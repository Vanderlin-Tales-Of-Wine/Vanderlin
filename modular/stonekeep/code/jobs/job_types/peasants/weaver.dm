/datum/job/roguetown/sk_weaver
	title = "Weaver"
	flag = SK_WEAVER
	department_flag = PEASANTS
	faction = "Station"
	tutorial = "Cloth, linen, silk and leather. You've tirelessly studied and poured your life into \
				sewing articles of protection, padding, and fashion for serf and noble alike."
	total_positions = 1
	spawn_positions = 1
	allowed_races = list("Humen","Elf","Aasimar","Half-Elf","Dwarf")
	give_bank_account = TRUE
	bypass_lastclass = TRUE
	display_order = WEAVER_ORDER
	min_pq = -50

	outfit = /datum/outfit/job/roguetown/sk_weaver

/datum/outfit/job/roguetown/sk_weaver/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/shirt/tunic/random
	shoes = /obj/item/clothing/shoes/nobleboot
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/weapon/knife/scissors
	beltl = /obj/item/key/tailor
	backr = /obj/item/storage/backpack/satchel
	neck = /obj/item/storage/belt/pouch/coins/mid
	cloak = /obj/item/clothing/cloak/cape/silk
	if(H.gender == FEMALE)
		head = /obj/item/clothing/head/armingcap
		shirt = /obj/item/clothing/shirt/dress/valorian
	else
		pants = /obj/item/clothing/pants/tights/random
	backpack_contents = list(/obj/item/needle = 1, /obj/item/natural/bundle/cloth = 2, /obj/item/natural/bundle/fibers = 1, /obj/item/dye_pack/luxury = 1, /obj/item/book/advice_weaving = 1, /obj/item/weapon/knife/villager = 1)


	H.mind?.adjust_skillrank(/datum/skill/misc/sewing, pick(4,5), TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/tanning, pick(3,4), TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 1, TRUE)
	ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)
	if(H.gender == MALE)
		pants = /obj/item/clothing/pants/tights/red
		shirt = /obj/item/clothing/shirt/undershirt/red
		armor = /obj/item/clothing/shirt/tunic/red
		cloak = /obj/item/clothing/cloak/raincloak/furcloak
	else
		cloak = /obj/item/clothing/cloak/raincloak/furcloak
		shirt = /obj/item/clothing/shirt/dress/gen/purple
		armor = /obj/item/clothing/shirt/tunic/purple
		pants = /obj/item/clothing/pants/tights/purple
	H.change_stat("intelligence", 2)
	H.change_stat("speed", 2)
	H.change_stat("perception", 1)
	H.change_stat("strength", -1)
	if(!H.has_language(/datum/language/dwarvish))
		H.grant_language(/datum/language/dwarvish)
		to_chat(H, "<span class='info'>My life has been shaped by working for the Dwarf-dominated Maker's Guild. I can speak Dwarvish with ,d before my speech.</span>")
