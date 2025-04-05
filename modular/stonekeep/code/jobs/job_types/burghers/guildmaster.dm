/datum/job/stonekeep/guildmaster
	title = "Guild Master"
	flag = SK_GUILDMASTER
	department_flag = SERFS
	total_positions = 1
	spawn_positions = 1

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list("Humen", "Half-Elf", "Dark Elf", "Elf", "Dwarf","Tiefling", "Aasimar", "Changeling","Skylancer")
	tutorial = "You've led a long life of adventuring, finally retiring to be a Guild Master. You help new adventurers find their feet, get a party, and veterans to hero--those belong to the men left rotting in the fields where you honed your ancient trade. You don't sleep well at night anymore, you don't like remembering what you've had to do to survive. Trading adventure for stable pay was the only logical solution, and maybe someday you'll get to lay down the blade and rest your weary body..."
	allowed_ages = list( AGE_MIDDLEAGED, AGE_OLD, AGE_IMMORTAL)
	display_order = GUILDMASTER_ORDER
	give_bank_account = 100
	can_have_apprentices = FALSE
	outfit = /datum/outfit/job/stonekeep/guildmaster
	cmode_music = 'sound/music/cmode/combat_hellish2.ogg'

/datum/outfit/job/stonekeep/guildmaster/pre_equip(mob/living/carbon/human/H)
	armor = /obj/item/clothing/shirt/tunic/red
	wrists = /obj/item/clothing/wrists/bracers/splint
	pants = /obj/item/clothing/pants/splintlegs
	shirt = /obj/item/clothing/armor/chainmail/iron
	shoes = /obj/item/clothing/shoes/boots
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/weapon/knife/dagger
	cloak = /obj/item/clothing/cloak/half/guildmaster
	belt = /obj/item/storage/belt/leather
	backr = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/key/adventurersguild = 1, /obj/item/reagent_containers/food/snacks/hardtack = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.change_stat("perception", 2)
		H.change_stat("intelligence", 2)
		H.change_stat("speed", -1)
		H.change_stat("strength", 1)
		H.mind.teach_crafting_recipe(/datum/crafting_recipe/adventurer_license)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)

/datum/crafting_recipe/adventurer_license
	name = "Produce a icense (Adventurer)"
	time = 4 SECONDS
	req_table = TRUE
	tools = /obj/item/natural/feather
	reqs = list(/obj/item/paper = 1)
	result = /obj/item/paper/certificate/adventurer
	category = CAT_NONE
