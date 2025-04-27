/obj/item/organ/horns
	name = "horns"
	desc = "A severed pair of horns. What did you cut this off of?"
	icon_state = "severedtail" //placeholder
	visible_organ = TRUE
	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_HORNS

/obj/item/organ/horns/tiefling
	name = "tiefling horns"
	accessory_type = /datum/sprite_accessory/horns/tiefling

/datum/customizer/organ/horns
	abstract_type = /datum/customizer/organ/horns
	name = "Horns"

/datum/customizer_choice/organ/horns
	abstract_type = /datum/customizer_choice/organ/horns
	name = "Horns"
	organ_type = /obj/item/organ/horns
	organ_slot = ORGAN_SLOT_HORNS
	allows_accessory_color_customization = FALSE

/datum/customizer/organ/horns/tiefling
	customizer_choices = list(/datum/customizer_choice/organ/horns/tiefling)
	allows_disabling = FALSE

/datum/customizer_choice/organ/horns/tiefling
	name = "Horns"
	organ_type = /obj/item/organ/horns
	sprite_accessories = list(
		/datum/sprite_accessory/horns/tiefling,
		/datum/sprite_accessory/horns/tiefling/alt,
	)
