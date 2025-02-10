/*  * * * * * * * * * * * * * * * * * * * * * * * * *
 *													*		Animal that can locate hidden truffles in bog area dirt turf
 *					TRUFFLE PIG						*		Dig them up with a shovel, pig will demand truffles eventually or stop working
 *					 								*		Meant to help locate some extra food in the wilderness
 *													*
 * * * * * * * * * * * * * * * * * * * * * * * * * * */


//	........   Dirt changes   ................
/turf/open/floor/rogue/dirt //truffles, var needed for the sniffing function
	var/hidden_truffles
	var/hidden_toxicshrooms

/turf/open/floor/rogue/dirt/Initialize()
	. = ..()
	if(istype(loc, /area/rogue/outdoors/bog))
		if(!((locate(/obj/structure) in src) || (locate(/obj/machinery) in src)))
			if(prob(4))
				hidden_truffles = TRUE
			else if(prob(1))
				hidden_toxicshrooms = FALSE
			return

/turf/open/floor/rogue/dirt/attackby(obj/item/W, mob/user, params)
	if(hidden_truffles)
		if(istype(W, /obj/item/rogueweapon/shovel))
			playsound(get_turf(src),'sound/items/dig_shovel.ogg', 70, TRUE)
			if(user.used_intent.type == /datum/intent/shovelscoop)
				if(do_after(user, 3 SECONDS, src))
					new /obj/item/reagent_containers/food/snacks/truffles(get_turf(src))
					hidden_truffles = FALSE
	if(hidden_toxicshrooms)
		if(istype(W, /obj/item/rogueweapon/shovel))
			playsound(get_turf(src),'sound/items/dig_shovel.ogg', 70, TRUE)
			if(user.used_intent.type == /datum/intent/shovelscoop)
				if(do_after(user, 3 SECONDS, src))
					new /obj/item/reagent_containers/food/snacks/rogue/toxicshrooms(get_turf(src))
					hidden_toxicshrooms = FALSE
	else ..()


//	........   Truffles   ................
/obj/item/reagent_containers/food/snacks/truffles
	name = "truffles"
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "mushroom1_full"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	cooked_type = /obj/item/reagent_containers/food/snacks/cooked/truffle
	fried_type = /obj/item/reagent_containers/food/snacks/cooked/truffle
	cooked_smell = /datum/pollutant/food/truffles
	color = "#ab7d6f"
	tastes = list("mushroom" = 1)
	sellprice = 30
	rotprocess = null
/obj/item/reagent_containers/food/snacks/truffles/Initialize()
	icon_state = pick("mushroom1_full","mushroom1_full","mushroom1_full")
	. = ..()
/obj/item/reagent_containers/food/snacks/cooked/truffle
	name = "truffles"
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "mushroom1_full"
	eat_effect = /datum/status_effect/buff/foodbuff
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	color = "#835b4f"
	tastes = list("delicious truffles" = 2)
/obj/item/reagent_containers/food/snacks/cooked/truffle/Initialize()
	icon_state = pick("mushroom1_full","mushroom1_full","mushroom1_full")
	. = ..()

/obj/item/reagent_containers/food/snacks/rogue/toxicshrooms
	name = "truffles"
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "mushroom1_full"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/berrypoison = 5)
	cooked_type = /obj/item/reagent_containers/food/snacks/cooked/truffle_toxic
	fried_type = /obj/item/reagent_containers/food/snacks/cooked/truffle_toxic
	cooked_smell = /datum/pollutant/food/truffles
	color = "#ab7d6f"
	tastes = list("mushroom" = 1)
/obj/item/reagent_containers/food/snacks/rogue/toxicshrooms/Initialize()
	icon_state = pick("mushroom1_full","mushroom1_full","mushroom1_full")
	. = ..()
/obj/item/reagent_containers/food/snacks/cooked/truffle_toxic
	name = "truffles"
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "mushroom1_full"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/berrypoison = 6)
	color = "#835b4f"
/obj/item/reagent_containers/food/snacks/cooked/truffle_toxic/Initialize()
	icon_state = pick("mushroom1_full","mushroom1_full","mushroom1_full")
	. = ..()



//	........   Truffle Pig   ................
/mob/living/simple_animal/hostile/retaliate/rogue/trufflepig
	icon = 'icons/roguetown/mob/monster/piggie.dmi'
	name = "truffle pig"
	desc = "A hairy pig, bred for finding truffles in the bog."
	icon_state = "piggie_m"
	icon_living = "piggie_m"
	icon_dead = "piggie_dead"
	icon_gib = "piggie_dead"

	animal_species = /mob/living/simple_animal/hostile/retaliate/rogue/trufflepig
	faction = list("goats")
	footstep_type = FOOTSTEP_MOB_SHOE
	emote_see = list("eyes the surroundings.", "flicks its ears.")
	deathsound = 'sound/vo/mobs/pig/hangry.ogg'

	stop_automated_movement_when_pulled = TRUE
	response_help_continuous = "pets"
	response_help_simple = "give the signal to the"

	botched_butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/fatty = 3,
									/obj/item/reagent_containers/food/snacks/fat = 1,
									/obj/item/natural/hide = 1)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/fatty = 4,
							/obj/item/reagent_containers/food/snacks/fat = 2,
							/obj/item/natural/hide = 2)
	perfect_butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/fatty = 5,
							/obj/item/reagent_containers/food/snacks/fat = 3,
							/obj/item/natural/hide = 3)

	health = FEMALE_GOTE_HEALTH
	maxHealth = FEMALE_GOTE_HEALTH
	food_type = list(/obj/item/reagent_containers/food/snacks/truffles)
	pooptype = /obj/item/natural/poo/horse
	tame = TRUE
	remains_type = /obj/effect/decal/remains/pig

	base_intents = list(/datum/intent/simple/headbutt)
	attack_verb_continuous = "bites"
	attack_verb_simple = "bites"
	melee_damage_lower = 8
	melee_damage_upper = 14
	minimum_distance = 1
	TOTALSPD = 2
	TOTALCON = 8
	TOTALSTR = 12
	can_buckle = TRUE
	buckle_lying = FALSE
	can_saddle = TRUE
	var/hangry_meter = 0

/mob/living/simple_animal/hostile/retaliate/rogue/trufflepig/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/pig/hangry.ogg')
		if("pain")
			return pick('sound/vo/mobs/pig/grunt (1).ogg','sound/vo/mobs/pig/grunt (2).ogg')
		if("death")
			return pick('sound/vo/mobs/pig/grunt (1).ogg','sound/vo/mobs/pig/grunt (2).ogg')
		if("idle")
			return pick('sound/vo/mobs/pig/grunt (1).ogg','sound/vo/mobs/pig/grunt (2).ogg')

/mob/living/simple_animal/hostile/retaliate/rogue/trufflepig/taunted(mob/user)
	emote("aggro")
	Retaliate()
	GiveTarget(user)
	return

/obj/effect/decal/remains/pig
	name = "remains"
	gender = PLURAL
	icon_state = "skele"
	icon = 'icons/roguetown/mob/monster/cow.dmi'

/mob/living/simple_animal/hostile/retaliate/rogue/trufflepig/tamed(mob/user)
	..()
	deaggroprob = 20
	if(can_buckle)
		var/datum/component/riding/D = LoadComponent(/datum/component/riding)
		D.set_riding_offsets(RIDING_OFFSET_ALL, list(TEXT_NORTH = list(0, 4), TEXT_SOUTH = list(0, 4), TEXT_EAST = list(-2, 4), TEXT_WEST = list(2, 4)))
		D.set_vehicle_dir_layer(SOUTH, ABOVE_MOB_LAYER)
		D.set_vehicle_dir_layer(NORTH, OBJ_LAYER)
		D.set_vehicle_dir_layer(EAST, OBJ_LAYER)
		D.set_vehicle_dir_layer(WEST, OBJ_LAYER)


/mob/living/simple_animal/hostile/retaliate/rogue/trufflepig/Life()
	. = ..()
	if((src.loc) && isturf(src.loc))
		for(var/obj/item/reagent_containers/food/snacks/truffles/M in view(1,src))
			if(Adjacent(M))
				walk_towards(src, M, 1)
				sleep(3)
				visible_message("<span class='notice'>The pig devours the vulnerable truffles!</span>")
				stop_automated_movement = 0
				hangry_meter = 0
				playsound(src,'sound/misc/eat.ogg', rand(30,60), TRUE)
				qdel(M)
				break

/mob/living/simple_animal/hostile/retaliate/rogue/trufflepig/attack_hand(mob/living/carbon/human/M)
	. = ..()
	hangry_meter += 1
	if(hangry_meter > 9)
		to_chat(M, "<span class='notice'>The pig squeals in anger. Its sulking and refusing to work until it gets delicious truffles.</span>")
		playsound(get_turf(src), 'sound/vo/mobs/pig/hangry.ogg', 120, TRUE, -1)
		return
	if(M.used_intent.type == INTENT_HELP)
		playsound(get_turf(src), pick('sound/vo/mobs/pig/grunt (1).ogg','sound/vo/mobs/pig/grunt (2).ogg'), 100, TRUE, -1)
		dir = pick(GLOB.cardinals)
		step(src, dir)
		playsound(src, 'sound/items/sniff.ogg', 60, FALSE)
		sleep(10)
		dir = pick(GLOB.cardinals)
		step(src, dir)
		playsound(src, 'sound/items/sniff.ogg', 60, FALSE)
		sleep(10)
		dir = pick(GLOB.cardinals)
		playsound(get_turf(src), pick('sound/vo/mobs/pig/grunt (1).ogg','sound/vo/mobs/pig/grunt (2).ogg'), 100, TRUE, -1)
		var/turf/t = get_turf(src)
		trufflesearch(t, 5)

/mob/living/simple_animal/hostile/retaliate/rogue/trufflepig/attackby(obj/item/O, mob/user, params)
	if(istype(O, /obj/item/reagent_containers/food/snacks/truffles))
		visible_message("<span class='notice'>The pig munches the truffles, looking happy.</span>")
		hangry_meter = 0
		playsound(src,'sound/misc/eat.ogg', rand(30,60), TRUE)
		qdel(O)
	if(istype(O, /obj/item/reagent_containers/food/snacks/rogue/toxicshrooms))
		visible_message("<span class='notice'>The pig munches the truffles reluctantly.</span>")
		playsound(src,'sound/misc/eat.ogg', rand(30,60), TRUE)
		qdel(O)
		playsound(get_turf(src), 'sound/vo/mobs/pig/hangry.ogg', 100, TRUE, -1)
		sleep(20)
		playsound(get_turf(src), 'sound/vo/mobs/pig/hangry.ogg', 100, TRUE, -1)
		visible_message("<span class='notice'>The pig shivers.</span>")
		sleep(10)
		death()
	else
		return ..()


//	........   Truffle Search   ................
/mob/living/simple_animal/hostile/retaliate/rogue/trufflepig/proc/trufflesearch(turf/T, range = world.view)
	var/list/found_stuff = list()
	for(var/turf/open/floor/rogue/dirt/M in range(range, T))
		if(M.hidden_truffles)
			found_stuff += M
	if(LAZYLEN(found_stuff))
		for(var/turf/open/floor/rogue/dirt/M in found_stuff)
			var/obj/effect/temp_visual/truffle_overlay/oldC = locate(/obj/effect/temp_visual/truffle_overlay) in M
			if(oldC)
				qdel(oldC)
			new /obj/effect/temp_visual/truffle_overlay(M)

/obj/effect/temp_visual/truffle_overlay
	plane = FULLSCREEN_PLANE
	layer = FLASH_LAYER
	icon = 'icons/roguetown/mob/trufflesniff.dmi'
	icon_state = "foundsome"
	appearance_flags = 0 //to avoid having TILE_BOUND in the flags, so that the 480x480 icon states let you see it no matter where you are
	duration = 35
	pixel_x = -224
	pixel_y = -224
