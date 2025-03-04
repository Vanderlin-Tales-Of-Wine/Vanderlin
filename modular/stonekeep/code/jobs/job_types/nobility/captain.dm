/datum/job/roguetown/captain
	title = "Captain"
	flag = CAPTAIN
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	spells = list(/obj/effect/proc_holder/spell/self/convertrole/guard)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf"
	)
	allowed_sexes = list(MALE, FEMALE)
	display_order = JDO_CAPTAIN
	tutorial = "Law and Order, your divine reason for existence. You have been given command over the garrison to help keep order and peace within the city and defend it against the many dangers of the island."
	whitelist_req = FALSE
	bypass_lastclass = TRUE
	outfit = /datum/outfit/job/roguetown/captain
	give_bank_account = 120
	min_pq = 0

	cmode_music = 'sound/music/cmode/antag/CombatSausageMaker.ogg'

/datum/job/roguetown/captain/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		var/honorary = "Sir"
		if(H.gender == FEMALE)
			honorary = "Dame"
		H.real_name = "[honorary] [prev_real_name]"
		H.name = "[honorary] [prev_name]"

/datum/outfit/job/roguetown/captain/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/helmet/visored/captain
	gloves = /obj/item/clothing/gloves/plate
	pants = /obj/item/clothing/pants/platelegs/captain
	armor = /obj/item/clothing/armor/captain
	neck = /obj/item/clothing/neck/gorget
	shirt = /obj/item/clothing/shirt/undershirt/guard
	shoes = /obj/item/clothing/shoes/boots
	backr = /obj/item/storage/backpack/satchel
	backl = /obj/item/weapon/shield/tower/metal
	belt = /obj/item/storage/belt/leather/plaquesilver
	beltl = /obj/item/weapon/sword/sabre
	beltr = /obj/item/weapon/mace/cudgel
	cloak = /obj/item/clothing/cloak/captain
	backpack_contents = list(/obj/item/storage/keyring/captain = 1, /obj/item/signal_horn = 1)
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.change_stat("strength", 3)
		H.change_stat("perception", 2)
		H.change_stat("intelligence", 1)
		H.change_stat("constitution", 1)
		H.change_stat("endurance", 2)
		H.change_stat("speed", 1)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
	H.verbs |= /mob/proc/haltyell

/obj/effect/proc_holder/spell/self/convertrole
	name = "Recruit Beggar"
	desc = "Recruit someone to your cause."
	overlay_state = "recruit_bog"
	antimagic_allowed = TRUE
	charge_max = 100
