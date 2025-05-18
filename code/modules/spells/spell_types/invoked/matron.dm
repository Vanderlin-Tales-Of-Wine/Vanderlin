/obj/effect/proc_holder/spell/targeted/seek_orphan
	name = "Brat Detector"
	overlay_state = "recruit_acolyte"
	recharge_time = 10 SECONDS
	max_targets = 0
	cast_without_targets = TRUE


/obj/effect/proc_holder/spell/targeted/seek_orphan/cast(list/targets, mob/user = usr)
	. = ..()
	var/list/orphans = list()
	for(var/mob/living/carbon/human/H in GLOB.human_list)
		if(!H.mind)
			continue
		if(!HAS_TRAIT(H, TRAIT_ORPHAN))
			continue
		orphans += H

	if(!length(orphans))
		to_chat(user, span_red("..There isn't any"))
		return

	var/mob/living/carbon/human/tracked_orphan = browser_input_list(user, "Which One?", "Seek Orphan", orphans)
	if(!tracked_orphan)
		to_chat(user, span_warning("I can't find any of those brats.."))
		return

	var/message = where_orphan(user, tracked_orphan)
	to_chat(user, span_blue("That brat is [message]."))

/obj/effect/proc_holder/spell/targeted/seek_orphan/proc/where_orphan(mob/user, mob/living/carbon/human/tracked_orphan)
	var/turf/our_turf = get_turf(user)
	var/turf/their_turf = get_turf(tracked_orphan)
	var/our_z = our_turf?.z
	var/their_z = their_turf?.z
	var/dist = get_dist(our_turf, their_turf)
	var/dir = get_dir(our_turf, their_turf)
	var/dir_text = dir2text(dir)
	var/distance_text

	switch(dist)
		if(0 to 7)
			distance_text = "very close"
		if(8 to 15)
			distance_text = "close"
		if(16 to 35)
			distance_text = "near"
		if(36 to 49)
			distance_text = "somewhat near"
		if(50 to 70)
			distance_text = "slightly far"
		if(71 to 98)
			distance_text = "somewhat far"
		if(99 to 127)
			distance_text = "far"
		else
			distance_text = "very far"

	if(our_z != their_z)
		var/z_text = our_z > their_z ? "below me" : "above me"
		return "[distance_text]...and to the [dir_text], [z_text]"

	return "[distance_text]...and to the [dir_text]"

/obj/effect/proc_holder/spell/self/hag_call
	name = "Hag's Call"
	recharge_time = 1 MINUTES
	warnie = "spellwarning"
	overlay_state = "message"

/obj/effect/proc_holder/spell/self/hag_call/cast(list/targets, mob/user)
	var/input = browser_input_text(user, "Which one of those brats am I trying to call?", "Hag's Call")
	if(!input)
		return FALSE
	if(!user.mind)
		to_chat(user, span_warning("I do not think i'll be able to call for them.."))
		return FALSE
	for(var/mob/living/carbon/human/HL in GLOB.human_list)
		if(HL.real_name == input && HL.mind)
			if(HAS_TRAIT(HL, TRAIT_ORPHAN) || HAS_TRAIT(HL, TRAIT_OLDPARTY))
				to_chat(HL, span_reallybig("[HL.real_name]!"))
				HL.visible_message(span_notice("Someone is calling for me!"))
				user.say("[HL.real_name]!!", spans = list("reallybig"))
				if(HAS_TRAIT(HL, TRAIT_ORPHAN))
					HL.add_stress(/datum/stressevent/mother_calling)
				else
					HL.add_stress(/datum/stressevent/friend_calling)
				return ..()
	to_chat(user, span_warning("What am I saying, That isn't one of the brats under my care?"))
	return FALSE
