/mob/living/carbon/human/species/abyssariad
	race = /datum/species/abyssariad

/datum/species/abyssariad
	name = "foglander"
	id = "abyssariad"
	max_age = 1250 //The year Abyssariads have been created by Abyssor.
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP | SLIME_EXTRACT

/datum/species/abyssariad/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	C.grant_language(/datum/language/common)
	C.grant_language(/datum/language/abyssal)



///mob/proc/banzai() //Don't have female 'Banzai' yells for that.
//	set name = "Banzai"
//	set category = "Noises"
//	emote("banzai")

/mob/proc/yoo()
	set name = "Yoo"
	set category = "Noises"
	emote("yoo")

/mob/proc/throatsing()
	set name = "Throatsing"
	set category = "Noises"
	emote("throatsing")

/mob/proc/birdcall()
	set name = "Birdcall"
	set category = "Noises"
	emote("birdcall")

/datum/species/abyssariad/check_roundstart_eligible()
	return FALSE

/datum/species/abyssariad/after_creation(mob/living/carbon/C)
	..()
//	if(!C.has_language(/datum/language/abyssal))
	C.grant_language(/datum/language/abyssal)
	to_chat(C, "<span class='info'>I can speak Abyssal with ,a before my speech.</span>")

/datum/species/abyssariad/on_species_loss(mob/living/carbon/C)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_SAY)
	C.remove_language(/datum/language/abyssal)

/datum/species/abyssariad/qualifies_for_rank(rank, list/features)
	return TRUE

/datum/species/abyssariad/get_skin_list()
	return sortList(list(
	"skin1" = "ffe0d1",
	"skin2" = "fcccb3"
	))


/datum/species/abyssariad/get_hairc_list()
	return sortList(list(
	"black - nightsky" = "0a0707",
	"brown - treebark" = "362e25",
	"blonde - moonlight" = "dfc999",
	"red - autumn" = "a34332"
	))

/proc/clanfication(mob/living/carbon/human/H)
	var/index = findtext(H.real_name, " Clanless") //Find 'Clanless' where an 'Clanless' makes no sense to  exist.
	if(index)
		var/original_first_name = copytext(H.real_name, 1, index) //First name extraction.
		var/new_surname = H.dna.species.random_surname() //Generation of a generic clan surname for RP purposes.
		var/new_full_name = "[original_first_name][new_surname]" //Creates a new full name. "Firstname of Surname clan"
		H.change_name(new_full_name) //Applies the name.
		testing("[H.real_name] has been reassigned a surname: [new_full_name]") //Debuglog for information. Sometimes "(name) the of (surname) happens and I'M FUGGING GOING INSANE."

//Not done yet.
/*
/mob/living/carbon/human/verb/abyssaltide()
	set name = "Abyssal Tide"
	set category = "Memory"
	if(HAS_TRAIT(src, TRAIT_KAIZOKU))  // I'm fUGGING ANGRY AT THIS, WHY IT DOESN'T WORKKAHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
		var/readme_text = file2text("strings/rt/Abyssal_Tide.json")  // CAN'T READ IIIIIIIIT
		if (readme_text)
			src << browse(readme_text, "window=memory")  // AHHHHHHHHHHHHHHHHHH 'IM GOING TO DUFDSGOKSDOGRT
		else
			to_chat(src, "OOC: The Abyssal Tide information is missing or cannot be read. Please check for further information on Discord.")
	else
		to_chat(src, "You have no idea what Abyssal Tide means.")
*/
