/mob/living/simple_animal/hostile/retaliate/cavebear
	icon = 'modular/stonekeep/icons/mobs/bear.dmi'
	name = "cave bear"
	desc = "Feral rage, hunger, these beasts are powerful and fast."
	icon_state = "bear"
	icon_living = "bear"
	icon_dead = "bear-dead"
	pixel_x = -32
	pixel_y = 1

	faction = list("bears")
	turns_per_move = 4
	move_to_delay = 2
	vision_range = 5
	aggro_vision_range = 5

	botched_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/steak = 2)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/steak = 4,
						/obj/item/alch/sinew = 2,
						/obj/item/bearpelt = 1)
	perfect_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/steak = 5,
						/obj/item/alch/sinew = 4,
						/obj/item/bearpelt = 1)

	health = BOGTROLL_HEALTH
	maxHealth = BOGTROLL_HEALTH
	food_type = list(/obj/item/bodypart,
					/obj/item/organ,
					/obj/item/reagent_containers/food/snacks/meat)

	base_intents = list(/datum/intent/simple/trollrip)
	attack_sound = list('modular/stonekeep/sound/vo/mobs/gator/gatorattack1.ogg', 'modular/stonekeep/sound/vo/mobs/gator/gatorattack2.ogg')
	melee_damage_lower = 35
	melee_damage_upper = 40

	TOTALCON = 14
	TOTALSTR = 18
	TOTALSPD = 6
	TOTALEND = 8

	retreat_distance = 0
	minimum_distance = 0
	deaggroprob = 0
	defprob = 20
	defdrain = 5
	attack_same = FALSE
	retreat_health = 0.2

	aggressive = TRUE
	stat_attack = UNCONSCIOUS
	body_eater = TRUE

	ai_controller = /datum/ai_controller/volf
	AIStatus = AI_OFF
	can_have_ai = FALSE

/mob/living/simple_animal/hostile/retaliate/gator/Initialize()
	. = ..()
	gender = MALE
	if(prob(33))
		gender = FEMALE
	update_icon()

	AddElement(/datum/element/ai_flee_while_injured, 0.75, retreat_health)
	ai_controller.set_blackboard_key(BB_BASIC_FOODS, food_type)
	//ADD_TRAIT(src, TRAIT_GENERIC) // to-do

/mob/living/simple_animal/hostile/retaliate/gator/find_food()
	. = ..()
	if(!.)
		return eat_bodies()

/mob/living/simple_animal/hostile/retaliate/gator/death(gibbed)
	..()
	update_icon()


/mob/living/simple_animal/hostile/retaliate/gator/update_icon()
	cut_overlays()
	..()

/mob/living/simple_animal/hostile/retaliate/gator/get_sound(input)
	switch(input)
		if("aggro")
			return pick('modular/stonekeep/sound/vo/mobs/gator/gatoraggro1.ogg','modular/stonekeep/sound/vo/mobs/gator/gatoraggro2.ogg','modular/stonekeep/sound/vo/mobs/gator/gatoraggro3.ogg','modular/stonekeep/sound/vo/mobs/gator/gatoraggro4.ogg')
		if("pain")
			return pick('modular/stonekeep/sound/vo/mobs/gator/gatorpain.ogg')
		if("death")
			return pick('modular/stonekeep/sound/vo/mobs/gator/gatordeath.ogg')
		if("idle")
			return pick('modular/stonekeep/sound/vo/mobs/gator/gatoridle1.ogg')

/mob/living/simple_animal/hostile/retaliate/gator/taunted(mob/user)
	emote("aggro")
	Retaliate()
	GiveTarget(user)
	return

/mob/living/simple_animal/hostile/retaliate/gator/Life()
	..()
	if(pulledby)
		Retaliate()
		GiveTarget(pulledby)

/mob/living/simple_animal/hostile/retaliate/gator/simple_limb_hit(zone)
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
			return "mouth"
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
		if(BODY_ZONE_PRECISE_GROIN)
			return "tail"
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
