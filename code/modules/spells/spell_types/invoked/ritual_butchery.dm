/obj/effect/proc_holder/spell/invoked/extract_heart
	name = "Heart Extraction"
	desc = "An unholy rite to claim hearts as a tribute to Graggar. Only works on fresh corpses."
	overlay_state = "curse"
	chargedrain = 0
	chargetime = 0
	range = 1
	movement_interrupt = TRUE
	invocation_type = "none"
	associated_skill = /datum/skill/labor/butchering
	miracle = FALSE
	devotion_cost = 0
	uses_mana = FALSE
	healing_miracle = FALSE
	sound = 'sound/surgery/organ1.ogg'
	/// Base time, reduced by butchery skill
	var/extraction_time = 15 SECONDS

/obj/effect/proc_holder/spell/invoked/extract_heart/cast(list/targets, mob/living/user)
	var/mob/living/carbon/human/target = targets[1]

	if(!istype(target))
		to_chat(user, "<span class='warning'>Only proper flesh is worthy of Graggar's attention!</span>")
		return FALSE

	if(target.stat != DEAD)
		to_chat(user, "<span class='warning'>The weakling still pulses with life! Graggar demands you finish them properly first!</span>")
		return FALSE

	// Calculate actual time based on butchery skill
	var/skill_modifier = 1 - (user.mind?.get_skill_level(/datum/skill/labor/butchering) * 0.1) // 10% reduction per skill level
	var/actual_time = max(extraction_time * skill_modifier, 7.5 SECONDS) // Minimum 7.5 seconds

	user.visible_message("<span class='warning'>[user] reaches for [target]'s chest, chanting incoherently...</span>", \
						"<span class='notice'>You begin the ritual extraction of [target]'s heart.</span>")

	if(!do_after(user, actual_time, target = target))
		to_chat(user, "<span class='warning'>The profane ritual was interrupted! SHAME!</span>")
		return FALSE

	if(target.stat != DEAD)
		to_chat(user, "<span class='warning'>The weakling still pulses with life! Graggar demands you finish them properly first!</span>")
		return FALSE

	var/obj/item/organ/heart/heart = target.getorganslot(ORGAN_SLOT_HEART)
	if(!heart)
		to_chat(user, "<span class='warning'>Only a hollow chest remains!</span>")
		return FALSE

	heart.Remove(target)
	heart.forceMove(target.drop_location())
	user.put_in_hands(heart)

	target.add_splatter_floor()
	target.adjustBruteLoss(20)

	user.visible_message("<span class='warning'>[user] rips [target]'s heart out with a roar!</span>", \
						"<span class='red'>You present the heart to Graggar! The God chuckles upon this offering.</span>")
	user.emote("rage", forced = TRUE)

	return TRUE
