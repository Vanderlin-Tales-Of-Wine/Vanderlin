/mob/living/simple_animal/hostile/retaliate/rogue/bogbug
	icon = 'icons/roguetown/mob/monster/bogbug.dmi'
	name = "bog bug"
	desc = "A vile insect, skittering forward on spindly, hairy legs. Enjoys the flesh of sapients as much as it enjoys its fellow swamp-dwellers."
	icon_state = "bogbug"
	icon_living = "bogbug"
	icon_dead = "bogbugdead"

	faction = list("bugs")
	emote_hear = null
	emote_see = null
	turns_per_move = 6
	see_in_dark = 9
	move_to_delay = 1
	vision_range = 9
	aggro_vision_range = 9

	botched_butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/strange= 1)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/strange= 1,
						/obj/item/natural/hide = 1)
	perfect_butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/strange = 2,
						/obj/item/natural/hide = 2)

	health = BOGBUG_HEALTH
	maxHealth = BOGBUG_HEALTH
	food_type = list(/obj/item/reagent_containers/food/snacks/rogue/meat,
					/obj/item/bodypart,
					/obj/item/organ)

	base_intents = list(/datum/intent/simple/claw, /datum/intent/simple/stab)
	attack_sound = list('sound/vo/mobs/bogbug/bogbugattack1.ogg','sound/vo/mobs/bogbug/bogbugattack2.ogg','sound/vo/mobs/bogbug/bogbugattack3.ogg')
	melee_damage_lower = 25
	melee_damage_upper = 35

	TOTALCON = 13
	TOTALSTR = 10
	TOTALSPD = 15
	TOTALEND = 15

	retreat_distance = 2
	minimum_distance = 1
	deaggroprob = 0
	defprob = 30
	defdrain = 8
	del_on_deaggro = 999 SECONDS
	retreat_health = 0
	food = 0

	dodgetime = 20
	aggressive = 1
//	stat_attack = UNCONSCIOUS
	remains_type = /obj/effect/decal/remains/bogbug
	body_eater = TRUE

	ai_controller = /datum/ai_controller/bog_bug
	AIStatus = AI_OFF
	can_have_ai = FALSE

/obj/effect/decal/remains/bogbug
	name = "remains"
	gender = PLURAL
	icon_state = "bones"
	icon = 'icons/roguetown/mob/monster/vol.dmi'

/mob/living/simple_animal/hostile/retaliate/rogue/bogbug/Initialize()
	. = ..()
	gender = MALE
	ai_controller.set_blackboard_key(BB_BASIC_FOODS, food_type)

/mob/living/simple_animal/hostile/retaliate/rogue/bogbug/death(gibbed)
	..()
	update_icon()


/mob/living/simple_animal/hostile/retaliate/rogue/bogbug/update_icon()
	cut_overlays()
	..()

/mob/living/simple_animal/hostile/retaliate/rogue/bogbug/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/bogbug/bogbug1.ogg','sound/vo/mobs/bogbug/bogbug2.ogg','sound/vo/mobs/bogbug/bogbug3.ogg')
		if("pain")
			return pick('sound/vo/mobs/bogbug/bogbughurt2.ogg')
		if("death")
			return pick('sound/vo/mobs/bogbug/bogbughurt1.ogg')
		if("idle")
			return pick('sound/vo/mobs/bogbug/bogbugidle.ogg')
		if("cidle")
			return pick('sound/vo/mobs/bogbug/bogbug3.ogg','sound/vo/mobs/bogbug/bogbugidle.ogg')

/mob/living/simple_animal/hostile/retaliate/rogue/bogbug/taunted(mob/user)
	emote("aggro")
	Retaliate()
	GiveTarget(user)
	return

/mob/living/simple_animal/hostile/retaliate/rogue/bogbug/Life()
	..()
	if(pulledby)
		Retaliate()
		GiveTarget(pulledby)

/mob/living/simple_animal/hostile/retaliate/rogue/bogbug/simple_limb_hit(zone)
	if(!zone)
		return ""
	switch(zone)
		if(BODY_ZONE_PRECISE_R_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_L_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_NOSE)
			return "nose"
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

