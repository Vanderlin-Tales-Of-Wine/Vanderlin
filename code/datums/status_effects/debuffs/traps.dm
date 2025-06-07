/datum/status_effect/frost_trap
	id = "frozen_trapped"
	duration = 10 SECONDS
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/freon
	var/icon/cube

/datum/status_effect/frost_trap/on_apply()
	. = ..()
	if(!.)
		return
	RegisterSignal(owner, COMSIG_MOB_APPLY_DAMGE, PROC_REF(on_attacked))
	cube = icon('icons/effects/freeze.dmi', "ice_cube")
	ADD_TRAIT(owner, TRAIT_INCAPACITATED, TRAIT_STATUS_EFFECT(id))
	ADD_TRAIT(owner, TRAIT_IMMOBILIZED, TRAIT_STATUS_EFFECT(id))
	owner.add_overlay(cube)

/datum/status_effect/frost_trap/proc/on_attacked(datum/source, damage,type,zone)
	to_chat(owner, span_danger("The ice around me violently shatters; damaging me further!"))
	owner.remove_status_effect(/datum/status_effect/frost_trap)
	owner.apply_damage(damage,type,zone)
	return

/datum/status_effect/frost_trap/on_remove()
	REMOVE_TRAIT(owner, TRAIT_INCAPACITATED, TRAIT_STATUS_EFFECT(id))
	REMOVE_TRAIT(owner, TRAIT_IMMOBILIZED, TRAIT_STATUS_EFFECT(id))
	owner.cut_overlay(cube)
	UnregisterSignal(owner,COMSIG_MOB_APPLY_DAMGE)
	return ..()

/datum/status_effect/frozen_solid
	parent_type = /datum/status_effect/frost_trap
	id = "frozen_solid"
	alert_type = /atom/movable/screen/alert/status_effect/frozen_solid
	var/icon/spike

/datum/status_effect/frozen_solid/on_apply()
	. = ..()
	if (!.) return
	spike = icon('icons/effects/freeze.dmi', "spike")
	owner.cut_overlay(cube) // remove base cube overlay
	owner.add_overlay(spike)
	var/mob/living/M = owner
	if (M)
		to_chat(M, span_warning("You're trapped in solid ice!"))

/datum/status_effect/frozen_solid/on_remove()
	owner.cut_overlay(spike) // remove the spike overlay
	playsound(owner.loc, "glassbreak", 100, TRUE)
	var/mob/living/M = owner
	if (M)
		M.Jitter(5)
		to_chat(M, span_notice("The ice shatters and you're free!"))
	. = ..()

/atom/movable/screen/alert/status_effect/frozen_solid
	name = "Frozen Solid"
	desc = "You are encased in solid ice and cannot move!"
	icon_state = "frozen"
