/datum/advclass/pilgrim/stonekeep/briar
	name = "Briar"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf"
	)
	outfit = /datum/outfit/job/sk/pilgrim/briar
	category_tags = list(CTAG_PILGRIM)
	tutorial = "Stoic gardeners or flesh-eating predators, all can follow Dendors path. <br>His Briars scorn civilized living, many embracing their animal nature, being fickle and temperamental."
	allowed_patrons = list(/datum/patron/divine/dendor)
	cmode_music = 'sound/music/cmode/combat_dendor.ogg'
	maximum_possible_slots = 2

/datum/outfit/job/sk/pilgrim/briar/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_KNEESTINGER_IMMUNITY, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SEEDKNOW, TRAIT_GENERIC)

	belt = /obj/item/storage/belt/leather/rope
	mask = /obj/item/clothing/face/druid
	neck = /obj/item/clothing/neck/psycross/silver/dendor
	shirt = /obj/item/clothing/armor/leather/vest
	armor = /obj/item/clothing/shirt/robe/dendor
	wrists = /obj/item/clothing/wrists/bracers/leather
	beltl = /obj/item/weapon/knife/stone
	backl = /obj/item/weapon/mace/goden/shillelagh

	H.change_stat("strength", 1)
	H.change_stat("endurance", 1)
	H.change_stat("intelligence", -1)

	if(H.mind)
		if(H.patron != /datum/patron/divine/dendor)
			H.set_patron(/datum/patron/divine/dendor)

		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/magic/holy, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/taming, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/tanning, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/butchering, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/farming, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.teach_crafting_recipe(/datum/crafting_recipe/dendor/shillelagh)

		if(H.age == AGE_OLD)
			H.mind?.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)

		// the unique Dendor crafting recipes. Dendor shrines (pantheon cross) and alt cosmetic helmet
		H.mind.teach_crafting_recipe(/datum/crafting_recipe/dendor/visage)
		H.mind.teach_crafting_recipe(/datum/crafting_recipe/dendor/shrine)
		H.mind.teach_crafting_recipe(/datum/crafting_recipe/dendor/shrine/saiga)
		H.mind.teach_crafting_recipe(/datum/crafting_recipe/dendor/shrine/volf)
		H.mind.teach_crafting_recipe(/datum/crafting_recipe/dendor/sacrifice_growing)
		H.mind.teach_crafting_recipe(/datum/crafting_recipe/dendor/sacrifice_stinging)
		H.mind.teach_crafting_recipe(/datum/crafting_recipe/dendor/sacrifice_devouring)

	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(H, H.patron)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
	C.grant_spells(H)
	if((H.facial_hairstyle == "Wise Hermit") || (H.facial_hairstyle == "Knightly") || (H.facial_hairstyle == "Raider") || (H.facial_hairstyle == "Rumata") || (H.facial_hairstyle == "Choppe") || (H.facial_hairstyle == "Full Beard") || (H.facial_hairstyle == "Fullest Beard") || (H.facial_hairstyle == "Drinker") || (H.facial_hairstyle == "Knowledge") || (H.facial_hairstyle == "Brew") || (H.facial_hairstyle == "Ranger"))
		C.devotion += 40

/datum/outfit/job/sk/pilgrim/briar
	var/tutorial = "<br><br><font color='#44720e'><span class='bold'>You know well how to make a shrine to Dendor, wood, thorns, and the head of a favored animal.<br><br>Choose a path stinging, devouring or growing, and make your sacrifices...<br><br>Remember - Dendor will only grant special powers from Blessing the first time you do recieve it, and only those mastering all his Miracles can unlock their full potential.  </span></font><br><br>"

/datum/outfit/job/sk/pilgrim/briar/post_equip(mob/living/carbon/human/H)
	..()
	to_chat(H, tutorial)

