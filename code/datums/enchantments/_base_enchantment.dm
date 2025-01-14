/atom
	///this is the path to the enchantment not the actual enchantment
	var/datum/enchantment/enchantment_path

/obj/item/proc/enchant(datum/enchantment/path)
	if(!path)
		path = pickweight(SSenchantment.weighted_enchantments)
	SSenchantment.enchant_item(src, path)

/obj/item/proc/has_enchantment(datum/enchantment/path)
	return SSenchantment.has_enchantment(src, path)


/datum/enchantment
	var/list/affected_items = list()
	var/starting_duration = 15 MINUTES
	var/examine_text
	var/enchantment_name
	var/enchantment_end_message
	var/random_enchantment_weight = 10

	var/list/enchantment_sacrifices = list()

	var/should_process = FALSE
	var/enchantment_color = COLOR_BLUE_GRAY

/datum/enchantment/New()
	. = ..()
	if(should_process)
		START_PROCESSING(SSenchantment, src)

/datum/enchantment/Destroy(force, ...)
	. = ..()
	if(should_process)
		STOP_PROCESSING(SSenchantment, src)

/datum/enchantment/proc/add_item(atom/enchanter)
	affected_items |= enchanter

	RegisterSignal(enchanter, COMSIG_PARENT_QDELETING, PROC_REF(remove_item))

	if(starting_duration)
		addtimer(CALLBACK(src, PROC_REF(remove_item), WEAKREF(enchanter)), starting_duration)
	return TRUE

/datum/enchantment/proc/remove_item(datum/weakref/weakref)
	var/atom/item = weakref.resolve()
	if(!item)
		return
	if(item in affected_items)
		affected_items -= item
		if(enchantment_end_message)
			item.visible_message(enchantment_end_message)
	item.enchantment_path = null
