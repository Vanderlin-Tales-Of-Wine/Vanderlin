/datum/job/roguetown/gaffer
	title = "Gaffer"
	flag = GAFFER
	department_flag = SERFS
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = ALL_PLAYER_RACES_BY_NAME
	//I say we let all races be the gaffer, this is job concerns the adventurers guild, and those come in all types and sizes, it makes it feel more like "it could've been anyone, but you got me"
	tutorial = "Most don't make it long in the life of an adventurer, but you did. Long enough to be chosen as the next Gaffer after the mysterious death of your predecessor. Gone are the days of dodging volve's teeth and swinging iron. Today your life is engrossed with two things: administrative work, and feeding the monstrous Head Eater that resides under the Guilds floors. Unify the adventures and mercenaries and give them the quests they foolishly hunger for. Act as the Guild representative in the town, organize expeditions, and make sure they bring back the heads of any slain monsters or bandits. For the Head Eater hungers..."

	display_order = JDO_GAFFER
	bypass_lastclass = TRUE

	outfit = /datum/outfit/job/roguetown/gaffer
	bypass_lastclass = TRUE
	give_bank_account = 100
	min_pq = 5
	selection_color = "#3b150e"

/datum/outfit/job/roguetown/gaffer/pre_equip(mob/living/carbon/human/H)
	..()


	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/storage/belt/rogue/pouch/coins/rich = 1, /obj/item/merctoken = 2, /obj/item/natural/feather, /obj/item/paper = 4, (/obj/item/rogueweapon/knife/dagger/steel))
	backl = /obj/item/rogueweapon/sword/long
	belt = /obj/item/storage/belt/rogue/leather/plaquegold
	beltl = /obj/item/storage/keyring/gaffer
	beltr = /obj/item/flashlight/flare/torch/lantern
	shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/black
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather/advanced
	armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
	id = /obj/item/clothing/ring/gold
	pants = /obj/item/clothing/under/roguetown/trou/leather/advanced
	shoes = /obj/item/clothing/shoes/roguetown/nobleboot
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/black
	mask = /obj/item/clothing/mask/rogue/eyepatch

	ADD_TRAIT(H, TRAIT_SEEPRICES, type)


	H.change_stat("intelligence", 2)
	H.change_stat("perception", 1)
	H.change_stat("strength", 1)

	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
