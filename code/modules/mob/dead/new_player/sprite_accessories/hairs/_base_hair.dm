/datum/sprite_accessory/hair
	abstract_type = /datum/sprite_accessory/hair
	color_key_name = "Hair"
	layer = HAIR_LAYER

/datum/sprite_accessory/hair/adjust_appearance_list(list/appearance_list, obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	generic_gender_feature_adjust(appearance_list, organ, bodypart, owner, OFFSET_FACE, OFFSET_FACE_F)
