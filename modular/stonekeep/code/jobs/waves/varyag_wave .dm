/datum/migrant_role/sk/varyag
	name = "Varyag Raider"
	greet_text = "The Varyags are humen raiders, with a flat social structure where all are equal, but only if strong. Commonly go raiding and capturing slaves, notoriously untrustworthy as mercenaries, unless serving someone personally powerful, such as a  vampire lord. Most worship Graggar but few are very pious."
	allowed_sexes = list(MALE)
	allowed_races = list(
		"Humen"
	)
	outfit = /datum/outfit/job/sk_migration/varyag
	grant_lit_torch = TRUE


/datum/migrant_role/sk/varyag/after_spawn(mob/living/carbon/human/character)
	. = ..()
	character.forceMove(pick(GLOB.mountainevil_starts))

/datum/outfit/job/sk_migration/varyag/pre_equip(mob/living/carbon/human/H)
	..()
	belt = /obj/item/storage/belt/leather/rope/survival
	pants = /obj/item/clothing/pants/trou
	shoes = /obj/item/clothing/shoes/boots/furlinedboots

	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)

		H.change_stat(STATKEY_STR, 3)
		H.change_stat(STATKEY_END, 3)
		H.change_stat(STATKEY_CON, 3)
		ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
		H.mind?.AddSpell(new /obj/effect/proc_holder/spell/self/barbrage)
		H.set_patron(/datum/patron/inhumen/graggar)
		H.cmode_music = 'sound/music/cmode/unused/combat_barbarian.ogg'
	var/helmet2choose = pickweight(list("Horned" = 1, "Varyag" = 1))
	switch(helmet2choose)
		if("Horned")
			head = /obj/item/clothing/head/helmet/horned
			armor = /obj/item/clothing/armor/chainmail/iron
		if("Varyag")
			head = /obj/item/clothing/head/helmet/heavy/necked/varyag
			armor = /obj/item/clothing/armor/leather/hide

	var/gear2choose = pickweight(list("Shield" = 1, "Battleaxe" = 1))
	switch(gear2choose)
		if("Shield")
			backr = /obj/item/weapon/shield/wood
			beltr = /obj/item/weapon/axe/battle/ono
		if("Battleaxe")
			beltr = /obj/item/weapon/axe/battle
			wrists = /obj/item/clothing/wrists/bracers/leather



/datum/migrant_wave/varyag_raiders
	name = "The Varyag Raiders"
	max_spawns = 1
	shared_wave_type = list(/datum/migrant_wave/evil_knight,/datum/migrant_wave/varyag_raiders, /datum/migrant_wave/zizo_cult)
	weight = 20
	downgrade_wave = /datum/migrant_wave/varyag_raiders_down
	roles = list(
		/datum/migrant_role/sk/varyag = 4)
	greet_text = "Varyag Raiders appear! They may plunder, slave or sell their swords as mercenaries, who knows..."

/datum/migrant_wave/varyag_raiders_down
	name = "The Varyag Raiders"
	max_spawns = 1
	shared_wave_type = list(/datum/migrant_wave/evil_knight,/datum/migrant_wave/varyag_raiders, /datum/migrant_wave/zizo_cult)
	can_roll = FALSE
	downgrade_wave = /datum/migrant_wave/varyag_raiders_down_last
	roles = list(
		/datum/migrant_role/sk/varyag = 3)
	greet_text = "Varyag Raiders appear! They may plunder, slave or sell their swords as mercenaries, who knows..."


/datum/migrant_wave/varyag_raiders_down_last
	name = "The Varyag Raiders"
	max_spawns = 1
	shared_wave_type = list(/datum/migrant_wave/evil_knight,/datum/migrant_wave/varyag_raiders, /datum/migrant_wave/zizo_cult)
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/sk/varyag = 2)
	greet_text = "Varyag Raiders appear! They may plunder, slave or sell their swords as mercenaries, who knows..."



