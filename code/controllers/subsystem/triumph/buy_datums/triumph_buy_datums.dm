/*
	TO NOTE THERE WILL BE A LOT OF SNOWFLAKE BEHAVIOR
*/


/datum/triumph_buy
	var/triumph_buy_id = "ERROR" // This serves no purpose rn other than to stop duplicates in certain places
	var/key_of_buyer = null // Key of the person who bought it.
	var/ckey_of_buyer = null //ckey of the person who bought it. I don't feel like dealing with the fact zeth used key for triumphs

	var/desc = "ERROR  " // desc shown for it on the menu
	var/triumph_cost = 107 // cost in triumphs for something
	var/category = TRIUMPH_CAT_ACTIVE_DATUMS // category we sort something into
	var/visible_on_active_menu = FALSE // Whether we are visible on active menu
	var/pre_round_only = FALSE // Whether its pre-round only

	var/list/conflicts_with = list() // List of things it can conflict with


// We fire this when someone buys it, aka right after its made and its bein inserted places.
/datum/triumph_buy/proc/on_buy()
	on_activate() // default behavior

// We fire this shit when someones trying to remove it aka unbuy or otherwise
/datum/triumph_buy/proc/on_removal()
	return

// We fire this on activate
/datum/triumph_buy/proc/on_activate(mob/living/carbon/human/H)
	return
