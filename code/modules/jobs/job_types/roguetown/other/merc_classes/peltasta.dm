/datum/advclass/mercenary/peltasta
	name = "Peltasta"
	tutorial = "Traveling light, carrying a shield and spear, you've floated around from towns past, to eventually become a merenary for hire"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list("Aasimar")
	outfit = /datum/outfit/job/roguetown/mercenary/peltasta
	category_tags = list(CTAG_MERCENARY)
	maximum_possible_slots = 5

	cmode_music = 'sound/music/cmode/adventurer/CombatOutlander2.ogg'

/datum/outfit/job/roguetown/mercenary/peltasta/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	gloves = /obj/item/clothing/gloves/roguetown/leather
	belt = /obj/item/storage/belt/rogue/leather/mercenary/black
	head = /obj/item/clothing/head/roguetown/helmet/sallet
	armor = /obj/item/clothing/suit/roguetown/armor/leather/splint
	cloak = /obj/item/clothing/cloak/half/linen
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	//beltl =  /obj/item/flashlight/flare/torch/lantern
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/merc
	pants = /obj/item/clothing/under/roguetown/tights
	neck = /obj/item/clothing/neck/roguetown/coif
	backl = /obj/item/rogueweapon/polearm/spear
	backr = /obj/item/rogueweapon/shield/tower
	mask = /obj/item/clothing/mask/rogue/shepherd/clothmask
	backpack_contents = list(/obj/item/rogueweapon/knife/hunting = 1)
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("endurance", 1)
		H.change_stat("constitution", 1)
		H.change_stat("intellegence", -1)

	//ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC) // they probably shouldn't be dodging to well if they are meant to use a sheild, right?
