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

	var/list/essence_recipe = list() // Format: list(/datum/thaumaturgical_essence/type = amount)

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
	if(!length(enchanter.enchantments))
		enchanter.enchantments = list()
	enchanter.enchantments |= src

	RegisterSignal(enchanter, COMSIG_PARENT_QDELETING, PROC_REF(remove_item))

	RegisterSignal(enchanter, COMSIG_ITEM_AFTERATTACK, PROC_REF(on_hit))
	RegisterSignal(enchanter, COMSIG_ITEM_EQUIPPED, PROC_REF(on_equip))
	RegisterSignal(enchanter, COMSIG_ITEM_PICKUP, PROC_REF(on_pickup))
	RegisterSignal(enchanter, COMSIG_ITEM_DROPPED, PROC_REF(on_drop))
	RegisterSignal(enchanter, COMSIG_ITEM_ATTACK_SELF, PROC_REF(on_use))
	RegisterSignal(enchanter, COMSIG_PARENT_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(enchanter, COMSIG_ITEM_HIT_RESPONSE, PROC_REF(on_hit_response))
	return TRUE

/datum/enchantment/proc/on_hit(obj/item/source, atom/target, mob/user, proximity_flag, click_parameters)

/datum/enchantment/proc/on_equip(obj/item/i, mob/living/user)

/datum/enchantment/proc/on_pickup(obj/item/i, mob/living/user)

/datum/enchantment/proc/on_use(obj/item/i, mob/living/user)

/datum/enchantment/proc/on_drop(obj/item/i, mob/living/user)		//when enchanted item is dropped, do effect
	addtimer(CALLBACK(src, PROC_REF(drop_effects), i, user), 1)

/datum/enchantment/proc/drop_effects(obj/item/i, mob/living/user)

/datum/enchantment/proc/projectile_hit(atom/fired_from, atom/movable/firer, atom/target, Angle)	//effects when shooting a protectile from an enchanted item

/datum/enchantment/proc/on_hit_response(obj/item/I, mob/living/carbon/human/owner, mob/living/carbon/human/attacker)//use for worn items such as armor to have effects on hit.

/datum/enchantment/proc/remove_item(datum/weakref/weakref)
	var/atom/item
	if(!istype(weakref))
		item = weakref
	else
		item = weakref.resolve()
	if(!item)
		return
	if(item in affected_items)
		affected_items -= item
		if(enchantment_end_message)
			item.visible_message(enchantment_end_message)
	item.enchantments -= src
	UnregisterSignal(item, list(COMSIG_PARENT_QDELETING, COMSIG_ITEM_AFTERATTACK, COMSIG_ITEM_EQUIPPED, COMSIG_ITEM_DROPPED, COMSIG_ITEM_PICKUP, COMSIG_ITEM_ATTACK_SELF, COMSIG_PARENT_EXAMINE))

/datum/enchantment/proc/on_examine(datum/source, mob/user, list/examine_list)
	if(examine_text)
		examine_list += span_info(examine_text)
