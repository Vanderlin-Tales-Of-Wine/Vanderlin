

/mob/living/carbon/monkey


/mob/living/carbon/monkey/Life()
	set invisibility = 0

	if (notransform)
		return

	if(..())

		if(!client)
			if(stat == CONSCIOUS)
				if(on_fire || buckled || restrained())
					if(!resisting && prob(MONKEY_RESIST_PROB))
						resisting = TRUE
						walk_to(src,0)
						resist()
				else if(resisting)
					resisting = FALSE
				else if((mode == MONKEY_IDLE && !pickupTarget && !prob(MONKEY_SHENANIGAN_PROB)) || !handle_combat())
					if(prob(25) && (mobility_flags & MOBILITY_MOVE) && isturf(loc) && !pulledby)
						step(src, pick(GLOB.cardinals))
					else if(prob(1))
						emote(pick("scratch","jump","roll","tail"))
			else
				walk_to(src,0)

/mob/living/carbon/monkey/handle_environment()
	var/loc_temp = BODYTEMP_NORMAL

	if(stat != DEAD)
		adjust_bodytemperature(natural_bodytemperature_stabilization())

	if(!on_fire) //If you're on fire, you do not heat up or cool down based on surrounding gases
		if(loc_temp < bodytemperature)
			adjust_bodytemperature(max((loc_temp - bodytemperature) / BODYTEMP_COLD_DIVISOR, BODYTEMP_COOLING_MAX))
		else
			adjust_bodytemperature(min((loc_temp - bodytemperature) / BODYTEMP_HEAT_DIVISOR, BODYTEMP_HEATING_MAX))


	if(bodytemperature > BODYTEMP_HEAT_DAMAGE_LIMIT && !HAS_TRAIT(src, TRAIT_RESISTHEAT))
		switch(bodytemperature)
			if(360 to 400)
				throw_alert("temp", /atom/movable/screen/alert/status_effect/debuff/hot, 1)
				apply_damage(HEAT_DAMAGE_LEVEL_1, BURN)
			if(400 to 460)
				throw_alert("temp", /atom/movable/screen/alert/status_effect/debuff/hot, 2)
				apply_damage(HEAT_DAMAGE_LEVEL_2, BURN)
			if(460 to INFINITY)
				throw_alert("temp", /atom/movable/screen/alert/status_effect/debuff/hot, 3)
				if(on_fire)
					apply_damage(HEAT_DAMAGE_LEVEL_3, BURN)
				else
					apply_damage(HEAT_DAMAGE_LEVEL_2, BURN)

	else if(bodytemperature < BODYTEMP_COLD_DAMAGE_LIMIT && !HAS_TRAIT(src, TRAIT_RESISTCOLD))
		switch(bodytemperature)
			if(200 to 260)
				throw_alert("temp", /atom/movable/screen/alert/status_effect/debuff/cold, 1)
				apply_damage(COLD_DAMAGE_LEVEL_1, BURN)
			if(120 to 200)
				throw_alert("temp", /atom/movable/screen/alert/status_effect/debuff/cold, 2)
				apply_damage(COLD_DAMAGE_LEVEL_2, BURN)
			if(-INFINITY to 120)
				throw_alert("temp", /atom/movable/screen/alert/status_effect/debuff/cold, 3)
				apply_damage(COLD_DAMAGE_LEVEL_3, BURN)

	else
		clear_alert("temp")

	return

/mob/living/carbon/monkey/handle_random_events()
	..()
	if (prob(1) && prob(2))
		emote("scratch")

/mob/living/carbon/monkey/has_smoke_protection()
	if(wear_mask)
		if(wear_mask.clothing_flags & BLOCK_GAS_SMOKE_EFFECT)
			return 1

/mob/living/carbon/monkey/handle_fire()
	. = ..()
	if(.) //if the mob isn't on fire anymore
		return

	//the fire tries to damage the exposed clothes and items
	var/list/burning_items = list()
	//HEAD//
	var/list/obscured = check_obscured_slots(TRUE)
	if(wear_mask && !(SLOT_WEAR_MASK in obscured))
		burning_items += wear_mask
	if(wear_neck && !(SLOT_NECK in obscured))
		burning_items += wear_neck
	if(head)
		burning_items += head

	if(back)
		burning_items += back

	for(var/X in burning_items)
		var/obj/item/I = X
		I.fire_act(((fire_stacks + divine_fire_stacks)* 50)) //damage taken is reduced to 2% of this value by fire_act()

	adjust_bodytemperature(BODYTEMP_HEATING_MAX)
	SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "on_fire", /datum/mood_event/on_fire)
