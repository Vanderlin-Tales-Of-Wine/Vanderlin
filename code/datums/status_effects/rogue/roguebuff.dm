/datum/status_effect/buff
	status_type = STATUS_EFFECT_REFRESH


/datum/status_effect/buff/drunk
	id = "drunk"
	alert_type = /atom/movable/screen/alert/status_effect/buff/drunk
	effectedstats = list(STATKEY_INT = -1, STATKEY_SPD = -1, STATKEY_CON = 1)
	duration = 12 MINUTES

/atom/movable/screen/alert/status_effect/buff/drunk
	name = "Drunk"
	desc = span_nicegreen("I feel very drunk.")
	icon_state = "drunk"

/datum/status_effect/buff/drunk/on_apply()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_stress(/datum/stressevent/drunk)
/datum/status_effect/buff/drunk/on_remove()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.remove_stress(/datum/stressevent/drunk)

/datum/status_effect/buff/foodbuff
	id = "foodbuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/foodbuff
	effectedstats = list("constitution" = 1,"endurance" = 1)
	duration = 15 MINUTES

/atom/movable/screen/alert/status_effect/buff/foodbuff
	name = "Great Meal"
	desc = span_nicegreen("That was a good meal!")
	icon_state = "foodbuff"

/datum/status_effect/buff/foodbuff/on_apply()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_stress(/datum/stressevent/goodfood)

//============= CLEAN PLUS ===============
/datum/status_effect/buff/clean_plus
	id = "cleanplus"
	alert_type = /atom/movable/screen/alert/status_effect/buff/clean_plus
	effectedstats = list("fortune" = 1)
	duration = 20 MINUTES

/datum/status_effect/buff/clean_plus/on_apply()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_stress(/datum/stressevent/clean_plus)

/atom/movable/screen/alert/status_effect/buff/clean_plus
	name = "Clean"
	desc = span_nicegreen("I feel very refreshed.")
	icon_state = "buff"	// add custom icon TO DO


/datum/status_effect/buff/druqks
	id = "druqks"
	alert_type = /atom/movable/screen/alert/status_effect/buff/druqks
	effectedstats = list("intelligence" = 4,"speed" = 2,"fortune" = -5)
	duration = 2 MINUTES

/datum/status_effect/buff/druqks/on_apply()
	. = ..()
	if(owner?.client)
		if(owner.client.screen && owner.client.screen.len)
			var/atom/movable/screen/plane_master/game_world/PM = locate(/atom/movable/screen/plane_master/game_world) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_fov_hidden) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_above) in owner.client.screen
			PM.backdrop(owner)
			var/mob/living/carbon/C = owner
			C.add_stress(/datum/stressevent/high)


/datum/status_effect/buff/druqks/on_remove()
	. = ..()
	if(owner?.client)
		if(owner.client.screen && owner.client.screen.len)
			var/atom/movable/screen/plane_master/game_world/PM = locate(/atom/movable/screen/plane_master/game_world) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_fov_hidden) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_above) in owner.client.screen
			PM.backdrop(owner)
			var/mob/living/carbon/C = owner
			C.remove_stress(/datum/stressevent/high)

/atom/movable/screen/alert/status_effect/buff/druqks
	name = "High"
	desc = span_nicegreen("Holy shit, I am tripping balls!")
	icon_state = "acid"

/datum/status_effect/buff/ozium
	id = "ozium"
	alert_type = /atom/movable/screen/alert/status_effect/buff/druqks
	effectedstats = list("speed" = -4, "perception" = 2)
	duration = 2 MINUTES

/datum/status_effect/buff/ozium/on_apply()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_stress(/datum/stressevent/ozium)
	ADD_TRAIT(owner, TRAIT_NOPAIN, TRAIT_GENERIC)

/datum/status_effect/buff/ozium/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_NOPAIN, TRAIT_GENERIC)
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.remove_stress(/datum/stressevent/ozium)

/datum/status_effect/buff/moondust
	id = "moondust"
	alert_type = /atom/movable/screen/alert/status_effect/buff/druqks
	effectedstats = list("speed" = 2, "endurance" = 2, "intelligence" = -4)
	duration = 1 MINUTES

/datum/status_effect/buff/moondust/nextmove_modifier()
	return 0.5

/datum/status_effect/buff/moondust/on_apply()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_stress(/datum/stressevent/moondust)

/datum/status_effect/buff/moondust/on_remove()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.remove_stress(/datum/stressevent/moondust)

/datum/status_effect/buff/moondust_purest
	id = "purest moondust"
	alert_type = /atom/movable/screen/alert/status_effect/buff/druqks
	effectedstats = list("speed" = 4, "endurance" = 4, "intelligence" = -2)
	duration = 2 MINUTES

/datum/status_effect/buff/moondust_purest/nextmove_modifier()
	return 0.5

/datum/status_effect/buff/moondust_purest/on_apply()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_stress(/datum/stressevent/moondust_purest)

/datum/status_effect/buff/moondust_purest/on_remove()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.remove_stress(/datum/stressevent/moondust_purest)


/datum/status_effect/buff/weed
	id = "weed"
	alert_type = /atom/movable/screen/alert/status_effect/buff/weed
	effectedstats = list("intelligence" = 2,"speed" = -2,"fortune" = 2)
	duration = 5 MINUTES

/datum/status_effect/buff/weed/on_apply()
	. = ..()
	if(owner?.client)
		if(owner.client.screen && owner.client.screen.len)
			var/atom/movable/screen/plane_master/game_world/PM = locate(/atom/movable/screen/plane_master/game_world) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_fov_hidden) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_above) in owner.client.screen
			PM.backdrop(owner)
			var/mob/living/carbon/C = owner
			C.add_stress(/datum/stressevent/weed)

/datum/status_effect/buff/weed/on_remove()
	. = ..()
	if(owner?.client)
		if(owner.client.screen && owner.client.screen.len)
			var/atom/movable/screen/plane_master/game_world/PM = locate(/atom/movable/screen/plane_master/game_world) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_fov_hidden) in owner.client.screen
			PM.backdrop(owner)
			PM = locate(/atom/movable/screen/plane_master/game_world_above) in owner.client.screen
			PM.backdrop(owner)
			var/mob/living/carbon/C = owner
			C.remove_stress(/datum/stressevent/weed)

/atom/movable/screen/alert/status_effect/buff/weed
	name = "Dazed"
	desc = span_nicegreen("I am so high maaaaaaaaan.")
	icon_state = "weed"

/atom/movable/screen/alert/status_effect/buff/featherfall
	name = "Featherfall"
	desc = "I am somewhat protected against falling from heights."
	icon_state = "buff"

/datum/status_effect/buff/featherfall
	id = "featherfall"
	alert_type = /atom/movable/screen/alert/status_effect/buff/featherfall
	duration = 1 MINUTES

/datum/status_effect/buff/featherfall/on_apply()
	. = ..()
	to_chat(owner, span_warning("I feel lighter."))
	ADD_TRAIT(owner, TRAIT_NOFALLDAMAGE1, MAGIC_TRAIT)

/datum/status_effect/buff/featherfall/on_remove()
	. = ..()
	to_chat(owner, span_warning("The feeling of lightness fades."))
	REMOVE_TRAIT(owner, TRAIT_NOFALLDAMAGE1, MAGIC_TRAIT)

/datum/status_effect/buff/darkvision
	id = "darkvision"
	alert_type = /atom/movable/screen/alert/status_effect/buff/darkvision
	duration = 10 MINUTES

/atom/movable/screen/alert/status_effect/buff/darkvision
	name = "Darkvision"
	desc = span_nicegreen("I can see in the dark.")
	icon_state = "buff"

/datum/status_effect/buff/darkvision/on_apply()
	. = ..()
	var/mob/living/carbon/human/H = owner
	var/obj/item/organ/eyes/eyes = H.getorgan(/obj/item/organ/eyes)
	if (!eyes || eyes.lighting_alpha)
		return
	ADD_TRAIT(owner, TRAIT_DARKVISION, MAGIC_TRAIT)
	owner.update_sight()

/datum/status_effect/buff/darkvision/on_remove()
	. = ..()
	to_chat(owner, span_warning("Darkness shrouds your senses once more."))
	REMOVE_TRAIT(owner, TRAIT_DARKVISION, MAGIC_TRAIT)
	owner.update_sight()

/atom/movable/screen/alert/status_effect/buff/haste
	name = "Haste"
	desc = "I am magically hastened."
	icon_state = "buff"

/datum/status_effect/buff/haste
	id = "haste"
	alert_type = /atom/movable/screen/alert/status_effect/buff/haste
	effectedstats = list("speed" = 3)
	duration = 1 MINUTES

/datum/status_effect/buff/calm
	id = "calm"
	alert_type = /atom/movable/screen/alert/status_effect/buff/calm
	effectedstats = list("fortune" = 1)
	duration = 240 MINUTES

/atom/movable/screen/alert/status_effect/buff/calm
	name = "Calmness"
	desc = span_nicegreen("I feel a supernatural calm coming over me.")
	icon_state = "stressg"

/datum/status_effect/buff/calm/on_apply()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_stress(/datum/stressevent/calm)

/datum/status_effect/buff/calm/on_remove()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.remove_stress(/datum/stressevent/calm)



/datum/status_effect/buff/barbrage
	id = "barbrage"
	alert_type = /atom/movable/screen/alert/status_effect/buff/barbrage
	effectedstats = list("strength" = 1, "endurance" = 2, "perception" = -2, "intelligence" = -2) //endurance to boost pain treshold, not powerful enough to warrant total painkilling
	duration = 15 SECONDS

/atom/movable/screen/alert/status_effect/buff/barbrage
	name = "Barbaric Rage"
	desc = span_nicegreen("WITNESS ME!")
	icon_state = "ravox"

/datum/status_effect/buff/barbrage/on_remove()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.apply_status_effect(/datum/status_effect/debuff/barbfalter)



//============================================================================
/*--------------\
|				|
| Divine Buffs	|
|		 	 	|
\---------------*/

// ---------------------- DIVINE KNOWLEDGE ( NOC ) ----------------------------
/datum/status_effect/buff/noc
	id = "nocbuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/nocbuff
	effectedstats = list("intelligence" = 3)
	duration = 240 MINUTES

/atom/movable/screen/alert/status_effect/buff/nocbuff
	name = "Divine Knowledge"
	desc = span_nicegreen("Divine knowledge flows through me.")
	icon_state = "intelligence"



// ---------------------- DIVINE POWER ( RAVOX ) ----------------------------
/datum/status_effect/buff/ravox
	id = "ravoxbuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/ravoxbuff
	effectedstats = list("constitution" = 1,"endurance" = 1,"strength" = 1)
	duration = 240 MINUTES

/atom/movable/screen/alert/status_effect/buff/ravoxbuff
	name = "Divine Power"
	desc = span_nicegreen("Divine power flows through me.")
	icon_state = "ravox"


/*-----------------\
|  Dendor Miracles |
\-----------------*/

// ---------------------- EYES OF THE BEAST ( DENDOR ) ----------------------------
/datum/status_effect/buff/beastsense
	id = "beastsense"
	alert_type = /atom/movable/screen/alert/status_effect/buff/beastsense
	duration = 10 MINUTES

/atom/movable/screen/alert/status_effect/buff/beastsense
	name = "Bestial Senses"
	desc = span_nicegreen("No scent too faint, no shadow too dark...")
	icon_state = "bestialsense"

/datum/status_effect/buff/beastsense/on_apply()
	. = ..()
	var/mob/living/carbon/human/H = owner
	var/obj/item/organ/eyes/eyes = H.getorgan(/obj/item/organ/eyes)
	if (!eyes || eyes.lighting_alpha)
		return
	ADD_TRAIT(owner, TRAIT_BESTIALSENSE, REF(src))
	owner.update_sight()

/datum/status_effect/buff/beastsense/on_remove()
	. = ..()
	to_chat(owner, span_warning("Darkness shrouds your senses once more."))
	REMOVE_TRAIT(owner, TRAIT_BESTIALSENSE, REF(src))
	owner.update_sight()

/datum/status_effect/buff/beastsense_elf
	id = "beastsenself"
	alert_type = /atom/movable/screen/alert/status_effect/buff/beastsenself
	effectedstats = list("perception" = 2)
	duration = 10 MINUTES

/atom/movable/screen/alert/status_effect/buff/beastsenself
	name = "Bestial Sense"
	desc = span_nicegreen("No scent too faint, no shadow too dark...")
	icon_state = "bestialsense"



// ---------------------- TROLL SHAPE ( DENDOR ) ----------------------------
/datum/status_effect/buff/trollshape
	id = "trollshape"
	alert_type = /atom/movable/screen/alert/status_effect/buff/trollshape
	effectedstats = list("strength" = 5, "endurance" = 2, "speed" = -3, "intelligence" = -5)
	duration = 3 MINUTES

/atom/movable/screen/alert/status_effect/buff/trollshape
	name = "Troll Shape"
	desc = span_nicegreen("I AM STRONG! DENDORS ENEMIES WILL DIE!")
	icon_state = "trollshape"
/datum/status_effect/buff/trollshape/on_apply()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/human/C = owner
		C.resize = 1.2
		C.update_transform()
		C.AddComponent(/datum/component/footstep, FOOTSTEP_MOB_HEAVY, 1, 2)

/datum/status_effect/buff/trollshape/on_remove()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/human/C = owner
		C.emote("pain", forced = TRUE)
		playsound(get_turf(C), 'sound/gore/flesh_eat_03.ogg', 100, TRUE)
		to_chat(C, span_warning("Dendors transformation fades, flesh shrinking back. My body aches..."))
		C.adjustBruteLoss(10)
		C.apply_status_effect(/datum/status_effect/debuff/barbfalter)
		C.resize = (1/1.2)
		C.update_transform()
		C.AddComponent(/datum/component/footstep, FOOTSTEP_MOB_HUMAN, 1, 2)


/*-----------------\
|   Eora Miracles  |
\-----------------*/

/datum/status_effect/buff/divine_beauty
	id = "divine_beauty"
	alert_type = /atom/movable/screen/alert/status_effect/buff/divine_beauty
	duration = 5 MINUTES

/datum/status_effect/buff/divine_beauty/on_apply()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_stress(/datum/stressevent/divine_beauty)

/datum/status_effect/buff/divine_beauty/on_remove()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.remove_stress(/datum/stressevent/divine_beauty)

/atom/movable/screen/alert/status_effect/buff/divine_beauty
	name = "Divine Beauty"
	desc = span_nicegreen("Everything about myself feels beautiful!")
	icon_state = "beauty"

/*-----------------\
|   Ravox Miracles |
\-----------------*/

/datum/status_effect/buff/call_to_arms
	id = "call_to_arms"
	alert_type = /atom/movable/screen/alert/status_effect/buff/call_to_arms
	duration = 2.5 MINUTES
	effectedstats = list(STATKEY_STR = 1, STATKEY_END = 2, STATKEY_CON = 2)

/atom/movable/screen/alert/status_effect/buff/call_to_arms
	name = "Call to Arms"
	desc = span_bloody("THE FIGHT WILL BE BLOODY!")
	icon_state = "call_to_arms"

/*-----------------\
|   Malum Miracles |
\-----------------*/

/datum/status_effect/buff/craft_buff
	id = "crafting_buff_malum"
	alert_type = /atom/movable/screen/alert/status_effect/buff/craft_buff
	duration = 2.5 MINUTES
	effectedstats = list(STATKEY_INT = 2)

/atom/movable/screen/alert/status_effect/buff/craft_buff
	name = "Exquisite Craftsmanship"
	desc = span_notice("I am inspired to create!")
	icon_state = "malum_buff"

// BARDIC BUFFS BELOW

/datum/status_effect/bardicbuff
	var/name
	id = "bardbuff"
	tick_interval = 1 SECONDS
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /atom/movable/screen/alert/status_effect/bardbuff
	duration = 50 // Sanity, so that people outside the bard buff listening area lose the buff after a few seconds

/datum/status_effect/bardicbuff/on_apply()
	if(owner.mind?.has_antag_datum(/datum/antagonist)) // Check if antag datum present
		if(owner.mind?.isactuallygood()) // Then check if they're actually a "good" antag (purishep, prisoner)
			for(var/S in effectedstats)
				owner.change_stat(S, effectedstats[S])
			return TRUE
		else // Otherwise, no buff
			return FALSE
	else // All non antags get the buffs
		for(var/S in effectedstats)
			owner.change_stat(S, effectedstats[S])
		return TRUE

// SKELETON BARD BUFF ALERT
/atom/movable/screen/alert/status_effect/bardbuff
	name = "Musical buff"
	desc = "My stats have been buffed by music!"
	icon_state = "intelligence"

// TIER 1 - WEAK
/datum/status_effect/bardicbuff/intelligence
	name = "Enlightening (+1 INT)"
	id = "bardbuff_int"
	effectedstats = list("intelligence" = 1)

// TIER 2 - AVERAGE
/datum/status_effect/bardicbuff/endurance
	name = "Invigorating (+1 END)"
	id = "bardbuff_end"
	effectedstats = list("endurance" = 1)

// TIER 3 - SKILLED
/datum/status_effect/bardicbuff/constitution
	name = "Fortitude (+1 CON)"
	id = "bardbuff_con"
	effectedstats = list("constitution" = 1)

// TIER 4 - EXPERT
/datum/status_effect/bardicbuff/speed
	name = "Inspiring (+1 SPD)"
	id = "bardbuff_spd"
	effectedstats = list("speed" = 1)

// TIER 5 - MASTER
/datum/status_effect/bardicbuff/ravox
	name = "Empowering (+1 STR, +1 PER)"
	id = "bardbuff_str"
	effectedstats = list("strength" = 1, "perception" = 1)

// TIER 6 - LEGENDARY
/datum/status_effect/bardicbuff/awaken
	name = "Awaken! (purges sleep)"
	id = "bardbuff_awaken"
	effectedstats = list("fortune" = 1)

/datum/status_effect/bardicbuff/awaken/on_apply()
	if(iscarbon(owner))
		var/mob/living/carbon/O = owner
		if(owner.mind?.has_antag_datum(/datum/antagonist))
			if(owner.mind.isactuallygood()) // Check for "good antags"
				for(var/S in effectedstats)
					owner.change_stat(S, effectedstats[S])
				if(O.has_status_effect(/datum/status_effect/debuff/sleepytime))
					O.remove_status_effect(/datum/status_effect/debuff/sleepytime)
					O.tiredness = 0
					if(O.IsSleeping())
						O.SetSleeping(0) // WAKE UP!
					O.adjust_triumphs(1) // Before people start crying about muh triumph lost
					to_chat(O, span_nicegreen("Astrata's blessed light cleanses away your tiredness!"))
			else
				return
		else
			for(var/S in effectedstats)
				owner.change_stat(S, effectedstats[S])
			if(O.has_status_effect(/datum/status_effect/debuff/sleepytime))
				O.remove_status_effect(/datum/status_effect/debuff/sleepytime)
				O.tiredness = 0
				if(O.IsSleeping())
					O.SetSleeping(0) // GRAB A BRUSH AND PUT A LITTLE MAKEUP
				O.adjust_triumphs(1) // Before people start crying about muh triumph lost
				to_chat(O, span_nicegreen("Astrata's blessed light cleanses away your tiredness!"))
			else
				return
