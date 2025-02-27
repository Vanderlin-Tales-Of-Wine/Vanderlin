/datum/reagent/drug
	name = "Drug"
	metabolization_rate = 0.1
	taste_description = "bitterness"
	var/trippy = TRUE //Does this drug make you trip?

/datum/reagent/drug/on_mob_end_metabolize(mob/living/M)
	if(trippy)
		SEND_SIGNAL(M, COMSIG_CLEAR_MOOD_EVENT, "[type]_high")

/datum/reagent/drug/space_drugs
	name = "Space drugs"
	description = "An illegal chemical compound used as drug."
	color = "#60A584" // rgb: 96, 165, 132
	overdose_threshold = 30

/datum/reagent/drug/space_drugs/on_mob_life(mob/living/carbon/M)
	M.set_drugginess(30)
	if(prob(5))
		if(M.gender == FEMALE)
			M.emote(pick("twitch_s","giggle"))
		else
			M.emote(pick("twitch_s","chuckle"))
	if(M.has_flaw(/datum/charflaw/addiction/smoker))
		M.sate_addiction()
	..()

/datum/reagent/drug/space_drugs/on_mob_metabolize(mob/living/M)
	..()
	M.set_drugginess(30)
	M.apply_status_effect(/datum/status_effect/buff/weed)
	M.overlay_fullscreen("weedsm", /atom/movable/screen/fullscreen/weedsm)
	M.update_body_parts_head_only()

/*
	if(M.client)
		SSdroning.area_entered(get_area(M), M.client)
*/

/datum/reagent/drug/space_drugs/on_mob_end_metabolize(mob/living/M)
	M.set_drugginess(0)
	M.clear_fullscreen("weedsm")
	M.remove_status_effect(/datum/status_effect/buff/weed)
	M.update_body_parts_head_only()

/*
	if(M.client)
		SSdroning.play_area_sound(get_area(M), M.client)
*/

/atom/movable/screen/fullscreen/weedsm
	icon_state = "smok"
	plane = BLACKNESS_PLANE
	layer = AREA_LAYER
	blend_mode = 0
	alpha = 100
	show_when_dead = FALSE

/atom/movable/screen/fullscreen/weedsm/Initialize()
	. = ..()
//			if(L.has_status_effect(/datum/status_effect/buff/weed))
	filters += filter(type="angular_blur",x=5,y=5,size=1)

/datum/reagent/drug/space_drugs/overdose_start(mob/living/M)
	to_chat(M, "<span class='danger'>I start tripping hard!</span>")
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "[type]_overdose", /datum/mood_event/overdose, name)

/datum/reagent/drug/space_drugs/overdose_process(mob/living/M)
	M.adjustToxLoss(0.1*REM, 0)
	M.adjustOxyLoss(1.1*REM, 0)
	..()

/datum/reagent/drug/nicotine
	name = "Nicotine"
	description = "Slightly reduces stun times. If overdosed it will deal toxin and oxygen damage."
	reagent_state = LIQUID
	color = "#60A584" // rgb: 96, 165, 132
	addiction_threshold = 999
	taste_description = "smoke"
	trippy = FALSE
	overdose_threshold=999
	metabolization_rate = 0.1 * REAGENTS_METABOLISM


/datum/reagent/drug/nicotine/on_mob_end_metabolize(mob/living/M)
//	M.remove_stress(/datum/stressevent/pweed)
	..()

/datum/reagent/drug/nicotine/on_mob_metabolize(mob/living/M)
	var/mob/living/carbon/V = M
	V.add_stress(/datum/stressevent/pweed)
	..()

/datum/reagent/drug/nicotine/on_mob_life(mob/living/carbon/M)
	if(M.has_flaw(/datum/charflaw/addiction/smoker))
		M.sate_addiction()
	..()
	. = 1

/datum/reagent/drug/nicotine/overdose_process(mob/living/M)
	M.adjustToxLoss(0.1*REM, 0)
	M.adjustOxyLoss(1.1*REM, 0)
	..()
	. = 1
