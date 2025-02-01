
/obj/item/reagent_containers/food/snacks/spiderhoney
	name = "honeycomb"
	desc = ""
	icon_state = "honey"
	dropshrink = 0.8
	possible_transfer_amounts = list()
	spillable = FALSE
	disease_amount = 0
	volume = 10
	amount_per_transfer_from_this = 0
	list_reagents = list(/datum/reagent/consumable/honey = 5, /datum/reagent/consumable/nutriment = SNACK_DECENT)
	grind_results = list()
	var/honey_color = ""
	tastes = list("sweetness" = 1)

/obj/item/reagent_containers/food/snacks/spiderhoney/Initialize()
	. = ..()
	pixel_x = rand(8,-8)
	pixel_y = rand(8,-8)
	update_icon()


/obj/item/reagent_containers/food/snacks/spiderhoney/update_icon()
	cut_overlays()
	var/mutable_appearance/honey_overlay = mutable_appearance(icon, /datum/reagent/consumable/honey)
	if(honey_color)
		honey_overlay.icon_state = "greyscale_honey"
		honey_overlay.color = honey_color
	add_overlay(honey_overlay)


/obj/item/reagent_containers/food/snacks/spiderhoney/proc/set_reagent(reagent)
	var/datum/reagent/R = GLOB.chemical_reagents_list[reagent]
	if(istype(R))
		name = "honeycomb ([R.name])"
		honey_color = R.color
		reagents.add_reagent(R.type,5)
	else
		honey_color = ""
	update_icon()
