/datum/sprite_accessory/tail
	abstract_type = /datum/sprite_accessory/tail
	icon = 'icons/roguetown/mob/bodies/attachments.dmi'
	color_key_name = "Tail"
	relevant_layers = list(BODY_FRONT_LAYER, BODY_BEHIND_LAYER)
	var/can_wag = FALSE

/datum/sprite_accessory/tail/is_visible(obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	return TRUE

/datum/sprite_accessory/tail/adjust_appearance_list(list/appearance_list, obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	generic_gender_feature_adjust(appearance_list, organ, bodypart, owner, OFFSET_UNDIES, OFFSET_UNDIES_F)

/datum/sprite_accessory/tail/tiefling
	icon = 'icons/roguetown/mob/bodies/attachments.dmi'
	name = "TiebTail"
	icon_state = "tiebtail"
	specuse = list("tiefling")
	gender = NEUTER
	color_key_defaults = list(KEY_SKIN_COLOR)
