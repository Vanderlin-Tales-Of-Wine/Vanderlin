
/mob/living/carbon/human/proc/change_name(new_name)
	real_name = new_name

/mob/living/carbon/human/restrained(ignore_grab)
	. = ((wear_armor && wear_armor.breakouttime) || ..())

/mob/living/carbon/human/check_language_hear(language)
	var/mob/living/carbon/V = src
	if(!language)
		return
	if(wear_neck)
		if(istype(wear_neck, /obj/item/clothing/neck/roguetown/talkstone))
			return TRUE
	if(!has_language(language))
		if(has_flaw(/datum/charflaw/paranoid))
			V.add_stress(/datum/stressevent/paratalk)


/mob/living/carbon/human/canBeHandcuffed()
	if(get_num_arms(FALSE) >= 2)
		return TRUE
	else
		return FALSE

//gets assignment from ID or ID inside PDA or PDA itself
//Useful when player do something with computers
/mob/living/carbon/human/proc/get_assignment(if_no_id = "No id", if_no_job = "No job", hand_first = TRUE)
	return if_no_job

//gets name from ID or ID inside PDA or PDA itself
//Useful when player do something with computers
/mob/living/carbon/human/proc/get_authentification_name(if_no_id = "Unknown")
	return if_no_id

//repurposed proc. Now it combines get_id_name() and get_face_name() to determine a mob's name variable. Made into a separate proc as it'll be useful elsewhere
/mob/living/carbon/human/get_visible_name()
	var/face_name = get_face_name("")
	var/id_name = get_id_name("")
	if(name_override)
		return name_override
	if(face_name)
		if(id_name && (id_name != face_name))
			return "Unknown [(gender == FEMALE) ? "Woman" : "Man"]"
		return face_name
	if(id_name)
		return id_name
	return "Unknown"

//Returns "Unknown" if facially disfigured and real_name if not. Useful for setting name when Fluacided or when updating a human's name variable
/mob/living/carbon/human/proc/get_face_name(if_no_face="Unknown")
	if( wear_mask && (wear_mask.flags_inv&HIDEFACE) )	//Wearing a mask which hides our face, use id-name if possible
		return if_no_face
	if( head && (head.flags_inv&HIDEFACE) )
		return if_no_face		//Likewise for hats
	var/obj/item/bodypart/O = get_bodypart(BODY_ZONE_HEAD)
	if( !O || (HAS_TRAIT(src, TRAIT_DISFIGURED)) || !real_name || O.skeletonized )	//disfigured. use id-name if possible
		return if_no_face
	return real_name

//gets name from ID or PDA itself, ID inside PDA doesn't matter
//Useful when player is being seen by other mobs
/mob/living/carbon/human/proc/get_id_name(if_no_id = "Unknown")
	. = if_no_id	//to prevent null-names making the mob unclickable
	return

/mob/living/carbon/human/IsAdvancedToolUser()
	if(HAS_TRAIT(src, TRAIT_MONKEYLIKE))
		return FALSE
	return TRUE//Humans can use guns and such

/mob/living/carbon/human/reagent_check(datum/reagent/R)
	return dna.species.handle_chemicals(R,src)
	// if it returns 0, it will run the usual on_mob_life for that reagent. otherwise, it will stop after running handle_chemicals for the species.


/mob/living/carbon/human/can_track(mob/living/user)
	if(istype(head, /obj/item/clothing/head))
		var/obj/item/clothing/head/hat = head
		if(hat.blockTracking)
			return 0

	return ..()

/mob/living/carbon/human/can_use_guns(obj/item/G)
	. = ..()
	if(G.trigger_guard == TRIGGER_GUARD_NORMAL)
		if(HAS_TRAIT(src, TRAIT_CHUNKYFINGERS))
			to_chat(src, "<span class='warning'>My meaty finger is much too large for the trigger guard!</span>")
			return FALSE
	if(HAS_TRAIT(src, TRAIT_NOGUNS))
		to_chat(src, "<span class='warning'>I can't bring myself to use a ranged weapon!</span>")
		return FALSE

/mob/living/carbon/human/get_policy_keywords()
	. = ..()
	. += "[dna.species.type]"

/mob/living/carbon/human/can_see_reagents()
	. = ..()
	if(.) //No need to run through all of this if it's already true.
		return
	if(isclothing(glasses) && (glasses.clothing_flags & SCAN_REAGENTS))
		return TRUE
	if(isclothing(head) && (head.clothing_flags & SCAN_REAGENTS))
		return TRUE
	if(isclothing(wear_mask) && (wear_mask.clothing_flags & SCAN_REAGENTS))
		return TRUE

/mob/living/carbon/human/get_punch_dmg()
	var/damage = 12

	var/used_str = STASTR

	if(domhand)
		used_str = get_str_arms(used_hand)

	if(used_str >= 11)
		damage = max(damage + (damage * ((used_str - 10) * 0.3)), 1)

	if(used_str <= 9)
		damage = max(damage - (damage * ((10 - used_str) * 0.1)), 1)

	if(mind)
		if(mind.has_antag_datum(/datum/antagonist/werewolf))
			return 30

	return damage

/*
* Family Tree subsystem helpers
* I was tired of editing indvidual values
* across fluff.dm and death.dm so im simplifying
* the process. They check with these procs that
* i can edit from here. -IP
*/
/mob/living/carbon/human/proc/RomanticPartner(mob/living/carbon/human/H)
	if(!ishuman(H))
		return
	if(spouse_mob == H)
		return TRUE

/mob/living/carbon/human/proc/IsWedded(mob/living/carbon/human/wedder)
	if(spouse_mob)
		return TRUE

//Instead of putting the spouse variable everywhere its all funneled through this proc.
/mob/living/carbon/human/proc/MarryTo(mob/living/carbon/human/spouse)
	if(!ishuman(spouse))
		return
	var/datum/heritage/brides_family = spouse.family_datum
	var/groommale = FALSE
	var/bridemale = FALSE
	if(gender == MALE)
		groommale = TRUE
	if(spouse.gender == MALE)
		bridemale = TRUE
	spouse_mob = spouse
	spouse.spouse_mob = src
	//If the bride is male then we assign her status in the family as father.
	//Im going to use this wacky tech to shorten the code. -IP
	var/checkgender = bridemale
	var/datum/heritage/checkfamdat = family_datum
	var/mob/living/carbon/human/who_we_check1 = src
	var/mob/living/carbon/human/who_we_transfer = spouse
	for(var/cycle = 1 to 2)
		//If cycle one is done then run again but with cycle 2 variables.
		if(cycle == 2)
			checkgender = groommale
			checkfamdat = brides_family
			who_we_check1 = spouse
			who_we_transfer = src
		//Do we have a family datum?
		if(checkfamdat)
			//Is the person being checked the patriarch or the matriarch? If not assign the person being transfered as a inlaw.
			if(checkfamdat.patriarch == who_we_check1 || checkfamdat.matriarch == who_we_check1)
				checkfamdat.TransferFamilies(who_we_transfer, checkgender ? FAMILY_FATHER : FAMILY_MOTHER)
				break
			else
				checkfamdat.TransferFamilies(who_we_transfer, FAMILY_INLAW)
				break
	return checkfamdat

//Perspective stranger looks at --> src
/mob/living/carbon/human/proc/ReturnRelation(mob/living/carbon/human/stranger)
	return family_datum.ReturnRelation(src, stranger)
