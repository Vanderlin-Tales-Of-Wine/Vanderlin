/datum/component/riding/gator/Initialize()
	. = ..()
	set_riding_offsets(RIDING_OFFSET_ALL, list(TEXT_NORTH = list(0, 25), TEXT_SOUTH = list(2, 25), TEXT_EAST = list(8, 20), TEXT_WEST = list(0, 20)))
	set_vehicle_dir_layer(SOUTH, OBJ_LAYER)
	set_vehicle_dir_layer(NORTH, OBJ_LAYER)
	set_vehicle_dir_layer(EAST, OBJ_LAYER)
	set_vehicle_dir_layer(WEST, OBJ_LAYER)


/mob/living/simple_animal/hostile/retaliate/gator
	icon = 'icons/mob/gator.dmi'
	name = "gator"
	desc = "Vicious and patient creachers; tales have been told of passersby being grabbed and dragged underwater, never to be seen again."
	icon_state = "gator"
	icon_living = "gator"
	icon_dead = "gator-dead"
	pixel_x = -32
	pixel_y = 1

	faction = list("gators")
	turns_per_move = 4
	move_to_delay = 12
	vision_range = 5
	aggro_vision_range = 5

	// One of these daes, they'll drop Gator leather
	botched_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/mince/beef = 1)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/mince/beef = 1,
						/obj/item/alch/bone = 2)
	perfect_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/steak = 1,
						/obj/item/alch/sinew = 1,
						/obj/item/alch/bone = 4)

	health = 220
	maxHealth = 220
	food_type = list(/obj/item/bodypart,
					/obj/item/organ,
					/obj/item/reagent_containers/food/snacks/meat)
	tame_chance = 100

	base_intents = list(/datum/intent/simple/bigbite)
	attack_sound = list('sound/vo/mobs/gator/gatorattack1.ogg', 'sound/vo/mobs/gator/gatorattack2.ogg')
	melee_damage_lower = 25
	melee_damage_upper = 37

	base_constitution = 10
	base_strength = 16
	base_speed = 2
	base_endurance = 20

	retreat_distance = 0
	minimum_distance = 0
	deaggroprob = 0
	defprob = 35
	defdrain = 5
	retreat_health = 0.2

	aggressive = TRUE
	stat_attack = UNCONSCIOUS
	body_eater = TRUE
	can_buckle = TRUE

	ai_controller = /datum/ai_controller/gator



	var/static/list/pet_commands = list(
		/datum/pet_command/idle,
		/datum/pet_command/free,
		/datum/pet_command/good_boy,
		/datum/pet_command/follow,
		/datum/pet_command/attack,
		/datum/pet_command/fetch,
		/datum/pet_command/play_dead,
		/datum/pet_command/protect_owner,
		/datum/pet_command/aggressive,
		/datum/pet_command/calm,
	)

/mob/living/simple_animal/hostile/retaliate/gator/Initialize()
	. = ..()
	AddComponent(/datum/component/obeys_commands, pet_commands)
	gender = MALE
	if(prob(33))
		gender = FEMALE
	update_icon()


/mob/living/simple_animal/hostile/retaliate/gator/tamed(mob/user)
	. = ..()
	if(can_buckle)
		AddComponent(/datum/component/riding/gator)

/mob/living/simple_animal/hostile/retaliate/gator/death(gibbed)
	..()
	update_icon()


/mob/living/simple_animal/hostile/retaliate/gator/update_icon()
	cut_overlays()
	..()
	if(stat != DEAD)
		var/mutable_appearance/eye_lights = mutable_appearance(icon, "gator-eyes")
		eye_lights.plane = 19
		eye_lights.layer = 19
		add_overlay(eye_lights)

/mob/living/simple_animal/hostile/retaliate/gator/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/gator/gatoraggro1.ogg','sound/vo/mobs/gator/gatoraggro2.ogg','sound/vo/mobs/gator/gatoraggro3.ogg','sound/vo/mobs/gator/gatoraggro4.ogg')
		if("pain")
			return pick('sound/vo/mobs/gator/gatorpain.ogg')
		if("death")
			return pick('sound/vo/mobs/gator/gatordeath.ogg')
		if("idle")
			return pick('sound/vo/mobs/gator/gatoridle1.ogg')

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
