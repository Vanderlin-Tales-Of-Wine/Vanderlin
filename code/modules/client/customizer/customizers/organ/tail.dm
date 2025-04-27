/datum/customizer/organ/tail
	name = "Tail"
	abstract_type = /datum/customizer/organ/tail

/datum/customizer_choice/organ/tail
	name = "Tail"
	organ_type = /obj/item/organ/tail
	organ_slot = ORGAN_SLOT_TAIL
	abstract_type = /datum/customizer_choice/organ/tail

/obj/item/organ/tail/tiefling
	accessory_type = /datum/sprite_accessory/tail/tiefling

/datum/customizer/organ/tail/tiefling
	customizer_choices = list(/datum/customizer_choice/organ/tail/tiefling)
	allows_disabling = FALSE

/datum/customizer_choice/organ/tail/tiefling
	name = "Tail"
	organ_type = /obj/item/organ/tail/tiefling
	allows_accessory_color_customization = FALSE
	sprite_accessories = list(
		/datum/sprite_accessory/tail/tiefling,
		)
