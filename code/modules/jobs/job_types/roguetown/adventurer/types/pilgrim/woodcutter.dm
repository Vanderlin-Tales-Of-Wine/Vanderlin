/datum/advclass/pilgrim/woodcutter
	name = "Woodcutter"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list("Humen",
	"Elf",
	"Dark Elf",
	"Half-Elf",
	"Tiefling",
	"Dwarf",
	"Aasimar",
	"Half-Orc"

	)
	outfit = /datum/outfit/job/roguetown/adventurer/woodcutter
	category_tags = list(CTAG_DISABLED)
	apprentice_name = "Woodcutter"

/datum/outfit/job/roguetown/adventurer/woodcutter/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, pick(3,3,4), TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/labor/lumberjacking, 3, TRUE)
	belt = /obj/item/storage/belt/rogue/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	pants = /obj/item/clothing/under/roguetown/trou
	head = /obj/item/clothing/head/roguetown/brimmed
	neck = /obj/item/clothing/neck/roguetown/coif
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	backr = /obj/item/storage/backpack/rogue/satchel
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	armor = /obj/item/clothing/suit/roguetown/armor/gambeson/light/striped
	beltr = /obj/item/rogueweapon/axe/iron
	beltl = /obj/item/rogueweapon/knife/villager
	backpack_contents = list(/obj/item/flint = 1, /obj/item/key/artificer = 1)
	H.change_stat("strength", 1)
	H.change_stat("endurance", 1) // Tree chopping builds endurance
