/mob/living/simple_animal/hostile/retaliate/rogue/goat/Initialize()
	. = ..()
	GLOB.farm_animals++
	if(tame)
		tamed(owner)

/mob/living/simple_animal/hostile/retaliate/rogue/goat/Destroy()
	..()
	GLOB.farm_animals = max(GLOB.farm_animals - 1, 0)

/mob/living/simple_animal/hostile/retaliate/rogue/goat/find_food()
	..()
	var/obj/structure/spacevine/SV = locate(/obj/structure/spacevine) in loc
	if(SV)
		SV.eat(src)
		food = max(food + 30, 100)

/mob/living/simple_animal/hostile/retaliate/rogue/goat/tamed(mob/user)
	..()
	deaggroprob = 50
	if(can_buckle)
		var/datum/component/riding/D = LoadComponent(/datum/component/riding)
		D.set_riding_offsets(RIDING_OFFSET_ALL, list(TEXT_NORTH = list(0, 6), TEXT_SOUTH = list(0, 6), TEXT_EAST = list(-2, 6), TEXT_WEST = list(2, 6)))
		D.set_vehicle_dir_layer(SOUTH, OBJ_LAYER)
		D.set_vehicle_dir_layer(NORTH, OBJ_LAYER)
		D.set_vehicle_dir_layer(EAST, OBJ_LAYER)
		D.set_vehicle_dir_layer(WEST, OBJ_LAYER)


/mob/living/simple_animal/hostile/retaliate/rogue/goat/update_icon()
	cut_overlays()
	..()
	if(stat != DEAD)
		if(ssaddle)
			var/mutable_appearance/saddlet = mutable_appearance(icon, "saddle-f-above", 4.3)
			add_overlay(saddlet)
			saddlet = mutable_appearance(icon, "saddle-f")
			add_overlay(saddlet)
		if(has_buckled_mobs())
			var/mutable_appearance/mounted = mutable_appearance(icon, "goat_mounted", 4.3)
			add_overlay(mounted)



/mob/living/simple_animal/hostile/retaliate/rogue/goat/Life()
	..()
	if(stat == CONSCIOUS)
		if(!pulledby)
			for(var/direction in shuffle(list(1,2,4,8,5,6,9,10)))
				var/step = get_step(src, direction)
				if(step)
					if(locate(/obj/structure/spacevine) in step || locate(/obj/structure/kneestingers) in step)
						Move(step, get_dir(src, step))

/mob/living/simple_animal/hostile/retaliate/rogue/goat/UniqueAttack()
	if(istype(target, /obj/structure/spacevine))
		var/obj/structure/spacevine/SV = target
		SV.eat(src)
		food = max(food + 30, food_max + 50)
		return
	return ..()

/mob/living/simple_animal/hostile/retaliate/rogue/goat
	icon = 'icons/roguetown/mob/monster/gote.dmi'
	name = "gote"
	desc = ""
	icon_state = "goat"
	icon_living = "goat"
	icon_dead = "goat_dead"
	icon_gib = "goat_gib"

	animal_species = /mob/living/simple_animal/hostile/retaliate/rogue/goatmale
	faction = list("goats")
	gender = FEMALE
	footstep_type = FOOTSTEP_MOB_SHOE
	emote_see = list("shakes her head.", "chews her cud.")

	botched_butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 2,
						/obj/item/natural/hide = 1,
						/obj/item/alch/bone = 1)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 4,
						/obj/item/reagent_containers/food/snacks/fat = 2,
						/obj/item/natural/hide = 2,
						/obj/item/natural/fur/gote = 1,
						/obj/item/alch/sinew = 2,
						/obj/item/alch/bone = 1)
	perfect_butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 6,
						/obj/item/reagent_containers/food/snacks/fat = 2,
						/obj/item/natural/hide = 2,
						/obj/item/natural/fur/gote = 2,
						/obj/item/alch/sinew = 2,
						/obj/item/alch/bone = 1,
						/obj/item/natural/head/gote = 1)

	health = FEMALE_GOTE_HEALTH
	maxHealth = FEMALE_GOTE_HEALTH
	food_type = list(/obj/item/reagent_containers/food/snacks/produce/wheat,
					/obj/item/reagent_containers/food/snacks/produce/oat,
					/obj/item/reagent_containers/food/snacks/produce/apple,
					/obj/item/reagent_containers/food/snacks/produce/turnip,
					/obj/item/reagent_containers/food/snacks/produce/cabbage,
					/obj/item/reagent_containers/food/snacks/produce/jacksberry)
	tame_chance = 25
	bonus_tame_chance = 15
	pooptype = /obj/item/natural/poo/horse
	var/milkies = TRUE

	base_intents = list(/datum/intent/simple/headbutt)
	attack_verb_continuous = "headbutts"
	attack_verb_simple = "headbutt"
	melee_damage_lower = 8
	melee_damage_upper = 12
	TOTALSPD = 4
	TOTALCON = 4
	TOTALSTR = 4
	buckle_lying = FALSE
	childtype = list(/mob/living/simple_animal/hostile/retaliate/rogue/goat/goatlet = 90, /mob/living/simple_animal/hostile/retaliate/rogue/goat/goatlet/boy = 10)
	can_buckle = TRUE
	remains_type = /obj/effect/decal/remains/cow



/mob/living/simple_animal/hostile/retaliate/rogue/goat/Initialize()
	. = ..()
	if(milkies)
		gudder = new()

/mob/living/simple_animal/hostile/retaliate/rogue/goat/Destroy()
	qdel(gudder)
	gudder = null
	..()

/mob/living/simple_animal/hostile/retaliate/rogue/goat/attackby(obj/item/O, mob/user, params)
	if(!stat && istype(O, /obj/item/reagent_containers/glass))
		changeNext_move(20) // milking sound length
		if(gudder)
			gudder.milkAnimal(O, user)
			return 1
	else
		return ..()

/mob/living/simple_animal/hostile/retaliate/rogue/goat/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/goat/aggro (1).ogg','sound/vo/mobs/goat/aggro (2).ogg')
		if("pain")
			return pick('sound/vo/mobs/goat/pain (1).ogg','sound/vo/mobs/goat/pain (2).ogg')
		if("death")
			return pick('sound/vo/mobs/goat/death (1).ogg','sound/vo/mobs/goat/death (2).ogg')
		if("idle")
			return pick('sound/vo/mobs/goat/idle (1).ogg','sound/vo/mobs/goat/idle (2).ogg','sound/vo/mobs/goat/idle (3).ogg')

/mob/living/simple_animal/hostile/retaliate/rogue/goat/simple_limb_hit(zone)
	if(!zone)
		return ""
	switch(zone)
		if(BODY_ZONE_PRECISE_R_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_L_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_NOSE)
			return "snout"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "snout"
		if(BODY_ZONE_PRECISE_SKULL)
			return "head"
		if(BODY_ZONE_PRECISE_EARS)
			return "head"
		if(BODY_ZONE_PRECISE_NECK)
			return "neck"
		if(BODY_ZONE_PRECISE_L_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_R_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_L_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_R_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_STOMACH)
			return "stomach"
		if(BODY_ZONE_HEAD)
			return "head"
		if(BODY_ZONE_R_LEG)
			return "leg"
		if(BODY_ZONE_L_LEG)
			return "leg"
		if(BODY_ZONE_R_ARM)
			return "foreleg"
		if(BODY_ZONE_L_ARM)
			return "foreleg"

	return ..()

/mob/living/simple_animal/hostile/retaliate/rogue/goatmale
	icon = 'icons/roguetown/mob/monster/gote.dmi'
	name = "male gote"
	icon_state = "goatmale"
	icon_living = "goatmale"
	icon_dead = "goatmale_dead"
	icon_gib = "goatmale_gib"

	faction = list("goats")
	footstep_type = FOOTSTEP_MOB_SHOE
	emote_see = list("shakes his head.", "chews his cud.")
	turns_per_move = 3

	botched_butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 3,
						/obj/item/natural/hide = 1,
						/obj/item/alch/sinew = 1,
						/obj/item/alch/bone = 1)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 4,
						/obj/item/reagent_containers/food/snacks/fat = 1,
						/obj/item/natural/hide = 2,
						/obj/item/natural/fur/gote = 1,
						/obj/item/alch/sinew = 2,
						/obj/item/alch/bone = 1)
	perfect_butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 6,
						/obj/item/reagent_containers/food/snacks/fat = 2,
						/obj/item/natural/hide = 2,
						/obj/item/natural/fur/gote = 2,
						/obj/item/alch/sinew = 2,
						/obj/item/alch/bone = 1,
						/obj/item/natural/head/gote = 1)

	health = MALE_GOTE_HEALTH
	maxHealth = MALE_GOTE_HEALTH
	food_type = list(/obj/item/reagent_containers/food/snacks/produce/wheat,
					/obj/item/reagent_containers/food/snacks/produce/oat,
					/obj/item/reagent_containers/food/snacks/produce/apple,
					/obj/item/reagent_containers/food/snacks/produce/turnip,
					/obj/item/reagent_containers/food/snacks/produce/cabbage,
					/obj/item/reagent_containers/food/snacks/produce/jacksberry)
	pooptype = /obj/item/natural/poo/horse

	base_intents = list(/datum/intent/simple/headbutt)
	attack_verb_continuous = "headbutts"
	attack_verb_simple = "headbutt"
	melee_damage_lower = 14
	melee_damage_upper = 22
	retreat_distance = 0
	minimum_distance = 0
	TOTALCON = 7
	TOTALSTR = 12
	TOTALSPD = 2

	can_buckle = TRUE
	buckle_lying = FALSE
	tame_chance = 25
	bonus_tame_chance = 15
	remains_type = /obj/effect/decal/remains/cow

/mob/living/simple_animal/hostile/retaliate/rogue/goatmale/update_icon()
	cut_overlays()
	..()
	if(stat != DEAD)
		if(ssaddle)
			var/mutable_appearance/saddlet = mutable_appearance(icon, "saddle-above", 4.3)
			add_overlay(saddlet)
			saddlet = mutable_appearance(icon, "saddle")
			add_overlay(saddlet)
		if(has_buckled_mobs())
			var/mutable_appearance/mounted = mutable_appearance(icon, "goatmale_mounted", 4.3)
			add_overlay(mounted)

/mob/living/simple_animal/hostile/retaliate/rogue/goatmale/tamed(mob/user)
	..()
	deaggroprob = 20
	if(can_buckle)
		var/datum/component/riding/D = LoadComponent(/datum/component/riding)
		D.set_riding_offsets(RIDING_OFFSET_ALL, list(TEXT_NORTH = list(0, 6), TEXT_SOUTH = list(0, 6), TEXT_EAST = list(-2, 6), TEXT_WEST = list(2, 6)))
		D.set_vehicle_dir_layer(SOUTH, OBJ_LAYER)
		D.set_vehicle_dir_layer(NORTH, OBJ_LAYER)
		D.set_vehicle_dir_layer(EAST, OBJ_LAYER)
		D.set_vehicle_dir_layer(WEST, OBJ_LAYER)

/mob/living/simple_animal/hostile/retaliate/rogue/goatmale/Initialize()
	..()
	GLOB.farm_animals++
	if(tame)
		tamed(owner)

/mob/living/simple_animal/hostile/retaliate/rogue/goatmale/Destroy()
	..()
	GLOB.farm_animals = max(GLOB.farm_animals - 1, 0)

/mob/living/simple_animal/hostile/retaliate/rogue/goatmale/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/goat/aggro (1).ogg','sound/vo/mobs/goat/aggro (2).ogg')
		if("pain")
			return pick('sound/vo/mobs/goat/pain (1).ogg','sound/vo/mobs/goat/pain (2).ogg')
		if("death")
			return pick('sound/vo/mobs/goat/death (1).ogg','sound/vo/mobs/goat/death (2).ogg')
		if("idle")
			return pick('sound/vo/mobs/goat/idle (1).ogg','sound/vo/mobs/goat/idle (2).ogg','sound/vo/mobs/goat/idle (3).ogg')

/mob/living/simple_animal/hostile/retaliate/rogue/goatmale/taunted(mob/user)
	emote("aggro")
	Retaliate()
	GiveTarget(user)
	return

/mob/living/simple_animal/hostile/retaliate/rogue/goatmale/eat_plants()
	..()
	var/obj/structure/spacevine/SV = locate(/obj/structure/spacevine) in loc
	if(SV)
		SV.eat(src)
		food = max(food + 30, 100)

/mob/living/simple_animal/hostile/retaliate/rogue/goatmale/Life()
	..()
	if(stat == CONSCIOUS)
		if(!pulledby)
			for(var/direction in shuffle(list(1,2,4,8,5,6,9,10)))
				var/step = get_step(src, direction)
				if(step)
					if(locate(/obj/structure/spacevine) in step || locate(/obj/structure/kneestingers) in step)
						Move(step, get_dir(src, step))

/mob/living/simple_animal/hostile/retaliate/rogue/goatmale/simple_limb_hit(zone)
	if(!zone)
		return ""
	switch(zone)
		if(BODY_ZONE_PRECISE_R_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_L_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_NOSE)
			return "snout"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "snout"
		if(BODY_ZONE_PRECISE_SKULL)
			return "head"
		if(BODY_ZONE_PRECISE_EARS)
			return "head"
		if(BODY_ZONE_PRECISE_NECK)
			return "neck"
		if(BODY_ZONE_PRECISE_L_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_R_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_L_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_R_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_STOMACH)
			return "stomach"
		if(BODY_ZONE_HEAD)
			return "head"
		if(BODY_ZONE_R_LEG)
			return "leg"
		if(BODY_ZONE_L_LEG)
			return "leg"
		if(BODY_ZONE_R_ARM)
			return "foreleg"
		if(BODY_ZONE_L_ARM)
			return "foreleg"
	return ..()

/mob/living/simple_animal/hostile/retaliate/rogue/goat/goatlet
	icon = 'icons/roguetown/mob/monster/gote.dmi'
	name = "gotelet"
	desc = ""
	icon_state = "goatlet"
	icon_living = "goatlet"
	icon_dead = "goatlet_dead"
	icon_gib = "goatlet_gib"

	animal_species = null
	gender = FEMALE
	mob_size = MOB_SIZE_SMALL
	pass_flags = PASSTABLE | PASSMOB

	botched_butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/mince/beef = 1)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 1)
	perfect_butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 1,
							/obj/item/natural/hide = 1)

	health = CALF_HEALTH
	maxHealth = CALF_HEALTH
	milkies = FALSE

	base_intents = list(/datum/intent/simple/headbutt)
	melee_damage_lower = 1
	melee_damage_upper = 6
	TOTALCON = 5
	TOTALSTR = 5
	TOTALSPD = 5
	defprob = 50

	adult_growth = /mob/living/simple_animal/hostile/retaliate/rogue/goat
	can_buckle = FALSE



/mob/living/simple_animal/hostile/retaliate/rogue/goat/goatlet/boy
	icon_state = "goatletboy"
	icon_living = "goatletboy"
	icon_dead = "goatletboy_dead"
	icon_gib = "goatletboyt_gib"

	gender = MALE

	adult_growth = /mob/living/simple_animal/hostile/retaliate/rogue/goatmale

