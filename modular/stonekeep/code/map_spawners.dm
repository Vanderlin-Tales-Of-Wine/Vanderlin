// ===================================================================================

/*	..................   Random crap for moats  ................... */
/obj/effect/spawner/map_spawner/moat_debris
	icon_state = "clodpile"
	icon = 'icons/roguetown/items/natural.dmi'
	probby = 50
	color = "#ff00d9"
	spawned = list(
		/obj/item/natural/dirtclod = 10,
		/obj/structure/fluff/clodpile = 5,
		/obj/item/reagent_containers/food/snacks/smallrat = 3,
		/obj/item/reagent_containers/food/snacks/smallrat/dead = 2,
		/obj/item/natural/worms/leech = 2,
		/obj/item/reagent_containers/food/snacks/rotten/meat = 1,
		/mob/living/simple_animal/hostile/retaliate/bigrat = 1,
		/obj/structure/kneestingers = 1)

/*	..................   Metal bars (weakened or normal?)  ................... */
/obj/effect/spawner/map_spawner/metal_bars
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "bars"
	probby = 100
	color = "#ff00d9"
	spawned = list(
		/obj/structure/bars/weakened = 30,
		/obj/structure/bars = 70,
		)



/*	..................   Plague District Thing  ................... */
/obj/effect/spawner/map_spawner/plaguedist_thing
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "danger"
	probby = 50
	spawned = list(
		/mob/living/carbon/human/species/zizombie/npc/peasant = 30,
		/obj/item/natural/worms = 10,
		/obj/item/reagent_containers/food/snacks/rotten/mince = 5,
		/obj/effect/decal/remains/bigrat = 5,
		/obj/item/reagent_containers/food/snacks/smallrat = 5,
		/obj/item/reagent_containers/food/snacks/smallrat/dead = 10,
		/mob/living/simple_animal/hostile/retaliate/bigrat = 5)

// ===================================================================================

/*	..................  Maybe Trap Spawner  ................... */
/obj/effect/spawner/map_spawner/maybe_trap
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "danger"
	probby = 50
	spawned = list(
		/obj/item/restraints/legcuffs/beartrap/armed/camouflage = 10,
		/obj/item/restraints/legcuffs/beartrap/armed = 20,
		/obj/structure/punji_sticks = 50
		)


/*	..................  Kitchen Mess Spawner  ................... */
/obj/effect/spawner/map_spawner/kitchenmess
	icon = 'icons/effects/tomatodecal.dmi'
	icon_state = "smashed_egg1"
	probby = 50
	color = "#3aff47"
	spawned = list(
		/obj/effect/decal/cleanable/food/egg_smudge = 35,
		/obj/effect/decal/cleanable/food/flour = 30,
		/obj/effect/decal/cleanable/food/mess/soup = 30
		)


// ===================================================================================
/*	..................  Bog Tree Spawner  ................... */
/obj/effect/spawner/map_spawner/bogtree
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "tree2"
	spawned = list(
		/obj/structure/flora/tree/burnt = 35,
		/obj/structure/flora/tree/neu/acacia = 30,
		/obj/structure/table/wood/treestump/burnt = 5
		)

/*	..................  Normal Tree Spawner (mapping visual)  ................... */
/obj/effect/spawner/map_spawner/tree
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "tree1"
	spawned = list(/obj/structure/flora/tree =95,
			 /obj/structure/flora/grass/bush_meagre = 5,
			 /obj/structure/table/wood/treestump = 1)

/*	..................  Outlaw Tree Spawner  ................... */
/obj/effect/spawner/map_spawner/outlawtree
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "tree1"
	probby = 50
	spawned = list(/obj/structure/flora/tree = 40,
			 /obj/structure/flora/grass/bush_meagre = 5,
			 /obj/structure/table/wood/treestump = 5,
			 /obj/structure/flora/grass/thorn_bush = 20)

/*	..................  Ruined Farm Spawner  ................... */
/obj/effect/spawner/map_spawner/ruinedfarmgrowth
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "tree3"
	probby = 50
	spawned = list(/obj/structure/flora/tree/neu/bush =30,
			 /obj/structure/flora/grass/bush_meagre = 20,
			 /obj/structure/flora/grass/thorn_bush = 10,
			 /obj/structure/flora/tree = 5)


/*	..................  Dendor Shrine Spawner  ................... */
/obj/effect/spawner/map_spawner/dendorshrine
	icon = 'icons/roguetown/misc/tallstructure.dmi'
	icon_state = "shrine_dendor_saiga"
	color = "#ffe13a"
	spawned = list(
		/obj/structure/fluff/psycross/crafted/shrine/dendor_volf= 35,
		/obj/structure/fluff/psycross/crafted/shrine/dendor_saiga = 35,
		/obj/structure/fluff/psycross/crafted/shrine/dendor_gote = 100
		)

/*	..................  Mountain Tree Spawner  ................... */
/obj/effect/spawner/map_spawner/mountain_tree
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "tree3"
	probby = 50
	spawned = list(/obj/structure/flora/tree/neu/pine =40,
			 /obj/structure/flora/tree/neu/pine_dead = 10,
			 /obj/structure/flora/tree/neu/bush = 10,
			 /obj/structure/flora/rock/pebbles = 5,
			 /obj/structure/flora/rock/pebbles/gray = 5,
			 /obj/structure/roguerock = 5)

/*	..................  Mountain Flowers  ................... */
/obj/effect/spawner/map_spawner/mountain_flowers
	icon_state = "salvia"
	icon = 'icons/roguetown/misc/herbfoliage.dmi'
	color = "#008e09"
	probby = 50
	spawned = list(/obj/structure/flora/grass/herb/salvia = 10,
			/obj/structure/flora/grass/pyroclasticflowers = 10
			)


/*	..................  Bog decoration Spawner  ................... */
/obj/effect/spawner/map_spawner/bogdirt
	icon_state = "gray"
	icon = 'modular/stonekeep/icons/pigflora.dmi'
	probby = 50
	color = "#3aff47"
	spawned = list(
		/obj/structure/flora/rock/pebbles/bogmix = 10,
		/obj/structure/flora/rock/pebbles/brown = 5
		)

/*	..................  Rocky Spawner  ................... */
/obj/effect/spawner/map_spawner/rockies
	icon_state = "rock1"
	icon = 'icons/roguetown/misc/foliage.dmi'
	alpha = 200
	color = "#88f78f"
	probby = 50
	spawned = list(/obj/structure/roguerock = 10,
			 /obj/item/natural/rock = 10,
			 /obj/structure/flora/rock/pebbles = 20,
			 /obj/item/natural/stone = 10,
			 /obj/structure/flora/rock/pebbles/bogmix = 10)

/*	..................  Grave Spawner  ................... */
/obj/effect/spawner/map_spawner/graverandom
	icon_state = "gravecovered"
	icon = 'icons/turf/roguefloor.dmi'
	alpha = 200
	color = "#00ff11"
	probby = 50
	spawned = list(/obj/structure/closet/dirthole/grave = 10,
			/obj/structure/closet/dirthole/closed = 10,
			/obj/structure/closet/dirthole/closed/loot = 2,
			/obj/structure/closet/dirthole = 10)

/*	..................  Bridge Spawner  ................... */
/obj/effect/spawner/map_spawner/bridgerandom
	probby = 50
	spawned = list(/turf/open/floor/blocks/moss)


/*	..................   Random Alcohol   ................... */
/obj/effect/spawner/map_spawner/alcohol	// random beer
	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "clear_bottle1"
	color = "#06b606"
	probby = 100
	spawned = list(
		/obj/item/reagent_containers/glass/bottle/beer = 50,
		/obj/item/reagent_containers/glass/bottle/beer/spottedhen = 15,
		/obj/item/reagent_containers/glass/bottle/beer/blackgoat = 10,
		/obj/item/reagent_containers/glass/bottle/beer/ratkept = 5,
		/obj/item/reagent_containers/glass/bottle/beer/hagwoodbitter = 10,
		/obj/item/reagent_containers/glass/bottle/beer/aurorian = 5,
		/obj/item/reagent_containers/glass/bottle/beer/fireleaf = 5,
		/obj/item/reagent_containers/glass/bottle/beer/butterhairs = 5,
		/obj/item/reagent_containers/glass/bottle/beer/stonebeardreserve = 5,
		/obj/item/reagent_containers/glass/bottle/beer/voddena = 5 )

/obj/effect/spawner/map_spawner/alcohol/wine
	spawned = list(
		/obj/item/reagent_containers/glass/bottle/wine = 50,
		/obj/item/reagent_containers/glass/bottle/wine/sourwine =10,
		/obj/item/reagent_containers/glass/bottle/redwine = 20,
		/obj/item/reagent_containers/glass/bottle/whitewine = 20,
		/obj/item/reagent_containers/glass/bottle/elfred = 5,
		/obj/item/reagent_containers/glass/bottle/elfblue = 5 )


/*	..................   Random Gem spawner   ................... */
/obj/effect/spawner/map_spawner/loot/random_gem
	spawned = list(
	/obj/item/gem = 25,
	/obj/item/gem/green = 12,
	/obj/item/gem/blue = 6,
	/obj/item/gem/yellow = 3,
	/obj/item/gem/violet = 2,
	/obj/item/gem/diamond = 1)


/*	..................   Toll randomizer (poor mans coin generator, cheaper workload is all)  ................... */
/obj/effect/spawner/map_spawner/tollrandom
	icon = 'icons/roguetown/underworld/enigma_husks.dmi'
	icon_state = "soultoken_floor"
	probby = 35
	color = "#ff0000"
	spawned = list(
		/obj/item/underworld/coin = 1,
		)

/*	..................   Random Seeds   ................... */
/obj/effect/spawner/map_spawner/seeds	// all random
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "seeds"
	color = "#06b606"
	probby = 100
	spawned = list(
		/obj/item/neuFarm/seed/wheat = 20,
		/obj/item/neuFarm/seed/cabbage = 10,
		/obj/item/neuFarm/seed/oat = 10,
		/obj/item/neuFarm/seed/potato = 10,
		/obj/item/neuFarm/seed/turnip = 10,
		/obj/item/neuFarm/seed/apple = 10,
		/obj/item/neuFarm/seed/onion = 10,
		/obj/item/neuFarm/seed/berryrogue = 15,
		/obj/item/neuFarm/seed/westleach = 10,
		/obj/item/neuFarm/seed/sunflower = 10,
		/obj/item/neuFarm/seed/swampleaf = 5,
		/obj/item/neuFarm/seed/pear = 5,
		/obj/item/neuFarm/seed/poppy = 5,
		/obj/item/neuFarm/seed/poison_berries = 5,
		/obj/item/neuFarm/seed/fyritius = 5 )

/obj/effect/spawner/map_spawner/seeds/common
	spawned = list(
		/obj/item/neuFarm/seed/wheat = 25,
		/obj/item/neuFarm/seed/cabbage = 15,
		/obj/item/neuFarm/seed/oat = 10,
		/obj/item/neuFarm/seed/potato = 10,
		/obj/item/neuFarm/seed/turnip = 10,
		/obj/item/neuFarm/seed/apple = 10,
		/obj/item/neuFarm/seed/onion = 10 )

/obj/effect/spawner/map_spawner/seeds/uncommon
	spawned = list(
		/obj/item/neuFarm/seed/berryrogue = 40,
		/obj/item/neuFarm/seed/westleach = 25,
		/obj/item/neuFarm/seed/swampleaf = 15,
		/obj/item/neuFarm/seed/pear = 15,
		/obj/item/neuFarm/seed/poison_berries = 5 )

/obj/effect/spawner/map_spawner/seeds/flowers
	spawned = list(
		/obj/item/neuFarm/seed/sunflower = 70,
		/obj/item/neuFarm/seed/fyritius = 10,
		/obj/item/neuFarm/seed/poppy = 20 )


/*	..................   Loot spawners   ................... */
/obj/effect/spawner/map_spawner/loot
	icon_state = "loot"
	probby = 50

/obj/effect/spawner/map_spawner/loot/common
	spawned = list(
		/obj/item/coin/copper = 5,
		/obj/item/coin/copper/pile = 15,
		/obj/item/natural/cloth = 10,
		/obj/item/storage/belt/pouch = 5,
		/obj/item/storage/belt/pouch/coins/poor = 5,
		/obj/item/storage/belt/leather/rope = 10,
		/obj/item/natural/bundle/stick = 10,
		/obj/item/grown/log/tree/small = 15,
		/obj/item/natural/hide = 4,
		/obj/item/clothing/shoes/gladiator = 5,
		/obj/item/kitchen/spoon = 1,
		/obj/item/reagent_containers/glass/bowl = 1,

		)


/obj/effect/spawner/map_spawner/loot/weapon
	spawned = list(
		/obj/item/coin/copper/pile = 15,
		/obj/item/weapon/knife/hunting = 10,
		/obj/item/weapon/knife/dagger = 8,
		/obj/item/weapon/knife/dagger/steel = 4,
		/obj/item/weapon/knife/dagger/silver = 2,
		/obj/item/weapon/sword/iron = 3,
		/obj/item/weapon/axe/iron = 10,
		/obj/item/weapon/mace = 5,
		/obj/item/ammo_holder/quiver/arrows = 5,
		/obj/item/weapon/sword/short = 5,
		/obj/item/clothing/armor/leather = 10,
		/obj/item/clothing/armor/gambeson = 15,
		/obj/item/clothing/gloves/chain/iron = 3,
		/obj/item/clothing/neck/coif = 3,
		/obj/item/clothing/shoes/gladiator = 5
		)


/obj/effect/spawner/map_spawner/loot/jewelry
	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "golden"
	color = "#06b606"
	spawned = list(
		/obj/item/statue/iron = 8,
		/obj/item/statue/steel = 8,
		/obj/item/ingot/gold = 7,
		/obj/item/statue/silver = 8,
		/obj/item/clothing/ring/silver = 7,
		/obj/item/reagent_containers/glass/cup/silver = 7,
		/obj/item/storage/belt/leather/plaquesilver = 7,
		/obj/item/clothing/ring/gold = 5,
		/obj/item/ingot/gold = 5,
		/obj/item/reagent_containers/glass/cup/golden = 4,
		/obj/item/storage/belt/leather/plaquegold = 4,
		/obj/item/clothing/face/spectacles/golden = 3,
		/obj/item/clothing/head/crown/circlet = 3,
		/obj/item/statue/gold/loot=2,
		/obj/item/clothing/head/helmet/heavy/decorated/golden = 1,
		/obj/item/clothing/head/crown/nyle = 1,
		/obj/item/statue/gold = 1,
		)


/obj/effect/spawner/map_spawner/loot/plaguedistrict
	icon_state = "loot"
	spawned = list(
		/obj/item/flashlight/flare/torch = 2,
		/obj/item/kitchen/spoon = 2,
		/obj/item/reagent_containers/glass/bowl/clay = 3,
		/obj/item/natural/bundle/stick = 2,
		/obj/item/grown/log/tree/small = 2,
		/obj/item/natural/cloth = 2,
		/obj/item/storage/belt/pouch = 1,
		/obj/item/storage/belt/leather/rope = 1,
		/obj/item/clothing/shoes/simpleshoes = 2,
		/obj/item/clothing/neck/psycross = 2,
		/obj/item/natural/hide/cured = 2,
		/obj/item/reagent_containers/glass/bottle/waterskin = 1,

		/obj/item/needle = 1,
		/obj/item/weapon/pitchfork = 1,
		/obj/item/flint = 1,
		/obj/item/weapon/hammer/iron = 1,
		/obj/item/weapon/knife/scissors = 1,
		/obj/item/weapon/knife/hunting = 1,
		/obj/item/weapon/knife/villager = 2,
		/obj/item/weapon/axe/stone = 1,
		/obj/item/weapon/sickle = 1,

		/obj/item/coin/copper = 5,
		/obj/item/coin/copper/pile = 5,
		/obj/item/storage/belt/pouch/coins/poor = 1,
		/obj/item/coin/silver = 1,
		/obj/item/clothing/neck/psycross/silver/pestra = 1,
		)



// ======================================================================
/*	..................   Maybe Mob Spawners   ................... */
/obj/effect/spawner/map_spawner/maybe_saiga
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "animal"
	probby = 50
	spawned = list(
		/mob/living/simple_animal/hostile/retaliate/saiga = 40,
		/mob/living/simple_animal/hostile/retaliate/saigabuck = 50,
		/mob/living/simple_animal/hostile/retaliate/saiga/saigakid = 10)

/obj/effect/spawner/map_spawner/maybe_cabbit
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "animal"
	probby = 50
	spawned = list(
		/mob/living/simple_animal/pet/cat/cabbit = 100)

/obj/effect/spawner/map_spawner/maybe_pig
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "animal"
	probby = 50
	spawned = list(
		/mob/living/simple_animal/hostile/retaliate/trufflepig = 90,
		/obj/effect/decal/remains/pig = 10)

/obj/effect/spawner/map_spawner/maybe_gote
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "animal"
	probby = 50
	spawned = list(
		/mob/living/simple_animal/hostile/retaliate/goat = 40,
		/mob/living/simple_animal/hostile/retaliate/goatmale = 50,
		/mob/living/simple_animal/hostile/retaliate/goat/goatlet/boy = 10)
