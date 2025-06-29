/datum/element/divine_intervention
	element_flags = ELEMENT_DETACH
	var/datum/stressevent/stress_event
	var/datum/patron/patron
	var/allows_pantheon
	var/sets_alight

/datum/element/divine_intervention/Attach(obj/item/item, patron = /datum/patron/divine/astrata, allows_pantheon = PUNISHMENT_NONE, stress_event = null, sets_alight = FALSE)
	. = ..()
	if(!istype(item))
		return ELEMENT_INCOMPATIBLE
	src.patron = GLOB.patronlist[patron]
	src.allows_pantheon = allows_pantheon
	src.stress_event = stress_event
	src.sets_alight = sets_alight
	RegisterSignal(item, COMSIG_ITEM_PICKUP, PROC_REF(on_pickup))

/datum/element/divine_intervention/Detach(obj/item/item)
	. = ..()
	patron = null
	UnregisterSignal(item, COMSIG_ITEM_PICKUP)

/datum/element/divine_intervention/proc/on_pickup(obj/item/source, mob/user)
	SIGNAL_HANDLER
	if(!iscarbon(user))
		return
	var/mob/living/carbon/mob = user
	if(!mob.patron)
		return
	var/datum/patron/mob_patron = mob.patron
	if(istype(mob_patron, patron))
		return
	var/punishment = PUNISHMENT_BURN
	if(allows_pantheon && ispath(mob_patron.associated_faith, patron.associated_faith))
		punishment = allows_pantheon

	if(punishment == PUNISHMENT_NONE)
		return

	if(stress_event && punishment >= PUNISHMENT_STRESS)
		to_chat(mob, span_warning("I feel the eyes of [patron.name] upon me..."))
		mob.add_stress(/datum/stressevent/divine_punishment)

	if(sets_alight && punishment >= PUNISHMENT_BURN)
		to_chat(mob, span_warning("[patron.name] spurns me for touching their sacred item, \the [source]!"))
		mob.adjust_fire_stacks(4)
		mob.IgniteMob()
		mob.drop_all_held_items()
