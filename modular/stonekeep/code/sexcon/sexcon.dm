/* Sex controller documentation notes:
You click with middle mouse on someone and drag them to your preferred target to open up the sex menu, where you select a sex action to perform.
The sex actions you can perform are gender-locked, as opposed to being specificially genital-locked, because Stonekeep doesn't have penis/testicles/vagina/breast organ slots like Ratwood and Azure Peak do.
If you want to lock an action to one sex, don't do if(!user.gender == [gender]), do if(user.gender == [gender]). I don't know why, but ! doesn't work on that and specifically that.
If, say, you wanted to seperate sex and gender without going to the trouble of adding cocks and pussies, you could simply code seperate variables for your sex and gender identity (based on pronouns or some shit IDK).
ejaculate() is actually just orgasm, for both sexes. I found this out the hard way after somehow making female characters unable to finish while testing this for the first time.
Admin logging is provided for orgasms and if you try to initiate sex with corpses, sleeping people, or people in combat mode. You can't bang in combat mode, as anti-zape protection.*/

/datum/sex_controller
	/// The user and the owner of the controller
	var/mob/living/carbon/human/user
	/// Target of our actions, can be ourself
	var/mob/living/carbon/human/target
	/// Whether the user desires to stop his current action
	var/desire_stop = FALSE
	/// What is the current performed action
	var/current_action = null
	/// Enum of desired speed
	var/speed = SEX_SPEED_MID
	/// Enum of desired force
	var/force = SEX_FORCE_MID
	/// Our arousal
	var/arousal = 0
	/// Our charge gauge
	var/charge = SEX_MAX_CHARGE
	/// Whether we want to screw until finished, or non stop
	var/do_until_finished = TRUE
	var/last_arousal_increase_time = 0
	var/last_ejaculation_time = 0
	var/last_moan = 0
	var/msg_signature = ""
	var/last_msg_signature = 0

/datum/sex_controller/New(mob/living/carbon/human/owner)
	user = owner

/datum/sex_controller/Destroy()
	user = null
	target = null
	. = ..()

/proc/do_thrust_animate(atom/movable/user, atom/movable/target, pixels = 4, time = 2.7)
	var/oldx = user.pixel_x
	var/oldy = user.pixel_y
	var/target_x = oldx
	var/target_y = oldy
	var/dir = get_dir(user, target)
	if(user.loc == target.loc)
		dir = user.dir
	switch(dir)
		if(NORTH)
			target_y += pixels
		if(SOUTH)
			target_y -= pixels
		if(WEST)
			target_x -= pixels
		if(EAST)
			target_x += pixels

	animate(user, pixel_x = target_x, pixel_y = target_y, time = time)
	animate(pixel_x = oldx, pixel_y = oldy, time = time)

/datum/sex_controller/proc/do_message_signature(sigkey)
	var/properkey = "[speed][force][sigkey]"
	if(properkey == msg_signature && last_msg_signature + 4.0 SECONDS >= world.time)
		return FALSE
	msg_signature = properkey
	last_msg_signature = world.time
	return TRUE

/datum/sex_controller/proc/is_spent()
	if(charge < CHARGE_FOR_CLIMAX)
		return TRUE
	return FALSE

/datum/sex_controller/proc/finished_check()
	if(!do_until_finished)
		return FALSE
	if(!just_ejaculated())
		return FALSE
	return TRUE

/datum/sex_controller/proc/adjust_speed(amt)
	speed = clamp(speed + amt, SEX_SPEED_MIN, SEX_SPEED_MAX)

/datum/sex_controller/proc/adjust_force(amt)
	force = clamp(force + amt, SEX_FORCE_MIN, SEX_FORCE_MAX)

/datum/sex_controller/proc/update_pink_screen()
	var/severity = 0
	switch(arousal)
		if(1 to 10)
			severity = 1
		if(10 to 20)
			severity = 2
		if(20 to 30)
			severity = 3
		if(30 to 40)
			severity = 4
		if(40 to 50)
			severity = 5
		if(50 to 60)
			severity = 6
		if(60 to 70)
			severity = 7
		if(70 to 80)
			severity = 8
		if(80 to 90)
			severity = 9
		if(90 to INFINITY)
			severity = 10
	if(severity > 0)
		user.overlay_fullscreen("horny", /atom/movable/screen/fullscreen/love, severity)
	else
		user.clear_fullscreen("horny")

/datum/sex_controller/proc/start(mob/living/carbon/human/new_target)
	if(!ishuman(new_target))
		return
	set_target(new_target)
	show_ui()

/datum/sex_controller/proc/cum_onto()
	log_combat(user, target, "came onto the target")
	playsound(target, 'modular/stonekeep/sound/sexcon/endout.ogg', 50, TRUE, ignore_walls = FALSE)
	add_cum_floor(get_turf(target))
	after_ejaculation()

/datum/sex_controller/proc/cum_into(oral = FALSE)
	log_combat(user, target, "came inside the target")
	if(oral)
		playsound(target, pick(list('modular/stonekeep/sound/sexcon/mouthend (1).ogg','modular/stonekeep/sound/sexcon/mouthend (2).ogg')), 100, FALSE, ignore_walls = FALSE)
	else
		playsound(target, 'modular/stonekeep/sound/sexcon/endin.ogg', 50, TRUE, ignore_walls = FALSE)
	after_ejaculation()
	if(!oral)
		after_intimate_climax()

/datum/sex_controller/proc/ejaculate()
	log_combat(user, user, "orgasmed")
	if(user.gender == FEMALE)
		user.visible_message(span_love("[user] tightens in ecstasy!"))
		after_ejaculation()
	if(user.gender == MALE)
		user.visible_message(span_love("[user] spills on the floor!"))
		playsound(user, 'modular/stonekeep/sound/sexcon/endout.ogg', 50, TRUE, ignore_walls = FALSE)
		add_cum_floor(get_turf(user))
		after_ejaculation()

/datum/sex_controller/proc/after_ejaculation()
	set_arousal(40)
	adjust_charge(-CHARGE_FOR_CLIMAX)
	user.emote("sexmoanhvy", forced = TRUE)
	user.playsound_local(user, 'modular/stonekeep/sound/sexcon/end.ogg', 100)
	last_ejaculation_time = world.time
//	SSticker.cums++ //We'll reimplement roundend pleasures in a later commit.

/datum/sex_controller/proc/after_intimate_climax()
	if(user == target)
		return
	if(HAS_TRAIT(target, TRAIT_GOODLOVER))
		if(!user.mob_timers["cumtri"])
			user.mob_timers["cumtri"] = world.time
			user.adjust_triumphs(1)
			to_chat(user, span_love("Our loving is a true TRIUMPH!"))
	if(HAS_TRAIT(user, TRAIT_GOODLOVER))
		if(!target.mob_timers["cumtri"])
			target.mob_timers["cumtri"] = world.time
			target.adjust_triumphs(1)
			to_chat(target, span_love("Our loving is a true TRIUMPH!"))

/datum/sex_controller/proc/just_ejaculated()
	return (last_ejaculation_time + 2 SECONDS >= world.time)

/datum/sex_controller/proc/set_charge(amount)
	var/empty = (charge < CHARGE_FOR_CLIMAX)
	charge = clamp(amount, 0, SEX_MAX_CHARGE)
	var/after_empty = (charge < CHARGE_FOR_CLIMAX)
	if(empty && !after_empty)
		to_chat(user, span_notice("I feel like I'm not so spent anymore."))
	if(!empty && after_empty)
		to_chat(user, span_notice("I'm spent!"))

/datum/sex_controller/proc/adjust_charge(amount)
	set_charge(charge + amount)

/datum/sex_controller/proc/handle_charge(dt)
	adjust_charge(dt * CHARGE_RECHARGE_RATE)
	if(is_spent())
		if(arousal > 60)
			to_chat(user, span_warning("I'm too spent!"))
			adjust_arousal(-20)
		adjust_arousal(-dt * SPENT_AROUSAL_RATE)

/datum/sex_controller/proc/set_arousal(amount)
	if(amount > arousal)
		last_arousal_increase_time = world.time
	arousal = clamp(amount, 0, MAX_AROUSAL)
	update_pink_screen()
	update_blueballs()

/datum/sex_controller/proc/adjust_arousal(amount)
	set_arousal(arousal + amount)

/datum/sex_controller/proc/perform_sex_action(mob/living/carbon/human/action_target, arousal_amt, giving)
	action_target.sexcon.receive_sex_action(arousal_amt, giving, force, speed)

/datum/sex_controller/proc/receive_sex_action(arousal_amt, giving, applied_force, applied_speed)
	arousal_amt *= get_force_pleasure_multiplier(applied_force, giving)

	if(user.stat == DEAD)
		arousal_amt = 0

	adjust_arousal(arousal_amt)

	try_do_moan(arousal_amt, applied_force, giving)

/datum/sex_controller/proc/try_do_moan(arousal_amt, applied_force, giving)
	if(arousal_amt < 1.5)
		return
	if(user.stat != CONSCIOUS)
		return
	if(last_moan + MOAN_COOLDOWN >= world.time)
		return
	if(prob(50))
		return
	var/chosen_emote
	switch(arousal_amt)
		if(0 to 5)
			chosen_emote = "sexmoanlight"
		if(5 to INFINITY)
			chosen_emote = "sexmoanhvy"

	last_moan = world.time
	user.emote(chosen_emote, forced = TRUE)

/datum/sex_controller/proc/update_blueballs()
	if(user.gender == FEMALE)
		return FALSE
	if(arousal >= BLUEBALLS_GAIN_THRESHOLD)
		user.add_stress(/datum/stressevent/blueb)
	else if (arousal <= BLUEBALLS_LOOSE_THRESHOLD)
		user.remove_stress(/datum/stressevent/blueb)

/datum/sex_controller/proc/check_active_ejaculation()
	if(arousal < ACTIVE_EJAC_THRESHOLD)
		return FALSE
	if(is_spent())
		return FALSE
	if(!can_ejaculate())
		return FALSE
	return TRUE

/datum/sex_controller/proc/can_ejaculate()
	if(HAS_TRAIT(user, TRAIT_LIMPDICK))
		return FALSE
	if(HAS_TRAIT(user, TRAIT_MINCED))
		return FALSE
	return TRUE

/datum/sex_controller/proc/handle_passive_ejaculation()
	if(arousal < PASSIVE_EJAC_THRESHOLD)
		return
	if(is_spent())
		return
	if(!can_ejaculate())
		return FALSE
	ejaculate()

/datum/sex_controller/proc/can_use_penis()
	if(user.gender == FEMALE)
		return FALSE
	if(HAS_TRAIT(user, TRAIT_LIMPDICK))
		return FALSE
	if(HAS_TRAIT(user, TRAIT_MINCED))
		return FALSE
	return TRUE

/datum/sex_controller/proc/considered_limp()
	if(arousal >= AROUSAL_HARD_ON_THRESHOLD)
		return FALSE
	return TRUE

/datum/sex_controller/proc/process_sexcon(dt)
	handle_arousal_unhorny(dt)
	handle_charge(dt)
	handle_passive_ejaculation()

/datum/sex_controller/proc/handle_arousal_unhorny(dt)
	if(!can_ejaculate())
		adjust_arousal(-dt * IMPOTENT_AROUSAL_LOSS_RATE)
	if(last_arousal_increase_time + AROUSAL_TIME_TO_UNHORNY >= world.time)
		return
	var/rate
	switch(arousal)
		if(-INFINITY to 25)
			rate = AROUSAL_LOW_UNHORNY_RATE
		if(25 to 40)
			rate = AROUSAL_MID_UNHORNY_RATE
		if(40 to INFINITY)
			rate = AROUSAL_HIGH_UNHORNY_RATE
	adjust_arousal(-dt * rate)

/datum/sex_controller/proc/show_ui()
	var/list/dat = list()
	var/force_name = get_force_string()
	var/speed_name = get_speed_string()
	dat += "<center><a href='?src=[REF(src)];task=speed_down'>\<</a> [speed_name] <a href='?src=[REF(src)];task=speed_up'>\></a> ~|~ <a href='?src=[REF(src)];task=force_down'>\<</a> [force_name] <a href='?src=[REF(src)];task=force_up'>\></a></center>"
	if(target == user)
		dat += "<center>Doing unto yourself</center>"
	else
		dat += "<center>Doing unto [target]'s</center>"
	if(current_action)
		dat += "<center><a href='?src=[REF(src)];task=stop'>Stop</a></center>"
	else
		dat += "<br>"
	dat += "<table width='100%'><td width='50%'></td><td width='50%'></td><tr>"
	var/i = 0
	for(var/action_type in GLOB.sex_actions)
		var/datum/sex_action/action = SEX_ACTION(action_type)
		if(!action.shows_on_menu(user, target))
			continue
		dat += "<td>"
		var/link = ""
		if(!can_perform_action(action_type))
			link = "linkOff"
		if(current_action == action_type)
			link = "linkOn"
		dat += "<center><a class='[link]' href='?src=[REF(src)];task=action;action_type=[action_type]'>[action.name]</a></center>"
		dat += "</td>"
		i++
		if(i >= 2)
			i = 0
			dat += "</tr><tr>"

	dat += "</tr></table>"
	var/datum/browser/popup = new(user, "sexcon", "<center>Pleasures</center>", 490, 550)
	popup.set_content(dat.Join())
	popup.open()
	return

/datum/sex_controller/Topic(href, href_list)
	if(usr != user)
		return
	switch(href_list["task"])
		if("action")
			var/action_path = text2path(href_list["action_type"])
			var/datum/sex_action/action = SEX_ACTION(action_path)
			if(!action)
				return
			try_start_action(action_path)
		if("stop")
			try_stop_current_action()
		if("speed_up")
			adjust_speed(1)
		if("speed_down")
			adjust_speed(-1)
		if("force_up")
			adjust_force(1)
		if("force_down")
			adjust_force(-1)
	show_ui()

/datum/sex_controller/proc/try_stop_current_action()
	if(!current_action)
		return
	desire_stop = TRUE
	user.doing = FALSE

/datum/sex_controller/proc/stop_current_action()
	if(!current_action)
		return
	var/datum/sex_action/action = SEX_ACTION(current_action)
	action.on_finish(user, target)
	desire_stop = FALSE
	user.doing = FALSE
	current_action = null

/datum/sex_controller/proc/try_start_action(action_type)
	if(action_type == current_action)
		try_stop_current_action()
		return
	if(current_action != null)
		try_stop_current_action()
		return
	if(!action_type)
		return
	if(!can_perform_action(action_type))
		return
	// Set vars
	desire_stop = FALSE
	current_action = action_type
	var/datum/sex_action/action = SEX_ACTION(current_action)
	log_combat(user, target, "Started sex action: [action.name]")
	INVOKE_ASYNC(src, PROC_REF(sex_action_loop))

/datum/sex_controller/proc/sex_action_loop()
	// Do action loop
	var/performed_action_type = current_action
	var/datum/sex_action/action = SEX_ACTION(current_action)
	action.on_start(user, target)
	while(TRUE)
		if(!user.adjust_stamina(action.stamina_cost * get_stamina_cost_multiplier()))
			break
		if(!do_after(user, (action.do_time / get_speed_multiplier()), target = target))
			break
		if(current_action == null || performed_action_type != current_action)
			break
		if(!can_perform_action(current_action))
			break
		if(action.is_finished(user, target))
			break
		if(desire_stop)
			break
		action.on_perform(user, target)
		// It could want to finish afterwards the performed action
		if(action.is_finished(user, target))
			break
		if(!action.continous)
			break
	stop_current_action()

/datum/sex_controller/proc/can_perform_action(action_type)
	if(!action_type)
		return FALSE
	var/datum/sex_action/action = SEX_ACTION(action_type)
	if(!inherent_perform_check(action_type))
		return FALSE
	if(!action.can_perform(user, target))
		return FALSE
	return TRUE

/datum/sex_controller/proc/inherent_perform_check(action_type)
	var/datum/sex_action/action = SEX_ACTION(action_type)
	if(!target)
		return FALSE
	if(user.stat != CONSCIOUS)
		return FALSE
	if(!user.Adjacent(target))
		return FALSE
	if(action.check_incapacitated && user.incapacitated())
		return FALSE
	if(action.check_same_tile)
		var/same_tile = (get_turf(user) == get_turf(target))
		var/grab_bypass = (action.aggro_grab_instead_same_tile && user.get_highest_grab_state_on(target) == GRAB_AGGRESSIVE)
		if(!same_tile && !grab_bypass)
			return FALSE
	if(action.require_grab)
		var/grabstate = user.get_highest_grab_state_on(target)
		if(grabstate == null || grabstate < action.required_grab_state)
			return FALSE
	return TRUE

/datum/sex_controller/proc/set_target(mob/living/carbon/human/new_target)
	target = new_target

/mob/living/carbon/human/proc/on_virgin_loss()
	var/mob/living/carbon/human/P = src
	virginity = FALSE
	if((P.patron != /datum/patron/divine/astrata) || (P.patron != /datum/patron/divine/noc) || (P.patron != /datum/patron/divine/malum) || (P.patron != /datum/patron/psydon))
		return FALSE
	if(P.IsWedded())
		return FALSE
	if(mind)
		switch(mind.assigned_role)
			if("Priest")
				P.add_stress(/datum/stressevent/virginchurch)
			if("Acolyte")
				P.add_stress(/datum/stressevent/virginchurch)
			if("Templar")
				P.add_stress(/datum/stressevent/virginchurch)
			if("Cleric")
				P.add_stress(/datum/stressevent/virginchurch)
			if("Paladin")
				P.add_stress(/datum/stressevent/virginchurch)

/datum/sex_controller/proc/get_speed_multiplier()
	switch(speed)
		if(SEX_SPEED_LOW)
			return 1.0
		if(SEX_SPEED_MID)
			return 1.5
		if(SEX_SPEED_HIGH)
			return 2.0

/datum/sex_controller/proc/get_stamina_cost_multiplier()
	switch(force)
		if(SEX_FORCE_LOW)
			return 1.0
		if(SEX_FORCE_MID)
			return 1.5
		if(SEX_FORCE_HIGH)
			return 2.0

/datum/sex_controller/proc/get_force_pleasure_multiplier(passed_force, giving)
	switch(passed_force)
		if(SEX_FORCE_LOW)
			if(giving)
				return 0.8
			else
				return 0.6
		if(SEX_FORCE_MID)
			if(giving)
				return 1.0
			else
				return 0.8
		if(SEX_FORCE_HIGH)
			if(giving)
				return 1.2
			else
				return 1.0

/datum/sex_controller/proc/get_force_string()
	switch(force)
		if(SEX_FORCE_LOW)
			return "<font color='#eac8de'>GENTLE</font>"
		if(SEX_FORCE_MID)
			return "<font color='#e9a8d1'>FIRM</font>"
		if(SEX_FORCE_HIGH)
			return "<font color='#f05ee1'>ROUGH</font>"

/datum/sex_controller/proc/get_speed_string()
	switch(speed)
		if(SEX_SPEED_LOW)
			return "<font color='#eac8de'>SLOW</font>"
		if(SEX_SPEED_MID)
			return "<font color='#e9a8d1'>STEADY</font>"
		if(SEX_SPEED_HIGH)
			return "<font color='#f05ee1'>QUICK</font>"

/datum/sex_controller/proc/get_generic_force_adjective()
	switch(force)
		if(SEX_FORCE_LOW)
			return pick(list("gently", "carefully", "tenderly", "gingerly", "delicately", "lazingly"))
		if(SEX_FORCE_MID)
			return pick(list("firmly", "vigorously", "eagerly", "steadily", "intently"))
		if(SEX_FORCE_HIGH)
			return pick(list("roughly", "carelessly", "forcefully", "fervently", "fiercely"))

/datum/sex_controller/proc/spanify_force(string)
	switch(force)
		if(SEX_FORCE_LOW)
			return "<span class='love_low'>[string]</span>"
		if(SEX_FORCE_MID)
			return "<span class='love_mid'>[string]</span>"
		if(SEX_FORCE_HIGH)
			return "<span class='love_high'>[string]</span>"

/obj/effect/decal/cleanable/coom
	name = "mess"
	icon = 'modular/stonekeep/icons/sexcon.dmi'
	icon_state = "mess1"
	random_icon_states = list("mess1", "mess2", "mess3")
	beauty = -100
	alpha = 150
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	appearance_flags = NO_CLIENT_COLOR

/obj/effect/decal/cleanable/coom/Initialize(mapload)
	. = ..()
	pixel_x = rand(-8, 8)
	pixel_y = rand(-8, 8)
