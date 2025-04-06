/datum/migrant_role/deprived
	name = "Deprived" // challenge run
	greet_text = "You were once a highwayman, a monster of the road - but you have since ditched your sinful ways, leaving society behind in wake of your regrets. Nothing erases the past, and you can find absolution only in the catharsis of death. Let the wildlife shepherd your soul to Necra."
	outfit = /datum/outfit/job/deprived
	grant_lit_torch = TRUE

/datum/outfit/job/deprived/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/menacing
	pants = /obj/item/clothing/pants/trou
	shoes = /obj/item/clothing/shoes/simpleshoes
	belt = /obj/item/storage/belt/leather/rope
	beltl = /obj/item/weapon/knife/villager // won't be able to light a torch without this, bare minimum

	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/tanning, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/fishing, 2, TRUE)
		H.change_stat(STATKEY_SPD, -2)
	ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC) // wouldn't include this normally, but due to heart-bleeding, it's required :/
	H.cmode_music = 'sound/music/cmode/towner/CombatPrisoner.ogg'

/datum/migrant_wave/deprived
	name = "The Deprived"
	max_spawns = 1
	shared_wave_type = /datum/migrant_wave/deprived
	weight = 8
	roles = list(
		/datum/migrant_role/deprived = 1,
	)
	greet_text = "Absolve yourself of sin, cast yourself away from society, and leave the travelers to their toils. Death and isolation grants you absolution."
