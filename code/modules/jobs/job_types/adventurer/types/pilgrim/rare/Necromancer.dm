/datum/advclass/pilgrim/rare/necromancer
	name = "Necromancer"
	tutorial = "From a young age you have been different, where others see death, you see the raw clay of creation. With every corpse you raise and every soul you shackle, you walk the path of Zizo, dreaming of the day you, too, will claim divinity."
	allowed_sexes = list(FEMALE)
	allowed_races = list(
	"Half-Elf",
	"Dark Elf"
	)

	outfit = /datum/outfit/job/adventurer/necromancer
	maximum_possible_slots = 2
	min_pq = 15
	category_tags = list(CTAG_PILGRIM)
	pickprob = 100
	displays_adv_job = FALSE

	cmode_music = 'sound/music/cmode/antag/CombatLich.ogg'

/datum/outfit/job/adventurer/necromancer/pre_equip(mob/living/carbon/human/H)
	..()
	H.mana_pool.set_intrinsic_recharge(MANA_ALL_LEYLINES)
	H.mind?.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/alchemy, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.ambushable = FALSE


	H.change_stat(STATKEY_STR, -1)
	H.change_stat(STATKEY_INT,  3)
	H.change_stat(STATKEY_CON,  -1)
	H.change_stat(STATKEY_END,  -1)
	H.change_stat(STATKEY_SPD,  1)

	H.mind.adjust_spellpoints(0)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/learnspell)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/strengthen_undead)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/raise_undead_lesser)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/eyebite)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/sickness)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/revoke_unlife)

	ADD_TRAIT(H, TRAIT_VILLAIN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
	H.faction = list(FACTION_UNDEAD)
	H.set_patron(/datum/patron/inhumen/zizo)

	H.become_blind("TRAIT_GENERIC")
	H.advjob = "Necromancer"
	// Necromancers being illegal have a variety of disguises to choose from.
	var/disguises = list("Beggar", "Sorceress", "Noble")
	var/disguisechoice = input("Choose your cover", "Available disguises") as anything in disguises

	if(disguisechoice)
		H.advjob = disguisechoice

	switch(disguisechoice)
		if("Beggar") //The sole "town" disguise available.
			H.job = "Beggar"
			belt = /obj/item/storage/belt/leather/rope
			backr = /obj/item/storage/backpack/satchel
			beltr = /obj/item/storage/magebag/apprentice
			r_hand = /obj/item/weapon/polearm/woodstaff
			backpack_contents = list(/obj/item/chalk = 1, /obj/item/reagent_containers/glass/bottle/manapot =1,/obj/item/weapon/knife/dagger/silver/arcyne = 1)
			armor = /obj/item/clothing/shirt/rags
		if("Sorceress")
			H.mind?.adjust_skillrank(/datum/skill/labor/fishing, 1, TRUE) //Have to know to play the part.
			shoes = /obj/item/clothing/shoes/simpleshoes
			armor = /obj/item/clothing/shirt/robe/mage
			belt = /obj/item/storage/belt/leather/rope
			backr = /obj/item/storage/backpack/satchel
			beltr = /obj/item/storage/magebag/apprentice
			r_hand = /obj/item/weapon/polearm/woodstaff
			backpack_contents = list(/obj/item/chalk = 1, /obj/item/reagent_containers/glass/bottle/manapot =1,/obj/item/weapon/knife/dagger/silver/arcyne = 1)
		if("Noble")
			var/prev_real_name = H.real_name
			var/prev_name = H.name
			var/honorary = "Lady"
			H.real_name = "[honorary] [prev_real_name]"
			H.name = "[honorary] [prev_name]"
			shoes = /obj/item/clothing/shoes/boots
			backl = /obj/item/storage/backpack/satchel
			neck = /obj/item/storage/belt/pouch/coins/poor //Spent all their money on expensive clothing.
			belt = /obj/item/storage/belt/leather/assassin
			id = /obj/item/clothing/ring/silver
			H.mind?.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, -1, TRUE)
			shirt = /obj/item/clothing/shirt/dress/silkdress/random
			head = /obj/item/clothing/head/hatfur
			cloak = /obj/item/clothing/cloak/raincloak/furcloak
			backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
			beltr = /obj/item/weapon/knife/dagger/steel/special
			beltl = /obj/item/ammo_holder/quiver/arrows
			backpack_contents = list(/obj/item/chalk = 1, /obj/item/reagent_containers/glass/bottle/manapot =1,/obj/item/weapon/knife/dagger/silver/arcyne = 1)
	H.cure_blind("TRAIT_GENERIC")
