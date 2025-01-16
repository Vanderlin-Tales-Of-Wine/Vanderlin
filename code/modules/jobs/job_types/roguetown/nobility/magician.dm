/datum/job/roguetown/magician
	title = "Court Magician"
	flag = WIZARD
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Aasimar"
	)
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD, AGE_IMMORTAL)
	allowed_sexes = list(MALE, FEMALE)
	display_order = JDO_MAGICIAN
	tutorial = "Dream interpreter, soothsayer, astrologer and valued courtier. A scholar of Noc, or a secret worshipper of Zizo. \
	Indebted to the ruler for funding yils of mystical studies in these dark times, \
	only wisdom and arcane knowledge amassed during a long life will allow a mage to unlock their full potential."
	outfit = /datum/outfit/job/roguetown/magician
	whitelist_req = FALSE
	bypass_lastclass = TRUE
	give_bank_account = 120
	min_pq = 6
	cmode_music = 'sound/music/cmode/nobility/CombatCourtMagician.ogg'

/datum/outfit/job/roguetown/magician/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/wizhat/gen
	backr = /obj/item/storage/backpack/rogue/satchel
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/black
	cloak = /obj/item/clothing/cloak/black_cloak
	id = /obj/item/clothing/ring/gold
	belt = /obj/item/storage/belt/rogue/leather/plaquesilver
	beltr = /obj/item/storage/keyring/mage
	backl = /obj/item/rogueweapon/polearm/woodstaff
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	backpack_contents = list(/obj/item/scrying = 1, /obj/item/reagent_containers/glass/bottle/rogue/killersice = 1)
	if(H.mind)
		if(!(H.patron == /datum/patron/divine/noc || /datum/patron/inhumen/zizo))
			H.set_patron(/datum/patron/divine/noc)

		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/magic/arcane, pick(6,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/alchemy, 5, TRUE)
		if(H.age == AGE_OLD)
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/courtmage
			H.change_stat("speed", -1)
			H.change_stat("intelligence", 1)
			if(H.dna.species.id == "human")
				belt = /obj/item/storage/belt/rogue/leather/plaquegold
				cloak = null
				head = /obj/item/clothing/head/roguetown/wizhat
				if(H.gender == FEMALE)
					armor = /obj/item/clothing/suit/roguetown/shirt/robe/courtmage
				if(H.gender == MALE)
					armor = /obj/item/clothing/suit/roguetown/shirt/robe/wizard
					H.dna.species.soundpack_m = new /datum/voicepack/male/wizard()
		ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_LEGENDARY_ALCHEMIST, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
		H.virginity = TRUE
		H.change_stat("strength", -2)
		H.change_stat("intelligence", 5)
		H.change_stat("constitution", -2)
		H.change_stat("speed", -2)
		H.mind.adjust_spellpoints(8)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/aoe_turf/knock)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/ethereal_jaunt)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/learnspell)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)

//............... Unique Court Mage Stuff ...........................
/*
/obj/item/clothing/head/roguetown/wizhat/equipped(mob/living/user, slot)
	. = ..()
	if(user.mind && user.mind.assigned_role == "Court Magician")
		if(slot == SLOT_HEAD && istype(user))
			user.apply_status_effect(/datum/status_effect/buff/thinking_cap)
		else
			user.remove_status_effect(/datum/status_effect/buff/thinking_cap)
	else return

/obj/item/clothing/head/roguetown/wizhat/dropped(mob/living/user, slot)
	. = ..()
	user.remove_status_effect(/datum/status_effect/buff/thinking_cap)


/datum/status_effect/buff/thinking_cap
	id = "thinkingcap"
	alert_type = /atom/movable/screen/alert/status_effect/buff/thinking_cap
	effectedstats = list("intelligence" = 2)
	duration = 240 MINUTES

/datum/status_effect/buff/thinking_cap/on_apply()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.remove_stress(/datum/stressevent/wheresmyhat)

/datum/status_effect/buff/thinking_cap/on_remove()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_stress(/datum/stressevent/wheresmyhat)

/datum/stressevent/wheresmyhat
	timer = 0
	stressadd = 1
	desc = "<span class='red'>I miss my hat....</span>"

/atom/movable/screen/alert/status_effect/buff/thinking_cap
	name = "My mind is clear"
	desc = "<span class='nicegreen'>My hat deflects mind-clouding rays of Zizo...</span>\n"
	icon = 'icons/mob/actions/roguespells.dmi'
	icon_state = ""
*/
