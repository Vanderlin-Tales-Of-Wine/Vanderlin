/obj/effect/spawner/map_spawner/beartrap_obvious
	icon_state = "beartrap"
	name = "beartrap"
	probby = 50
	spawned = list(/obj/item/restraints/legcuffs/beartrap/armed)


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


/*	..................   Spooky Village loot   ................... */
/obj/effect/spawner/map_spawner/spooky_village_stuff
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "generic_event"
	probby = 50
	spawned = list(
		/obj/item/clothing/head/armingcap = 10,
		/obj/item/clothing/head/fisherhat = 10,
		/obj/item/clothing/shoes/simpleshoes/buckle = 10,
		/obj/item/key/spooky_village  = 30,
		/obj/item/coin/copper/pile = 10,
		)


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

// ===================================================================================
/*	..................   Sewer Danger   ................... */
/obj/effect/spawner/map_spawner/sewerencounter
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "danger"
	probby = 50
	spawned = list(
		/obj/item/reagent_containers/food/snacks/smallrat = 30,
		/obj/item/reagent_containers/food/snacks/smallrat/dead = 10,
		/obj/item/organ/guts = 5,
		/obj/item/coin/copper = 5,
		/obj/effect/gibspawner/generic = 5,
		/obj/effect/decal/remains/bigrat = 5,
		/mob/living/simple_animal/hostile/retaliate/bigrat = 2,
		)

/*	..................   Cheap Room Danger   ................... */
/obj/effect/spawner/map_spawner/cheapinnroomencounter
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "danger"
	probby = 50
	spawned = list(
		/obj/item/reagent_containers/food/snacks/smallrat = 15,
		/obj/item/reagent_containers/food/snacks/smallrat/dead = 10,
		/obj/item/coin/copper = 50,
		/mob/living/carbon/human/species/human/northern/bum/skilled/madman  = 10,
		/mob/living/simple_animal/hostile/retaliate/bigrat = 10
		)



/*	..................   Beggar Danger   ................... */
/obj/effect/spawner/map_spawner/hostile_beggar_danger
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "danger"
	probby = 50
	spawned = list(
		/obj/effect/decal/cleanable/vomit = 10,
		/obj/item/clothing/face/cigarette/rollie = 10,
		/obj/item/weapon/knife/stone = 10,
		/obj/structure/idle_enemy/hostile_bum = 25	)

/*	..................   Mines Danger   ................... */
/obj/effect/spawner/map_spawner/mine_mole_maybe
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "danger"
	probby = 50
	spawned = list(
		/obj/effect/decal/remains/mole = 20,
		/obj/item/natural/rock = 10,
		/obj/item/natural/stone = 10,
		/obj/item/gem/yellow = 10,
		/obj/structure/idle_enemy/mole = 50	)

/*	..................   Crypt Danger   ................... */
/obj/effect/spawner/map_spawner/crypt_randomdanger
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "danger"
	probby = 50
	spawned = list(
		/obj/item/coin/silver = 5,
		/obj/item/natural/worms/grub_silk = 5,
		/obj/item/natural/worms = 20,
		/obj/item/reagent_containers/food/snacks/smallrat/dead = 10,
		/mob/living/simple_animal/hostile/retaliate/bigrat = 5,
		/mob/living/simple_animal/hostile/skeleton = 50	)

/*	..................   Rat Danger   ................... */
/obj/effect/spawner/map_spawner/rat_danger
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "danger"
	probby = 50
	spawned = list(
		/obj/effect/decal/remains/bigrat = 20,
		/obj/item/reagent_containers/food/snacks/smallrat = 20,
		/obj/item/natural/worms = 10,
		/obj/item/reagent_containers/food/snacks/smallrat/dead = 10,
		/mob/living/simple_animal/hostile/retaliate/bigrat = 40)

/*	..................   Skeleton Fighter Enemy   ................... */
/obj/effect/spawner/map_spawner/ancientskellyguardmaybe
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "enemy"
	probby = 50
	spawned = list(
//		/obj/structure/idle_enemy/skeleton_fighter = 100
		/mob/living/carbon/human/species/skeleton/skilled/fighter = 100
		)

/*	..................   Maneater Enemy    ................... */
/obj/effect/spawner/map_spawner/maneater_danger
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "enemy"
	probby = 50
	spawned = list(
//		/obj/structure/idle_enemy/lamia = 50,
//		/obj/structure/idle_enemy/headless = 50
		/mob/living/simple_animal/hostile/retaliate/lamia = 50,
		/mob/living/simple_animal/hostile/retaliate/headless = 50
		)

/*	..................   Zizombie Farmer Enemy    ................... */
/obj/effect/spawner/map_spawner/zizombie_farmer_maybe
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "enemy"
	probby = 50
	spawned = list(
//		/obj/structure/idle_enemy/zizombie_farmer = 100
		/mob/living/carbon/human/species/zizombie/npc/peasant = 100
		)

/*	..................   Hairy Spider Enemy   ................... */
/obj/effect/spawner/map_spawner/hairy_spider_maybe
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "enemy"
	probby = 50
	spawned = list(
//		/obj/structure/idle_enemy/hairy_spider = 100
		/mob/living/simple_animal/hostile/retaliate/spider/hairy = 100
		)

/*	..................   Savage Orc Enemy    ................... */
/obj/effect/spawner/map_spawner/orc_warrior_carbon_maybe
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "enemy"
	probby = 50
	spawned = list(
//		/obj/structure/idle_enemy/savage_orc = 65,
//		/obj/structure/idle_enemy/savage_orc_looter = 35
		/mob/living/carbon/human/species/orc/skilled/savage = 65,
		/mob/living/carbon/human/species/orc/skilled/looter = 35
		)

/obj/effect/spawner/map_spawner/orc_warlord_carbon
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "enemy"
	probby = 100
	color = "#caa3a3"
	spawned = list(
//		/obj/structure/idle_enemy/savage_orc_chieftain = 100
		/mob/living/carbon/human/species/orc/skilled/savage_chieftain = 100
		)

/*	..................   Haunts Enemy    ................... */
/obj/effect/spawner/map_spawner/haunts_maybe
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "enemy"
	probby = 50
	spawned = list(
		/obj/structure/bonepile = 100	)

/*	..................   Outlaw Enemy  (starving desperate peasants)  ................... */
/obj/effect/spawner/map_spawner/outlaw_maybe
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "enemy"
	probby = 50
	spawned = list(
//		/obj/structure/idle_enemy/outlaw = 100
		/mob/living/carbon/human/species/human/northern/bum/skilled/outlaw = 100
		)

/*	..................   Volf Enemy   ................... */
/obj/effect/spawner/map_spawner/volf_maybe
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "enemy"
	probby = 50
	spawned = list(
		/mob/living/simple_animal/hostile/retaliate/wolf = 100
//		/obj/structure/idle_enemy/volf= 100
		)

/*	..................   Honeyspider Enemy   ................... */
/obj/effect/spawner/map_spawner/honeyspider_maybe
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "enemy"
	probby = 50
	spawned = list(
//		/obj/structure/idle_enemy/honeyspider = 100
		/mob/living/simple_animal/hostile/retaliate/spider = 100
	)

/*	..................   Cave Goblin Enemy    ................... */
/obj/effect/spawner/map_spawner/goblincave_threat
	icon = 'modular/stonekeep/icons/misc.dmi'
	icon_state = "enemy"
	probby = 50
	spawned = list(
//		/obj/structure/idle_enemy/cavegoblin = 100,
		/mob/living/carbon/human/species/goblin/skilled/ambush/cave = 100
		)


// ===================================================================================
/*	..................   Idle Enemy Spawner   ................... */
/obj/structure/idle_enemy
	name = ""
	icon = 'icons/roguetown/mob/skeleton_male.dmi'
	icon_state = ""
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	anchored = TRUE
	layer = BELOW_OBJ_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/datum/component/spawner/npc
	spawn_time = 0
	spawn_delay = 0
	max_mobs = 1
	spawn_text = ""
	no_nest = TRUE

// *** CARBONS ***
/*	..................   Skeleton Fighter Spawner   ................... */
/obj/structure/idle_enemy/skeleton_fighter
/obj/structure/idle_enemy/skeleton_fighter/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/npc/skeleton_fighter)
/datum/component/spawner/npc/skeleton_fighter
	mob_types = list(/mob/living/carbon/human/species/skeleton/skilled/fighter)
	range = 11

/*	..................   Orc Carbons Spawner   ................... */
/obj/structure/idle_enemy/savage_orc
/obj/structure/idle_enemy/savage_orc/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/npc/savage_orc)
/datum/component/spawner/npc/savage_orc
	mob_types = list(/mob/living/carbon/human/species/orc/skilled/savage)
	spawn_time = 0
	spawn_delay = 0
	max_mobs = 1
	range = 11
	spawn_text = ""

/obj/structure/idle_enemy/savage_orc_looter
/obj/structure/idle_enemy/savage_orc_looter/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/npc/savage_orc_looter)
/datum/component/spawner/npc/savage_orc_looter
	mob_types = list(/mob/living/carbon/human/species/orc/skilled/looter)
	range = 11

/obj/structure/idle_enemy/savage_orc_chieftain
/obj/structure/idle_enemy/savage_orc_chieftain/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/npc/savage_orc_chieftain)
/datum/component/spawner/npc/savage_orc_chieftain
	mob_types = list(/mob/living/carbon/human/species/orc/skilled/savage_chieftain)
	range = 11


/*	..................   Hostile Bum Spawner   ................... */
/obj/structure/idle_enemy/hostile_bum
/obj/structure/idle_enemy/hostile_bum/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/npc/hostile_bum)
/datum/component/spawner/npc/hostile_bum
	mob_types = list(/mob/living/carbon/human/species/human/northern/bum/skilled/madman)
	spawn_time = 0
	spawn_delay = 0
	max_mobs = 1
	range = 11
	spawn_text = ""

/*	..................   Weak Skelly Spawner   ................... */
/obj/structure/idle_enemy/weak_skelly
/obj/structure/idle_enemy/weak_skelly/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/npc/weak_skelly)
/datum/component/spawner/npc/weak_skelly
	mob_types = list(/mob/living/carbon/human/species/skeleton/skilled/unarmed)
	range = 11
	spawn_text = ""

/*	..................   Zizombie Farmer Spawner   ................... */
/obj/structure/idle_enemy/zizombie_farmer
/obj/structure/idle_enemy/zizombie_farmer/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/npc/zizombie_farmer)
/datum/component/spawner/npc/zizombie_farmer
	mob_types = list(/mob/living/carbon/human/species/zizombie/npc/peasant)
	spawn_time = 0
	spawn_delay = 0
	max_mobs = 1
	range = 6
	spawn_text = ""


/*	..................   Outlaw Spawner   ................... */
/obj/structure/idle_enemy/outlaw
/obj/structure/idle_enemy/outlaw/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/npc/outlaw)
/datum/component/spawner/npc/outlaw
	mob_types = list(/mob/living/carbon/human/species/human/northern/bum/skilled/outlaw )
	spawn_time = 0
	spawn_delay = 0
	max_mobs = 1
	range = 11
	spawn_text = ""


// *** SIMPLE ANIMALS ***
/*	..................   Big Rat Spawner   ................... */
/obj/structure/idle_enemy/bigrat
/obj/structure/idle_enemy/bigrat/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/bigrat)
/datum/component/spawner/bigrat
	mob_types = list(/mob/living/simple_animal/hostile/retaliate/bigrat)
	spawn_time = 0
	spawn_delay = 0
	max_mobs = 1
	range = 11
	spawn_text = ""

/*	..................   Lesser Mole Spawner   ................... */
/obj/structure/idle_enemy/mole
/obj/structure/idle_enemy/mole/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/mole)
/datum/component/spawner/mole
	mob_types = list(/mob/living/simple_animal/hostile/retaliate/mole)
	spawn_time = 0
	spawn_delay = 0
	max_mobs = 1
	range = 11
	spawn_text = ""

/*	..................   Lamia Spawner   ................... */
/obj/structure/idle_enemy/lamia
/obj/structure/idle_enemy/lamia/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/lamia)
/datum/component/spawner/lamia
	mob_types = list(/mob/living/simple_animal/hostile/retaliate/lamia)
	spawn_time = 0
	spawn_delay = 0
	max_mobs = 1
	range = 10
	spawn_text = ""

/*	..................   Headless Spawner   ................... */
/obj/structure/idle_enemy/headless
/obj/structure/idle_enemy/headless/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/headless)
/datum/component/spawner/headless
	mob_types = list(/mob/living/simple_animal/hostile/retaliate/headless)
	spawn_time = 0
	spawn_delay = 0
	max_mobs = 1
	range = 10
	spawn_text = ""


/*	..................   Hairy Spider Spawner   ................... */
/obj/structure/idle_enemy/hairy_spider
/obj/structure/idle_enemy/hairy_spider/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/hairy_spider)
/datum/component/spawner/hairy_spider
	mob_types = list(/mob/living/simple_animal/hostile/retaliate/spider/hairy)
	spawn_time = 0
	spawn_delay = 0
	max_mobs = 1
	range = 11
	spawn_text = ""

/*	..................   Volf Spawner   ................... */
/obj/structure/idle_enemy/volf
/obj/structure/idle_enemy/volf/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/volf)
/datum/component/spawner/volf
	mob_types = list(/mob/living/simple_animal/hostile/retaliate/wolf )
	spawn_time = 0
	spawn_delay = 0
	max_mobs = 1
	range = 11
	spawn_text = ""

/*	..................   Cave Goblin Spawner   ................... */
/obj/structure/idle_enemy/cavegoblin
/obj/structure/idle_enemy/cavegoblin/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/npc/cavegoblin)
	icon_state = ""
/datum/component/spawner/npc/cavegoblin
	mob_types = list(/mob/living/carbon/human/species/goblin/skilled/ambush/cave )
	spawn_time = 0
	spawn_delay = 0
	max_mobs = 1
	range = 11
	spawn_text = ""


/*	..................   Cabbit Boss Spawner   ................... */
/obj/structure/idle_enemy/cabbit_boss
/obj/structure/idle_enemy/cabbit_boss/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/cabbit_boss)
/datum/component/spawner/cabbit_boss
	mob_types = list(/mob/living/simple_animal/hostile/retaliate/troll/caerbannog)
	spawn_time = 0
	spawn_delay = 0
	max_mobs = 1
	range = 11
	spawn_text = ""

/*	..................   Honeyspider Spawner   ................... */
/obj/structure/idle_enemy/honeyspider
/obj/structure/idle_enemy/honeyspider/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner/honeyspider)
/datum/component/spawner/honeyspider
	mob_types = list(/mob/living/simple_animal/hostile/retaliate/spider)
	spawn_time = 0
	spawn_delay = 0
	max_mobs = 1
	range = 11
	spawn_text = ""

/obj/effect/spawner/map_spawner/tallgrass
	color = "#ec98df"
