/mob/living/Moved()
	. = ..()
	stop_looking()
	update_turf_movespeed(loc)
	if(m_intent == MOVE_INTENT_RUN)
		consider_ambush()

/mob/living/CanPass(atom/movable/mover, turf/target)
	if((mover.pass_flags & PASSMOB))
		return TRUE
	if(istype(mover, /obj/projectile))
		var/obj/projectile/P = mover
		return !P.can_hit_target(src, P.permutated, src == P.original, TRUE)
	if(mover.throwing)
		return (!density || !(mobility_flags & MOBILITY_STAND) || wallpressed || (mover.throwing.thrower == src && !ismob(mover)))
	if(buckled == mover)
		return TRUE
	if(ismob(mover))
		if(mover in buckled_mobs)
			return TRUE
		if(isliving(mover))
			var/mob/living/M = mover
			if(M.wallpressed)
				return !wallpressed
	return (!density || wallpressed || !(mobility_flags & MOBILITY_STAND))

/mob/living/toggle_move_intent()
	. = ..()
	update_move_intent_slowdown()

/mob/living/toggle_rogmove_intent()
	. = ..()
	update_move_intent_slowdown()

// /mob/living/update_sneak_invis()
// if(m_intent == MOVE_INTENT_SNEAK)
//       return // Placeholder until further implementation
		// Implementation of invisibility or other effects.
		// For illustration:
		// src.set_invisibility(INVISIBILITY_LEVEL_MINIMAL)

/mob/living/def_intent_change()
	. = ..()
	update_move_intent_slowdown()

/mob/living/update_config_movespeed()
	update_move_intent_slowdown()
	return ..()

/mob/living/equip_to_slot_if_possible(obj/item/W, slot, qdel_on_fail = FALSE, disable_warning = FALSE, redraw_mob = TRUE, bypass_equip_delay_self = FALSE, initial)
	. = ..()
	update_config_movespeed()

/mob/living/proc/update_move_intent_slowdown()
	var/mod = 0
	switch(m_intent)
		if(MOVE_INTENT_WALK)
			mod = CONFIG_GET(number/movedelay/walk_delay)
		if(MOVE_INTENT_RUN)
			mod = CONFIG_GET(number/movedelay/run_delay)
		if(MOVE_INTENT_SNEAK)
			mod = 6
	var/spdchange = (10-STASPD)*0.1
	var/armorWeight = check_armor_weight()
	if(armorWeight == "Heavy")
		spdchange = spdchange + 0.2
		if(!check_armor_skill())
			spdchange = spdchange + 0.2
	if(armorWeight == "Medium")
		spdchange = spdchange + 0.1
		if(!check_armor_skill())
			spdchange = spdchange + 0.1
	spdchange = clamp(spdchange, -0.5, 1)  //if this is not clamped, it can make you go faster than you should be able to.
	mod = mod+spdchange
	//maximum speed is achieved at 15 speed.
	add_movespeed_modifier(MOVESPEED_ID_MOB_WALK_RUN_CONFIG_SPEED, TRUE, 100, override = TRUE, multiplicative_slowdown = mod)

/mob/living/proc/update_turf_movespeed(turf/open/T)
	if(isopenturf(T))
		var/usedslow = T.get_slowdown(src)
		if(HAS_TRAIT(src, TRAIT_LONGSTRIDER))
			usedslow = max(0, usedslow - 2)
		if(HAS_TRAIT(src, TRAIT_TRAM_MOVER))
			usedslow = 0
		if(usedslow != 0)
			add_movespeed_modifier(MOVESPEED_ID_LIVING_TURF_SPEEDMOD, update=TRUE, priority=100, multiplicative_slowdown=usedslow, movetypes=GROUND)
		else
			remove_movespeed_modifier(MOVESPEED_ID_LIVING_TURF_SPEEDMOD)
	else
		remove_movespeed_modifier(MOVESPEED_ID_LIVING_TURF_SPEEDMOD)

/turf/open
	var/mob_overlay

/turf/open/proc/get_mob_overlay()
	return mob_overlay

/mob/living/proc/update_charging_movespeed(datum/intent/I)
	if(I)
		add_movespeed_modifier(MOVESPEED_ID_CHARGING, update=TRUE, priority=100, override=TRUE, multiplicative_slowdown=I.charging_slowdown, movetypes=GROUND)
	else
		remove_movespeed_modifier(MOVESPEED_ID_CHARGING)

/mob/living/proc/update_pull_movespeed()
	if(pulling)
		if(pulling != src)
			if(isliving(pulling))
				var/mob/living/L = pulling
				if(!slowed_by_drag || (L.mobility_flags & MOBILITY_STAND) || L.buckled || grab_state >= GRAB_AGGRESSIVE)
					remove_movespeed_modifier(MOVESPEED_ID_BULKY_DRAGGING)
					return
				add_movespeed_modifier(MOVESPEED_ID_BULKY_DRAGGING, multiplicative_slowdown = PULL_PRONE_SLOWDOWN)
				return
			if(isobj(pulling))
				var/obj/structure/S = pulling
				if(!slowed_by_drag || !S.drag_slowdown || HAS_TRAIT(src, TRAIT_CRATEMOVER))
					remove_movespeed_modifier(MOVESPEED_ID_BULKY_DRAGGING)
					return
				add_movespeed_modifier(MOVESPEED_ID_BULKY_DRAGGING, multiplicative_slowdown = S.drag_slowdown)
				return

	remove_movespeed_modifier(MOVESPEED_ID_BULKY_DRAGGING)

/mob/living/can_zFall(turf/T, levels)
	return ..()

/mob/living/canZMove(dir, turf/target)
	return can_zTravel(target, dir) && (movement_type & FLYING)
