// Literally Yakuza, but split into Kabukimonos and Toweryakkos.
// They are different references to Kabuki-monos and Machi-yakko.
// ALL of them are Burakumins.
// Their presence on the alt map will be more of gang warfare instead of a mercenary job.

/datum/advclass/mercenary/kabukimaru
	name = "Kabuki-maru"
	tutorial = "You're an exiled brigand driven by coin while robed in yellow. Known for wild antics, loose camaraderie and using large odachis. Your rivals in purple robes are a constant thorn in your search for richness."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen", //Heartfeltean.
		"Changeling",
		"Skylancer",
		"Ogrun",
		"Undine"
	)
	outfit = /datum/outfit/job/roguetown/mercenary/kabukimaru
	category_tags = list(CTAG_MERCENARY)
	maximum_possible_slots = 5

/datum/outfit/job/roguetown/mercenary/kabukimaru/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(3,4), TRUE) //sword is their focus.
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, pick(1,1,2), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, pick(2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/shields, pick(0,0,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.burakumin = TRUE //They will not receive the explosive mask, as these have already been exiled. They do not require masks to exist on a society.

	beltr = /obj/item/storage/belt/pouch/coins/poor
	neck = /obj/item/clothing/neck/chaincoif/karuta_zukin/kabukimono
	pants = /obj/item/clothing/pants/trou/tobi/kabukimono
	shoes = /obj/item/clothing/shoes/shortboots/cloudhead/kabukimono
	gloves = /obj/item/clothing/gloves/leather/abyssal/kabukimono
	belt = /obj/item/storage/belt/leather
	beltl = /obj/item/weapon/mace/cudgel/jitte
	cloak = /obj/item/clothing/cloak/raincloak/horocloak/kabukimono
	shirt = /obj/item/clothing/shirt/tunic/kimono/kabukimono
	head = /obj/item/clothing/head/helmet/kaizoku/hachigane
	armor = /obj/item/clothing/armor/cuirass/nanbando
	backl = /obj/item/storage/backpack/satchel
	backr = /obj/item/weapon/sword/long/greatsword/odachi
	if(!H.has_language(/datum/language/abyssal))
		H.grant_language(/datum/language/abyssal)
		to_chat(H, "<span class='info'>I can speak Abyssal with ,a before my speech.</span>")

	H.merctype = 9

	H.change_stat("strength", 2) // Big sword. They really are not that different of the grezenholft counterpart, but even less armored.
	H.change_stat("endurance", 1)
	H.change_stat("constitution", 2)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
