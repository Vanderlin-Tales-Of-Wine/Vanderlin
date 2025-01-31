/obj/effect/proc_holder/spell/invoked/vicious_mimicry
	name = "Vicious Mimicry"
	desc = "Speak as a target in range."
	overlay_state = "mimicry"
	invocation_type = "none"
	associated_skill = /datum/skill/magic/holy
	charge_max = 1 MINUTES
	req_items = list(/obj/item/clothing/neck/roguetown/psycross/silver/xylix)
	miracle = TRUE
	devotion_cost = 25

/obj/effect/proc_holder/spell/invoked/vicious_mimicry/cast(list/targets,mob/user = usr)
	if(!isliving(targets[1]))
		return FALSE
	var/mob/living/victim = targets[1]
	if(victim.anti_magic_check())
		to_chat(user, span_warning("Your manipulation of [victim] failed!"))
		return ..()
	var/forced_speak = input(user, "What should they say?", "Vicious Mimicry")
	if(!forced_speak)
		return FALSE
	var/list/bannedwords = list("zizo","graggar","matthios","baotha","inhumen","heresy")
	forced_speak = sanitize_hear_message(forced_speak)
	for(var/T in bannedwords)  //astrata smites naughty xylixans
		if(findtext(forced_speak, T))
			if(isliving(user))
				var/mob/living/L = user
				L.add_stress(/datum/stressevent/psycurse)
				L.adjust_fire_stacks(6)
				L.IgniteMob()
			return ..()
	to_chat(victim, span_userdanger("Your mouth starts to move on its own!"))
	victim.say(forced_speak, forced = "spell")
	victim.log_message("[user] has forced [victim] to say '[forced_speak]' with Vicious Mimicry!")
	user.log_message("[user] has forced [victim] to say '[forced_speak]' with Vicious Mimicry!")
	return ..()

/obj/effect/proc_holder/spell/invoked/wheel
	name = "Wheel of Fortune"
	releasedrain = 10
	chargedrain = 0
	chargetime = 3
	range = 2
	no_early_release = TRUE
	chargedloop = /datum/looping_sound/invokeholy
	sound = 'sound/misc/letsgogambling.ogg'
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	req_items = list(/obj/item/clothing/neck/roguetown/psycross/silver/xylix)
	charge_max = 2 MINUTES
	miracle = TRUE
	devotion_cost = 35

/obj/effect/proc_holder/spell/invoked/wheel/cast(list/targets, mob/user = usr)
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target.anti_magic_check(TRUE, TRUE))
			to_chat(user, span_warning("Your manipulation of [target]'s fate failed!"))
			return ..()
		target.apply_status_effect(/datum/status_effect/wheel)
		target.blur_eyes(1)
		return ..()
	return FALSE

//Xylix Gambling
/datum/status_effect/wheel
	id = "wheel"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 2 MINUTES //keep same as spell charge cooldown
	alert_type = /atom/movable/screen/alert/status_effect/buff/wheel

/datum/status_effect/wheel/on_apply()
	var/list/mob_stats = MOBSTATS
	mob_stats = mob_stats.Copy() //why do i have to do this
	effectedstats[pick_n_take(mob_stats)] = rand(1,5)
	effectedstats[pick_n_take(mob_stats)] = -rand(1,5)
	if(prob(25)) // Nope!
		if(effectedstats[STATKEY_LCK])
			effectedstats[STATKEY_LCK] += 2
		else
			effectedstats[STATKEY_LCK] = 2
	. = ..()

/atom/movable/screen/alert/status_effect/buff/wheel
	name = "The Wheel"
	desc = "Xylix has spun your fate. You feel disorientated as if you had been rotated.\n"
	icon_state = "acid"
