/obj/effect/proc_holder/spell/self/primalsavagery5e
	name = "Primal Savagery"
	desc = "For a short duration you develop the ability to inject targets with poisons with each bite."
	range = 8
	overlay_state = "null"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE

	releasedrain = 50
	chargedrain = 1
	chargetime = 3
	recharge_time = 60 SECONDS //cooldown

	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	antimagic_allowed = FALSE //can you use it if you are antimagicked?
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/druidic //can be arcane, druidic, blood, holy
	cost = 1

	attunements = list(
		/datum/attunement/earth = 0.3,
	)

	miracle = FALSE

	overlay_state = "wolf_head"
	invocation = "Teeth of a serpent."
	invocation_type = "whisper" //can be none, whisper, emote and shout
// Notes: Bard, Sorcerer, Warlock, Wizard

/obj/effect/proc_holder/spell/self/primalsavagery5e/cast(mob/user = usr)
	var/mob/living/target = user
	var/duration_increase = min(0, attuned_strength * 1 MINUTES)
	target.apply_status_effect(/datum/status_effect/buff/duration_increase/primalsavagery5e, duration_increase)
	ADD_TRAIT(target, TRAIT_POISONBITE, TRAIT_GENERIC)
	user.visible_message(span_info("[user] looks more primal!"), span_info("You feel more primal."))

	if(attuned_strength > 1.5)
		for(var/mob/living/extra_target in range(FLOOR(attuned_strength, 1)))
			if(extra_target == target)
				continue
			extra_target.apply_status_effect(/datum/status_effect/buff/duration_increase/primalsavagery5e, duration_increase)
			ADD_TRAIT(extra_target, TRAIT_POISONBITE, TRAIT_GENERIC)
			extra_target.visible_message(span_info("[extra_target] looks more primal!"), span_info("You feel more primal."))

	return TRUE

/datum/status_effect/buff/duration_increase/primalsavagery5e
	id = "primal savagery"
	alert_type = /atom/movable/screen/alert/status_effect/buff/primalsavagery5e
	duration = 30 SECONDS

/atom/movable/screen/alert/status_effect/buff/primalsavagery5e
	name = "Primal Savagery"
	desc = "I have grown venomous fangs inject my victims with poison."
	icon_state = "buff"

/datum/status_effect/buff/duration_increase/primalsavagery5e/on_remove()
	var/mob/living/target = owner
	REMOVE_TRAIT(target, TRAIT_POISONBITE, TRAIT_GENERIC)
	. = ..()
