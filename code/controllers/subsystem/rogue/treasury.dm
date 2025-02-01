
/*
* I think this is placed here because its
* used to tell people what their income is
* in a non fantasy tone. This is used here
* and in the drugmachine.dm.
*/
/proc/send_ooc_note(msg, name, job)
	var/list/names_to = list()
	if(name)
		names_to += name
	if(job)
		var/list/L = list()
		if(islist(job))
			L = job
		else
			L += job
		for(var/J in L)
			for(var/mob/living/carbon/human/X in GLOB.human_list)
				if(X.job == J)
					names_to |= X.real_name
	if(names_to.len)
		for(var/mob/living/carbon/human/X in GLOB.human_list)
			if(X.real_name in names_to)
				if(!X.stat)
					to_chat(X, "<span class='info'>[msg]</span>")

/*
* The Treasury system is the ocean
* in which the steward sails.
*/
SUBSYSTEM_DEF(treasury)
	name = "treasury"
	wait = 1
	priority = FIRE_PRIORITY_WATER_LEVEL
	var/tax_value = 0.11
	var/queens_tax = 0.15
	var/treasury_value = 0
	var/list/bank_accounts = list()
	var/list/stockpile_datums = list()
	var/next_treasury_check = 0
	var/list/log_entries = list()


/datum/controller/subsystem/treasury/Initialize()
	//Randomizes the roundstart amount of money and the queens tax.
	treasury_value = rand(800,1500)
	queens_tax = pick(0.09, 0.15, 0.21, 0.30)

	//For the merchants import and export.
	for(var/path in subtypesof(/datum/roguestock/bounty))
		var/datum/D = new path
		stockpile_datums += D
	for(var/path in subtypesof(/datum/roguestock/stockpile))
		var/datum/D = new path
		stockpile_datums += D
	for(var/path in subtypesof(/datum/roguestock/import))
		var/datum/D = new path
		stockpile_datums += D
	return ..()

/datum/controller/subsystem/treasury/fire(resumed = 0)
	if(world.time > next_treasury_check)
		//I dont know why the treasury check is randomized
		next_treasury_check = world.time + rand(5 MINUTES, 8 MINUTES)
		if(SSticker.current_state == GAME_STATE_PLAYING)
			//Stock price updated based on demand variable.
			for(var/datum/roguestock/X in stockpile_datums)
				if(!X.stable_price && !X.transport_item)
					if(X.demand < initial(X.demand))
						X.demand += rand(5,15)
					if(X.demand > initial(X.demand))
						X.demand -= rand(5,15)

		//Checks all items in the vault.
		var/amt_to_generate = CalcVaultIncome()

		/*
		* This is the final calculations of how
		* much passive income the kingdom makes.
		* exsample: 4 items worth 100 mammon
		* individually will produce (productprice*0.25)
		* before the total suffers from the queens tax
		* which ranges from 9% to 30%. Some rounds
		* will just be harder for the Steward than others.
		*/
		amt_to_generate = amt_to_generate - (amt_to_generate * queens_tax)
		amt_to_generate = round(amt_to_generate)
		give_money_treasury(amt_to_generate, "wealth horde")
		for(var/mob/living/carbon/human/X in GLOB.human_list)
			if(X.job == "Monarch" || X.job == "Consort" || X.job == "Steward")
				send_ooc_note("Income from wealth horde: +[amt_to_generate]", name = X.real_name)
				return

/*
* Calculates Passive income based
* on the items that are placed within
* the vault.
*/
/datum/controller/subsystem/treasury/proc/CalcVaultIncome()
	var/area/A = GLOB.areas_by_type[/area/rogue/indoors/town/vault]
	var/passive_income = 0
	for(var/obj/item/I in A)
		if(!isturf(I.loc))
			continue
		if(I.get_real_price() <= 0)
			continue
		/*
		* This seems to be a removed variable
		* that occurs only in submission.dm and
		* bounties.dm. Its original purpose
		* seems to be preventing people from
		* collecting the same bounty several times.
		*/
		if(!I.submitted_to_stockpile)
			I.submitted_to_stockpile = TRUE
		//Passive income is 15% of the items worth.
		if(is_type_in_typecache(I, GLOB.ITEM_DOES_NOT_GENERATE_VAULT_RENT) )
			passive_income += (I.get_real_price()*0) // coin gives no interest, need to have rare items or refined products
		else	passive_income += (I.get_real_price()*0.15)
	return passive_income

/*
* These procs are all called directly from
* things outside of the system.
*/
/datum/controller/subsystem/treasury/proc/create_bank_account(name, initial_deposit)
	if(!name)
		return
	if(name in bank_accounts)
		return
	bank_accounts += name
	if(initial_deposit)
		bank_accounts[name] = initial_deposit
	else
		bank_accounts[name] = 0
	return TRUE

//increments the treasury directly (tax collection)
/datum/controller/subsystem/treasury/proc/give_money_treasury(amt, source)
	if(!amt)
		return
	treasury_value += amt
	if(source)
		log_to_steward("+[amt] to treasury ([source])")
	else
		log_to_steward("+[amt] to treasury")

//pays to account from treasury (payroll)
/datum/controller/subsystem/treasury/proc/give_money_account(amt, name, source)
	if(!amt)
		return
	if(!name)
		return
	var/found_account
	if (amt > treasury_value)  // Check if the amount exceeds the treasury balance
		send_ooc_note("<b>The Bank:</b> Error: Insufficient funds in the treasury to complete the transaction.", name = name)
		return FALSE  // Return early if the treasury balance is insufficient
	for(var/X in bank_accounts)
		if(X == name)
			if(amt > 0)
				bank_accounts[X] += amt  // Deposit the money into the player's account
				treasury_value -= amt   // Deduct the given amount from the treasury
			else
				// Check if the amount to be fined exceeds the player's account balance
				if(abs(amt) > bank_accounts[X])
					send_ooc_note("<b>The Bank:</b> Error: Insufficient funds in the player's account to complete the fine.", name = name)
					return FALSE  // Return early if the player has insufficient funds
				bank_accounts[X] -= abs(amt)  // Deduct the fine amount from the player's account
				treasury_value += abs(amt)  // Add the fined amount to the treasury
			found_account = TRUE
			break
	if(!found_account)
		return FALSE

	if (amt > 0)
		// Player received money
		if(source)
			send_ooc_note("<b>The Bank:</b> You received money. ([source])", name = name)
			log_to_steward("+[amt] from treasury to [name] ([source])")
		else
			send_ooc_note("<b>The Bank:</b> You received money.", name = name)
			log_to_steward("+[amt] from treasury to [name]")
	else
		// Player was fined
		if(source)
			send_ooc_note("<b>The Bank:</b> You were fined. ([source])", name = name)
			log_to_steward("[name] was fined [amt] ([source])")
		else
			send_ooc_note("<b>The Bank:</b> You were fined.", name = name)
			log_to_steward("[name] was fined [amt]")

	return TRUE

//increments the treasury and gives the money to the account (deposits)
/datum/controller/subsystem/treasury/proc/generate_money_account(amt, name, source)
	if(!amt)
		return
	var/found_account
	for(var/X in bank_accounts)
		if(X == name)
			bank_accounts[X] += amt  // Deposit the money into the player's account
			found_account = TRUE
			break
	if(!found_account)
		log_to_steward("+[amt] deposited by anonymous.")
		return
	if(source)
		log_to_steward("+[amt] deposited by [name] ([source])")
	else
		log_to_steward("+[amt] deposited by [name]")
	return TRUE


/datum/controller/subsystem/treasury/proc/withdraw_money_account(amt, name)
	if(!amt)
		return
	var/found_account
	for(var/X in bank_accounts)
		if(X == name)
			if(bank_accounts[X] < amt)  // Check if the withdrawal amount exceeds the player's account balance
				send_ooc_note("<b>The Bank:</b> Error: Insufficient funds in the player's account to complete the withdrawal.", name = name)
				return  // Return without processing the transaction
			bank_accounts[X] -= amt
			found_account = TRUE
			break
	if(!found_account)
		return
	log_to_steward("-[amt] withdrawn by [name]")
	return TRUE


/datum/controller/subsystem/treasury/proc/log_to_steward(log)
	log_entries += log
	return
