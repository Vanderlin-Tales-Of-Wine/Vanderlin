/datum/action/cooldown/spell/undirected/touch/darkvision
	name = "Darkvision"
	desc = "Enhance the night vision of a target you touch for an hour."
	button_icon_state = "darkvision"
	can_cast_on_self = TRUE

	point_cost = 2
	attunements = list(
		/datum/attunement/illusion = 0.4,
	)

	cooldown_time = 6 MINUTES

	hand_path = /obj/item/melee/touch_attack/darkvision
	draw_message = "I prepare to grant Darkvision."
	drop_message = "I release my arcyne focus."
	charges = 3

/datum/action/cooldown/spell/undirected/touch/darkvision/adjust_hand_charges()
	charges += FLOOR(attuned_strength * 1.5, 1)

/datum/action/cooldown/spell/undirected/touch/darkvision/is_valid_target(atom/cast_on)
	return isliving(cast_on)

/datum/action/cooldown/spell/undirected/touch/darkvision/cast_on_hand_hit(obj/item/melee/touch_attack/hand, mob/living/victim, mob/living/carbon/caster)
	. = ..()
	if(!do_after(caster, 5 SECONDS, victim))
		return

	var/duration_increase = min(0, attuned_strength * 2 MINUTES)

	if(victim != caster)
		caster.visible_message("[caster] draws a glyph in the air and touches [victim] with an arcyne focus.")
	else
		caster.visible_message("[caster] draws a glyph in the air and touches themselves with an arcyne focus.")

	victim.apply_status_effect(/datum/status_effect/buff/duration_modification/darkvision, duration_increase)

/obj/item/melee/touch_attack/darkvision
	name = "\improper arcyne focus"
	desc = "Touch a creature to grant them Darkvision for 10 minutes."
	color = "#3FBAFD"
