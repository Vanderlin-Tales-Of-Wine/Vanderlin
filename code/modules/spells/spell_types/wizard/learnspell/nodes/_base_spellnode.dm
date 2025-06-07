/datum/spell_node
	var/name = "Unknown Spell"
	var/desc = "A mysterious magical technique."
	var/icon = 'icons/mob/actions/roguespells.dmi'
	var/icon_state = "rune1"
	var/node_x = 0  // Position on the research tree
	var/node_y = 0
	var/list/prerequisites = list()  // List of spell node types required
	var/list/unlocks = list()  // Description of what this unlocks
	var/cost = 1  // Spell points required
	var/is_passive = FALSE  // Whether this is a passive ability instead of a spell
	var/obj/effect/proc_holder/spell/spell_type = null  // What spell this grants (null for passives)

/datum/spell_node/New()
	. = ..()
	if(spell_type)
		cost = spell_type.cost
		icon = spell_type.action_icon
		icon_state = spell_type.overlay_state

/datum/spell_node/proc/on_node_buy(mob/user)
	return
