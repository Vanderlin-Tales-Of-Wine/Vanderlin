/datum/job/rogue
	title = "Thief"
	flag = ADVENTURER
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 5
	spawn_positions = 5

	tutorial = "A wandering thief, capable of breaking in and out of just about any secure location, and born to meet the sharp end of the guillotine. Just remember, murder is the mark of an amateur."
	display_order = JDO_ROGUE
	bypass_lastclass = TRUE
	min_pq = 8
	shows_in_list = FALSE
	allowed_races = ALL_PLAYER_RACES_BY_NAME
	advclass_cat_rolls = list(CTAG_THIEF = 20)
	job_reopens_slots_on_death = FALSE

	wanderer_examine = TRUE


	outfit = /datum/outfit/job/rogue
	cmode_music = 'sound/music/cmode/adventurer/CombatRogue.ogg'

/datum/outfit/job/rogue
	shirt = /obj/item/clothing/shirt/undershirt/black
	pants = /obj/item/clothing/pants/trou/leather
	shoes = /obj/item/clothing/shoes/boots
	backr = /obj/item/storage/backpack/satchel
	belt = /obj/item/storage/belt/leather
	beltl = /obj/item/storage/belt/pouch/coins/poor

/datum/job/rogue/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

		if(GLOB.thieves_guild_doors.len > 0)
			var/obj/structure/mineral_door/secret/D = GLOB.thieves_guild_doors[1]
			to_chat(H, span_notice("The Thieves Guild Door Password is:\n'"+D.get_open_phrase()+"'"))


/datum/advclass/rogue/rogue
	name = "Rogue"
	tutorial = "Lorem Ipsum"
	outfit = /datum/outfit/job/rogue/rogueclassic
	category_tags = list(CTAG_THIEF)
	maximum_possible_slots = 3

/datum/outfit/job/rogue/rogueclassic/pre_equip(mob/living/carbon/human/H)
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
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE)
	gloves = /obj/item/clothing/gloves/fingerless
	beltr = /obj/item/weapon/mace/cudgel // TEMP until I make a blackjack- for now though this will do.
	backpack_contents = list(/obj/item/lockpick, /obj/item/weapon/knife/dagger/steel, /obj/item/clothing/face/shepherd/clothmask, /obj/item/key/thieves_guild)
	ADD_TRAIT(H, TRAIT_THIEVESGUILD, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_LIGHT_STEP, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	H.change_stat(STATKEY_STR, -2)
	H.change_stat(STATKEY_PER, 2)
	H.change_stat(STATKEY_END, 1)
	H.change_stat(STATKEY_SPD, 2)
	H.grant_language(/datum/language/thievescant)
	to_chat(H, "<span class='info'>I can gesture in thieves' cant with ,t before my speech.</span>")

/datum/outfit/job/rogue/rogueclassic/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(H)
		// Give them their cloak- as well as the ability to choose what color they want.
		var/obj/item/clothing/cloak/raincloak/thiefcloak = new()
		thiefcloak.color = get_thief_color(H)
		H.equip_to_slot(thiefcloak, SLOT_CLOAK, TRUE)

		var/obj/item/clothing/head/roguehood/thiefhood = new()
		thiefhood.color = thiefcloak.color
		H.equip_to_slot(thiefhood, SLOT_HEAD, TRUE)


/datum/advclass/rogue/ruffian
	name = "Ruffian"
	tutorial = "Lorem Ipsum"
	outfit = /datum/outfit/job/rogue/ruffian
	category_tags = list(CTAG_THIEF)
	maximum_possible_slots = 3

/datum/outfit/job/rogue/ruffian/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE)
	neck = /obj/item/clothing/neck/chaincoif/iron
	armor = /obj/item/clothing/armor/chainmail/iron
	gloves = /obj/item/clothing/gloves/angle
	beltr = /obj/item/weapon/mace/steel/morningstar
	backpack_contents = list(/obj/item/weapon/knife/dagger/steel, /obj/item/clothing/face/shepherd/clothmask, /obj/item/key/thieves_guild)

	ADD_TRAIT(H, TRAIT_THIEVESGUILD, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_LIGHT_STEP, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	H.change_stat(STATKEY_STR, 2)
	H.change_stat(STATKEY_PER, 1)
	H.change_stat(STATKEY_CON, 1)
	H.change_stat(STATKEY_END, 1)
	H.grant_language(/datum/language/thievescant)
	to_chat(H, "<span class='info'>I can gesture in thieves' cant with ,t before my speech.</span>")

/datum/outfit/job/rogue/ruffian/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(H)
		var/obj/item/clothing/cloak/raincloak/thiefcloak = new()
		thiefcloak.color = get_thief_color(H)
		H.equip_to_slot(thiefcloak, SLOT_CLOAK, TRUE)

		var/obj/item/clothing/head/roguehood/thiefhood = new()
		thiefhood.color = thiefcloak.color
		H.equip_to_slot(thiefhood, SLOT_HEAD, TRUE)


/datum/advclass/rogue/cutthroat
	name = "Cutthroat"
	tutorial = "Lorem Ipsum"
	outfit = /datum/outfit/job/rogue/cutthroat
	category_tags = list(CTAG_THIEF)
	maximum_possible_slots = 1

/datum/outfit/job/rogue/cutthroat/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/alchemy, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
	gloves = /obj/item/clothing/gloves/leather/black
	beltr = /obj/item/weapon/mace/cudgel // TEMP until I make a blackjack- for now though this will do.
	backl = /obj/item/storage/backpack/satchel/surgbag
	backpack_contents = list(/obj/item/natural/cloth = 2, /obj/item/weapon/knife/dagger/steel, /obj/item/clothing/face/shepherd/clothmask, /obj/item/key/thieves_guild)

	ADD_TRAIT(H, TRAIT_THIEVESGUILD, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_LIGHT_STEP, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)
	H.change_stat(STATKEY_INT, 3)
	H.change_stat(STATKEY_STR, -1)
	H.change_stat(STATKEY_PER, 1)
	if(H.age == AGE_OLD)
		H.change_stat("speed", -1)
		H.change_stat("intelligence", 1)
		H.change_stat("perception", 1)
	H.grant_language(/datum/language/thievescant)
	to_chat(H, "<span class='info'>I can gesture in thieves' cant with ,t before my speech.</span>")

/datum/outfit/job/rogue/cutthroat/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(H)
		var/obj/item/clothing/cloak/raincloak/thiefcloak = new()
		thiefcloak.color = get_thief_color(H)
		H.equip_to_slot(thiefcloak, SLOT_CLOAK, TRUE)

		var/obj/item/clothing/head/roguehood/thiefhood = new()
		thiefhood.color = thiefcloak.color
		H.equip_to_slot(thiefhood, SLOT_HEAD, TRUE)

		var/obj/item/clothing/armor/leather/vest/thiefvest = new()
		thiefvest.color = thiefcloak.color
		H.equip_to_slot(thiefvest, SLOT_ARMOR, TRUE)


/proc/get_thief_color(mob/living/carbon/human/H)
	var/list/thief_colors = list(\
	// Red Colors
	"Fyritius Dye"	="#b47011",\
	"Winestain Red"	="#6b3737",\
	"Maroon"		="#672c0d",\
	"Blood Red"		="#770d0d",\
	// Green Colors
	"Forest Green"	="#3f8b24",\
	"Bog Green"		="#58793f",\
	"Spring Green"	="#435436",\
	// Blue Colors
	"Royal Teal"	="#249589",\
	"Mana Blue"		="#1b3c7a",\
	"Berry"			="#38455b",\
	"Lavender"		="#865c9c",\
	"Majenta"		="#822b52",\
	// Brown Colors
	"Bark Brown"	="#685542",\
	"Russet"		="#685542",\
	"Chestnut"		="#5f3d21",\
	"Old Leather"	="#473a30",\
	"Ashen Black"	="#2f352f",\
	)
	var/color_selection = input(H,"What color was I again?","Thief Color","Ashen Black") in thief_colors
	return thief_colors[color_selection]

