/datum/advclass/roguemage //mage class - like the adventurer mage, but more evil.
	name = "Rogue Mage"
	tutorial = "Cast aside by your masters for unholy experimentation, you lived for a time in hiding in the forest where you eventually met the unsavory followers of Matthios who took you in as family, one of their own. Amongst your brigand friends you now have opportunity to attain the wealth and power necessary for your to rise above those who once looked down on you."
	allowed_sexes = list(MALE, FEMALE)
	outfit = /datum/outfit/job/bandit/roguemage
	category_tags = list(CTAG_BANDIT)
	cmode_music = 'sound/music/cmode/antag/combat_bandit_mage.ogg'

/datum/outfit/job/bandit/roguemage/pre_equip(mob/living/carbon/human/H)
	..()
	H.mana_pool?.set_intrinsic_recharge(MANA_ALL_LEYLINES)
	shoes = /obj/item/clothing/shoes/simpleshoes
	pants = /obj/item/clothing/pants/trou/leather
	shirt = /obj/item/clothing/shirt/shortshirt
	armor = /obj/item/clothing/shirt/robe/black
	belt = /obj/item/storage/belt/leather/rope
	beltr = /obj/item/reagent_containers/glass/bottle/manapot
	backr = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/needle/thorn = 1, /obj/item/natural/cloth = 1, /obj/item/book/granter/spellbook/apprentice = 1)
	mask = /obj/item/clothing/face/facemask/steel //idk if this makes it so they cant cast but i want all of the bandits to have the same mask
	neck = /obj/item/clothing/neck/coif
	head = /obj/item/clothing/head/helmet/leather/volfhelm

	r_hand = /obj/item/weapon/polearm/woodstaff
	if(H.mind)
		H.mind.special_role = "Bandit"
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE) //needs climbing to get into hideout
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/alchemy, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
		if(H.age == AGE_OLD)
			head = /obj/item/clothing/head/wizhat/gen
			armor = /obj/item/clothing/shirt/robe
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
			H.change_stat(STATKEY_SPD, -1)
			H.change_stat(STATKEY_INT, 1)
			H.change_stat(STATKEY_PER, 1)
			H.mind.adjust_spellpoints(1)
		H.change_stat(STATKEY_STR, -1)
		H.change_stat(STATKEY_INT, 3)
		H.change_stat(STATKEY_CON, 1)
		H.change_stat(STATKEY_END, -1)
		H.mind.adjust_spellpoints(6)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/acidsplash5e)
