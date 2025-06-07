/obj/effect/proc_holder/spell/self/arcyne_eye
	name = "Arcyne Eye"
	desc = "Tap into the arcyne and see the leylines."
	active = FALSE
	releasedrain = 30
	chargedrain = 1
	chargetime = 0
	recharge_time = 10 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = TRUE
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	attunements = list(
		/datum/attunement/arcyne = 0.1
		)
	cost = 0
	overlay_state = "transfix"

/obj/effect/proc_holder/spell/self/arcyne_eye/cast(list/targets, mob/living/user)
	playsound(get_turf(user), 'sound/vo/smokedrag.ogg', 100, TRUE)
	var/duration_increase = min(0, attuned_strength * 1.5 MINUTES)
	user.apply_status_effect(/datum/status_effect/buff/duration_modification/arcyne_eye, duration_increase)
	return TRUE

/datum/status_effect/buff/duration_modification/arcyne_eye
	duration = 1 MINUTES
	alert_type = null

/datum/status_effect/buff/duration_modification/arcyne_eye/on_apply()
	ADD_TRAIT(owner, TRAIT_SEE_LEYLINES, type)
	owner.see_invisible = SEE_INVISIBLE_LEYLINES
	owner.hud_used?.plane_masters_update()
	return TRUE

/datum/status_effect/buff/duration_modification/arcyne_eye/on_remove()
	REMOVE_TRAIT(owner, TRAIT_SEE_LEYLINES, type)
	owner.see_invisible = SEE_INVISIBLE_LIVING
	owner.hud_used?.plane_masters_update()
