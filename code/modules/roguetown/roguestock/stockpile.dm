// Guidelines for Stockpiles. Items should always cost ~50% more to withdraw than was recieved for depositing.
// Export Prices should fall between the payout and the withdraw, unless the item is incredibly cheap.

/datum/roguestock/stockpile/wood
	name = "Small Log"
	desc = "Wooden logs cut short for transport."
	item_type = /obj/item/grown/log/tree/small
	held_items = 5
	payout_price = 4
	withdraw_price = 6
	export_price = 5
	importexport_amt = 10

/datum/roguestock/stockpile/wood/plank
	name = "Wood Plank"
	desc = "Wooden planks ready to be worked."
	item_type = /obj/item/natural/wood/plank
	held_items = 4
	payout_price = 2
	withdraw_price = 4
	export_price = 3
	importexport_amt = 20

/datum/roguestock/stockpile/stone
	name = "Stone"
	desc = "Chunks of stone good for masonry and construction."
	item_type = /obj/item/natural/stone
	held_items = 5
	payout_price = 1
	withdraw_price = 2
	export_price = 2
	importexport_amt = 10

/datum/roguestock/stockpile/cloth
	name = "Cloth"
	desc = "Cloth sewn for further sewing and tailoring."
	item_type = /obj/item/natural/cloth
	held_items = 4
	payout_price = 3
	withdraw_price = 4
	export_price = 3
	importexport_amt = 10

/datum/roguestock/stockpile/hide
	name = "Hide"
	desc = "Hide stripped off of prey."
	item_type = /obj/item/natural/hide
	held_items = 0
	payout_price = 10
	withdraw_price = 15
	export_price = 12
	importexport_amt = 10

/datum/roguestock/stockpile/cured
	name = "Cured Leather"
	desc = "Cured Leather ready to be worked."
	item_type = /obj/item/natural/hide/cured
	held_items = 4
	payout_price = 5
	withdraw_price = 7
	export_price = 6
	importexport_amt = 10

/datum/roguestock/stockpile/fur
	name = "Fur"
	desc = "Hide with a long winter coat from animals."
	item_type = /obj/item/natural/fur
	held_items = 0
	payout_price = 5
	withdraw_price = 7
	export_price = 6
	importexport_amt = 10

/datum/roguestock/stockpile/silk
	name = "Silk"
	desc = "Strands of fine silk used for exotic weaving"
	item_type = /obj/item/natural/silk
	held_items = 4
	payout_price = 6
	withdraw_price = 8
	export_price = 7
	importexport_amt = 10

/datum/roguestock/stockpile/salt
	name = "Salt"
	desc = "Rock salt useful for curing and cooking."
	item_type = /obj/item/reagent_containers/powder/salt
	held_items = 5
	payout_price = 4
	withdraw_price = 6
	export_price = 5
	importexport_amt = 20

/datum/roguestock/stockpile/grain
	name = "Grain"
	desc = "Wheat grains primed for milling."
	item_type = /obj/item/reagent_containers/food/snacks/produce/wheat
	held_items = 5
	payout_price = 4
	withdraw_price = 6
	export_price = 5
	importexport_amt = 20

/datum/roguestock/stockpile/turnip
	name = "Turnips"
	desc = "A hearty root vegetable fit for soup."
	item_type = /obj/item/reagent_containers/food/snacks/produce/turnip
	held_items = 2
	payout_price = 3
	withdraw_price = 5
	export_price = 4
	importexport_amt = 20

/datum/roguestock/stockpile/potato
	name = "Potatoes"
	desc = "A reliable if tough vegetable of Dwarven popularity."
	item_type = /obj/item/reagent_containers/food/snacks/produce/potato
	held_items = 2
	payout_price = 4
	withdraw_price = 6
	export_price = 5
	importexport_amt = 20

/datum/roguestock/stockpile/coal
	name = "Coal"
	desc = "Chunks of coal used for fuel and alloying."
	item_type = /obj/item/rogueore/coal
	held_items = 5
	payout_price = 4
	withdraw_price = 6
	export_price = 5
	importexport_amt = 20

/datum/roguestock/stockpile/copper
	name = "Copper Ore"
	desc = "Raw unrefined copper."
	item_type = /obj/item/rogueore/copper
	held_items = 4
	payout_price = 4
	withdraw_price = 6
	export_price = 5
	importexport_amt = 10

/datum/roguestock/stockpile/tin
	name = "Tin Ore"
	desc = "Raw tin fit for alloying."
	item_type = /obj/item/rogueore/tin
	held_items = 4
	payout_price = 5
	withdraw_price = 7
	export_price = 6
	importexport_amt = 10

/datum/roguestock/stockpile/iron
	name = "Iron Ore"
	desc = "Raw unrefined iron."
	item_type = /obj/item/rogueore/iron
	held_items = 2
	payout_price = 8
	withdraw_price = 12
	export_price = 10
	importexport_amt = 10
