
/datum/customizer_choice/organ
	abstract_type = /datum/customizer_choice/organ
	name = "Organ"
	/// Typepath of the organ this choice yields.
	var/organ_type
	/// Slot of the organ.
	var/organ_slot
	/// Typepath of the organ DNA.
	var/organ_dna_type = /datum/organ_dna

/// When you want to customize an organ but not through DNA (hair dye for example)
/datum/customizer_choice/organ/get_organ_slot(obj/item/organ/organ, datum/customizer_entry/entry)
	return organ_slot

/// When you want to customize an organ but not through DNA (hair dye for example)
/datum/customizer_choice/organ/customize_organ(obj/item/organ/organ, datum/customizer_entry/entry)
	return

/datum/customizer_choice/organ/imprint_organ_dna(datum/organ_dna/organ_dna, datum/customizer_entry/entry, datum/preferences/prefs)
	organ_dna.organ_type = organ_type
	if(entry?.accessory_type)
		organ_dna?.accessory_type = entry?.accessory_type
		if(allows_accessory_color_customization)
			organ_dna.accessory_colors = entry.accessory_colors
		else
			var/datum/sprite_accessory/accessory = SPRITE_ACCESSORY(entry?.accessory_type)
			organ_dna.accessory_colors = accessory.get_default_colors(color_key_source_list_from_prefs(prefs))

/datum/customizer_choice/organ/create_organ_dna(datum/customizer_entry/entry, datum/preferences/prefs)
	var/datum/organ_dna/organ_dna = new organ_dna_type()
	imprint_organ_dna(organ_dna, entry, prefs)
	return organ_dna
