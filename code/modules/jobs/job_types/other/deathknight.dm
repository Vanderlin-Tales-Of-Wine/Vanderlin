/datum/job/skeleton/knight
	title = "Death Knight"
	flag = DEATHKNIGHT

	outfit = /datum/outfit/job/deathknight
	cmode_music = 'sound/music/cmode/combat_weird.ogg'

/datum/job/skeleton/knight/after_spawn(mob/living/carbon/spawned, client/player_client)
	SSmapping.find_and_remove_world_trait(/datum/world_trait/death_knight)
	SSmapping.retainer.death_knights |= spawned.mind
	..()
	spawned.name = "Death Knight"
	spawned.real_name = "Death Knight"

	ADD_TRAIT(spawned, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(spawned, TRAIT_CRITICAL_WEAKNESS, TRAIT_GENERIC)

/datum/outfit/job/deathknight/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)


	belt = /obj/item/storage/belt/leather
	pants = /obj/item/clothing/pants/platelegs/blk/death
	shoes = /obj/item/clothing/shoes/boots/armor/blkknight
	shirt = /obj/item/clothing/shirt/undershirt/black
	armor = /obj/item/clothing/armor/plate/blkknight/death
	gloves = /obj/item/clothing/gloves/plate/blk/death
	backl = /obj/item/weapon/sword/long/death
	head = /obj/item/clothing/head/helmet/visored/knight/black

	H.change_stat(STATKEY_INT, 3)
	H.change_stat(STATKEY_STR, 2)
	H.change_stat(STATKEY_END, 2)
	H.change_stat(STATKEY_CON, 2)
	H.change_stat(STATKEY_SPD, -3)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/lightningbolt)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fetch)

	var/datum/antagonist/new_antag = new /datum/antagonist/skeleton/knight()
	H.mind.add_antag_datum(new_antag)

/obj/item/clothing/armor/plate/blkknight/death
	color = CLOTHING_SOOT_BLACK

/obj/item/clothing/shoes/boots/armor/blkknight/death
	color = CLOTHING_SOOT_BLACK

/obj/item/clothing/gloves/plate/blk/death
	color = CLOTHING_SOOT_BLACK

/obj/item/clothing/pants/platelegs/blk/death
	color = CLOTHING_SOOT_BLACK
