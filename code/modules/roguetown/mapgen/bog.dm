
/obj/effect/landmark/mapGenerator/rogue/bog
	mapGeneratorType = /datum/mapGenerator/bog
	endTurfX = 200
	endTurfY = 200
	startTurfX = 1
	startTurfY = 1

/datum/mapGenerator/bog
	modules = list(/datum/mapGeneratorModule/ambushing,/datum/mapGeneratorModule/bog, /datum/mapGeneratorModule/bogwater)

/datum/mapGeneratorModule/bog
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/rogue/dirt, /turf/open/floor/rogue/grass)
	spawnableAtoms = list(/obj/structure/flora/roguetree = 1,
							/obj/structure/flora/roguegrass/bush_meagre = 7,
							/obj/structure/flora/roguegrass/bush_meagre/bog = 4,
							/obj/structure/flora/roguegrass/maneater = 1,
							/obj/structure/flora/roguegrass/herb/random = 20,
							/obj/structure/flora/roguegrass = 23,
							/obj/structure/chair/bench/ancientlog = 20,
							/obj/item/natural/rock = 30,
							/obj/item/natural/stone = 30,
							/obj/structure/flora/roguegrass/swampweed = 30,
							/obj/item/grown/log/tree/stick = 3,
							/obj/structure/flora/roguegrass/maneater/real = 2,
							/obj/structure/innocent_bush = 1,
							)
	spawnableTurfs = list(/turf/open/water/swamp = 5)
	allowed_areas = list(/area/rogue/outdoors/bog)

/datum/mapGeneratorModule/bogwater
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	spawnableAtoms = list(/obj/structure/flora/roguegrass/water = 5,
						/obj/structure/flora/roguegrass/water/reeds = 80,
						/obj/structure/kneestingers = 60)
	allowed_turfs = list(/turf/open/water/swamp,
						/turf/open/water/swamp/deep)
	allowed_areas = list(/area/rogue/outdoors/bog)
