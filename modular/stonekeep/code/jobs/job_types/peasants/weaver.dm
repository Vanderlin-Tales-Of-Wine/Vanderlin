/datum/job/stonekeep/weaver
	title = "Weaver"
	flag = SK_WEAVER
	department_flag = PEASANTS
	tutorial = "Cloth, linen, silk and leather. You've tirelessly studied and poured your life into \
				sewing articles of protection, padding, and fashion for serf and noble alike."
	total_positions = 1
	spawn_positions = 1
	allowed_races = list("Humen","Elf","Aasimar","Half-Elf","Dwarf")
	display_order = WEAVER_ORDER
	min_pq = -50

	outfit = /datum/outfit/job/stonekeep/weaver

/datum/outfit/job/stonekeep/weaver/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/shirt/robe/weaver
	shirt = /obj/item/clothing/shirt/tunic/random
	shoes = /obj/item/clothing/shoes/shortboots
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/weapon/knife/scissors
	beltl = /obj/item/key/tailor
	backr = /obj/item/storage/backpack/satchel
	neck = /obj/item/storage/belt/pouch/coins/mid
	pants = /obj/item/clothing/pants/tights/random
	cloak = /obj/item/clothing/cloak/half/random
	if(H.gender == FEMALE)
		head = /obj/item/clothing/head/armingcap
	backpack_contents = list(/obj/item/needle = 1, /obj/item/natural/bundle/cloth = 2, /obj/item/natural/bundle/fibers = 1, /obj/item/dye_pack/luxury = 1, /obj/item/weapon/knife/villager = 1)

	H.mind?.adjust_skillrank(/datum/skill/misc/sewing, pick(4,5), TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/tanning, pick(3,4), TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 1, TRUE)
	ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)
	H.change_stat("intelligence", 2)
	H.change_stat("speed", 2)
	H.change_stat("perception", 1)
	H.change_stat("strength", -1)
