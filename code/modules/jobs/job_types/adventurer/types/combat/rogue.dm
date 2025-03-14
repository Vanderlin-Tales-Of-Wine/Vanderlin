//Disabled
/datum/advclass/combat/rogue
	name = "Thief"
	tutorial = "A guildless thief, capable of breaking in and out of just about any secure location, and born to meet the sharp end of the guillotine. Just remember, murder is the mark of an amateur."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = ALL_PLAYER_RACES_BY_NAME
	outfit = /datum/outfit/job/adventurer/rogue
	min_pq = 5
	category_tags = list(CTAG_ADVENTURER)
	cmode_music = 'sound/music/cmode/adventurer/CombatRogue.ogg'
	pickprob = 0 // get fucked

/datum/outfit/job/adventurer/rogue/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, pick(0,0,1), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, pick(0,1,1), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE)
	shirt = /obj/item/clothing/shirt/undershirt/black
	gloves = /obj/item/clothing/gloves/fingerless
	pants = /obj/item/clothing/pants/trou/leather
	shoes = /obj/item/clothing/shoes/boots
	backl = /obj/item/storage/backpack/satchel
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/weapon/mace/cudgel // TEMP until I make a blackjack- for now though this will do.
	beltl = /obj/item/storage/belt/pouch/coins/poor
	backpack_contents = list(/obj/item/lockpick, /obj/item/weapon/knife/dagger/steel, /obj/item/clothing/face/shepherd/rag)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_LIGHT_STEP, TRAIT_GENERIC)
	H.change_stat(STATKEY_STR, -2)
	H.change_stat(STATKEY_PER, 2)
	H.change_stat(STATKEY_END, 1)
	H.change_stat(STATKEY_SPD, 2)
	H.grant_language(/datum/language/thievescant)
	to_chat(H, "<span class='info'>I can gesture in thieves' cant with ,t before my speech.</span>")

/datum/outfit/job/adventurer/rogue/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	var/list/thief_colors = list("Bleached White"	="#FFFFFF")
	thief_colors |= GLOB.peasant_dyes
	thief_colors |= GLOB.noble_dyes
	var/color_selection = input(H,"What color was I again?","Thief Color","Ash Grey") in thief_colors
	var/obj/item/clothing/cloak/raincloak/thiefcloak = new()
	thiefcloak.color = thief_colors[color_selection]
	H.equip_to_slot(thiefcloak, SLOT_CLOAK, TRUE)
