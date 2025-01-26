/datum/job/roguetown/gaffer
	title = "Gaffer"
	flag = GAFFER
	department_flag = SERFS
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = ALL_PLAYER_RACES_BY_NAME
	//I say we let all races be the gaffer, this is job concerns the adventurers guild, and those come in all types and sizes, it makes it feel more like "it could've been anyone, but you got me"
	tutorial = "It used to be a simple life, you spent most of your time with the guild; taking on quests, killing monsters, escorting the passing sucker. You quickly rose in the guild ranks and before long you were chosen to be next Gaffer, with the previous ones mysterious passing, perhaps you were looking for glory and recognition after so many years in this position, but all you get now is monotonous administrative work, and a terrible, terrible burden... As hiding within the very floor of your Guild is a monster only accepting of the name 'Head Eater'. Fulfil your duties of unifying the unwashed adventurer and mercenary masses, organizing expeditions, acting as a bridge between the smithies and merchants so the lot don't loiter, and making sure the quests handed to you are being completed. You may take your cuts as the broker for all the work in town, but coin has little worth to you now, orchestrate conflict, send fools to their doom and shed blood, just to give way for your ultimate goal, gain heads, and feed the beast."

	display_order = JDO_GAFFER
	bypass_lastclass = TRUE

	outfit = /datum/outfit/job/roguetown/gaffer
	bypass_lastclass = TRUE
	give_bank_account = 100
	min_pq = 0
	selection_color = "#3b150e"

/datum/outfit/job/roguetown/gaffer/pre_equip(mob/living/carbon/human/H)
	..()


	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/storage/belt/rogue/pouch/coins/veryrich = 1, /obj/item/merctoken = 2, /obj/item/natural/feather, /obj/item/paper = 3, (/obj/item/rogueweapon/knife/dagger/steel))
	backl = /obj/item/rogueweapon/sword/long
	belt = /obj/item/storage/belt/rogue/leather/plaquegold
	beltl = /obj/item/storage/keyring/gaffer
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
