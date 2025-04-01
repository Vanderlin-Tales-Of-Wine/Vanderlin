/datum/status_effect/frost_trap
	id = "frozen_trapped"
	duration = 10 SECONDS
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/freon
	var/icon/cube

/datum/status_effect/frost_trap/on_apply()
	RegisterSignal(owner, COMSIG_MOB_APPLY_DAMGE, PROC_REF(on_attacked))
	cube = icon('icons/effects/freeze.dmi', "ice_cube")
	owner.apply_status_effect(STATUS_EFFECT_PARALYZED)
	owner.add_overlay(cube)
	owner.update_mobility()
	return ..()

/datum/status_effect/frost_trap/proc/on_attacked(datum/source, damage,type,zone)
	to_chat(owner, span_danger("The ice around me violently shatters; damaging me further!"))
	owner.remove_status_effect(/datum/status_effect/frost_trap)
	owner.update_mobility()
	owner.apply_damage(damage,type,zone)
	return

/datum/status_effect/frost_trap/tick()
	owner.update_mobility()

/datum/status_effect/frost_trap/on_remove()
	owner.remove_status_effect(STATUS_EFFECT_PARALYZED)
	owner.cut_overlay(cube)
	owner.update_mobility()
	UnregisterSignal(owner,COMSIG_MOB_APPLY_DAMGE)
