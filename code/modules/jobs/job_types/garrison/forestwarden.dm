/datum/job/forestwarden
	title = "Forest Warden"
	flag = FORWARDEN
	department_flag = GARRISON
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	spells = list(/obj/effect/proc_holder/spell/self/convertrole/guard/forest_guard)
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
	)
	tutorial = "You were born in the forest. Alone, you've always felt home in the woods. In your tenure with the garrison, you've cleaved through the wildlife -\
	and for your service in the short-lived Goblin War, the king has granted you nobility. In turn, you've been entrusted to keep his lands clear of the foul\
	creechers that taint his land. Alone, you will die in these woods."
	display_order = JDO_FORWARDEN
	whitelist_req = FALSE
	bypass_lastclass = TRUE
	selection_color = "#0d6929"
	outfit = /datum/outfit/job/forestwarden
	give_bank_account = 45
	min_pq = 8
	cmode_music = 'sound/music/cmode/garrison/CombatForestGarrison.ogg'

/datum/outfit/job/forestwarden
	job_bitflag = BITFLAG_GARRISON

/datum/outfit/job/forestwarden/pre_equip(mob/living/carbon/human/H)
	..()
	cloak = /obj/item/clothing/cloak/raincloak/furcloak
	armor = /obj/item/clothing/armor/leather/splint
	shirt = /obj/item/clothing/armor/chainmail/iron
	pants = /obj/item/clothing/pants/trou/leather
	shoes = /obj/item/clothing/shoes/boots/furlinedboots
	wrists = /obj/item/clothing/wrists/bracers/leather
	head = /obj/item/clothing/head/helmet/kettle/slit
	gloves = /obj/item/clothing/gloves/leather
	neck = /obj/item/clothing/neck/bevor
	belt = /obj/item/storage/belt/leather
	beltl = /obj/item/weapon/axe/iron
	beltr = /obj/item/storage/belt/pouch/coins/rich
	backr = /obj/item/weapon/polearm/halberd/bardiche/woodcutter
	backl = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/weapon/knife/hunting = 1, /obj/item/rope/chain = 1, /obj/item/key/forrestgarrison = 1, /obj/item/signal_horn = 1)
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/lumberjacking, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/tanning, 2, TRUE)
		H.change_stat(STATKEY_STR, 3)
		H.change_stat(STATKEY_PER, 1)
		H.change_stat(STATKEY_INT, 3)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_SPD, 1)
	H.verbs |= /mob/proc/haltyell
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_FORAGER, TRAIT_GENERIC)
