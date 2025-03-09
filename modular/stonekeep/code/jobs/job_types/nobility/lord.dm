/datum/job/stonekeep/lord
	title = "Monarch"
	flag = SK_LORD
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 0
	spawn_positions = 1

	spells = list(
		/obj/effect/proc_holder/spell/self/grant_title,
		/obj/effect/proc_holder/spell/self/grant_nobility,
	)

	allowed_races = list(
		"Humen"
	)
	outfit = /datum/outfit/job/stonekeep/lord
	display_order = 1
	tutorial = "Elevated upon your throne through a web of intrigue and political upheaval, you are the absolute authority of these lands and at the center of every plot within it. Every man, woman and child is envious of your position and would replace you in less than a heartbeat: Show them the error in their ways."
	bypass_lastclass = TRUE
	whitelist_req = FALSE
	min_pq = 0
	give_bank_account = 500
	selection_color = "#7851A9"

	cmode_music = 'sound/music/cmode/nobility/combat_noble.ogg'
	can_have_apprentices = FALSE

/datum/job/stonekeep/lord/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
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

/datum/outfit/job/stonekeep/lord/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/crown/serpcrown
	backr = /obj/item/storage/backpack/satchel
	belt = /obj/item/storage/belt/leather/plaquegold
	backpack_contents = list(/obj/item/weapon/knife/dagger/steel/special = 1)
	id = /obj/item/clothing/ring/active/nomag
	l_hand = /obj/item/weapon/lordscepter
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
		pants = /obj/item/clothing/pants/pantaloons/dark
		shirt = /obj/item/clothing/shirt/undershirt/black
		armor = /obj/item/clothing/armor/medium/surcoat
		shoes = /obj/item/clothing/shoes/boots
		cloak = /obj/item/clothing/cloak/lordcloak
		if(H.dna?.species)
			if(H.dna.species.id == "human")
				H.dna.species.soundpack_m = new /datum/voicepack/male/evil()
	else
		pants = /obj/item/clothing/pants/tights/random
		armor = /obj/item/clothing/armor/gambeson/heavy/winterdress
		shoes = /obj/item/clothing/shoes/shortboots
		cloak = /obj/item/clothing/cloak/lordcloak/ladycloak
		wrists = /obj/item/clothing/wrists/royalsleeves

		if(H.wear_mask)
			if(istype(H.wear_mask, /obj/item/clothing/face/eyepatch))
				qdel(H.wear_mask)
				mask = /obj/item/clothing/face/lordmask
			if(istype(H.wear_mask, /obj/item/clothing/face/eyepatch/left))
				qdel(H.wear_mask)
				mask = /obj/item/clothing/face/lordmask/l

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
