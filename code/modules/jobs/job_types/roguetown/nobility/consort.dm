/datum/job/roguetown/consort
	title = "Consort"
	flag = CONSORT
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 0
	spawn_positions = 1

	spells = list(/obj/effect/proc_holder/spell/self/convertrole/servant)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf"
	)

	tutorial = "Yours was a marriage of political convenience rather than love, yet you have remained the ruling monarch's good friend and confidant throughout your marriage. But your love and loyalty will be tested, for daggers are equally pointed at your throat."

	outfit = /datum/outfit/job/roguetown/consort
	advclass_cat_rolls = list(CTAG_CONSORT = 20)

	display_order = JDO_CONSORT
	bypass_lastclass = TRUE
	min_pq = 6
	give_bank_account = 500

	cmode_music = 'sound/music/cmode/nobility/combat_noble.ogg'
	apprentice_name = "Servant"

/datum/job/roguetown/consort/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")
		if(H.gender == FEMALE)
			SSfamilytree.AddRoyal(H, FAMILY_MOTHER)
		else
			SSfamilytree.AddRoyal(H, FAMILY_FATHER)

/datum/outfit/job/roguetown/consort // Default equipment regardless of class.
	head = /obj/item/clothing/head/roguetown/crown/nyle/consortcrown
	shoes = /obj/item/clothing/shoes/roguetown/boots
	id = /obj/item/clothing/ring/silver
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/storage/keyring/consort
	beltr = /obj/item/storage/belt/rogue/pouch/coins/rich

/* ! ! ! CONSORT CLASSES ! ! !
- Highborn: The "default" class, a typical Enigman noble. Decent with swords and a knife. Can sew and read pretty good. A little squishy.
- Courtesan: Ex-classy or not-so-classy prostitute. Concerningly good with that knife and sneaking around. A little dumb.
- Lowborn: A good wholesome peasant spouse. Can cook and swing a pitchfork good. Not so smart or perceptive.
*/
/datum/advclass/consort
	displays_adv_job = FALSE

/datum/advclass/consort/highborn
	name = "Highborn Consort"
	tutorial = "Of a minor noble house, yours is a rather typical tale; you were trained in manners, literature, and intrigue, all to be married off to the next ruler of this backwater island."
	outfit = /datum/outfit/job/roguetown/consort/highborn

	category_tags = list(CTAG_CONSORT)

/datum/outfit/job/roguetown/consort/highborn/pre_equip(mob/living/carbon/human/H)
	. = ..()
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights/black
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
		armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/winterjacket
	else
		pants = /obj/item/clothing/under/roguetown/tights/random
		armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/winterjacket
		shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/winterdress


	H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	if(H.age == AGE_OLD)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
	H.change_stat("intelligence", 3)
	H.change_stat("endurance", 1)
	H.change_stat("perception", 3)
	H.change_stat("speed", 1)
	H.change_stat("fortune", 5)
	ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NUTCRACKER, TRAIT_GENERIC)

/datum/advclass/consort/courtesan
	name = "Courtesan Consort"
	tutorial = "Though initially none envied your lot in life, it's certain that your midnight talents haven't gone to waste. Your honeyed words and charm have brought you right to being a ruler's beloved consort."
	outfit = /datum/outfit/job/roguetown/consort/courtesan

	category_tags = list(CTAG_CONSORT)

/datum/outfit/job/roguetown/consort/courtesan/pre_equip(mob/living/carbon/human/H)
	. = ..()
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights/black
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
		armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/winterjacket // this is kind of stupid but i love it anyway
	else
		pants = /obj/item/clothing/under/roguetown/tights/random
		shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/winterdress
		armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/winterjacket
		cloak = /obj/item/clothing/cloak/raincloak/furcloak

	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE) // oh you know
	H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
	if(H.age == AGE_OLD)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	H.change_stat("strength", 1)
	H.change_stat("intelligence", -1)
	H.change_stat("endurance", 2)
	H.change_stat("speed", 1)
	H.change_stat("fortune", 3)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NUTCRACKER, TRAIT_GENERIC)

/datum/advclass/consort/lowborn
	name = "Lowborn Consort"
	tutorial = "You never could have dreamed your life would be like this. Though your origins are humble, something special about you - whether it was your good looks, your kind heart, or your bravery - has brought you into Vanderlin Keep."
	outfit = /datum/outfit/job/roguetown/consort/lowborn

	category_tags = list(CTAG_CONSORT)

/datum/outfit/job/roguetown/consort/lowborn/pre_equip(mob/living/carbon/human/H)
	. = ..()
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights/green
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
		armor = /obj/item/clothing/suit/roguetown/shirt/tunic/green
	else
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/silkdress/princess
		armor = /obj/item/clothing/suit/roguetown/armor/leather/jacket/silk_coat

	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/farming, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
	if(H.age == AGE_OLD)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.change_stat("strength", 1)
	H.change_stat("constitution", 2) // good old peasant constitution. in exchange for making them dumb, they will be STRONG.
	H.change_stat("intelligence", -2) // either a hapless dumbass, or just not educated
	H.change_stat("endurance", 3)
	H.change_stat("speed", -1)
	H.change_stat("fortune", 1)
	ADD_TRAIT(H, TRAIT_SEEDKNOW, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NUTCRACKER, TRAIT_GENERIC)

/datum/advclass/consort/courtesan/night_spy
	name = "Night-Mother's Spy Consort"
	tutorial = "Raised by the guild to report on all the Monarch's action. Using your honeyed words and charm have brought you right to being a ruler's beloved consort."
	outfit = /datum/outfit/job/roguetown/consort/courtesan/spy

	category_tags = list(CTAG_CONSORT)

/datum/job/roguetown/exlady //just used to change the consort title
	title = "Ex-Consort"
	flag = CONSORT
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	display_order = JDO_CONSORT

/datum/outfit/job/roguetown/consort/courtesan/spy/pre_equip(mob/living/carbon/human/H)
	. = ..()
	H.grant_language(/datum/language/thievescant)
	to_chat(H, "<span class='info'>I can gesture in thieves' cant with ,t before my speech.</span>")
	ADD_TRAIT(H, TRAIT_THIEVESGUILD, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NUTCRACKER, TRAIT_GENERIC)

/obj/effect/proc_holder/spell/self/convertrole/servant
	name = "Recruit Servant"
	new_role = "Servant"
	overlay_state = "recruit_servant"
	recruitment_faction = "Servants"
	recruitment_message = "Join the keep's servants, %RECRUIT!"
	accept_message = "I serve the Crown!"
	refuse_message = "I refuse."
	charge_max = 100
