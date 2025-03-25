/obj/effect/proc_holder/spell/invoked/boomingblade5e
	name = "Booming Blade"
	desc = "Causes explosions to ripple out from your target when they move."
	overlay_state = "blade_burst"
	releasedrain = 50
	chargetime = 3
	recharge_time = 15 SECONDS
	//chargetime = 10
	//recharge_time = 30 SECONDS
	range = 6
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1


	miracle = FALSE

	invocation = "Stay still!" // Incantation should explain a confusing spell's mechanic.
	invocation_type = "shout" //can be none, whisper, emote and shout

	attunements = list(
		/datum/attunement/earth = 0.3,
	)

/obj/effect/proc_holder/spell/invoked/boomingblade5e/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/carbon/target = targets[1]
		var/mob/living/L = target
		var/mob/U = user
		var/obj/item/held_item = user.get_active_held_item() //get held item
		if(held_item)
			held_item.melee_attack_chain(U, L)
			target.apply_status_effect(/datum/status_effect/buff/boomingblade5e) //apply buff
		return TRUE
	return FALSE

/datum/status_effect/buff/boomingblade5e
	id = "booming blade"
	alert_type = /atom/movable/screen/alert/status_effect/buff/boomingblade5e
	duration = 10 SECONDS
	var/turf/start_pos
	var/static/mutable_appearance/glow = mutable_appearance('icons/effects/effects.dmi', "empdisable", -MUTATIONS_LAYER)

/datum/status_effect/buff/boomingblade5e/on_apply()
	. = ..()
	var/mob/living/target = owner
	target.add_overlay(glow)
	target.update_vision_cone()
	start_pos = get_turf(target) //set buff starting position

/datum/status_effect/buff/boomingblade5e/on_remove()
	var/mob/living/target = owner
	target.cut_overlay(glow)
	target.update_vision_cone()
	. = ..()

/datum/status_effect/buff/boomingblade5e/tick()
	var/turf/new_pos = get_turf(owner)
	var/startX = start_pos.x
	var/startY = start_pos.y
	var/newX = new_pos.x
	var/newY = new_pos.y
	if(startX != newX || startY != newY)//if target moved
		//explosion
		if(!owner.anti_magic_check())
			boom()
		qdel(src)

/datum/status_effect/buff/boomingblade5e/proc/boom()
	var/exp_heavy = 0
	var/exp_light = 0
	var/exp_flash = 2
	var/exp_fire = 0
	var/damage = 10
	explosion(owner, -1, exp_heavy, exp_light, exp_flash, 0, flame_range = exp_fire)
	owner.adjustBruteLoss(damage)
	owner.visible_message(span_warning("A thunderous boom eminates from [owner]!"), span_danger("A thunderous boom eminates from you!"))

/atom/movable/screen/alert/status_effect/buff/boomingblade5e
	name = "Booming Blade"
	desc = "I feel if I move I am in serious trouble."
	icon_state = "debuff"
