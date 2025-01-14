/datum/advclass/mercenary/anthrax
	name = "Anthrax"
	tutorial = "With the brutal dismantlement of drow society, the talents of the redeemed Anthraxi were no longer needed. Yet where one door closes, another opens - the decadent mortals of the overworld clamber over each other to bid for your blade. Show them your craft."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list("Dark Elf")
	outfit = /datum/outfit/job/roguetown/mercenary/anthrax
	category_tags = list(CTAG_MERCENARY)
	maximum_possible_slots = 5

	cmode_music = 'sound/music/cmode/adventurer/CombatOutlander3.ogg'

/datum/outfit/job/roguetown/mercenary/anthrax/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/boots
	belt = /obj/item/storage/belt/rogue/leather/black
	pants = /obj/item/clothing/under/roguetown/trou/shadowpants
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/key/mercenary, /obj/item/storage/belt/rogue/pouch/coins/poor, /obj/item/rogueweapon/knife/dagger/steel/dirk)
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)

		ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
		H.verbs |= /mob/living/carbon/human/proc/torture_victim //Secret police training owing to their origins.

		if(H.gender == FEMALE) //Melee defense-oriented brute, heavy lean towards non-lethal takedowns and capture.
			armor = /obj/item/clothing/suit/roguetown/armor/cuirass/iron/shadowplate
			gloves = /obj/item/clothing/gloves/roguetown/chain/iron/shadowgauntlets
			wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
			mask = /obj/item/clothing/mask/rogue/facemask/shadowfacemask
			neck = /obj/item/clothing/neck/roguetown/gorget
			backr = /obj/item/rogueweapon/shield/tower/spidershield
			beltr = /obj/item/rogueweapon/whip/spiderwhip

			H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)

			H.change_stat("strength", 2) //Grenz merc statline but with maluses.
			H.change_stat("constitution", 1)
			H.change_stat("endurance", 1)
			H.change_stat("intelligence", -1) //Brutebrain, relies on archer for healing, lockpicking and crafting.
			H.change_stat("speed", -1)

			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

		if(H.gender == MALE) //Squishy hit-and-runner assassin.
			shirt = /obj/item/clothing/suit/roguetown/shirt/shadowshirt
			armor = /obj/item/clothing/suit/roguetown/armor/gambeson/shadowrobe
			cloak = /obj/item/clothing/cloak/half/shadowcloak
			gloves = /obj/item/clothing/gloves/roguetown/fingerless/shadowgloves
			mask = /obj/item/clothing/mask/rogue/shepherd/shadowmask
			neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
			backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve //Coupled with the racial PER malus, abysmal damage, but good for poison arrows.
			beltr = /obj/item/ammo_holder/quiver/arrows
			beltl = /obj/item/rogueweapon/sword/sabre/stalker

			H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 3, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE) //Spread-out support skills, but inferior to Steppesman/Boltslinger.
			H.mind?.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE)

			H.change_stat("speed", 2) //Speedier than a Steppesman, but not as tough or damaging.
			H.change_stat("endurance", 1)

			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)

		H.merctype = 7
