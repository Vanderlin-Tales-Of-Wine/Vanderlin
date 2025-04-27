
/datum/customizer_choice/bodypart_feature
	abstract_type = /datum/customizer_choice/bodypart_feature
	name = "Bodypart Feature"
	/// Typepath of the bodypart feature
	var/feature_type = /datum/bodypart_feature

/datum/customizer_choice/bodypart_feature/apply_customizer_to_character(mob/living/carbon/human/human, datum/preferences/prefs, datum/customizer_entry/entry)
	var/datum/bodypart_feature/feature = new feature_type()
	if(entry?.accessory_type)
		var/colors_used = allows_accessory_color_customization ? entry.accessory_colors : null
		feature.set_accessory_type(entry?.accessory_type, colors_used, human)
	customize_feature(feature, human, prefs, entry)
	human.add_bodypart_feature(feature)

/datum/customizer_choice/bodypart_feature/proc/customize_feature(datum/bodypart_feature/feature, mob/living/carbon/human/human, datum/preferences/prefs, datum/customizer_entry/entry)
	return
