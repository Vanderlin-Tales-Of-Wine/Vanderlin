#define MAX_SPELL_SLOTS 8

/mob/var/list/spell_quickslots = list()

/mob/proc/initialize_spell_quickslots()
	spell_quickslots = new /list(MAX_SPELL_SLOTS)

/mob/proc/spell_quickselect(atom/clicked_atom)
	if(!mind)
		return
	if(!length(spell_quickslots))
		initialize_spell_quickslots()

	var/list/radial_options = list()

	for(var/i in 1 to MAX_SPELL_SLOTS)
		var/obj/effect/proc_holder/spell/stored_spell = spell_quickslots[i]
		if(stored_spell)
			radial_options["[i]"] = image(icon = stored_spell.action_icon, icon_state = stored_spell.overlay_state)
		else
			radial_options["[i]"] = image(icon = 'icons/hud/radial.dmi', icon_state = "empty_slot")

	var/choice = show_radial_menu(src, get_turf(clicked_atom), radial_options, custom_check = CALLBACK(src, PROC_REF(check_spell_quickselect)), radial_slice_icon = "radial_thaum", click_on_hover = TRUE)

	if(!choice)
		return

	var/slot_index = text2num(choice)
	if(client.keys_held["Ctrl"] || !spell_quickslots[slot_index])
		assign_spell_to_slot(slot_index, get_turf(clicked_atom))
	else
		var/obj/effect/proc_holder/spell/selected_spell = spell_quickslots[slot_index]
		if(selected_spell)
			if(ranged_ability)
				ranged_ability.remove_ranged_ability()
			selected_spell.Click()

/mob/proc/assign_spell_to_slot(slot_index, turf/creation)
	if(!mind || !mind.spell_list.len)
		return

	var/list/spell_options = list()

	// Build list of available spells
	for(var/obj/effect/proc_holder/spell/S in mind.spell_list)
		spell_options[S] = image(icon = S.action_icon, icon_state = S.overlay_state)

	// Add option to clear the slot
	spell_options["Clear Slot"] = image(icon = 'icons/hud/radial.dmi', icon_state = "clear_slot")

	var/choice = show_radial_menu(src, creation, spell_options, radial_slice_icon = "radial_thaum")

	if(!choice)
		return

	if(choice == "Clear Slot")
		spell_quickslots[slot_index] = null
	else
		spell_quickslots[slot_index] = choice
