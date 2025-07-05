/mob/living/var/list/spell_quickslots = list()

/mob/living/proc/spell_quickselect(atom/clicked_atom, params)
	if(!mind)
		return

	var/list/radial_options = list()

	for(var/i in 1 to 6)
		var/datum/action/cooldown/spell/stored_spell = get_spell(spell_quickslots[i])
		if(stored_spell)
			radial_options["[i]"] = mutable_appearance(stored_spell.button_icon, stored_spell.button_icon_state)
		else
			radial_options["[i]"] = mutable_appearance('icons/hud/radial.dmi', "empty_slot")

	var/choice = show_radial_menu(src, get_turf(clicked_atom), radial_options, radial_slice_icon = "radial_thaum", click_on_hover = TRUE)

	if(!choice)
		return

	var/list/modifiers = params2list(params)

	var/slot_index = text2num(choice)
	if(LAZYACCESS(modifiers, SHIFT_CLICKED) || !spell_quickslots[slot_index])
		assign_spell_to_slot(slot_index, get_turf(clicked_atom))
		return
	var/datum/action/cooldown/spell/selected_spell = get_spell(spell_quickslots[slot_index])
	if(selected_spell)
		var/trigger_flags
		if(LAZYACCESS(modifiers, RIGHT_CLICK))
			trigger_flags |= TRIGGER_SECONDARY_ACTION
		selected_spell.Trigger(trigger_flags)

#define CLEAR_SLOT "Clear Slot"

/mob/living/proc/assign_spell_to_slot(slot_index, turf/creation)
	if(length(actions))
		return

	var/list/spell_options = list()

	// Build list of available spells
	for(var/datum/action/cooldown/spell/spell in actions)
		spell_options[spell] = mutable_appearance(spell.button_icon, spell.button_icon_state)

	// Add option to clear the slot
	spell_options[CLEAR_SLOT] = mutable_appearance('icons/hud/radial.dmi', "clear_slot")

	var/choice = show_radial_menu(src, creation, spell_options, radial_slice_icon = "radial_thaum")

	if(!choice)
		return

	if(choice == CLEAR_SLOT)
		spell_quickslots[slot_index] = null
	else if(istype(choice, /datum))
		var/datum/selected = choice
		spell_quickslots[slot_index] = selected.type

#undef CLEAR_SLOT
