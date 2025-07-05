/datum/action/cooldown/spell/undirected/touch/non_detection
	name = "Nondetection"
	desc = "Consume a handful of ash and shroud a target that you touch from divination magic for 1 hour."
	button_icon_state = "prestidigitation"
	can_cast_on_self = "nondetect"

	point_cost = 1
	attunements = list(
		/datum/attunement/illusion = 0.4,
	)

	cooldown_time = 10 MINUTES

	hand_path = /obj/item/melee/touch_attack/nondetection
	draw_message = "I prepare to form a magical shroud."
	drop_message = "I release my arcyne focus."
	charges = 2

/datum/action/cooldown/spell/undirected/touch/non_detection/adjust_hand_charges()
	charges += FLOOR(attuned_strength * 1.5, 1)

/datum/action/cooldown/spell/undirected/touch/non_detection/is_valid_target(atom/cast_on)
	return isliving(cast_on)

/datum/action/cooldown/spell/undirected/touch/non_detection/cast_on_hand_hit(obj/item/melee/touch_attack/hand, mob/living/victim, mob/living/carbon/caster)
	if(victim.has_status_effect(/datum/status_effect/non_detection) || HAS_TRAIT(target, TRAIT_ANTISCRYING))
		to_chat(caster, span_warning("[victim] already has protection from divination magic."))
		return FALSE

	var/obj/item/sacrifice
	for(var/obj/item/I in caster.held_items)
		if(istype(I, /obj/item/ash))
			sacrifice = I

	if(!sacrifice)
		to_chat(caster, span_warning("I require some ash in a free hand."))
		return FALSE

	if(!do_after(caster, 5 SECONDS, victim))
		return FALSE

	qdel(sacrifice)

	if(victim != caster)
		caster.visible_message("[caster] draws a glyph in the air and blows some ash onto [victim].")
	else
		caster.visible_message("[caster] draws a glyph in the air and covers themselves in ash.")

	victim.apply_status_effect(/datum/status_effect/non_detection, 1 HOURS)

	return TRUE

/obj/item/melee/touch_attack/nondetection
	name = "\improper arcyne focus"
	desc = "Touch a creature to cover them in an anti-scrying shroud for 1 hour, consumes some ash as a catalyst."
	color = "#3FBAFD"

/atom/movable/screen/alert/status_effect/non_detection
	name = "Thaumaturgical Voice"
	desc = "I am projected from divination magic for a time."
	icon_state = "stressvg"

/datum/status_effect/non_detection
	id = "non_detection"
	alert_type = /atom/movable/screen/alert/status_effect/non_detection
	duration = 3 MINUTES

/datum/status_effect/non_detection/on_creation()
	. = ..()
	ADD_TRAIT(owner, TRAIT_ANTISCRYING, MAGIC_TRAIT)

/datum/status_effect/non_detection/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_ANTISCRYING, MAGIC_TRAIT)
