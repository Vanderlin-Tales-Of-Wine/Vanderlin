/datum/job/stonekeep/hand
	title = "Hand"
	flag = SK_HAND
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf"
	)
	allowed_sexes = list(MALE, FEMALE)
	outfit = /datum/outfit/job/stonekeep/hand
	display_order = HAND_ORDER
	tutorial = "You owe everything to your liege. You are the most trusted of the ruler- their sibling, in fact. You have played spymaster and confidant to the Noble-Family for so long that you are a vault of intrigue, something you exploit with potent conviction. Let no man ever forget whose ear you whisper into. Youve killed more men with those lips than any blademaster could ever claim to."
	bypass_lastclass = TRUE
	whitelist_req = FALSE
	give_bank_account = 120
	min_pq = 0
	cmode_music = 'sound/music/cmode/nobility/CombatSpymaster.ogg'

/datum/job/roguetown/hand/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	SSfamilytree.AddRoyal(L, FAMILY_OMMER)
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		addtimer(CALLBACK(src, PROC_REF(know_agents), H), 50)

/datum/job/roguetown/hand/proc/know_agents(mob/living/carbon/human/H)
	if(!GLOB.roundstart_court_agents.len)
		to_chat(H, span_notice("You begun the week with no agents."))
	else
		to_chat(H, span_notice("We begun the week with these agents:"))
		for(var/name in GLOB.roundstart_court_agents)
			to_chat(H, span_notice(name))
		H.mind.cached_frumentarii |= GLOB.roundstart_court_agents

/datum/outfit/job/stonekeep/hand/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/shirt/undershirt/fancy
	backr = /obj/item/storage/backpack/satchel/black
	armor = /obj/item/clothing/armor/leather/jacket/handjacket
	belt = /obj/item/storage/belt/leather/steel
	beltr = /obj/item/weapon/sword/rapier/dec
	shirt = /obj/item/clothing/shirt/undershirt/fancy
	backr = /obj/item/storage/backpack/satchel/black
	armor = /obj/item/clothing/armor/leather/jacket/hand
	pants = /obj/item/clothing/pants/tights/black
	shoes = /obj/item/clothing/shoes/nobleboot/thighboots
	backpack_contents = list(/obj/item/weapon/knife/dagger/steel = 1, /obj/item/storage/keyring/hand = 1, /obj/item/reagent_containers/glass/bottle/poison = 1, /obj/item/paper/scroll/frumentarii/roundstart = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/alchemy, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 4, TRUE)
		H.change_stat(STATKEY_PER, 3)
		H.change_stat(STATKEY_INT, 3)
	if(H.age == AGE_OLD)
		H.change_stat(STATKEY_SPD, -1)
		H.change_stat(STATKEY_STR, -1)
		H.change_stat(STATKEY_INT, 1)
		H.change_stat(STATKEY_PER, 1)

	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	H.verbs |= /mob/living/carbon/human/proc/torture_victim
