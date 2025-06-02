
/obj/effect/proc_holder/spell/invoked/guidance
	name = "Guidance"
	desc = "Blesses your target with arcyne luck, improving their ability in combat. (+10% chance to hit with melee, +10% chance to defend from melee)"
	cost = 2
	releasedrain = 60
	chargedrain = 1
	chargetime = 4 SECONDS
	recharge_time = 5 MINUTES
	warnie = "spellwarning"
	school = "transmutation"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane


/obj/effect/proc_holder/spell/invoked/guidance/cast(list/targets, mob/user)
	var/atom/A = targets[1]
	if(!isliving(A))
		return FALSE

	var/mob/living/spelltarget = A

	playsound(get_turf(spelltarget), 'sound/magic/haste.ogg', 80, TRUE, soundping = TRUE)

	if(spelltarget != user)
		user.visible_message("[user] mutters an incantation and [spelltarget] briefly shines orange.")
	else
		user.visible_message("[user] mutters an incantation and they briefly shine orange.")

	return TRUE

/datum/status_effect/buff/duration_modification/guidance
	id = "guidance"
	alert_type = /atom/movable/screen/alert/status_effect/buff/guidance
	duration = 1 MINUTES
	effectedstats = list(STATKEY_INT = 2)
	var/static/mutable_appearance/guided = mutable_appearance('icons/effects/effects.dmi', "blessed")

/datum/status_effect/buff/duration_modification/guidance/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_GUIDANCE, MAGIC_TRAIT)
	var/mob/living/target = owner
	target.add_overlay(guided)

/datum/status_effect/buff/duration_modification/guidance/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_GUIDANCE, MAGIC_TRAIT)
	var/mob/living/target = owner
	target.cut_overlay(guided)

/atom/movable/screen/alert/status_effect/buff/guidance
	name = "Guidance"
	desc = span_nicegreen("Arcyne assistance guides my senses in combat.")
	icon_state = "buff"
