/datum/advclass/mercenary/grenzelhoft
	name = "Grenzelhoft"
	tutorial = "A mercenary from the Grenzelhoft Empire's Mercenary Guild. Their only care is coin, and the procurement of coin."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_GRENZ
	outfit = /datum/outfit/job/mercenary/grenzelhoft
	category_tags = list(CTAG_MERCENARY)
	maximum_possible_slots = 5

	cmode_music = 'sound/music/cmode/combat_grenzelhoft.ogg'

/datum/outfit/job/mercenary/grenzelhoft/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)	//Big sword user so - really helps them.
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, pick(1,1,2), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, pick(2,3), TRUE) // Equal chance between skilled and average, can use a cudgel to beat less dangerous targets into submission
		H.mind?.adjust_skillrank(/datum/skill/combat/shields, pick(0,0,1), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)

	if(H.gender == FEMALE)
		H.underwear = "Femleotard"
		H.underwear_color = CLOTHING_SOOT_BLACK
		H.update_body()

	beltr = /obj/item/storage/belt/pouch/coins/poor
	neck = /obj/item/clothing/neck/chaincoif
	pants = /obj/item/clothing/pants/grenzelpants
	shoes = /obj/item/clothing/shoes/grenzelhoft
	gloves = /obj/item/clothing/gloves/angle/grenzel
	belt = /obj/item/storage/belt/leather/mercenary
	beltl = /obj/item/weapon/mace/cudgel
	shirt = /obj/item/clothing/shirt/grenzelhoft
	head = /obj/item/clothing/head/helmet/skullcap/grenzelhoft
	armor = /obj/item/clothing/armor/cuirass/grenzelhoft
	backl = /obj/item/storage/backpack/satchel
	backr = /obj/item/weapon/sword/long/greatsword/zwei
	if(!H.has_language(/datum/language/oldpsydonic))
		H.grant_language(/datum/language/oldpsydonic)
		to_chat(H, "<span class='info'>I can speak Old Psydonic with ,m before my speech.</span>")

	H.merctype = 2

	H.change_stat(STATKEY_STR, 2) // They need this to roll at least min STR for the Zwei.
	H.change_stat(STATKEY_CON, 2)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
