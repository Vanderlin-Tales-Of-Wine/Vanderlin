/datum/action/cooldown/spell/undirected/arcyne_eye
	name = "Arcyne Eye"
	desc = "Tap into the arcyne what is unseen."
	button_icon_state = "transfix"
	sound = 'sound/vo/smokedrag.ogg'

	point_cost = 0

	charge_required = FALSE
	cooldown_time = 25 SECONDS
	spell_cost = 30

	attunements = list(
		/datum/attunement/arcyne = 0.1
	)

/datum/action/cooldown/spell/undirected/arcyne_eye/cast(atom/cast_on)
	. = ..()
	if(isliving(owner))
		var/mob/living/L = owner
		var/duration_increase = min(0, attuned_strength * 1.5 MINUTES)
		L.apply_status_effect(/datum/status_effect/buff/duration_modification/arcyne_eye, duration_increase)

/datum/status_effect/buff/duration_modification/arcyne_eye
	duration = 1 MINUTES
	alert_type = null

/datum/status_effect/buff/duration_modification/arcyne_eye/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_SEE_LEYLINES, type)
	owner.see_invisible = SEE_INVISIBLE_LEYLINES
	owner.hud_used?.plane_masters_update()

/datum/status_effect/buff/duration_modification/arcyne_eye/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_SEE_LEYLINES, type)
	owner.see_invisible = SEE_INVISIBLE_LIVING
	owner.hud_used?.plane_masters_update()
