
/obj/item/organ/ears/elf
	name = "elf ears"
	accessory_type = /datum/sprite_accessory/ears/elf

/obj/item/organ/ears/elfw
	name = "wood elf ears"
	accessory_type = /datum/sprite_accessory/ears/elfw

/obj/item/organ/ears/tiefling
	name = "tiefling ears"
	accessory_type = /datum/sprite_accessory/ears

/obj/item/organ/ears/halforc
	name = "halforc ears"
	accessory_type = /datum/sprite_accessory/ears/elf

/datum/customizer/organ/ears
	name = "Ears"
	abstract_type = /datum/customizer/organ/ears

/datum/customizer_choice/organ/ears
	name = "Ears"
	organ_type = /obj/item/organ/ears
	organ_slot = ORGAN_SLOT_EARS
	allows_accessory_color_customization = FALSE
	abstract_type = /datum/customizer_choice/organ/ears

/datum/customizer_choice/organ/ears/elf
	name = "Elf Ears"
	organ_type = /obj/item/organ/ears
	sprite_accessories = list(
		/datum/sprite_accessory/ears/elf,
		/datum/sprite_accessory/ears/elfw)

/datum/customizer/organ/ears/elf
	customizer_choices = list(/datum/customizer_choice/organ/ears/elf)
	allows_disabling = TRUE

/datum/customizer/organ/ears/halforc
	customizer_choices = list(/datum/customizer_choice/organ/ears/halforc)
	allows_disabling = FALSE

/datum/customizer_choice/organ/ears/halforc
	name = "Half-Orc Ears"
	organ_type = /obj/item/organ/ears
	sprite_accessories = list(
		/datum/sprite_accessory/ears/elf,
		/datum/sprite_accessory/ears/elfw,
		)

/datum/customizer/organ/ears/tiefling
	customizer_choices = list(/datum/customizer_choice/organ/ears/tiefling)
	allows_disabling = FALSE

/datum/customizer_choice/organ/ears/tiefling
	name = "Tiefling Ears"
	organ_type = /obj/item/organ/ears
	sprite_accessories = list(
		/datum/sprite_accessory/ears/elf,
		/datum/sprite_accessory/ears/elfw,
		)
