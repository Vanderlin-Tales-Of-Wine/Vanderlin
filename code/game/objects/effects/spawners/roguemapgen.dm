/obj/effect/spawner/roguemap
	icon = 'icons/obj/structures_spawners.dmi'
	///Chance to bother spawning anything
	var/probby = 100
	var/list/spawned		//a list of possible items to spawn e.g. list(/obj/item, /obj/structure, /obj/effect), can be weighted
	var/lootmin = 1		//how many items will be spawned, at least.
	var/lootmax = 1		//how many items will be spawned, at most
	var/lootdoubles = TRUE	//if the same item can be spawned twice
	var/fan_out_items = FALSE //Whether the items should be distributed to offsets 0,1,-1,2,-2,3,-3.. This overrides pixel_x/y on the spawner itself
/obj/effect/spawner/roguemap/proc/do_spawn()
	if(prob(probby))
		var/obj/new_type = pickweight(spawned)
		new new_type(get_turf(src))

/obj/effect/spawner/roguemap/Initialize(mapload)
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

/obj/effect/spawner/roguemap/pit
	icon_state = "pit"

/obj/effect/spawner/roguemap/pit/do_spawn()
	var/turf/T = get_turf(src)
	var/turf/below = get_step_multiz(src, DOWN)
	if(below)
		T.ChangeTurf(/turf/open/transparent/openspace)
		below.ChangeTurf(/turf/open/floor/rogue/dirt/road)

/obj/effect/spawner/roguemap/tree
	icon_state = "tree"
	name = "Tree spawner"
	probby = 80
	spawned = list(/obj/structure/flora/roguetree)

/obj/effect/spawner/roguemap/treeorbush
	icon_state = "Treeorbush"
	name = "Tree or bush spawner"
	probby = 50
	spawned = list(/obj/structure/flora/roguetree, /obj/structure/flora/roguegrass/bush_meagre)

/obj/effect/spawner/roguemap/treeorstump
	icon_state = "treeorstump"
	name = "Tree or stump spawner"
	probby = 50
	spawned = list(/obj/structure/flora/roguetree, /obj/structure/table/wood/treestump)

/obj/effect/spawner/roguemap/stump
	icon_state = "stump"
	name = "stump spawner"
	probby = 75
	spawned = list(/obj/structure/table/wood/treestump)

/obj/effect/spawner/roguemap/shroud
	icon_state = "shroud"
	name = "shroud sp"
	probby = 30
	spawned = list(/turf/closed/wall/shroud)

/obj/effect/spawner/roguemap/hauntpile
	icon_state = "hauntpile"
	name = "hauntpile"
	probby = 23
	spawned = list(/obj/structure/bonepile)

/obj/effect/spawner/roguemap/beartrap
	icon_state = "beartrap"
	name = "beartrap"
	probby = 50
	spawned = list(/obj/item/restraints/legcuffs/beartrap/armed/camouflage)

/obj/effect/spawner/roguemap/tallgrass
	icon_state = "grass"
	name = "grass tile loot spawner"
	probby = 75
	spawned = list(/obj/structure/flora/roguegrass/bush_meagre = 10, /obj/structure/flora/roguegrass = 60, /obj/item/natural/stone = 8, /obj/item/natural/rock = 7, /obj/item/grown/log/tree/stick = 3, /obj/structure/closet/dirthole/closed/loot=0.1)

/obj/effect/spawner/roguemap/grass_low
	icon_state = "grass"
	name = "grass tile low loot spawner"
	probby = 50
	spawned = list(/obj/structure/flora/roguegrass/bush_meagre = 5, /obj/structure/flora/roguegrass = 60, /obj/item/natural/stone = 8, /obj/item/natural/rock = 4, /obj/item/grown/log/tree/stick = 2)

/*	..................   Toll randomizer (poor mans coin generator, cheaper workload is all)  ................... */
/obj/effect/spawner/roguemap/tollrandom
	icon = 'icons/roguetown/underworld/enigma_husks.dmi'
	icon_state = "soultoken_floor"
	probby = 25
	color = "#ff0000"
	spawned = list(
		/obj/item/underworld/coin = 1,
		)

/*	..................   Hauntz randomizer   ................... */
/obj/effect/spawner/roguemap/hauntz_random
	icon = 'icons/mob/actions/roguespells.dmi'
	icon_state = "raiseskele"
	alpha = 150
	probby = 50
	spawned = list(	/obj/effect/landmark/events/haunts = 100	)

/*	..................   Loot spawners   ................... */
/obj/effect/spawner/roguemap/loot
	icon_state = "lootblank"
	probby = 100

/obj/effect/spawner/roguemap/loot/common
	icon_state = "lootlow"
	spawned = list(
		/obj/item/roguecoin/copper/pile = 15,
		/obj/item/rogueweapon/knife/hunting = 5,
		/obj/item/rogueweapon/knife/dagger = 8,
		/obj/item/rogueweapon/sword/iron = 3,
		/obj/item/rogueweapon/axe/copper = 10,
		/obj/item/rogueweapon/mace = 5,
		/obj/item/clothing/suit/roguetown/armor/leather = 10,
		/obj/item/clothing/gloves/roguetown/chain/iron = 3,
		/obj/item/clothing/neck/roguetown/coif = 3,
		/obj/item/natural/poo = 5
		)

/obj/effect/spawner/roguemap/loot/medium
	icon_state = "lootmed"
	spawned = list(
		/obj/item/roguecoin/silver/pile = 15,
		/obj/item/rogueweapon/knife/dagger/steel = 4,
		/obj/item/rogueweapon/axe/iron = 10,
		/obj/item/ammo_holder/quiver/arrows = 5,
		/obj/item/rogueweapon/sword/short = 5,
		/obj/item/clothing/suit/roguetown/armor/cuirass/iron = 10,
		/obj/item/clothing/suit/roguetown/armor/gambeson = 10,
		/obj/item/clothing/gloves/roguetown/chain/iron = 3,
		/obj/item/clothing/neck/roguetown/gorget = 3,
		/obj/item/roguestatue/gold/loot = 1
		)

/obj/effect/spawner/roguemap/loot/rare
	icon_state = "loothigh"
	spawned = list(
		/obj/item/roguecoin/gold/pile = 15,
		/obj/item/rogueweapon/knife/dagger/silver = 5,
		/obj/item/rogueweapon/sword/long/greatsword = 3,
		/obj/item/rogueweapon/axe/iron = 10,
		/obj/item/ingot/gold = 5,
		/obj/item/clothing/head/roguetown/crown/circlet = 2,
		/obj/item/clothing/suit/roguetown/armor/medium/scale = 8,
		/obj/item/clothing/suit/roguetown/armor/plate = 8,
		/obj/item/clothing/gloves/roguetown/chain = 3,
		/obj/item/clothing/neck/roguetown/bevor = 3,
		/obj/item/clothing/under/roguetown/chainlegs = 5
		)

/obj/effect/spawner/roguemap/loot/magic
	icon_state = "lootmagic"
	spawned = list(
		/obj/item/clothing/ring/active/nomag = 20,
		/obj/item/clothing/ring/gold/protection = 10,
		/obj/item/clothing/ring/gold/ravox = 6,
		/obj/item/clothing/ring/silver/calm = 20,
		/obj/item/clothing/ring/silver/noc = 6,
		/obj/item/clothing/head/roguetown/crown/circlet/vision = 3,
		/obj/item/clothing/head/roguetown/crown/circlet/sleepless = 3,
		/obj/item/clothing/head/roguetown/crown/circlet/stink = 5,
		/obj/item/clothing/neck/roguetown/talkstone = 10
		)

/obj/effect/spawner/roguemap/loot/coin
	icon_state = "lootcoin"
	lootmax = 3
	spawned = list(
		/obj/item/roguecoin/gold/pile = 5,
		/obj/item/roguecoin/gold = 10,
		/obj/item/roguecoin/silver/pile = 20,
		/obj/item/roguecoin/silver = 25,
		/obj/item/roguecoin/copper/pile = 30,
		/obj/item/roguecoin/copper = 35
		)

/obj/effect/spawner/roguemap/loot/coin/low
	icon_state = "lootcoinlow"
	spawned = list(
		/obj/item/roguecoin/copper/pile = 75,
		/obj/item/roguecoin/copper = 25
		)

/obj/effect/spawner/roguemap/loot/coin/med
	icon_state = "lootcoinmed"
	spawned = list(
		/obj/item/roguecoin/silver/pile = 75,
		/obj/item/roguecoin/silver = 25
		)

/obj/effect/spawner/roguemap/loot/coin/high
	icon_state = "lootcoinhigh"
	spawned = list(
		/obj/item/roguecoin/gold/pile = 75,
		/obj/item/roguecoin/gold = 25
		)

/obj/effect/spawner/roguemap/loot/coin/absurd
	icon_state = "lootcoinabsurd"
	spawned = list(
		/obj/item/roguecoin/gold/pile = 50,
		/obj/item/roguegem = 50
		)

/obj/effect/spawner/roguemap/loot/weapon
	icon_state = "lootweapon"
	spawned = list(
		/obj/item/rogueweapon/mace/copperbludgeon = 15,
		/obj/item/rogueweapon/axe/copper = 15,
		/obj/item/rogueweapon/knife/copper = 15,
		/obj/item/rogueweapon/sword/long/rider/copper = 15,
		/obj/item/rogueweapon/sword/coppermesser = 15,
		/obj/item/rogueweapon/polearm/spear/stone/copper = 15,
		/obj/item/rogueweapon/axe/iron = 10,
		/obj/item/rogueweapon/polearm/halberd/bardiche = 10,
		/obj/item/rogueweapon/sword/rapier/ironestoc = 10,
		/obj/item/rogueweapon/polearm/eaglebeak/lucerne = 10,
		/obj/item/rogueweapon/mace = 10,
		/obj/item/rogueweapon/sword/scimitar/messer = 10,
		/obj/item/rogueweapon/flail/militia = 10,
		/obj/item/rogueweapon/sword/short = 10,
		/obj/item/rogueweapon/sword/long/greatsword/zwei = 10,
		/obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve = 10,
		/obj/item/gun/ballistic/revolver/grenadelauncher/bow = 10,
		/obj/item/gun/ballistic/revolver/grenadelauncher/bow/long = 5,
		/obj/item/gun/ballistic/revolver/grenadelauncher/crossbow = 5,
		/obj/item/rogueweapon/axe/steel = 5,
		/obj/item/rogueweapon/sword/long/greatsword = 5,
		/obj/item/rogueweapon/sword/rapier = 5,
		/obj/item/rogueweapon/sword/sabre = 5,
		/obj/item/rogueweapon/mace/goden/steel = 5,
		/obj/item/rogueweapon/mace/steel = 5,
		/obj/item/rogueweapon/hammer/sledgehammer/war = 5
		)

/obj/effect/spawner/roguemap/loot/armor
	icon_state = "lootarmor"
	spawned = list(
		/obj/item/clothing/mask/rogue/facemask/copper = 15,
		/obj/item/clothing/wrists/roguetown/bracers/copper = 15,
		/obj/item/clothing/head/roguetown/helmet/coppercap = 15,
		/obj/item/clothing/suit/roguetown/armor/cuirass/copperchest = 15,
		/obj/item/clothing/under/roguetown/chainlegs/iron = 10,
		/obj/item/clothing/suit/roguetown/armor/chainmail/iron = 10,
		/obj/item/clothing/suit/roguetown/armor/plate/iron = 10,
		/obj/item/clothing/head/roguetown/helmet/heavy/ironplate = 10,
		/obj/item/clothing/suit/roguetown/armor/leather/splint = 10,
		/obj/item/clothing/suit/roguetown/armor/brigandine = 5,
		/obj/item/clothing/head/roguetown/helmet/heavy/frog = 5,
		/obj/item/clothing/head/roguetown/helmet/visored/hounskull = 5,
		/obj/item/clothing/mask/rogue/facemask/steel = 5,
		/obj/item/clothing/suit/roguetown/armor/plate/full = 5,
		/obj/item/clothing/neck/roguetown/chaincoif = 5
		)

/obj/effect/spawner/roguemap/loot/food
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
		/obj/item/reagent_containers/food/snacks/rogue/meat/salami = 10,
		/obj/item/reagent_containers/food/snacks/hardtack = 10
		)

/obj/effect/spawner/roguemap/loot/potion_vitals
	icon_state = "lootpotion"
	spawned = list(
		/obj/item/reagent_containers/glass/bottle/rogue/healthpot = 10,
		/obj/item/reagent_containers/glass/bottle/rogue/stronghealthpot = 5,
		/obj/item/reagent_containers/glass/bottle/rogue/manapot = 10,
		/obj/item/reagent_containers/glass/bottle/rogue/strongmanapot = 5,
		/obj/item/reagent_containers/glass/bottle/rogue/stampot = 10,
		/obj/item/reagent_containers/glass/bottle/rogue/strongstampot = 5
	)

/obj/effect/spawner/roguemap/loot/potion_poisons
	icon_state = "lootpoison"
	spawned = list(
		/obj/item/reagent_containers/glass/bottle/rogue/poison = 10,
		/obj/item/reagent_containers/glass/bottle/rogue/strongpoison = 5,
		/obj/item/reagent_containers/glass/bottle/rogue/stampoison = 10,
		/obj/item/reagent_containers/glass/bottle/rogue/strongstampoison = 5,
		/obj/item/reagent_containers/glass/bottle/rogue/stampot = 10,
		/obj/item/reagent_containers/glass/bottle/rogue/strongstampot = 5
	)

/obj/effect/spawner/roguemap/loot/potion_ingredient
	icon_state = "lootpotioning"
	var/static/list/all_potion_ings = list()
	spawned = list()

/obj/effect/spawner/roguemap/loot/potion_ingredient/Initialize(mapload)
	if(!all_potion_ings.len)
		all_potion_ings = subtypesof(/obj/item/alch)
	if(!spawned.len)
		spawned = all_potion_ings.Copy()
	return ..()

/obj/effect/spawner/roguemap/loot/potion_ingredient/herb
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
	)
/obj/effect/spawner/roguemap/loot/potion_stats
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
/obj/effect/spawner/roguemap/sewerencounter
	icon_state = "srat"
	icon = 'icons/roguetown/mob/monster/rat.dmi'
	probby = 50
	color = "#ff0000"
	spawned = list(
		/obj/item/reagent_containers/food/snacks/smallrat = 30,
		/obj/item/reagent_containers/food/snacks/smallrat/dead = 10,
		/obj/item/organ/guts = 5,
		/obj/item/roguecoin/copper = 5,
		/obj/effect/gibspawner/generic = 5,
		/obj/effect/decal/remains/bigrat = 5,
		/mob/living/simple_animal/hostile/retaliate/rogue/bigrat = 1,
		)
