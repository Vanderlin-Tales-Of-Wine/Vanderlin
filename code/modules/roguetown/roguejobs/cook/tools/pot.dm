/obj/item/reagent_containers/glass/bucket/pot
	force = 10
	name = "pot"
	desc = "The peasants friend, when filled with boiling water it will turn the driest oats to filling oatmeal."

	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "pote"

	sharpness = IS_BLUNT
	slot_flags = null
	w_class = WEIGHT_CLASS_BULKY
	drop_sound = 'sound/foley/dropsound/shovel_drop.ogg'
	var/processing_amount = 0 ///we use this to "reserve" reagents
	var/list/in_progress_recipes = list() //these are unique creations only ever used

	var/static/list/checker_recipes = list()

/obj/item/reagent_containers/glass/bucket/pot/copper
	icon_state = "pote_copper"

/obj/item/reagent_containers/glass/bucket/pot/Destroy()
	. = ..()
	in_progress_recipes = null

/obj/item/reagent_containers/glass/bucket/pot/proc/attempt_pot_recipes(obj/item/attacked_item, mob/living/user)
	var/water_amount = reagents.get_reagent_amount(/datum/reagent/water)
	water_amount -= processing_amount

	if(!length(checker_recipes))
		for(var/datum/pot_recipe/recipe as anything in typesof(/datum/pot_recipe))
			if(is_abstract(recipe))
				continue
			checker_recipes |= new recipe

	for(var/datum/pot_recipe/recipe as anything in in_progress_recipes)
		for(var/required_type as anything in recipe.required_items)
			if(!istype(attacked_item, required_type))
				continue
			qdel(attacked_item)
			user.visible_message("<span class='info'>[user] places [attacked_item] into the pot.</span>")
			playsound(get_turf(src), 'sound/items/Fish_out.ogg', 20, TRUE)
			recipe.required_items[required_type]--
			if(recipe.required_items[required_type] <= 0)
				recipe.required_items -= required_type
			break
		if(!length(recipe.required_items) && !recipe.cooking)
			recipe.start_cooking(src, user)
			return TRUE

	var/datum/pot_recipe/fallback
	var/datum/pot_recipe/recipe_type
	///this is wonky but we always check for the first item, so we don't need to radial soups because that would suck
	for(var/datum/pot_recipe/recipe as anything in checker_recipes)
		var/obj/item/first_type = recipe.required_items[1]
		if(water_amount < recipe.water_volume)
			continue //lack of water
		if(!istype(attacked_item, first_type))
			continue

		if(recipe.fallback)
			fallback = recipe.type
			continue
		recipe_type = recipe.type

	if(!recipe_type)
		recipe_type = fallback

	if(!recipe_type)
		return FALSE

	var/datum/pot_recipe/created_recipe = new recipe_type
	var/obj/item/first_type = created_recipe.required_items[1]
	in_progress_recipes |= created_recipe
	qdel(attacked_item)
	user.visible_message("<span class='info'>[user] places [attacked_item] into the pot.</span>")
	playsound(get_turf(src), 'sound/items/Fish_out.ogg', 20, TRUE)
	created_recipe.required_items[first_type]--
	if(created_recipe.required_items[first_type] <= 0)
		created_recipe.required_items -= first_type
	if(!length(created_recipe.required_items) && !created_recipe.cooking)
		created_recipe.start_cooking(src, user)
		return TRUE
	return TRUE

/obj/item/reagent_containers/glass/bucket/pot/update_icon()
	cut_overlays()
	if(reagents.total_volume > 0)
		if(reagents.total_volume <= 50)
			var/mutable_appearance/filling = mutable_appearance('icons/roguetown/items/cooking.dmi', "pote_half")
			filling.color = mix_color_from_reagents(reagents.reagent_list)
			filling.alpha = mix_alpha_from_reagents(reagents.reagent_list)
			add_overlay(filling)

		if(reagents.total_volume > 50)
			var/mutable_appearance/filling = mutable_appearance('icons/roguetown/items/cooking.dmi', "pote_full")
			filling.color = mix_color_from_reagents(reagents.reagent_list)
			filling.alpha = mix_alpha_from_reagents(reagents.reagent_list)
			add_overlay(filling)


/obj/item/reagent_containers/glass/bucket/pot/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/reagent_containers/glass/bowl))
		to_chat(user, "<span class='notice'>Filling the bowl...</span>")
		playsound(user, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 70, FALSE)
		if(do_after(user, 2 SECONDS, src))
			reagents.trans_to(I, reagents.total_volume)
	return TRUE

/obj/item/reagent_containers/glass/bucket/pot/throw_impact(atom/hit_atom, datum/thrownthing/thrownthing)
	if(reagents.total_volume > 5)
		new /obj/effect/decal/cleanable/food/mess/soup(get_turf(src))
	..()

/obj/item/reagent_containers/glass/bucket/pot/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -5,"sy" = -8,"nx" = 7,"ny" = -9,"wx" = -1,"wy" = -8,"ex" = -1,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)


///this is where pot recipes go

/datum/pot_recipe
	var/name = "Generic Pot Recipe"
	abstract_type = /datum/pot_recipe
	var/datum/reagent/produced_reagent
	var/water_volume = 33
	///cannot be greated then 1 as we don't extra reserve.
	var/water_conversion = 1

	var/list/required_items = list()

	var/obj/item/reagent_containers/glass/bucket/pot/cooking_pot
	var/cooking_time = 30 SECONDS
	///we spawn a burst of this as it finishes cooking
	var/datum/pollutant/finished_smell
	///are we cooking?
	var/cooking = FALSE
	///are we a fallback recipe (only picked if no recipe at all left)
	var/fallback = FALSE
	///the amount we pollute
	var/pollute_amount = 600
	///do we hide from books?
	var/hides_from_books = FALSE

/datum/pot_recipe/proc/start_cooking(obj/item/reagent_containers/glass/bucket/pot, mob/living/user)
	cooking_pot = pot
	RegisterSignal(cooking_pot, COMSIG_PARENT_QDELETING, PROC_REF(end_recipe))

	var/real_cooking_time = cooking_time
	if(user.mind)
		real_cooking_time /= 1 + (user.mind.get_skill_level(/datum/skill/craft/cooking) * 0.5)
		real_cooking_time = round(real_cooking_time)

	cooking = TRUE
	cooking_pot.processing_amount += water_volume
	addtimer(CALLBACK(src, PROC_REF(finish_cooking)), cooking_time)


/datum/pot_recipe/proc/end_recipe()
	cooking_pot.in_progress_recipes -= src
	cooking_pot = null
	cooking = FALSE
	qdel(src)

/datum/pot_recipe/proc/finish_cooking()
	if(!cooking_pot)
		return

	var/turf/pot_turf = get_turf(cooking_pot)
	if(finished_smell)
		pot_turf.pollute_turf(finished_smell, pollute_amount)
	playsound(pot_turf, "bubbles", 30, TRUE)

	cooking_pot.processing_amount -= water_volume
	cooking_pot.reagents.remove_reagent(/datum/reagent/water, water_volume)
	cooking_pot.reagents.add_reagent(produced_reagent, CEILING(water_volume * water_conversion, 1))

	post_recipe() //mainly useful for drugs where we take the remainder of the water and turn it spicy
	end_recipe()

/datum/pot_recipe/proc/post_recipe()
	return

/datum/pot_recipe/cooking
	abstract_type = /datum/pot_recipe/cooking

/datum/pot_recipe/cooking/oatmeal
	name = "oatmeal"
	produced_reagent = /datum/reagent/consumable/soup/oatmeal
	required_items = list(/obj/item/reagent_containers/food/snacks/produce/oat = 1)
	finished_smell = /datum/pollutant/food/oatmeal

/datum/pot_recipe/cooking/potato_stew
	name = "potato stew"
	cooking_time = 80 SECONDS
	produced_reagent = /datum/reagent/consumable/soup/veggie/potato
	required_items = list(/obj/item/reagent_containers/food/snacks/rogue/veg/potato_sliced = 1)
	finished_smell = /datum/pollutant/food/potato_stew

/datum/pot_recipe/cooking/onion_stew
	name = "onion stew"
	cooking_time = 60 SECONDS
	produced_reagent = /datum/reagent/consumable/soup/veggie/onion
	required_items = list(/obj/item/reagent_containers/food/snacks/rogue/veg/onion_sliced = 1)
	finished_smell = /datum/pollutant/food/onion_stew

/datum/pot_recipe/cooking/cabbage_stew
	name = "cabbage stew"
	cooking_time = 70 SECONDS
	produced_reagent = /datum/reagent/consumable/soup/veggie/cabbage
	required_items = list(/obj/item/reagent_containers/food/snacks/rogue/veg/cabbage_sliced = 1)
	finished_smell = /datum/pollutant/food/cabbage_stew

/datum/pot_recipe/cooking/turnip_stew
	name = "turnip stew"
	cooking_time = 70 SECONDS
	produced_reagent = /datum/reagent/consumable/soup/veggie/turnip
	required_items = list(/obj/item/reagent_containers/food/snacks/rogue/veg/turnip_sliced = 1)
	finished_smell = /datum/pollutant/food/turnip_stew

/datum/pot_recipe/cooking/fish_stew
	name = "fish stew"
	cooking_time = 80 SECONDS
	produced_reagent = /datum/reagent/consumable/soup/stew/fish
	required_items = list(/obj/item/reagent_containers/food/snacks/rogue/meat/mince/fish = 1)
	finished_smell = /datum/pollutant/food/fish_stew

/datum/pot_recipe/cooking/chicken_stew
	name = "chicken stew"
	cooking_time = 90 SECONDS
	produced_reagent = /datum/reagent/consumable/soup/stew/chicken
	required_items = list(/obj/item/reagent_containers/food/snacks/rogue/meat/mince/poultry = 1)
	finished_smell = /datum/pollutant/food/chicken_stew

/datum/pot_recipe/cooking/chicken_stew/cutlet
	required_items = list(/obj/item/reagent_containers/food/snacks/rogue/meat/poultry/cutlet = 1)

/datum/pot_recipe/cooking/questionable_stew
	name = "questionable stew"
	cooking_time = 90 SECONDS
	produced_reagent = /datum/reagent/consumable/soup/stew/gross
	required_items = list(/obj/item/reagent_containers/food/snacks/rogue/meat/strange = 1)
	finished_smell = /datum/pollutant/food/potato_stew

/datum/pot_recipe/cooking/generic_meat_stew
	name = "meat stew"
	cooking_time = 90 SECONDS
	produced_reagent = /datum/reagent/consumable/soup/stew/meat
//	required_items = list(/obj/item/reagent_containers/food/snacks/rogue/meat/mince/beef = 1)
	required_items = list(/obj/item/reagent_containers/food/snacks/rogue/meat = 1)
	finished_smell = /datum/pollutant/food/meat_stew
	fallback = TRUE
/*
/datum/pot_recipe/cooking/generic_meat_stew/steak
	required_items = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 1)
*/
/datum/pot_recipe/cooking/egg_soup
	name = "egg soup"
	cooking_time = 80 SECONDS
	produced_reagent = /datum/reagent/consumable/soup/egg
	required_items = list(/obj/item/reagent_containers/food/snacks/egg = 1)
	finished_smell = /datum/pollutant/food/egg_soup

/datum/pot_recipe/cooking/truffle_stew
	name = "truffle stew"
	cooking_time = 80 SECONDS
	produced_reagent = /datum/reagent/consumable/soup/stew/truffle
	required_items = list(/obj/item/reagent_containers/food/snacks/truffles = 1)
	finished_smell = /datum/pollutant/food/truffle_stew

/datum/pot_recipe/cooking/cheese_soup
	name = "cheese soup"
	cooking_time = 80 SECONDS
	produced_reagent = /datum/reagent/consumable/soup/cheese
	required_items = list(/obj/item/reagent_containers/food/snacks/rogue/cheese = 1)
	finished_smell = /datum/pollutant/food/cheese_soup

/datum/pot_recipe/cooking/cheese_soup/wedge
	required_items = list(/obj/item/reagent_containers/food/snacks/cheese_wedge = 1)

/datum/pot_recipe/drugs
	abstract_type = /datum/pot_recipe/drugs

/datum/pot_recipe/drugs/drukqs
	name = "drukqs"
	cooking_time = 50 SECONDS
	water_conversion = 0.45
	produced_reagent = /datum/reagent/druqks
	required_items = list(/obj/item/reagent_containers/powder/spice = 1)
	finished_smell = /datum/pollutant/food/druqks
	pollute_amount = 100

/datum/pot_recipe/drugs/post_recipe()
	var/remaining_water = water_volume - CEILING(water_volume * water_conversion, 1)
	cooking_pot.reagents.add_reagent(/datum/reagent/water/spicy, remaining_water)

/datum/pot_recipe/drugs/ozium
	name = "ozium"
	cooking_time = 50 SECONDS
	water_conversion = 0.45
	produced_reagent = /datum/reagent/ozium
	required_items = list(/obj/item/reagent_containers/powder/ozium = 1)
	finished_smell = /datum/pollutant/food/druqks
	pollute_amount = 100

/datum/pot_recipe/drugs/moondust
	name = "moondust"
	cooking_time = 50 SECONDS
	water_conversion = 0.45
	produced_reagent = /datum/reagent/moondust
	required_items = list(/obj/item/reagent_containers/powder/moondust = 1)
	finished_smell = /datum/pollutant/food/druqks
	pollute_amount = 100

/datum/pot_recipe/drugs/moondust_purest
	name = "pure moondust"
	cooking_time = 50 SECONDS
	water_conversion = 0.45
	produced_reagent = /datum/reagent/moondust_purest
	required_items = list(/obj/item/reagent_containers/powder/moondust_purest = 1)
	finished_smell = /datum/pollutant/food/druqks
	pollute_amount = 100

/datum/pot_recipe/drugs/post_recipe()
	var/remaining_water = water_volume - CEILING(water_volume * water_conversion, 1)
	cooking_pot.reagents.add_reagent(/datum/reagent/water/spicy, remaining_water)

/datum/pot_recipe/yuck_soup
	name = "yuck soup"
	hides_from_books = TRUE
	cooking_time = 60 SECONDS
	produced_reagent = /datum/reagent/yuck/cursed_soup
	required_items = list(/obj/item/reagent_containers/food/snacks/produce/jacksberry/poison = 1)

/datum/pot_recipe/yuck_soup/poo
	required_items = list(/obj/item/natural/poo = 1)

/datum/pot_recipe/yuck_soup/toxicshrooms
	required_items = list(/obj/item/reagent_containers/food/snacks/rogue/toxicshrooms = 1)

/datum/pot_recipe/yuck_soup/worms
	required_items = list(/obj/item/natural/worms = 1)

/datum/pot_recipe/yuck_soup/rotten_food
	required_items = list(/obj/item/reagent_containers/food/snacks/rotten = 1)

/datum/pot_recipe/yuck_soup/organ
	required_items = list(/obj/item/organ = 1)

/datum/pot_recipe/yuck_soup/living_rat
	required_items = list(/obj/item/reagent_containers/food/snacks/smallrat = 1)
	fallback = TRUE

/datum/pot_recipe/gross_stew
	name = "gross stew"
	hides_from_books = TRUE
	cooking_time = 60 SECONDS
	produced_reagent = /datum/reagent/consumable/soup/stew/gross
	required_items = list(/obj/item/reagent_containers/food/snacks/smallrat/dead = 1)

/datum/pot_recipe/gross_stew/bad_recipe
	required_items = list(/obj/item/reagent_containers/food/snacks/badrecipe = 1)


/datum/pot_recipe/proc/generate_html(mob/user)
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
	for(var/atom/path as anything in required_items)
		var/count = required_items[path]
		html += "[icon2html(new path, user)] [count] of any [initial(path.name)]<br>"
	html += "[CEILING((water_volume) / 3, 1)] oz of water<br>"
	html += {"
		</div>
		<div>
		"}
	var/obj/item/reagent_containers/glass/bucket/pot/new_pot = new /obj/item/reagent_containers/glass/bucket/pot
	html += "<strong class=class='scroll'>After cooking for [cooking_time * 0.1] Seconds<br>"
	html += "<strong class=class='scroll'>inside of a [initial(new_pot.name)]<br> [icon2html(new_pot, user)] <br>"
	qdel(new_pot)

	html += "<strong class=class='scroll'>Cooks into<br>"
	html += "[CEILING((water_volume / water_conversion) / 3, 1)] oz of [initial(produced_reagent.name)]<br>"

	html += {"
		</div>
		</div>
	</body>
	</html>
	"}
	return html

/datum/pot_recipe/proc/show_menu(mob/user)
	user << browse(generate_html(user),"window=recipe;size=500x810")
