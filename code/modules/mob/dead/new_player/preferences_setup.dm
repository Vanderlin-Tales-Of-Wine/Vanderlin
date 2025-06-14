/// Randomizes our character preferences according to enabled bitflags.
// Reflect changes in [mob/living/carbon/human/proc/randomize_human_appearance]
/datum/preferences/proc/randomise_appearance_prefs(randomise_flags = ALL, include_patreon = FALSE)
	if(randomise_flags & RANDOMIZE_SPECIES)
		var/rando_race = GLOB.species_list[pick(get_selectable_species(include_patreon))]
		pref_species = new rando_race()

	if(NOEYESPRITES in pref_species.species_traits)
		randomise_flags &= ~RANDOMIZE_EYE_COLOR

	if(randomise_flags & RANDOMIZE_GENDER)
		gender = pref_species.sexes ? pick(MALE, FEMALE) : PLURAL

	if(randomise_flags & RANDOMIZE_AGE)
		age = pick(pref_species.possible_ages)

	if(randomise_flags & RANDOMIZE_NAME)
		real_name = pref_species.random_name(gender, TRUE)

	if(randomise_flags & RANDOMIZE_UNDERWEAR)
		underwear = pref_species.random_underwear(gender)

	if(randomise_flags & (RANDOMIZE_HAIRSTYLE | RANDOMIZE_HAIR_COLOR))
		var/datum/customizer_entry/hair/entry = get_customizer_entry_of_type(/datum/customizer_entry/hair/head)
		if(entry)
			var/datum/customizer_choice/customizer_choice = CUSTOMIZER_CHOICE(entry.customizer_choice_type)
			var/color = (randomise_flags & RANDOMIZE_HAIR_COLOR)
			var/accessory = (randomise_flags & RANDOMIZE_HAIRSTYLE)
			customizer_choice.randomize_entry(entry, src, color, accessory)

	if(randomise_flags & (RANDOMIZE_FACIAL_HAIRSTYLE | RANDOMIZE_FACIAL_HAIR_COLOR))
		var/datum/customizer_entry/hair/entry = get_customizer_entry_of_type(/datum/customizer_entry/hair/facial)
		if(entry)
			var/datum/customizer_choice/customizer_choice = CUSTOMIZER_CHOICE(entry.customizer_choice_type)
			var/color = (randomise_flags & RANDOMIZE_FACIAL_HAIR_COLOR)
			var/accessory = (randomise_flags & RANDOMIZE_FACIAL_HAIRSTYLE)
			customizer_choice.randomize_entry(entry, src, color, accessory)

	if(randomise_flags & RANDOMIZE_SKIN_TONE)
		var/list/skin_list = pref_species.get_skin_list()
		skin_tone = pick_assoc(skin_list)

	if(randomise_flags & RANDOMIZE_EYE_COLOR)
		eye_color = random_eye_color()

	//if(randomise_flags & RANDOMIZE_FEATURES)
		//features = random_features()

/// Randomizes our character preferences according to enabled randomise preferences.
/datum/preferences/proc/apply_character_randomization_prefs(antag_override = FALSE)
	if(!randomise[RANDOM_BODY] && !(antag_override && randomise[RANDOM_BODY_ANTAG]))
		return // Prefs say "no, thank you"
	if(randomise[RANDOM_SPECIES])
		random_species()
	if(randomise[RANDOM_GENDER] || antag_override && randomise[RANDOM_GENDER_ANTAG])
		gender = pref_species.sexes ? pick(MALE, FEMALE) : PLURAL
	if(randomise[RANDOM_AGE] || randomise[RANDOM_AGE_ANTAG] && antag_override)
		age = pick(pref_species.possible_ages)
	if(randomise[RANDOM_NAME] || antag_override && randomise[RANDOM_NAME_ANTAG])
		real_name = pref_species.random_name(gender, TRUE)

	if(randomise[RANDOM_UNDERWEAR_COLOR])
		underwear_color = random_short_color()
	if(randomise[RANDOM_UNDERSHIRT])
		undershirt = random_undershirt(gender)
	if(randomise[RANDOM_UNDERWEAR])
		underwear = pref_species.random_underwear(gender)
	if(randomise[RANDOM_SKIN_TONE])
		var/list/skins = pref_species.get_skin_list()
		skin_tone = pick_assoc(skins)
	if(randomise[RANDOM_EYE_COLOR])
		eye_color = random_eye_color()
	features = random_features()

	if(pref_species.default_features["ears"])
		features["ears"] = pref_species.default_features["ears"]
	accessory = "Nothing"

/datum/preferences/proc/random_species()
	var/random_species_type = GLOB.species_list[pick(get_selectable_species(patreon))]
	pref_species = new random_species_type
	if(randomise[RANDOM_NAME])
		real_name = pref_species.random_name(gender, TRUE)

/datum/preferences/proc/update_preview_icon()
	set waitfor = 0
	if(!parent)
		return
	// Determine what job is marked as 'High' priority, and dress them up as such.
	var/datum/job/previewJob
	var/highest_pref = 0
	for(var/job in job_preferences)
		if(job_preferences[job] > highest_pref)
			previewJob = SSjob.GetJob(job)
			highest_pref = job_preferences[job]

	// Set up the dummy for its photoshoot
	var/mob/living/carbon/human/dummy/mannequin = generate_or_wait_for_human_dummy(DUMMY_HUMAN_SLOT_PREFERENCES)
	apply_prefs_to(mannequin, TRUE)

	if(previewJob)
		mannequin.job = previewJob.title
		mannequin.dress_up_as_job(previewJob, TRUE)

	parent.show_character_previews(new /mutable_appearance(mannequin))
	unset_busy_human_dummy(DUMMY_HUMAN_SLOT_PREFERENCES)


/datum/preferences/proc/spec_check()
	if(!(pref_species.name in get_selectable_species(patreon)))
		return FALSE
	return TRUE
