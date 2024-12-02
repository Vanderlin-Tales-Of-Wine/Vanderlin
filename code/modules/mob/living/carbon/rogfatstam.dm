/mob/living/proc/update_curr_stam() ///Dont confuse this with a mobs stamina damage, this is their 'action stamina'
	max_stamina = max_fatigue / 10

	if(world.time > last_stam_drained + 20) //regen stamina
		var/regenerated = round(10+ ((curr_fatigue / max_fatigue)*40))
		if(HAS_TRAIT(src, TRAIT_MISSING_NOSE))
			regenerated = FLOOR(regenerated * 0.5, 1)
		if(curr_stamina < max_stamina)
			change_stamina(regenerated)
		else
			curr_stamina = max_stamina

	update_health_hud()

/mob/living/proc/update_fatigue()
	var/athletics_skill = 0
	if(mind)
		athletics_skill = mind.get_skill_level(/datum/skill/misc/athletics)
	max_fatigue = (STAEND + (athletics_skill/2 ) ) * 100
	if(cmode)
		if(!HAS_TRAIT(src, TRAIT_BREADY))
			change_fatigue(-2)

/mob/proc/change_fatigue(added as num)
	return

/mob/living/change_fatigue(added as num)
	if(HAS_TRAIT(src, TRAIT_NOFATIGUE))
		return TRUE
	if(m_intent == MOVE_INTENT_RUN)
		var/boon = mind.get_learning_boon(/datum/skill/misc/athletics)
		mind.adjust_experience(/datum/skill/misc/athletics, (STAINT*0.02) * boon)
	curr_fatigue += added
	if(curr_fatigue > max_fatigue)
		curr_fatigue = max_fatigue
		update_health_hud()
		return FALSE
	else
		if(curr_fatigue <= 0)
			curr_fatigue = 0
			if(m_intent == MOVE_INTENT_RUN)
				toggle_rogmove_intent(MOVE_INTENT_WALK)
		update_health_hud()
		return TRUE

/mob/proc/change_stamina(added as num)
	return TRUE

/mob/living/change_stamina(added as num, emote_override, force_emote = TRUE) //call update_stamina here and set last_stam_drained, return false when not enough fatigue left
	if(HAS_TRAIT(src, TRAIT_NOFATIGUE))
		return TRUE
	curr_stamina = CLAMP(curr_stamina+added, 0, max_stamina)
	if(added < 0)
		change_fatigue(added)
	if(added <= -5)
		if(curr_fatigue <= 0)
			if(iscarbon(src))
				var/mob/living/carbon/C = src
				if(!HAS_TRAIT(C, TRAIT_NOHUNGER))
					if(C.nutrition <= 0)
						if(C.hydration <= 0)
							C.heart_attack()
							return FALSE
	if(curr_stamina <= 0)
		curr_stamina = 0
		update_health_hud()
		if(m_intent == MOVE_INTENT_RUN) //can't sprint at full fatigue
			toggle_rogmove_intent(MOVE_INTENT_WALK, TRUE)
		if(!emote_override)
			emote("fatigue", forced = force_emote)
		else
			emote(emote_override, forced = force_emote)
		blur_eyes(2)
		last_stam_drained = world.time + 30 //extra time before fatigue regen sets in
		stop_attack()
		changeNext_move(CLICK_CD_EXHAUSTED)
		flash_fullscreen("blackflash")
		if(curr_fatigue <= 0)
			addtimer(CALLBACK(src, PROC_REF(Knockdown), 30), 10)
		addtimer(CALLBACK(src, PROC_REF(Immobilize), 30), 10)
		if(iscarbon(src))
			var/mob/living/carbon/C = src
			if(C.stress >= 30)
				C.heart_attack()
			if(!HAS_TRAIT(C, TRAIT_NOHUNGER))
				if(C.nutrition <= 0)
					if(C.hydration <= 0)
						C.heart_attack()
		return FALSE
	else
		if (added < 0)
			last_stam_drained = world.time
		update_health_hud()
		return TRUE

/mob/living/carbon
	var/heart_attacking = FALSE

/mob/living/carbon/proc/heart_attack()
	if(HAS_TRAIT(src, TRAIT_NOFATIGUE))
		return
	if(!heart_attacking)
		var/mob/living/carbon/C = src
		C.visible_message(C, "<span class='danger'>[C] clutches at [C.p_their()] chest!</span>") // Other people know something is wrong.
		emote("breathgasp", forced = TRUE)
		shake_camera(src, 1, 3)
		blur_eyes(40)
		var/stuffy = list("ZIZO GRABS MY WEARY HEART!","ARGH! MY HEART BEATS NO MORE!","NO... MY HEART HAS BEAT IT'S LAST!","MY HEART HAS GIVEN UP!","MY HEART BETRAYS ME!","THE METRONOME OF MY LIFE STILLS!")
		to_chat(src, "<span class='userdanger'>[pick(stuffy)]</span>")
		addtimer(CALLBACK(src, PROC_REF(set_heartattack), TRUE), 3 SECONDS) //no penthrite so just doing this
		// addtimer(CALLBACK(src, PROC_REF(adjustOxyLoss), 110), 30) This was commented out because the heart attack already kills, why put people into oxy crit instantly?

/mob/living/proc/freak_out()
	return

/mob/proc/do_freakout_scream()
	emote("scream", forced=TRUE)

/mob/living/carbon/freak_out()
	if(mob_timers["freakout"])
		if(world.time < mob_timers["freakout"] + 10 SECONDS)
			flash_fullscreen("stressflash")
			return
	mob_timers["freakout"] = world.time
	shake_camera(src, 1, 3)
	flash_fullscreen("stressflash")
	changeNext_move(CLICK_CD_EXHAUSTED)
	add_stress(/datum/stressevent/freakout)
	if(stress >= 30)
		heart_attack()
	else
		emote("fatigue", forced = TRUE)
		if(stress > 15)
			addtimer(CALLBACK(src, TYPE_PROC_REF(/mob, do_freakout_scream)), rand(30,50))
	if(hud_used)
//		var/list/screens = list(hud_used.plane_masters["[OPENSPACE_BACKDROP_PLANE]"],hud_used.plane_masters["[BLACKNESS_PLANE]"],hud_used.plane_masters["[GAME_PLANE_UPPER]"],hud_used.plane_masters["[GAME_PLANE_FOV_HIDDEN]"], hud_used.plane_masters["[FLOOR_PLANE]"], hud_used.plane_masters["[GAME_PLANE]"], hud_used.plane_masters["[LIGHTING_PLANE]"])
		var/matrix/skew = matrix()
		skew.Scale(2)
		//skew.Translate(-224,0)
		var/matrix/newmatrix = skew
		for(var/C in hud_used.plane_masters)
			var/atom/movable/screen/plane_master/whole_screen = hud_used.plane_masters[C]
			if(whole_screen.plane == HUD_PLANE)
				continue
			animate(whole_screen, transform = newmatrix, time = 1, easing = QUAD_EASING)
			animate(transform = -newmatrix, time = 30, easing = QUAD_EASING)

/mob/living/proc/rogfat_reset()
	curr_stamina = 0
	last_stam_drained = 0
	return
