/datum/advclass
	var/name
	var/outfit
	var/tutorial = "Choose me!"
	var/list/allowed_sexes
	var/list/allowed_races = list(
	"Humen",
	"Rakshari",
	"Elf",
	"Half-Elf",
	"Dwarf",
	"Tiefling",
	"Dark Elf",
	"Aasimar",
	"Half-Orc"
	)
	var/list/allowed_patrons
	var/list/allowed_ages
	var/pickprob = 100
	var/maximum_possible_slots = 999
	var/total_slots_occupied = 0
	var/min_pq = -100
	var/cmode_music

	var/horse = FALSE
	var/vampcompat = TRUE

	/// This class is immune to species-based swapped gender locks
	var/immune_to_genderswap = FALSE

	//What categories we are going to sort it in
	var/list/category_tags = list(CTAG_DISABLED)
	var/displays_adv_job = TRUE
	var/apprentice_name //Must be set to give apprentices the correct title. Note that pilgrims cannot have apprentices.

/datum/advclass/proc/equipme(mob/living/carbon/human/H)
	// input sleeps....
	set waitfor = FALSE
	if(!H)
		return FALSE

	if(outfit)
		H.equipOutfit(outfit)

	if(displays_adv_job)
		H.advjob = "Adventurer"
		if(name)
			H.advjob = name

	var/turf/TU = get_turf(H)
	if(TU)
		if(horse)
			new horse(TU)
	H.mind?.apprentice_name = apprentice_name

/*	for(var/trait in traits_applied)
		ADD_TRAIT(H, trait, ADVENTURER_TRAIT) */

	if(CTAG_TOWNER in category_tags)
		for(var/mob/M in GLOB.billagerspawns)
			to_chat(M, "<span class='info'>[H.real_name] is the [name].</span>")
		GLOB.billagerspawns -= H

	// Remove the stun first, then grant us the torch.
	for(var/datum/status_effect/incapacitating/stun/S in H.status_effects)
		H.remove_status_effect(S)

	post_equip(H)

/datum/advclass/proc/post_equip(mob/living/carbon/human/H)
	addtimer(CALLBACK(H,TYPE_PROC_REF(/mob/living/carbon/human, add_credit)), 20)
	if(cmode_music)
		H.cmode_music = cmode_music
	sleep(5)
	var/obj/item/flashlight/flare/torch/T = new()
	T.spark_act()
	H.put_in_hands(T, forced = TRUE)

/*
	Whoa! we are checking requirements here!
	On the datum! Wow!
*/
/datum/advclass/proc/check_requirements(mob/living/carbon/human/H)

	var/list/local_allowed_sexes = list()
	if(length(allowed_sexes))
		local_allowed_sexes |= allowed_sexes

	if(length(local_allowed_sexes) && !(H.gender in local_allowed_sexes))
		return FALSE

	if(length(allowed_races) && !(H.dna.species.name in allowed_races))
		if(!(H.client.triumph_ids.Find("race_all")))
			return FALSE

	if(length(allowed_ages) && !(H.age in allowed_ages))
		return FALSE

	if(maximum_possible_slots > -1)
		if(total_slots_occupied >= maximum_possible_slots)
			return FALSE

	if(min_pq != -100) // If someone sets this we actually do the check.
		if(!(get_playerquality(H.client.ckey) >= min_pq))
			return FALSE

	var/pq_prob = pickprob + max((get_playerquality(H.client.ckey))/2, 0) // Takes the base pick rate of the rare class and adds the client's pq divided by 2 or 0, whichever is higher. Allows a maximum of 65 pick probability at 100 pq
	if(prob(pq_prob))
		return TRUE

// Basically the handler has a chance to plus up a class, heres a generic proc you can override to handle behavior related to it.
// For now you just get an extra stat in everything depending on how many plusses you managed to get.
/datum/advclass/proc/boost_by_plus_power(plus_factor, mob/living/carbon/human/H)
	for(var/S in MOBSTATS)
		H.change_stat(S, plus_factor)


//Final proc in the set for really dumb shit
///datum/advclass/proc/extra_slop_proc_ending(mob/living/carbon/human/H)
