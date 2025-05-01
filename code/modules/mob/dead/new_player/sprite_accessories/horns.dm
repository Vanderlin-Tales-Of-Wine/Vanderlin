/datum/sprite_accessory/horns
	abstract_type = /datum/sprite_accessory/horns
	icon = 'icons/mob/mutant_bodyparts.dmi'
	color_key_name = "Horns"
	relevant_layers = list(BODY_FRONT_LAYER)

/datum/sprite_accessory/horns/is_visible(obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	return is_human_part_visible(owner, HIDEEARS|HIDEHAIR)

/datum/sprite_accessory/horns/adjust_appearance_list(list/appearance_list, obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	generic_gender_feature_adjust(appearance_list, organ, bodypart, owner, OFFSET_FACE, OFFSET_FACE_F)

/datum/sprite_accessory/horns/tiefling
	icon = 'icons/roguetown/mob/bodies/attachments.dmi'
	name = "TiebHorns"
	icon_state = "tiebhorns"
	specuse = list("tiefling")
	color_key_defaults = list(KEY_SKIN_COLOR)

/datum/sprite_accessory/horns/tiefling/alt
	icon = 'icons/roguetown/mob/bodies/attachments.dmi'
	name = "TiebHornies"
	icon_state = "tiebhornsalt"
	specuse = list("tiefling")
	color_key_defaults = list(KEY_SKIN_COLOR)
