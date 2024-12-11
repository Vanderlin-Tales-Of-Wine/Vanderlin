/datum/job/roguetown/lady
	title = "Queen"
	flag = LADY
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 0
	spawn_positions = 1

	allowed_sexes = list(FEMALE)

	spells = list(
		/obj/effect/proc_holder/spell/self/grant_title,
	)

	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf"
	)
	tutorial = "Picked out of your political value rather than likely any form of love, you have become the King's most trusted confidant and likely friend throughout your marriage. Your loyalty and, perhaps, love; will be tested this day. For the daggers that threaten your beloved are as equally pointed at your own throat."

	outfit = /datum/outfit/job/roguetown/lady

	display_order = JDO_LADY
	bypass_lastclass = TRUE
	give_bank_account = 500
	min_pq = 4
	cmode_music = 'sound/music/cmode/nobility/combat_noble.ogg'

/datum/outfit/job/roguetown/lady/pre_equip(mob/living/carbon/human/H)
	. = ..()
	ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NUTCRACKER, TRAIT_GENERIC)
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	belt = /obj/item/storage/belt/rogue/leather/cloth/lady
	beltl = /obj/item/storage/keyring/queen
	armor = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/dress
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/clothing/head/roguetown/crown/circlet = 1)
	if(SSticker.rulertype == "Queen")
		head = /obj/item/clothing/head/roguetown/crown/serpcrown
		SSroguemachine.crown = head
		cloak = /obj/item/clothing/cloak/lordcloak
		belt = /obj/item/storage/belt/rogue/leather/plaquegold
		armor = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/dress/alt
		l_hand = /obj/item/rogueweapon/lordscepter
		if(H.mind)
			H.mind?.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
			if(H.age == AGE_OLD)
				H.mind?.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.change_stat("intelligence", 3)
			H.change_stat("endurance", 3)
			H.change_stat("speed", 2)
			H.change_stat("perception", 2)
			H.change_stat("fortune", 5)
	if(prob(66))
		armor = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/dress/alt
	id = /obj/item/clothing/ring/silver
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, pick(1,2,3), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)

/datum/job/roguetown/lady/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(SSticker.rulertype == "Queen")
		SSticker.select_ruler()
		if(L)
			to_chat(world, "<b><span class='notice'><span class='big'>[L.real_name] is Queen of Rockhill.</span></span></b>")
			to_chat(world, "<br>")
			addtimer(CALLBACK(L, TYPE_PROC_REF(/mob, lord_color_choice)), 50)
	SSfamilytree.AddRoyal(L, FAMILY_MOTHER)
