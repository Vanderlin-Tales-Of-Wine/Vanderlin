/datum/skill/craft
	abstract_type = /datum/skill/craft
	name = "Craft"
	desc = ""

/datum/skill/craft/crafting
	name = "Crafting"
	desc = ""
	dreams = list(
		"...you feel grass under you feet as you peer onto a meadow, you prepare a campfire and a tent and drift off into deeper slumber.."
	)

/datum/skill/craft/weaponsmithing
	name = "Weaponsmithing"

/datum/skill/craft/armorsmithing
	name = "Armorsmithing"

/datum/skill/craft/blacksmithing
	name = "Blacksmithing"

/datum/skill/craft/smelting
	name = "Smelting"

/datum/skill/craft/carpentry
	name = "Carpentry"

/datum/skill/craft/masonry
	name = "Masonry"

/datum/skill/craft/traps
	name = "Trapping"

/datum/skill/craft/cooking
	name = "Cooking"

/datum/skill/craft/medicine
	name = "Medicinecraft"
	desc = ""

/datum/skill/craft/alchemy
	name = "Alchemy"

/datum/skill/craft/alchemy/skill_level_effect(level, datum/mind/mind)
	if(level > SKILL_LEVEL_MASTER)
		ADD_TRAIT(mind?.current, TRAIT_LEGENDARY_ALCHEMIST, type)
		//SEND_GLOBAL_SIGNAL(COMSIG_ATOM_ADD_TRAIT, (mind?.current, TRAIT_LEGENDARY_ALCHEMIST)
	else if(HAS_TRAIT(mind?.current, TRAIT_LEGENDARY_ALCHEMIST))
		REMOVE_TRAIT(mind?.current, TRAIT_LEGENDARY_ALCHEMIST, type)
		//SEND_GLOBAL_SIGNAL(COMSIG_ATOM_ADD_TRAIT, (mind?.current, TRAIT_LEGENDARY_ALCHEMIST)

/datum/skill/craft/bombs
	name = "Bombcrafting"

/datum/skill/craft/engineering
	name = "Engineering"

/datum/skill/craft/tanning
	name = "Skincrafting"
	desc = ""

/datum/skill/craft/tailor
	name = "Clothesmaking"
	desc = ""
