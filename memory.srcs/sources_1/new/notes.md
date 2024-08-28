- we never need to write to main memory twice, how?
    - what if we need to evacuate both L1 and L2?
    - I had said that won't happen because of inclusive policy, if a value exists in L1, then it must also exist in L2, meaning that we would simply combine both values and write the combination to main
    - problem here is: when I miss in L1, I execute a read to extract the value to evacuate, then later when I also miss L2, I execute another read to extract the L2 value to evacuate, but what if I read from the wrong N? the N that doesn't match the one from L1? that is, I read from L1 a value, then I read a different value from L2, then I combine both, that is a problem
    - solution: I already put a mechanism to read the address along with the value, I should use that address when extracting the L2 value so it matches what we got from L1
    - is that what I am already doing? (forgot what I was doing!)
solved (I think)

-------------------
- [x] L1 not reading missing data from above
- [ ] test filling L2 to see how it evacuates
- [ ] main mem never getting written evacuated data from L2
- [ ] L1 getting wrong and jittery address at first of read phase of testbench
- [ ] L2 not getting hit even though data there
    - [ ] tag mem is written the wrong value for some reason
    - [ ] the address we read with data to evacuate is wrong
- [ ] contiguous data across different evacuations evacuated to wrong blocks in L2
    - because it is writing to the wrong N
    - we hit one N then read, the when we write we write to a different N, why is that?
    - it is getting the wrong hit N
- [x] after some repetitions, L1 seems to fetch the wrong data from above
- [x] use manual address must be set IN THE LOOKUP STAGE, not just in the write stage!, so the correct N is obtained
- [ ] wierd evacuation behavior: at a certain point, while the correct data does get evacuated, it seems to fetch data from main when it shouldn't and to the wrong N I think
    - happens when whole thing is full (L2)
    - new data is brought from main, written to L1, but is never written to L2, and data in L2 isn't evacuated to main even through it should, but in the next operation, that does happen, data read from main is indeed written to L2 and evicted data is written to main, but here is another problem: the data written to main is half correct, it writes the lower half correctly but the upper half is from a different block, the one that is being evacuated from L1 at the same time
    - [ ] don't know what to do when something is clean, seems like that breaks things, investigate, that might have been the problem
    - [x] when evac from L1 to L2, set L2 dirty
- [ ] problem with target N again
    - [x] finding clean N but probably the clean should not have been detected, investigate at 3092.02 us
        - actually this is the intended behavior, it found clean and overwrote that, makes plenty of sense and even the numbers continue naturally, the actual problem is that it didn't fetch the new data to L2 from main

- [ ] new data not fetched to L2, only written to L1, later gets written to L2
    - it appears something nasty is happening, as if data DOES get fetched but later gets overwritten with evacuated data, because I see the tag mem change twice in the same place, that shouldn't happen
    - theory: we fetch from main, then when we evacuate, we evacuate to the same location because it is clean, and the other location is dirty, and it seem we always prefer writing to clean rathe than evacate which is more costly, but that only works between DIFFERENT operations, not within the same operation, the place where we fetch new data must be different than the place we evacuate old data to
    - the whole evacuation process doesn't appear to be happening, I don't see the old data in o_read_data
    - why doesn't evacuation happen? check read state
    - indeed we aren't reading L2 at all
    - Now L2 is being read but still we are evacing and fetching to the same place
    - maybe when we get to write the evacuated data, that location should have already been clean? maybe when we read from that location it should then be set to invalid and clean?
    - L1 should NEVER need an evacuation becuse L1 is writing to it, beucase of inclusive, policy, if L1 evacuations always hit in L2. The only reason L2 might need an evac is if we are fetching data from main and there is a conflict and no clean
        - but shouldn't we account for the clean/dirty dichotomy? that is, if L1 needs an evac, that will make it's L2 equivalent dirty, and so if there wasn't a conflict already (because that evac target is clean) then now we will have a conflict

- [ ] to keep inclusivity, we must NEVER remove data from L2 that exists in L1, there is no mechanism for that right now!

# Potential Solutions:
- Cache Lock N
    - you set a specific N to be locked, so on lookup operations, we never choose that locked N
    - so that we lock N in L2 with data in L1 so inclusivity is maintained
    - that lock allows only writes only to the same address in that N, we can release that lock whenever we want using a read/write to that same locked address
    - this simply prevents choosing that N on lookups even if it is clean
- always evacuate from L1 to L2 before writing new data
    - the issue is that when we write new data first, we might write it to the N that contains address we would later evacuate to, because it happens to be clean, we don't want that
    - and so if we evacuate first, then the evacuation will set that N to dirty, so later when we write the new data we shouldn't write it there, because that would be dirty and the most recently written, so we should end up choosing the other way
    - but that requires that when we do the first lookup, that we lookup the evac address rather than the new address, but that requires knowing the evac address to begin with, that isn't possible right now because we only know the evac address once we've done a READ operation, but we need to know it at the lookup stage, which is before the read operation
        - and so we should do the already more sensible thing which is to get the conflicting address on lookup, not on read
- [x] inexplicably the other N get's set to fetched data from main while the current N has the data already!
        - the actual data from below gets evacuated to the correct place, but then this happens
        - hit didn't occur on L2 when it should have

## Action items:
- [x] in cache module: get conflicting address on lookup instead of on read
    - this shouldn't be a problem, when we read, we already read from target_N which is determined on Lookup, so we can simply on lookup set the address output to that conflicting N address, same thing we do right now with the read operation, but it genuinely makes more sense to do on lookup
- [x] if an evac is required, then lookup the evac address in the evac stage rather than the new address
    - but how would we know that evac is required before we even do a lookup!
- [x] if an evac is required, always do the evac first then write the new data
- [x] now in the second lookup we instead lookup the original address if we had previously looked up address from L1
---- repeat
- [x] reverse this: "if an evac is required, then lookup the evac address in the evac stage rather than the new address"
    - first lookups must always be to the current address, otherwise we mess up subsequent states, read and write transitions all depend on hit/miss states to the current address
- [x] "if an evac is required, always do the evac first then write the new data" add yet another lookup before this
- [x] now in the second lookup we instead lookup the original address if we had previously looked up address from L1
- [x] change what happens after evac to L2, what state to we go to from there? cache_hierarchy.v ln:656
- [x] look at all the transistions between states



- [x] test all these
- [x] new data block not written to L2, only to L1
    - after first fill, evac data written to L2 but not data from Main
- [x] 1,906.02 us when fetching missing data from L2 (hit) to L1 (miss) we fetch the wrong part of L2, we fetch the first part when we should have fetched the second part
- [x] restore lookup to original behavior
    - the new behavior is messing with the states, because they all assume that the last lookup had been to the current address
- [x] we are stuck

- L1 and L2 writing seems to be pretty solid, can't see any problems
--------
# Main writing
- [ ] main gets written the wrong data
    - [ ] wrong data evacuated to main, we seem to be evacuating the data we read from L1 instead of L2
- [ ] wrong data is being read, from wrong N
    - getting wrong N on first lookup, then after we write the evac data, we flip the use bit (which we shouldn't do) that's when we are in the correct N
    - [o] why does it get wrong N?
    - [ ] get correct N on first lookup
    - [ ] don't flip "use bit" when writing evac data, only when writing new data
        - right now when evacuating to main I mix data from L1 (if dirty) and data from L2 (if dirty), but I think now there is no situation in which that is necessary, we seem to always engage with different N, so we evacuate to one N (in L2) then writing the new data to a different N, we never simply wipeout data from both L1 and L2 in one go, that makes no sense, we should be get rid of data oldest to newest, data evacced from L1 must be newer than data in L2 but not in L1, all of this must be determined by the "use mem"
        - the first lookup will always return the wrong N because the last place evacuated to is going to be dirty whereas the other way is clean and clean always trumps "use mem" bit.
        - we desparately need a way to do manual N reads/writes


--------
# Later
    - [ ] revise all the "neededs" they are critically important
    - [ ] check on the main, it got very little attention
    - [ ] move on to validate reading


