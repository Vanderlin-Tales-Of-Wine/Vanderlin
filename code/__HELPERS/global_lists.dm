//////////////////////////
/////Initial Building/////
//////////////////////////

/proc/make_datum_references_lists()
	//hair
	init_sprite_accessory_subtypes(/datum/sprite_accessory/hair, GLOB.hairstyles_list, GLOB.hairstyles_male_list, GLOB.hairstyles_female_list)
	//facial hair
	init_sprite_accessory_subtypes(/datum/sprite_accessory/facial_hair, GLOB.facial_hairstyles_list, GLOB.facial_hairstyles_male_list, GLOB.facial_hairstyles_female_list, female_same = TRUE)
	//underwear
	init_sprite_accessory_subtypes(/datum/sprite_accessory/underwear, GLOB.underwear_list, GLOB.underwear_m, GLOB.underwear_f)
	//undershirt
	init_sprite_accessory_subtypes(/datum/sprite_accessory/undershirt, GLOB.undershirt_list, GLOB.undershirt_m, GLOB.undershirt_f)
	//socks
	init_sprite_accessory_subtypes(/datum/sprite_accessory/socks, GLOB.socks_list)
	//jewelry
	init_sprite_accessory_subtypes(/datum/sprite_accessory/accessories, GLOB.accessories_list, GLOB.accessories_m, GLOB.accessories_f)
	//snowflake
	init_sprite_accessory_subtypes(/datum/sprite_accessory/detail, GLOB.detail_list, GLOB.detail_m, GLOB.detail_f)


	//bodypart accessories (blizzard intensifies)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/body_markings, GLOB.body_markings_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/tails/lizard, GLOB.tails_list_lizard)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/tails_animated/lizard, GLOB.animated_tails_list_lizard)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/tails/human, GLOB.tails_list_human)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/tails_animated/human, GLOB.animated_tails_list_human)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/snouts, GLOB.snouts_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/horns,GLOB.horns_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/ears, GLOB.ears_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/wings, GLOB.wings_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/wings_open, GLOB.wings_open_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/frills, GLOB.frills_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/spines, GLOB.spines_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/spines_animated, GLOB.animated_spines_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/legs, GLOB.legs_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/wings, GLOB.r_wings_list,roundstart = TRUE)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/caps, GLOB.caps_list)

	//Species
	for(var/spath in subtypesof(/datum/species))
		var/datum/species/S = new spath()
		GLOB.species_list[S.name] = spath
	sortList(GLOB.species_list, GLOBAL_PROC_REF(cmp_typepaths_asc))

	//Surgery steps
	for(var/path in subtypesof(/datum/surgery_step))
		GLOB.surgery_steps += new path()
	sortList(GLOB.surgery_steps, GLOBAL_PROC_REF(cmp_typepaths_asc))

	//Surgeries
	for(var/path in subtypesof(/datum/surgery))
		GLOB.surgeries_list += new path()
	sortList(GLOB.surgeries_list, GLOBAL_PROC_REF(cmp_typepaths_asc))

	// Keybindings
	init_keybindings()

	init_slapcraft_steps()
	init_slapcraft_recipes()
	init_curse_names()

	init_orderless_slapcraft_recipes()
	init_crafting_repeatable_recipes()
	setup_particles()

	GLOB.emote_list = init_emote_list()

	init_subtypes(/datum/crafting_recipe, GLOB.crafting_recipes)

	init_subtypes(/datum/anvil_recipe, GLOB.anvil_recipes)

	init_subtypes(/datum/artificer_recipe, GLOB.artificer_recipes)

	init_subtypes(/datum/alch_grind_recipe, GLOB.alch_grind_recipes)

	init_subtypes(/datum/alch_cauldron_recipe,GLOB.alch_cauldron_recipes)

	for(var/i in 0 to 20)
		GLOB.mouseicons_human += file("icons/effects/mousemice/swang/[i * 5].dmi")

	// Faiths
	for(var/path in subtypesof(/datum/faith))
		var/datum/faith/faith = new path()
		GLOB.faithlist[path] = faith
		if(faith.preference_accessible)
			GLOB.preference_faiths[path] = faith

	// Patron Gods
	for(var/path in subtypesof(/datum/patron))
		var/datum/patron/patron = new path()
		if(patron.non_faith)
			continue
		GLOB.patronlist[path] = patron
		LAZYINITLIST(GLOB.patrons_by_faith[patron.associated_faith])
		GLOB.patrons_by_faith[patron.associated_faith][path] = patron
		if(patron.preference_accessible)
			GLOB.preference_patrons[path] = patron

//creates every subtype of prototype (excluding prototype) and adds it to list L.
//if no list/L is provided, one is created.
/proc/init_subtypes(prototype, list/L)
	if(!istype(L))
		L = list()
	for(var/path in subtypesof(prototype))
		L += new path()
	return L

//returns a list of paths to every subtype of prototype (excluding prototype)
//if no list/L is provided, one is created.
/proc/init_paths(prototype, list/L)
	if(!istype(L))
		L = list()
		for(var/path in subtypesof(prototype))
			L+= path
		return L

/// Functions like init_subtypes, but uses the subtype's path as a key for easy access
/proc/init_subtypes_w_path_keys(prototype, list/L)
	if(!istype(L))
		L = list()
	for(var/path as anything in subtypesof(prototype))
		L[path] = new path()
	return L

/proc/init_curse_names()
	GLOB.curse_names = list()
	for(var/datum/curse/curse_type as anything in subtypesof(/datum/curse))
		if(is_abstract(curse_type))
			continue
		GLOB.curse_names |= initial(curse_type.name)
		GLOB.curse_names[initial(curse_type.name)] = new curse_type
