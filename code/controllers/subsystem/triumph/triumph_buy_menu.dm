

/datum/triumph_buy_menu
	//These are the menu datum vars
	var/client/linked_client
	var/triumph_quantity = 108 // The amount of triumphs we got

	var/current_page = "1" // Current page of triumphs we are viewing and yes its a number in a string
	var/current_category = TRIUMPH_CAT_ROUND_EFX //Current category we are viewing

	var/page_count = 0

/datum/triumph_buy_menu/New()
	..()

/datum/triumph_buy_menu/Destroy(force, ...)
	linked_client = null
	. = ..()


/datum/triumph_buy_menu/proc/triumph_menu_startup_slop()
	var/datum/asset/thicc_assets = get_asset_datum(/datum/asset/simple/stonekeep_triumph_buy_menu_slop_layout)
	thicc_assets.send(linked_client)

	show_menu()


// TRIUMPH BUY MENU SIDED PROC
/datum/triumph_buy_menu/proc/show_menu()
	if(!linked_client)
		return
	var/data = {"
	<html>
		<head>
			<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge,chrome=1\"/>
			<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"/>
			<style>
				@import url('https://fonts.googleapis.com/css2?family=Aclonica&display=swap');
				@import url('https://fonts.googleapis.com/css2?family=VT323&display=swap');
				@import url('https://fonts.googleapis.com/css2?family=Pirata+One&display=swap');
				@import url('https://fonts.googleapis.com/css2?family=Jersey+25&display=swap');
				body {
					background-color: rgb(31, 20, 24);
					background:
						url('[SSassets.transport.get_asset_url("try5_border.png")]'),
						url('[SSassets.transport.get_asset_url("try5.png")]');
					background-repeat: no-repeat;
					background-attachment: fixed;
					background-size: 100% 100%;
				}
			</style>
			<link rel='stylesheet' type='text/css' href='[SSassets.transport.get_asset_url("slop_menustyle3.css")]'>
		</head>
		<body>
			<div id=\"top_container_div\">
				<div id=\"triumph_quantity_div\">
					I have [SStriumphs.get_triumphs(linked_client.ckey)] Triumphs
				</div>
			</div>
			<div style=\"width:100%;float:left\">
	"}
/*
				<div id='triumph_close_div'>
					<a id='triumph_close_button' href='byond://?src=\ref[src];close_menu=1'>CLOSE MENU</a>
				</div>
*/

	data += "<hr class='fadeout_line'>"
	for(var/cat_key in SStriumphs.central_state_data)
		if(cat_key == current_category)
			data += "<a class=\"triumph_categories_selected\" href=\"byond://?src=\ref[src];select_a_category=[cat_key]\"><span class=\"bigunder_back\"><span class=\"bigunder\"></span>[cat_key]</span></a>"
		else
			data += "<a class=\"triumph_categories_normal\" href=\"byond://?src=\ref[src];select_a_category=[cat_key]\">[cat_key]</a>"

	data +={"
	<hr class=\"fadeout_line\">
		</div>
			<table>
				<thead>
					<tr>
						<th class=\"triumph_text_head\">Description</th>
						<th class=\"triumph_text_head\">Cost</th>
						<th class=\"triumph_text_head_redeem\">Redeem</th>
					</tr>
				</thead>
				<tbody>
	"}


	if(current_category == TRIUMPH_CAT_ACTIVE_DATUMS)
		// Mostly so we can stop the filler message from not being displayed if someone has a non-visible triumph buy, and theres nothing else in.
		var/found_one = FALSE
		if(SStriumphs.active_triumph_buy_queue.len)
			for(var/datum/triumph_buy/found_triumph_buy in SStriumphs.active_triumph_buy_queue)
				if(!found_triumph_buy.visible_on_active_menu || usr.ckey != found_triumph_buy.ckey_of_buyer) // If we aren't set to be able to be visible on the main menu
					continue
				data += {"
					<tr class='triumph_text_row'>
						<td class='triumph_text_desc'>[found_triumph_buy.desc]</td>
						<td class='triumph_cost_wrapper'>[found_triumph_buy.triumph_cost]</td>
				"}
				if(SSticker.HasRoundStarted() && found_triumph_buy.pre_round_only)
					data += "<td class='triumph_buy_wrapper'><a class='triumph_text_buy' href='byond://?src=\ref[src];handle_buy_button=\ref[found_triumph_buy];'><span class='strikethru_back'>ROUND STARTED</span></a></td>"
				else
					data += "<td class='triumph_buy_wrapper'><a class='triumph_text_buy' href='byond://?src=\ref[src];handle_buy_button=\ref[found_triumph_buy];'>UNBUY</a></td>"

				data += "</tr>"

				found_one = TRUE // WE GOT ONE WOOHOO


		if(!found_one) // We didn't find anything that could be visible, so cram in the mssage
			data += {"
				<tr class='triumph_text_row'>
					<td class='triumph_text_desc'>CURRENTLY NOTHING</td>
					<td class='triumph_cost_wrapper'>ACTIVE</td>
					<td class='triumph_buy_wrapper'><a class='triumph_text_buy' href='byond://?src=\ref[src];'>HERE</a></td>
				</tr>
			"}

	else
		for(var/datum/triumph_buy/current_check in SStriumphs.central_state_data[current_category]["[current_page]"])
			data += {"
				<tr class='triumph_text_row'>
					<td class='triumph_text_desc'>[current_check.desc]</td>
					<td class='triumph_cost_wrapper'>[current_check.triumph_cost]</td>
				"}

			var/string = "<td class='triumph_buy_wrapper'><a class='triumph_text_buy' href='byond://?src=\ref[src];handle_buy_button=\ref[current_check];'>BUY</a></td>"
			if(SSticker.HasRoundStarted() && current_check.pre_round_only)
				string = "<td class='triumph_buy_wrapper'><a class='triumph_text_buy' href='byond://?src=\ref[src];handle_buy_button=\ref[current_check];'><span class='strikethru_back'>CONFLICT</span></a></td>"
			else
				for(var/datum/triumph_buy/conflict_check in SStriumphs.active_triumph_buy_queue)
					if(current_check.type in conflict_check.conflicts_with) // We are in an active datum's conflicts with
						string = "<td class='triumph_filler_cells'><a class='triumph_text_buy' href='byond://?src=\ref[src];handle_buy_button=\ref[current_check];'><span class='strikethru_back'>CONFLICT</span></a></td>"

			data += string
			data += "</tr>"



	data += {"
				</tbody>
			</table>
			"}
	data += "<div class='triumph_footer'>"

	for(var/i in 1 to SStriumphs.central_state_data[current_category].len)

		if("[i]" == current_page)
			data += "<a class='triumph_numbers_selected' href='byond://?src=\ref[src];select_a_page=[i]'><span class='num_bigunder_back'><span class='num_bigunder'></span>[i]</span></a>"
		else
			data += "<a class='triumph_numbers_normal' href='byond://?src=\ref[src];select_a_page=[i]'>[i]</a>"

	data += "</div>"
	data += {"
		</body>
	</html>
	"}
	data += {"
		</head>
	</html>
	"}
	linked_client << browse(data, "window=triumph_buy_window;size=500x760;can_close=1;can_minimize=0;can_maximize=0;can_resize=0;titlebar=1")

	// We setup the href_list "close" call if they hit the x on the top right
	for(var/i in 1 to 10)
		if(!linked_client)
			break
		if(winexists(linked_client, "triumph_buy_window"))
			winset(linked_client, "triumph_buy_window", "on-close=\".windowclose [REF(src)]\"")
			break

// TRIUMPH BUY MENU SIDED PROC
/datum/triumph_buy_menu/Topic(href, list/href_list)
	. = ..()

	if(href_list["select_a_category"])
		var/sent_category = href_list["select_a_category"]
		if(SStriumphs.central_state_data[sent_category])
			if(sent_category != current_category)
				current_category = sent_category
				show_menu()

	if(href_list["select_a_page"])
		var/sent_page = href_list["select_a_page"]
		if(SStriumphs.central_state_data[current_category]["[sent_page]"])
			if(sent_page != current_page)
				current_page = sent_page
				show_menu()

	//This sends a reference to a datum,
	if(href_list["handle_buy_button"])
		var/datum/triumph_buy/target_datum = locate(href_list["handle_buy_button"])
		if(target_datum)
			var/conflicting = FALSE

			for(var/datum/triumph_buy/current_actives in SStriumphs.active_triumph_buy_queue)
				if(target_datum.type in current_actives.conflicts_with)
					conflicting = TRUE

			if(SSticker.HasRoundStarted() && target_datum.pre_round_only)
				conflicting = TRUE

			if(!conflicting)
				// Well we already made sure it wasn't going to conflict before we sent the path in, im sleepy and I hope this isn't REALLY fuckedu p when i look at it later
				if(current_category == TRIUMPH_CAT_ACTIVE_DATUMS) // ACTIVE datums are ones already bought anyways
					SStriumphs.attempt_to_unbuy_triumph_condition(linked_client, target_datum) // By unbuy, i mean you unbuy someone elses buy and thus we need a ref to it anyways
				else
					SStriumphs.attempt_to_buy_triumph_condition(linked_client, target_datum) // regular buy, just send over the ref to the reference case
			show_menu()

	if(href_list["close"])
		SStriumphs.remove_triumph_buy_menu(linked_client)
