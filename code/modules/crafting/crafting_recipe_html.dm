
/datum/crafting_recipe/proc/generate_html(mob/user)
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
				font-size: 2.5em;
				border-bottom: 2px solid #3e2723;
				padding-bottom: 10px;
				margin-bottom: 20px;
			}
			.icon {
				width: 96px;
				height: 96px;
				vertical-align: middle;
				margin-right: 10px;
			}
		</style>
		<body>
		  <div>
		    <h1>[name]</h1>
		    <div>
		      <strong>Requirements</strong>
			  <br>
		"}
	for(var/atom/path as anything in reqs)
		var/count = reqs[path]
		if(subtype_reqs)
			html += "[icon2html(new path, user)] [count] of any [initial(path.name)]<br>"
		else
			html += "[icon2html(new path, user)] [count] [initial(path.name)]<br>"

	html += {"
		</div>
		<div>
		"}

	if(length(tools))
		html += {"
		<br>
		<div>
		    <strong>Required Tools</strong>
			<br>
			  "}
		for(var/atom/path as anything in tools)
			if(subtype_reqs)
				html += "[icon2html(new path, user)] any [initial(path.name)]<br>"
			else
				html += "[icon2html(new path, user)] [initial(path.name)]<br>"
		html += {"
			</div>
		<div>
		"}

	if(length(chem_catalysts))
		html += {"
		<br>
		<div>
		    <strong>Required Liquids</strong>
			<br>
			  "}
		for(var/atom/path as anything in chem_catalysts)
			var/count = chem_catalysts[path]
			html += "[CEILING(count / 3, 1)] oz of [initial(path.name)]<br>"
		html += {"
			</div>
		<div>
		"}

	html += {"
		</div>
		</div>
	</body>
	</html>
	"}
	return html

/datum/crafting_recipe/proc/show_menu(mob/user)
	user << browse(generate_html(user),"window=recipe;size=500x810")
