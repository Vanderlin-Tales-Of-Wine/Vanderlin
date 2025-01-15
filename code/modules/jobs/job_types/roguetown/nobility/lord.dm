GLOBAL_VAR(lordsurname)
GLOBAL_LIST_EMPTY(lord_titles)

/datum/job/roguetown/lord
	title = "Monarch"
	flag = LORD
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 0
	spawn_positions = 1

	spells = list(
		/obj/effect/proc_holder/spell/self/grant_title,
		/obj/effect/proc_holder/spell/self/grant_nobility,
	)

	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf"
	)
	outfit = /datum/outfit/job/roguetown/lord
	display_order = JDO_LORD
	tutorial = "Elevated upon your throne through a web of intrigue and political upheaval, you are the absolute authority of these lands and at the center of every plot within it. Every man, woman and child is envious of your position and would replace you in less than a heartbeat: Show them the error in their ways."
	bypass_lastclass = TRUE
	whitelist_req = FALSE
	min_pq = 15
	give_bank_account = 500
	selection_color = "#7851A9"

	cmode_music = 'sound/music/cmode/nobility/combat_noble.ogg'
	can_have_apprentices = FALSE

/datum/job/roguetown/lord/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		SSticker.select_ruler()
		addtimer(CALLBACK(L, TYPE_PROC_REF(/mob, lord_color_choice)), 50)
	if(L.gender == MALE)
		SSfamilytree.AddRoyal(L, FAMILY_FATHER)
		to_chat(world, "<b><span class='notice'><span class='big'>[L.real_name] is King of Vanderlin.</span></span></b>")
		to_chat(world, "<br>")
	else
		SSfamilytree.AddRoyal(L, FAMILY_MOTHER)
		to_chat(world, "<b><span class='notice'><span class='big'>[L.real_name] is Queen of Vanderlin.</span></span></b>")
		to_chat(world, "<br>")

/datum/outfit/job/roguetown/lord/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/crown/serpcrown
	backr = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather/plaquegold
	backpack_contents = list(/obj/item/rogueweapon/knife/dagger/steel/special = 1)
	id = /obj/item/clothing/ring/active/nomag
	l_hand = /obj/item/rogueweapon/lordscepter
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("intelligence", 3)
		H.change_stat("endurance", 3)
		H.change_stat("speed", 1)
		H.change_stat("perception", 2)
		H.change_stat("fortune", 5)
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights/black
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
		armor = /obj/item/clothing/suit/roguetown/armor/gambeson/arming
		shoes = /obj/item/clothing/shoes/roguetown/boots
		cloak = /obj/item/clothing/cloak/lordcloak
		if(H.dna?.species)
			if(H.dna.species.id == "human")
				H.dna.species.soundpack_m = new /datum/voicepack/male/evil()
	else
		pants = /obj/item/clothing/under/roguetown/tights/random
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/royal
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
		cloak = /obj/item/clothing/cloak/lordcloak/ladycloak
		wrists = /obj/item/clothing/wrists/roguetown/royalsleeves

		if(H.wear_mask)
			if(istype(H.wear_mask, /obj/item/clothing/mask/rogue/eyepatch))
				qdel(H.wear_mask)
				mask = /obj/item/clothing/mask/rogue/lordmask
			if(istype(H.wear_mask, /obj/item/clothing/mask/rogue/eyepatch/left))
				qdel(H.wear_mask)
				mask = /obj/item/clothing/mask/rogue/lordmask/l

	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSEGRAB, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
//	SSticker.rulermob = H

/datum/job/roguetown/exlord //just used to change the lords title
	title = "Ex-Monarch"
	flag = LORD
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	display_order = JDO_LORD

/proc/give_lord_surname(mob/living/carbon/human/family_guy, preserve_original = FALSE)
	if(!GLOB.lordsurname)
		return
	if(preserve_original)
		family_guy.fully_replace_character_name(family_guy.real_name, family_guy.real_name + " " + GLOB.lordsurname)
		return family_guy.real_name
	var/list/chopped_name = splittext(family_guy.real_name, " ")
	if(length(chopped_name) > 1)
		family_guy.fully_replace_character_name(family_guy.real_name, chopped_name[1] + " " + GLOB.lordsurname)
	else
		family_guy.fully_replace_character_name(family_guy.real_name, family_guy.real_name + " " + GLOB.lordsurname)
	return family_guy.real_name

/obj/effect/proc_holder/spell/self/grant_title
	name = "Grant Title"
	desc = "Grant someone a title of honor... Or shame."
	overlay_state = "recruit_titlegrant"
	antimagic_allowed = TRUE
	charge_max = 100
	/// Maximum range for title granting
	var/title_range = 3
	/// Maximum length for the title
	var/title_length = 42

/obj/effect/proc_holder/spell/self/grant_title/cast(list/targets, mob/user = usr)
	. = ..()
	var/granted_title = input(user, "What title do you wish to grant?", "[name]") as null|text
	granted_title = reject_bad_text(granted_title, title_length)
	if(!granted_title)
		return
	var/list/recruitment = list()
	for(var/mob/living/carbon/human/village_idiot in (get_hearers_in_view(title_range, user) - user))
		//not allowed
		if(!can_title(village_idiot))
			continue
		recruitment[village_idiot.name] = village_idiot
	if(!length(recruitment))
		to_chat(user, span_warning("There are no potential honoraries in range."))
		return
	var/inputty = input(user, "Select an honorary!", "[name]") as anything in recruitment
	if(inputty)
		var/mob/living/carbon/human/recruit = recruitment[inputty]
		if(!QDELETED(recruit) && (recruit in get_hearers_in_view(title_range, user)))
			INVOKE_ASYNC(src, PROC_REF(village_idiotify), recruit, user, granted_title)
		else
			to_chat(user, span_warning("Honorific failed!"))
	else
		to_chat(user, span_warning("Honorific cancelled."))

/obj/effect/proc_holder/spell/self/grant_title/proc/can_title(mob/living/carbon/human/recruit)
	//wtf
	if(QDELETED(recruit))
		return FALSE
	//need a mind
	if(!recruit.mind)
		return FALSE
	//need to see their damn face
	if(!recruit.get_face_name(null))
		return FALSE
	return TRUE

/obj/effect/proc_holder/spell/self/grant_title/proc/village_idiotify(mob/living/carbon/human/recruit, mob/living/carbon/human/recruiter, granted_title)
	if(QDELETED(recruit) || QDELETED(recruiter) || !granted_title)
		return FALSE
	if(GLOB.lord_titles[recruit.real_name])
		recruiter.say("I HEREBY STRIP YOU, [uppertext(recruit.name)], OF THE TITLE OF [uppertext(GLOB.lord_titles[recruit.real_name])]!")
		GLOB.lord_titles -= recruit.real_name
		return FALSE
	recruiter.say("I HEREBY GRANT YOU, [uppertext(recruit.name)], THE TITLE OF [uppertext(granted_title)]!")
	GLOB.lord_titles[recruit.real_name] = granted_title
	return TRUE


/obj/effect/proc_holder/spell/self/grant_nobility
	name = "Grant Nobility"
	desc = "Make someone a noble, or strip them of their nobility."
	antimagic_allowed = TRUE
	charge_max = 100
	/// Maximum range for nobility granting
	var/nobility_range = 3

/obj/effect/proc_holder/spell/self/grant_nobility/cast(list/targets, mob/user = usr)
	. = ..()
	var/list/recruitment = list()
	for(var/mob/living/carbon/human/village_idiot in (get_hearers_in_view(nobility_range, user) - user))
		//not allowed
		if(!can_nobility(village_idiot))
			continue
		recruitment[village_idiot.name] = village_idiot
	if(!length(recruitment))
		to_chat(user, span_warning("There are no potential honoraries in range."))
		return
	var/inputty = input(user, "Select an honorary!", "[name]") as anything in recruitment
	if(inputty)
		var/mob/living/carbon/human/recruit = recruitment[inputty]
		if(!QDELETED(recruit) && (recruit in get_hearers_in_view(nobility_range, user)))
			INVOKE_ASYNC(src, PROC_REF(grant_nobility), recruit, user)
		else
			to_chat(user, span_warning("Honorific failed!"))
	else
		to_chat(user, span_warning("Honorific cancelled."))

/obj/effect/proc_holder/spell/self/grant_nobility/proc/can_nobility(mob/living/carbon/human/recruit)
	//wtf
	if(QDELETED(recruit))
		return FALSE
	//need a mind
	if(!recruit.mind)
		return FALSE
	//need to see their damn face
	if(!recruit.get_face_name(null))
		return FALSE
	return TRUE

/obj/effect/proc_holder/spell/self/grant_nobility/proc/grant_nobility(mob/living/carbon/human/recruit, mob/living/carbon/human/recruiter)
	if(QDELETED(recruit) || QDELETED(recruiter))
		return FALSE
	if(HAS_TRAIT(recruit, TRAIT_NOBLE))
		recruiter.say("I HEREBY STRIP YOU, [uppertext(recruit.name)], OF NOBILITY!!")
		REMOVE_TRAIT(recruit, TRAIT_NOBLE, TRAIT_GENERIC)
		return FALSE
	recruiter.say("I HEREBY GRANT YOU, [uppertext(recruit.name)], NOBILITY!")
	ADD_TRAIT(recruit, TRAIT_NOBLE, TRAIT_GENERIC)
	return TRUE
