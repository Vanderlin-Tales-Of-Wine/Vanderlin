/datum/stock/import
	import_only = TRUE
	stable_price = TRUE

/datum/stock/import/crackers
	name = "Bin of Rations"
	desc = "Low moisture bread that keeps well."
	item_type = /obj/item/bin/crackers
	export_price = 100
	importexport_amt = 1

/obj/item/bin/crackers/Initialize()
	. = ..()
	new /obj/item/reagent_containers/food/snacks/hardtack(src)
	new /obj/item/reagent_containers/food/snacks/hardtack(src)
	new /obj/item/reagent_containers/food/snacks/hardtack(src)
	new /obj/item/reagent_containers/food/snacks/hardtack(src)
	new /obj/item/reagent_containers/food/snacks/hardtack(src)
	new /obj/item/reagent_containers/food/snacks/hardtack(src)
	new /obj/item/reagent_containers/food/snacks/hardtack(src)
	new /obj/item/reagent_containers/food/snacks/hardtack(src)
	new /obj/item/reagent_containers/food/snacks/hardtack(src)
	new /obj/item/reagent_containers/food/snacks/hardtack(src)

/obj/structure/closet/crate/chest/steward
	lockid = "steward"
	locked = TRUE
	masterkey = TRUE

/datum/stock/import/wheat
	name = "Crate of Wheat"
	desc = "Wheat."
	item_type = /obj/structure/closet/crate/chest/steward/wheat
	export_price = 150
	importexport_amt = 1

/obj/structure/closet/crate/chest/steward/wheat/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/food/snacks/produce/wheat(src)
