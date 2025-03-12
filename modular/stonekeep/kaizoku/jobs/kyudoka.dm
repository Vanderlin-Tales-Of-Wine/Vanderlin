/////////////////////////////////////////////////////Abyssariad Pattern for Combat Skills/////////////////////////////////////////////////////////
//'Civilian/Low Abyssanctum' Combat Roles - 3 LEVELS MAX in Combat Skill (Normal) - Many reasons. Mostly religious and Finantial.				//
//'Zamurai/High Abyssanctum' Combat Roles - 4 lEVELS MAX in Combat Skill (Rare) - Plenty of Reasons. Leading religious and Demon-slaying.		//
//'Champion' Combat Roles - 5 LEVELS MAX in Combat SKill (Unique) - Little Reason to go to Rockhill besides Royal Expedition/Rockhill's Captain.//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/advclass/combat/sk/abyss/kyudoka //Ashigaru/Civilian role.
	name = "Kyudoka"
	tutorial = "The praticioners of Kyujutsu trained in Dustwalker dojos, making use of the large Yumi as a weapon of war, \
	trying to keep the culture alive even after the creation of handcannons and firelances overly used by the Fog Island's manpower."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
	//humen - need to settle Heartfeltean culture on this one.
	"Changeling",
	"Skylancer",
	"Ogrun",
	"Undine")
	outfit = /datum/outfit/job/sk/adventurer/abyss/kyudoka
	category_tags = list(CTAG_ADVENTURER)
	pickprob = 100

/datum/outfit/job/sk/adventurer/abyss/kyudoka/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(0,1,1), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)

	shoes = /obj/item/clothing/shoes/ridingboots/gutal
	pants = /obj/item/clothing/pants/trou/leather/fur/random
	shirt = /obj/item/clothing/armor/gambeson/light/hitatare/random //For the drip's sake that portrays their military side.
	if(prob(23))
		gloves = /obj/item/clothing/gloves/leather/abyssal
	else
		gloves = /obj/item/clothing/gloves/fingerless/yugake
	wrists = /obj/item/clothing/wrists/bracers/leather/khudagach
	belt = /obj/item/storage/belt/leather
	armor = /obj/item/clothing/armor/leather/hide/dustwalker
	cloak = /obj/item/clothing/cloak/raincloak/mino
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/long/yumi
	backl = /obj/item/storage/backpack/satchel
	beltr = /obj/item/flashlight/flare/torch/lantern
	backpack_contents = list(/obj/item/bait = 1, /obj/item/weapon/huntingknife/kunai = 1)
	beltl = /obj/item/ammo_holder/quiver/arrows
	H.change_stat("perception", 2)
	H.change_stat("endurance", 1)
	H.change_stat("speed", 1)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
