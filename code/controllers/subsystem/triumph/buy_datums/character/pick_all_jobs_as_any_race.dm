/datum/triumph_buy/race_all_jobs
	triumph_buy_id = "race_all"
	desc = "Every species can be in any job and class!"
	triumph_cost = 30
	category = TRIUMPH_CAT_CHARACTER
	visible_on_active_menu = TRUE


/datum/triumph_buy/race_all_jobs/on_buy()
	if(usr && usr.client)
		usr.client.triumph_ids += list(src.triumph_buy_id)
	..()


/datum/triumph_buy/race_all_jobs/on_removal()
	if(usr && usr.client)
		if(usr.client.triumph_ids.Find(src.triumph_buy_id))
			usr.client.triumph_ids -= list(src.triumph_buy_id)
