---

excalidraw-plugin: parsed
tags: [excalidraw]

---
==⚠  Switch to EXCALIDRAW VIEW in the MORE OPTIONS menu of this document. ⚠==


# Text Elements
4 ^rL1xPemk

a ^NqHiq2rb

read operation 
address (h) (trickey) ^XBA8Jx78

a ^KAn93ncr

c ^xH2pa6ns

e ^A6ryhIwC

f ^M81cZBl1

g ^89jiOMrK

h ^I5XSbele

0 ^mUamcUxZ

a ^r3kBQnTh

b ^x2KgjIb8

c ^IMCgLqvb

d ^VzXGPBB3

e ^k7xOMnoz

f ^w54hbXjC

g ^JYDnh4Lq

h ^HvniLhnr

a ^vFHVFqRb

write operation 
to address (a) ^AGpR2yeZ

a ^Hrb4fGc4

b ^9pXXHWjh

c ^GTYC5fEt

d ^ela7Tk6o

e ^f3VU54GI

f ^EO1N4ejA

g ^70x5vPa3

h ^d7LEDTif

1 ^W2jHBcED

b ^6Yl31jmu

b ^cAkETkYF

a ^SBm4uKPn

read operation 
address (b) ^RfVurlXS

a ^YYk27tu1

b ^QKlZPCUS

c ^2ryjWt28

d ^27GAznXw

e ^Mde8uLXs

f ^E40Q3TmD

g ^GJt3lGpF

h ^yQVUGHKS

2 ^vMOTJwY4

b ^c7kYd4x1

b ^py2EbVwM

c ^76SuwVjb

c ^agRBj7LL

a ^npMBANyE

read operation 
address (c) ^2jh2U2NE

a ^53R0mWyQ

b ^TJ2rSb4E

c ^1WgL9fFK

d ^FkIGDY4k

e ^XtG3B73Q

f ^QTu4Vizf

g ^fizmXNaI

h ^KUvTA3oh

2 ^gVq02cMf

b ^HkPc4qTQ

b ^W5HFuD4i

c ^jaDJNyhc

c ^M93gtj21

d ^MTjJ6RRP

a ^KolQll1f

write operation 
address (d) ^VdgWngCj

a ^fmdg1zZu

b ^Z86A5THK

c ^VFMs5cjr

d ^ghR9oUyI

e ^pMzgVWQL

f ^dpSJ0t6t

g ^1XY9Ctal

h ^GhwmNIlo

3 ^KV4QRbjT

b ^k4VwlHDD

c ^qFKxXCq6

c ^TyGTqjLu

d ^t1CGJooM

h ^0EbYQ1KD

h ^PhKBsQ8K

procedure:
(arrows are numbered in order of operations)
- first (h) is to be fetched to the lowest
level cache
- but there we find value (d) is stored and dirty
so (d) needs to be evacuated (1)
- (d) is evacuated back 1 level
- (h) is fetched to lowest cache (2)
- now for inclusivity's sake, (h) needs to be fetched
to 2nd level cache, but (d) was previously evacuated 
there
- (d) is evacuated yet again back to 3rd level cache (3)
- (h) is written in it's place into 2nd level cache (4)

conclusion:
when reading, always write to lowest level first, then
climb up to upper levels, evacuating as you go ^t4mJEM31

2 ^nl8USqVf

4 ^RX4uiHcK

1 ^fWyb8tR7

3 ^6Unj4FJU

1 ^E1UmTSwI

2 ^vKyeTtZV

1 ^fqw6eYfF

2 ^CWCVEqhn

3 ^oCevVU1c

1 ^UL9iklJc

2 ^L9HdyayP

read h op i ^9MyekHQZ

cache 0
read h op i ^YPH2mVea

order of operations:
- system read operation address h
- read request L0 address h
- miss!
- read request L1 address h
- miss!
- read request L3 address h
- hit!

- write request to L0 address h
- evacuation required
- L0 write request to L1 (evacuation)
- L1 write done signal
- L0 write done signal

- write request to L1 address h
- evacuation required
- L1 write request to L3 (evacuation)
- L3 write done signal
- L1 write done signal

as you can see we initiate a request which leads to
another etc., then they get executed from end to
beginning, until initial request is fulfilled ^98ib66OT

%%
# Drawing
```json
{
	"type": "excalidraw",
	"version": 2,
	"source": "https://github.com/zsviczian/obsidian-excalidraw-plugin/releases/tag/2.1.3",
	"elements": [
		{
			"type": "rectangle",
			"version": 231,
			"versionNonce": 1737870689,
			"isDeleted": false,
			"id": "JBfgv1PZskqu6doxvZ4eo",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1097.2024389227668,
			"y": -589.4349472186175,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 101.1608273043898,
			"height": 473.6684207040644,
			"seed": 547531329,
			"groupIds": [
				"EUlnYIQO_tlRb47NDp5MV"
			],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [],
			"updated": 1714386616828,
			"link": null,
			"locked": false
		},
		{
			"type": "line",
			"version": 250,
			"versionNonce": 1602286895,
			"isDeleted": false,
			"id": "hGYQrdi4OwXg0x1CIr6MD",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -986.3028459015053,
			"y": -532.132515233305,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 1312143905,
			"groupIds": [
				"EUlnYIQO_tlRb47NDp5MV"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616828,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 276,
			"versionNonce": 219642177,
			"isDeleted": false,
			"id": "Qy3NURMCGLvLWvCTrLyS0",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -986.3028459015053,
			"y": -473.39775197295467,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 446418433,
			"groupIds": [
				"EUlnYIQO_tlRb47NDp5MV"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616828,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 280,
			"versionNonce": 220755791,
			"isDeleted": false,
			"id": "rHnuoW3Mw6WUcrOS8aAOP",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -986.3028459015053,
			"y": -412.05259572841123,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 1020552673,
			"groupIds": [
				"EUlnYIQO_tlRb47NDp5MV"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616828,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 306,
			"versionNonce": 288925985,
			"isDeleted": false,
			"id": "MOshy9kp_YWRfzBQ8j_P3",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -986.3028459015053,
			"y": -353.31783246806094,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 1609499073,
			"groupIds": [
				"EUlnYIQO_tlRb47NDp5MV"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616828,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 299,
			"versionNonce": 987411823,
			"isDeleted": false,
			"id": "WHTXThI5qrAxeB6xoiC1O",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -986.3028459015053,
			"y": -293.2779225056686,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 554377633,
			"groupIds": [
				"EUlnYIQO_tlRb47NDp5MV"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616828,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 325,
			"versionNonce": 2104024321,
			"isDeleted": false,
			"id": "ewop6nb48VnNFIFRwsl0r",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -986.3028459015053,
			"y": -234.54315924531807,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 1297630593,
			"groupIds": [
				"EUlnYIQO_tlRb47NDp5MV"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616828,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 329,
			"versionNonce": 266350479,
			"isDeleted": false,
			"id": "OmOGBe2-iFShSaL-LpvQO",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -986.3028459015053,
			"y": -173.19800300077463,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 1612049761,
			"groupIds": [
				"EUlnYIQO_tlRb47NDp5MV"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616828,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "rectangle",
			"version": 437,
			"versionNonce": 19371233,
			"isDeleted": false,
			"id": "q22BSfP-yyfc4viPpaLnZ",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -697.8770962205327,
			"y": -511.23519840113545,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 66.88541640049824,
			"height": 308.63805989636126,
			"seed": 1083414849,
			"groupIds": [
				"EUlnYIQO_tlRb47NDp5MV"
			],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [],
			"updated": 1714386616828,
			"link": null,
			"locked": false
		},
		{
			"type": "line",
			"version": 459,
			"versionNonce": 913401263,
			"isDeleted": false,
			"id": "9yVX0Bj9n-Ob_1elCmBE0",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -628.0901854012715,
			"y": -430.6581881530517,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 75.33717800129428,
			"height": 0,
			"seed": 1076939041,
			"groupIds": [
				"EUlnYIQO_tlRb47NDp5MV"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616828,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-75.33717800129428,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 502,
			"versionNonce": 805589185,
			"isDeleted": false,
			"id": "NNiHv6pASlzvic7A1NSZ6",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -628.0901854012715,
			"y": -360.3538967707375,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 75.33717800129428,
			"height": 0,
			"seed": 1482489089,
			"groupIds": [
				"EUlnYIQO_tlRb47NDp5MV"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616828,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-75.33717800129428,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 494,
			"versionNonce": 2109134799,
			"isDeleted": false,
			"id": "uFKbrXPceAZVKGRlern3m",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -627.1364718101119,
			"y": -274.58844932820625,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 75.33717800129428,
			"height": 0,
			"seed": 681030881,
			"groupIds": [
				"EUlnYIQO_tlRb47NDp5MV"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616828,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-75.33717800129428,
					0
				]
			]
		},
		{
			"type": "rectangle",
			"version": 557,
			"versionNonce": 2141098145,
			"isDeleted": false,
			"id": "dSzFoxWq_IW2Hecwv8bUO",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -328.81249146249377,
			"y": -427.31356820641827,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 66.88541640049824,
			"height": 137.9337314915794,
			"seed": 879784129,
			"groupIds": [
				"EUlnYIQO_tlRb47NDp5MV"
			],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [],
			"updated": 1714386616828,
			"link": null,
			"locked": false
		},
		{
			"type": "line",
			"version": 535,
			"versionNonce": 1003029999,
			"isDeleted": false,
			"id": "c3GkvDtYDbAtB-2d_YC56",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -258.07193981020475,
			"y": -357.49293789258695,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 75.33717800129428,
			"height": 0,
			"seed": 1636216993,
			"groupIds": [
				"EUlnYIQO_tlRb47NDp5MV"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616828,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-75.33717800129428,
					0
				]
			]
		},
		{
			"type": "arrow",
			"version": 174,
			"versionNonce": 94753921,
			"isDeleted": false,
			"id": "wb-y5kU3JXAbAYjYgW8kG",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": -1044.7416806821548,
			"y": -558.9650125690721,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 377.64755415062143,
			"height": 91.55093875427153,
			"seed": 898233473,
			"groupIds": [
				"EUlnYIQO_tlRb47NDp5MV"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616828,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					377.64755415062143,
					91.55093875427153
				]
			]
		},
		{
			"type": "arrow",
			"version": 216,
			"versionNonce": 1873833999,
			"isDeleted": false,
			"id": "CEmgi35opJOYTIGpeqn8F",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": -1036.1587312895722,
			"y": -496.97741256652967,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 371.9256000152549,
			"height": 101.08749260081649,
			"seed": 1413069921,
			"groupIds": [
				"EUlnYIQO_tlRb47NDp5MV"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616828,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					371.9256000152549,
					101.08749260081649
				]
			]
		},
		{
			"type": "arrow",
			"version": 288,
			"versionNonce": 1977195617,
			"isDeleted": false,
			"id": "nzdtlx8WV-XAZwaMPvmit",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": -1043.7880398491266,
			"y": -436.8971306091091,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 382.41583107389397,
			"height": 122.06791833902864,
			"seed": 1030064193,
			"groupIds": [
				"EUlnYIQO_tlRb47NDp5MV"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616828,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					382.41583107389397,
					122.06791833902864
				]
			]
		},
		{
			"type": "arrow",
			"version": 347,
			"versionNonce": 593860143,
			"isDeleted": false,
			"id": "K8W47EBC3wGGrL0L7iqI5",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": -1047.6026395603053,
			"y": -376.81684865168904,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 384.3231491190162,
			"height": 136.37274910884614,
			"seed": 1257035809,
			"groupIds": [
				"EUlnYIQO_tlRb47NDp5MV"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616828,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					384.3231491190162,
					136.37274910884614
				]
			]
		},
		{
			"type": "arrow",
			"version": 170,
			"versionNonce": 1611229249,
			"isDeleted": false,
			"id": "zW3PENPemZ4qOzURNtWsP",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": -1047.6026395603053,
			"y": -317.6901711482308,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 379.55487219574377,
			"height": 147.81658462144748,
			"seed": 1858022401,
			"groupIds": [
				"EUlnYIQO_tlRb47NDp5MV"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616828,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					379.55487219574377,
					-147.81658462144748
				]
			]
		},
		{
			"type": "arrow",
			"version": 141,
			"versionNonce": 231798863,
			"isDeleted": false,
			"id": "KNQmuRcXIHwz8P_CWWpIn",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": -1049.5099576054276,
			"y": -260.4708844480267,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 385.27675357297846,
			"height": 134.46539468465812,
			"seed": 819725281,
			"groupIds": [
				"EUlnYIQO_tlRb47NDp5MV"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616828,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					385.27675357297846,
					-134.46539468465812
				]
			]
		},
		{
			"type": "arrow",
			"version": 141,
			"versionNonce": 773109793,
			"isDeleted": false,
			"id": "9n74M3GZ57QHp_e_nfncI",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": -1049.5099576054276,
			"y": -205.15884303481312,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 389.0913896632228,
			"height": 103.94845147896683,
			"seed": 1834147777,
			"groupIds": [
				"EUlnYIQO_tlRb47NDp5MV"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616828,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					389.0913896632228,
					-103.94845147896683
				]
			]
		},
		{
			"type": "arrow",
			"version": 135,
			"versionNonce": 1959466607,
			"isDeleted": false,
			"id": "WtLjpJrIe0PwGAofwRSSP",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": -1048.5563167723994,
			"y": -141.2639613662143,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 385.2768263311102,
			"height": 93.45818404126192,
			"seed": 1380138913,
			"groupIds": [
				"EUlnYIQO_tlRb47NDp5MV"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616828,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					385.2768263311102,
					-93.45818404126192
				]
			]
		},
		{
			"type": "arrow",
			"version": 165,
			"versionNonce": 1642793985,
			"isDeleted": false,
			"id": "bNFLPU3xOoqYpXk3_4ms3",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": -645.160096339359,
			"y": -469.32139185992287,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 332.82574379604705,
			"height": 77.24610798445406,
			"seed": 500999041,
			"groupIds": [
				"EUlnYIQO_tlRb47NDp5MV"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616828,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					332.82574379604705,
					77.24610798445406
				]
			]
		},
		{
			"type": "arrow",
			"version": 185,
			"versionNonce": 1327263887,
			"isDeleted": false,
			"id": "rQ-DM85TXE7MYmnvE_nFs",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": -643.252741915171,
			"y": -393.0289247084968,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 322.33540360021016,
			"height": 69.61679942489945,
			"seed": 475958113,
			"groupIds": [
				"EUlnYIQO_tlRb47NDp5MV"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616828,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					322.33540360021016,
					69.61679942489945
				]
			]
		},
		{
			"type": "arrow",
			"version": 171,
			"versionNonce": 327934945,
			"isDeleted": false,
			"id": "5joYViHm_dR7E1cYghyWF",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": -636.5771833258424,
			"y": -310.06093534680826,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 323.2891171913701,
			"height": 72.47783106118152,
			"seed": 1712879425,
			"groupIds": [
				"EUlnYIQO_tlRb47NDp5MV"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616829,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					323.2891171913701,
					-72.47783106118152
				]
			]
		},
		{
			"type": "arrow",
			"version": 186,
			"versionNonce": 645760687,
			"isDeleted": false,
			"id": "i5ys495r9KrW3iq84_MdD",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": -635.6235424928142,
			"y": -232.8148637414199,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 314.70634969411674,
			"height": 79.1533896505104,
			"seed": 1567221537,
			"groupIds": [
				"EUlnYIQO_tlRb47NDp5MV"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616829,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					314.70634969411674,
					-79.1533896505104
				]
			]
		},
		{
			"type": "rectangle",
			"version": 307,
			"versionNonce": 788971457,
			"isDeleted": false,
			"id": "iqR-VF1IwV28hk12s8TYk",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 306.2934367687743,
			"y": -593.9623708184793,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 101.1608273043898,
			"height": 473.6684207040644,
			"seed": 1238270639,
			"groupIds": [
				"p6O8Ce6NdopwBykRKa1FX"
			],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [],
			"updated": 1714386616829,
			"link": null,
			"locked": false
		},
		{
			"type": "line",
			"version": 326,
			"versionNonce": 966187215,
			"isDeleted": false,
			"id": "bJiYUf_pQa-ICLWvdPnMw",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 417.1930297900359,
			"y": -536.659938833167,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 1097356495,
			"groupIds": [
				"p6O8Ce6NdopwBykRKa1FX"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616829,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 352,
			"versionNonce": 1920671649,
			"isDeleted": false,
			"id": "lq53pz7Hj045rXPdmo7w-",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 417.1930297900359,
			"y": -477.92517557281644,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 1715659503,
			"groupIds": [
				"p6O8Ce6NdopwBykRKa1FX"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616829,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 356,
			"versionNonce": 1577117423,
			"isDeleted": false,
			"id": "eMrJ8mXlsdpQXQr3bQ9j3",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 417.1930297900359,
			"y": -416.58001932827324,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 1223077135,
			"groupIds": [
				"p6O8Ce6NdopwBykRKa1FX"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616829,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 382,
			"versionNonce": 739804033,
			"isDeleted": false,
			"id": "H0R_wo97Vl1tFkGnZqp8M",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 417.1930297900359,
			"y": -357.8452560679227,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 1422668591,
			"groupIds": [
				"p6O8Ce6NdopwBykRKa1FX"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616829,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 375,
			"versionNonce": 574894351,
			"isDeleted": false,
			"id": "W37b6DiNGhtzW3Sh1g8fg",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 417.1930297900359,
			"y": -297.80534610553036,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 1918629199,
			"groupIds": [
				"p6O8Ce6NdopwBykRKa1FX"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616829,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 401,
			"versionNonce": 941517665,
			"isDeleted": false,
			"id": "oLkFMRyVkId6BxQbq_zes",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 417.1930297900359,
			"y": -239.07058284517984,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 1760457583,
			"groupIds": [
				"p6O8Ce6NdopwBykRKa1FX"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616829,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 405,
			"versionNonce": 802764591,
			"isDeleted": false,
			"id": "bK4qlaer4qBcxr0sIW58J",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 417.1930297900359,
			"y": -177.7254266006364,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 13381007,
			"groupIds": [
				"p6O8Ce6NdopwBykRKa1FX"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616829,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "rectangle",
			"version": 513,
			"versionNonce": 1054627649,
			"isDeleted": false,
			"id": "aM8hdLIbvxZO7GaeR4oxC",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 705.6187794710086,
			"y": -515.7626220009972,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 66.88541640049824,
			"height": 308.63805989636126,
			"seed": 1697489839,
			"groupIds": [
				"p6O8Ce6NdopwBykRKa1FX"
			],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [],
			"updated": 1714386616829,
			"link": null,
			"locked": false
		},
		{
			"type": "line",
			"version": 535,
			"versionNonce": 1831369039,
			"isDeleted": false,
			"id": "U-bDaXg4XEXdiKfFC0EFB",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 775.4056902902697,
			"y": -435.1856117529137,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 75.33717800129428,
			"height": 0,
			"seed": 1178293711,
			"groupIds": [
				"p6O8Ce6NdopwBykRKa1FX"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616829,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-75.33717800129428,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 578,
			"versionNonce": 850511649,
			"isDeleted": false,
			"id": "A_IznJVPeq92hYj9N6kLl",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 775.4056902902697,
			"y": -364.88132037059927,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 75.33717800129428,
			"height": 0,
			"seed": 990757871,
			"groupIds": [
				"p6O8Ce6NdopwBykRKa1FX"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616829,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-75.33717800129428,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 570,
			"versionNonce": 1602910063,
			"isDeleted": false,
			"id": "wvLqGBRKZL1YIbxvUCrzF",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 776.3594038814293,
			"y": -279.11587292806803,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 75.33717800129428,
			"height": 0,
			"seed": 1672310287,
			"groupIds": [
				"p6O8Ce6NdopwBykRKa1FX"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616829,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-75.33717800129428,
					0
				]
			]
		},
		{
			"type": "rectangle",
			"version": 633,
			"versionNonce": 235813633,
			"isDeleted": false,
			"id": "DiO6-MBQH2i0joU6lOxQm",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1074.6833842290475,
			"y": -431.8409918062803,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 66.88541640049824,
			"height": 137.9337314915794,
			"seed": 1259525167,
			"groupIds": [
				"p6O8Ce6NdopwBykRKa1FX"
			],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [],
			"updated": 1714386616829,
			"link": null,
			"locked": false
		},
		{
			"type": "line",
			"version": 611,
			"versionNonce": 1296544143,
			"isDeleted": false,
			"id": "u8lnkjpOHuoB9aO-FBoD7",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1145.4239358813365,
			"y": -362.0203614924487,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 75.33717800129428,
			"height": 0,
			"seed": 153515599,
			"groupIds": [
				"p6O8Ce6NdopwBykRKa1FX"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616829,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-75.33717800129428,
					0
				]
			]
		},
		{
			"type": "arrow",
			"version": 250,
			"versionNonce": 1366373089,
			"isDeleted": false,
			"id": "AYUkuWf0C0_8ayjigRDE8",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 358.7541950093862,
			"y": -563.4924361689341,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 377.64755415062143,
			"height": 91.55093875427153,
			"seed": 616617071,
			"groupIds": [
				"p6O8Ce6NdopwBykRKa1FX"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616829,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					377.64755415062143,
					91.55093875427153
				]
			]
		},
		{
			"type": "arrow",
			"version": 295,
			"versionNonce": 530098095,
			"isDeleted": false,
			"id": "CKirWv10AU6LVfs-hNHBw",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 367.337144401969,
			"y": -501.50483616639144,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 371.9256000152549,
			"height": 101.08749260081649,
			"seed": 900361871,
			"groupIds": [
				"p6O8Ce6NdopwBykRKa1FX"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616829,
			"link": null,
			"locked": false,
			"startBinding": {
				"focus": -0.14862558574215268,
				"gap": 1.9638168918772863,
				"elementId": "9pXXHWjh"
			},
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					371.9256000152549,
					101.08749260081649
				]
			]
		},
		{
			"type": "arrow",
			"version": 364,
			"versionNonce": 1097477825,
			"isDeleted": false,
			"id": "Ih3Zd_cdkWPaC5JrWeztv",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 359.7078358424144,
			"y": -441.42455420897113,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 382.41583107389397,
			"height": 122.06791833902864,
			"seed": 1184613551,
			"groupIds": [
				"p6O8Ce6NdopwBykRKa1FX"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616829,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					382.41583107389397,
					122.06791833902864
				]
			]
		},
		{
			"type": "arrow",
			"version": 423,
			"versionNonce": 77978063,
			"isDeleted": false,
			"id": "r7nUBLlg0Oo9xT-chW1Jg",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 355.8932361312359,
			"y": -381.3442722515508,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 384.3231491190162,
			"height": 136.37274910884614,
			"seed": 2000508623,
			"groupIds": [
				"p6O8Ce6NdopwBykRKa1FX"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616829,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					384.3231491190162,
					136.37274910884614
				]
			]
		},
		{
			"type": "arrow",
			"version": 246,
			"versionNonce": 1687727777,
			"isDeleted": false,
			"id": "u093hxjmKzgV8tQmTeCI1",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 355.89323613123577,
			"y": -322.217594748093,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 379.55487219574377,
			"height": 147.81658462144748,
			"seed": 1579656431,
			"groupIds": [
				"p6O8Ce6NdopwBykRKa1FX"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616829,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					379.55487219574377,
					-147.81658462144748
				]
			]
		},
		{
			"type": "arrow",
			"version": 217,
			"versionNonce": 1367853039,
			"isDeleted": false,
			"id": "6kuEJgJcZdPaKAeXib2di",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 353.98591808611366,
			"y": -264.99830804788894,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 385.27675357297846,
			"height": 134.46539468465812,
			"seed": 719531791,
			"groupIds": [
				"p6O8Ce6NdopwBykRKa1FX"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616829,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					385.27675357297846,
					-134.46539468465812
				]
			]
		},
		{
			"type": "arrow",
			"version": 217,
			"versionNonce": 1101804161,
			"isDeleted": false,
			"id": "v8R8pIB42j45XB3CyHQEY",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 353.98591808611366,
			"y": -209.6862666346749,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 389.0913896632228,
			"height": 103.94845147896683,
			"seed": 132674863,
			"groupIds": [
				"p6O8Ce6NdopwBykRKa1FX"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616829,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					389.0913896632228,
					-103.94845147896683
				]
			]
		},
		{
			"type": "arrow",
			"version": 211,
			"versionNonce": 608629263,
			"isDeleted": false,
			"id": "om-7TMbtHucSXA68innw3",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 354.93955891914186,
			"y": -145.79138496607607,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 385.2768263311102,
			"height": 93.45818404126192,
			"seed": 1017116495,
			"groupIds": [
				"p6O8Ce6NdopwBykRKa1FX"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616829,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					385.2768263311102,
					-93.45818404126192
				]
			]
		},
		{
			"type": "arrow",
			"version": 248,
			"versionNonce": 1566849633,
			"isDeleted": false,
			"id": "TB_AaCZ3JV42oa2l64CCB",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 755.4267328322959,
			"y": -473.8855498546952,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 335.7347903159332,
			"height": 77.31194671885714,
			"seed": 258094447,
			"groupIds": [
				"p6O8Ce6NdopwBykRKa1FX"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616829,
			"link": null,
			"locked": false,
			"startBinding": {
				"focus": -0.014277704017785497,
				"gap": 3.2612986634078425,
				"elementId": "Ua6nCPk0"
			},
			"endBinding": {
				"focus": -0.16550420866796872,
				"gap": 2.585838233460663,
				"elementId": "vFHVFqRb"
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					335.7347903159332,
					77.31194671885714
				]
			]
		},
		{
			"type": "arrow",
			"version": 259,
			"versionNonce": 1172035631,
			"isDeleted": false,
			"id": "UOaCYTR79mmDdeciOrvFB",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 760.2431337763702,
			"y": -397.5563483083588,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 322.33540360021016,
			"height": 69.61679942489945,
			"seed": 1735896975,
			"groupIds": [
				"p6O8Ce6NdopwBykRKa1FX"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616829,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					322.33540360021016,
					69.61679942489945
				]
			]
		},
		{
			"type": "arrow",
			"version": 249,
			"versionNonce": 2022721089,
			"isDeleted": false,
			"id": "u6JQhsdGq04lx1YEbmRdP",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 766.9186923656988,
			"y": -314.58835894667004,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 321.83470490443824,
			"height": 72.456338351348,
			"seed": 790160815,
			"groupIds": [
				"p6O8Ce6NdopwBykRKa1FX"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616830,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": {
				"focus": -0.18944012333788257,
				"gap": 3.5395518246207303,
				"elementId": "vFHVFqRb"
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					321.83470490443824,
					-72.456338351348
				]
			]
		},
		{
			"type": "arrow",
			"version": 260,
			"versionNonce": 1278147151,
			"isDeleted": false,
			"id": "eIjKJl1fi9wbG_c5HBdNz",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 767.872333198727,
			"y": -237.3422873412817,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 314.70634969411674,
			"height": 79.1533896505104,
			"seed": 1970165711,
			"groupIds": [
				"p6O8Ce6NdopwBykRKa1FX"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616830,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					314.70634969411674,
					-79.1533896505104
				]
			]
		},
		{
			"type": "text",
			"version": 154,
			"versionNonce": 832565815,
			"isDeleted": false,
			"id": "mUamcUxZ",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -925.333840277509,
			"y": 94.45300107247226,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 190.87872314453125,
			"height": 346.808897217726,
			"seed": 265407215,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923220,
			"link": null,
			"locked": false,
			"fontSize": 277.4471177741808,
			"fontFamily": 1,
			"text": "0",
			"rawText": "0",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "0",
			"lineHeight": 1.25
		},
		{
			"type": "text",
			"version": 192,
			"versionNonce": 775467193,
			"isDeleted": false,
			"id": "vFHVFqRb",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1093.7473613816896,
			"y": -428.0891923797758,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 32.23609924316406,
			"height": 60.417411654673245,
			"seed": 1351648751,
			"groupIds": [
				"6Zwr6El_sGSgQVYZuxA3_"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923220,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "a",
			"rawText": "a",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "a",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 215,
			"versionNonce": 282225153,
			"isDeleted": false,
			"id": "tEzQs_KRFjZq3jFLeHUWh",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1082.1235263251137,
			"y": -423.3339394894283,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 2139615247,
			"groupIds": [
				"6Zwr6El_sGSgQVYZuxA3_"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [
				{
					"id": "7TWBe_UiNYkRsQSNM22EM",
					"type": "arrow"
				}
			],
			"updated": 1714386616830,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 94,
			"versionNonce": 1936888663,
			"isDeleted": false,
			"id": "AGpR2yeZ",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 532.7156393892914,
			"y": 43.54713241603463,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 283.1759033203125,
			"height": 90,
			"seed": 1280120367,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923220,
			"link": null,
			"locked": false,
			"fontSize": 36,
			"fontFamily": 1,
			"text": "write operation \nto address (a)",
			"rawText": "write operation \nto address (a)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "write operation \nto address (a)",
			"lineHeight": 1.25
		},
		{
			"type": "text",
			"version": 500,
			"versionNonce": 557068697,
			"isDeleted": false,
			"id": "r3kBQnTh",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1066.680492195189,
			"y": -594.4041689945409,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 32.23609924316406,
			"height": 60.417411654673245,
			"seed": 1701727809,
			"groupIds": [
				"AMbDsotu3r3ENDUZj9Tez"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923221,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "a",
			"rawText": "a",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "a",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 522,
			"versionNonce": 1656932527,
			"isDeleted": false,
			"id": "SQjHlS8M2GvgnPa0hwaDS",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1078.3043272517652,
			"y": -589.6489161041934,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 1106042401,
			"groupIds": [
				"AMbDsotu3r3ENDUZj9Tez"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616830,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 696,
			"versionNonce": 1620316279,
			"isDeleted": false,
			"id": "x2KgjIb8",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1060.5116720830083,
			"y": -530.5981259165251,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 24.5516357421875,
			"height": 60.417411654673245,
			"seed": 1406038529,
			"groupIds": [
				"b3Y_JRuZPzN0nwz3q7zDx"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923221,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "b",
			"rawText": "b",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "b",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 705,
			"versionNonce": 2145639119,
			"isDeleted": false,
			"id": "YP1iwhz0H4pfzgpg6ZbnJ",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1077.0586967429508,
			"y": -531.9967191800238,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 1214945,
			"groupIds": [
				"b3Y_JRuZPzN0nwz3q7zDx"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616830,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 731,
			"versionNonce": 785159801,
			"isDeleted": false,
			"id": "IMCgLqvb",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1060.5116720830083,
			"y": -472.4162522482013,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 24.26165771484375,
			"height": 60.417411654673245,
			"seed": 1606985153,
			"groupIds": [
				"BJWaA9d1TsEcOSf6IswD4"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923221,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "c",
			"rawText": "c",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "c",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 739,
			"versionNonce": 392014063,
			"isDeleted": false,
			"id": "i6cD9y8uzVHkRgnUTpJqe",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1077.0586967429508,
			"y": -473.8148455117,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 1041253793,
			"groupIds": [
				"BJWaA9d1TsEcOSf6IswD4"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616830,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 753,
			"versionNonce": 1657334167,
			"isDeleted": false,
			"id": "VzXGPBB3",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1060.5116720830083,
			"y": -414.23443406638285,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 27.499771118164062,
			"height": 60.417411654673245,
			"seed": 1444473217,
			"groupIds": [
				"12vSSfXoL9xF0g0u2ttvE"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923221,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "d",
			"rawText": "d",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "d",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 760,
			"versionNonce": 1454945039,
			"isDeleted": false,
			"id": "Xf62skGSghKg41Qt-TkQH",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1077.0586967429508,
			"y": -415.63302732988154,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 1361187169,
			"groupIds": [
				"12vSSfXoL9xF0g0u2ttvE"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616830,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 783,
			"versionNonce": 969236313,
			"isDeleted": false,
			"id": "k7xOMnoz",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1060.5116720830083,
			"y": -353.1435138781728,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 26.436508178710938,
			"height": 60.417411654673245,
			"seed": 75185473,
			"groupIds": [
				"PCqDbWMRw_CEgg8n1PKPz"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923221,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "e",
			"rawText": "e",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "e",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 790,
			"versionNonce": 644708655,
			"isDeleted": false,
			"id": "F7kC85Wy3kFl9HGGduAia",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1077.0586967429508,
			"y": -354.5421071416715,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 1870916897,
			"groupIds": [
				"PCqDbWMRw_CEgg8n1PKPz"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616830,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 814,
			"versionNonce": 927309495,
			"isDeleted": false,
			"id": "w54hbXjC",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1060.5116720830083,
			"y": -296.41627444280334,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 23.488372802734375,
			"height": 60.417411654673245,
			"seed": 2041291009,
			"groupIds": [
				"ljyDi1F1aRvsXLfn2qaeB"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923221,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "f",
			"rawText": "f",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "f",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 821,
			"versionNonce": 1273264975,
			"isDeleted": false,
			"id": "jU2XMxBwww_x20WVjeNgJ",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1077.0586967429508,
			"y": -297.81486770630204,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 1886509281,
			"groupIds": [
				"ljyDi1F1aRvsXLfn2qaeB"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616830,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 841,
			"versionNonce": 7474233,
			"isDeleted": false,
			"id": "JYDnh4Lq",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1060.5116720830083,
			"y": -233.87083099464985,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 24.21331787109375,
			"height": 60.417411654673245,
			"seed": 1164317889,
			"groupIds": [
				"22rO5WmtbMpgrjbkjyznS"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923221,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "g",
			"rawText": "g",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "g",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 848,
			"versionNonce": 1266039151,
			"isDeleted": false,
			"id": "EVgWPJB4zXNE8VXsEe6C6",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1077.0586967429508,
			"y": -235.26942425814855,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 203936929,
			"groupIds": [
				"22rO5WmtbMpgrjbkjyznS"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 877,
			"versionNonce": 11448279,
			"isDeleted": false,
			"id": "HvniLhnr",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1060.5116720830083,
			"y": -172.77996629294535,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 23.875015258789062,
			"height": 60.417411654673245,
			"seed": 946247809,
			"groupIds": [
				"tbwoxqHi9RAv6W6SwxOhQ"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923221,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "h",
			"rawText": "h",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "h",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 884,
			"versionNonce": 174797711,
			"isDeleted": false,
			"id": "k-eSQoU4qnMGAdGSJoUs6",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": -1077.0586967429508,
			"y": -174.17855955644404,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 467787873,
			"groupIds": [
				"tbwoxqHi9RAv6W6SwxOhQ"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 617,
			"versionNonce": 716578073,
			"isDeleted": false,
			"id": "Hrb4fGc4",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 334.65287165572363,
			"y": -594.4041689945409,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 32.23609924316406,
			"height": 60.417411654673245,
			"seed": 768112719,
			"groupIds": [
				"fPPqReiPE2IWmnuc0SgEI"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923221,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "a",
			"rawText": "a",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "a",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 639,
			"versionNonce": 821815727,
			"isDeleted": false,
			"id": "oVjOBA4PHKtle2vVz7gJB",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 323.0290365991473,
			"y": -589.6489161041934,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 701666927,
			"groupIds": [
				"fPPqReiPE2IWmnuc0SgEI"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 814,
			"versionNonce": 421043447,
			"isDeleted": false,
			"id": "9pXXHWjh",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 340.8216917679042,
			"y": -530.5981259165251,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 24.5516357421875,
			"height": 60.417411654673245,
			"seed": 1999892623,
			"groupIds": [
				"PMFnDvIfhjpHNVDKoqhYL"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923221,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "b",
			"rawText": "b",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "b",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 822,
			"versionNonce": 1280367567,
			"isDeleted": false,
			"id": "Ctd0ahaUpaunnpQjeQUWz",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 324.2746671079617,
			"y": -531.9967191800238,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 1604650671,
			"groupIds": [
				"PMFnDvIfhjpHNVDKoqhYL"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 848,
			"versionNonce": 402985465,
			"isDeleted": false,
			"id": "GTYC5fEt",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 340.8216917679042,
			"y": -472.4162522482013,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 24.26165771484375,
			"height": 60.417411654673245,
			"seed": 1640913103,
			"groupIds": [
				"YoYfR3m54k62GZdKTLops"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923221,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "c",
			"rawText": "c",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "c",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 856,
			"versionNonce": 813861359,
			"isDeleted": false,
			"id": "S37PVlsoLsmpTiHVXfAOz",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 324.2746671079617,
			"y": -473.8148455117,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 323512047,
			"groupIds": [
				"YoYfR3m54k62GZdKTLops"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 870,
			"versionNonce": 604497431,
			"isDeleted": false,
			"id": "ela7Tk6o",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 340.8216917679042,
			"y": -414.23443406638285,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 27.499771118164062,
			"height": 60.417411654673245,
			"seed": 1117499663,
			"groupIds": [
				"DeIuEGBymV46ipyNwpIQz"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923221,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "d",
			"rawText": "d",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "d",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 877,
			"versionNonce": 446264335,
			"isDeleted": false,
			"id": "YasuvUd7t8COAU17UuJY2",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 324.2746671079617,
			"y": -415.63302732988154,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 1497413423,
			"groupIds": [
				"DeIuEGBymV46ipyNwpIQz"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 900,
			"versionNonce": 1835166425,
			"isDeleted": false,
			"id": "f3VU54GI",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 340.8216917679042,
			"y": -353.1435138781728,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 26.436508178710938,
			"height": 60.417411654673245,
			"seed": 2107636047,
			"groupIds": [
				"ttYKG3k7NVecNQgFKFfha"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923221,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "e",
			"rawText": "e",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "e",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 907,
			"versionNonce": 311302703,
			"isDeleted": false,
			"id": "UFPFvFq2njINpc4GcOMdO",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 324.2746671079617,
			"y": -354.5421071416715,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 1964111727,
			"groupIds": [
				"ttYKG3k7NVecNQgFKFfha"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 931,
			"versionNonce": 1618021175,
			"isDeleted": false,
			"id": "EO1N4ejA",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 340.8216917679042,
			"y": -296.41627444280334,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 23.488372802734375,
			"height": 60.417411654673245,
			"seed": 1172255119,
			"groupIds": [
				"mtZhKBjERTxf6vGy1Bvcw"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923221,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "f",
			"rawText": "f",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "f",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 938,
			"versionNonce": 222886991,
			"isDeleted": false,
			"id": "sHZUL5bv4NNB28esfWtFw",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 324.2746671079617,
			"y": -297.81486770630204,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 423634863,
			"groupIds": [
				"mtZhKBjERTxf6vGy1Bvcw"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 958,
			"versionNonce": 1667344313,
			"isDeleted": false,
			"id": "70x5vPa3",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 340.8216917679042,
			"y": -233.87083099464985,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 24.21331787109375,
			"height": 60.417411654673245,
			"seed": 1566398927,
			"groupIds": [
				"GLerYxZDMJ05IwVAqzrMy"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923221,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "g",
			"rawText": "g",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "g",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 965,
			"versionNonce": 1319279215,
			"isDeleted": false,
			"id": "m8dRICGB6pg45fx9GX8eN",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 324.2746671079617,
			"y": -235.26942425814855,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 659507183,
			"groupIds": [
				"GLerYxZDMJ05IwVAqzrMy"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 994,
			"versionNonce": 985173079,
			"isDeleted": false,
			"id": "d7LEDTif",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 340.8216917679042,
			"y": -172.77996629294535,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 23.875015258789062,
			"height": 60.417411654673245,
			"seed": 1428058639,
			"groupIds": [
				"B_gTWikQzFCDTzkY9SrFn"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923221,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "h",
			"rawText": "h",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "h",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1001,
			"versionNonce": 191067279,
			"isDeleted": false,
			"id": "LhXAZRUGlEx0qXATaNB_c",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 324.2746671079617,
			"y": -174.17855955644404,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 1875073071,
			"groupIds": [
				"B_gTWikQzFCDTzkY9SrFn"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 232,
			"versionNonce": 1411795097,
			"isDeleted": false,
			"id": "W2jHBcED",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 606.6661800675437,
			"y": 197.11967791166512,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 75.18623352050781,
			"height": 346.808897217726,
			"seed": 1294367311,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923221,
			"link": null,
			"locked": false,
			"fontSize": 277.4471177741808,
			"fontFamily": 1,
			"text": "1",
			"rawText": "1",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "1",
			"lineHeight": 1.25
		},
		{
			"type": "rectangle",
			"version": 386,
			"versionNonce": 1262750383,
			"isDeleted": false,
			"id": "ElGrDiaf5NW-XetgrY2AL",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1632.0077224830616,
			"y": -593.9623708184793,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 101.1608273043898,
			"height": 473.6684207040644,
			"seed": 579841889,
			"groupIds": [
				"wWDLsluC5Bn2fb8p4swoK"
			],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false
		},
		{
			"type": "line",
			"version": 405,
			"versionNonce": 47872961,
			"isDeleted": false,
			"id": "xfTWZCrCkpKV3h2-5eKoO",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1742.907315504323,
			"y": -536.659938833167,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 1384454977,
			"groupIds": [
				"wWDLsluC5Bn2fb8p4swoK"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 431,
			"versionNonce": 183295183,
			"isDeleted": false,
			"id": "QZQjEjvL0BIxI24nilr0Q",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1742.907315504323,
			"y": -477.92517557281644,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 1554123553,
			"groupIds": [
				"wWDLsluC5Bn2fb8p4swoK"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 435,
			"versionNonce": 209148833,
			"isDeleted": false,
			"id": "dGnH7qe8PGPwYoXgqRFey",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1742.907315504323,
			"y": -416.58001932827324,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 425066241,
			"groupIds": [
				"wWDLsluC5Bn2fb8p4swoK"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 461,
			"versionNonce": 502688495,
			"isDeleted": false,
			"id": "LVARSMaJlEVEu2fBMe2x2",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1742.907315504323,
			"y": -357.8452560679227,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 656439009,
			"groupIds": [
				"wWDLsluC5Bn2fb8p4swoK"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 454,
			"versionNonce": 858603393,
			"isDeleted": false,
			"id": "7o0QZp1KtK6Lfbqc5urxo",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1742.907315504323,
			"y": -297.80534610553036,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 680587969,
			"groupIds": [
				"wWDLsluC5Bn2fb8p4swoK"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 480,
			"versionNonce": 1357460751,
			"isDeleted": false,
			"id": "vqte6SInV7dcoSCxckX5_",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1742.907315504323,
			"y": -239.07058284517984,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 1111945889,
			"groupIds": [
				"wWDLsluC5Bn2fb8p4swoK"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 484,
			"versionNonce": 1966843745,
			"isDeleted": false,
			"id": "El_pFbvqYFp6msMKJJlCN",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1742.907315504323,
			"y": -177.7254266006364,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 1492252289,
			"groupIds": [
				"wWDLsluC5Bn2fb8p4swoK"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "rectangle",
			"version": 592,
			"versionNonce": 1262336815,
			"isDeleted": false,
			"id": "MEzAoLr8bzWN4ujJ6N6_c",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 2031.3330651852957,
			"y": -515.7626220009972,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 66.88541640049824,
			"height": 308.63805989636126,
			"seed": 256999009,
			"groupIds": [
				"wWDLsluC5Bn2fb8p4swoK"
			],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false
		},
		{
			"type": "line",
			"version": 614,
			"versionNonce": 1559368513,
			"isDeleted": false,
			"id": "J3lVzjZOx4YJNg_E9JfRE",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 2101.119976004557,
			"y": -435.1856117529137,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 75.33717800129428,
			"height": 0,
			"seed": 70584897,
			"groupIds": [
				"wWDLsluC5Bn2fb8p4swoK"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-75.33717800129428,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 657,
			"versionNonce": 828144975,
			"isDeleted": false,
			"id": "XK8iNf5EpXHWWB1oI0LAr",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 2101.119976004557,
			"y": -364.88132037059927,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 75.33717800129428,
			"height": 0,
			"seed": 1350310433,
			"groupIds": [
				"wWDLsluC5Bn2fb8p4swoK"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-75.33717800129428,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 649,
			"versionNonce": 2125464353,
			"isDeleted": false,
			"id": "gCwLJ_os5qkSXCKLBPaVx",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 2102.0736895957166,
			"y": -279.11587292806803,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 75.33717800129428,
			"height": 0,
			"seed": 1159081473,
			"groupIds": [
				"wWDLsluC5Bn2fb8p4swoK"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-75.33717800129428,
					0
				]
			]
		},
		{
			"type": "rectangle",
			"version": 713,
			"versionNonce": 1386319695,
			"isDeleted": false,
			"id": "7Wn2tehw4bQgc3qjFCRLV",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 2400.3976699433347,
			"y": -431.8409918062803,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 66.88541640049824,
			"height": 137.9337314915794,
			"seed": 1761789409,
			"groupIds": [
				"wWDLsluC5Bn2fb8p4swoK"
			],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "yZqvOIS2ms9S6CaDG2-NT",
					"type": "arrow"
				}
			],
			"updated": 1714387200682,
			"link": null,
			"locked": false
		},
		{
			"type": "line",
			"version": 690,
			"versionNonce": 920975105,
			"isDeleted": false,
			"id": "76mS3nnOJdyhGt4fHTcn1",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 2471.1382215956237,
			"y": -362.0203614924487,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 75.33717800129428,
			"height": 0,
			"seed": 928080321,
			"groupIds": [
				"wWDLsluC5Bn2fb8p4swoK"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-75.33717800129428,
					0
				]
			]
		},
		{
			"type": "arrow",
			"version": 329,
			"versionNonce": 1330296207,
			"isDeleted": false,
			"id": "FXO04Q_VJkq1Gskn6FdLS",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 1684.4684807236733,
			"y": -563.4924361689341,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 377.64755415062143,
			"height": 91.55093875427153,
			"seed": 488735137,
			"groupIds": [
				"wWDLsluC5Bn2fb8p4swoK"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					377.64755415062143,
					91.55093875427153
				]
			]
		},
		{
			"type": "arrow",
			"version": 456,
			"versionNonce": 672165601,
			"isDeleted": false,
			"id": "-GJUAtvnHGCIfRyOTmXe8",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 1694.05145300444,
			"y": -501.4960334286313,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 370.92557712707105,
			"height": 101.07868986305633,
			"seed": 933406081,
			"groupIds": [
				"wWDLsluC5Bn2fb8p4swoK"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false,
			"startBinding": {
				"focus": -0.14862558574215265,
				"gap": 1.9638168918772863,
				"elementId": "QKlZPCUS"
			},
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					370.92557712707105,
					101.07868986305633
				]
			]
		},
		{
			"type": "arrow",
			"version": 443,
			"versionNonce": 1922771887,
			"isDeleted": false,
			"id": "3SrI0GQ8hezY5bMp08VPB",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 1685.4221215567015,
			"y": -441.42455420897113,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 382.41583107389397,
			"height": 122.06791833902864,
			"seed": 1377062241,
			"groupIds": [
				"wWDLsluC5Bn2fb8p4swoK"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					382.41583107389397,
					122.06791833902864
				]
			]
		},
		{
			"type": "arrow",
			"version": 502,
			"versionNonce": 2025974465,
			"isDeleted": false,
			"id": "TcbiHbU5d3nEJ6k_kE4aB",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 1681.607521845523,
			"y": -381.3442722515508,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 384.3231491190162,
			"height": 136.37274910884614,
			"seed": 600176961,
			"groupIds": [
				"wWDLsluC5Bn2fb8p4swoK"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					384.3231491190162,
					136.37274910884614
				]
			]
		},
		{
			"type": "arrow",
			"version": 325,
			"versionNonce": 1555553743,
			"isDeleted": false,
			"id": "9uR0PeIX3CUPGQgSSvVTT",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 1681.607521845523,
			"y": -322.217594748093,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 379.55487219574377,
			"height": 147.81658462144748,
			"seed": 1310140705,
			"groupIds": [
				"wWDLsluC5Bn2fb8p4swoK"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					379.55487219574377,
					-147.81658462144748
				]
			]
		},
		{
			"type": "arrow",
			"version": 296,
			"versionNonce": 1368976033,
			"isDeleted": false,
			"id": "mh5Z7Cy1CyKm5sy9sqEZR",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 1679.7002038004007,
			"y": -264.99830804788894,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 385.27675357297846,
			"height": 134.46539468465812,
			"seed": 444030209,
			"groupIds": [
				"wWDLsluC5Bn2fb8p4swoK"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					385.27675357297846,
					-134.46539468465812
				]
			]
		},
		{
			"type": "arrow",
			"version": 296,
			"versionNonce": 1622756335,
			"isDeleted": false,
			"id": "jTD68ym_B0Gx423hZ9ecI",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 1679.7002038004007,
			"y": -209.6862666346749,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 389.0913896632228,
			"height": 103.94845147896683,
			"seed": 2019955937,
			"groupIds": [
				"wWDLsluC5Bn2fb8p4swoK"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					389.0913896632228,
					-103.94845147896683
				]
			]
		},
		{
			"type": "arrow",
			"version": 290,
			"versionNonce": 457502337,
			"isDeleted": false,
			"id": "hRGT8aX-zu7Hu8CKXRqvR",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 1680.653844633429,
			"y": -145.79138496607607,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 385.2768263311102,
			"height": 93.45818404126192,
			"seed": 997380289,
			"groupIds": [
				"wWDLsluC5Bn2fb8p4swoK"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					385.2768263311102,
					-93.45818404126192
				]
			]
		},
		{
			"type": "arrow",
			"version": 330,
			"versionNonce": 1520956943,
			"isDeleted": false,
			"id": "vrsCdlJVwYk_aJOMdo6aj",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 2081.141018546583,
			"y": -473.8855498546952,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 335.7347903159332,
			"height": 77.31194671885714,
			"seed": 423432353,
			"groupIds": [
				"wWDLsluC5Bn2fb8p4swoK"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": {
				"focus": -0.1655042086679682,
				"gap": 2.5858382334604357,
				"elementId": "SBm4uKPn"
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					335.7347903159332,
					77.31194671885714
				]
			]
		},
		{
			"type": "arrow",
			"version": 362,
			"versionNonce": 2089121377,
			"isDeleted": false,
			"id": "OfFJo4QcNJ_03tuFiR5-Y",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 2085.9574194906572,
			"y": -397.57954180744764,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 323.3354646353664,
			"height": 69.66728381635153,
			"seed": 1735677057,
			"groupIds": [
				"wWDLsluC5Bn2fb8p4swoK"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false,
			"startBinding": {
				"focus": -0.21807159144687208,
				"gap": 10.869791007488857,
				"elementId": "c7kYd4x1"
			},
			"endBinding": {
				"focus": -0.05357527551458198,
				"gap": 12.243169650113487,
				"elementId": "py2EbVwM"
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					323.3354646353664,
					69.66728381635153
				]
			]
		},
		{
			"type": "arrow",
			"version": 330,
			"versionNonce": 293362735,
			"isDeleted": false,
			"id": "jffo2cCP1G37ko0Z19Bkd",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 2092.632978079986,
			"y": -314.58835894667004,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 321.83470490443824,
			"height": 72.456338351348,
			"seed": 433593441,
			"groupIds": [
				"wWDLsluC5Bn2fb8p4swoK"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": {
				"focus": -0.17976328570012354,
				"gap": 4.993964111552486,
				"elementId": "SBm4uKPn"
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					321.83470490443824,
					-72.456338351348
				]
			]
		},
		{
			"type": "arrow",
			"version": 351,
			"versionNonce": 405406273,
			"isDeleted": false,
			"id": "4y3Gikbf1PCfevvcc5anC",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 2093.5866189130143,
			"y": -237.3422873412817,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 315.7064107292731,
			"height": 79.1719525312156,
			"seed": 3663937,
			"groupIds": [
				"wWDLsluC5Bn2fb8p4swoK"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": {
				"focus": -0.0518646880365505,
				"gap": 12.243024133849758,
				"elementId": "py2EbVwM"
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					315.7064107292731,
					-79.1719525312156
				]
			]
		},
		{
			"type": "text",
			"version": 273,
			"versionNonce": 515041655,
			"isDeleted": false,
			"id": "SBm4uKPn",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 2419.461647095977,
			"y": -428.0891923797758,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 32.23609924316406,
			"height": 60.417411654673245,
			"seed": 1148401697,
			"groupIds": [
				"sM28y3AyyMbGszuR7tt2H"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923221,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "a",
			"rawText": "a",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "a",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 293,
			"versionNonce": 185733665,
			"isDeleted": false,
			"id": "T6ReUiT0Ihs1MbUg83l64",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 2407.837812039401,
			"y": -423.3339394894283,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 679054337,
			"groupIds": [
				"sM28y3AyyMbGszuR7tt2H"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 181,
			"versionNonce": 157535609,
			"isDeleted": false,
			"id": "RfVurlXS",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1858.4299251035786,
			"y": 43.54713241603463,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 277.52392578125,
			"height": 90,
			"seed": 71984097,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923222,
			"link": null,
			"locked": false,
			"fontSize": 36,
			"fontFamily": 1,
			"text": "read operation \naddress (b)",
			"rawText": "read operation \naddress (b)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "read operation \naddress (b)",
			"lineHeight": 1.25
		},
		{
			"type": "text",
			"version": 696,
			"versionNonce": 161784471,
			"isDeleted": false,
			"id": "YYk27tu1",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1660.3671573700108,
			"y": -594.4041689945409,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 32.23609924316406,
			"height": 60.417411654673245,
			"seed": 66404289,
			"groupIds": [
				"_7LRvYQssOjaF5hKZYolY"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923222,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "a",
			"rawText": "a",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "a",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 718,
			"versionNonce": 924907151,
			"isDeleted": false,
			"id": "Oa1CoErr5gy78QTWmcBD-",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1648.7433223134344,
			"y": -589.6489161041934,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 630824865,
			"groupIds": [
				"_7LRvYQssOjaF5hKZYolY"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 895,
			"versionNonce": 1247655513,
			"isDeleted": false,
			"id": "QKlZPCUS",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1666.5359774821914,
			"y": -530.5981259165251,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 24.5516357421875,
			"height": 60.417411654673245,
			"seed": 2003239809,
			"groupIds": [
				"oWyjB75X38jqDLZDLww6I"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923222,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "b",
			"rawText": "b",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "b",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 904,
			"versionNonce": 1744915631,
			"isDeleted": false,
			"id": "X4mQ1v0-RyIYLS5spGh27",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1649.9889528222488,
			"y": -531.9967191800238,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 362605409,
			"groupIds": [
				"oWyjB75X38jqDLZDLww6I"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [
				{
					"id": "yZqvOIS2ms9S6CaDG2-NT",
					"type": "arrow"
				}
			],
			"updated": 1714386616831,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 927,
			"versionNonce": 1547843511,
			"isDeleted": false,
			"id": "2ryjWt28",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1666.5359774821914,
			"y": -472.4162522482013,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 24.26165771484375,
			"height": 60.417411654673245,
			"seed": 1753929537,
			"groupIds": [
				"P70RvZJnPjULSxD3nPzxF"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923222,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "c",
			"rawText": "c",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "c",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 935,
			"versionNonce": 1655824079,
			"isDeleted": false,
			"id": "-t87opMVF_CH56Ay3_R-V",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1649.9889528222488,
			"y": -473.8148455117,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 579880737,
			"groupIds": [
				"P70RvZJnPjULSxD3nPzxF"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 949,
			"versionNonce": 703038265,
			"isDeleted": false,
			"id": "27GAznXw",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1666.5359774821914,
			"y": -414.23443406638285,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 27.499771118164062,
			"height": 60.417411654673245,
			"seed": 2115812097,
			"groupIds": [
				"cHGqmjtxyfqzc4NakFVSQ"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923222,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "d",
			"rawText": "d",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "d",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 956,
			"versionNonce": 2043358447,
			"isDeleted": false,
			"id": "2eJljSblOk_i49i3bbR5O",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1649.9889528222488,
			"y": -415.63302732988154,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 1001370337,
			"groupIds": [
				"cHGqmjtxyfqzc4NakFVSQ"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 979,
			"versionNonce": 1823484119,
			"isDeleted": false,
			"id": "Mde8uLXs",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1666.5359774821914,
			"y": -353.1435138781728,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 26.436508178710938,
			"height": 60.417411654673245,
			"seed": 1608036033,
			"groupIds": [
				"xdGW7nvUWodM4ZTxSqOvV"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923222,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "e",
			"rawText": "e",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "e",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 986,
			"versionNonce": 416659215,
			"isDeleted": false,
			"id": "Q5mFfjP6zHj4oze4c7XPU",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1649.9889528222488,
			"y": -354.5421071416715,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 825700001,
			"groupIds": [
				"xdGW7nvUWodM4ZTxSqOvV"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1010,
			"versionNonce": 342144025,
			"isDeleted": false,
			"id": "E40Q3TmD",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1666.5359774821914,
			"y": -296.41627444280334,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 23.488372802734375,
			"height": 60.417411654673245,
			"seed": 1987752577,
			"groupIds": [
				"0T_eaxOaAjdGLla-LHaL7"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923222,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "f",
			"rawText": "f",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "f",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1017,
			"versionNonce": 642383151,
			"isDeleted": false,
			"id": "nIJANluuFd40SJRjYkYIz",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1649.9889528222488,
			"y": -297.81486770630204,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 1952627297,
			"groupIds": [
				"0T_eaxOaAjdGLla-LHaL7"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1037,
			"versionNonce": 1484977655,
			"isDeleted": false,
			"id": "GJt3lGpF",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1666.5359774821914,
			"y": -233.87083099464985,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 24.21331787109375,
			"height": 60.417411654673245,
			"seed": 733922881,
			"groupIds": [
				"8JuUqsJ2jVlbUIAoyHAWi"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923222,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "g",
			"rawText": "g",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "g",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1044,
			"versionNonce": 630226767,
			"isDeleted": false,
			"id": "8q82H7W3I8VErPaglgoE-",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1649.9889528222488,
			"y": -235.26942425814855,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 1466848801,
			"groupIds": [
				"8JuUqsJ2jVlbUIAoyHAWi"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1073,
			"versionNonce": 499697913,
			"isDeleted": false,
			"id": "yQVUGHKS",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1666.5359774821914,
			"y": -172.77996629294535,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 23.875015258789062,
			"height": 60.417411654673245,
			"seed": 710994433,
			"groupIds": [
				"tkQQRpuBXMOP2I8Iz455s"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923222,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "h",
			"rawText": "h",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "h",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1080,
			"versionNonce": 419544431,
			"isDeleted": false,
			"id": "eUpFN6H1GpVtK1q9YYoxd",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1649.9889528222488,
			"y": -174.17855955644404,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 1301676513,
			"groupIds": [
				"tkQQRpuBXMOP2I8Iz455s"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 312,
			"versionNonce": 381624087,
			"isDeleted": false,
			"id": "vMOTJwY4",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1932.380465781831,
			"y": 197.11967791166512,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 197.53729248046875,
			"height": 346.808897217726,
			"seed": 505224641,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923222,
			"link": null,
			"locked": false,
			"fontSize": 277.4471177741808,
			"fontFamily": 1,
			"text": "2",
			"rawText": "2",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "2",
			"lineHeight": 1.25
		},
		{
			"type": "text",
			"version": 945,
			"versionNonce": 261571033,
			"isDeleted": false,
			"id": "c7kYd4x1",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 2050.535992740981,
			"y": -425.598125916525,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 24.5516357421875,
			"height": 60.417411654673245,
			"seed": 722845089,
			"groupIds": [
				"wmKC6nwA6vFgo8cI16n7H"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923222,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "b",
			"rawText": "b",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "b",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 954,
			"versionNonce": 510004449,
			"isDeleted": false,
			"id": "qX4NnMw-oReiEBN_RDzV5",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 2033.9889680810384,
			"y": -426.9967191800237,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 1940873601,
			"groupIds": [
				"wmKC6nwA6vFgo8cI16n7H"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [
				{
					"id": "yZqvOIS2ms9S6CaDG2-NT",
					"type": "arrow"
				},
				{
					"id": "My4vZ-XLbQFi7jETNi-EB",
					"type": "arrow"
				}
			],
			"updated": 1714386616831,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1011,
			"versionNonce": 1238967351,
			"isDeleted": false,
			"id": "py2EbVwM",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 2421.536053776137,
			"y": -354.5981411753141,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 24.5516357421875,
			"height": 60.417411654673245,
			"seed": 1697220961,
			"groupIds": [
				"dkBQUYfmWe9ts1Gocnb2P"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923222,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "b",
			"rawText": "b",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "b",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1020,
			"versionNonce": 1652740015,
			"isDeleted": false,
			"id": "yzADWraMvbPPFKM_vmE_4",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 2404.9890291161946,
			"y": -355.9967344388128,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 416527681,
			"groupIds": [
				"dkBQUYfmWe9ts1Gocnb2P"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [
				{
					"id": "My4vZ-XLbQFi7jETNi-EB",
					"type": "arrow"
				}
			],
			"updated": 1714387209338,
			"link": null,
			"locked": false
		},
		{
			"type": "rectangle",
			"version": 453,
			"versionNonce": 1037754319,
			"isDeleted": false,
			"id": "MdV1RREPeMHzXOreqQ1Tv",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 2944.0077573602944,
			"y": -593.9623708184793,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 101.1608273043898,
			"height": 473.6684207040644,
			"seed": 92263887,
			"groupIds": [
				"EH9C8WUl5xspUa1eLKRev"
			],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false
		},
		{
			"type": "line",
			"version": 472,
			"versionNonce": 1235159201,
			"isDeleted": false,
			"id": "VwPoRzW9iJoRAZyy8QOCX",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 3054.9073503815557,
			"y": -536.659938833167,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 499270639,
			"groupIds": [
				"EH9C8WUl5xspUa1eLKRev"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 498,
			"versionNonce": 1781272047,
			"isDeleted": false,
			"id": "e_l2uAKxuoTaw-mhOGMkw",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 3054.9073503815557,
			"y": -477.92517557281644,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 2077355535,
			"groupIds": [
				"EH9C8WUl5xspUa1eLKRev"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616831,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 502,
			"versionNonce": 685198465,
			"isDeleted": false,
			"id": "4O-ljWLgtRIpNw1sTrLPf",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 3054.9073503815557,
			"y": -416.58001932827324,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 1789350959,
			"groupIds": [
				"EH9C8WUl5xspUa1eLKRev"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 528,
			"versionNonce": 1819441167,
			"isDeleted": false,
			"id": "4JRMr26W15omT-dC4vycy",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 3054.9073503815557,
			"y": -357.8452560679227,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 1110111823,
			"groupIds": [
				"EH9C8WUl5xspUa1eLKRev"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 521,
			"versionNonce": 605820001,
			"isDeleted": false,
			"id": "OoUE8tWx1_zSCR60borjK",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 3054.9073503815557,
			"y": -297.80534610553036,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 1228231791,
			"groupIds": [
				"EH9C8WUl5xspUa1eLKRev"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 547,
			"versionNonce": 1252433455,
			"isDeleted": false,
			"id": "2Hl2oyCKvsR3CznYXDnAd",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 3054.9073503815557,
			"y": -239.07058284517984,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 1468984975,
			"groupIds": [
				"EH9C8WUl5xspUa1eLKRev"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 551,
			"versionNonce": 255647809,
			"isDeleted": false,
			"id": "HLdGo--B-9pPJNsnCos_u",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 3054.9073503815557,
			"y": -177.7254266006364,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 938493103,
			"groupIds": [
				"EH9C8WUl5xspUa1eLKRev"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "rectangle",
			"version": 661,
			"versionNonce": 307343695,
			"isDeleted": false,
			"id": "Abc2C3bsDvbP5RLuWGfD1",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 3343.3331000625285,
			"y": -515.7626220009972,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 66.88541640049824,
			"height": 308.63805989636126,
			"seed": 1241634511,
			"groupIds": [
				"EH9C8WUl5xspUa1eLKRev"
			],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [],
			"updated": 1714387242235,
			"link": null,
			"locked": false
		},
		{
			"type": "line",
			"version": 681,
			"versionNonce": 404303905,
			"isDeleted": false,
			"id": "RcQ3EUg0W77KE7W8dFRlC",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 3413.1200108817898,
			"y": -435.1856117529137,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 75.33717800129428,
			"height": 0,
			"seed": 1683760367,
			"groupIds": [
				"EH9C8WUl5xspUa1eLKRev"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-75.33717800129428,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 724,
			"versionNonce": 1969888879,
			"isDeleted": false,
			"id": "lOKgjQh5_m3Lisuj5WG7V",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 3413.1200108817898,
			"y": -364.88132037059927,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 75.33717800129428,
			"height": 0,
			"seed": 1988603663,
			"groupIds": [
				"EH9C8WUl5xspUa1eLKRev"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-75.33717800129428,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 716,
			"versionNonce": 77628417,
			"isDeleted": false,
			"id": "AdGZgbHnOTUdhfw4Gr8h6",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 3414.0737244729494,
			"y": -279.11587292806803,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 75.33717800129428,
			"height": 0,
			"seed": 1794962735,
			"groupIds": [
				"EH9C8WUl5xspUa1eLKRev"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-75.33717800129428,
					0
				]
			]
		},
		{
			"type": "rectangle",
			"version": 783,
			"versionNonce": 950679521,
			"isDeleted": false,
			"id": "BSxZ9qCwSUVNj41wwDFP4",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 3712.3977048205675,
			"y": -431.8409918062803,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 66.88541640049824,
			"height": 137.9337314915794,
			"seed": 1227126607,
			"groupIds": [
				"EH9C8WUl5xspUa1eLKRev"
			],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "1Q2tLu2xxWyua-KjrEl4K",
					"type": "arrow"
				},
				{
					"id": "LtaMdczChDq-ySgYYwglI",
					"type": "arrow"
				}
			],
			"updated": 1714387289681,
			"link": null,
			"locked": false
		},
		{
			"type": "line",
			"version": 757,
			"versionNonce": 819092449,
			"isDeleted": false,
			"id": "A20ZQS3nonPaGwTFw688J",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 3783.1382564728565,
			"y": -362.0203614924487,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 75.33717800129428,
			"height": 0,
			"seed": 391558511,
			"groupIds": [
				"EH9C8WUl5xspUa1eLKRev"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-75.33717800129428,
					0
				]
			]
		},
		{
			"type": "arrow",
			"version": 396,
			"versionNonce": 1090162351,
			"isDeleted": false,
			"id": "2lS7bPyzi05MqzColr9I8",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 2996.4685156009064,
			"y": -563.4924361689341,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 377.64755415062143,
			"height": 91.55093875427153,
			"seed": 2094804879,
			"groupIds": [
				"EH9C8WUl5xspUa1eLKRev"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					377.64755415062143,
					91.55093875427153
				]
			]
		},
		{
			"type": "arrow",
			"version": 525,
			"versionNonce": 1287534529,
			"isDeleted": false,
			"id": "ovuuTHSbwkrJ32wPnRcFQ",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 3006.051487881673,
			"y": -501.4960334286313,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 370.92557712707105,
			"height": 101.07868986305633,
			"seed": 602760623,
			"groupIds": [
				"EH9C8WUl5xspUa1eLKRev"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": {
				"focus": -0.156747147761234,
				"gap": 2.9638397800613347,
				"elementId": "TJ2rSb4E"
			},
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					370.92557712707105,
					101.07868986305633
				]
			]
		},
		{
			"type": "arrow",
			"version": 510,
			"versionNonce": 254992591,
			"isDeleted": false,
			"id": "vK40K29Ap2YS0pH82pvT4",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 2997.422156433934,
			"y": -441.42455420897113,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 382.41583107389397,
			"height": 122.06791833902864,
			"seed": 1538447311,
			"groupIds": [
				"EH9C8WUl5xspUa1eLKRev"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					382.41583107389397,
					122.06791833902864
				]
			]
		},
		{
			"type": "arrow",
			"version": 569,
			"versionNonce": 1518573473,
			"isDeleted": false,
			"id": "S1ZUnMU0QV_yBw1lB8AKI",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 2993.607556722756,
			"y": -381.3442722515508,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 384.3231491190162,
			"height": 136.37274910884614,
			"seed": 2051343855,
			"groupIds": [
				"EH9C8WUl5xspUa1eLKRev"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					384.3231491190162,
					136.37274910884614
				]
			]
		},
		{
			"type": "arrow",
			"version": 392,
			"versionNonce": 853274351,
			"isDeleted": false,
			"id": "gCd2UIjh-Iev2FNvYmh0u",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 2993.607556722756,
			"y": -322.217594748093,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 379.55487219574377,
			"height": 147.81658462144748,
			"seed": 2125230095,
			"groupIds": [
				"EH9C8WUl5xspUa1eLKRev"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					379.55487219574377,
					-147.81658462144748
				]
			]
		},
		{
			"type": "arrow",
			"version": 363,
			"versionNonce": 1817312129,
			"isDeleted": false,
			"id": "o_e0TsVpUDohtQy81thcf",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 2991.7002386776335,
			"y": -264.99830804788894,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 385.27675357297846,
			"height": 134.46539468465812,
			"seed": 1927386671,
			"groupIds": [
				"EH9C8WUl5xspUa1eLKRev"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					385.27675357297846,
					-134.46539468465812
				]
			]
		},
		{
			"type": "arrow",
			"version": 363,
			"versionNonce": 914241807,
			"isDeleted": false,
			"id": "9OG4VmUrRsN1ITxMi2mrg",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 2991.7002386776335,
			"y": -209.6862666346749,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 389.0913896632228,
			"height": 103.94845147896683,
			"seed": 231536719,
			"groupIds": [
				"EH9C8WUl5xspUa1eLKRev"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					389.0913896632228,
					-103.94845147896683
				]
			]
		},
		{
			"type": "arrow",
			"version": 357,
			"versionNonce": 577299297,
			"isDeleted": false,
			"id": "v5b0D55kRxPs-rUPNOfT2",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 2992.6538795106617,
			"y": -145.79138496607607,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 385.2768263311102,
			"height": 93.45818404126192,
			"seed": 356980335,
			"groupIds": [
				"EH9C8WUl5xspUa1eLKRev"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					385.2768263311102,
					-93.45818404126192
				]
			]
		},
		{
			"type": "arrow",
			"version": 626,
			"versionNonce": 1066549039,
			"isDeleted": false,
			"id": "7B6YrDqswwzyYkdkZIYc7",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 3393.141053423816,
			"y": -473.61970567132494,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 328.205421634867,
			"height": 78.19141387204877,
			"seed": 1601679,
			"groupIds": [
				"EH9C8WUl5xspUa1eLKRev"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": {
				"focus": -0.05763267504012096,
				"gap": 2.1491401991697785,
				"elementId": "npMBANyE"
			},
			"endBinding": {
				"focus": -0.1301284864825862,
				"gap": 11.07198358980304,
				"elementId": "M93gtj21"
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					328.205421634867,
					78.19141387204877
				]
			]
		},
		{
			"type": "arrow",
			"version": 499,
			"versionNonce": 1763168065,
			"isDeleted": false,
			"id": "zbcPIlN9hIj0eM_qKOyUI",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 3397.95745436789,
			"y": -397.57954180744764,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 323.3354646353664,
			"height": 69.66728381635153,
			"seed": 1475970735,
			"groupIds": [
				"EH9C8WUl5xspUa1eLKRev"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": {
				"focus": -0.21845864906053053,
				"gap": 10.869791007488857,
				"elementId": "HkPc4qTQ"
			},
			"endBinding": {
				"focus": -0.05357527551458254,
				"gap": 12.243169650113487,
				"elementId": "W5HFuD4i"
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					323.3354646353664,
					69.66728381635153
				]
			]
		},
		{
			"type": "arrow",
			"version": 595,
			"versionNonce": 813728079,
			"isDeleted": false,
			"id": "MxyN46MvMpcuM9FKQIE8p",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 3404.565073466535,
			"y": -314.1617951484818,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 312.4909514953056,
			"height": 70.12415620467112,
			"seed": 1536350415,
			"groupIds": [
				"EH9C8WUl5xspUa1eLKRev"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": {
				"focus": 0.4011359027163499,
				"gap": 1.9270744977708532,
				"elementId": "e_24cAlfWHLU5mMc5HNby"
			},
			"endBinding": {
				"focus": -0.11393602304016606,
				"gap": 15.362433686646,
				"elementId": "M93gtj21"
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					312.4909514953056,
					-70.12415620467112
				]
			]
		},
		{
			"type": "arrow",
			"version": 486,
			"versionNonce": 1992179489,
			"isDeleted": false,
			"id": "YBfhKuKNh8if8FDkREn5Z",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 3405.586653790247,
			"y": -237.3422873412817,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 315.7064107292731,
			"height": 79.1719525312156,
			"seed": 1618798319,
			"groupIds": [
				"EH9C8WUl5xspUa1eLKRev"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": {
				"focus": -0.051864688036552135,
				"gap": 12.243024133849758,
				"elementId": "W5HFuD4i"
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					315.7064107292731,
					-79.1719525312156
				]
			]
		},
		{
			"type": "text",
			"version": 464,
			"versionNonce": 920886969,
			"isDeleted": false,
			"id": "npMBANyE",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 3358.755813981482,
			"y": -506.20683225799263,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 32.23609924316406,
			"height": 60.417411654673245,
			"seed": 1967141135,
			"groupIds": [
				"dSYHWN2eZ54Ge0HwK6lwu"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923222,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "a",
			"rawText": "a",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "a",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 481,
			"versionNonce": 164344577,
			"isDeleted": false,
			"id": "bvzgB8yajJlNbLOpSkzmx",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 3347.131978924906,
			"y": -501.45157936764514,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 1129658159,
			"groupIds": [
				"dSYHWN2eZ54Ge0HwK6lwu"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 249,
			"versionNonce": 1370850647,
			"isDeleted": false,
			"id": "2jh2U2NE",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 3170.4299599808114,
			"y": 43.54713241603463,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 277.52392578125,
			"height": 90,
			"seed": 824473935,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923222,
			"link": null,
			"locked": false,
			"fontSize": 36,
			"fontFamily": 1,
			"text": "read operation \naddress (c)",
			"rawText": "read operation \naddress (c)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "read operation \naddress (c)",
			"lineHeight": 1.25
		},
		{
			"type": "text",
			"version": 763,
			"versionNonce": 1917935513,
			"isDeleted": false,
			"id": "53R0mWyQ",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 2972.3671922472436,
			"y": -594.4041689945409,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 32.23609924316406,
			"height": 60.417411654673245,
			"seed": 1141274479,
			"groupIds": [
				"SKJCi0x1bzgwrivtXVAhk"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923222,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "a",
			"rawText": "a",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "a",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 785,
			"versionNonce": 646819759,
			"isDeleted": false,
			"id": "YiVjqlJSNxOW8a8w4cKGn",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 2960.743357190667,
			"y": -589.6489161041934,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 1111732623,
			"groupIds": [
				"SKJCi0x1bzgwrivtXVAhk"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 963,
			"versionNonce": 497599095,
			"isDeleted": false,
			"id": "TJ2rSb4E",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 2978.536012359424,
			"y": -530.5981259165251,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 24.5516357421875,
			"height": 60.417411654673245,
			"seed": 353675183,
			"groupIds": [
				"gynLYx9H_OSnJnRQui7sG"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923222,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "b",
			"rawText": "b",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "b",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 970,
			"versionNonce": 2008670671,
			"isDeleted": false,
			"id": "ZLFhU73y6_wSO5eYz2Xpj",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 2961.9889876994816,
			"y": -531.9967191800238,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 1788991951,
			"groupIds": [
				"gynLYx9H_OSnJnRQui7sG"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 996,
			"versionNonce": 1311865,
			"isDeleted": false,
			"id": "1WgL9fFK",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 2978.536012359424,
			"y": -472.4162522482013,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 24.26165771484375,
			"height": 60.417411654673245,
			"seed": 402900975,
			"groupIds": [
				"vfQSDini-FzyKwloiHy_m"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923222,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "c",
			"rawText": "c",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "c",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1007,
			"versionNonce": 1625318703,
			"isDeleted": false,
			"id": "VBgkUj1Ci_2hZlBJrAmRw",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 2961.9889876994816,
			"y": -473.8148455117,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 994243087,
			"groupIds": [
				"vfQSDini-FzyKwloiHy_m"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714387294249,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1016,
			"versionNonce": 1048009623,
			"isDeleted": false,
			"id": "FkIGDY4k",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 2978.536012359424,
			"y": -414.23443406638285,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 27.499771118164062,
			"height": 60.417411654673245,
			"seed": 492296239,
			"groupIds": [
				"QlEsyVNTHit8-0CdJ7YzM"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923222,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "d",
			"rawText": "d",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "d",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1023,
			"versionNonce": 1475934735,
			"isDeleted": false,
			"id": "omU0Y2ihkkFMmPBxs79ig",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 2961.9889876994816,
			"y": -415.63302732988154,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 1412102735,
			"groupIds": [
				"QlEsyVNTHit8-0CdJ7YzM"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1046,
			"versionNonce": 200215897,
			"isDeleted": false,
			"id": "XtG3B73Q",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 2978.536012359424,
			"y": -353.1435138781728,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 26.436508178710938,
			"height": 60.417411654673245,
			"seed": 613734511,
			"groupIds": [
				"osjZOrv6k7a-V1DvomIYY"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923222,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "e",
			"rawText": "e",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "e",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1053,
			"versionNonce": 1175248943,
			"isDeleted": false,
			"id": "qKnfsPB1a7g-Nau5-pf9H",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 2961.9889876994816,
			"y": -354.5421071416715,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 610136719,
			"groupIds": [
				"osjZOrv6k7a-V1DvomIYY"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1077,
			"versionNonce": 945148087,
			"isDeleted": false,
			"id": "QTu4Vizf",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 2978.536012359424,
			"y": -296.41627444280334,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 23.488372802734375,
			"height": 60.417411654673245,
			"seed": 473876655,
			"groupIds": [
				"rLyydLDxDKKo4C0KZl7ot"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923222,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "f",
			"rawText": "f",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "f",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1084,
			"versionNonce": 822018639,
			"isDeleted": false,
			"id": "e8SBwGyeCR6NgwbuKhuOM",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 2961.9889876994816,
			"y": -297.81486770630204,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 702536399,
			"groupIds": [
				"rLyydLDxDKKo4C0KZl7ot"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1104,
			"versionNonce": 2100689465,
			"isDeleted": false,
			"id": "fizmXNaI",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 2978.536012359424,
			"y": -233.87083099464985,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 24.21331787109375,
			"height": 60.417411654673245,
			"seed": 567912687,
			"groupIds": [
				"41azoUwo1Y9KOcfrwWosi"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923222,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "g",
			"rawText": "g",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "g",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1111,
			"versionNonce": 1504174191,
			"isDeleted": false,
			"id": "b_LMWIwTc4GYokire21e9",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 2961.9889876994816,
			"y": -235.26942425814855,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 833925903,
			"groupIds": [
				"41azoUwo1Y9KOcfrwWosi"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1140,
			"versionNonce": 350790103,
			"isDeleted": false,
			"id": "KUvTA3oh",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 2978.536012359424,
			"y": -172.77996629294535,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 23.875015258789062,
			"height": 60.417411654673245,
			"seed": 1105819951,
			"groupIds": [
				"T4qctkItOJjK3XK61jZOv"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923222,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "h",
			"rawText": "h",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "h",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1147,
			"versionNonce": 1372584591,
			"isDeleted": false,
			"id": "Q1aYwfIUuFyqfwCmSQZTU",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 2961.9889876994816,
			"y": -174.17855955644404,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 400587599,
			"groupIds": [
				"T4qctkItOJjK3XK61jZOv"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 379,
			"versionNonce": 80497433,
			"isDeleted": false,
			"id": "gVq02cMf",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 3244.3805006590637,
			"y": 197.11967791166512,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 197.53729248046875,
			"height": 346.808897217726,
			"seed": 938621295,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923222,
			"link": null,
			"locked": false,
			"fontSize": 277.4471177741808,
			"fontFamily": 1,
			"text": "2",
			"rawText": "2",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "2",
			"lineHeight": 1.25
		},
		{
			"type": "text",
			"version": 1013,
			"versionNonce": 893669111,
			"isDeleted": false,
			"id": "HkPc4qTQ",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 3362.5360276182137,
			"y": -425.598125916525,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 24.5516357421875,
			"height": 60.417411654673245,
			"seed": 124203919,
			"groupIds": [
				"4xej1wtfmgyniT_oeWzDE"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923222,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "b",
			"rawText": "b",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "b",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1019,
			"versionNonce": 972428737,
			"isDeleted": false,
			"id": "BodL7OUqflR12g5MNU0ng",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 3345.989002958271,
			"y": -426.9967191800237,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 779610543,
			"groupIds": [
				"4xej1wtfmgyniT_oeWzDE"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1078,
			"versionNonce": 1797619705,
			"isDeleted": false,
			"id": "W5HFuD4i",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 3733.53608865337,
			"y": -354.5981411753141,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 24.5516357421875,
			"height": 60.417411654673245,
			"seed": 978115535,
			"groupIds": [
				"p53RnYMG6xKzFLhA8xNm4"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923222,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "b",
			"rawText": "b",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "b",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1084,
			"versionNonce": 1359984033,
			"isDeleted": false,
			"id": "TEtUYMytggd-so2FZaa8t",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 3716.9890639934274,
			"y": -355.9967344388128,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 2130610671,
			"groupIds": [
				"p53RnYMG6xKzFLhA8xNm4"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1045,
			"versionNonce": 1676498967,
			"isDeleted": false,
			"id": "jaDJNyhc",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 3362.5360051788175,
			"y": -346.29859082816455,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 24.26165771484375,
			"height": 60.417411654673245,
			"seed": 966095887,
			"groupIds": [
				"nl5HiHAwJzFBmRM_EpWOo"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923223,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "c",
			"rawText": "c",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "c",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1056,
			"versionNonce": 185752079,
			"isDeleted": false,
			"id": "e_24cAlfWHLU5mMc5HNby",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 3345.988980518875,
			"y": -347.69718409166325,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 1913264687,
			"groupIds": [
				"nl5HiHAwJzFBmRM_EpWOo"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [
				{
					"id": "LtaMdczChDq-ySgYYwglI",
					"type": "arrow"
				}
			],
			"updated": 1714387285354,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1120,
			"versionNonce": 507844825,
			"isDeleted": false,
			"id": "M93gtj21",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 3732.418458648486,
			"y": -424.4162666094145,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 24.26165771484375,
			"height": 60.417411654673245,
			"seed": 491060303,
			"groupIds": [
				"btta5G8l9q8QnOdZlnP8b"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923223,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "c",
			"rawText": "c",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "c",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1128,
			"versionNonce": 1570043713,
			"isDeleted": false,
			"id": "W23voc2L_zwRs7GRQDZgn",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 3715.8714339885437,
			"y": -425.8148598729132,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 2132712047,
			"groupIds": [
				"btta5G8l9q8QnOdZlnP8b"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [
				{
					"id": "LtaMdczChDq-ySgYYwglI",
					"type": "arrow"
				}
			],
			"updated": 1714387281625,
			"link": null,
			"locked": false
		},
		{
			"type": "arrow",
			"version": 381,
			"versionNonce": 286910287,
			"isDeleted": false,
			"id": "1Q2tLu2xxWyua-KjrEl4K",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 3034.93341523354,
			"y": -441.1186387513907,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 665.1151049064865,
			"height": 182.1487952694036,
			"seed": 1281324175,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "CWCVEqhn"
				}
			],
			"updated": 1714387294250,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": {
				"elementId": "BSxZ9qCwSUVNj41wwDFP4",
				"focus": 0.2782027801984802,
				"gap": 12.349184680540702
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					362.5348911223914,
					-156.25787804047366
				],
				[
					665.1151049064865,
					25.890917228929936
				]
			]
		},
		{
			"type": "text",
			"version": 2,
			"versionNonce": 2231265,
			"isDeleted": false,
			"id": "CWCVEqhn",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 3384.652312093236,
			"y": -619.8765167918643,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 19.40625,
			"height": 45,
			"seed": 1756516431,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714387259883,
			"link": null,
			"locked": false,
			"fontSize": 36,
			"fontFamily": 1,
			"text": "2",
			"rawText": "2",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "1Q2tLu2xxWyua-KjrEl4K",
			"originalText": "2",
			"lineHeight": 1.25
		},
		{
			"type": "arrow",
			"version": 270,
			"versionNonce": 1968334927,
			"isDeleted": false,
			"id": "LtaMdczChDq-ySgYYwglI",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 3700.3394025974126,
			"y": -386.23382873718595,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 286.25461647727207,
			"height": 65.06668368252838,
			"seed": 213912239,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "oCevVU1c"
				}
			],
			"updated": 1714387302066,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "BSxZ9qCwSUVNj41wwDFP4",
				"focus": 0.44015800019876994,
				"gap": 12.05830222315467
			},
			"endBinding": {
				"elementId": "e_24cAlfWHLU5mMc5HNby",
				"focus": 0.23895793871726104,
				"gap": 11.083521030270838
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-286.25461647727207,
					65.06668368252838
				]
			]
		},
		{
			"type": "text",
			"version": 3,
			"versionNonce": 978650671,
			"isDeleted": false,
			"id": "oCevVU1c",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 3544.954098753308,
			"y": -376.20048689592176,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 19.40625,
			"height": 45,
			"seed": 1045160129,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714387301704,
			"link": null,
			"locked": false,
			"fontSize": 36,
			"fontFamily": 1,
			"text": "3",
			"rawText": "3",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "LtaMdczChDq-ySgYYwglI",
			"originalText": "3",
			"lineHeight": 1.25
		},
		{
			"type": "arrow",
			"version": 102,
			"versionNonce": 1328664911,
			"isDeleted": false,
			"id": "jxMULZySDbFAj4Sk8Qp2Q",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 3675.501527231202,
			"y": -408.4443956335669,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 244.00001525878906,
			"height": 55,
			"seed": 1021893839,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "fqw6eYfF"
				}
			],
			"updated": 1714387265188,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-244.00001525878906,
					-55
				]
			]
		},
		{
			"type": "text",
			"version": 3,
			"versionNonce": 774737711,
			"isDeleted": false,
			"id": "fqw6eYfF",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 3548.623521249757,
			"y": -458.4443956335669,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 19.40625,
			"height": 45,
			"seed": 2076485935,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714387264854,
			"link": null,
			"locked": false,
			"fontSize": 36,
			"fontFamily": 1,
			"text": "1",
			"rawText": "1",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "jxMULZySDbFAj4Sk8Qp2Q",
			"originalText": "1",
			"lineHeight": 1.25
		},
		{
			"type": "arrow",
			"version": 42,
			"versionNonce": 256597281,
			"isDeleted": false,
			"id": "7TWBe_UiNYkRsQSNM22EM",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1229.6182264499514,
			"y": -401.2560342944874,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 75.73331705729174,
			"height": 2.1333414713541856,
			"seed": 1153977679,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": {
				"elementId": "tEzQs_KRFjZq3jFLeHUWh",
				"focus": -0.10869449195545176,
				"gap": 14.913842692179447
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-75.73331705729174,
					2.1333414713541856
				]
			]
		},
		{
			"type": "arrow",
			"version": 254,
			"versionNonce": 287572609,
			"isDeleted": false,
			"id": "yZqvOIS2ms9S6CaDG2-NT",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 1708.5516167494302,
			"y": -495.1226928231338,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 689.066609700521,
			"height": 339.3462126523633,
			"seed": 956877327,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "E1UmTSwI"
				}
			],
			"updated": 1714387222463,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "X4mQ1v0-RyIYLS5spGh27",
				"focus": -0.49528097290181594,
				"gap": 2.6370314702470665
			},
			"endBinding": {
				"elementId": "7Wn2tehw4bQgc3qjFCRLV",
				"focus": -0.7042672042700016,
				"gap": 4.65120567516081
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					370.51674657264675,
					339.3462126523633
				],
				[
					689.066609700521,
					205.86663818359375
				]
			]
		},
		{
			"type": "text",
			"version": 3,
			"versionNonce": 986349217,
			"isDeleted": false,
			"id": "E1UmTSwI",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 2074.190364970026,
			"y": -178.27648017077047,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 19.40625,
			"height": 45,
			"seed": 1925453551,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714387221976,
			"link": null,
			"locked": false,
			"fontSize": 36,
			"fontFamily": 1,
			"text": "1",
			"rawText": "1",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "yZqvOIS2ms9S6CaDG2-NT",
			"originalText": "1",
			"lineHeight": 1.25
		},
		{
			"type": "arrow",
			"version": 264,
			"versionNonce": 495611329,
			"isDeleted": false,
			"id": "My4vZ-XLbQFi7jETNi-EB",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 2392.2848931166177,
			"y": -328.72270909917535,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 286.9332682291665,
			"height": 67.19999186197924,
			"seed": 1298029153,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "vKyeTtZV"
				}
			],
			"updated": 1714387224925,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "yzADWraMvbPPFKM_vmE_4",
				"focus": -0.2866552155764649,
				"gap": 12.723302897317033
			},
			"endBinding": {
				"elementId": "qX4NnMw-oReiEBN_RDzV5",
				"focus": -0.25555076291425816,
				"gap": 14.375184385043475
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-286.9332682291665,
					-67.19999186197924
				]
			]
		},
		{
			"type": "text",
			"version": 2,
			"versionNonce": 74273249,
			"isDeleted": false,
			"id": "vKyeTtZV",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 2236.002264739339,
			"y": -384.82270503016497,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 19.40625,
			"height": 45,
			"seed": 1733306959,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714387224807,
			"link": null,
			"locked": false,
			"fontSize": 36,
			"fontFamily": 1,
			"text": "2",
			"rawText": "2",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "My4vZ-XLbQFi7jETNi-EB",
			"originalText": "2",
			"lineHeight": 1.25
		},
		{
			"type": "rectangle",
			"version": 508,
			"versionNonce": 475085711,
			"isDeleted": false,
			"id": "HLuNJjKRuzxAAdxbOvzE7",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4304.007757360296,
			"y": -593.9623708184793,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 101.1608273043898,
			"height": 473.6684207040644,
			"seed": 998996865,
			"groupIds": [
				"KpIXHYdXXRSr5zW4oi4lx"
			],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false
		},
		{
			"type": "line",
			"version": 527,
			"versionNonce": 2031962337,
			"isDeleted": false,
			"id": "YDDPm-Jn7dSyI_YPlS_21",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4414.907350381556,
			"y": -536.659938833167,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 1316119393,
			"groupIds": [
				"KpIXHYdXXRSr5zW4oi4lx"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 553,
			"versionNonce": 685830575,
			"isDeleted": false,
			"id": "oePeSyw295GebMz0xWpN-",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4414.907350381556,
			"y": -477.92517557281644,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 1475432257,
			"groupIds": [
				"KpIXHYdXXRSr5zW4oi4lx"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 557,
			"versionNonce": 119768257,
			"isDeleted": false,
			"id": "1btI_6eh3RkBMSdUenS-y",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4414.907350381556,
			"y": -416.58001932827324,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 1315421985,
			"groupIds": [
				"KpIXHYdXXRSr5zW4oi4lx"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 583,
			"versionNonce": 307553231,
			"isDeleted": false,
			"id": "AmJsFK03Q8OagsitoTw9C",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4414.907350381556,
			"y": -357.8452560679227,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 809841409,
			"groupIds": [
				"KpIXHYdXXRSr5zW4oi4lx"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 576,
			"versionNonce": 347554977,
			"isDeleted": false,
			"id": "f2_5K0b9skGrWifKRiYQ3",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4414.907350381556,
			"y": -297.80534610553036,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 34155233,
			"groupIds": [
				"KpIXHYdXXRSr5zW4oi4lx"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 602,
			"versionNonce": 684036591,
			"isDeleted": false,
			"id": "JAZjqxn3doJRH0pGRCeUm",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4414.907350381556,
			"y": -239.07058284517984,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 205727425,
			"groupIds": [
				"KpIXHYdXXRSr5zW4oi4lx"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 606,
			"versionNonce": 1569196161,
			"isDeleted": false,
			"id": "_bZ0vlp-zKVTOAeFZ3HlR",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4414.907350381556,
			"y": -177.7254266006364,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 1502783137,
			"groupIds": [
				"KpIXHYdXXRSr5zW4oi4lx"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "rectangle",
			"version": 716,
			"versionNonce": 624655375,
			"isDeleted": false,
			"id": "uQ_EZvLKEERGGedmUyGew",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4703.333100062529,
			"y": -515.7626220009972,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 66.88541640049824,
			"height": 308.63805989636126,
			"seed": 1957112449,
			"groupIds": [
				"KpIXHYdXXRSr5zW4oi4lx"
			],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false
		},
		{
			"type": "line",
			"version": 736,
			"versionNonce": 2069188705,
			"isDeleted": false,
			"id": "3GV7yCNZPx1Vv96q7wW1X",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4773.12001088179,
			"y": -435.1856117529137,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 75.33717800129428,
			"height": 0,
			"seed": 1715483233,
			"groupIds": [
				"KpIXHYdXXRSr5zW4oi4lx"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-75.33717800129428,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 779,
			"versionNonce": 196026927,
			"isDeleted": false,
			"id": "r219lIjN5UvfThM9UcX3R",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4773.12001088179,
			"y": -364.88132037059927,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 75.33717800129428,
			"height": 0,
			"seed": 1932344897,
			"groupIds": [
				"KpIXHYdXXRSr5zW4oi4lx"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-75.33717800129428,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 771,
			"versionNonce": 602840129,
			"isDeleted": false,
			"id": "7CNNe-molNgsU0wygdFDq",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4774.07372447295,
			"y": -279.11587292806803,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 75.33717800129428,
			"height": 0,
			"seed": 441306657,
			"groupIds": [
				"KpIXHYdXXRSr5zW4oi4lx"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-75.33717800129428,
					0
				]
			]
		},
		{
			"type": "rectangle",
			"version": 836,
			"versionNonce": 1292436559,
			"isDeleted": false,
			"id": "4yfShUu0Vrksq0kW7kXir",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5072.397704820569,
			"y": -431.8409918062803,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 66.88541640049824,
			"height": 137.9337314915794,
			"seed": 1385259521,
			"groupIds": [
				"KpIXHYdXXRSr5zW4oi4lx"
			],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false
		},
		{
			"type": "line",
			"version": 812,
			"versionNonce": 657681441,
			"isDeleted": false,
			"id": "bM0LBfOc1zBzX27_kU72Z",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5143.138256472857,
			"y": -362.0203614924487,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 75.33717800129428,
			"height": 0,
			"seed": 150436321,
			"groupIds": [
				"KpIXHYdXXRSr5zW4oi4lx"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-75.33717800129428,
					0
				]
			]
		},
		{
			"type": "arrow",
			"version": 451,
			"versionNonce": 690070127,
			"isDeleted": false,
			"id": "MF8JvNr245BoLhoiO_UU2",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 4356.468515600907,
			"y": -563.4924361689341,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 377.64755415062143,
			"height": 91.55093875427153,
			"seed": 1586468289,
			"groupIds": [
				"KpIXHYdXXRSr5zW4oi4lx"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					377.64755415062143,
					91.55093875427153
				]
			]
		},
		{
			"type": "arrow",
			"version": 638,
			"versionNonce": 756236289,
			"isDeleted": false,
			"id": "xRqqOZy07ufOSlkN4WzgE",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 4366.051487881674,
			"y": -501.4960334286313,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 370.92557712707105,
			"height": 101.07868986305633,
			"seed": 645477793,
			"groupIds": [
				"KpIXHYdXXRSr5zW4oi4lx"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": {
				"focus": -0.1567471477612303,
				"gap": 2.96383978006088,
				"elementId": "Z86A5THK"
			},
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					370.92557712707105,
					101.07868986305633
				]
			]
		},
		{
			"type": "arrow",
			"version": 565,
			"versionNonce": 1354857615,
			"isDeleted": false,
			"id": "8kQQ8SaSlFtuDzW4Q0ek8",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 4357.422156433935,
			"y": -441.42455420897113,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 382.41583107389397,
			"height": 122.06791833902864,
			"seed": 602134913,
			"groupIds": [
				"KpIXHYdXXRSr5zW4oi4lx"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					382.41583107389397,
					122.06791833902864
				]
			]
		},
		{
			"type": "arrow",
			"version": 624,
			"versionNonce": 864917473,
			"isDeleted": false,
			"id": "a8PAzUgTWglwr1IYEC_4i",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 4353.607556722756,
			"y": -381.3442722515508,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 384.3231491190162,
			"height": 136.37274910884614,
			"seed": 135201121,
			"groupIds": [
				"KpIXHYdXXRSr5zW4oi4lx"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					384.3231491190162,
					136.37274910884614
				]
			]
		},
		{
			"type": "arrow",
			"version": 447,
			"versionNonce": 1201738415,
			"isDeleted": false,
			"id": "kqBKF1XhD680qP98xcxWH",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 4353.607556722756,
			"y": -322.217594748093,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 379.55487219574377,
			"height": 147.81658462144748,
			"seed": 810167617,
			"groupIds": [
				"KpIXHYdXXRSr5zW4oi4lx"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616832,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					379.55487219574377,
					-147.81658462144748
				]
			]
		},
		{
			"type": "arrow",
			"version": 418,
			"versionNonce": 1286730689,
			"isDeleted": false,
			"id": "wAIbNI2qYhrHRpjamm65R",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 4351.700238677635,
			"y": -264.99830804788894,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 385.27675357297846,
			"height": 134.46539468465812,
			"seed": 603249953,
			"groupIds": [
				"KpIXHYdXXRSr5zW4oi4lx"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					385.27675357297846,
					-134.46539468465812
				]
			]
		},
		{
			"type": "arrow",
			"version": 418,
			"versionNonce": 107537615,
			"isDeleted": false,
			"id": "8k4XYaqBBvwddjEQQpCmB",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 4351.700238677635,
			"y": -209.6862666346749,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 389.0913896632228,
			"height": 103.94845147896683,
			"seed": 1384026369,
			"groupIds": [
				"KpIXHYdXXRSr5zW4oi4lx"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					389.0913896632228,
					-103.94845147896683
				]
			]
		},
		{
			"type": "arrow",
			"version": 412,
			"versionNonce": 480236449,
			"isDeleted": false,
			"id": "CzQ7bR45qWe8xWnsgTW9Y",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 4352.653879510663,
			"y": -145.79138496607607,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 385.2768263311102,
			"height": 93.45818404126192,
			"seed": 291948769,
			"groupIds": [
				"KpIXHYdXXRSr5zW4oi4lx"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					385.2768263311102,
					-93.45818404126192
				]
			]
		},
		{
			"type": "arrow",
			"version": 793,
			"versionNonce": 1555133167,
			"isDeleted": false,
			"id": "23RmWrrZb-PlxV1pL1nDt",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 4753.141053423817,
			"y": -473.61970567132494,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 328.205421634867,
			"height": 78.19141387204877,
			"seed": 1513948353,
			"groupIds": [
				"KpIXHYdXXRSr5zW4oi4lx"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false,
			"startBinding": {
				"focus": -0.057962368735305046,
				"gap": 2.1491401991697785,
				"elementId": "KolQll1f"
			},
			"endBinding": {
				"focus": -0.1301284864825889,
				"gap": 11.071983589803494,
				"elementId": "TyGTqjLu"
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					328.205421634867,
					78.19141387204877
				]
			]
		},
		{
			"type": "arrow",
			"version": 718,
			"versionNonce": 394704769,
			"isDeleted": false,
			"id": "ZNjUJuLXuQgIXpTT2wV1z",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 4757.957454367891,
			"y": -397.57954180744764,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 323.3354646353664,
			"height": 69.66728381635153,
			"seed": 1218495649,
			"groupIds": [
				"KpIXHYdXXRSr5zW4oi4lx"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false,
			"startBinding": {
				"focus": -0.21845864906053053,
				"gap": 10.869791007488857,
				"elementId": "k4VwlHDD"
			},
			"endBinding": {
				"focus": -0.02980539506222136,
				"gap": 11.528894834962557,
				"elementId": "t1CGJooM"
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					323.3354646353664,
					69.66728381635153
				]
			]
		},
		{
			"type": "arrow",
			"version": 708,
			"versionNonce": 318979343,
			"isDeleted": false,
			"id": "WGQvpJb6c8p5-6OeDHvn0",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 4764.565073466536,
			"y": -314.1617951484818,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 312.4909514953056,
			"height": 70.12415620467112,
			"seed": 1480689793,
			"groupIds": [
				"KpIXHYdXXRSr5zW4oi4lx"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false,
			"startBinding": {
				"focus": 0.40169932126302055,
				"gap": 1.9270744977707963,
				"elementId": "8RfTe8Tok7IDP0qpJVe3b"
			},
			"endBinding": {
				"focus": -0.2346273153313218,
				"gap": 1.7470085085513354,
				"elementId": "L6GL8nOFsCG-_i1AD-eMc"
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					312.4909514953056,
					-70.12415620467112
				]
			]
		},
		{
			"type": "arrow",
			"version": 625,
			"versionNonce": 2141593441,
			"isDeleted": false,
			"id": "b4XMTcmLszmpIn_dyD_Ej",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 4765.5866537902475,
			"y": -237.3422873412817,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 315.7064107292731,
			"height": 79.1719525312156,
			"seed": 1658769505,
			"groupIds": [
				"KpIXHYdXXRSr5zW4oi4lx"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": {
				"focus": -0.017848396050430558,
				"gap": 11.528749318698829,
				"elementId": "t1CGJooM"
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					315.7064107292731,
					-79.1719525312156
				]
			]
		},
		{
			"type": "text",
			"version": 519,
			"versionNonce": 651705655,
			"isDeleted": false,
			"id": "KolQll1f",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4718.755813981483,
			"y": -506.20683225799263,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 32.23609924316406,
			"height": 60.417411654673245,
			"seed": 1581784129,
			"groupIds": [
				"Q5LW4rN1U9z5PiKX9ZswD"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923223,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "a",
			"rawText": "a",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "a",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 536,
			"versionNonce": 592284481,
			"isDeleted": false,
			"id": "zRi-ItBE8gI4izJ-e5bTc",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4707.131978924906,
			"y": -501.45157936764514,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 1516039201,
			"groupIds": [
				"Q5LW4rN1U9z5PiKX9ZswD"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 312,
			"versionNonce": 2143196601,
			"isDeleted": false,
			"id": "VdgWngCj",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4530.429959980813,
			"y": 43.54713241603463,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 283.1759033203125,
			"height": 90,
			"seed": 1057800193,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923223,
			"link": null,
			"locked": false,
			"fontSize": 36,
			"fontFamily": 1,
			"text": "write operation \naddress (d)",
			"rawText": "write operation \naddress (d)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "write operation \naddress (d)",
			"lineHeight": 1.25
		},
		{
			"type": "text",
			"version": 818,
			"versionNonce": 1365868119,
			"isDeleted": false,
			"id": "fmdg1zZu",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4332.367192247244,
			"y": -594.4041689945409,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 32.23609924316406,
			"height": 60.417411654673245,
			"seed": 1247221729,
			"groupIds": [
				"LYzEF5Bh_TmDPxCVZVj6k"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923223,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "a",
			"rawText": "a",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "a",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 840,
			"versionNonce": 731186031,
			"isDeleted": false,
			"id": "j3McanYdIlQ6ei4TlQq9u",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4320.743357190668,
			"y": -589.6489161041934,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 1313567681,
			"groupIds": [
				"LYzEF5Bh_TmDPxCVZVj6k"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1018,
			"versionNonce": 1924495001,
			"isDeleted": false,
			"id": "Z86A5THK",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4338.5360123594255,
			"y": -530.5981259165251,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 24.5516357421875,
			"height": 60.417411654673245,
			"seed": 789140385,
			"groupIds": [
				"APCHnT0_sFviPZBfH6cpN"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923223,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "b",
			"rawText": "b",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "b",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1025,
			"versionNonce": 1344322959,
			"isDeleted": false,
			"id": "2cIE6S8SHLMEIReaAXYmd",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4321.988987699482,
			"y": -531.9967191800238,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 549468033,
			"groupIds": [
				"APCHnT0_sFviPZBfH6cpN"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1051,
			"versionNonce": 1450548087,
			"isDeleted": false,
			"id": "VFMs5cjr",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4338.5360123594255,
			"y": -472.4162522482013,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 24.26165771484375,
			"height": 60.417411654673245,
			"seed": 632266593,
			"groupIds": [
				"SMXnGoaNvnOdythDInj_K"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923223,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "c",
			"rawText": "c",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "c",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1061,
			"versionNonce": 2070950831,
			"isDeleted": false,
			"id": "oHIddZhV1r1FSmVm1F3RL",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4321.988987699482,
			"y": -473.8148455117,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 1277627201,
			"groupIds": [
				"SMXnGoaNvnOdythDInj_K"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1140,
			"versionNonce": 702364537,
			"isDeleted": false,
			"id": "ghR9oUyI",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4338.5360123594255,
			"y": -414.23443406638285,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 27.499771118164062,
			"height": 60.417411654673245,
			"seed": 746978081,
			"groupIds": [
				"AHeOsuw1S4E8zSYPZlkZ3"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923223,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "d",
			"rawText": "d",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "d",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1150,
			"versionNonce": 363587023,
			"isDeleted": false,
			"id": "U40OZ-2p3-tlE_8QYYCeO",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4321.988987699482,
			"y": -415.63302732988154,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 658239233,
			"groupIds": [
				"AHeOsuw1S4E8zSYPZlkZ3"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1101,
			"versionNonce": 1514214551,
			"isDeleted": false,
			"id": "pMzgVWQL",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4338.5360123594255,
			"y": -353.1435138781728,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 26.436508178710938,
			"height": 60.417411654673245,
			"seed": 1657300705,
			"groupIds": [
				"HIQwEeqVxuVFm1JLiFlj6"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923223,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "e",
			"rawText": "e",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "e",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1108,
			"versionNonce": 1844204527,
			"isDeleted": false,
			"id": "sP6Ed71clFYadIAgvp_iy",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4321.988987699482,
			"y": -354.5421071416715,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 163242689,
			"groupIds": [
				"HIQwEeqVxuVFm1JLiFlj6"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1132,
			"versionNonce": 897147993,
			"isDeleted": false,
			"id": "dpSJ0t6t",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4338.5360123594255,
			"y": -296.41627444280334,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 23.488372802734375,
			"height": 60.417411654673245,
			"seed": 1219682977,
			"groupIds": [
				"N3MTzigoUkDv1aa9Kugu5"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923223,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "f",
			"rawText": "f",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "f",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1139,
			"versionNonce": 1547304463,
			"isDeleted": false,
			"id": "TBPFHkFkIsF21hsDALCwU",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4321.988987699482,
			"y": -297.81486770630204,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 207611521,
			"groupIds": [
				"N3MTzigoUkDv1aa9Kugu5"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1159,
			"versionNonce": 75524535,
			"isDeleted": false,
			"id": "1XY9Ctal",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4338.5360123594255,
			"y": -233.87083099464985,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 24.21331787109375,
			"height": 60.417411654673245,
			"seed": 2139188833,
			"groupIds": [
				"6LURGncWdCT_6Ukv2NAB7"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923223,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "g",
			"rawText": "g",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "g",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1166,
			"versionNonce": 596468783,
			"isDeleted": false,
			"id": "_T07OTK_YcCbsz22xdJEV",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4321.988987699482,
			"y": -235.26942425814855,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 1223096897,
			"groupIds": [
				"6LURGncWdCT_6Ukv2NAB7"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1195,
			"versionNonce": 1365078329,
			"isDeleted": false,
			"id": "GhwmNIlo",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4338.5360123594255,
			"y": -172.77996629294535,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 23.875015258789062,
			"height": 60.417411654673245,
			"seed": 158337569,
			"groupIds": [
				"t-MWv-1Pa1fcZaGWz5os0"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923223,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "h",
			"rawText": "h",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "h",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1202,
			"versionNonce": 332334671,
			"isDeleted": false,
			"id": "1eV0kBQ2NgfAbNs5hAksH",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4321.988987699482,
			"y": -174.17855955644404,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 437001729,
			"groupIds": [
				"t-MWv-1Pa1fcZaGWz5os0"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 435,
			"versionNonce": 307763927,
			"isDeleted": false,
			"id": "KV4QRbjT",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4604.380500659065,
			"y": 197.11967791166512,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 188.9366455078125,
			"height": 346.808897217726,
			"seed": 163231201,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923223,
			"link": null,
			"locked": false,
			"fontSize": 277.4471177741808,
			"fontFamily": 1,
			"text": "3",
			"rawText": "3",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "3",
			"lineHeight": 1.25
		},
		{
			"type": "text",
			"version": 1072,
			"versionNonce": 928825433,
			"isDeleted": false,
			"id": "k4VwlHDD",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4722.536027618215,
			"y": -425.5980789664049,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 24.5516357421875,
			"height": 60.417411654673245,
			"seed": 1535857089,
			"groupIds": [
				"sgd1hIUbqvHm3yuR89n5i"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720989171328,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "b",
			"rawText": "b",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "b",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1079,
			"versionNonce": 1987398969,
			"isDeleted": false,
			"id": "TxFRF0Q82z-TlTiblwq5W",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4705.989002958272,
			"y": -426.9966722299036,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 77427105,
			"groupIds": [
				"sgd1hIUbqvHm3yuR89n5i"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720989171328,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1100,
			"versionNonce": 677160951,
			"isDeleted": false,
			"id": "qFKxXCq6",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4722.536005178818,
			"y": -346.29859082816455,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 24.26165771484375,
			"height": 60.417411654673245,
			"seed": 706778497,
			"groupIds": [
				"xNc7JAIAn24pS8_FKz8w0"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923223,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "c",
			"rawText": "c",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "c",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1112,
			"versionNonce": 1978742241,
			"isDeleted": false,
			"id": "8RfTe8Tok7IDP0qpJVe3b",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4705.988980518876,
			"y": -347.69718409166325,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 525614433,
			"groupIds": [
				"xNc7JAIAn24pS8_FKz8w0"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1175,
			"versionNonce": 387659513,
			"isDeleted": false,
			"id": "TyGTqjLu",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5092.418458648487,
			"y": -424.4162666094145,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 24.26165771484375,
			"height": 60.417411654673245,
			"seed": 596109633,
			"groupIds": [
				"UdKlYDCG-ZSXsBFnFpaXi"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923223,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "c",
			"rawText": "c",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "c",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1182,
			"versionNonce": 2096222657,
			"isDeleted": false,
			"id": "L6GL8nOFsCG-_i1AD-eMc",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5075.871433988545,
			"y": -425.8148598729132,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 1612388641,
			"groupIds": [
				"UdKlYDCG-ZSXsBFnFpaXi"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false
		},
		{
			"type": "arrow",
			"version": 94,
			"versionNonce": 1280878383,
			"isDeleted": false,
			"id": "rNaVNtTahlEsp8xxde1OF",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5037.042999078582,
			"y": -333.9401196725432,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 265.142822265625,
			"height": 58.28569684709822,
			"seed": 645745921,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "UL9iklJc"
				}
			],
			"updated": 1714387322271,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": {
				"focus": -0.06769765415642912,
				"gap": 9.36547190551978,
				"elementId": "TxFRF0Q82z-TlTiblwq5W"
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-265.142822265625,
					-58.28569684709822
				]
			]
		},
		{
			"type": "text",
			"version": 3,
			"versionNonce": 905027855,
			"isDeleted": false,
			"id": "UL9iklJc",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 4899.593589593719,
			"y": -385.58296809609226,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 19.40625,
			"height": 45,
			"seed": 2029351905,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714387321280,
			"link": null,
			"locked": false,
			"fontSize": 36,
			"fontFamily": 1,
			"text": "1",
			"rawText": "1",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "rNaVNtTahlEsp8xxde1OF",
			"originalText": "1",
			"lineHeight": 1.25
		},
		{
			"type": "text",
			"version": 1231,
			"versionNonce": 1687326999,
			"isDeleted": false,
			"id": "t1CGJooM",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5092.82181383822,
			"y": -353.66297061772207,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 27.499771118164062,
			"height": 60.417411654673245,
			"seed": 1848509665,
			"groupIds": [
				"Zhj-tWY7QV78KsADayJ4g"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923223,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "d",
			"rawText": "d",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "d",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1240,
			"versionNonce": 1568027887,
			"isDeleted": false,
			"id": "edhi-PacUjhQRNkpRUvh-",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5076.2747891782765,
			"y": -355.06156388122076,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 314360001,
			"groupIds": [
				"Zhj-tWY7QV78KsADayJ4g"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false
		},
		{
			"type": "arrow",
			"version": 57,
			"versionNonce": 1045315233,
			"isDeleted": false,
			"id": "w2-BAC6QMoRc0KdIOcqku",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5301.043068833047,
			"y": -314.5115395246637,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 155.42864118303623,
			"height": 3.4285627092633604,
			"seed": 1372127393,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "L9HdyayP"
				}
			],
			"updated": 1714387323356,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": {
				"focus": 0.2694563389884833,
				"gap": 13.171055511768007,
				"elementId": "edhi-PacUjhQRNkpRUvh-"
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-155.42864118303623,
					-3.4285627092633604
				]
			]
		},
		{
			"type": "text",
			"version": 2,
			"versionNonce": 110214849,
			"isDeleted": false,
			"id": "L9HdyayP",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5210.512753978834,
			"y": -338.7258208792954,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 19.40625,
			"height": 45,
			"seed": 384690031,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714387323240,
			"link": null,
			"locked": false,
			"fontSize": 36,
			"fontFamily": 1,
			"text": "2",
			"rawText": "2",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "w2-BAC6QMoRc0KdIOcqku",
			"originalText": "2",
			"lineHeight": 1.25
		},
		{
			"type": "rectangle",
			"version": 551,
			"versionNonce": 444945217,
			"isDeleted": false,
			"id": "iDp7jsbtZ9Yr957LyIiAw",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5701.341063566893,
			"y": -593.9623708184793,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 101.1608273043898,
			"height": 473.6684207040644,
			"seed": 1824676609,
			"groupIds": [
				"n8leYzWgfzjhMvRl3rX9b"
			],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "GWzgo106XqXO3jpxy5BeY",
					"type": "arrow"
				}
			],
			"updated": 1714386900087,
			"link": null,
			"locked": false
		},
		{
			"type": "line",
			"version": 567,
			"versionNonce": 2085272929,
			"isDeleted": false,
			"id": "9iW60Wp2pyS5U2qSm5eNw",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5812.240656588154,
			"y": -536.659938833167,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 77681377,
			"groupIds": [
				"n8leYzWgfzjhMvRl3rX9b"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 593,
			"versionNonce": 1356006703,
			"isDeleted": false,
			"id": "tuAlErD8giYsvIncvd54d",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5812.240656588154,
			"y": -477.92517557281644,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 1503022785,
			"groupIds": [
				"n8leYzWgfzjhMvRl3rX9b"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 597,
			"versionNonce": 497969473,
			"isDeleted": false,
			"id": "6V2M8aCKwBnB6vXmDcN8X",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5812.240656588154,
			"y": -416.58001932827324,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 1648414369,
			"groupIds": [
				"n8leYzWgfzjhMvRl3rX9b"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 623,
			"versionNonce": 699959119,
			"isDeleted": false,
			"id": "zQawNP54FWhd6idS8SpoJ",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5812.240656588154,
			"y": -357.8452560679227,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 357585537,
			"groupIds": [
				"n8leYzWgfzjhMvRl3rX9b"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 616,
			"versionNonce": 1366399265,
			"isDeleted": false,
			"id": "s0GfM3HdUmWSH8CuN9Dgw",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5812.240656588154,
			"y": -297.80534610553036,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 1736727137,
			"groupIds": [
				"n8leYzWgfzjhMvRl3rX9b"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 642,
			"versionNonce": 1793639791,
			"isDeleted": false,
			"id": "3cp3-n-3bzoA_Z7LS5T4C",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5812.240656588154,
			"y": -239.07058284517984,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 162293313,
			"groupIds": [
				"n8leYzWgfzjhMvRl3rX9b"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 646,
			"versionNonce": 688114945,
			"isDeleted": false,
			"id": "NNORlldcuYDvGk2Kdp4Qh",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5812.240656588154,
			"y": -177.7254266006364,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 122.6903124890867,
			"height": 0,
			"seed": 1722283553,
			"groupIds": [
				"n8leYzWgfzjhMvRl3rX9b"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-122.6903124890867,
					0
				]
			]
		},
		{
			"type": "rectangle",
			"version": 760,
			"versionNonce": 299837455,
			"isDeleted": false,
			"id": "zZVv3lJb63FZ99u38OlPF",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 6100.666406269127,
			"y": -515.7626220009972,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 66.88541640049824,
			"height": 308.63805989636126,
			"seed": 1634109953,
			"groupIds": [
				"n8leYzWgfzjhMvRl3rX9b"
			],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "2FJ7yKKarFrBQsuh6f0SD",
					"type": "arrow"
				},
				{
					"id": "d98VT2SxXAWq25lFe-O9Z",
					"type": "arrow"
				},
				{
					"id": "GWzgo106XqXO3jpxy5BeY",
					"type": "arrow"
				},
				{
					"id": "r5yLmUribZVpRd-zZudzm",
					"type": "arrow"
				}
			],
			"updated": 1714386864612,
			"link": null,
			"locked": false
		},
		{
			"type": "line",
			"version": 776,
			"versionNonce": 1541702881,
			"isDeleted": false,
			"id": "DfxTmRit0jSfbEtK6KZd0",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 6170.453317088388,
			"y": -435.1856117529137,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 75.33717800129428,
			"height": 0,
			"seed": 1390911969,
			"groupIds": [
				"n8leYzWgfzjhMvRl3rX9b"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-75.33717800129428,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 819,
			"versionNonce": 641430959,
			"isDeleted": false,
			"id": "1FVw0Z5VK3g0rJVTHUTye",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 6170.453317088388,
			"y": -364.88132037059927,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 75.33717800129428,
			"height": 0,
			"seed": 1211809217,
			"groupIds": [
				"n8leYzWgfzjhMvRl3rX9b"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-75.33717800129428,
					0
				]
			]
		},
		{
			"type": "line",
			"version": 811,
			"versionNonce": 94585025,
			"isDeleted": false,
			"id": "HrcObfi96cbyujPFo9_Dp",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 6171.4070306795475,
			"y": -279.11587292806803,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 75.33717800129428,
			"height": 0,
			"seed": 8347041,
			"groupIds": [
				"n8leYzWgfzjhMvRl3rX9b"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-75.33717800129428,
					0
				]
			]
		},
		{
			"type": "rectangle",
			"version": 880,
			"versionNonce": 2035203809,
			"isDeleted": false,
			"id": "Q84HK2O0I0q-ENzsWsFCm",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 6469.7310110271665,
			"y": -431.8409918062803,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 66.88541640049824,
			"height": 137.9337314915794,
			"seed": 719651201,
			"groupIds": [
				"n8leYzWgfzjhMvRl3rX9b"
			],
			"frameId": null,
			"roundness": {
				"type": 3
			},
			"boundElements": [
				{
					"id": "r5yLmUribZVpRd-zZudzm",
					"type": "arrow"
				},
				{
					"id": "d98VT2SxXAWq25lFe-O9Z",
					"type": "arrow"
				}
			],
			"updated": 1714386859694,
			"link": null,
			"locked": false
		},
		{
			"type": "line",
			"version": 852,
			"versionNonce": 601850017,
			"isDeleted": false,
			"id": "UvivJTPmKhX8U3P3HLVu1",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 6540.471562679455,
			"y": -362.0203614924487,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 75.33717800129428,
			"height": 0,
			"seed": 1688938849,
			"groupIds": [
				"n8leYzWgfzjhMvRl3rX9b"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					-75.33717800129428,
					0
				]
			]
		},
		{
			"type": "arrow",
			"version": 491,
			"versionNonce": 743380463,
			"isDeleted": false,
			"id": "6Q4_IxERA6vxmT3KirMNq",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 5753.801821807505,
			"y": -563.4924361689341,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 377.64755415062143,
			"height": 91.55093875427153,
			"seed": 1998673217,
			"groupIds": [
				"n8leYzWgfzjhMvRl3rX9b"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					377.64755415062143,
					91.55093875427153
				]
			]
		},
		{
			"type": "arrow",
			"version": 719,
			"versionNonce": 1414055041,
			"isDeleted": false,
			"id": "kzo9oyJWKfFLbr_HZM6kg",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 5763.3847940882715,
			"y": -501.4960334286313,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 370.92557712707105,
			"height": 101.07868986305633,
			"seed": 1437009185,
			"groupIds": [
				"n8leYzWgfzjhMvRl3rX9b"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "6Yl31jmu",
				"focus": -0.1567471477612303,
				"gap": 2.96383978006088
			},
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					370.92557712707105,
					101.07868986305633
				]
			]
		},
		{
			"type": "arrow",
			"version": 605,
			"versionNonce": 83132431,
			"isDeleted": false,
			"id": "mbXs_V-lTb1J8ktX1x8aL",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 5754.755462640533,
			"y": -441.42455420897113,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 382.41583107389397,
			"height": 122.06791833902864,
			"seed": 1537980673,
			"groupIds": [
				"n8leYzWgfzjhMvRl3rX9b"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					382.41583107389397,
					122.06791833902864
				]
			]
		},
		{
			"type": "arrow",
			"version": 664,
			"versionNonce": 1386122337,
			"isDeleted": false,
			"id": "nkj9ugPFUbbB_5LqRY9UA",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 5750.940862929354,
			"y": -381.3442722515508,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 384.3231491190162,
			"height": 136.37274910884614,
			"seed": 1252978913,
			"groupIds": [
				"n8leYzWgfzjhMvRl3rX9b"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					384.3231491190162,
					136.37274910884614
				]
			]
		},
		{
			"type": "arrow",
			"version": 487,
			"versionNonce": 363308591,
			"isDeleted": false,
			"id": "F5hCFNKhXU99lcHV0Mekh",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 5750.940862929354,
			"y": -322.217594748093,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 379.55487219574377,
			"height": 147.81658462144748,
			"seed": 138423489,
			"groupIds": [
				"n8leYzWgfzjhMvRl3rX9b"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					379.55487219574377,
					-147.81658462144748
				]
			]
		},
		{
			"type": "arrow",
			"version": 458,
			"versionNonce": 917526593,
			"isDeleted": false,
			"id": "TxDyvR2UlGJXOFGRbpizA",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 5749.0335448842325,
			"y": -264.99830804788894,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 385.27675357297846,
			"height": 134.46539468465812,
			"seed": 469691553,
			"groupIds": [
				"n8leYzWgfzjhMvRl3rX9b"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					385.27675357297846,
					-134.46539468465812
				]
			]
		},
		{
			"type": "arrow",
			"version": 458,
			"versionNonce": 223414351,
			"isDeleted": false,
			"id": "4O4nsd0nxnSx23VC6sj-e",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 5749.0335448842325,
			"y": -209.6862666346749,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 389.0913896632228,
			"height": 103.94845147896683,
			"seed": 1838854273,
			"groupIds": [
				"n8leYzWgfzjhMvRl3rX9b"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					389.0913896632228,
					-103.94845147896683
				]
			]
		},
		{
			"type": "arrow",
			"version": 452,
			"versionNonce": 1918740513,
			"isDeleted": false,
			"id": "2O17oQERD-OlfK86_7VmG",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 5749.98718571726,
			"y": -145.79138496607607,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 385.2768263311102,
			"height": 93.45818404126192,
			"seed": 1121122401,
			"groupIds": [
				"n8leYzWgfzjhMvRl3rX9b"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					385.2768263311102,
					-93.45818404126192
				]
			]
		},
		{
			"type": "arrow",
			"version": 916,
			"versionNonce": 701048431,
			"isDeleted": false,
			"id": "EPXdhTQPbm-PwVJ7YRcCw",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 6150.474359630414,
			"y": -473.61970567132494,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 328.205421634867,
			"height": 78.19141387204877,
			"seed": 2104968257,
			"groupIds": [
				"n8leYzWgfzjhMvRl3rX9b"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "NqHiq2rb",
				"focus": -0.057962368735305046,
				"gap": 2.1491401991697785
			},
			"endBinding": {
				"elementId": "xH2pa6ns",
				"focus": -0.1301284864825889,
				"gap": 11.071983589803494
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					328.205421634867,
					78.19141387204877
				]
			]
		},
		{
			"type": "arrow",
			"version": 843,
			"versionNonce": 727955617,
			"isDeleted": false,
			"id": "Fkvx6CU2Yy4azyKsg0BlA",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 6155.290760574489,
			"y": -397.57954180744764,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 323.3354646353664,
			"height": 69.66728381635153,
			"seed": 426185761,
			"groupIds": [
				"n8leYzWgfzjhMvRl3rX9b"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386662735,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "cAkETkYF",
				"focus": -0.21845864906053053,
				"gap": 10.869791007488857
			},
			"endBinding": {
				"elementId": "I5XSbele",
				"focus": -0.030982143569436158,
				"gap": 11.376434827521734
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					323.3354646353664,
					69.66728381635153
				]
			]
		},
		{
			"type": "arrow",
			"version": 831,
			"versionNonce": 1507360911,
			"isDeleted": false,
			"id": "G4Y82mc4WOONKNL6XD0iY",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 6161.898379673134,
			"y": -314.1617951484818,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 312.4909514953056,
			"height": 70.12415620467112,
			"seed": 1787947009,
			"groupIds": [
				"n8leYzWgfzjhMvRl3rX9b"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386616833,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "0fQp1bsAiZybtciSNAAPA",
				"focus": 0.40169932126302055,
				"gap": 1.9270744977707963
			},
			"endBinding": {
				"elementId": "PbKZ1awAT3eemFFVwhtYW",
				"focus": -0.2346273153313218,
				"gap": 1.7470085085513354
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					312.4909514953056,
					-70.12415620467112
				]
			]
		},
		{
			"type": "arrow",
			"version": 712,
			"versionNonce": 7652449,
			"isDeleted": false,
			"id": "lrPd2sLVRp5hmEsqFZM9O",
			"fillStyle": "solid",
			"strokeWidth": 2,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 20,
			"angle": 0,
			"x": 6164.421150202108,
			"y": -237.4723459742583,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 314.20522052401066,
			"height": 79.02338131180267,
			"seed": 452411361,
			"groupIds": [
				"n8leYzWgfzjhMvRl3rX9b"
			],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [],
			"updated": 1714386662735,
			"link": null,
			"locked": false,
			"startBinding": {
				"focus": 0.3567513247790302,
				"gap": 1,
				"elementId": "vXwv0Q0IwgIpCDv2zvqx3"
			},
			"endBinding": {
				"elementId": "I5XSbele",
				"focus": -0.04653121058966967,
				"gap": 11.376289311258006
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					314.20522052401066,
					-79.02338131180267
				]
			]
		},
		{
			"type": "text",
			"version": 559,
			"versionNonce": 1349251033,
			"isDeleted": false,
			"id": "NqHiq2rb",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 6116.08912018808,
			"y": -506.20683225799263,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 32.23609924316406,
			"height": 60.417411654673245,
			"seed": 599751585,
			"groupIds": [
				"xz8V6LaDCbgwuaRaV-bz3"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [
				{
					"id": "EPXdhTQPbm-PwVJ7YRcCw",
					"type": "arrow"
				}
			],
			"updated": 1720988923223,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "a",
			"rawText": "a",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "a",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 576,
			"versionNonce": 1119203265,
			"isDeleted": false,
			"id": "lxx51QNTRgH8qoj4WISSB",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 6104.465285131504,
			"y": -501.45157936764514,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 1819369345,
			"groupIds": [
				"xz8V6LaDCbgwuaRaV-bz3"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616834,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 371,
			"versionNonce": 812537399,
			"isDeleted": false,
			"id": "XBA8Jx78",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5927.76326618741,
			"y": 43.54713241603463,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 363.1318359375,
			"height": 90,
			"seed": 821806945,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923223,
			"link": null,
			"locked": false,
			"fontSize": 36,
			"fontFamily": 1,
			"text": "read operation \naddress (h) (trickey)",
			"rawText": "read operation \naddress (h) (trickey)",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "read operation \naddress (h) (trickey)",
			"lineHeight": 1.25
		},
		{
			"type": "text",
			"version": 858,
			"versionNonce": 351440057,
			"isDeleted": false,
			"id": "KAn93ncr",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5729.700498453842,
			"y": -594.4041689945409,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 32.23609924316406,
			"height": 60.417411654673245,
			"seed": 1960193249,
			"groupIds": [
				"8YsZFbDC929z_B4Hh9e78"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923223,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "a",
			"rawText": "a",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "a",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 880,
			"versionNonce": 1534523119,
			"isDeleted": false,
			"id": "ZeUZTGblB2-V156ivQsr0",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5718.076663397265,
			"y": -589.6489161041934,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 1646258369,
			"groupIds": [
				"8YsZFbDC929z_B4Hh9e78"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616834,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1058,
			"versionNonce": 1389655895,
			"isDeleted": false,
			"id": "6Yl31jmu",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5735.869318566023,
			"y": -530.5981259165251,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 24.5516357421875,
			"height": 60.417411654673245,
			"seed": 1099517025,
			"groupIds": [
				"cg3S9CcMyxO43PVlpMFvO"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [
				{
					"id": "kzo9oyJWKfFLbr_HZM6kg",
					"type": "arrow"
				}
			],
			"updated": 1720988923223,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "b",
			"rawText": "b",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "b",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1065,
			"versionNonce": 645415183,
			"isDeleted": false,
			"id": "q85ouLKyLRXpKDnmFD5wa",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5719.32229390608,
			"y": -531.9967191800238,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 2051217473,
			"groupIds": [
				"cg3S9CcMyxO43PVlpMFvO"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616834,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1091,
			"versionNonce": 1280478617,
			"isDeleted": false,
			"id": "76SuwVjb",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5735.869318566023,
			"y": -472.4162522482013,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 24.26165771484375,
			"height": 60.417411654673245,
			"seed": 1740805569,
			"groupIds": [
				"PpubS4z1S_JN4pvxsDlFT"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923224,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "c",
			"rawText": "c",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "c",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1101,
			"versionNonce": 856377135,
			"isDeleted": false,
			"id": "msaURbG0uC6jKlh5ABKWj",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5719.32229390608,
			"y": -473.8148455117,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 290207137,
			"groupIds": [
				"PpubS4z1S_JN4pvxsDlFT"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616834,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1180,
			"versionNonce": 1108964471,
			"isDeleted": false,
			"id": "MTjJ6RRP",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5735.869318566023,
			"y": -414.23443406638285,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 27.499771118164062,
			"height": 60.417411654673245,
			"seed": 1879453857,
			"groupIds": [
				"ns4Kleil2T1-qOV9dLyoU"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923224,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "d",
			"rawText": "d",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "d",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1190,
			"versionNonce": 1603832143,
			"isDeleted": false,
			"id": "YAF1WJaKqEUPBGxea08pb",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5719.32229390608,
			"y": -415.63302732988154,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 1209627777,
			"groupIds": [
				"ns4Kleil2T1-qOV9dLyoU"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616834,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1141,
			"versionNonce": 499085945,
			"isDeleted": false,
			"id": "A6ryhIwC",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5735.869318566023,
			"y": -353.1435138781728,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 26.436508178710938,
			"height": 60.417411654673245,
			"seed": 2099411937,
			"groupIds": [
				"k5MdTJGU2uwCPMJYj_9Wt"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923224,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "e",
			"rawText": "e",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "e",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1148,
			"versionNonce": 695764847,
			"isDeleted": false,
			"id": "9IaDg4_Ox2bEvD8YZE1lA",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5719.32229390608,
			"y": -354.5421071416715,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 1510627265,
			"groupIds": [
				"k5MdTJGU2uwCPMJYj_9Wt"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616834,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1172,
			"versionNonce": 906087831,
			"isDeleted": false,
			"id": "M81cZBl1",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5735.869318566023,
			"y": -296.41627444280334,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 23.488372802734375,
			"height": 60.417411654673245,
			"seed": 692828065,
			"groupIds": [
				"JJqjgeNe1kjXTu2A3j0VH"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923224,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "f",
			"rawText": "f",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "f",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1179,
			"versionNonce": 1324597647,
			"isDeleted": false,
			"id": "tw7yXBIHMm8eOrIeTFa5n",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5719.32229390608,
			"y": -297.81486770630204,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 1830165377,
			"groupIds": [
				"JJqjgeNe1kjXTu2A3j0VH"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616834,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1199,
			"versionNonce": 2113715033,
			"isDeleted": false,
			"id": "89jiOMrK",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5735.869318566023,
			"y": -233.87083099464985,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 24.21331787109375,
			"height": 60.417411654673245,
			"seed": 900268897,
			"groupIds": [
				"76TOA5B4FUByoM_bsBzmF"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923224,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "g",
			"rawText": "g",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "g",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1206,
			"versionNonce": 826455983,
			"isDeleted": false,
			"id": "V6CZwD2JDlNJ8VsC5sxa6",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5719.32229390608,
			"y": -235.26942425814855,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 1599336257,
			"groupIds": [
				"76TOA5B4FUByoM_bsBzmF"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616834,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1237,
			"versionNonce": 2042757815,
			"isDeleted": false,
			"id": "0EbYQ1KD",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5735.869318566023,
			"y": -172.77996629294535,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 23.875015258789062,
			"height": 60.417411654673245,
			"seed": 1618421039,
			"groupIds": [
				"RGSi1SVCTfh_atOBmw6ha"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923224,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "h",
			"rawText": "h",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "h",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1246,
			"versionNonce": 1601863265,
			"isDeleted": false,
			"id": "_rsn3B6O5-HpWVw7NI6wM",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5719.32229390608,
			"y": -174.17855955644404,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 1876469583,
			"groupIds": [
				"RGSi1SVCTfh_atOBmw6ha"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [
				{
					"id": "2FJ7yKKarFrBQsuh6f0SD",
					"type": "arrow"
				}
			],
			"updated": 1714386801424,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 477,
			"versionNonce": 2103306297,
			"isDeleted": false,
			"id": "rL1xPemk",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 6001.713806865662,
			"y": 197.11967791166512,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 177.5615997314453,
			"height": 346.808897217726,
			"seed": 1755749313,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923224,
			"link": null,
			"locked": false,
			"fontSize": 277.4471177741808,
			"fontFamily": 1,
			"text": "4",
			"rawText": "4",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "4",
			"lineHeight": 1.25
		},
		{
			"type": "text",
			"version": 1108,
			"versionNonce": 2113835991,
			"isDeleted": false,
			"id": "cAkETkYF",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 6119.869333824812,
			"y": -425.598125916525,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 24.5516357421875,
			"height": 60.417411654673245,
			"seed": 134075727,
			"groupIds": [
				"S072WJJqdn4c6F03YCC81"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [
				{
					"id": "Fkvx6CU2Yy4azyKsg0BlA",
					"type": "arrow"
				}
			],
			"updated": 1720988923224,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "b",
			"rawText": "b",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "b",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1116,
			"versionNonce": 1953440385,
			"isDeleted": false,
			"id": "tDAM96IB0EfJZnTgClu3x",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 6103.32230916487,
			"y": -426.9967191800237,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 794055535,
			"groupIds": [
				"S072WJJqdn4c6F03YCC81"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386616834,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1140,
			"versionNonce": 1439070489,
			"isDeleted": false,
			"id": "agRBj7LL",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 6119.869311385416,
			"y": -346.29859082816455,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 24.26165771484375,
			"height": 60.417411654673245,
			"seed": 656306127,
			"groupIds": [
				"3wj0jGWr6Krl2SCVrud7e"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923224,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "c",
			"rawText": "c",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "c",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1152,
			"versionNonce": 441002593,
			"isDeleted": false,
			"id": "0fQp1bsAiZybtciSNAAPA",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 6103.3222867254735,
			"y": -347.69718409166325,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 75341295,
			"groupIds": [
				"3wj0jGWr6Krl2SCVrud7e"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [
				{
					"id": "G4Y82mc4WOONKNL6XD0iY",
					"type": "arrow"
				}
			],
			"updated": 1714386616834,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1215,
			"versionNonce": 718012663,
			"isDeleted": false,
			"id": "xH2pa6ns",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 6489.751764855085,
			"y": -424.4162666094145,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 24.26165771484375,
			"height": 60.417411654673245,
			"seed": 830223457,
			"groupIds": [
				"HdRTnVBSRRBqrhrem6SiZ"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [
				{
					"id": "EPXdhTQPbm-PwVJ7YRcCw",
					"type": "arrow"
				},
				{
					"id": "G4Y82mc4WOONKNL6XD0iY",
					"type": "arrow"
				}
			],
			"updated": 1720988923224,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "c",
			"rawText": "c",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "c",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1222,
			"versionNonce": 727135809,
			"isDeleted": false,
			"id": "PbKZ1awAT3eemFFVwhtYW",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 6473.204740195142,
			"y": -425.8148598729132,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 999882817,
			"groupIds": [
				"HdRTnVBSRRBqrhrem6SiZ"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [
				{
					"id": "G4Y82mc4WOONKNL6XD0iY",
					"type": "arrow"
				}
			],
			"updated": 1714386616834,
			"link": null,
			"locked": false
		},
		{
			"type": "arrow",
			"version": 410,
			"versionNonce": 998947329,
			"isDeleted": false,
			"id": "2FJ7yKKarFrBQsuh6f0SD",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5780.400593173274,
			"y": -147.2672481763212,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 723.2012987946382,
			"height": 196.2246897307308,
			"seed": 693055745,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "nl8USqVf"
				}
			],
			"updated": 1714386840895,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "_rsn3B6O5-HpWVw7NI6wM",
				"focus": -0.16631279158859655,
				"gap": 4.055724366820765
			},
			"endBinding": {
				"elementId": "eJ4dYFwK0NEhIWCs6WL9Q",
				"focus": -0.8724048552145686,
				"gap": 10.481182658180643
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					573.867965461307,
					55.49070697039528
				],
				[
					723.2012987946382,
					-140.73398276033552
				]
			]
		},
		{
			"type": "text",
			"version": 3,
			"versionNonce": 1032988193,
			"isDeleted": false,
			"id": "nl8USqVf",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 6341.452564371885,
			"y": -114.27654120592592,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 19.40625,
			"height": 45,
			"seed": 90759329,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386840570,
			"link": null,
			"locked": false,
			"fontSize": 36,
			"fontFamily": 1,
			"text": "2",
			"rawText": "2",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "2FJ7yKKarFrBQsuh6f0SD",
			"originalText": "2",
			"lineHeight": 1.25
		},
		{
			"type": "arrow",
			"version": 234,
			"versionNonce": 766917313,
			"isDeleted": false,
			"id": "d98VT2SxXAWq25lFe-O9Z",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 6464.135257853329,
			"y": -302.97661444811274,
			"strokeColor": "#2f9e44",
			"backgroundColor": "transparent",
			"width": 285.86653645833394,
			"height": 71.4666748046875,
			"seed": 1609901327,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "RX4uiHcK"
				}
			],
			"updated": 1714386859695,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "Q84HK2O0I0q-ENzsWsFCm",
				"focus": -0.6483833031919831,
				"gap": 5.595753173838148
			},
			"endBinding": {
				"elementId": "zZVv3lJb63FZ99u38OlPF",
				"focus": 0.8665712454406302,
				"gap": 10.716898725369447
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-285.86653645833394,
					71.4666748046875
				]
			]
		},
		{
			"type": "text",
			"version": 3,
			"versionNonce": 1625987503,
			"isDeleted": false,
			"id": "RX4uiHcK",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 6308.615261210262,
			"y": -294.0099599884773,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 19.40625,
			"height": 45,
			"seed": 1901736929,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386851626,
			"link": null,
			"locked": false,
			"fontSize": 36,
			"fontFamily": 1,
			"text": "4",
			"rawText": "4",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "d98VT2SxXAWq25lFe-O9Z",
			"originalText": "4",
			"lineHeight": 1.25
		},
		{
			"type": "arrow",
			"version": 127,
			"versionNonce": 448658145,
			"isDeleted": false,
			"id": "r5yLmUribZVpRd-zZudzm",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 6456.668623738745,
			"y": -327.50993964342524,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 278.40006510416606,
			"height": 71.46667480468744,
			"seed": 1422160353,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "fWyb8tR7"
				}
			],
			"updated": 1714386867848,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "Q84HK2O0I0q-ENzsWsFCm",
				"focus": -0.30207043434979464,
				"gap": 13.062387288422087
			},
			"endBinding": {
				"elementId": "zZVv3lJb63FZ99u38OlPF",
				"focus": 0.7165957807038403,
				"gap": 10.716735964953386
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-278.40006510416606,
					71.46667480468744
				]
			]
		},
		{
			"type": "text",
			"version": 2,
			"versionNonce": 43944399,
			"isDeleted": false,
			"id": "fWyb8tR7",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 6318.457210673153,
			"y": -314.80992743639405,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 19.40625,
			"height": 45,
			"seed": 35031809,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386838013,
			"link": null,
			"locked": false,
			"fontSize": 36,
			"fontFamily": 1,
			"text": "1",
			"rawText": "1",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "r5yLmUribZVpRd-zZudzm",
			"originalText": "1",
			"lineHeight": 1.25
		},
		{
			"type": "arrow",
			"version": 219,
			"versionNonce": 850733761,
			"isDeleted": false,
			"id": "GWzgo106XqXO3jpxy5BeY",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 6090.80176175958,
			"y": -264.5766307241543,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 282.6666259765634,
			"height": 105.60001627604186,
			"seed": 208606799,
			"groupIds": [],
			"frameId": null,
			"roundness": {
				"type": 2
			},
			"boundElements": [
				{
					"type": "text",
					"id": "6Unj4FJU"
				}
			],
			"updated": 1714386901055,
			"link": null,
			"locked": false,
			"startBinding": {
				"elementId": "zZVv3lJb63FZ99u38OlPF",
				"focus": -0.6776817515449003,
				"gap": 9.864644509547816
			},
			"endBinding": {
				"elementId": "iDp7jsbtZ9Yr957LyIiAw",
				"focus": -0.13314444078188326,
				"gap": 5.633244911733527
			},
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": "arrow",
			"points": [
				[
					0,
					0
				],
				[
					-282.6666259765634,
					-105.60001627604186
				]
			]
		},
		{
			"type": "text",
			"version": 2,
			"versionNonce": 1915836769,
			"isDeleted": false,
			"id": "6Unj4FJU",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5934.543786499162,
			"y": -343.60993557441486,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 19.40625,
			"height": 45,
			"seed": 1982630607,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714386846603,
			"link": null,
			"locked": false,
			"fontSize": 36,
			"fontFamily": 1,
			"text": "3",
			"rawText": "3",
			"textAlign": "center",
			"verticalAlign": "middle",
			"containerId": "GWzgo106XqXO3jpxy5BeY",
			"originalText": "3",
			"lineHeight": 1.25
		},
		{
			"type": "text",
			"version": 1308,
			"versionNonce": 950660601,
			"isDeleted": false,
			"id": "PhKBsQ8K",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 6122.002660037377,
			"y": -267.713234522112,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 23.875015258789062,
			"height": 60.417411654673245,
			"seed": 1459092065,
			"groupIds": [
				"xq1Ij1pq_INCVk2GeoZt2"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923224,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "h",
			"rawText": "h",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "h",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1319,
			"versionNonce": 1845488911,
			"isDeleted": false,
			"id": "vXwv0Q0IwgIpCDv2zvqx3",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 6105.455635377433,
			"y": -269.11182778561067,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 162268737,
			"groupIds": [
				"xq1Ij1pq_INCVk2GeoZt2"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [
				{
					"id": "d98VT2SxXAWq25lFe-O9Z",
					"type": "arrow"
				},
				{
					"id": "GWzgo106XqXO3jpxy5BeY",
					"type": "arrow"
				}
			],
			"updated": 1714386877355,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 1391,
			"versionNonce": 1907280407,
			"isDeleted": false,
			"id": "I5XSbele",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 6490.002660037377,
			"y": -354.1132589361744,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 23.875015258789062,
			"height": 60.417411654673245,
			"seed": 276193057,
			"groupIds": [
				"vbFsKiZENRXoapL55xRrB"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [
				{
					"id": "Fkvx6CU2Yy4azyKsg0BlA",
					"type": "arrow"
				},
				{
					"id": "lrPd2sLVRp5hmEsqFZM9O",
					"type": "arrow"
				}
			],
			"updated": 1720988923224,
			"link": null,
			"locked": false,
			"fontSize": 48.333929323738595,
			"fontFamily": 1,
			"text": "h",
			"rawText": "h",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "h",
			"lineHeight": 1.25
		},
		{
			"type": "ellipse",
			"version": 1399,
			"versionNonce": 429852353,
			"isDeleted": false,
			"id": "eJ4dYFwK0NEhIWCs6WL9Q",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 6473.455635377433,
			"y": -355.5118521996731,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 57.062873441329344,
			"height": 57.062873441329344,
			"seed": 2004865793,
			"groupIds": [
				"vbFsKiZENRXoapL55xRrB"
			],
			"frameId": null,
			"roundness": null,
			"boundElements": [
				{
					"id": "2FJ7yKKarFrBQsuh6f0SD",
					"type": "arrow"
				},
				{
					"id": "lrPd2sLVRp5hmEsqFZM9O",
					"type": "arrow"
				},
				{
					"id": "d98VT2SxXAWq25lFe-O9Z",
					"type": "arrow"
				}
			],
			"updated": 1714386817872,
			"link": null,
			"locked": false
		},
		{
			"type": "text",
			"version": 717,
			"versionNonce": 1561052889,
			"isDeleted": false,
			"id": "t4mJEM31",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 6373.468509806455,
			"y": 35.82343438001192,
			"strokeColor": "#e03131",
			"backgroundColor": "transparent",
			"width": 1026.1436767578125,
			"height": 765,
			"seed": 2016465231,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923224,
			"link": null,
			"locked": false,
			"fontSize": 36,
			"fontFamily": 1,
			"text": "procedure:\n(arrows are numbered in order of operations)\n- first (h) is to be fetched to the lowest\nlevel cache\n- but there we find value (d) is stored and dirty\nso (d) needs to be evacuated (1)\n- (d) is evacuated back 1 level\n- (h) is fetched to lowest cache (2)\n- now for inclusivity's sake, (h) needs to be fetched\nto 2nd level cache, but (d) was previously evacuated \nthere\n- (d) is evacuated yet again back to 3rd level cache (3)\n- (h) is written in it's place into 2nd level cache (4)\n\nconclusion:\nwhen reading, always write to lowest level first, then\nclimb up to upper levels, evacuating as you go",
			"rawText": "procedure:\n(arrows are numbered in order of operations)\n- first (h) is to be fetched to the lowest\nlevel cache\n- but there we find value (d) is stored and dirty\nso (d) needs to be evacuated (1)\n- (d) is evacuated back 1 level\n- (h) is fetched to lowest cache (2)\n- now for inclusivity's sake, (h) needs to be fetched\nto 2nd level cache, but (d) was previously evacuated \nthere\n- (d) is evacuated yet again back to 3rd level cache (3)\n- (h) is written in it's place into 2nd level cache (4)\n\nconclusion:\nwhen reading, always write to lowest level first, then\nclimb up to upper levels, evacuating as you go",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "procedure:\n(arrows are numbered in order of operations)\n- first (h) is to be fetched to the lowest\nlevel cache\n- but there we find value (d) is stored and dirty\nso (d) needs to be evacuated (1)\n- (d) is evacuated back 1 level\n- (h) is fetched to lowest cache (2)\n- now for inclusivity's sake, (h) needs to be fetched\nto 2nd level cache, but (d) was previously evacuated \nthere\n- (d) is evacuated yet again back to 3rd level cache (3)\n- (h) is written in it's place into 2nd level cache (4)\n\nconclusion:\nwhen reading, always write to lowest level first, then\nclimb up to upper levels, evacuating as you go",
			"lineHeight": 1.25
		},
		{
			"type": "line",
			"version": 174,
			"versionNonce": 1397834479,
			"isDeleted": false,
			"id": "bS2lwm6iAPaB0OJHFcDFS",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5628.934899780406,
			"y": 1844.2236698739903,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 1278.933430989584,
			"height": 104.53336588541674,
			"seed": 2080428705,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714387650988,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					261.33333333333303,
					0
				],
				[
					261.33333333333303,
					-104.53336588541674
				],
				[
					1278.933430989584,
					-104.53336588541674
				]
			]
		},
		{
			"type": "text",
			"version": 108,
			"versionNonce": 530280247,
			"isDeleted": false,
			"id": "9MyekHQZ",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5359.334924194469,
			"y": 1765.5569218271153,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 197.02793884277344,
			"height": 45,
			"seed": 1239670497,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923224,
			"link": null,
			"locked": false,
			"fontSize": 36,
			"fontFamily": 1,
			"text": "read h op i",
			"rawText": "read h op i",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "read h op i",
			"lineHeight": 1.25
		},
		{
			"type": "text",
			"version": 123,
			"versionNonce": 1300202425,
			"isDeleted": false,
			"id": "YPH2mVea",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5349.734907918427,
			"y": 1990.3568791025064,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 197.02793884277344,
			"height": 90,
			"seed": 940589295,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923224,
			"link": null,
			"locked": false,
			"fontSize": 36,
			"fontFamily": 1,
			"text": "cache 0\nread h op i",
			"rawText": "cache 0\nread h op i",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "cache 0\nread h op i",
			"lineHeight": 1.25
		},
		{
			"type": "line",
			"version": 342,
			"versionNonce": 1233540431,
			"isDeleted": false,
			"id": "S9WUX311PNjquEeH7-lhV",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 5635.334883504364,
			"y": 2061.8236861500322,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 1278.933430989584,
			"height": 104.53336588541674,
			"seed": 1295752815,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1714387650988,
			"link": null,
			"locked": false,
			"startBinding": null,
			"endBinding": null,
			"lastCommittedPoint": null,
			"startArrowhead": null,
			"endArrowhead": null,
			"points": [
				[
					0,
					0
				],
				[
					261.33333333333303,
					0
				],
				[
					261.33333333333303,
					-104.53336588541674
				],
				[
					1278.933430989584,
					-104.53336588541674
				]
			]
		},
		{
			"type": "text",
			"version": 834,
			"versionNonce": 1861644375,
			"isDeleted": false,
			"id": "98ib66OT",
			"fillStyle": "solid",
			"strokeWidth": 4,
			"strokeStyle": "solid",
			"roughness": 1,
			"opacity": 100,
			"angle": 0,
			"x": 6668.477415126379,
			"y": -1094.729128151962,
			"strokeColor": "#1e1e1e",
			"backgroundColor": "transparent",
			"width": 940.9317016601562,
			"height": 1080,
			"seed": 1484494465,
			"groupIds": [],
			"frameId": null,
			"roundness": null,
			"boundElements": [],
			"updated": 1720988923225,
			"link": null,
			"locked": false,
			"fontSize": 36,
			"fontFamily": 1,
			"text": "order of operations:\n- system read operation address h\n- read request L0 address h\n- miss!\n- read request L1 address h\n- miss!\n- read request L3 address h\n- hit!\n\n- write request to L0 address h\n- evacuation required\n- L0 write request to L1 (evacuation)\n- L1 write done signal\n- L0 write done signal\n\n- write request to L1 address h\n- evacuation required\n- L1 write request to L3 (evacuation)\n- L3 write done signal\n- L1 write done signal\n\nas you can see we initiate a request which leads to\nanother etc., then they get executed from end to\nbeginning, until initial request is fulfilled",
			"rawText": "order of operations:\n- system read operation address h\n- read request L0 address h\n- miss!\n- read request L1 address h\n- miss!\n- read request L3 address h\n- hit!\n\n- write request to L0 address h\n- evacuation required\n- L0 write request to L1 (evacuation)\n- L1 write done signal\n- L0 write done signal\n\n- write request to L1 address h\n- evacuation required\n- L1 write request to L3 (evacuation)\n- L3 write done signal\n- L1 write done signal\n\nas you can see we initiate a request which leads to\nanother etc., then they get executed from end to\nbeginning, until initial request is fulfilled",
			"textAlign": "left",
			"verticalAlign": "top",
			"containerId": null,
			"originalText": "order of operations:\n- system read operation address h\n- read request L0 address h\n- miss!\n- read request L1 address h\n- miss!\n- read request L3 address h\n- hit!\n\n- write request to L0 address h\n- evacuation required\n- L0 write request to L1 (evacuation)\n- L1 write done signal\n- L0 write done signal\n\n- write request to L1 address h\n- evacuation required\n- L1 write request to L3 (evacuation)\n- L3 write done signal\n- L1 write done signal\n\nas you can see we initiate a request which leads to\nanother etc., then they get executed from end to\nbeginning, until initial request is fulfilled",
			"lineHeight": 1.25
		}
	],
	"appState": {
		"theme": "light",
		"viewBackgroundColor": "#ffffff",
		"currentItemStrokeColor": "#1e1e1e",
		"currentItemBackgroundColor": "transparent",
		"currentItemFillStyle": "solid",
		"currentItemStrokeWidth": 4,
		"currentItemStrokeStyle": "solid",
		"currentItemRoughness": 1,
		"currentItemOpacity": 100,
		"currentItemFontFamily": 1,
		"currentItemFontSize": 36,
		"currentItemTextAlign": "left",
		"currentItemStartArrowhead": null,
		"currentItemEndArrowhead": "arrow",
		"scrollX": -3632.199288852374,
		"scrollY": 831.6965343622858,
		"zoom": {
			"value": 0.65
		},
		"currentItemRoundness": "sharp",
		"gridSize": null,
		"gridColor": {
			"Bold": "#C9C9C9FF",
			"Regular": "#EDEDEDFF"
		},
		"currentStrokeOptions": null,
		"previousGridSize": null,
		"frameRendering": {
			"enabled": true,
			"clip": true,
			"name": true,
			"outline": true
		}
	},
	"files": {}
}
```
%%