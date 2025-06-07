
/datum/enchantment/frostbite
	enchantment_name = "Frostbite"
	examine_text = "This weapon is covered in a thin layer of frost."
	enchantment_color = "#87CEEB"
	enchantment_end_message = "The frost melts away."
	essence_recipe = list(
		/datum/thaumaturgical_essence/frost = 30,
		/datum/thaumaturgical_essence/poison = 15,
		/datum/thaumaturgical_essence/water = 10
	)
	var/list/last_used = list()

/datum/enchantment/frostbite/on_hit(obj/item/source, atom/target, mob/user, proximity_flag, click_parameters)
	if(world.time < (src.last_used[source] + (20 SECONDS)))
		return

	if(isliving(target))
		var/mob/living/L = target
		L.apply_damage(5, BURN)
		to_chat(L, span_warning("You feel a bone-chilling cold!"))
		L.add_movespeed_modifier("frostbite", 0.5)
		addtimer(CALLBACK(L, TYPE_PROC_REF(/mob/living, remove_movespeed_modifier), "frostbite"), 10 SECONDS)
	last_used[source] = world.time
