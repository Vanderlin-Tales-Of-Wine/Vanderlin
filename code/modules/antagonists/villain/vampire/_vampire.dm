GLOBAL_LIST_EMPTY(vampire_objects)

/datum/antagonist/vampire
	name = "Vampire"
	roundend_category = "Vampires"
	antagpanel_category = "Vampire"
	job_rank = ROLE_VAMPIRE
	antag_hud_type = ANTAG_HUD_TRAITOR
	antag_hud_name = "vampire"
	confess_lines = list(
		"I WANT YOUR BLOOD!",
		"DRINK THE BLOOD!",
		"CHILD OF KAIN!",
	)
	var/isspawn = FALSE
	var/disguised = FALSE
	var/ascended = FALSE
	var/starved = FALSE
	var/sired = FALSE
	var/vamplevel = 0
	var/vitae = 1000
	var/vmax = 2000
	COOLDOWN_DECLARE(last_transform)
	var/cache_skin
	var/cache_eyes
	var/cache_hair
	var/obj/effect/proc_holder/spell/targeted/shapeshift/bat/batform //attached to the datum itself to avoid cloning memes, and other duplicates
	var/obj/effect/proc_holder/spell/targeted/shapeshift/gaseousform/gas

/datum/antagonist/vampire/examine_friendorfoe(datum/antagonist/examined_datum, mob/examiner, mob/examined)
	if(istype(examined_datum, /datum/antagonist/vampire/lesser))
		return span_boldnotice("A vampire spawn.")
	if(istype(examined_datum, /datum/antagonist/vampire/lord))
		return span_boldnotice("A vampire lord!")
	if(istype(examined_datum, /datum/antagonist/vampire))
		return span_boldnotice("A wandering vampire.")

	if(istype(examined_datum, /datum/antagonist/zombie))
		return span_boldnotice("Another deadite.")
	if(istype(examined_datum, /datum/antagonist/skeleton))
		return span_boldnotice("Another deadite.")

/datum/antagonist/vampire/apply_innate_effects(mob/living/mob_override)
	var/mob/living/M = mob_override || owner.current
	add_antag_hud(antag_hud_type, antag_hud_name, M)

/datum/antagonist/vampire/remove_innate_effects(mob/living/mob_override)
	var/mob/living/M = mob_override || owner.current
	remove_antag_hud(antag_hud_type, M)

/datum/antagonist/vampire/on_gain()
	var/mob/living/carbon/human/vampire = owner
	vampire.adv_hugboxing_end() // shitty workaround for adventurers and pilgrims becoming vamp
	SSmapping.retainer.vampires |= owner
	. = ..()
	owner.special_role = name
	move_to_spawnpoint()
	ADD_TRAIT(owner.current, TRAIT_CRITICAL_WEAKNESS, "[type]") //half assed but necessary otherwise these guys be invincible
	ADD_TRAIT(owner.current, TRAIT_STRONGBITE, "[type]")
	ADD_TRAIT(owner.current, TRAIT_NOSTAMINA, "[type]")
	ADD_TRAIT(owner.current, TRAIT_NOHUNGER, "[type]")
	ADD_TRAIT(owner.current, TRAIT_NOBREATH, "[type]")
	ADD_TRAIT(owner.current, TRAIT_NOPAIN, "[type]")
	ADD_TRAIT(owner.current, TRAIT_TOXIMMUNE, "[type]")
	ADD_TRAIT(owner.current, TRAIT_STEELHEARTED, "[type]")
	ADD_TRAIT(owner.current, TRAIT_NOSLEEP, "[type]")
	ADD_TRAIT(owner.current, TRAIT_VAMPMANSION, "[type]")

	ADD_TRAIT(owner.current, TRAIT_VAMP_DREAMS, "[type]")
	owner.current.cmode_music = 'sound/music/cmode/antag/CombatThrall.ogg'
	owner.current.AddSpell(new /obj/effect/proc_holder/spell/targeted/transfix)
	owner.current.verbs |= /mob/living/carbon/human/proc/vamp_regenerate
	owner.current.verbs |= /mob/living/carbon/human/proc/vampire_telepathy
	vamp_look()
	after_gain()
	greet()
	return ..()

/datum/antagonist/vampire/on_removal()
	if(!silent && owner.current)
		to_chat(owner.current,span_danger("I am no longer a [job_rank]!"))
	owner.special_role = null
	if(!isnull(batform))
		owner.current.RemoveSpell(batform)
		QDEL_NULL(batform)
	return ..()

/datum/antagonist/vampire/proc/after_gain()
	return

/datum/antagonist/vampire/proc/equip()
	owner.unknow_all_people()
	for(var/datum/mind/MF in get_minds())
		owner.become_unknown_to(MF)
	for(var/datum/mind/MF in get_minds("Vampire Spawn"))
		owner.i_know_person(MF)
		owner.person_knows_me(MF)
	for(var/datum/mind/MF in get_minds("Death Knight"))
		owner.i_know_person(MF)
		owner.person_knows_me(MF)

/datum/antagonist/vampire/proc/add_objective(datum/objective/O)
	var/datum/objective/V = new O
	objectives += V

/datum/antagonist/vampire/greet()
	SHOULD_CALL_PARENT(TRUE)
	owner.current.playsound_local(get_turf(owner.current), 'sound/music/vampintro.ogg', 80, FALSE, pressure_affected = FALSE)
	owner.announce_objectives()
	. = ..()

/datum/antagonist/vampire/proc/vamp_look()
	var/mob/living/carbon/human/V = owner.current
	cache_skin = V.skin_tone
	cache_eyes = V.eye_color
	cache_hair = V.hair_color
	V.skin_tone = "c9d3de"
	V.hair_color = "181a1d"
	V.facial_hair_color = "181a1d"
	V.eye_color = "ff0000"
	V.update_body()
	V.update_hair()
	V.update_body_parts(redraw = TRUE)
	V.mob_biotypes = MOB_UNDEAD
	if(isspawn)
		V.vampire_disguise()

/datum/antagonist/vampire/on_life(mob/user)
	if(!user)
		return
	var/mob/living/carbon/human/H = user
	if(H.stat == DEAD)
		return
	if(H.advsetup)
		return
	if(ascended)
		return
	if(world.time % 5)
		if(GLOB.tod != "night")
			if(isturf(H.loc))
				var/turf/T = H.loc
				if(T.can_see_sky())
					if(T.get_lumcount() > 0.15)
						exposed_to_sunlight()

	if(H.on_fire)
		if(disguised)
			last_transform = world.time
			H.vampire_undisguise(src)
		H.freak_out()

	if(H.stat)
		if(istype(H.loc, /obj/structure/closet/crate/coffin))
			H.fully_heal()

	if(vitae > 0)
		H.blood_volume = BLOOD_VOLUME_NORMAL
		if(vitae < 200)
			if(disguised)
				to_chat(H, span_warning("My disguise fails!"))
				H.vampire_undisguise(src)
	handle_vitae(-1)

/datum/antagonist/vampire/proc/exposed_to_sunlight()
	var/mob/living/H = owner
	if(!disguised)
		H.fire_act(1, 5)
		handle_vitae(-10)

/datum/antagonist/vampire/proc/handle_vitae(change, tribute)
	if(vitae <= 20)
		if(!starved)
			to_chat(owner, span_userdanger("I starve, my power dwindles! I am so weak!"))
			starved = TRUE
			for(var/S in MOBSTATS)
				owner.current.change_stat(S, -5)
	else
		if(starved)
			starved = FALSE
			for(var/S in MOBSTATS)
				owner.current.change_stat(S, 5)

/datum/antagonist/vampire/proc/move_to_spawnpoint()
	return

/datum/antagonist/vampire/proc/grow_in_power()
	if(vamplevel >= 3)
		return
	switch(vamplevel)
		if(0)
			batform = new
			owner.current.AddSpell(batform)
			for(var/obj/structure/vampire/portalmaker/S in GLOB.vampire_objects)
				S.unlocked = TRUE
			for(var/statkey in MOBSTATS)
				owner.current.change_stat(statkey, 2)
			to_chat(owner, "<font color='red'>I am refreshed and have grown stronger. The visage of the bat is once again available to me. I can also once again access my portals.</font>")
		if(1)
			owner.current.verbs |= /mob/living/carbon/human/proc/vamp_regenerate
			owner.current.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/bloodsteal)
			owner.current.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/bloodlightning)
			owner.adjust_skillrank(/datum/skill/magic/blood, 3, TRUE)
			gas = new
			owner.current.AddSpell(gas)
			for(var/S in MOBSTATS)
				owner.current.change_stat(S, 2)
			to_chat(owner, "<font color='red'>My power is returning. I can once again access my spells. I have also regained usage of my mist form.</font>")
		if(2)
			for(var/obj/structure/vampire/necromanticbook/S in GLOB.vampire_objects)
				S.unlocked = TRUE
			owner.current.verbs |= /mob/living/carbon/human/proc/blood_strength
			owner.current.verbs |= /mob/living/carbon/human/proc/blood_celerity
			owner.current.RemoveSpell(/obj/effect/proc_holder/spell/targeted/transfix)
			owner.current.AddSpell(new /obj/effect/proc_holder/spell/targeted/transfix/master)
			for(var/S in MOBSTATS)
				owner.current.change_stat(S, 2)
			to_chat(owner, span_notice("My dominion over others minds and my own body returns to me. I am nearing perfection. The armies of the dead shall now answer my call."))
		if(3)
			owner.current.visible_message("<font color='red'>[owner.current] is enveloped in dark crimson, a horrific sound echoing in the area. They are evolved.</font>","<font color='red'>I AM ANCIENT, I AM THE LAND. EVEN THE SUN BOWS TO ME.</font>")
			ascended = TRUE
			SSmapping.retainer.ascended = TRUE
			for(var/datum/mind/thrall in SSmapping.retainer.vampires)
				if(thrall.special_role == "Vampire Spawn")
					thrall.current.verbs |= /mob/living/carbon/human/proc/blood_strength
					thrall.current.verbs |= /mob/living/carbon/human/proc/blood_celerity
					thrall.current.verbs |= /mob/living/carbon/human/proc/vamp_regenerate
					for(var/S in MOBSTATS)
						thrall.current.change_stat(S, 2)
	vamplevel++

/datum/antagonist/vampire/roundend_report()
	var/traitorwin = TRUE
	printplayer(owner)

	var/count = 0
	if(isspawn) // don't need to spam up the chat with all spawn
		if(objectives.len)//If the traitor had no objectives, don't need to process this.
			for(var/datum/objective/objective in objectives)
				objective.update_explanation_text()
				if(objective.check_completion())
					to_chat(owner, "<B>Goal #[count]</B>: [objective.explanation_text] <span class='greentext'>TRIUMPH!</span>")
				else
					to_chat(owner, "<B>Goal #[count]</B>: [objective.explanation_text] <span class='redtext'>Failure.</span>")
					traitorwin = FALSE
				count += objective.triumph_count
	else
		if(objectives.len)//If the traitor had no objectives, don't need to process this.
			for(var/datum/objective/objective in objectives)
				objective.update_explanation_text()
				if(objective.check_completion())
					to_chat(world, "<B>Goal #[count]</B>: [objective.explanation_text] <span class='greentext'>TRIUMPH!</span>")
				else
					to_chat(world, "<B>Goal #[count]</B>: [objective.explanation_text] <span class='redtext'>Failure.</span>")
					traitorwin = FALSE
				count += objective.triumph_count

	var/special_role_text = lowertext(name)
	if(traitorwin)
		if(count)
			if(owner)
				owner.adjust_triumphs(count)
		to_chat(world, span_greentext("The [special_role_text] has TRIUMPHED!"))
		if(owner?.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/triumph.ogg', 100, FALSE, pressure_affected = FALSE)
	else
		to_chat(world, span_redtext("The [special_role_text] has FAILED!"))
		if(owner?.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/fail.ogg', 100, FALSE, pressure_affected = FALSE)

/obj/structure/vampire
	icon = 'icons/roguetown/topadd/death/vamp-lord.dmi'
	var/unlocked = FALSE
	density = TRUE

/obj/structure/vampire/Initialize()
	GLOB.vampire_objects |= src
	. = ..()

/obj/structure/vampire/Destroy()
	GLOB.vampire_objects -= src
	return ..()

// LANDMARKS

/obj/effect/landmark/start/vampirelord
	name = "Vampire Lord"
	icon_state = "arrow"
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/vampirelord/Initialize()
	. = ..()
	GLOB.vlord_starts += loc

/obj/effect/landmark/start/vampirespawn
	name = "Vampire Spawn"
	icon_state = "arrow"
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/vampirespawn/Initialize()
	. = ..()
	GLOB.vspawn_starts += loc

/obj/effect/landmark/start/vampireknight
	name = "Death Knight"
	icon_state = "arrow"
	jobspawn_override = list("Death Knight")
	delete_after_roundstart = FALSE

/obj/effect/landmark/vteleport
	name = "Teleport Destination"
	icon_state = "x2"

/obj/effect/landmark/vteleportsending
	name = "Teleport Sending"
	icon_state = "x2"

/obj/effect/landmark/vteleportdestination
	name = "Return Destination"
	icon_state = "x2"
	var/amuletname

/obj/effect/landmark/vteleportsenddest
	name = "Sending Destination"
	icon_state = "x2"
