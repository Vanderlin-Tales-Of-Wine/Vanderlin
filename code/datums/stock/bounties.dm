/*
* This is a datum for sending
* treasures to the vault without
* having to talk to the steward.
*/

/datum/stock/bounty/treasure
	name = "Collectable Treasures"
	desc = "Treasures are sent to the vault, where they accrue value over time. Payout is a percentage is based on the price of the treasure, with taxes removed from the payout after."
	item_type = /obj/item
	payout_price = 10
	transport_item = /area/rogue/indoors/town/vault
	percent_bounty = TRUE

/datum/stock/bounty/treasure/get_payout_price(obj/item/I)
	if(!I)
		return ..()
	var/bounty_percent = (payout_price/100) * I.get_real_price()
	bounty_percent = round(bounty_percent)
	if(bounty_percent < 1)
		return 0
	return bounty_percent
/*
* This removed code seems to be for
* the unused submitted_to_stockpile
* variable. If you submitted a statue
* and get paid the statue is labeled as
* in stockpile. If you robbed the vault
* and put the item back in you would get
* no money. This seems like exploit prevention.

	var/taxes_amount = bounty_percent * SStreasury.tax_value
	taxes_amount = max(bounty_percent - taxes_amount, 0)
	if(I.submitted_to_stockpile)
		return 0
	return taxes_amount
*/

/obj/item
	var/submitted_to_stockpile
	var/list/attunement_values

/*
* Weird proc that prevents
* items other than cups, gems, and statues
* from being submitted to the bounty system.
*/
/datum/stock/bounty/treasure/check_item(obj/item/I)
	if(!I)
		return
	if(I.get_real_price() > 0)
		if(istype(I, /obj/item/statue))
			return TRUE
		if(istype(I, /obj/item/reagent_containers/glass/cup))
			return TRUE
		if(istype(I, /obj/item/gem))
			return TRUE
