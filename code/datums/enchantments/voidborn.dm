
/datum/enchantment/void_touched
	enchantment_name = "Void Touched"
	examine_text = "This item seems to absorb light around it, existing partially outside reality."
	enchantment_color = "#2F2F2F"
	enchantment_end_message = "The item returns to normal reality."
	essence_recipe = list(
		/datum/thaumaturgical_essence/void = 60,
		/datum/thaumaturgical_essence/magic = 40,
		/datum/thaumaturgical_essence/chaos = 35,
		/datum/thaumaturgical_essence/energia = 25
	)
	var/list/last_used = list()

/datum/enchantment/void_touched/on_hit(obj/item/source, atom/target, mob/user, proximity_flag, click_parameters)
	if(world.time < (src.last_used[source] + (1 MINUTES + 40 SECONDS))) //thanks borbop
		return

	if(isliving(target) && prob(15))
		var/mob/living/L = target
		to_chat(L, span_warning("You feel reality warp around you!"))
		var/list/possible_turfs = list()
		for(var/turf/T in range(3, L))
			if(T.density)
				continue
			possible_turfs += T
		if(possible_turfs.len)
			L.forceMove(pick(possible_turfs))
	last_used[source] = world.time
