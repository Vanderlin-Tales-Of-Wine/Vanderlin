///this in theory should be better then the old system pies are funky as they don't create a new type at the end.
/datum/orderless_slapcraft/pie
	abstract_type = /datum/orderless_slapcraft/pie

	finishing_item = /obj/item/reagent_containers/food/snacks/piedough
	starting_item = /obj/item/reagent_containers/food/snacks/foodbase/piebottom
	related_skill = /datum/skill/craft/cooking
	skill_xp_gained = 20
	action_time = 5 SECONDS

	var/overlay_state = ""
	var/pie_name

	var/finished_icon_state
	var/finished_cooked_type
	var/finished_cooked_smell
	var/finished_filling_color	// to give pies the filling color they should have
	var/pie_roof

	var/fill_states = 3
	var/superior_cooked_type	// what cooking path if user got good cooking skills?

/datum/orderless_slapcraft/pie/try_finish(mob/living/user)
	var/obj/item/reagent_containers/food/snacks/foodbase/piebottom/source = hosted_source

	source.cut_overlays()
	var/mutable_appearance/piebottom = mutable_appearance(source.icon, "pieuncooked")
	source.add_overlay(piebottom)
	if(pie_roof)
		var/mutable_appearance/roof = mutable_appearance(source.icon, pie_roof)
		source.add_overlay(roof)

	source.name = "uncooked [pie_name]"

	source.icon_state = finished_icon_state
	source.cooked_type = finished_cooked_type
	source.cooked_smell = finished_cooked_smell
	source.filling_color = finished_filling_color

	if(user.mind.get_skill_level(/datum/skill/craft/cooking) >= 2)
		source.cooked_type = superior_cooked_type

	source.short_cooktime = (50 - ((user?.mind?.get_skill_level(/datum/skill/craft/cooking)) * 8))
	source.long_cooktime = (90 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*15))

/datum/orderless_slapcraft/pie/step_process(mob/user, obj/item/attacking_item)
	. = ..()
	hosted_source.name = "unfinished [pie_name]"
	var/total_number = 0
	for(var/type in requirements)
		total_number |= requirements[type]

	hosted_source.cut_overlays()
	var/mutable_appearance/fill_state = mutable_appearance(hosted_source.icon, "[overlay_state][max(1, fill_states - total_number)]")
	hosted_source.add_overlay(fill_state)

/datum/orderless_slapcraft/pie/fish
	name = "fish pie"
	requirements = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/mince/fish = 2,
		list(
			/obj/item/reagent_containers/food/snacks/rogue/meat/mince/fish,
			/obj/item/reagent_containers/food/snacks/rogue/veg/potato_sliced) = 1)

	overlay_state = "fill_fish"
	pie_name = "fish pie"

	finished_icon_state = "fishpie_raw"
	finished_cooked_type = /obj/item/reagent_containers/food/snacks/pie/cooked/meat/fish
	finished_cooked_smell = /datum/pollutant/food/fish_pie
	finished_filling_color = "#bb5a93"
	superior_cooked_type = /obj/item/reagent_containers/food/snacks/pie/cooked/meat/fish/good

/datum/orderless_slapcraft/pie/pot
	name = "pot pie"
	requirements = list(
		list(
			/obj/item/reagent_containers/food/snacks/rogue/meat/mince/poultry,
			/obj/item/reagent_containers/food/snacks/cheese_wedge,
			/obj/item/reagent_containers/food/snacks/rogue/cheese,
			/obj/item/reagent_containers/food/snacks/egg,
			/obj/item/reagent_containers/food/snacks/fat,
			/obj/item/reagent_containers/food/snacks/rogue/veg/onion_sliced,
			/obj/item/reagent_containers/food/snacks/rogue/veg/potato_sliced,
			/obj/item/reagent_containers/food/snacks/rogue/veg/turnip_sliced,
			/obj/item/reagent_containers/food/snacks/rogue/roastseeds) = 2,
		list(
			/obj/item/reagent_containers/food/snacks/rogue/meat/mince/poultry,
			/obj/item/reagent_containers/food/snacks/cheese_wedge,
			/obj/item/reagent_containers/food/snacks/rogue/cheese,
			/obj/item/reagent_containers/food/snacks/egg,
			/obj/item/reagent_containers/food/snacks/fat) = 1
	)

	overlay_state = "fill_pot"
	pie_name = "pot pie"

	finished_cooked_type = /obj/item/reagent_containers/food/snacks/pie/cooked/pot
	finished_cooked_smell = /datum/pollutant/food/pot_pie
	finished_filling_color = "#9d8c3b"
	superior_cooked_type = /obj/item/reagent_containers/food/snacks/pie/cooked/pot/good

/datum/orderless_slapcraft/pie/apple
	name = "apple pie"
	requirements = list(
		/obj/item/reagent_containers/food/snacks/produce/apple = 3
	)
	overlay_state = "fill_apple"
	pie_name = "applepie"

	finished_cooked_type = /obj/item/reagent_containers/food/snacks/pie/cooked/apple
	finished_cooked_smell = /datum/pollutant/food/apple_pie
	finished_filling_color = "#eca48c"
	superior_cooked_type = /obj/item/reagent_containers/food/snacks/pie/cooked/apple/good

/datum/orderless_slapcraft/pie/berry
	name = "berry pie"
	requirements = list(
		list(
			/obj/item/reagent_containers/food/snacks/produce/jacksberry/poison,
			/obj/item/reagent_containers/food/snacks/produce/jacksberry) = 3
	)
	overlay_state = "fill_berry"
	pie_name = "berry pie"

	finished_cooked_type = /obj/item/reagent_containers/food/snacks/pie/cooked/berry
	finished_cooked_smell = /datum/pollutant/food/berry_pie
	finished_filling_color = "#394da5"
	superior_cooked_type = /obj/item/reagent_containers/food/snacks/pie/cooked/berry/good

/datum/orderless_slapcraft/pie/berry/step_process(mob/user, obj/item/attacking_item)
	. = ..()
	if(istype(attacking_item, /obj/item/reagent_containers/food/snacks/produce/jacksberry/poison))
		finished_cooked_type = /obj/item/reagent_containers/food/snacks/pie/cooked/poison

/datum/orderless_slapcraft/pie/meat
	name = "meat pie"
	requirements = list(
		/obj/item/reagent_containers/food/snacks/rogue/meat/mince/beef = 2,
		list(
			/obj/item/reagent_containers/food/snacks/rogue/meat/mince/beef,
			/obj/item/reagent_containers/food/snacks/egg) = 1)
	overlay_state = "fill_meat"
	pie_name = "meat pie"

	finished_icon_state = "meatpie_raw"
	finished_cooked_type = /obj/item/reagent_containers/food/snacks/pie/cooked/meat/meat
	finished_cooked_smell = /datum/pollutant/food/meat_pie
	finished_filling_color = "#b44f44"
	superior_cooked_type = /obj/item/reagent_containers/food/snacks/pie/cooked/meat/meat/good



/*	.................   Cheap dye crafting   ................... */
/datum/orderless_slapcraft/cheapdye
	recipe_name = "Cheap dyes"
	starting_item = /obj/item/ash
	related_skill = /datum/skill/misc/sewing
	skill_xp_gained = 2
	requirements = list(
		list(
			/obj/item/reagent_containers/food/snacks/produce/jacksberry/poison,
			/obj/item/reagent_containers/food/snacks/produce/jacksberry,
			/obj/item/reagent_containers/food/snacks/produce/swampweed) = 2
	)
	output_item = /obj/item/cheap_dyes
