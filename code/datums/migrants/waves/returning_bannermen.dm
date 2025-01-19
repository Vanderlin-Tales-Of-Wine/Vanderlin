/datum/migrant_role/sergeant_at_arms
	name = "Serjeant at arms"
	greet_text = "You were apart of an expedition sent by the King of Vanderlin to Kingsfield, you and the mens under your command have returned upon fullfiling your task."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Dwarf",
		"Aasimar",
		"Half-Elf",
		"Elf")
	grant_lit_torch = TRUE
	show_wanderer_examine = FALSE
	outfit = /datum/outfit/job/roguetown/serjeant_at_arms

/datum/outfit/job/roguetown/serjeant_at_arms/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/leather
	pants = /obj/item/clothing/under/roguetown/trou/leather
	cloak = /obj/item/clothing/cloak/half/vet
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/guardsecond
	armor = /obj/item/clothing/suit/roguetown/armor/medium/scale
	neck = /obj/item/clothing/neck/roguetown/gorget
	shoes = /obj/item/clothing/shoes/roguetown/boots
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/sword/arming
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/rogueweapon/knife/dagger/steel/special = 1, /obj/item/signal_horn = 1)
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
	if(H.age == AGE_OLD)
		H.change_stat("strength", 3)
		H.change_stat("perception", 1)
		H.change_stat("intelligence", 2)
		H.change_stat("endurance", 2)
		H.change_stat("speed", 1)
	else
		H.change_stat("strength", 2)
		H.change_stat("intelligence", 2)
		H.change_stat("endurance", 2)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/cmode/garrison/CombatGarrison.ogg'

/datum/migrant_role/archer_bannerman
	name = "Bannermen Archer"
	greet_text = "You were apart of an expedition sent by the King of Vanderlin to Kingsfield, you and your serjeant-at-arms have returned upon fullfiling your task."
	outfit = /datum/outfit/job/roguetown/archer_bannerman
	allowed_races = list("Humen",
		"Dwarf",
		"Aasimar",
		"Half-Elf",
		"Elf")
	grant_lit_torch = TRUE
	show_wanderer_examine = FALSE
/datum/outfit/job/roguetown/archer_bannerman/pre_equip(mob/living/carbon/human/H)
	..()
	pants = /obj/item/clothing/under/roguetown/trou/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/merc
	cloak = /obj/item/clothing/cloak/stabard/guard
	shoes = /obj/item/clothing/shoes/roguetown/boots
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/storage/keyring/guard
	beltr = /obj/item/ammo_holder/quiver/arrows
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	backpack_contents = list(/obj/item/rogueweapon/knife/dagger/steel/special = 1)
	if(prob(30))
		head = /obj/item/clothing/head/roguetown/helmet/kettle
	else
		head = /obj/item/clothing/head/roguetown/roguehood/red

	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
		H.change_stat("intelligence", 1)
		H.change_stat("perception", 2)
		H.change_stat("endurance", 1)
		H.change_stat("speed", 2)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/cmode/garrison/CombatGarrison.ogg'

/datum/migrant_role/crossbow_bannerman
	name = "Bannermen Crossboman"
	greet_text = "You were apart of an expedition sent by the King of Vanderlin to Kingsfield, you and your serjeant-at-arms have returned upon fullfiling your task."
	outfit = /datum/outfit/job/roguetown/crossbow_bannerman
	allowed_races = list("Humen","Dwarf","Aasimar", "Half-Elf", "Elf")
	grant_lit_torch = TRUE
	show_wanderer_examine = FALSE

/datum/outfit/job/roguetown/crossbow_bannerman/pre_equip(mob/living/carbon/human/H)
	..()
	pants = /obj/item/clothing/under/roguetown/trou/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/merc
	cloak = /obj/item/clothing/cloak/stabard/guard
	shoes = /obj/item/clothing/shoes/roguetown/boots
	belt = /obj/item/storage/belt/rogue/leather
	pants = /obj/item/clothing/under/roguetown/trou/leather
	beltl = /obj/item/storage/keyring/guard
	beltr = /obj/item/ammo_holder/quiver/bolts
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	backpack_contents = list(/obj/item/rogueweapon/knife/dagger/steel/special = 1)
	if(prob(30))
		head = /obj/item/clothing/head/roguetown/helmet/kettle
	else
		head = /obj/item/clothing/head/roguetown/roguehood/red

	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
		H.change_stat("intelligence", 1)
		H.change_stat("perception", 2)
		H.change_stat("endurance", 1)
		H.change_stat("speed", 2)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/cmode/garrison/CombatGarrison.ogg'

/datum/migrant_role/footman_bannerman
	name = "Bannermen Footman"
	greet_text = "You were apart of an expedition sent by the King of Vanderlin to Kingsfield, you and your serjeant-at-arms have returned upon fullfiling your task."
	outfit = /datum/outfit/job/roguetown/footman_bannerman
	allowed_races = list("Humen","Dwarf","Aasimar","Half-Elf","Elf")
	grant_lit_torch = TRUE
	show_wanderer_examine = FALSE

/datum/outfit/job/roguetown/footman_bannerman/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/suit/roguetown/armor/cuirass
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	neck = /obj/item/clothing/neck/roguetown/gorget
	head = /obj/item/clothing/head/roguetown/helmet/nasal
	backr = /obj/item/rogueweapon/shield/wood
	beltr = /obj/item/rogueweapon/sword/scimitar/messer
	beltl = /obj/item/rogueweapon/mace
	pants = /obj/item/clothing/under/roguetown/trou/leather
	cloak = /obj/item/clothing/cloak/stabard/guard
	shoes = /obj/item/clothing/shoes/roguetown/boots
	belt = /obj/item/storage/belt/rogue/leather
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("endurance", 2)
		H.change_stat("constitution", 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/cmode/garrison/CombatGarrison.ogg'
	H.verbs |= /mob/proc/haltyell

/datum/migrant_role/pikeman_bannerman
	name = "Bannermen Pikeman"
	greet_text = "You were apart of an expedition sent by the King of Vanderlin to Kingsfield, you and your serjeant-at-arms have returned upon fullfiling your task."
	outfit = /datum/outfit/job/roguetown/pikeman_bannerman
	allowed_races = list("Humen","Dwarf","Aasimar","Half-Elf","Elf")
	grant_lit_torch = TRUE
	show_wanderer_examine = FALSE

/datum/outfit/job/roguetown/pikeman_bannerman/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	neck = /obj/item/clothing/neck/roguetown/gorget
	head = /obj/item/clothing/head/roguetown/helmet/kettle
	beltr = /obj/item/rogueweapon/sword/scimitar/messer
	pants = /obj/item/clothing/under/roguetown/trou/leather
	cloak = /obj/item/clothing/cloak/stabard/guard
	shoes = /obj/item/clothing/shoes/roguetown/boots
	belt = /obj/item/storage/belt/rogue/leather

	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("endurance", 1)
		H.change_stat("constitution", 1)
		H.change_stat("speed", -1)
		H.verbs |= /mob/proc/haltyell
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)

	var/weapontype = pickweight(list("Spear" = 6, "Bardiche" = 4))
	switch(weapontype)
		if("Spear")
			backr = /obj/item/rogueweapon/polearm/spear
		if("Bardiche")
			backr = /obj/item/rogueweapon/polearm/halberd/bardiche

/datum/migrant_wave/returning_bannermen
	name = "The Bannermen's return"
	max_spawns = 2
	shared_wave_type = /datum/migrant_wave/knight
	downgrade_wave = /datum/migrant_wave/returning_bannermen_down
	weight = 40
	roles = list(
		/datum/migrant_role/sergeant_at_arms = 1,
		/datum/migrant_role/footman_bannerman = 2,
		/datum/migrant_role/pikeman_bannerman = 2,
		/datum/migrant_role/archer_bannerman = 1,
		/datum/migrant_role/crossbow_bannerman = 1
	)
	greet_text = "You were apart of an expedition sent by the King of Vanderlin to Kingsfield, as it is done, you now return."

/datum/migrant_wave/returning_bannermen_down
	name = "The Bannermen's return"
	shared_wave_type = /datum/migrant_wave/returning_bannermen
	downgrade_wave = /datum/migrant_wave/returning_bannermen_down_one
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/sergeant_at_arms = 1,
		/datum/migrant_role/footman_bannerman = 1,
		/datum/migrant_role/pikeman_bannerman = 1,
		/datum/migrant_role/archer_bannerman = 1,
		/datum/migrant_role/crossbow_bannerman = 1
	)
	greet_text = "You were apart of an expedition sent by the King of Vanderlin to Kingsfield, as it is done, you now return."

/datum/migrant_wave/returning_bannermen_down_one
	name = "The Bannermen's return"
	shared_wave_type = /datum/migrant_wave/returning_bannermen
	downgrade_wave = /datum/migrant_wave/returning_bannermen_down_two
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/sergeant_at_arms = 1,
		/datum/migrant_role/footman_bannerman = 1,
		/datum/migrant_role/pikeman_bannerman = 1,
		/datum/migrant_role/archer_bannerman = 1,
	)
	greet_text = "You were apart of an expedition sent by the King of Vanderlin to Kingsfield, as it is done, you now return."

/datum/migrant_wave/returning_bannermen_down_two
	name = "The Bannermen's return"
	shared_wave_type = /datum/migrant_wave/returning_bannermen
	downgrade_wave = /datum/migrant_wave/returning_bannermen_down_three
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/sergeant_at_arms = 1,
		/datum/migrant_role/footman_bannerman = 1,
		/datum/migrant_role/pikeman_bannerman = 1,
	)
	greet_text = "You were apart of an expedition sent by the King of Vanderlin to Kingsfield, as it is done, you now return."

/datum/migrant_wave/returning_bannermen_down_three
	name = "The Bannermen's return"
	shared_wave_type = /datum/migrant_wave/returning_bannermen
	downgrade_wave = /datum/migrant_wave/returning_bannermen_down_four
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/sergeant_at_arms = 1,
		/datum/migrant_role/footman_bannerman = 1,
	)
	greet_text = "You were apart of an expedition sent by the King of Vanderlin to Kingsfield, as it is done, you now return."

/datum/migrant_wave/returning_bannermen_down_four
	name = "The Bannermen's return"
	shared_wave_type = /datum/migrant_wave/returning_bannermen
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/sergeant_at_arms = 1,
	)
	greet_text = "You were apart of an expedition sent by the King to Kingsfield, as it is done, you now return."

