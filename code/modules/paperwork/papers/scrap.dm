/obj/item/paper/bsmith
	info = "It's easy to smith. Put ores in the smelter. Put ingots on the anvil. Use your tongs to handle ingots. Hit them with the hammer. Quench hot ingots in the barrel (there must be water in it). Steel is an alloy from iron and coal, find the golden ratio"

/obj/item/paper/heartfelt/goal3
	info = "Establish a diplomatic alliance with the local Monarch to strengthen the relationship between Heartfelt and this minor nation."

/obj/item/paper/heartfelt/goal2
	info = "Explore the mysteries of these lands, uncovering its secrets and hidden treasures."

/obj/item/paper/heartfelt/goal1
	info = "Sway the local Mercator guild to support our cause discreetly. Too much trade passses our realm by and these yokels get the tax revenue, unacceptable."

/obj/item/paper/heartfelt/goal4
	info = "Our lands have long been forsaken by Dendor, Our fields are failing and the famine is causing unrest in our realm. Seek royal largesse"

/obj/item/paper/heartfelt/random/Initialize()
	..()
	var/type = pick(typesof(/obj/item/paper/heartfelt) - /obj/item/paper/heartfelt/random)
	new type(loc)
	return INITIALIZE_HINT_QDEL
