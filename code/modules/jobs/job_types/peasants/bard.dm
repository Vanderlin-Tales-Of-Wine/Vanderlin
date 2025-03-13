/datum/job/bard
	title = "Bard"
	tutorial = "Bards make up one of the largest populations of registered adventurers in Vanderlin, mostly because they are \
	the last ones in a party to die. Their wish is to experience the greatest adventures of the age and write amazing songs \
	about them. This is not your story, for you are the storyteller."
	faction = "Station"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar",
		"Half-Orc",
		"Rakshari"
	)
	outfit = /datum/outfit/job/bard
	flag = BARD
	department_flag = PEASANTS
	display_order = JDO_BARD
	total_positions = 4
	spawn_positions = 4

/datum/outfit/job/bard/pre_equip(mob/living/carbon/human/H)
	. = ..()
	H.mind?.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/music, 4, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind?.AddSpell(new /obj/effect/proc_holder/spell/invoked/mockery)
	head = /obj/item/clothing/head/bardhat
	shoes = /obj/item/clothing/shoes/boots
	pants = /obj/item/clothing/pants/tights/random
	shirt = /obj/item/clothing/shirt/tunic/noblecoat
	if(prob(30))
		gloves = /obj/item/clothing/gloves/fingerless
	belt = /obj/item/storage/belt/leather
	armor = /obj/item/clothing/armor/leather/vest
	cloak = /obj/item/clothing/cloak/raincloak/blue
	if(prob(50))
		cloak = /obj/item/clothing/cloak/raincloak/red
	backl = /obj/item/storage/backpack/satchel
	beltr = /obj/item/weapon/knife/dagger/steel/special
	beltl = /obj/item/storage/belt/pouch/coins/poor
	backpack_contents = list(/obj/item/flint)
	if(H.dna?.species?.id == "dwarf")
		H.cmode_music = 'sound/music/cmode/combat_dwarf.ogg'
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_BARDIC_TRAINING, TRAIT_GENERIC)
	H.change_stat(STATKEY_PER, 1)
	H.change_stat(STATKEY_SPD, 2)
	H.change_stat(STATKEY_STR, -1)

/datum/job/bard/after_spawn(mob/living/L, mob/M, latejoin)
	. = ..()
	if(ishuman(L)) //utter slop
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("bard_select")
		var/instruments = list(
			"Harp" = /obj/item/instrument/harp,
			"Lute" = /obj/item/instrument/lute,
			"Accordion" = /obj/item/instrument/accord,
			"Guitar" = /obj/item/instrument/guitar,
			"Flute" = /obj/item/instrument/flute,
			"Drum" = /obj/item/instrument/drum,
			"Hurdy-Gurdy" = /obj/item/instrument/hurdygurdy,
			"Viola" = /obj/item/instrument/viola)
		var/instrument_choice = input(M, "Choose your instrument.", "XYLIX") as anything in instruments
		var/spawn_instrument = instruments[instrument_choice]
		if(!spawn_instrument)
			spawn_instrument = /obj/item/instrument/lute
		H.equip_to_slot_or_del(new spawn_instrument(H),SLOT_BACK_R, TRUE)
		H.advsetup = 0
		H.invisibility = initial(H.invisibility)
		H.cure_blind("bard_select")
		var/atom/movable/screen/advsetup/GET_IT_OUT = locate() in H.hud_used?.static_inventory // dis line sux its basically a loop anyways if i remember
		qdel(GET_IT_OUT)
