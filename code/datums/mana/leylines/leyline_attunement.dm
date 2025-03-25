// works differently than others - uses prob(), so treat this stuff as percents
GLOBAL_LIST_INIT(leyline_attunement_themes, list(
	/datum/leyline_variable/attunement_theme/fire_minor = 0.5,
))

/proc/get_random_attunement_themes()
	RETURN_TYPE(/list/datum/leyline_variable/attunement_theme)

	var/list/datum/leyline_variable/attunement_theme/themes = list()

	for (var/datum/leyline_variable/attunement_theme/theme as anything in GLOB.leyline_attunement_themes)
		if (prob(GLOB.leyline_attunement_themes[theme]))
			themes += new theme

	return themes

/// For each entry in GLOB.[leyline_attunement_themes], prob() is ran, and if it succeeds, it adjusts the leyline attunement by [adjust_attunements]
/datum/leyline_variable/attunement_theme

/datum/leyline_variable/attunement_theme/proc/adjust_attunements(list/datum/attunement/attunements)
	return

/datum/leyline_variable/attunement_theme/fire_minor
	name = "Smoldering"
	beam_color = COLOR_ORANGE

/datum/leyline_variable/attunement_theme/fire_minor/adjust_attunements(list/datum/attunement/attunements)
	attunements[MAGIC_ELEMENT_FIRE] += 0.2

/datum/leyline_variable/attunement_theme/arcyne_minor
	name = "Arcyne"
	beam_color = COLOR_PALE_PURPLE_GRAY

/datum/leyline_variable/attunement_theme/arcyne_minor/adjust_attunements(list/datum/attunement/attunements)
	attunements[/datum/attunement/arcyne] += 0.2
