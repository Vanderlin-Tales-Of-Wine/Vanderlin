/datum/enchantment/leaping
	enchantment_name = "Leaping"
	examine_text = "It vibrates faintly with bound movement."
	essence_recipe = list(
		/datum/thaumaturgical_essence/motion = 30,
		/datum/thaumaturgical_essence/air = 20
	)
	var/active_item

/datum/enchantment/leaping/on_equip(obj/item/i, mob/living/user, slot)
	.=..()
	if(slot == SLOT_HANDS)
		return
	if(active_item)
		return
	else
		active_item = TRUE
		ADD_TRAIT(user, TRAIT_ZJUMP, TRAIT_GENERIC)
		to_chat(user, span_notice("My legs feel much stronger."))

/datum/enchantment/leaping/on_drop(obj/item/i, mob/living/user)
	if(active_item)
		active_item = FALSE
		REMOVE_TRAIT(user, TRAIT_ZJUMP, TRAIT_GENERIC)
		to_chat(user, span_notice("I feel mundane once more."))
