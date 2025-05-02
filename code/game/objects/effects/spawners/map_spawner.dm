/obj/effect/spawner/map_spawner
	icon = 'icons/obj/structures_spawners.dmi'
	///Chance to bother spawning anything
	var/probby = 100
	var/list/spawned		//a list of possible items to spawn e.g. list(/obj/item, /obj/structure, /obj/effect), can be weighted
	var/lootmin = 1		//how many items will be spawned, at least.
	var/lootmax = 1		//how many items will be spawned, at most
	var/lootdoubles = TRUE	//if the same item can be spawned twice
	var/fan_out_items = FALSE //Whether the items should be distributed to offsets 0,1,-1,2,-2,3,-3.. This overrides pixel_x/y on the spawner itself
/obj/effect/spawner/map_spawner/proc/do_spawn()
	if(prob(probby) && length(spawned))
		var/obj/new_type = pickweight(spawned)
		new new_type(get_turf(src))

/obj/effect/spawner/map_spawner/Initialize(mapload)
	..()
	if(!prob(probby))
		return INITIALIZE_HINT_QDEL
	if(spawned && spawned.len > 1)
		var/turf/T = get_turf(src)
		var/loot_spawned = 0
		var/chosenamout = rand(lootmin,lootmax)
		for(var/i in 1 to chosenamout)
			if(!spawned.len)
				break
			var/lootspawn = pickweight(spawned)
			while(islist(lootspawn))
				lootspawn = pickweight(lootspawn)
			if(!lootdoubles)
				spawned.Remove(lootspawn)

			if(lootspawn)
				var/atom/movable/spawned_loot = new lootspawn(T)
				if (!fan_out_items)
					if (pixel_x != 0)
						spawned_loot.pixel_x = pixel_x
					if (pixel_y != 0)
						spawned_loot.pixel_y = pixel_y
				else
					if (loot_spawned)
						spawned_loot.pixel_x = spawned_loot.pixel_y = ((!(loot_spawned%2)*loot_spawned/2)*-1)+((loot_spawned%2)*(loot_spawned+1)/2*1)
			loot_spawned++
	else
		do_spawn()
	return INITIALIZE_HINT_QDEL

/obj/effect/spawner/map_spawner/pit
	icon_state = "pit"

/obj/effect/spawner/map_spawner/pit/do_spawn()
	var/turf/T = get_turf(src)
	var/turf/below = get_step_multiz(src, DOWN)
	if(below)
		T.ChangeTurf(/turf/open/transparent/openspace)
		below.ChangeTurf(/turf/open/floor/dirt/road)

/obj/effect/spawner/map_spawner/tree
	icon_state = "tree"
	name = "Tree spawner"
	probby = 80
	spawned = list(/obj/structure/flora/tree)

/obj/effect/spawner/map_spawner/treeorbush
	icon_state = "Treeorbush"
	name = "Tree or bush spawner"
	probby = 50
	spawned = list(/obj/structure/flora/tree, /obj/structure/flora/grass/bush_meagre)

/obj/effect/spawner/map_spawner/treeorstump
	icon_state = "treeorstump"
	name = "Tree or stump spawner"
	probby = 50
	spawned = list(/obj/structure/flora/tree, /obj/structure/table/wood/treestump)

/obj/effect/spawner/map_spawner/stump
	icon_state = "stump"
	name = "stump spawner"
	probby = 75
	spawned = list(/obj/structure/table/wood/treestump)

/obj/effect/spawner/map_spawner/hauntpile
	icon_state = "hauntpile"
	name = "hauntpile"
	probby = 23
	spawned = list(/obj/structure/bonepile)

/obj/effect/spawner/map_spawner/beartrap
	icon_state = "beartrap"
	name = "beartrap"
	probby = 50
	spawned = list(/obj/item/restraints/legcuffs/beartrap/armed/camouflage)

/obj/effect/spawner/map_spawner/tallgrass
	icon_state = "grass"
	name = "grass tile loot spawner"
	probby = 75
	spawned = list(/obj/structure/flora/grass/bush_meagre = 10, /obj/structure/flora/grass = 60, /obj/item/natural/stone = 8, /obj/item/natural/rock = 7, /obj/item/grown/log/tree/stick = 3, /obj/structure/closet/dirthole/closed/loot=0.1)

/obj/effect/spawner/map_spawner/grass_low
	icon_state = "grass"
	name = "grass tile low loot spawner"
	probby = 50
	spawned = list(/obj/structure/flora/grass/bush_meagre = 5, /obj/structure/flora/grass = 60, /obj/item/natural/stone = 8, /obj/item/natural/rock = 4, /obj/item/grown/log/tree/stick = 2)

/*	..................   Toll randomizer (poor mans coin generator, cheaper workload is all)  ................... */
/obj/effect/spawner/map_spawner/tollrandom
	icon = 'icons/roguetown/underworld/enigma_husks.dmi'
	icon_state = "soultoken_floor"
	probby = 25
	color = "#ff0000"
	spawned = list(
		/obj/item/underworld/coin = 1,
		)

/*	..................   Hauntz randomizer   ................... */
/obj/effect/spawner/map_spawner/hauntz_random
	icon = 'icons/mob/actions/roguespells.dmi'
	icon_state = "raiseskele"
	alpha = 150
	probby = 50
	spawned = list(	/obj/effect/landmark/events/haunts = 100	)

/*	..................   Loot spawners   ................... */
/obj/effect/spawner/map_spawner/loot
	icon_state = "lootblank"
	probby = 100

/obj/effect/spawner/map_spawner/loot/common
	icon_state = "lootlow"
	spawned = list(
		/obj/item/coin/copper/pile = 15,
		/obj/item/weapon/knife/hunting = 5,
		/obj/item/weapon/knife/dagger = 8,
		/obj/item/weapon/sword/iron = 3,
		/obj/item/weapon/axe/copper = 10,
		/obj/item/weapon/mace = 5,
		/obj/item/clothing/armor/leather = 10,
		/obj/item/clothing/gloves/chain/iron = 3,
		/obj/item/clothing/neck/coif = 3,
		/obj/item/natural/poo = 5
		)

/obj/effect/spawner/map_spawner/loot/medium
	icon_state = "lootmed"
	spawned = list(
		/obj/item/coin/silver/pile = 15,
		/obj/item/weapon/knife/dagger/steel = 4,
		/obj/item/weapon/axe/iron = 10,
		/obj/item/ammo_holder/quiver/arrows = 5,
		/obj/item/weapon/sword/short = 5,
		/obj/item/clothing/armor/cuirass/iron = 10,
		/obj/item/clothing/armor/gambeson = 10,
		/obj/item/clothing/gloves/chain/iron = 3,
		/obj/item/clothing/neck/gorget = 3,
		/obj/item/statue/gold/loot = 1
		)

/obj/effect/spawner/map_spawner/loot/rare
	icon_state = "loothigh"
	spawned = list(
		/obj/item/coin/gold/pile = 15,
		/obj/item/weapon/knife/dagger/silver = 5,
		/obj/item/weapon/sword/long/greatsword = 3,
		/obj/item/weapon/axe/iron = 10,
		/obj/item/ingot/gold = 5,
		/obj/item/clothing/head/crown/circlet = 2,
		/obj/item/clothing/armor/medium/scale = 8,
		/obj/item/clothing/armor/plate = 8,
		/obj/item/clothing/gloves/chain = 3,
		/obj/item/clothing/neck/bevor = 3,
		/obj/item/clothing/pants/chainlegs = 5,
		/obj/item/clothing/pants/chainlegs/kilt = 5
		)

/obj/effect/spawner/map_spawner/loot/magic
	icon_state = "lootmagic"
	spawned = list(
		/obj/item/clothing/ring/active/nomag = 20,
		/obj/item/clothing/ring/gold/protection = 10,
		/obj/item/clothing/ring/gold/ravox = 6,
		/obj/item/clothing/ring/silver/calm = 20,
		/obj/item/clothing/ring/silver/noc = 6,
		/obj/item/clothing/head/crown/circlet/vision = 3,
		/obj/item/clothing/head/crown/circlet/sleepless = 3,
		/obj/item/clothing/head/crown/circlet/stink = 5,
		/obj/item/clothing/neck/talkstone = 10
		)

/obj/effect/spawner/map_spawner/loot/coin
	icon_state = "lootcoin"
	lootmax = 3
	spawned = list(
		/obj/item/coin/gold/pile = 5,
		/obj/item/coin/gold = 10,
		/obj/item/coin/silver/pile = 20,
		/obj/item/coin/silver = 25,
		/obj/item/coin/copper/pile = 30,
		/obj/item/coin/copper = 35
		)

/obj/effect/spawner/map_spawner/loot/coin/low
	icon_state = "lootcoinlow"
	spawned = list(
		/obj/item/coin/copper/pile = 75,
		/obj/item/coin/copper = 25
		)

/obj/effect/spawner/map_spawner/loot/coin/med
	icon_state = "lootcoinmed"
	spawned = list(
		/obj/item/coin/silver/pile = 75,
		/obj/item/coin/silver = 25
		)

/obj/effect/spawner/map_spawner/loot/coin/high
	icon_state = "lootcoinhigh"
	spawned = list(
		/obj/item/coin/gold/pile = 75,
		/obj/item/coin/gold = 25
		)

/obj/effect/spawner/map_spawner/loot/coin/absurd
	icon_state = "lootcoinabsurd"
	spawned = list(
		/obj/item/coin/gold/pile = 50,
		/obj/item/gem = 50
		)

/obj/effect/spawner/map_spawner/loot/weapon
	icon_state = "lootweapon"
	spawned = list(
		/obj/item/weapon/mace/copperbludgeon = 15,
		/obj/item/weapon/axe/copper = 15,
		/obj/item/weapon/knife/copper = 15,
		/obj/item/weapon/sword/long/rider/copper = 15,
		/obj/item/weapon/sword/coppermesser = 15,
		/obj/item/weapon/polearm/spear/stone/copper = 15,
		/obj/item/weapon/axe/iron = 10,
		/obj/item/weapon/polearm/halberd/bardiche = 10,
		/obj/item/weapon/sword/rapier/ironestoc = 10,
		/obj/item/weapon/polearm/eaglebeak/lucerne = 10,
		/obj/item/weapon/mace = 10,
		/obj/item/weapon/sword/scimitar/messer = 10,
		/obj/item/weapon/flail/militia = 10,
		/obj/item/weapon/sword/short = 10,
		/obj/item/weapon/sword/long/greatsword/zwei = 10,
		/obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve = 10,
		/obj/item/gun/ballistic/revolver/grenadelauncher/bow = 10,
		/obj/item/gun/ballistic/revolver/grenadelauncher/bow/long = 5,
		/obj/item/gun/ballistic/revolver/grenadelauncher/crossbow = 5,
		/obj/item/weapon/axe/steel = 5,
		/obj/item/weapon/sword/long/greatsword = 5,
		/obj/item/weapon/sword/rapier = 5,
		/obj/item/weapon/sword/sabre = 5,
		/obj/item/weapon/mace/goden/steel = 5,
		/obj/item/weapon/mace/steel = 5,
		/obj/item/weapon/hammer/sledgehammer/war = 5
		)

/obj/effect/spawner/map_spawner/loot/armor
	icon_state = "lootarmor"
	spawned = list(
		/obj/item/clothing/face/facemask/copper = 15,
		/obj/item/clothing/wrists/bracers/copper = 15,
		/obj/item/clothing/head/helmet/coppercap = 15,
		/obj/item/clothing/armor/cuirass/copperchest = 15,
		/obj/item/clothing/pants/chainlegs/iron = 10,
		/obj/item/clothing/pants/chainlegs/kilt/iron = 10,
		/obj/item/clothing/armor/chainmail/iron = 10,
		/obj/item/clothing/armor/plate/iron = 10,
		/obj/item/clothing/head/helmet/heavy/ironplate = 10,
		/obj/item/clothing/armor/leather/splint = 10,
		/obj/item/clothing/armor/brigandine = 5,
		/obj/item/clothing/head/helmet/heavy/frog = 5,
		/obj/item/clothing/head/helmet/visored/hounskull = 5,
		/obj/item/clothing/face/facemask/steel = 5,
		/obj/item/clothing/armor/plate/full = 5,
		/obj/item/clothing/neck/chaincoif = 5
		)

/obj/effect/spawner/map_spawner/loot/food
	icon_state = "lootfood"
	spawned = list(
		/obj/item/reagent_containers/food/snacks/bread = 10,
		/obj/item/reagent_containers/food/snacks/bread/raisin = 10,
		/obj/item/reagent_containers/food/snacks/bun = 10,
		/obj/item/reagent_containers/food/snacks/cheesebun = 10,
		/obj/item/reagent_containers/food/snacks/frybread = 10,
		/obj/item/reagent_containers/food/snacks/cooked/frysteak = 10,
		/obj/item/reagent_containers/food/snacks/cooked/egg = 10,
		/obj/item/reagent_containers/food/snacks/cooked/frybird = 10,
		/obj/item/reagent_containers/food/snacks/cooked/ham = 10,
		/obj/item/reagent_containers/food/snacks/cooked/sausage = 10,
		/obj/item/reagent_containers/food/snacks/potato/baked = 10,
		/obj/item/reagent_containers/food/snacks/onion_fried = 10,
		/obj/item/reagent_containers/food/snacks/raisins = 10,
		/obj/item/reagent_containers/food/snacks/meat/salami = 10,
		/obj/item/reagent_containers/food/snacks/hardtack = 10
		)

/obj/effect/spawner/map_spawner/loot/potion_vitals
	icon_state = "lootpotion"
	spawned = list(
		/obj/item/reagent_containers/glass/bottle/healthpot = 10,
		/obj/item/reagent_containers/glass/bottle/stronghealthpot = 5,
		/obj/item/reagent_containers/glass/bottle/manapot = 10,
		/obj/item/reagent_containers/glass/bottle/strongmanapot = 5,
		/obj/item/reagent_containers/glass/bottle/stampot = 10,
		/obj/item/reagent_containers/glass/bottle/strongstampot = 5
	)

/obj/effect/spawner/map_spawner/loot/potion_poisons
	icon_state = "lootpoison"
	spawned = list(
		/obj/item/reagent_containers/glass/bottle/poison = 10,
		/obj/item/reagent_containers/glass/bottle/strongpoison = 5,
		/obj/item/reagent_containers/glass/bottle/stampoison = 10,
		/obj/item/reagent_containers/glass/bottle/strongstampoison = 5,
		/obj/item/reagent_containers/glass/bottle/stampot = 10,
		/obj/item/reagent_containers/glass/bottle/strongstampot = 5
	)

/obj/effect/spawner/map_spawner/loot/potion_ingredient
	icon_state = "lootpotioning"
	var/static/list/all_potion_ings = list()
	spawned = list()

/obj/effect/spawner/map_spawner/loot/potion_ingredient/Initialize(mapload)
	if(!all_potion_ings.len)
		all_potion_ings = subtypesof(/obj/item/alch)
	if(!spawned.len)
		spawned = all_potion_ings.Copy()
	return ..()

/obj/effect/spawner/map_spawner/loot/potion_ingredient/herb
	icon_state = "lootpotionherb"
	spawned = list(
		/obj/item/alch/atropa = 5,
		/obj/item/alch/matricaria = 5,
		/obj/item/alch/symphitum = 5,
		/obj/item/alch/taraxacum = 5,
		/obj/item/alch/euphrasia = 5,
		/obj/item/alch/paris = 5,
		/obj/item/alch/calendula = 5,
		/obj/item/alch/mentha = 5,
		/obj/item/alch/urtica = 5,
		/obj/item/alch/salvia = 5,
		/obj/item/alch/hypericum = 5,
		/obj/item/alch/benedictus = 5,
		/obj/item/alch/valeriana = 5,
		/obj/item/alch/artemisia = 5,
		/obj/item/alch/rosa = 5,
	)
/obj/effect/spawner/map_spawner/loot/potion_stats
	icon_state = "lootstatpot"
	spawned = list(
		/obj/item/reagent_containers/glass/bottle/vial/strpot = 10,
		/obj/item/reagent_containers/glass/bottle/vial/perpot = 10,
		/obj/item/reagent_containers/glass/bottle/vial/endpot = 10,
		/obj/item/reagent_containers/glass/bottle/vial/conpot = 10,
		/obj/item/reagent_containers/glass/bottle/vial/intpot = 10,
		/obj/item/reagent_containers/glass/bottle/vial/spdpot = 10,
		/obj/item/reagent_containers/glass/bottle/vial/lucpot = 10
	)
/obj/effect/spawner/map_spawner/sewerencounter
	icon_state = "srat"
	icon = 'icons/roguetown/mob/monster/rat.dmi'
	probby = 50
	color = "#ff0000"
	spawned = list(
		/obj/item/reagent_containers/food/snacks/smallrat = 30,
		/obj/item/reagent_containers/food/snacks/smallrat/dead = 10,
		/obj/item/organ/guts = 5,
		/obj/item/coin/copper = 5,
		/obj/effect/gibspawner/generic = 5,
		/obj/effect/decal/remains/bigrat = 5,
		/mob/living/simple_animal/hostile/retaliate/bigrat = 1,
		)
