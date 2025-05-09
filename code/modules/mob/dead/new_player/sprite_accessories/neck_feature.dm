/datum/sprite_accessory/neck_feature
	abstract_type = /datum/sprite_accessory/neck_feature
	relevant_layers = list(BODY_ADJ_LAYER)
	color_key_defaults = list(KEY_HAIR_COLOR)

/datum/sprite_accessory/neck_feature/adjust_appearance_list(list/appearance_list, obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	generic_gender_feature_adjust(appearance_list, organ, bodypart, owner, OFFSET_NECK, OFFSET_NECK_F)

/datum/sprite_accessory/neck_feature/moth_fluff
	abstract_type = /datum/sprite_accessory/neck_feature/moth_fluff
	color_key_name = "Fluff"
	icon = 'icons/mob/sprite_accessory/neck_features/moth_fluff.dmi'
	default_colors = list("#FFFFFF")

/datum/sprite_accessory/neck_feature/moth_fluff/plain
	name = "Plain"
	icon_state = "plain"

/datum/sprite_accessory/neck_feature/moth_fluff/monarch
	name = "Monarch"
	icon_state = "monarch"

/datum/sprite_accessory/neck_feature/moth_fluff/luna
	name = "Luna"
	icon_state = "luna"

/datum/sprite_accessory/neck_feature/moth_fluff/atlas
	name = "Atlas"
	icon_state = "atlas"

/datum/sprite_accessory/neck_feature/moth_fluff/reddish
	name = "Reddish"
	icon_state = "redish"

/datum/sprite_accessory/neck_feature/moth_fluff/royal
	name = "Royal"
	icon_state = "royal"

/datum/sprite_accessory/neck_feature/moth_fluff/gothic
	name = "Gothic"
	icon_state = "gothic"

/datum/sprite_accessory/neck_feature/moth_fluff/lovers
	name = "Lovers"
	icon_state = "lovers"

/datum/sprite_accessory/neck_feature/moth_fluff/whitefly
	name = "White Fly"
	icon_state = "whitefly"

/datum/sprite_accessory/neck_feature/moth_fluff/punished
	name = "Burnt Off"
	icon_state = "burnt_off"

/datum/sprite_accessory/neck_feature/moth_fluff/firewatch
	name = "Firewatch"
	icon_state = "firewatch"

/datum/sprite_accessory/neck_feature/moth_fluff/deathhead
	name = "Deathshead"
	icon_state = "deathhead"

/datum/sprite_accessory/neck_feature/moth_fluff/poison
	name = "Poison"
	icon_state = "poison"

/datum/sprite_accessory/neck_feature/moth_fluff/ragged
	name = "Ragged"
	icon_state = "ragged"

/datum/sprite_accessory/neck_feature/moth_fluff/moonfly
	name = "Moon Fly"
	icon_state = "moonfly"

/datum/sprite_accessory/neck_feature/moth_fluff/snow
	name = "Snow"
	icon_state = "snow"

/datum/sprite_accessory/neck_feature/moth_fluff/oakworm
	name = "Oak Worm"
	icon_state = "oakworm"

/datum/sprite_accessory/neck_feature/moth_fluff/jungle
	name = "Jungle"
	icon_state = "jungle"

/datum/sprite_accessory/neck_feature/moth_fluff/witchwing
	name = "Witch Wing"
	icon_state = "witchwing"

/datum/sprite_accessory/neck_feature/mammal_fluff
	abstract_type = /datum/sprite_accessory/neck_feature/mammal_fluff
	color_key_name = "Fluff"
	icon = 'icons/mob/sprite_accessory/neck_features/mammal_fluff.dmi'

/datum/sprite_accessory/neck_feature/mammal_fluff/fluff
	name = "Fluff"
	icon_state = "fluff"

/datum/sprite_accessory/neck_feature/mammal_fluff/fluff_front
	name = "Fluff (Top)"
	icon_state = "ffluff"
	relevant_layers = list(BODY_FRONT_LAYER)

/datum/sprite_accessory/neck_feature/mammal_fluff/fluff_dual
	name = "Fluff Dual"
	icon_state = "fluffdual"
	color_keys = 2
	color_key_names = list("Fluff", "Front")

/datum/sprite_accessory/neck_feature/mammal_fluff/fluff_dual_front
	name = "Fluff Dual (Top)"
	icon_state = "ffluffdual"
	relevant_layers = list(BODY_FRONT_LAYER)
	color_keys = 2
	color_key_names = list("Fluff", "Front")

/datum/sprite_accessory/neck_feature/mammal_fluff/insect_m
	name = "Insect (Male)"
	icon_state = "insectm"

/datum/sprite_accessory/neck_feature/mammal_fluff/insect_f
	name = "Insect (Female)"
	icon_state = "insectf"
