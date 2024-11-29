/datum/roguestock/stockpile/wood
	name = "Wood"
	desc = "Wooden logs cut short for transport."
	item_type = /obj/item/grown/log/tree/small
	held_items = 3
	payout_price = 2
	withdraw_price = 4
	//transport_fee = 2
	export_price = 4
	importexport_amt = 10

/datum/roguestock/stockpile/wood/plank
	name = "Wood Plank"
	desc = "Wooden planks ready to be worked."
	item_type = /obj/item/natural/wood/plank
	held_items = 2
	payout_price = 4
	withdraw_price = 6
	export_price = 4
	importexport_amt = 20

/datum/roguestock/stockpile/stone
	name = "Stone"
	desc = "High quality rocks of stone used for construction."
	item_type = /obj/item/natural/rock
	held_items = 2
	payout_price = 1
	withdraw_price = 6
	export_price = 2
	importexport_amt = 10

/datum/roguestock/stockpile/coal
	name = "Coal"
	desc = "Chunks of coal used for fuel and alloying."
	item_type = /obj/item/rogueore/coal
	held_items = 5
	payout_price = 4
	withdraw_price = 8
	export_price = 5
	importexport_amt = 20

/datum/roguestock/stockpile/cloth
	name = "Cloth"
	desc = "Lengths of cloth for sewing and tailoring."
	item_type = /obj/item/natural/cloth
	held_items = 2
	payout_price = 1
	withdraw_price = 2
	export_price = 3
	importexport_amt = 15

/datum/roguestock/stockpile/hide
	name = "Hide"
	desc = "Stripped hide from animals."
	item_type = /obj/item/natural/hide
	held_items = 0
	payout_price = 10
	withdraw_price = 15
	export_price = 12
	importexport_amt = 10

/datum/roguestock/stockpile/fur
	name = "Fur"
	desc = "Hide with a long winter coat from animals."
	item_type = /obj/item/natural/fur
	held_items = 0
	payout_price = 4
	withdraw_price = 6
	export_price = 4
	importexport_amt = 10

/datum/roguestock/stockpile/silk
	name = "Silk"
	desc = "Strands of fine silk used for exotic weaving"
	item_type = /obj/item/natural/silk
	held_items = 7
	payout_price = 4
	withdraw_price = 6
	export_price = 6
	importexport_amt = 10

/datum/roguestock/stockpile/salt
	name = "Salt"
	desc = "Rock salt useful for curing and cooking."
	item_type = /obj/item/reagent_containers/powder/salt
	held_items = 2
	payout_price = 4
	withdraw_price = 6
	export_price = 8
	importexport_amt = 15

/datum/roguestock/stockpile/grain
	name = "Grain"
	desc = "Spelt grain."
	item_type = /obj/item/reagent_containers/food/snacks/produce/wheat
	payout_price = 2
	export_price = 5
	withdraw_price = 5
	importexport_amt = 20

/datum/roguestock/stockpile/turnip
	name = "Turnips"
	desc = "The spine of many communities."
	item_type = /obj/item/reagent_containers/food/snacks/produce/turnip
	payout_price = 2
	export_price = 4
	withdraw_price = 3
	importexport_amt = 20

/datum/roguestock/stockpile/iron
	name = "Iron Ore"
	desc = "Raw unrefined iron ore."
	item_type = /obj/item/rogueore/iron
	payout_price = 5
	withdraw_price = 15
	export_price = 12
	importexport_amt = 10

/datum/roguestock/stockpile/copper
	name = "Copper Ingot"
	desc = "Low-Cost Copper Ingots from Zybantu." // Hinting at the increasing price in the future/ore
	item_type = /obj/item/ingot/copper
	payout_price = 5
	withdraw_price = 10
	export_price = 12
	importexport_amt = 10

/datum/roguestock/stockpile/tin
	name = "Raw Tin"
	desc = "Chunks of tin used for smithing and alloying."
	item_type = /obj/item/rogueore/tin
	held_items = 6
	payout_price = 4
	withdraw_price = 5
	//transport_fee = 4
	export_price = 5
	importexport_amt = 10

/datum/roguestock/stockpile/silver
	name = "Raw Silver"
	desc = "Chunks of unrefined silver."
	item_type = /obj/item/rogueore/silver
	held_items = 0
	payout_price = 75
	withdraw_price = 100
	//transport_fee = 10
	export_price = 100
	importexport_amt = 10
