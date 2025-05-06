//genstuff
/obj/effect/landmark/mapGenerator/forest
	mapGeneratorType = /datum/mapGenerator/forest
	endTurfX = 200
	endTurfY = 200
	startTurfX = 1
	startTurfY = 1


/datum/mapGenerator/forest
	modules = list(/datum/mapGeneratorModule/ambushing,/datum/mapGeneratorModule/forestgrassturf,/datum/mapGeneratorModule/forest,/datum/mapGeneratorModule/forestroad,/datum/mapGeneratorModule/forestgrass,/datum/mapGeneratorModule/forestswampwaterturf,/datum/mapGeneratorModule/forestwaterturf)


/datum/mapGeneratorModule/forest
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/dirt)
	excluded_turfs = list(/turf/open/floor/dirt/road)
	spawnableAtoms = list(/obj/structure/flora/newtree = 5,
							/obj/structure/flora/grass/bush_meagre = 6,
							/obj/structure/flora/grass/thorn_bush = 2,
							/obj/structure/flora/grass = 80,
							/obj/structure/flora/grass/herb/random = 7,
							/obj/item/natural/stone = 5,
							/obj/item/natural/rock = 6,
							/obj/structure/flora/grass/pyroclasticflowers = 1,
							/obj/item/grown/log/tree/stick = 5,
							/obj/structure/chair/bench/ancientlog = 3,
							/obj/structure/table/wood/treestump = 4,
							/obj/structure/closet/dirthole/closed/loot=6,
							/obj/item/restraints/legcuffs/beartrap/armed/camouflage=0.1)
	spawnableTurfs = list(/turf/open/floor/dirt/road=40,
						/turf/open/water/swamp=5)
	allowed_areas = list(/area/rogue/outdoors/woods)

/datum/mapGeneratorModule/forestroad
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/dirt/road)
	spawnableAtoms = list(/obj/item/natural/stone = 3,/obj/item/grown/log/tree/stick = 2)

/datum/mapGeneratorModule/forestgrassturf
	clusterCheckFlags = CLUSTER_CHECK_NONE
	allowed_turfs = list(/turf/open/floor/dirt)
	excluded_turfs = list(/turf/open/floor/dirt/road)
	spawnableTurfs = list(/turf/open/floor/grass = 15)
	allowed_areas = list(/area/rogue/outdoors/woods)

/datum/mapGeneratorModule/forestgrass
	clusterCheckFlags = CLUSTER_CHECK_SAME_ATOMS
	allowed_turfs = list(/turf/open/floor/grass)
	excluded_turfs = list()
	allowed_areas = list(/area/rogue/outdoors/woods)
	spawnableAtoms = list(/obj/structure/flora/tree = 0,
							/obj/structure/flora/grass/bush_meagre = 6,
							/obj/structure/flora/grass = 80,
							/obj/structure/flora/grass/herb/random = 7,
							/obj/structure/flora/grass/maneater = 0.1,
							/obj/structure/flora/grass/maneater/real = 0.1,
							/obj/item/restraints/legcuffs/beartrap/armed/camouflage = 0.1,
							/obj/item/natural/stone = 6,
							/obj/item/natural/rock = 5,
							/obj/item/grown/log/tree/stick = 3,
							/obj/structure/chair/bench/ancientlog = 5)

/datum/mapGeneratorModule/forestwaterturf
	clusterCheckFlags = CLUSTER_CHECK_SAME_ATOMS
	allowed_turfs = list(/turf/open/water/cleanshallow)
	excluded_turfs = list()
	allowed_areas = list(/area/rogue/outdoors/woods)
	spawnableAtoms = list(/obj/structure/flora/grass/water = 20,
	                        /obj/structure/flora/grass/water/reeds = 25,
	                        /obj/structure/kneestingers = 25)

/datum/mapGeneratorModule/forestswampwaterturf
	clusterCheckFlags = CLUSTER_CHECK_SAME_ATOMS
	allowed_turfs = list(/turf/open/water/swamp)
	excluded_turfs = list()
	allowed_areas = list(/area/rogue/outdoors/woods)
	spawnableAtoms = list(/obj/structure/flora/grass/water = 20,
		                    /obj/structure/flora/grass/water/reeds = 30,
	                        /obj/structure/kneestingers = 30)
