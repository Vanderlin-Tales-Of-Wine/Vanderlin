
/obj/item/reagent_containers/food/snacks/spiderhoney
	name = "honeycomb"
	desc = ""
	icon_state = "honey"
	dropshrink = 0.8
	possible_transfer_amounts = list()
	spillable = FALSE
	volume = 10
	amount_per_transfer_from_this = 0
	list_reagents = list(/datum/reagent/consumable/honey = 5, /datum/reagent/consumable/nutriment = SNACK_DECENT)
	grind_results = list()
	tastes = list("sweetness" = 1)

/obj/item/reagent_containers/food/snacks/spiderhoney/Initialize()
	. = ..()
	pixel_x = rand(8,-8)
	pixel_y = rand(8,-8)

/obj/item/reagent_containers/food/snacks/spiderhoney/proc/set_reagent(reagent)
	var/datum/reagent/R = GLOB.chemical_reagents_list[reagent]
	if(istype(R))
		name = "honeycomb ([R.name])"
		reagents.add_reagent(R.type,5)

/obj/item/reagent_containers/food/snacks/spiderhoney/honey
	name = "honey"
	icon_state = "honeycomb"
	tastes = list("sweetness" = 1)
