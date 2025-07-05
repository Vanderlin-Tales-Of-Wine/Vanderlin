/obj/effect/proc_holder/spell/invoked/transfer_pain
	name = "Take Pain"
	invocation_type = "whisper"
	overlay_state = "curse"
	uses_mana = FALSE
	range = 1
	recharge_time = 1 MINUTES

/obj/effect/proc_holder/spell/invoked/transfer_pain/cast(list/targets, mob/user = usr)
	var/mob/living/carbon/human/H = user
	if(!istype(H))
		return FALSE

	var/mob/living/carbon/human/target = targets[1]
	if(!istype(target))
		to_chat(H, span_warning("You must target a valid person!"))
		return FALSE

	if(target == H)
		to_chat(H, span_warning("You target yourself!"))
		return FALSE

	if(H.stat != CONSCIOUS)
		to_chat(H, span_warning("You must be conscious to perform this act!"))
		return FALSE

	if(target.stat == DEAD)
		to_chat(H, span_warning("[target] is beyond your help!"))
		return FALSE

	H.visible_message(span_notice("[H] begins a solemn prayer to Pestra."), \
					span_notice("You begin the pain transfer ritual..."))

	if(!do_after(H, 5 SECONDS, target = target))
		to_chat(H, span_warning("The ritual was interrupted!"))
		return FALSE

	var/total_pain_to_transfer = 0
	var/list/affected_wounds = list()

	for(var/obj/item/bodypart/BP in target.bodyparts)
		for(var/datum/wound/W in BP.wounds)
			if(W.woundpain <= W.sewn_woundpain)
				continue
			var/pain_reduction = W.woundpain * 0.5
			total_pain_to_transfer += pain_reduction
			W.woundpain = max(W.sewn_woundpain, W.woundpain - pain_reduction)
			affected_wounds += W

	for(var/datum/wound/W in target.simple_wounds)
		if(W.woundpain <= W.sewn_woundpain)
			continue
		var/pain_reduction = W.woundpain * 0.5
		total_pain_to_transfer += pain_reduction
		W.woundpain = max(W.sewn_woundpain, W.woundpain - pain_reduction)
		affected_wounds += W

	if(total_pain_to_transfer <= 0)
		to_chat(H, span_warning("[target] is not in pain!"))
		return FALSE

	var/pain_percentage = 0
	if(H.get_complex_pain() > 0)
		pain_percentage = (total_pain_to_transfer / H.get_complex_pain()) * 100
	else
		pain_percentage = 100

	var/wound_severity_mod = clamp(pain_percentage / 50, 0.5, 3.0)

	var/pain_per_wound = total_pain_to_transfer / max(1, H.bodyparts.len)
	for(var/obj/item/bodypart/BP in H.bodyparts)
		var/datum/wound/existing_wound
		for(var/datum/wound/W in BP.wounds)
			if(W.woundpain > 0)
				existing_wound = W
				break

		if(existing_wound)
			existing_wound.woundpain += (pain_per_wound * wound_severity_mod) * 3
			existing_wound.whp += ((pain_per_wound / 2) * wound_severity_mod) * 2
			if(existing_wound.severity < WOUND_SEVERITY_CRITICAL && wound_severity_mod > 1.5)
				existing_wound.severity = WOUND_SEVERITY_CRITICAL
		else
			var/datum/wound/new_wound = new /datum/wound()
			new_wound.woundpain = (pain_per_wound * wound_severity_mod) * 3
			new_wound.whp += ((pain_per_wound / 2) * wound_severity_mod) * 2
			new_wound.sewn_woundpain = 0
			new_wound.severity = WOUND_SEVERITY_SEVERE
			new_wound.can_sew = FALSE
			new_wound.can_cauterize = FALSE
			new_wound.passive_healing = max(1, 3 - wound_severity_mod)

			if(wound_severity_mod > 2.0)
				new_wound.name = "transferred agony"
			else if(wound_severity_mod > 1.0)
				new_wound.name = "transferred serious pain"
			else
				new_wound.name = "transferred pain"

			new_wound.apply_to_bodypart(BP)

	playsound(get_turf(H), 'sound/magic/heal.ogg', 50, TRUE)
	to_chat(H, span_notice("You take [target]'s pain upon yourself!"))
	to_chat(target, span_notice("You feel [H] take some of your pain away!"))
	SEND_SIGNAL(user, COMSIG_PAIN_TRANSFERRED, pain_percentage)
	return ..()
