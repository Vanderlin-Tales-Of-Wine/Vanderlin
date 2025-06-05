GLOBAL_LIST_EMPTY(vampire_objects)

#define VITAE_LEVEL_STARVING 20
#define VITAE_LEVEL_HUNGRY 100
#define VITAE_LEVEL_FED 200

/datum/antagonist/vampire
	name = "Vampire"
	roundend_category = "Vampires"
	antagpanel_category = "Vampire"
	job_rank = ROLE_VAMPIRE
	antag_hud_type = ANTAG_HUD_VAMPIRE
	antag_hud_name = "vamp"
	confess_lines = list(
		"I WANT YOUR BLOOD!",
		"DRINK THE BLOOD!",
		"CHILD OF KAIN!",
	)

	/// This vampire's Team.
	var/datum/team/vampires/team = null
	/// If the vampire will autojoin on spawn.
	var/autojoin_team = FALSE //! shouldn't exist, need to find a better method

	/// TRAITs that the datum will grant.
	innate_traits = list(
		TRAIT_STRONGBITE,
		TRAIT_NOSTAMINA,
		TRAIT_NOHUNGER,
		TRAIT_NOBREATH,
		TRAIT_NOPAIN,
		TRAIT_TOXIMMUNE,
		TRAIT_STEELHEARTED,
		TRAIT_NOSLEEP,
		TRAIT_VAMPMANSION,
		TRAIT_VAMP_DREAMS,
		TRAIT_NOAMBUSH,
		TRAIT_DARKVISION,
		TRAIT_LIMBATTACHMENT,
	)

	var/vitae = 1000
	var/vmax = 3000

	COOLDOWN_DECLARE(last_transform)
	var/disguised = FALSE //! spawn
	var/cache_skin
	var/cache_eyes
	var/cache_hair

/datum/antagonist/vampire/examine_friendorfoe(datum/antagonist/examined_datum, mob/examiner, mob/examined)
	if(istype(examined_datum, /datum/antagonist/vampire/lord))
		return span_boldnotice("Kaine's firstborn!")
	if(istype(examined_datum, /datum/antagonist/vampire))
		return span_boldnotice("A child of Kaine.")
	if(istype(examined_datum, /datum/antagonist/zombie))
		return span_boldnotice("Another deadite.")
	if(istype(examined_datum, /datum/antagonist/skeleton))
		return span_boldnotice("Another deadite.")

/datum/antagonist/vampire/on_gain()
	owner.current.has_reflection = FALSE
	owner.current.cut_overlay(owner.current.reflective_icon)
	SSmapping.retainer.vampires |= owner
	move_to_spawnpoint()
	owner.special_role = name

	if(ishuman(owner.current))
		var/mob/living/carbon/human/vampdude = owner.current
		vampdude.adv_hugboxing_cancel()

	owner.current.cmode_music = 'sound/music/cmode/antag/CombatThrall.ogg'
	owner.current.adjust_skillrank(/datum/skill/magic/blood, 2, TRUE)
	owner.current.AddSpell(new /obj/effect/proc_holder/spell/targeted/transfix)

	vamp_look()
	. = ..()
	equip()
	after_gain()

/datum/antagonist/vampire/lord/on_gain()
	. = ..()
	owner.special_role = span_redtext("[name]")

/datum/antagonist/vampire/proc/after_gain()
	owner.current.verbs |= /mob/living/carbon/human/proc/vamp_regenerate
	owner.current.verbs |= /mob/living/carbon/human/proc/disguise_button

/datum/antagonist/vampire/on_removal()
	owner.current.has_reflection = TRUE
	owner.current.create_reflection()
	owner.current.update_reflection()
	if(!silent && owner.current)
		to_chat(owner.current, span_danger("I am no longer a [job_rank]!"))
	owner.special_role = null
	return ..()

/datum/antagonist/vampire/proc/equip()
	return

/datum/antagonist/vampire/greet()
	SHOULD_CALL_PARENT(TRUE)
	owner.current.playsound_local(get_turf(owner.current), 'sound/music/vampintro.ogg', 80, FALSE, pressure_affected = FALSE)
	. = ..()

/datum/antagonist/vampire/proc/vamp_look()
	var/mob/living/carbon/human/V = owner.current
	var/obj/item/organ/eyes/eyes = V.getorganslot(ORGAN_SLOT_EYES)
	cache_skin = V.skin_tone
	cache_eyes = V.get_eye_color()
	cache_hair = V.get_hair_color()
	V.skin_tone = "c9d3de"
	V.set_hair_color("#181a1d", FALSE)
	V.set_facial_hair_color("#181a1d", FALSE)

	eyes.heterochromia = FALSE
	eyes.eye_color = "#FF0000"

	V.update_body()
	V.update_body_parts(redraw = TRUE)
	V.mob_biotypes = MOB_UNDEAD

/datum/antagonist/vampire/on_life(mob/user)
	if(!user)
		return
	var/mob/living/carbon/human/H = user
	if(H.stat == DEAD)
		return
	if(H.advsetup)
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
	adjust_vitae(-1)
	handle_vitae()

/datum/antagonist/vampire/proc/exposed_to_sunlight()
	var/mob/living/H = owner.current
	if(!disguised)
		H.fire_act(1, 5)
		adjust_vitae(-10)

/datum/antagonist/vampire/proc/has_vitae(change)
	return (vitae >= change)

/datum/antagonist/vampire/proc/adjust_vitae(change, tribute)
	if(tribute)
		team?.vitae_pool?.update_pool(tribute)
	vitae = clamp(vitae + change, 0, vmax)

/datum/antagonist/vampire/proc/handle_vitae()
	//copy-paste from hunger code
	switch(vitae)
		if(VITAE_LEVEL_HUNGRY to VITAE_LEVEL_FED)
			owner.current.apply_status_effect(/datum/status_effect/debuff/thirstyt1)
			owner.current.remove_status_effect(/datum/status_effect/debuff/thirstyt2)
			owner.current.remove_status_effect(/datum/status_effect/debuff/thirstyt3)
		if(VITAE_LEVEL_STARVING to VITAE_LEVEL_HUNGRY)
			owner.current.apply_status_effect(/datum/status_effect/debuff/thirstyt2)
			owner.current.remove_status_effect(/datum/status_effect/debuff/thirstyt1)
			owner.current.remove_status_effect(/datum/status_effect/debuff/thirstyt3)
		if(-INFINITY to VITAE_LEVEL_STARVING)
			owner.current.apply_status_effect(/datum/status_effect/debuff/thirstyt3)
			owner.current.remove_status_effect(/datum/status_effect/debuff/thirstyt1)
			owner.current.remove_status_effect(/datum/status_effect/debuff/thirstyt2)
			if(prob(3))
				playsound(get_turf(owner.current), pick('sound/vo/hungry1.ogg','sound/vo/hungry2.ogg','sound/vo/hungry3.ogg'), 100, TRUE, -1)

/datum/antagonist/vampire/create_team(datum/team/vampires/new_team)
	var/static/datum/team/vampires/vampire_team //only one team for now
	if(!new_team)
		if(!vampire_team)
			vampire_team = new()
		if(autojoin_team)
			new_team = vampire_team

	if(istype(new_team) && (new_team != vampire_team))
		message_admins("[owner.name] just revealed that a second vampire team exists, this is pretty bad, should notify coders")
		stack_trace("two vampire teams were created, and the wrong one tried to be assigned")

	team = new_team

/datum/antagonist/vampire/get_team()
	return team

/obj/structure/vampire
	icon = 'icons/roguetown/topadd/death/vamp-lord.dmi'
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
