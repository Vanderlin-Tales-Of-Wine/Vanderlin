
/obj/item/clothing/gloves/essence_gauntlet
	name = "essence gauntlet"
	desc = "A mystical gauntlet that can store thaumaturgical essences and channel them into minor utility spells. Advanced combinations can unlock powerful effects."
	icon_state = "essence_gauntlet"
	var/list/obj/item/essence_vial/stored_vials = list()
	var/max_vials = 4
	var/list/granted_spells = list() // Spells granted by stored essences
	var/list/essence_spell_mapping = list() // Maps essence types to spell types
	var/list/combo_spell_mapping = list() // Maps essence combinations to combo spells
	var/list/racial_combo_mapping = list() // Maps race + essence combos to special spells

/obj/item/clothing/gloves/essence_gauntlet/Initialize()
	. = ..()

	// Single essence spells
	essence_spell_mapping = list(
		/datum/thaumaturgical_essence/air = list(/obj/effect/proc_holder/spell/invoked/utility/breeze, /obj/effect/proc_holder/spell/invoked/utility/air_walk),
		/datum/thaumaturgical_essence/water = list(/obj/effect/proc_holder/spell/invoked/utility/cleanse, /obj/effect/proc_holder/spell/invoked/utility/water_breathing),
		/datum/thaumaturgical_essence/fire = list(/obj/effect/proc_holder/spell/invoked/utility/spark, /obj/effect/proc_holder/spell/invoked/utility/warmth),
		/datum/thaumaturgical_essence/earth = list(/obj/effect/proc_holder/spell/invoked/utility/mend, /obj/effect/proc_holder/spell/invoked/utility/stone_shape),
		/datum/thaumaturgical_essence/frost = list(/obj/effect/proc_holder/spell/invoked/utility/chill, /obj/effect/proc_holder/spell/invoked/utility/preserve),
		/datum/thaumaturgical_essence/light = list(/obj/effect/proc_holder/spell/invoked/utility/illuminate, /obj/effect/proc_holder/spell/invoked/utility/daylight),
		/datum/thaumaturgical_essence/motion = list(/obj/effect/proc_holder/spell/invoked/utility/haste, /obj/effect/proc_holder/spell/invoked/utility/phase_step),
		/datum/thaumaturgical_essence/life = list(/obj/effect/proc_holder/spell/invoked/utility/refresh, /obj/effect/proc_holder/spell/invoked/utility/vigor),
		/datum/thaumaturgical_essence/order = list(/obj/effect/proc_holder/spell/invoked/utility/stabilize),
		/datum/thaumaturgical_essence/chaos = list(/obj/effect/proc_holder/spell/invoked/utility/randomize),
		/datum/thaumaturgical_essence/void = list(/obj/effect/proc_holder/spell/invoked/utility/silence),
		/datum/thaumaturgical_essence/poison = list(/obj/effect/proc_holder/spell/invoked/utility/neutralize, /obj/effect/proc_holder/spell/invoked/utility/detect_poison),
		/datum/thaumaturgical_essence/crystal = list(/obj/effect/proc_holder/spell/invoked/utility/gem_detect),
		/datum/thaumaturgical_essence/magic = list(/obj/effect/proc_holder/spell/invoked/utility/arcane_mark),
		/datum/thaumaturgical_essence/energia = list(/obj/effect/proc_holder/spell/invoked/utility/energize, /obj/effect/proc_holder/spell/invoked/utility/power_surge),
		/datum/thaumaturgical_essence/cycle = list(/obj/effect/proc_holder/spell/invoked/utility/seasonal_attune)
	)

	// Combo spells - require two different essences
	combo_spell_mapping = list(
		list(/datum/thaumaturgical_essence/fire, /datum/thaumaturgical_essence/air) = list(/obj/effect/proc_holder/spell/invoked/utility/flame_jet),
		list(/datum/thaumaturgical_essence/water, /datum/thaumaturgical_essence/earth) = list(/obj/effect/proc_holder/spell/invoked/utility/mud_shape, /obj/effect/proc_holder/spell/invoked/utility/fertile_soil),
		list(/datum/thaumaturgical_essence/fire, /datum/thaumaturgical_essence/earth) = list(/obj/effect/proc_holder/spell/invoked/utility/forge_heat),
		list(/datum/thaumaturgical_essence/frost, /datum/thaumaturgical_essence/water) = list(/obj/effect/proc_holder/spell/invoked/utility/ice_bridge, /obj/effect/proc_holder/spell/invoked/utility/frozen_storage),
		list(/datum/thaumaturgical_essence/light, /datum/thaumaturgical_essence/fire) = list(/obj/effect/proc_holder/spell/invoked/utility/brilliant_flame, /obj/effect/proc_holder/spell/invoked/utility/solar_focus),
		list(/datum/thaumaturgical_essence/life, /datum/thaumaturgical_essence/water) = list(/obj/effect/proc_holder/spell/invoked/utility/healing_spring, /obj/effect/proc_holder/spell/invoked/utility/purify_water),
		list(/datum/thaumaturgical_essence/earth, /datum/thaumaturgical_essence/crystal) = list(/obj/effect/proc_holder/spell/invoked/utility/gem_growth, /obj/effect/proc_holder/spell/invoked/utility/mineral_sense),
		list(/datum/thaumaturgical_essence/motion, /datum/thaumaturgical_essence/air) = list(/obj/effect/proc_holder/spell/invoked/utility/wind_step, /obj/effect/proc_holder/spell/invoked/utility/aerial_dash),
		list(/datum/thaumaturgical_essence/order, /datum/thaumaturgical_essence/light) = list(/obj/effect/proc_holder/spell/invoked/utility/divine_order, /obj/effect/proc_holder/spell/invoked/utility/sacred_geometry),
		list(/datum/thaumaturgical_essence/chaos, /datum/thaumaturgical_essence/void) = list(/obj/effect/proc_holder/spell/invoked/utility/reality_shift, /obj/effect/proc_holder/spell/invoked/utility/probability_warp),
		list(/datum/thaumaturgical_essence/poison, /datum/thaumaturgical_essence/water) = list(/obj/effect/proc_holder/spell/invoked/utility/toxic_cleanse),
		list(/datum/thaumaturgical_essence/magic, /datum/thaumaturgical_essence/crystal) = list(/obj/effect/proc_holder/spell/invoked/utility/spell_crystal, /obj/effect/proc_holder/spell/invoked/utility/arcane_focus),
		list(/datum/thaumaturgical_essence/energia, /datum/thaumaturgical_essence/motion) = list(/obj/effect/proc_holder/spell/invoked/utility/kinetic_burst, /obj/effect/proc_holder/spell/invoked/utility/momentum_transfer),
		list(/datum/thaumaturgical_essence/cycle, /datum/thaumaturgical_essence/life) = list(/obj/effect/proc_holder/spell/invoked/utility/regeneration_cycle, /obj/effect/proc_holder/spell/invoked/utility/growth_acceleration)
	)

	// Racial combo spells
	racial_combo_mapping = list(
		"dwarf" = list(
			list(/datum/thaumaturgical_essence/earth, /datum/thaumaturgical_essence/water) = list(/obj/effect/proc_holder/spell/invoked/utility/create_beer),
			list(/datum/thaumaturgical_essence/fire, /datum/thaumaturgical_essence/earth) = list(/obj/effect/proc_holder/spell/invoked/utility/master_forge, /obj/effect/proc_holder/spell/invoked/utility/ancestral_smithing)
		),
		"elf" = list(
			list(/datum/thaumaturgical_essence/life, /datum/thaumaturgical_essence/light) = list(/obj/effect/proc_holder/spell/invoked/utility/elven_grace)
		),
		"human" = list(
			list(/datum/thaumaturgical_essence/order, /datum/thaumaturgical_essence/chaos) = list(/obj/effect/proc_holder/spell/invoked/utility/balanced_mind)
		)
	)

/obj/item/clothing/gloves/essence_gauntlet/equipped(mob/user, slot)
	. = ..()
	if(slot == SLOT_GLOVES)
		grant_essence_spells(user)

/obj/item/clothing/gloves/essence_gauntlet/dropped(mob/user)
	. = ..()
	remove_essence_spells(user)


/obj/item/clothing/gloves/essence_gauntlet/attack_right(mob/user)
	if(!stored_vials.len)
		to_chat(user, span_warning("[src] has no vials to remove!"))
		return

	// Create radial menu for vial selection
	var/list/radial_options = list()
	var/list/vial_mapping = list()
	for(var/i in 1 to stored_vials.len)
		var/obj/item/essence_vial/vial = stored_vials[i]
		var/vial_desc = "Vial [i]"
		var/display_name = "Vial [i]"
		if(vial.contained_essence && vial.essence_amount > 0)
			if(HAS_TRAIT(user, TRAIT_LEGENDARY_ALCHEMIST))
				vial_desc += " - [vial.contained_essence.name] ([vial.essence_amount] units)"
				display_name = "[vial.contained_essence.name]"
			else
				vial_desc += " - essence smelling of [vial.contained_essence.smells_like] ([vial.essence_amount] units)"
				display_name = "Essence smelling of [vial.contained_essence.smells_like]"
		else
			vial_desc += " - empty"
			display_name = "Empty vial"

		var/datum/radial_menu_choice/choice = new()
		var/image/image = image(icon = 'icons/roguetown/misc/alchemy.dmi', icon_state = "essence")
		if(vial.contained_essence && vial.essence_amount > 0)
			image.color = vial.contained_essence.color
		choice.image = image
		choice.name = display_name
		if(vial.contained_essence && vial.essence_amount > 0)
			if(HAS_TRAIT(user, TRAIT_LEGENDARY_ALCHEMIST))
				choice.info = "Remove vial containing [vial.contained_essence.name] ([vial.essence_amount] units)"
			else
				choice.info = "Remove vial containing essence smelling of [vial.contained_essence.smells_like] ([vial.essence_amount] units)"
		else
			choice.info = "Remove empty vial"
		radial_options[vial_desc] = choice
		vial_mapping[vial_desc] = vial

	var/choice = show_radial_menu(user, src, radial_options, custom_check = CALLBACK(src, PROC_REF(check_gauntlet_validity), user), radial_slice_icon = "radial_thaum")
	if(!choice || !vial_mapping[choice])
		return
	var/obj/item/essence_vial/chosen_vial = vial_mapping[choice]
	stored_vials -= chosen_vial
	chosen_vial.forceMove(get_turf(user))
	user.put_in_hands(chosen_vial)
	to_chat(user, span_notice("You remove [chosen_vial] from [src]."))
	// Update spells if currently equipped
	if(ishuman(user) && user.get_item_by_slot(SLOT_GLOVES) == src)
		remove_essence_spells(user)
		grant_essence_spells(user)

/obj/item/clothing/gloves/essence_gauntlet/proc/check_gauntlet_validity(mob/user)
	return user && src.loc == user

/obj/item/clothing/gloves/essence_gauntlet/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/essence_vial))
		var/obj/item/essence_vial/vial = I
		if(!vial.contained_essence || vial.essence_amount <= 0)
			to_chat(user, span_warning("[vial] is empty!"))
			return

		if(stored_vials.len >= max_vials)
			to_chat(user, span_warning("[src] cannot hold any more essence vials!"))
			return

		if(!user.transferItemToLoc(vial, src))
			return

		stored_vials += vial
		to_chat(user, span_notice("You insert [vial] into [src]."))

		// Update spells if currently equipped
		if(ishuman(user) && user.get_item_by_slot(SLOT_GLOVES) == src)
			remove_essence_spells(user)
			grant_essence_spells(user)
		return

	return ..()

/obj/item/clothing/gloves/essence_gauntlet/proc/can_consume_essence(required_amount, list/required_attunements)
	var/total_available = 0

	if(!required_attunements || !required_attunements.len)
		for(var/obj/item/essence_vial/vial in stored_vials)
			if(vial.contained_essence && vial.essence_amount > 0)
				total_available += vial.essence_amount
		return total_available >= required_amount

	for(var/attunement_path in required_attunements)
		var/essence_type = extract_essence_type(attunement_path)
		for(var/obj/item/essence_vial/vial in stored_vials)
			if(vial.contained_essence && vial.contained_essence.type == essence_type)
				total_available += vial.essence_amount

	return total_available >= required_amount

/obj/item/clothing/gloves/essence_gauntlet/proc/consume_essence(amount, list/required_attunements)
	var/remaining_to_consume = amount

	if(!required_attunements || !required_attunements.len)
		for(var/obj/item/essence_vial/vial in stored_vials)
			if(remaining_to_consume <= 0)
				break
			if(vial.contained_essence && vial.essence_amount > 0)
				var/to_consume = min(vial.essence_amount, remaining_to_consume)
				vial.essence_amount -= to_consume
				remaining_to_consume -= to_consume
				if(vial.essence_amount <= 0)
					vial.contained_essence = null
				vial.update_icon()
		return remaining_to_consume <= 0

	for(var/attunement_path in required_attunements)
		if(remaining_to_consume <= 0)
			break
		var/essence_type = extract_essence_type(attunement_path)
		for(var/obj/item/essence_vial/vial in stored_vials)
			if(remaining_to_consume <= 0)
				break
			if(vial.contained_essence && vial.contained_essence.type == essence_type && vial.essence_amount > 0)
				var/to_consume = min(vial.essence_amount, remaining_to_consume)
				vial.essence_amount -= to_consume
				remaining_to_consume -= to_consume
				if(vial.essence_amount <= 0)
					vial.contained_essence = null
				vial.update_icon()

	return remaining_to_consume <= 0

/obj/item/clothing/gloves/essence_gauntlet/proc/extract_essence_type(attunement_path)
	switch(attunement_path)
		if(/datum/attunement/aeromancy)
			return /datum/thaumaturgical_essence/air
		if(/datum/attunement/blood)
			return /datum/thaumaturgical_essence/water
		if(/datum/attunement/fire)
			return /datum/thaumaturgical_essence/fire
		if(/datum/attunement/earth)
			return /datum/thaumaturgical_essence/earth
		if(/datum/attunement/ice)
			return /datum/thaumaturgical_essence/frost
		if(/datum/attunement/light)
			return /datum/thaumaturgical_essence/light
		if(/datum/attunement/life)
			return /datum/thaumaturgical_essence/life
	return null

/obj/item/clothing/gloves/essence_gauntlet/proc/get_available_essence_types()
	var/list/available_types = list()
	for(var/obj/item/essence_vial/vial in stored_vials)
		if(vial.contained_essence && vial.essence_amount > 0)
			available_types[vial.contained_essence.type] = TRUE
	return available_types

/obj/item/clothing/gloves/essence_gauntlet/proc/get_user_race(mob/user)
	if(!ishuman(user))
		return null
	var/mob/living/carbon/human/human_user = user
	return human_user.dna?.species?.id

/obj/item/clothing/gloves/essence_gauntlet/proc/check_combo_requirements(list/required_essences, list/available_essences)
	for(var/essence_type in required_essences)
		if(!(essence_type in available_essences))
			return FALSE
	return TRUE

/obj/item/clothing/gloves/essence_gauntlet/proc/update_granted_spells()
	granted_spells.Cut()
	var/list/available_essences = get_available_essence_types()

	// Add single essence spells
	for(var/obj/item/essence_vial/vial in stored_vials)
		if(vial.contained_essence && vial.essence_amount > 0)
			var/list/spells = essence_spell_mapping[vial.contained_essence.type]
			if(spells)
				for(var/spell_type in spells)
					if(!(spell_type in granted_spells))
						granted_spells += spell_type

	// Add combo spells
	for(var/list/combo_requirements in combo_spell_mapping)
		if(check_combo_requirements(combo_requirements, available_essences))
			var/list/combo_spells = combo_spell_mapping[combo_requirements]
			for(var/spell_type in combo_spells)
				if(!(spell_type in granted_spells))
					granted_spells += spell_type

/obj/item/clothing/gloves/essence_gauntlet/proc/grant_essence_spells(mob/user)
	if(!isliving(user))
		return

	update_granted_spells()
	var/mob/living/living_user = user
	var/list/available_essences = get_available_essence_types()
	var/user_race = get_user_race(user)

	// Grant single essence and combo spells
	for(var/spell_type in granted_spells)
		var/obj/effect/proc_holder/spell/essence_spell = new spell_type()
		if(istype(essence_spell))
			essence_spell.spell_flag |= SPELL_ESSENCE
			living_user.mind?.AddSpell(essence_spell)

	// Grant racial combo spells
	if(user_race && (user_race in racial_combo_mapping))
		var/list/racial_combos = racial_combo_mapping[user_race]
		for(var/list/combo_requirements in racial_combos)
			if(check_combo_requirements(combo_requirements, available_essences))
				var/list/racial_spells = racial_combos[combo_requirements]
				for(var/spell_type in racial_spells)
					var/obj/effect/proc_holder/spell/racial_spell = new spell_type()
					if(istype(racial_spell))
						racial_spell.spell_flag |= SPELL_ESSENCE
						living_user.mind?.AddSpell(racial_spell)

/obj/item/clothing/gloves/essence_gauntlet/proc/remove_essence_spells(mob/user)
	if(!isliving(user) || !user.mind)
		return

	var/mob/living/living_user = user

	// Remove all essence-flagged spells
	for(var/obj/effect/proc_holder/spell/spell in living_user.mind.spell_list)
		if(spell.spell_flag & SPELL_ESSENCE)
			living_user.mind.RemoveSpell(spell)

/obj/item/clothing/gloves/essence_gauntlet/proc/essence_failure_feedback(mob/user)
	to_chat(user, span_warning("[src] lacks sufficient essence to cast that spell!"))
	return TRUE

/obj/item/clothing/gloves/essence_gauntlet/proc/get_gauntlet_user()
	return loc

/obj/item/clothing/gloves/essence_gauntlet/examine(mob/user)
	. = ..()

	. += span_notice("Essence Vials ([stored_vials.len]/[max_vials]):")

	if(!stored_vials.len)
		. += span_notice("- No vials inserted")
		. += span_notice("Right-click to remove vials when available")
		return

	var/list/available_essences = get_available_essence_types()
	var/user_race = get_user_race(user)

	for(var/obj/item/essence_vial/vial in stored_vials)
		if(vial.contained_essence && vial.essence_amount > 0)
			if(!HAS_TRAIT(user, TRAIT_LEGENDARY_ALCHEMIST))
				. += span_notice("- [vial.essence_amount] units of essence smelling of [vial.contained_essence.smells_like]")
			else
				. += span_notice("- [vial.essence_amount] units of [vial.contained_essence.name]")
		else
			. += span_notice("- Empty vial")

	. += span_notice("Right-click to remove vials")

	// Show available combo spells
	if(available_essences.len >= 2)
		. += span_notice("\nCombo Spells Available:")
		var/combo_count = 0
		for(var/list/combo_requirements in combo_spell_mapping)
			if(check_combo_requirements(combo_requirements, available_essences))
				combo_count++

		if(user_race && (user_race in racial_combo_mapping))
			var/list/racial_combos = racial_combo_mapping[user_race]
			for(var/list/combo_requirements in racial_combos)
				if(check_combo_requirements(combo_requirements, available_essences))
					combo_count++

		if(combo_count > 0)
			. += span_notice("- [combo_count] combination spell[combo_count > 1 ? "s" : ""] unlocked")
		else
			. += span_notice("- No combinations available with current essences")
