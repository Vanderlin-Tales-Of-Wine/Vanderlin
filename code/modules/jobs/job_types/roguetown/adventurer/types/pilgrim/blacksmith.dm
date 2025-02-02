/datum/advclass/pilgrim/blacksmith
	name = "Blacksmith"
	tutorial = "Hardy worksmen that are at home in the forge, dedicating their lives \
	to ceaselessly toil in dedication to Malum."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar",
		"Half-Orc"
	)
	outfit = /datum/outfit/job/roguetown/adventurer/blacksmith
	category_tags = list(CTAG_PILGRIM)
	apprentice_name = "Blacksmith Apprentice"

/datum/outfit/job/roguetown/adventurer/blacksmith/pre_equip(mob/living/carbon/human/H)
	..()
	belt = /obj/item/storage/belt/rogue/leather

	beltr = /obj/item/rogueweapon/hammer/iron
	beltl = /obj/item/rogueweapon/tongs

	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	gloves = /obj/item/clothing/gloves/roguetown/leather
	cloak = /obj/item/clothing/cloak/apron/brown
	pants = /obj/item/clothing/under/roguetown/trou

	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/flint = 1, /obj/item/rogueore/coal=1, /obj/item/rogueore/iron=1)

	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, pick(0,0,1), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, pick(1,2,2), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/masonry, pick(1,1,2), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, pick(1,1,2), TRUE) // For the bin
		H.mind?.adjust_skillrank(/datum/skill/craft/engineering, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE) // For craftable beartraps
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/blacksmithing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/armorsmithing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/weaponsmithing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/smelting, 3, TRUE)
		if(prob(50))
			H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
		if(H.age == AGE_OLD) //Oldness points are a bit different here, you get a pool of 1-3 points that are assigned randomly to the smithing stats since you're not a specialist
			var/oldnesspoints = rand(1,3)
			for(var/i=1, i<oldnesspoints, i++)
				var/datum/skill/craft/skillpicked = pick(/datum/skill/craft/weaponsmithing, /datum/skill/craft/armorsmithing, /datum/skill/craft/blacksmithing)
				H.mind?.adjust_skillrank(skillpicked, 1, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("endurance", 1)
		H.change_stat("constitution", 1)
		H.change_stat("speed", -1)
		ADD_TRAIT(H, TRAIT_MALUMFIRE, TRAIT_GENERIC)

	if(H.gender == MALE)
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
	else
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
		shoes = /obj/item/clothing/shoes/roguetown/shortboots

	if(H.dna.species.id == "dwarf")
		head = /obj/item/clothing/head/roguetown/helmet/leather/minershelm
		H.cmode_music = 'sound/music/cmode/combat_dwarf.ogg'
