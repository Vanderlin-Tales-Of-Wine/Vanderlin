
/datum/sprite_accessory/ears
	icon = 'icons/mob/mutant_bodyparts.dmi'
	color_key_name = "Ears"
	relevant_layers = list(BODY_ADJ_LAYER, BODY_FRONT_LAYER)

/datum/sprite_accessory/ears/is_visible(obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	return is_human_part_visible(owner, HIDEEARS)

/datum/sprite_accessory/ears/adjust_appearance_list(list/appearance_list, obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	generic_gender_feature_adjust(appearance_list, organ, bodypart, owner, OFFSET_FACE, OFFSET_FACE_F)

/datum/sprite_accessory/ears/none
	name = "None"
	icon_state = null

/datum/sprite_accessory/ears/elf
	icon = 'icons/roguetown/mob/bodies/attachments.dmi'
	name = "Elf"
	icon_state = "elf"
	specuse = list("elf")
	color_key_defaults = list(KEY_SKIN_COLOR)

/datum/sprite_accessory/ears/elfw
	icon = 'icons/roguetown/mob/bodies/attachments.dmi'
	name = "ElfW"
	icon_state = "elfw"
	specuse = list("elf", "tiefling") //tiebs use these
	color_key_defaults = list(KEY_SKIN_COLOR)

/datum/sprite_accessory/ears/elfh //halfelfs are humens techincally
	icon = 'icons/roguetown/mob/bodies/attachments.dmi'
	name = "ElfH"
	icon_state = "elf"
	specuse = list("human")
	color_key_defaults = list(KEY_SKIN_COLOR)

/datum/sprite_accessory/ears/cat
	name = "Cat"
	icon_state = "cat"
	color_key_defaults = list(KEY_HAIR_COLOR)
	specuse = list("cattan")
