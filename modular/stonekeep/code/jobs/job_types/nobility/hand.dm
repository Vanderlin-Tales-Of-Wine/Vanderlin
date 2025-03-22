/datum/job/stonekeep/hand
	title = "Hand"
	flag = SK_HAND
	department_flag = NOBLEMEN
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
	tutorial = "Advisor, spymaster, confidante, your ties with the ruler are deep and personal."
	advclass_cat_rolls = list(CTAG_SKHAND = 20)
	give_bank_account = 120
	cmode_music = 'sound/music/cmode/nobility/CombatSpymaster.ogg'

/datum/job/stonekeep/hand/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	SSfamilytree.AddRoyal(L, FAMILY_OMMER)
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		addtimer(CALLBACK(src, PROC_REF(know_agents), H), 50)
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

/datum/job/stonekeep/hand/proc/know_agents(mob/living/carbon/human/H)
	if(!GLOB.roundstart_court_agents.len)
		to_chat(H, span_notice("You begun the week with no agents."))
	else
		to_chat(H, span_notice("We begun the week with these agents:"))
		for(var/name in GLOB.roundstart_court_agents)
			to_chat(H, span_notice(name))
		H.mind.cached_frumentarii |= GLOB.roundstart_court_agents

/datum/outfit/job/stonekeep/hand/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/shirt/undershirt/fancy
	backr = /obj/item/storage/backpack/satchel
	shoes = /obj/item/clothing/shoes/nobleboot/thighboots
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
		H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 3, TRUE)
		H.change_stat(STATKEY_PER, 3)
		H.change_stat(STATKEY_INT, 3)
	if(H.age == AGE_OLD)
		H.change_stat(STATKEY_SPD, -1)
		H.change_stat(STATKEY_STR, -1)
		H.change_stat(STATKEY_INT, 1)
		H.change_stat(STATKEY_PER, 1)
	if(H.gender == FEMALE)
		H.change_stat(STATKEY_STR, -1)
		H.change_stat(STATKEY_PER, 1)

	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	H.verbs |= /mob/living/carbon/human/proc/torture_victim

/datum/advclass/sk/hand/spymaster	// flexible poison/offensive
	name = "Spymaster"
	tutorial = "A nose for intrigue, rd, axe, or mace in the other hand."
	outfit = /datum/outfit/job/stonekeep/hand_spymaster

	category_tags = list(CTAG_SKHAND)

/datum/outfit/job/stonekeep/hand_spymaster/pre_equip(mob/living/carbon/human/H)
	..()
	beltr = /obj/item/weapon/sword/sabre/dec
	armor = /obj/item/clothing/armor/leather/jacket/hand
	belt = /obj/item/storage/belt/leather/steel
	beltl = /obj/item/storage/keyring/hand
	backpack_contents = list(/obj/item/natural/cloth = 1, /obj/item/lockpickring/mundane = 1, /obj/item/reagent_containers/glass/bottle/poison = 1, /obj/item/paper/scroll/frumentarii = 1)
	if(H.gender == MALE)
		pants = /obj/item/clothing/pants/tights/black
	else
		shirt = /obj/item/clothing/shirt/robe/elegantgown

	H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)

/datum/advclass/sk/hand/consort	// medical support focus
	name = "Consort"
	tutorial = "You are related to the Monarch, by marriage or by blood."
	outfit = /datum/outfit/job/stonekeep/hand_consort

	category_tags = list(CTAG_SKHAND)

/datum/outfit/job/stonekeep/hand_consort/pre_equip(mob/living/carbon/human/H)
	..()
	belt = /obj/item/storage/belt/leather
	beltl = /obj/item/storage/keyring/hand
	beltr = /obj/item/weapon/knife/dagger/steel

	if(H.gender == MALE)
		armor = /obj/item/clothing/shirt/tunic/noblecoat
		pants = /obj/item/clothing/pants/tights/black
	else
		backpack_contents = list(/obj/item/needle = 1, /obj/item/natural/cloth = 1, /obj/item/lockpickring/mundane = 1, /obj/item/reagent_containers/glass/bottle/antidote = 1, /obj/item/reagent_containers/glass/bottle/healthpot = 1, /obj/item/paper/scroll/frumentarii = 1)
		armor = /obj/item/clothing/shirt/dress/velvetdress/sleeveless

