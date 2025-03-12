/////////////////////////////////////////////////////Abyssariad Pattern for Combat Skills/////////////////////////////////////////////////////////
//'Civilian/Low Abyssanctum' Combat Roles - 3 LEVELS MAX in Combat Skill (Normal) - Many reasons. Mostly religious and Finantial.				//
//'Zamurai/High Abyssanctum' Combat Roles - 4 lEVELS MAX in Combat Skill (Rare) - Plenty of Reasons. Leading religious and Demon-slaying.		//
//'Champion' Combat Roles - 5 LEVELS MAX in Combat SKill (Unique) - Little Reason to go to Rockhill besides Royal Expedition/Rockhill's Captain.//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//THIS ROLE IS FAR FROM FINISHED! The coder that voluntered in helping me on the Abyssanctum spells quitted. So someone willing and able is VERY necessary.
//Contact Monochrome9090 for further information.

/datum/advclass/combat/sk/abyss/mastersohei // High Abyssanctum role. Normally a religious leader for expeditions and whatnot.
	name = "Preceptor Sohei"
	tutorial = "High-ranking Sohei who hold authority within multiple temples and Soheis retainers within their influence. \
	Often in charge of militant activities, these senior soheis are in search of demonic corruption to dismantle - \
	or involve themselves in spiritual matters with a iron fist."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Changeling",
		"Skylancer",
		"Ogrun",
		"Undine"
	)
	outfit = /datum/outfit/job/sk/adventurer/abyss/mastersohei
	maximum_possible_slots = 1
	pickprob = 100
	category_tags = list(CTAG_ADVENTURER)
	vampcompat = FALSE

/datum/outfit/job/sk/adventurer/abyss/mastersohei/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/helmet/heavy/bucket/soheidemon
	wrists = /obj/item/clothing/neck/psycross/silver/abyssanctum
	shirt = /obj/item/clothing/armor/chainmail/hauberk/kusari
	pants = /obj/item/clothing/pants/chainlegs/sendan
	shoes = /obj/item/clothing/shoes/sandals/geta
	belt = /obj/item/storage/belt/kaizoku/leather/daisho/random
	beltl = /obj/item/storage/belt/pouch/coins/mid
	id = /obj/item/clothing/ring/silver
	cloak = /obj/item/clothing/cloak/odoshisohei
	neck = /obj/item/clothing/neck/chaincoif/karuta_zukin/random
	gloves = /obj/item/clothing/gloves/chain/kikko
	r_hand = /obj/item/weapon/polearm/halberd/bisento
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("perception", 2)
		H.change_stat("intelligence", 2)
		H.change_stat("constitution", 1)
		H.change_stat("endurance", 1)
		H.change_stat("speed", -2)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/churn)

	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(H, H.patron)
	//Paladins, while devout warriors spent WAY too much time studying the blade. No more acolyte+
	C.update_devotion(50, 50)
	C.holder_mob = H
	C.grant_spells_sohei(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/churn)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC) //It's meant to be only heavy armor, but Kusari is medium. Idk how templar is doing, but in my testing, the armor was freaked.
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
