
/mob/living/simple_animal/hostile/retaliate/rogue/chicken
	name = "\improper chicken"
	desc = "A fat and mostly flightless bird. They produce eggs, or 'cackleberries'."
	icon = 'icons/roguetown/mob/monster/chicken.dmi'
	icon_state = "chicken_brown"
	icon_living = "chicken_brown"
	icon_dead = "chicken_brown_dead"

	density = FALSE
	gender = FEMALE
	pass_flags = PASSTABLE | PASSMOB
	mob_size = MOB_SIZE_SMALL
	ventcrawler = VENTCRAWLER_ALWAYS
	emote_see = list("pecks at the ground.","flaps its wings viciously.")
	speak_chance = 2
	faction = list("chickens")

	botched_butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/poultry/cutlet = 1)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/fat = 1,
						/obj/item/reagent_containers/food/snacks/rogue/meat/poultry = 1,
						/obj/item/natural/feather = 1)
	perfect_butcher_results = list(/obj/item/reagent_containers/food/snacks/fat = 1,
						/obj/item/reagent_containers/food/snacks/rogue/meat/poultry = 1,
						/obj/item/reagent_containers/food/snacks/rogue/meat/poultry/cutlet = 1,
						/obj/item/natural/feather = 1)

	var/egg_type = /obj/item/reagent_containers/food/snacks/egg
	food_type = list(/obj/item/reagent_containers/food/snacks/produce/jacksberry,
					/obj/item/natural/worms, // well this works for domesticating but to actually eat it has to be a reagen_container/food object. Leaving it for now.
					/obj/item/reagent_containers/food/snacks/produce/wheat,
					/obj/item/reagent_containers/food/snacks/produce/oat)

	health = CHICKEN_HEALTH
	maxHealth = CHICKEN_HEALTH

	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"

	base_intents = list(/datum/intent/simple/peck)
	melee_damage_lower = 1
	melee_damage_upper = 5

	pooptype = /obj/item/natural/poo/horse

	var/eggsFertile = TRUE
	var/body_color
	var/icon_prefix = "chicken"
	var/list/layMessage = EGG_LAYING_MESSAGES
	var/list/validColors = list("brown","black","white")
	var/static/chicken_count = 0

	TOTALCON = 1
	TOTALSTR = 1
	TOTALSPD = 5
	tame = TRUE

	AIStatus = AI_STATUS_OFF
	can_have_ai = FALSE
	ai_controller = /datum/ai_controller/basic_controller/chicken

	var/chicken_init = TRUE

/mob/living/simple_animal/hostile/retaliate/rogue/chicken/get_sound(input)
	switch(input)
		if("pain")
			return pick('sound/vo/mobs/chikn/pain (1).ogg','sound/vo/mobs/chikn/pain (2).ogg','sound/vo/mobs/chikn/pain (3).ogg')
		if("death")
			return 'sound/vo/mobs/chikn/death.ogg'
		if("idle")
			return pick('sound/vo/mobs/chikn/idle (1).ogg','sound/vo/mobs/chikn/idle (2).ogg','sound/vo/mobs/chikn/idle (3).ogg','sound/vo/mobs/chikn/idle (4).ogg','sound/vo/mobs/chikn/idle (5).ogg','sound/vo/mobs/chikn/idle (6).ogg')


/mob/living/simple_animal/hostile/retaliate/rogue/chicken/simple_limb_hit(zone)
	if(!zone)
		return ""
	switch(zone)
		if(BODY_ZONE_PRECISE_R_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_L_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_NOSE)
			return "beak"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "beak"
		if(BODY_ZONE_PRECISE_SKULL)
			return "head"
		if(BODY_ZONE_PRECISE_EARS)
			return "head"
		if(BODY_ZONE_PRECISE_NECK)
			return "neck"
		if(BODY_ZONE_PRECISE_L_HAND)
			return "wing"
		if(BODY_ZONE_PRECISE_R_HAND)
			return "wing"
		if(BODY_ZONE_PRECISE_L_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_R_FOOT)
			return "leg"
		if(BODY_ZONE_HEAD)
			return "head"
		if(BODY_ZONE_R_LEG)
			return "leg"
		if(BODY_ZONE_L_LEG)
			return "leg"
		if(BODY_ZONE_R_ARM)
			return "wing"
		if(BODY_ZONE_L_ARM)
			return "wing"
	return ..()

/mob/living/simple_animal/hostile/retaliate/rogue/chicken/Initialize()
	. = ..()
	ai_controller.set_blackboard_key(BB_BASIC_FOODS, food_type)
	if(chicken_init)
		if(!body_color)
			body_color = pick(validColors)
		icon_state = "[icon_prefix]_[body_color]"
		icon_living = "[icon_prefix]_[body_color]"
		icon_dead = "[icon_prefix]_[body_color]_dead"
	pixel_x = rand(-6, 6)
	pixel_y = rand(0, 10)
	++chicken_count

/mob/living/simple_animal/hostile/retaliate/rogue/chicken/Destroy()
	--chicken_count
	return ..()

/mob/living/simple_animal/hostile/retaliate/rogue/chicken/Life()
	..()
	if(!stat && (production > 29) && egg_type && isturf(loc) && !enemies.len)
		if(!stop_automated_movement)
			//look for nests
			var/list/foundnests = list()
			for(var/obj/structure/fluff/nest/N in oview(src))
				foundnests += N
			//if no nests, look for chaff and build one
			if(!foundnests.len)
				new /obj/structure/fluff/nest(loc)
				visible_message("<span class='notice'>[src] builds a nest.</span>")

/mob/living/simple_animal/hostile/retaliate/rogue/chicken/proc/hatch_eggs()
	for(var/obj/item/reagent_containers/food/snacks/egg/egg in loc)
		if(!egg.fertile)
			continue
		egg.hatch(src)
		qdel(egg)


/mob/living/simple_animal/hostile/retaliate/rogue/chicken/chick
	name = "chick"
	desc = "So cute!"
	icon_state = "chick"
	icon_living = "chick"
	icon_dead = "chick_dead"

	density = FALSE
	gender = FEMALE
	pass_flags = PASSTABLE | PASSMOB

	botched_butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/poultry/cutlet = 1)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/fat = 1,
						/obj/item/reagent_containers/food/snacks/rogue/meat/poultry = 1,
						/obj/item/natural/feather = 1)
	perfect_butcher_results = list(/obj/item/reagent_containers/food/snacks/fat = 1,
						/obj/item/reagent_containers/food/snacks/rogue/meat/poultry = 1,
						/obj/item/reagent_containers/food/snacks/rogue/meat/poultry/cutlet = 1,
						/obj/item/natural/feather = 1)

	health = CHICKEN_HEALTH / 2
	maxHealth = CHICKEN_HEALTH / 2

	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"

	base_intents = list(/datum/intent/simple/peck)
	melee_damage_lower = 1
	melee_damage_upper = 5
	defprob = 50
	adult_growth = /mob/living/simple_animal/hostile/retaliate/rogue/chicken

	ai_controller = /datum/ai_controller/basic_controller/chicken/baby
	chicken_init = FALSE

/obj/structure/fluff/nest
	name = "nest"
	desc = "a chicken's nest."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "nest"
	density = FALSE
	anchored = TRUE
	can_buckle = 1
	layer = 2.8
	max_integrity = 40
//  removed to prevent infinite fiber farming
//	static_debris = list(/obj/item/natural/fibers = 1)
