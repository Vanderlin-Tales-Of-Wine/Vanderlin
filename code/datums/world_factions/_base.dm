///this is the only one that exists for now
///but its way better to put the information on this
///so when we actually get them switching won't be hard

/datum/world_faction
	var/name = "World"
	var/desc = "The entirety of the world"

	var/faction_name

	var/list/sell_value_modifiers = list()
	var/list/last_sell_modification = list()
	///this tracks sprint sells, so things sold in large bulks it starts to decrease when the price restabilizes
	var/list/sold_count = list()
	///for when we print out a selling manifest we have this which shows the price decreases
	var/list/price_change_manifest = list()

	///modifiers that are hard set by the faction think zybantine needing food more cause desert.
	var/list/hard_value_multipliers = list()

	///this is our town reputation, this changes the buy and sell modifiers on a faction to faction basis
	var/faction_reputation = 0

/datum/world_faction/proc/handle_world_change()
	for(var/obj/atom as anything in last_sell_modification)
		if(last_sell_modification[atom] > world.time - 15 MINUTES)
			continue
		var/current_price = initial(atom.sellprice) * return_sell_modifier(atom)
		sold_count[atom]--
		adjust_sell_multiplier(atom, rand(0.05, 0.15), 1)
		if(return_sell_modifier(atom) == 1)
			last_sell_modification -= atom
		var/new_price = initial(atom.sellprice) * return_sell_modifier(atom)

		if(new_price != current_price)
			changed_sell_prices(atom, current_price, new_price)

/datum/world_faction/proc/adjust_sell_multiplier(obj/change_type, change = 0, maximum)
	if(!change || !change_type)
		return
	sell_value_modifiers[change_type] += change
	if(sell_value_modifiers[change_type] < 0.1)
		sell_value_modifiers[change_type] = 0.1

	if(maximum)
		if(sell_value_modifiers[change_type] > maximum)
			sell_value_modifiers[change_type] = maximum

	last_sell_modification |= change_type
	last_sell_modification[change_type] = world.time


/datum/world_faction/proc/handle_selling(obj/selling_type)
	sold_count |= selling_type
	sold_count[selling_type]++

	///basically guarenteed diminish after 10 sells of an item.
	if(!prob(sold_count[selling_type] * 10))
		return

	adjust_sell_multiplier(selling_type, -rand(0.01, 0.1))

/datum/world_faction/proc/changed_sell_prices(atom/atom_type, old_price, new_price)
	price_change_manifest |= atom_type
	price_change_manifest[atom_type] = list("[old_price]", "[new_price]")

/datum/world_faction/proc/draw_selling_changes()
	var/index_num = 0
	var/list/sell_data = list()
	for(var/atom/list_type as anything in price_change_manifest)
		if(index_num >= 4)
			SSmerchant.sending_stuff |= new /obj/item/paper/scroll/sell_price_changes(null, sell_data, faction_name)
			index_num = 0
			sell_data = list()
			continue
		sell_data |= list_type
		var/list/prices = price_change_manifest[list_type]
		sell_data[list_type] = prices.Copy()

	if(length(sell_data))
		SSmerchant.sending_stuff |= new /obj/item/paper/scroll/sell_price_changes(null, sell_data, faction_name)


/datum/world_faction/proc/return_sell_modifier(atom/sell_type)
	var/static_modifer = 1
	if(sell_type in hard_value_multipliers)
		static_modifer = hard_value_multipliers[sell_type]
	if(!(sell_type in sell_value_modifiers))
		return 1 * static_modifer
	return sell_value_modifiers[sell_type] * static_modifer

/datum/world_faction/proc/setup_sell_data(atom/sell_type)
	sell_value_modifiers |= sell_type
	sell_value_modifiers[sell_type] = 1
