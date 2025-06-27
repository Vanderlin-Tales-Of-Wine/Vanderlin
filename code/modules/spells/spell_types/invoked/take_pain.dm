/obj/effect/proc_holder/spell/invoked/transfer_pain
	name = "Transfer Pain"
	desc = "Take another's pain upon yourself as an act of mercy."
	invocation_type = "whisper"
	overlay_state = "curse"
	range = 1
	recharge_time = 30 SECONDS

/obj/effect/proc_holder/spell/invoked/transfer_pain/cast(list/targets, mob/user = usr)
	var/mob/living/carbon/human/H = user
	if(!istype(H))
		return

	var/mob/living/carbon/human/target = targets[1]
	if(!istype(target))
		to_chat(H, span_warning("You must target a valid person!"))
		return

	if(target == H)
		to_chat(H, span_warning("You cannot transfer pain to yourself!"))
		return

	if(H.stat != CONSCIOUS)
		to_chat(H, span_warning("You must be conscious to perform this act!"))
		return

	if(target.stat == DEAD)
		to_chat(H, span_warning("[target] is beyond your help!"))
		return

	H.visible_message(span_notice("[H] begins a solemn prayer to Pestra."), \
					span_notice("You begin the pain transfer ritual to Pestra..."))

	if(!do_after(H, 5 SECONDS, target = target))
		to_chat(H, span_warning("The ritual was interrupted!"))
		return

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
		to_chat(H, span_warning("[target] is not in enough pain to transfer!"))
		return

	var/pain_percentage = 0
	if(H.get_complex_pain() > 0)
		pain_percentage = (total_pain_to_transfer / H.get_complex_pain()) * 100
	else
		pain_percentage = 100

	var/pain_per_wound = total_pain_to_transfer / max(1, H.bodyparts.len)
	for(var/obj/item/bodypart/BP in H.bodyparts)
		if(prob(30))
			continue

		var/datum/wound/existing_wound
		for(var/datum/wound/W in BP.wounds)
			if(W.woundpain > 0)
				existing_wound = W
				break

		if(existing_wound)
			existing_wound.woundpain += pain_per_wound
		else
			var/datum/wound/new_wound = new /datum/wound()
			new_wound.woundpain = pain_per_wound
			new_wound.sewn_woundpain = 0
			new_wound.name = "transferred agony"
			new_wound.can_sew = FALSE
			new_wound.can_cauterize = FALSE
			new_wound.passive_healing = 1
			new_wound.apply_to_bodypart(BP)

	playsound(get_turf(H), 'sound/magic/heal.ogg', 50, TRUE)
	to_chat(H, span_notice("You take [round(pain_percentage)]% of [target]'s pain upon yourself!"))
	to_chat(target, span_notice("You feel [H] take some of your pain away!"))
	SEND_SIGNAL(user, COMSIG_PAIN_TRANSFERRED, pain_percentage)
	return ..()
