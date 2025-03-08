/////////////////////////////////////////////////////Abyssariad Pattern for Combat Skills/////////////////////////////////////////////////////////
//'Civilian/Low Abyssanctum' Combat Roles - 3 LEVELS MAX in Combat Skill (Normal) - Many reasons. Mostly religious and Finantial.				//
//'Zamurai/High Abyssanctum' Combat Roles - 4 lEVELS MAX in Combat Skill (Rare) - Plenty of Reasons. Leading religious and Demon-slaying.		//
//'Champion' Combat Roles - 5 LEVELS MAX in Combat SKill (Unique) - Little Reason to go to Rockhill besides Royal Expedition/Rockhill's Captain.//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//THIS ROLE IS FAR FROM FINISHED! The coder that voluntered in helping me on the Abyssanctum spells quitted. So someone willing and able is VERY necessary.
//Contact Monochrome9090 for further information.

/datum/advclass/combat/abyssariad/yamabushi //Low-ranking Abyssanctum.
	name = "Yamabushi"
	allowed_sexes = list(MALE, FEMALE)
	tutorial = "The Yamabushi stands as the battle-hardened stewards and hermits of knowledge dedicated to society's \
	welfare of Abyssanctum's faith. Their wisdom welcome other patron within their sacred ranks so their devotion \
	further embrace the greater good. They meditate on mountains and endure long lengths each voyage."
	allowed_races = list(
	"Changeling",
	"Skylancer",
	"Ogrun",
	"Undine")
	outfit = /datum/outfit/job/stonekeep/adventurer/abyssariad/yamabushi
	maximum_possible_slots = 2 //Less slots. It is split with Sohei.
	category_tags = list(CTAG_ADVENTURER)
	pickprob = 100
	vampcompat = FALSE

/datum/outfit/job/stonekeep/adventurer/abyssariad/yamabushi
	allowed_patrons = ALL_CLERIC_PATRONS

/datum/outfit/job/stonekeep/adventurer/abyssariad/yamabushi/pre_equip(mob/living/carbon/human/H)
	..()
	switch(H.patron?.name)
		if("Astrata")
			wrists = /obj/item/clothing/neck/psycross/silver/astrata
			H.virginity = TRUE
		if("Dendor")
			wrists = /obj/item/clothing/neck/psycross/silver/dendor
		if("Necra")
			wrists = /obj/item/clothing/neck/psycross/silver/necra
		if("Eora")
			wrists = /obj/item/clothing/neck/psycross/silver/eora
		if("Ravox")
			wrists = /obj/item/clothing/neck/psycross/silver/ravox
		if("Noc")
			wrists = /obj/item/clothing/neck/psycross/noc
			H.virginity = TRUE
		if("Pestra")
			wrists = /obj/item/clothing/neck/psycross/silver/pestra
		if("Malum")
			wrists = /obj/item/clothing/neck/psycross/silver/malum_steel
		if("Abyssor")
			wrists = /obj/item/clothing/neck/psycross/silver/abyssanctum
		else // Failsafe
			wrists = /obj/item/clothing/neck/psycross/silver

	armor = /obj/item/clothing/armor/plate/nanbando
	shirt = /obj/item/clothing/shirt/rags/monkgarb/random
	shoes = /obj/item/clothing/shoes/boots/jikatabi
	pants = /obj/item/clothing/pants/tights/hakama/random
	backl = /obj/item/storage/backpack/satchel
	belt = /obj/item/storage/belt/kaizoku/leather/daisho/random
	beltr = /obj/item/storage/belt/pouch/coins/poor
	if(prob(40))
		beltr = /obj/item/weapon/mace/ararebo
		beltl = /obj/item/weapon/thrown/ono
	else if(prob(20))
		backr = /obj/item/weapon/mace/goden/kanabo // luckyroll, payoff for the Otsuchi.
	else
		backr = /obj/item/weapon/mace/goden/otsuchi //Somewhat worse than normal mace
	if(prob(50))
		head = /obj/item/clothing/head/tengai/yamabushi
	else
		head = /obj/item/clothing/head/tengai/sandogasa/yamabushi

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
		H.change_stat(STATKEY_STR, 2)
		H.change_stat(STATKEY_PER, -2)
		H.change_stat(STATKEY_CON, 1)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_SPD, -1)


	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(H, H.patron)
	C.holder_mob = H
	C.update_devotion(50, 50)
	C.grant_spells_cleric(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
