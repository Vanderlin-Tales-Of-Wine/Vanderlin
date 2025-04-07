/mob/living/carbon/human/proc/vampire_telepathy()
	set name = "Telepathy"
	set category = "VAMPIRE"

	if(!mind)
		return

	var/datum/antagonist/vampire/vamp_datum = mind.has_antag_datum(/datum/antagonist/vampire)
	if(!vamp_datum)
		return

	var/datum/team/vampires/vamp_team = vamp_datum.team
	if(!vamp_team)
		return


	var/msg = browser_input_text(src, "Send a message", "COMMAND", max_length = MAX_MESSAGE_LEN, multiline = TRUE)
	if(!msg)
		return
	if(stat > CONSCIOUS)
		return

	var/message = span_narsie("<B>A message from <span style='color:#[voice_color]'>[real_name]</span>: [msg]</B>")
	to_chat(vamp_team.members, message)

// Spells
/obj/effect/proc_holder/spell/targeted/transfix
	name = "Transfix"
	overlay_state = "transfix"
	releasedrain = 100
	chargedrain = 0
	chargetime = 0
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = null
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/blood
	antimagic_allowed = TRUE
	recharge_time = 10 SECONDS
	include_user = 0
	max_targets = 1

/obj/effect/proc_holder/spell/targeted/transfix/cast(list/targets, mob/user = usr)
	var/msg = input("Soothe them. Dominate them. Speak and they will succumb.", "Transfix") as text|null
	if(length(msg) < 10)
		to_chat(user, span_userdanger("This is not enough!"))
		return FALSE
	var/bloodskill = user.mind.get_skill_level(/datum/skill/magic/blood)
	var/bloodroll = roll("[bloodskill]d8")
	user.say(msg)
	for(var/mob/living/carbon/human/L in targets)
		var/datum/antagonist/vampire/VD = L.mind.has_antag_datum(/datum/antagonist/vampire)
		var/willpower = round(L.STAINT / 4)
		var/willroll = roll("[willpower]d6")
		if(VD)
			return
		if(L.cmode)
			willroll += 10
		var/found_psycross = FALSE
		for(var/obj/item/clothing/neck/psycross/silver/I in L.contents) //Subpath fix.
			found_psycross = TRUE
			break

		if(bloodroll >= willroll)
			if(found_psycross == TRUE)
				to_chat(L, "<font color='white'>The silver psycross shines and protect me from the unholy magic.</font>")
				to_chat(user, span_userdanger("[L] has my BANE!It causes me to fail to ensnare their mind!"))
			else
				L.drowsyness = min(L.drowsyness + 50, 150)
				switch(L.drowsyness)
					if(0 to 50)
						to_chat(L, "You feel like a curtain is coming over your mind.")
						to_chat(user, "Their mind gives way slightly.")
						L.Slowdown(20)
					if(50 to 100)
						to_chat(L, "Your eyelids force themselves shut as you feel intense lethargy.")
						L.Slowdown(50)
						L.eyesclosed = TRUE
						for(var/atom/movable/screen/eye_intent/eyet in L.hud_used.static_inventory)
							eyet.update_icon(L)
						L.become_blind("eyelids")
						to_chat(user, "They will not be able to resist much more.")
					if(100 to INFINITY)
						to_chat(L, span_userdanger("You can't take it anymore. Your legs give out as you fall into the dreamworld."))
						to_chat(user, "They're mine now.")
						L.Slowdown(50)
						L.eyesclosed = TRUE
						for(var/atom/movable/screen/eye_intent/eyet in L.hud_used.static_inventory)
							eyet.update_icon(L)
						L.become_blind("eyelids")
						sleep(50)
						L.Sleeping(600)

		if(willroll >= bloodroll)
			if(found_psycross == TRUE)
				to_chat(L, "<font color='white'>The silver psycross shines and protect me from the unholy magic.</font>")
				to_chat(user, span_userdanger("[L] has my BANE!It causes me to fail to ensnare their mind!"))
			else
				to_chat(user, "I fail to ensnare their mind.")
			if(willroll - bloodroll >= 3)
				if(found_psycross == TRUE)
					to_chat(L, "<font color='white'> The silver psycross shines and protect me from the blood magic, the one who used blood magic was [user]!</font>")
				else
					to_chat(user, "I fail to ensnare their mind.")
					to_chat(L, "I feel like someone or something unholy is messing with my head. I should get out of here!")
					var/holyskill = L.mind.get_skill_level(/datum/skill/magic/holy)
					var/arcaneskill = L.mind.get_skill_level(/datum/skill/magic/arcane)
					if(holyskill + arcaneskill >= 1)
						to_chat(L, "I feel like the unholy magic came from [user]. I should use my magic or miracles on them.")

/obj/effect/proc_holder/spell/targeted/transfix/master
	name = "Subjugate"
	overlay_state = "transfixmaster"
	releasedrain = 1000
	chargedrain = 0
	chargetime = 0
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = null
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/blood
	antimagic_allowed = TRUE
	recharge_time = 10 SECONDS
	include_user = 0
	max_targets = 0

/obj/effect/proc_holder/spell/targeted/transfix/master/cast(list/targets, mob/user = usr)
	var/msg = input("Soothe them. Dominate them. Speak and they will succumb.", "Transfix") as text|null
	if(length(msg) < 10)
		to_chat(user, span_userdanger("This is not enough!"))
		return FALSE
	var/bloodskill = user.mind.get_skill_level(/datum/skill/magic/blood)
	var/bloodroll = roll("[bloodskill]d10")
	user.say(msg)
	user.visible_message("<font color='red'>[user]'s eyes glow a ghastly red as they project their will outwards!</font>")
	for(var/mob/living/carbon/human/L in targets)
		var/datum/antagonist/vampire/VD = L.mind.has_antag_datum(/datum/antagonist/vampire)
		var/willpower = round(L.STAINT / 4)
		var/willroll = roll("[willpower]d6")
		if(VD)
			return
		if(L.cmode)
			willroll += 15
		if(bloodroll >= willroll)
			L.drowsyness = min(L.drowsyness + 50, 150)
			switch(L.drowsyness)
				if(0 to 50)
					to_chat(L, "You feel like a curtain is coming over your mind.")
					L.Slowdown(20)
				if(50 to 100)
					to_chat(L, "Your eyelids force themselves shut as you feel intense lethargy.")
					L.Slowdown(50)
					L.eyesclosed = TRUE
					for(var/atom/movable/screen/eye_intent/eyet in L.hud_used.static_inventory)
						eyet.update_icon(L)
					L.become_blind("eyelids")
				if(100 to INFINITY)
					to_chat(L, span_userdanger("You can't take it anymore. Your legs give out as you fall into the dreamworld."))
					L.eyesclosed = TRUE
					for(var/atom/movable/screen/eye_intent/eyet in L.hud_used.static_inventory)
						eyet.update_icon(L)
					L.become_blind("eyelids")
					L.Slowdown(50)
					sleep(50)
					L.Sleeping(300)

/mob/living/carbon/human/proc/disguise_button()
	set name = "Disguise"
	set category = "VAMPIRE"

	var/datum/antagonist/vampire/VD = mind?.has_antag_datum(/datum/antagonist/vampire)
	if(!VD)
		return
	if(world.time < VD.last_transform + 30 SECONDS)
		var/timet2 = (VD.last_transform + 30 SECONDS) - world.time
		to_chat(src, "<span class='warning'>No.. not yet. [round(timet2/10)]s</span>")
		return
	if(VD.disguised)
		VD.last_transform = world.time
		vampire_undisguise(VD)
	else
		if(VD.vitae < 100)
			to_chat(src, "<span class='warning'>I don't have enough Vitae!</span>")
			return
		VD.last_transform = world.time
		vampire_disguise(VD)

/mob/living/carbon/human/proc/vampire_disguise(datum/antagonist/vampire/VD)
	if(!VD)
		return
	VD.disguised = TRUE
	skin_tone = VD.cache_skin
	hair_color = VD.cache_hair
	eye_color = VD.cache_eyes
	facial_hair_color = VD.cache_hair
	mob_biotypes = MOB_ORGANIC
	update_body()
	update_hair()
	update_body_parts(redraw = TRUE)
	to_chat(src, span_notice("My true form is hidden."))

/mob/living/carbon/human/proc/vampire_undisguise(datum/antagonist/vampire/VD)
	if(!VD)
		return
	VD.disguised = FALSE
//	VD.cache_skin = skin_tone
//	VD.cache_eyes = eye_color
//	VD.cache_hair = hair_color
	mob_biotypes = MOB_UNDEAD
	skin_tone = "c9d3de"
	hair_color = "181a1d"
	facial_hair_color = "181a1d"
	eye_color = "ff0000"
	update_body()
	update_hair()
	update_body_parts(redraw = TRUE)
	to_chat(src, span_danger("My true form is revealed."))


/mob/living/carbon/human/proc/blood_strength()
	set name = "Night Muscles"
	set category = "VAMPIRE"

	var/cooldown = FALSE
	var/cooldown_time = 3000 // Five minutes cooldown

	var/datum/antagonist/vampire/VD = mind.has_antag_datum(/datum/antagonist/vampire)
	if(!VD)
		return
	if(VD.disguised)
		to_chat(src, span_warning("My curse is hidden."))
		return
	if(VD.vitae < 500)
		to_chat(src, span_warning("Not enough vitae."))
		return
	if(has_status_effect(/datum/status_effect/buff/bloodstrength))
		to_chat(src, span_warning("Already active."))
		return
	if(cooldown)
		to_chat(src, span_warning("I can't cast it yet!"))

	// Gain experience towards blood magic
	var/mob/living/carbon/human/licker = usr
	var/boon = usr.mind?.get_learning_boon(/datum/skill/magic/blood)
	var/amt2raise = licker.STAINT*2
	usr.mind.adjust_experience(/datum/skill/magic/blood, floor(amt2raise * boon), FALSE)
	VD.adjust_vitae(-500)
	apply_status_effect(/datum/status_effect/buff/bloodstrength)
	to_chat(src, "<span class='greentext'>! NIGHT MUSCLES !</span>")
	src.playsound_local(get_turf(src), 'sound/misc/vampirespell.ogg', 100, FALSE, pressure_affected = FALSE)
	cooldown = TRUE
	sleep(cooldown_time)
	to_chat(src, "<span class='info'>My [name] ability is ready to be casted again.</span>")
	cooldown = FALSE

/datum/status_effect/buff/bloodstrength
	id = "bloodstrength"
	alert_type = /atom/movable/screen/alert/status_effect/buff/bloodstrength
	effectedstats = list(STATKEY_STR = 6)
	duration = 1 MINUTES

/atom/movable/screen/alert/status_effect/buff/bloodstrength
	name = "Night Muscles"
	desc = ""
	icon_state = "bleed1"

/mob/living/carbon/human/proc/blood_celerity()
	set name = "Quickening"
	set category = "VAMPIRE"

	var/cooldown = FALSE
	var/cooldown_time = 3000 // Five minutes cooldown

	var/datum/antagonist/vampire/VD = mind.has_antag_datum(/datum/antagonist/vampire)
	if(!VD)
		return
	if(VD.disguised)
		to_chat(src, "<span class='warning'>My curse is hidden.</span>")
		return
	if(VD.vitae < 500)
		to_chat(src, "<span class='warning'>Not enough vitae.</span>")
		return
	if(has_status_effect(/datum/status_effect/buff/celerity))
		to_chat(src, "<span class='warning'>Already active.</span>")
		return
	if(cooldown)
		to_chat(src, "<span class='warning'>I can't cast it yet!</span>")
	// Gain experience towards blood magic
	var/mob/living/carbon/human/licker = usr
	var/boon = usr.mind?.get_learning_boon(/datum/skill/magic/blood)
	var/amt2raise = licker.STAINT*2
	usr.mind.adjust_experience(/datum/skill/magic/blood, floor(amt2raise * boon), FALSE)
	VD.adjust_vitae(-500)
	apply_status_effect(/datum/status_effect/buff/celerity)
	to_chat(src, "<span class='greentext'>! QUICKENING !</span>")
	src.playsound_local(get_turf(src), 'sound/misc/vampirespell.ogg', 100, FALSE, pressure_affected = FALSE)
	cooldown = TRUE
	sleep(cooldown_time)
	to_chat(src, "<span class='info'>My [name] ability is ready to be casted again.</span>")
	cooldown = FALSE

/datum/status_effect/buff/celerity
	id = "celerity"
	alert_type = /atom/movable/screen/alert/status_effect/buff/celerity
	effectedstats = list(STATKEY_SPD = 15, STATKEY_PER = 10)
	duration = 30 SECONDS

/datum/status_effect/buff/celerity/nextmove_modifier()
	return 0.60

/atom/movable/screen/alert/status_effect/buff/celerity
	name = "Quickening"
	desc = ""
	icon_state = "bleed1"

/mob/living/carbon/human/proc/blood_fortitude()
	set name = "Armor of Darkness"
	set category = "VAMPIRE"
	var/cooldown = FALSE
	var/cooldown_time = 6000 // Ten minutes cooldown, you get an anticrit 100 melee armor for free with the stats.

	var/datum/antagonist/vampire/VD = mind.has_antag_datum(/datum/antagonist/vampire)
	if(!VD)
		return
	if(VD.disguised)
		to_chat(src, "<span class='warning'>My curse is hidden.</span>")
		return
	if(VD.vitae < 500)
		to_chat(src, "<span class='warning'>Not enough vitae.</span>")
		return
	if(has_status_effect(/datum/status_effect/buff/fortitude))
		to_chat(src, "<span class='warning'>Already active.</span>")
		return
	if(cooldown)
		to_chat(src, "<span class='warning'>I can't cast it yet!</span>")
	// Gain experience towards blood magic
	var/mob/living/carbon/human/licker = usr
	var/boon = usr.mind?.get_learning_boon(/datum/skill/magic/blood)
	var/amt2raise = licker.STAINT*2
	usr.mind.adjust_experience(/datum/skill/magic/blood, floor(amt2raise * boon), FALSE)
	VD.adjust_vitae(-500)
	apply_status_effect(/datum/status_effect/buff/fortitude)
	to_chat(src, "<span class='greentext'>! ARMOR OF DARKNESS !</span>")
	src.playsound_local(get_turf(src), 'sound/misc/vampirespell.ogg', 100, FALSE, pressure_affected = FALSE)
	cooldown = TRUE
	sleep(cooldown_time)
	to_chat(src, "<span class='info'>My [name] ability is ready to be casted again.</span>")
	cooldown = FALSE

/datum/status_effect/buff/fortitude
	id = "fortitude"
	alert_type = /atom/movable/screen/alert/status_effect/buff/fortitude
	effectedstats = list(STATKEY_END = 20, STATKEY_CON = 20)
	duration = 30 SECONDS

/atom/movable/screen/alert/status_effect/buff/fortitude
	name = "Armor of Darkness"
	desc = ""
	icon_state = "bleed1"

/datum/status_effect/buff/fortitude/on_apply()
	. = ..()
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		QDEL_NULL(H.skin_armor)
		H.skin_armor = new /obj/item/clothing/armor/skin_armor/vampire_fortitude(H)
	owner.add_stress(/datum/stressevent/weed)

/datum/status_effect/buff/fortitude/on_remove()
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		if(istype(H.skin_armor, /obj/item/clothing/armor/skin_armor/vampire_fortitude))
			QDEL_NULL(H.skin_armor)
	. = ..()

/obj/item/clothing/armor/skin_armor/vampire_fortitude
	slot_flags = null
	name = "vampire's skin"
	desc = ""
	icon_state = null
	body_parts_covered = FULL_BODY
	armor = list("blunt" = 100, "slash" = 100, "stab" = 100,  "piercing" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_BLUNT, BCLASS_TWIST)
	blocksound = SOFTHIT
	blade_dulling = DULLING_BASHCHOP
	sewrepair = TRUE
	max_integrity = 0

/mob/living/carbon/human/proc/vamp_regenerate()
	set name = "Regenerate"
	set category = "VAMPIRE"
	var/cooldown = FALSE
	var/cooldown_time = 6000 // Ten minutes cooldown, it's a goddamn AHEAL

	var/silver_curse_status = FALSE
	for(var/datum/status_effect/debuff/silver_curse/SC in status_effects)
		silver_curse_status = TRUE
		break
	var/datum/antagonist/vampire/VD = mind.has_antag_datum(/datum/antagonist/vampire)
	if(!VD)
		return
	if(VD.disguised)
		to_chat(src, "<span class='warning'>My curse is hidden.</span>")
		return
	if(silver_curse_status)
		to_chat(src, "<span class='warning'>My BANE is not letting me REGENERATE!.</span>")
		return
	if(VD.vitae < 500)
		to_chat(src, "<span class='warning'>Not enough vitae.</span>")
		return
	if(cooldown)
		to_chat(src, "<span class='warning'>I can't cast it yet!</span>")
	to_chat(src, "<span class='greentext'>! REGENERATE !</span>")
	src.playsound_local(get_turf(src), 'sound/misc/vampirespell.ogg', 100, FALSE, pressure_affected = FALSE)
	VD.adjust_vitae(-500)
	// Gain experience towards blood magic
	var/mob/living/carbon/human/licker = usr
	var/boon = usr.mind?.get_learning_boon(/datum/skill/magic/blood)
	var/amt2raise = licker.STAINT*2
	usr.mind.adjust_experience(/datum/skill/magic/blood, floor(amt2raise * boon), FALSE)
	fully_heal(admin_revive = TRUE)
	var/obj/item/organ/eyes/eyes = licker.getorganslot(ORGAN_SLOT_EYES)
	if(eyes)
		eyes.Remove(licker, TRUE)
		QDEL_NULL(eyes)
	eyes = new /obj/item/organ/eyes/night_vision/zombie
	eyes.Insert(licker)
	cooldown = TRUE
	sleep(cooldown_time)
	to_chat(src, "<span class='info'>My [name] ability is ready to be casted again.</span>")
	cooldown = FALSE
