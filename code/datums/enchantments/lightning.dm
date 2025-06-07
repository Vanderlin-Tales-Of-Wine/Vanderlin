
/datum/enchantment/lightning
	enchantment_name = "Lightning"
	examine_text = "Small arcs of electricity dance across this weapon."
	enchantment_color = "#FFFF00"
	enchantment_end_message = "The electrical energy dissipates."
	essence_recipe = list(
		/datum/thaumaturgical_essence/energia = 45,
		/datum/thaumaturgical_essence/air = 25,
		/datum/thaumaturgical_essence/chaos = 15
	)

	var/list/last_used = list()

/datum/enchantment/lightning/on_hit(obj/item/source, atom/target, mob/user, proximity_flag, click_parameters)
	if(world.time < (src.last_used[source] + (1 MINUTES + 40 SECONDS))) //thanks borbop
		return

	if(isliving(target))
		var/mob/living/L = target
		L.electrocute_act(10, source, 1)

		for(var/mob/living/nearby in range(2, target))
			if(nearby == target || nearby == user)
				continue
			if(prob(30))
				nearby.electrocute_act(5, source, 1)
				new /obj/effect/temp_visual/lightning(get_turf(target), get_turf(nearby))
	last_used[source] = world.time
