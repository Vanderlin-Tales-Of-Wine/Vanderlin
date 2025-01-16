

/obj/item/recipe_book
	icon = 'icons/roguetown/items/books.dmi'

	grid_width = 32
	grid_height = 64
	var/list/types = list()
	var/mob/current_reader
	var/open
	var/base_icon_state
	var/can_spawn = TRUE


/obj/item/recipe_book/dropped(mob/user, silent)
	. = ..()
	if(current_reader)
		current_reader << browse(null,"window=recipe")
		current_reader = null

/obj/item/recipe_book/attack_self(mob/user)
	. = ..()
	current_reader = user
	current_reader << browse(generate_html(user),"window=recipe;size=500x810")

/obj/item/recipe_book/proc/generate_html(mob/user)
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
		"}

	for(var/atom/path as anything in types)
		if(is_abstract(path))
			for(var/atom/sub_path as anything in subtypesof(path))
				if(is_abstract(sub_path))
					continue
				html += "<a href='byond://?src=\ref[src];pick_recipe=[sub_path]'>[initial(sub_path.name)]</a> <br>"
		else
			html += "<a href='byond://?src=\ref[src];pick_recipe=[path]'>[initial(path.name)]</a> <br>"

	html += {"
	</body>
	</html>
	"}
	return html

/obj/item/recipe_book/Topic(href, href_list)
	. = ..()
	if(href_list["pick_recipe"])
		var/datum/path = text2path(href_list["pick_recipe"])
		if(ispath(path, /datum/repeatable_crafting_recipe))
			var/datum/repeatable_crafting_recipe/real_path = new path
			real_path.show_menu(current_reader)
		else if(ispath(path, /datum/orderless_slapcraft))
			var/datum/orderless_slapcraft/real_path = new path
			real_path.show_menu(current_reader)
		else if(ispath(path, /datum/slapcraft_recipe))
			var/datum/slapcraft_recipe/real_path = new path
			real_path.show_menu(current_reader)
		else if(ispath(path, /datum/crafting_recipe))
			var/datum/crafting_recipe/real_path = new path
			real_path.show_menu(current_reader)
		else if(ispath(path, /datum/pot_recipe))
			var/datum/pot_recipe/real_path = new path
			real_path.show_menu(current_reader)

/obj/item/recipe_book/getonmobprop(tag)
	. = ..()
	if(tag)
		if(open)
			switch(tag)
				if("gen")
					return list("shrink" = 0.4,
	"sx" = -2,
	"sy" = -3,
	"nx" = 10,
	"ny" = -2,
	"wx" = 1,
	"wy" = -3,
	"ex" = 5,
	"ey" = -3,
	"northabove" = 0,
	"southabove" = 1,
	"eastabove" = 1,
	"westabove" = 0,
	"nturn" = 0,
	"sturn" = 0,
	"wturn" = 0,
	"eturn" = 0,
	"nflip" = 0,
	"sflip" = 0,
	"wflip" = 0,
	"eflip" = 0)
				if("onbelt")
					return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)
		else
			switch(tag)
				if("gen")
					return list("shrink" = 0.4,
	"sx" = -2,
	"sy" = -3,
	"nx" = 10,
	"ny" = -2,
	"wx" = 1,
	"wy" = -3,
	"ex" = 5,
	"ey" = -3,
	"northabove" = 0,
	"southabove" = 1,
	"eastabove" = 1,
	"westabove" = 0,
	"nturn" = 0,
	"sturn" = 0,
	"wturn" = 0,
	"eturn" = 0,
	"nflip" = 0,
	"sflip" = 0,
	"wflip" = 0,
	"eflip" = 0)
				if("onbelt")
					return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


/obj/item/recipe_book/leatherworking
	name = "The Tanned Hide Tome: Mastery of Leather and Craft"
	desc = "Penned by Orym Vaynore, fourth generation leatherworker"
	icon_state ="book8_0"
	base_icon_state = "book8"

	types = list(/datum/repeatable_crafting_recipe/leather)

/obj/item/recipe_book/sewing
	name = "Threads of Destiny: A Tailor's Codex"
	desc = "Penned by Elise Heiran, second generation court tailor"
	icon_state ="book7_0"
	base_icon_state = "book7"

	types = list(/datum/repeatable_crafting_recipe/sewing)

/obj/item/recipe_book/cooking
	name = "The Hearthstone Grimoire: Culinary Secrets of the Realm"
	desc = "Penned by Aric Dunswell, Head Court Chef, Third Generation"
	icon_state ="book6_0"
	base_icon_state = "book6"

	types = list(
		/datum/pot_recipe/cooking,
		/datum/repeatable_crafting_recipe/cooking,
		/datum/repeatable_crafting_recipe/salami,
		/datum/repeatable_crafting_recipe/coppiette,
		/datum/repeatable_crafting_recipe/salo,
		/datum/repeatable_crafting_recipe/saltfish,
		/datum/repeatable_crafting_recipe/raisins,
		/datum/orderless_slapcraft/pie,
	)

/obj/item/recipe_book/survival
	name = "The Wilderness Guide: Secrets of Survival"
	desc = "Penned by Kaelen Stormrider, Fourth Generation Trailblazer"
	icon_state ="book5_0"
	base_icon_state = "book5"

	types = list(
		/datum/repeatable_crafting_recipe/survival,
		/datum/repeatable_crafting_recipe/soap,
		/datum/repeatable_crafting_recipe/fishing,
		/datum/repeatable_crafting_recipe/sigsweet,
		/datum/repeatable_crafting_recipe/sigdry,
		/datum/repeatable_crafting_recipe/dryleaf,
		/datum/repeatable_crafting_recipe/westleach,
		/datum/repeatable_crafting_recipe/salami,
		/datum/repeatable_crafting_recipe/coppiette,
		/datum/repeatable_crafting_recipe/salo,
		/datum/repeatable_crafting_recipe/saltfish,
		/datum/repeatable_crafting_recipe/raisins,
		/datum/repeatable_crafting_recipe/parchment,
		/datum/repeatable_crafting_recipe/crafting,
	)

/obj/item/recipe_book/underworld
	name = "The Smuggler’s Guide: A Treatise on Elixirs of the Guild"
	desc = "Penned by Thorne Ashveil, Thieves Guild's Alchemist, Second Generation"
	icon_state ="book4_0"
	base_icon_state = "book4"
	can_spawn = FALSE

	types = list(
		/datum/repeatable_crafting_recipe/narcotics,
		/datum/pot_recipe/drugs,
	)

/obj/item/recipe_book/carpentry
	name = "The Woodwright's Codex: Crafting with Timber and Grain"
	desc = "Penned by Eadric Hollowell, Master Carpenter, Fourth Generation"
	icon_state ="book3_0"
	base_icon_state = "book3"

	types = list(
		/datum/slapcraft_recipe/carpentry,
	)

/obj/item/recipe_book/engineering
	name = "The Engineer’s Primer: Machines, Mechanisms, and Marvels"
	desc = "Penned by Liora Brasslock, Chief Engineer, Second Generation"
	icon_state ="book2_0"
	base_icon_state = "book2"

	types = list(
		/datum/slapcraft_recipe/engineering,
	)

/obj/item/recipe_book/masonry
	name = "The Stonebinder’s Manual: Foundations of Craft and Fortitude"
	desc = "Penned by Garrin Ironvein, Master Mason, Third Generation"
	icon_state ="book_0"
	base_icon_state = "book"

	types = list(
		/datum/slapcraft_recipe/masonry,
	)

/obj/item/recipe_book/art
	name = "The Artisan's Palette"
	desc = "Created by Elara Moondance, Visionary Painter and Culinary Alchemist"
	icon_state ="book3_0"
	base_icon_state = "book3"

	types = list(
		/datum/repeatable_crafting_recipe/canvas,
		/datum/repeatable_crafting_recipe/paint_palette,
		/datum/repeatable_crafting_recipe/paintbrush,
		/datum/slapcraft_recipe/carpentry/structure/easel,
	)
