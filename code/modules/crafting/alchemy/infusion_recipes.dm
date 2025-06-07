/datum/essence_infusion_recipe
	abstract_type = /datum/essence_infusion_recipe
	var/category = "Infusions"
	var/name = "infusion recipe"
	var/obj/item/target_type
	var/list/required_essences = list() // essence_type = amount
	var/infusion_time = 10 SECONDS
	var/obj/item/result_type

/datum/essence_infusion_recipe/proc/generate_html(mob/user)
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
			.requirements {
				margin-bottom: 20px;
			}
			.optional {
				margin-top: 15px;
				font-style: italic;
			}
		</style>
		<body>
			<div>
				<h1>[name]</h1>
				<div class="requirements">
					<h2>Required Item</h2>
					[icon2html(new target_type, user)] [initial(target_type.name)]
					<h2>Required Essences</h2>
	"}

	for(var/essence_type in required_essences)
		var/datum/thaumaturgical_essence/essence = new essence_type
		html += "[required_essences[essence_type]] parts [essence.name]<br>"
		qdel(essence)

	html += {"
				</div>
				<div>
					<h2>Creates</h2>
					[icon2html(new result_type, user)] [initial(result_type.name)]
				</div>
				<div class='skill'>
					<strong>Infusion Time:</strong> [infusion_time * 0.1] seconds
				</div>
			</div>
		</body>
		</html>
	"}

	return html


/datum/essence_infusion_recipe/glass
	name = "Glass Transmutation"
	target_type  = /obj/item/natural/stone
	result_type = /obj/item/natural/glass
	required_essences = list(/datum/thaumaturgical_essence/crystal = 5)

/datum/essence_infusion_recipe/thaumic_iron
	name = "Thaumic Iron"
	target_type  = /obj/item/ingot/iron
	result_type = /obj/item/ingot/thaumic
	required_essences = list(/datum/thaumaturgical_essence/fire = 10)

/datum/essence_infusion_recipe/mana_crystal
	name = "Mana Crystal"
	target_type  = /obj/item/gem
	result_type = /obj/item/mana_battery/mana_crystal
	required_essences = list(/datum/thaumaturgical_essence/magic = 10)

