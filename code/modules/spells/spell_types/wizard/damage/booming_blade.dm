/obj/effect/proc_holder/spell/invoked/boomingblade5e
	name = "Booming Blade"
	desc = "Causes explosions to ripple out from your target when they move."
	overlay_state = "blade_burst"
	releasedrain = 50
	chargetime = 3
	recharge_time = 15 SECONDS
	range = 6
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	cost = 1
	miracle = FALSE
	invocation = "Stay still!"
	invocation_type = "shout"
	attunements = list(
		/datum/attunement/arcyne = 0.4,
	)

/obj/effect/proc_holder/spell/invoked/boomingblade5e/set_attuned_strength(list/incoming_attunements)
	var/total_value = 1
	for(var/datum/attunement/attunement as anything in attunements)
		if(!(attunement in incoming_attunements))
			continue
		total_value += incoming_attunements[attunement] * attunements[attunement]
	attuned_strength = total_value
	attuned_strength = max(attuned_strength, 0.5)
	return

/obj/effect/proc_holder/spell/invoked/boomingblade5e/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/carbon/target = targets[1]
		var/mob/living/L = target
		var/mob/U = user
		var/obj/item/held_item = user.get_active_held_item()
		if(held_item)
			held_item.melee_attack_chain(U, L)
			// Pass attunement strength to status effect
			target.apply_status_effect(/datum/status_effect/buff/boomingblade5e, attuned_strength)
		return TRUE
	return FALSE

/datum/status_effect/buff/boomingblade5e
	var/strength_multiplier = 1

/datum/status_effect/buff/boomingblade5e/New(atom/A, strength = 1)
	strength_multiplier = strength
	. = ..()

/datum/status_effect/buff/boomingblade5e/proc/boom()
	var/exp_heavy = 0
	var/exp_light = round(1 * strength_multiplier)  // Scale explosion
	var/exp_flash = round(2 * strength_multiplier)
	var/exp_fire = 0
	var/damage = round(10 * strength_multiplier)  // Scale damage

	explosion(owner, -1, exp_heavy, exp_light, exp_flash, 0, flame_range = exp_fire)
	owner.adjustBruteLoss(damage)
	owner.visible_message(span_warning("A thunderous boom eminates from [owner]!"), span_danger("A thunderous boom eminates from you!"))
