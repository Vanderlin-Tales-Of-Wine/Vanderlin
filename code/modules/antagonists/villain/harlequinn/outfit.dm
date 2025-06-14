
/datum/outfit/job/harlequin/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/boots/leather
	neck = /obj/item/clothing/neck/gorget
	mask = /obj/item/clothing/face/mask/facemask/steel/harlequin
	gloves = /obj/item/clothing/gloves/fingerless
	belt = /obj/item/storage/belt/leather/black
	wrists = /obj/item/rope
	pants = /obj/item/clothing/pants/trou/leather
	armor = /obj/item/clothing/armor/leather/jacket
	beltl = /obj/item/weapon/knife/dagger/steel
	beltr = /obj/item/instrument/flute
	backr = /obj/item/storage/backpack/satchel
	backl = /obj/item/storage/belt/pouch/coins/poor
	cloak = /obj/item/clothing/cloak/half/shadowcloak
	head = /obj/item/clothing/head/roguehood/black

	H.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/music, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 3, TRUE)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/shadowstep)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/enhanced_mimicry)
	H.change_stat("strength", 2)
	H.change_stat("endurance", 2)
	H.change_stat("perception", 1)
	H.change_stat("speed", 3)

	backpack_contents = list(
		/obj/item/harlequinn_disguise_kit,
		/obj/item/reagent_containers/glass/bottle/poison,
		/obj/item/lockpick,
		/obj/item/smokebomb = 2,
	)

	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
