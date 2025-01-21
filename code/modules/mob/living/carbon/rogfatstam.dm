/mob/living/proc/update_stamina() //update hud and regen after last_fatigued delay on taking
	var/athletics_skill = 0
	if(mind)
		athletics_skill = mind.get_skill_level(/datum/skill/misc/athletics)
	maximum_stamina = (STAEND + athletics_skill) * 10 //This here is the calculation for max STAMINA / GREEN

	var/delay = (HAS_TRAIT(src, TRAIT_APRICITY) && GLOB.tod == "day") ? 11 : 20
	if(world.time > last_fatigued + delay) //regen fatigue
		var/added = energy / max_energy
		added = round(-10+ (added*-40))
		if(HAS_TRAIT(src, TRAIT_MISSING_NOSE))
			added = round(added * 0.5, 1)
		if(stamina >= 1)
			adjust_stamina(added)
		else
			stamina = 0

	update_health_hud(TRUE)

/mob/living/proc/update_energy()
	///this is kinda weird and not at the same time for energy being tied to this,
	/// since energy is both a magical and physical system
	var/athletics_skill = 0
	if(mind)
		athletics_skill = mind.get_skill_level(/datum/skill/misc/athletics)
	max_energy = (STAEND + athletics_skill) * 100 // ENERGY / BLUE (Average of 1000)
	if(cmode)
		if(!HAS_TRAIT(src, TRAIT_BREADY))
			adjust_energy(-2)

/mob/proc/adjust_energy(added as num)
	return

/mob/living/adjust_energy(added as num)
	///this trait affects both stamina and energy since they are part of the same system.
	if(HAS_TRAIT(src, TRAIT_NOSTAMINA))
		return TRUE
	if(m_intent == MOVE_INTENT_RUN)
		var/boon = mind.get_learning_boon(/datum/skill/misc/athletics)
		mind.adjust_experience(/datum/skill/misc/athletics, (STAINT*0.02) * boon)
	energy += added
	if(energy > max_energy)
		energy = max_energy
		update_health_hud(TRUE)
		return FALSE
	else
		if(energy <= 0)
			energy = 0
			if(m_intent == MOVE_INTENT_RUN) //can't sprint at zero stamina
				toggle_rogmove_intent(MOVE_INTENT_WALK)
		update_health_hud(TRUE)
		return TRUE

/mob/proc/adjust_stamina(added as num)
	return TRUE

/mob/living/adjust_stamina(added as num, emote_override, force_emote = TRUE) //call update_stamina here and set last_fatigued, return false when not enough fatigue left
	if(HAS_TRAIT(src, TRAIT_NOSTAMINA))
		return TRUE
	stamina = CLAMP(stamina+added, 0, maximum_stamina)
	if(added > 0)
		adjust_energy(added * -1)
	if(added >= 5)
		if(energy <= 0)
			if(iscarbon(src))
				var/mob/living/carbon/C = src
				if(!HAS_TRAIT(C, TRAIT_NOHUNGER))
					if(C.nutrition <= 0)
						if(C.hydration <= 0)
							C.heart_attack()
							return FALSE
	if(stamina >= maximum_stamina)
		stamina = maximum_stamina
		update_health_hud(TRUE)
		if(m_intent == MOVE_INTENT_RUN) //can't sprint at full fatigue
			toggle_rogmove_intent(MOVE_INTENT_WALK, TRUE)
		if(!emote_override)
			emote("fatigue", forced = force_emote)
		else
			emote(emote_override, forced = force_emote)
		blur_eyes(2)
		last_fatigued = world.time + 30 //extra time before fatigue regen sets in
		stop_attack()
		changeNext_move(CLICK_CD_EXHAUSTED)
		flash_fullscreen("blackflash")
		if(energy <= 0)
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
		last_fatigued = world.time
		update_health_hud(TRUE)
		return TRUE

/mob/living/carbon
	var/heart_attacking = FALSE

/mob/living/carbon/proc/heart_attack()
	if(HAS_TRAIT(src, TRAIT_NOSTAMINA))
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

/mob/living/proc/stamina_reset()
	stamina = 0
	last_fatigued = 0
	return
