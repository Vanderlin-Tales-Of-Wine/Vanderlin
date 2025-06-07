/datum/enchantment/mana_regeneration
	enchantment_name = "Mana Regeneration"
	examine_text = "Mana flows freely from this object."

	should_process = TRUE
	essence_recipe = list(
		/datum/thaumaturgical_essence/energia = 35,
		/datum/thaumaturgical_essence/cycle = 25
	)
	var/regeneration_rate = 2

/datum/enchantment/mana_regeneration/process()
	for(var/obj/item/item in affected_items)
		if(!iscarbon(item.loc))
			continue
		var/mob/living/carbon/mob = item.loc
		mob.safe_adjust_personal_mana(regeneration_rate)
