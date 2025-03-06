/datum/job/roguetown/sheriff
	title = "Sheriff"
	flag = SK_SHERIFF
	department_flag = GARRISON
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	spells = list(/obj/effect/proc_holder/spell/self/convertrole/guard)
	allowed_races = list(
		"Humen",
		"Elf",
		"Dwarf"
	)
	allowed_sexes = list(MALE, FEMALE)
	display_order = SHERIFF_ORDER
	tutorial = "Law and Order, your divine reason for existence. You have been given command over the garrison to help keep order and peace within the Lords demesne and defend it against the many dangers of the land."
	whitelist_req = FALSE
	bypass_lastclass = TRUE
	outfit = /datum/outfit/job/sheriff
	give_bank_account = 120
	min_pq = 0

	cmode_music = 'sound/music/cmode/antag/CombatSausageMaker.ogg'

/datum/job/roguetown/sheriff/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
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

/datum/outfit/job/sheriff/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/helmet/bascinet
	gloves = /obj/item/clothing/gloves/plate
	pants = /obj/item/clothing/pants/platelegs/captain
	armor = /obj/item/clothing/armor/brigandine/sheriff
	neck = /obj/item/clothing/neck/bevor
	shirt = /obj/item/clothing/shirt/undershirt/guard
	shoes = /obj/item/clothing/shoes/boots/leather/heavy
	backr = /obj/item/storage/backpack/satchel
	belt = /obj/item/storage/belt/leather/black
	beltl = /obj/item/flashlight/flare/torch/lantern
	beltr = /obj/item/weapon/mace/steel
	cloak = /obj/item/clothing/cloak/captain
	r_hand = /obj/item/weapon/polearm/eaglebeak/lucerne/poleaxe

	backpack_contents = list(/obj/item/storage/keyring/captain = 1, /obj/item/signal_horn = 1, /obj/item/weapon/knife/dagger/steel = 1, /obj/item/natural/feather = 1)
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
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
