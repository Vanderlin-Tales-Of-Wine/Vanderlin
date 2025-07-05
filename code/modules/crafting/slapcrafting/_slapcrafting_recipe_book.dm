/datum/slapcraft_recipe/proc/generate_html(mob/user)
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
		"}
	var/datum/slapcraft_step/second_step = SLAPCRAFT_STEP(steps[2])
	var/obj/item/second_item = second_step.item_types[1]
	var/datum/slapcraft_step/first_step = SLAPCRAFT_STEP(steps[1])
	var/obj/item/first_item = first_step.item_types[1]

	html += "[icon2html(new second_item, user)][print_step_description(second_step)] [second_step.start_verb] <br> [icon2html(new first_item, user)] a [initial(first_item.name)]<br>"
	var/count = 0
	for(var/step_type in steps)
		if(count < 2)
			count++
			continue
		var/datum/slapcraft_step/step_datum = SLAPCRAFT_STEP(step_type)
		var/obj/item/item = step_datum.item_types[1]
		var/opt_string = step_datum.optional ? "(optional)" : ""
		html += "[icon2html(new item, user)] then [print_step_description(step_datum)] [opt_string]<br>"

	html += {"
		</div>
		<div>
		"}

	html += "<strong class=class='scroll'>and then you get</strong> <br> [icon2html(new result_type, user)] <br> [initial(result_type.name)]<br>"


	html += {"
		</div>
		</div>
	</body>
	</html>
	"}
	return html

/datum/slapcraft_recipe/proc/show_menu(mob/user)
	user << browse(generate_html(user),"window=recipe;size=500x810")


/datum/slapcraft_recipe/proc/print_step_description(datum/slapcraft_step/craft_step)
	if(!craft_step.recipe_link)
		return craft_step.desc
	// This step links to some recipe, linkify the description with a href
	. = craft_step.desc
	. = replacetext(., "%ENDLINK%", "</a>")
	. = replacetext(., "%LINK%", "<a href='byond://?src=[REF(src)];preference=popup_recipe;recipe=[craft_step.recipe_link]'>")
