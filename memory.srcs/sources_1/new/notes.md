- we never need to write to main memory twice, how?
    - what if we need to evacuate both L1 and L2?
    - I had said that won't happen because of inclusive policy, if a value exists in L1, then it must also exist in L2, meaning that we would simply combine both values and write the combination to main
    - problem here is: when I miss in L1, I execute a read to extract the value to evacuate, then later when I also miss L2, I execute another read to extract the L2 value to evacuate, but what if I read from the wrong N? the N that doesn't match the one from L1? that is, I read from L1 a value, then I read a different value from L2, then I combine both, that is a problem
    - solution: I already put a mechanism to read the address along with the value, I should use that address when extracting the L2 value so it matches what we got from L1
    - is that what I am already doing? (forgot what I was doing!)
solved (I think)

-------------------
- [ ] L1 not reading missing data from above
- [ ] L2 never getting filled
- [ ] L2 wierd behavior as we progress
- [ ] main mem never getting written evacuated data from L2
