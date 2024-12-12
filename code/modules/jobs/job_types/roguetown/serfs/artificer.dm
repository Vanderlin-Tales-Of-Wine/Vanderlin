/datum/job/roguetown/artificer
	title = "Artificer"
	flag = ARTIFICER
	department_flag = SERFS
	faction = "Station"
	total_positions = 2
	spawn_positions = 2

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
	allowed_sexes = list(MALE, FEMALE)

	tutorial = "Hidden in the depths are ancient mechanical secrets, something your creed has taken it upon themselves to studying and understanding. To some, these mechanical wonders may seem like magic, but you know their inner workings as well as you do stone, down to the last cog."

	outfit = /datum/outfit/job/roguetown/mason
	display_order = JDO_MASON
	bypass_lastclass = TRUE
	give_bank_account = 8
	min_pq = -50

/datum/outfit/job/roguetown/mason/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, rand(1,3), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, rand(1,3), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, pick(2,2,3), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/masonry, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/engineering, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/mining, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/smelting, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)

	head = /obj/item/clothing/head/roguetown/brimmed
	neck = /obj/item/clothing/neck/roguetown/coif
	armor = /obj/item/clothing/suit/roguetown/armor/gambeson/light/striped
	cloak = /obj/item/clothing/cloak/apron/waist/brown
	pants = /obj/item/clothing/under/roguetown/trou
	shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/green//gave them the guild tunic they have on the map, blacksmiths get them too
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes/buckle
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
	beltl = /obj/item/key/artificer
	mask = /obj/item/clothing/mask/rogue/spectacles/golden
	backl = /obj/item/storage/backpack/rogue/backpack
	id = /obj/item/clothing/ring/silver/makers_guild
	backpack_contents = list(/obj/item/rogueweapon/hammer/claw = 1, /obj/item/key/artificer = 1, /obj/item/flashlight/flare/torch/lantern, /obj/item/rogueweapon/knife/villager)

	H.change_stat("strength", 1)
	H.change_stat("intelligence", 2)
	H.change_stat("endurance", 1)
	H.change_stat("constitution", 1)
	H.change_stat("speed", -1)

	if(H.dna.species.id == "dwarf")
		head = /obj/item/clothing/head/roguetown/helmet/leather/minershelm
		H.cmode_music = 'sound/music/cmode/combat_dwarf.ogg'
