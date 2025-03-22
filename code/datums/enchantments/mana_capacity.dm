/datum/enchantment/mana_capacity
	enchantment_name = "Mana Capacity"
	examine_text = "I can feel this objects mana and use it freely."

	var/softcap_increase = 20
	var/hardcap_increase = 1000

	var/list/affecting_mobs = list()

/datum/enchantment/mana_capacity/on_equip(obj/item/source, mob/living/carbon/equipper, slot)
	if(!(source in affecting_mobs))
		affecting_mobs |= source
		affecting_mobs[source] = list()
	if(equipper in affecting_mobs[source])
		return
	affecting_mobs[source] |= equipper

	equipper.mana_pool.softcap += softcap_increase
	equipper.mana_pool.set_max_mana(equipper.mana_pool.maximum_mana_capacity + hardcap_increase)


/datum/enchantment/mana_capacity/on_drop(datum/source, mob/living/carbon/user)
	if(!(source in affecting_mobs))
		affecting_mobs |= source
		affecting_mobs[source] = list()
	if(!istype(user))
		return
	if(user in affecting_mobs[source])
		return
	affecting_mobs[source] -= user

	user.mana_pool.softcap -= softcap_increase
	user.mana_pool?.set_max_mana(user.mana_pool.maximum_mana_capacity - hardcap_increase)
