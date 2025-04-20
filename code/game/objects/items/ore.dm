/obj/item/ore
	name = "ore"
	icon = 'icons/roguetown/items/ore.dmi'
	icon_state = "ore"
	w_class = WEIGHT_CLASS_NORMAL
	resistance_flags = FIRE_PROOF
	grid_width = 32
	grid_height = 32
	melt_amount = 120

/obj/item/ore/gold
	name = "raw gold"
	icon_state = "oregold1"
	smeltresult = /obj/item/ingot/gold
	sellprice = 10
	melting_material = /datum/material/gold
	item_weight = 6.2 * GOLD_MULITPLIER

/obj/item/ore/gold/Initialize()
	icon_state = "oregold[rand(1,3)]"
	..()


/obj/item/ore/silver
	name = "raw silver"
	icon_state = "oresilv1"
	smeltresult = /obj/item/ingot/silver
	sellprice = 8
	melting_material = /datum/material/silver
	item_weight = 6.2 * SILVER_MULTIPLIER

/obj/item/ore/silver/Initialize()
	icon_state = "oresilv[rand(1,3)]"
	..()


/obj/item/ore/iron
	name = "raw iron"
	icon_state = "oreiron1"
	smeltresult = /obj/item/ingot/iron
	sellprice = 5
	melting_material = /datum/material/iron
	item_weight = 6.2 * IRON_MULTIPLIER

/obj/item/ore/iron/Initialize()
	icon_state = "oreiron[rand(1,3)]"
	..()


/obj/item/ore/copper
	name = "raw copper"
	icon_state = "orecop1"
	smeltresult = /obj/item/ingot/copper
	sellprice = 2
	melting_material = /datum/material/copper
	item_weight = 6.2 * COPPER_MULTIPLIER

/obj/item/ore/copper/Initialize()
	icon_state = "orecop[rand(1,3)]"
	..()

/obj/item/ore/tin
	name = "raw tin"
	desc = "A mass of soft, almost malleable white ore."
	icon_state = "oretin1"
	smeltresult = /obj/item/ingot/tin
	sellprice = 4
	melting_material = /datum/material/tin
	item_weight = 6.2 * TIN_MULTIPLIER

/obj/item/ore/tin/Initialize()
	icon_state = "oretin[rand(1,3)]"
	..()

/obj/item/ore/coal
	name = "coal"
	icon_state = "orecoal1"
	firefuel = 5 MINUTES
	smeltresult = /obj/item/ore/coal
	sellprice = 1
	item_weight = 7

/obj/item/ore/coal/Initialize()
	icon_state = "orecoal[rand(1,3)]"
	..()

/obj/item/ore/cinnabar
	name = "cinnabar"
	desc = "Red gems that contain the essence of quicksilver."
	icon_state = "orecinnabar"
	grind_results = list(/datum/reagent/mercury = 15)
	sellprice = 5
	item_weight = 6.2

/obj/item/ingot
	name = "ingot"
	desc = "A parent bar of metal. If you see this, report it on github."
	icon = 'icons/roguetown/items/ore.dmi'
	icon_state = "ingot"
	w_class = WEIGHT_CLASS_NORMAL
	smeltresult = null
	resistance_flags = FIRE_PROOF

	grid_width = 64
	grid_height = 32
	melt_amount = 100
	var/datum/anvil_recipe/currecipe
	var/quality = SMELTERY_LEVEL_NORMAL

/obj/item/ingot/examine()
	. += ..()
	if(currecipe)
		. += "<span class='warning'>It is currently being worked on to become [currecipe.recipe_name].</span>"

/obj/item/ingot/Initialize(mapload, smelt_quality)
	. = ..()
	if(smelt_quality)
		quality = smelt_quality
		smelted = TRUE
		switch(quality)
			if(SMELTERY_LEVEL_SPOIL)
				name = "spoilt [name]"
				desc += " It is practically scrap."
			if(SMELTERY_LEVEL_POOR)
				name = "poor-quality [name]"
				desc += " It is of dubious quality." // EA NASSIR, WHEN I GET YOU...
			if(SMELTERY_LEVEL_GOOD)
				name = "good-quality [name]"
				desc += " It is of exquisite quality."

/obj/item/ingot/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/weapon/tongs))
		var/obj/item/weapon/tongs/T = I
		if(!T.held_item)
			if(item_flags & IN_STORAGE)
				if(!SEND_SIGNAL(loc, COMSIG_TRY_STORAGE_TAKE, src, user.loc, TRUE))
					return ..()
			forceMove(T)
			T.held_item = src
			T.hott = null
			T.update_icon()
			return
	..()

/obj/item/ingot/Destroy()
	if(currecipe)
		QDEL_NULL(currecipe)
	if(istype(loc, /obj/machinery/anvil))
		var/obj/machinery/anvil/A = loc
		A.hingot = null
		A.update_icon()
	..()

/obj/item/ingot/gold
	name = "gold bar"
	desc = "A bar of glittering gold."
	icon_state = "ingotgold"
	smeltresult = /obj/item/ingot/gold
	sellprice = 100
	melting_material = /datum/material/gold
	item_weight = 7.5 * GOLD_MULITPLIER

/obj/item/ingot/iron
	name = "iron bar"
	desc = "A bar of wrought iron."
	icon_state = "ingotiron"
	smeltresult = /obj/item/ingot/iron
	sellprice = 25
	melting_material = /datum/material/iron
	item_weight = 7.5 * IRON_MULTIPLIER

/obj/item/ingot/copper
	name = "copper bar"
	desc = "A bar of copper."
	icon_state = "ingotcop"
	smeltresult = /obj/item/ingot/copper
	sellprice = 10
	melting_material = /datum/material/copper
	item_weight = 7.5 * COPPER_MULTIPLIER

/obj/item/ingot/tin
	name = "tin bar"
	desc = "An ingot of strangely soft and malleable essence."
	icon_state = "ingottin"
	smeltresult = /obj/item/ingot/tin
	sellprice = 15
	melting_material = /datum/material/tin
	item_weight = 7.5 * TIN_MULTIPLIER

/obj/item/ingot/bronze
	name = "bronze bar"
	desc = "A hard and durable alloy favored by engineers and followers of Malum alike."
	icon_state = "ingotbronze"
	smeltresult = /obj/item/ingot/bronze
	sellprice = 30
	melting_material = /datum/material/bronze
	item_weight = 7.5 * BRONZE_MULTIPLIER

/obj/item/ingot/silver
	name = "silver bar"
	desc = "A bar of glistening silver. The bane of nitewalkers."
	icon_state = "ingotsilv"
	smeltresult = /obj/item/ingot/silver
	sellprice = 60
	melting_material = /datum/material/silver
	item_weight = 7.5 * SILVER_MULTIPLIER

/obj/item/ingot/steel
	name = "steel bar"
	desc = "A bar of alloyed steel."
	icon_state = "ingotsteel"
	smeltresult = /obj/item/ingot/steel
	sellprice = 40
	melting_material = /datum/material/steel
	item_weight = 7.5 * STEEL_MULTIPLIER

/obj/item/ingot/blacksteel
	name = "blacksteel bar"
	desc = "Sacrificing the holy elements of silver for raw strength, this strange and powerful ingot's origin carries dark rumors.."
	icon_state = "ingotblacksteel"
	smeltresult = /obj/item/ingot/blacksteel
	sellprice = 90
	melting_material = /datum/material/blacksteel
	item_weight = 7.5 * BLACKSTEEL_MULTIPLIER
