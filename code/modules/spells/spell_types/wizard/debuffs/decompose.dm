/obj/effect/proc_holder/spell/invoked/decompose5e
	name = "Decompose"
	desc = "Instantly rots the target, if humanoid creates a deadite."
	overlay_state = "null"
	releasedrain = 50
	chargetime = 5
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
	associated_skill = /datum/skill/magic/blood //can be arcane, druidic, blood, holy
	cost = 1


	miracle = FALSE

	invocation = "Return to rot."
	invocation_type = "whisper"
	attunements = list(
		/datum/attunement/death = 0.3,
	)

/obj/effect/proc_holder/spell/invoked/decompose5e/cast(list/targets, mob/living/user)
	if(!isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target == user)
			return FALSE
		var/has_rot = FALSE
		if(iscarbon(target))
			var/mob/living/carbon/stinky = target
			for(var/obj/item/bodypart/bodypart as anything in stinky.bodyparts)
				if(bodypart.rotted || bodypart.skeletonized)
					has_rot = TRUE
					break
		if(has_rot)
			to_chat(user, span_warning("Already rotted."))
			return FALSE
		//do some sounds and effects or something (flies?)
		if(target.mind)
			target.mind.add_antag_datum(/datum/antagonist/zombie)
		target.Unconscious(20 SECONDS)
		target.emote("breathgasp")
		target.Jitter(100)
		var/datum/component/rot/rot = target.GetComponent(/datum/component/rot)
		if(rot)
			rot.amount = 100
		if(iscarbon(target))
			var/mob/living/carbon/stinky = target
			for(var/obj/item/bodypart/rotty in stinky.bodyparts)
				rotty.rotted = TRUE
				rotty.update_limb()
				if(rotty.can_be_disabled)
					rotty.update_disabled()
		target.update_body()
		if(HAS_TRAIT(target, TRAIT_ROTMAN))
			target.visible_message(span_notice("[target]'s body rots!"), span_green("I feel rotten!"))
		else
			target.visible_message(span_warning("[target]'s body fails to rot!"), span_warning("I feel no different..."))
		return TRUE
	return FALSE
