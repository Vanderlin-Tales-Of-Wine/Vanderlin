PROCESSING_SUBSYSTEM_DEF(enchantment)
	name = "Enchantments"
	priority = FIRE_PRIORITY_ENCHANTMENT
	flags = SS_BACKGROUND
	wait = 2 SECONDS

	var/list/enchantments_to_list = list()
	var/list/weighted_enchantments = list()

/datum/controller/subsystem/processing/enchantment/Initialize(start_timeofday)
	for(var/datum/enchantment/enchantment as anything in subtypesof(/datum/enchantment))
		enchantments_to_list |= enchantment
		enchantments_to_list[enchantment] = new enchantment
		weighted_enchantments |= enchantment
		weighted_enchantments[enchantment] = initial(enchantment.random_enchantment_weight)
	return ..()

/datum/controller/subsystem/processing/enchantment/proc/has_enchantment(atom/item, datum/enchantment/path)
	if(!item || !path)
		return FALSE
	if(!(path in enchantments_to_list))
		return FALSE
	var/datum/enchantment/real = enchantments_to_list[path]
	if(!(item in real.affected_items))
		return FALSE
	return TRUE

/datum/controller/subsystem/processing/enchantment/proc/has_any_enchantment(atom/item)
	for(var/enchantment as anything in enchantments_to_list)
		if(has_enchantment(item, enchantment))
			return TRUE
	return FALSE

/datum/controller/subsystem/processing/enchantment/proc/remove_enchantment(atom/item)
	for(var/enchantment as anything in enchantments_to_list)
		if(has_enchantment(item, enchantment))
			var/datum/enchantment/real = enchantments_to_list[enchantment]
			real.remove_item(WEAKREF(item))
			return TRUE
	return FALSE

/datum/controller/subsystem/processing/enchantment/proc/enchant_item(atom/item, datum/enchantment/enchantment)
	if(!item || !enchantment)
		return FALSE
	if(!(enchantment in enchantments_to_list))
		return FALSE
	if(has_any_enchantment(item))
		return FALSE

	var/datum/enchantment/real = enchantments_to_list[enchantment]
	real.add_item(item)
