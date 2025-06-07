
/datum/enchantment/life_eternal
	enchantment_name = "Life Eternal"
	examine_text = "This item radiates with the pure essence of life itself."
	enchantment_color = "#FF69B4"
	enchantment_end_message = "The life essence fades away."
	essence_recipe = list(
		/datum/thaumaturgical_essence/life = 80,
		/datum/thaumaturgical_essence/cycle = 50,
		/datum/thaumaturgical_essence/magic = 35,
		/datum/thaumaturgical_essence/light = 30
	)

/datum/enchantment/life_eternal/on_equip(obj/item/i, mob/living/user)
	// Constant slow healing while equipped
	START_PROCESSING(SSobj, src)

/datum/enchantment/life_eternal/process()
	for(var/obj/item/I in affected_items)
		if(I.loc && isliving(I.loc))
			var/mob/living/L = I.loc
			if(L.health < L.maxHealth)
				L.heal_bodypart_damage(1, 1)
