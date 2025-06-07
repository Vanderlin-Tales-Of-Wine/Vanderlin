/datum/brewing_recipe
	abstract_type = /datum/brewing_recipe
	var/name = "Alcohols"
	var/category = "Alcohols"
	///the type path of the reagent
	var/datum/reagent/reagent_to_brew = /datum/reagent/consumable/ethanol
	///pre-reqs: Essentially do we need past recipes made of this, uses the reagent_to_brew var to know if this has been done
	var/datum/reagent/pre_reqs
	///the crops typepath we need goes typepath = amount. Amount is not just how many based on potency value up to a cap it adds values.
	var/list/needed_crops = list()
	///the type paths of needed reagents in typepath = amount
	var/list/needed_reagents = list()
	///list of items that aren't crops we need
	var/list/needed_items = list()
	///our brewing time in deci seconds should use the SECONDS MINUTES HOURS helpers
	var/brew_time = 1 SECONDS
	///the price this gets at cargo
	var/sell_value = 0
	///amount of brewed creations used when either canning or bottling
	var/brewed_amount = 1
	///each bottle or canning gives how this much reagents
	var/per_brew_amount = 50
	///helpful hints
	var/helpful_hints
	///if we have a secondary name some do if you want to hide the ugly info
	var/secondary_name
	///typepath of our output if set we also make this item
	var/atom/brewed_item
	///amount of brewed items
	var/brewed_item_count = 1
	///do we age afterwards?
	var/ages = FALSE
	///the reagent we get at different age times
	var/list/age_times = list()
	///the heat we need to be kept at
	var/heat_required

/datum/brewing_recipe/proc/after_finish_attackby(mob/user, obj/item/attacked_item, atom/source)
	return FALSE

/datum/brewing_recipe/proc/generate_html(mob/user)
	var/client/client = user
	if(!istype(client))
		client = user.client
	SSassets.transport.send_assets(client, list("try4_border.png", "try4.png", "slop_menustyle2.css"))
	user << browse_rsc('html/book.png')
	var/html = {"
		<!DOCTYPE html>
		<html lang="en">
		<meta charset='UTF-8'>
		<meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'/>
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'/>

		<style>
			@import url('https://fonts.googleapis.com/css2?family=Charm:wght@700&display=swap');
			body {
				font-family: "Charm", cursive;
				font-size: 1.2em;
				text-align: center;
				margin: 20px;
				background-color: #f4efe6;
				color: #3e2723;
				background-color: rgb(31, 20, 24);
				background:
					url('[SSassets.transport.get_asset_url("try4_border.png")]'),
					url('book.png');
				background-repeat: no-repeat;
				background-attachment: fixed;
				background-size: 100% 100%;

			}
			h1 {
				text-align: center;
				font-size: 2em;
				border-bottom: 2px solid #3e2723;
				padding-bottom: 10px;
				margin-bottom: 10px;
			}
			.icon {
				width: 64px;
				height: 64px;
				vertical-align: middle;
				margin-right: 10px;
			}
		</style>
		<body>
		  <div>
		    <h1>[name]</h1>
		    <div>
			  <h2>Brewing Time: [brew_time / 10] Seconds </h2>
			  <h2>Requirements</h2>
		"}
	if(ages)
		html += "<h2>Will Continue to age after brewing.</h2>"
	if(helpful_hints)
		html += "<strong>[helpful_hints]</stong><br>"
	if(pre_reqs)
		html += "<strong>Requires that you have just made [initial(pre_reqs.name)] in the [heat_required ? "Distiller" : "Keg"].</stong><br>"
	if(heat_required)
		html += "<strong>Requires that this be made in a distiller thats atleast [heat_required - 273.1]C.</stong><br>"

	if(length(needed_crops) || length(needed_items))
		html += "<h3>Items Required</h3>"
		for(var/atom/path as anything in needed_crops)
			var/count = needed_crops[path]
			html += "[icon2html(new path, user)] [count] parts [initial(path.name)]<br>"
		for(var/atom/path as anything in needed_items)
			var/count = needed_items[path]
			html += "[count] parts [initial(path.name)]<br>"
		html += "<br>"
	if(length(needed_reagents))
		html += "<h3>Liquids Required</h3>"
		for(var/atom/path as anything in needed_reagents)
			var/count = needed_reagents[path]
			html += "[FLOOR(count / 3, 1)] oz of [initial(path.name)]<br>"
		html += "<br>"

	if(brewed_amount)
		html += "Produces: [FLOOR((per_brew_amount * brewed_amount) / 3, 1)] oz of [name]"
	if(brewed_item)
		html += "Produces:[icon2html(new brewed_item, user)] [(brewed_item_count)] [initial(brewed_item.name)]"
	html += {"
		</div>
		<div>
		"}

	if(ages)
		for(var/datum/reagent/path as anything in age_times)
			html += "After aging for [age_times[path] * 0.1] Seconds, becomes [initial(path.name)].<br>"

	html += {"
		</div>
		</div>
	</body>
	</html>
	"}
	return html

/datum/brewing_recipe/proc/show_menu(mob/user)
	user << browse(generate_html(user),"window=recipe;size=500x810")
