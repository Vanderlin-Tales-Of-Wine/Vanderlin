/datum/job/roguetown/innkeep_son
	title = "Innkeepers Son"
	f_title = "Innkeepers Daughter"
	flag = INNKEEPCHILD
	department_flag = YOUNGFOLK
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = ALL_PLAYER_RACES_BY_NAME

	allowed_ages = list(AGE_CHILD)

	tutorial = "One nite the Innkeeper took you in durring a harsh winter, you've been thankful ever since."

	outfit = /datum/outfit/job/roguetown/innkeep_son
	display_order = JDO_INNKEEP_CHILD
	give_bank_account = TRUE
	give_bank_account = 5
	min_pq = -5
	can_have_apprentices = FALSE
	cmode_music = 'sound/music/cmode/towner/CombatInn.ogg'

/datum/outfit/job/roguetown/innkeep_son/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.change_stat("endurance", 1)
		H.change_stat("strength", -1)
		H.change_stat("constitution", -1)
	pants = /obj/item/clothing/under/roguetown/tights/random
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	neck = /obj/item/storage/keyring/innkeep
	if(H.gender == MALE)
		cloak = /obj/item/clothing/cloak/apron/waist
	else
		armor = /obj/item/clothing/suit/roguetown/shirt/dress
