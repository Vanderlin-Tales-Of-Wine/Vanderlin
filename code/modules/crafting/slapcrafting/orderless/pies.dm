///this in theory should be better then the old system pies are funky as they don't create a new type at the end.
/datum/orderless_slapcraft/pie
	abstract_type = /datum/orderless_slapcraft/pie
	category = "Pies"

	finishing_item = /obj/item/reagent_containers/food/snacks/piedough
	starting_item = /obj/item/reagent_containers/food/snacks/foodbase/piebottom
	related_skill = /datum/skill/craft/cooking
	skill_xp_gained = 20
	action_time = 5 SECONDS

	var/overlay_state = ""
	var/fill_states = 3

/datum/orderless_slapcraft/pie/step_process(mob/user, obj/item/attacking_item)
	. = ..()
	hosted_source.name = "unfinished [name]"
	var/total_number = 0
	for(var/type in requirements)
		total_number |= requirements[type]

	hosted_source.cut_overlays()
	var/mutable_appearance/fill_state = mutable_appearance(hosted_source.icon, "[overlay_state][max(1, fill_states - total_number)]")
	hosted_source.add_overlay(fill_state)

/datum/orderless_slapcraft/pie/fish
	name = "Unbaked Fish Pie"
	requirements = list(
		/obj/item/reagent_containers/food/snacks/meat/mince/fish = 2,
		list(
			/obj/item/reagent_containers/food/snacks/meat/mince/fish,
			/obj/item/reagent_containers/food/snacks/veg/potato_sliced) = 1)
	overlay_state = "fill_fish"
	output_item = /obj/item/reagent_containers/food/snacks/raw_pie/fish

/datum/orderless_slapcraft/pie/pot
	name = "Unbaked Pot Pie"
	requirements = list(
		list(
			/obj/item/reagent_containers/food/snacks/cheese_wedge,
			/obj/item/reagent_containers/food/snacks/cheese,
			/obj/item/reagent_containers/food/snacks/butterslice,
			/obj/item/reagent_containers/food/snacks/egg) = 1,
		list(
			/obj/item/reagent_containers/food/snacks/veg/onion_sliced,
			/obj/item/reagent_containers/food/snacks/veg/potato_sliced,
			/obj/item/reagent_containers/food/snacks/veg/turnip_sliced,
			/obj/item/reagent_containers/food/snacks/veg/cabbage_sliced,
			/obj/item/reagent_containers/food/snacks/roastseeds) = 1,
		list(
			/obj/item/reagent_containers/food/snacks/meat/mince/poultry,
			/obj/item/reagent_containers/food/snacks/meat/mince/beef,
			/obj/item/reagent_containers/food/snacks/meat/mince/fish,
			/obj/item/reagent_containers/food/snacks/fat) = 1
	)
	overlay_state = "fill_pot"
	output_item = /obj/item/reagent_containers/food/snacks/raw_pie/pot_pie

/datum/orderless_slapcraft/pie/apple
	name = "Unbaked Apple Pie"
	requirements = list(
		/obj/item/reagent_containers/food/snacks/produce/fruit/apple = 3
	)
	overlay_state = "fill_apple"
	output_item = /obj/item/reagent_containers/food/snacks/raw_pie/apple

/datum/orderless_slapcraft/pie/pear
	name = "Unbaked Pear Pie"
	requirements = list(
		/obj/item/reagent_containers/food/snacks/produce/fruit/pear = 3
	)
	overlay_state = "fill_pear"
	output_item = /obj/item/reagent_containers/food/snacks/raw_pie/pear

/datum/orderless_slapcraft/pie/berry
	name = "Unbaked Berry Pie"
	requirements = list(
		list(
			/obj/item/reagent_containers/food/snacks/produce/fruit/jacksberry/poison,
			/obj/item/reagent_containers/food/snacks/produce/fruit/jacksberry) = 3
	)
	overlay_state = "fill_berry"
	output_item = /obj/item/reagent_containers/food/snacks/raw_pie/berry

/datum/orderless_slapcraft/pie/berry/step_process(mob/user, obj/item/attacking_item)
	. = ..()
	if(istype(attacking_item, /obj/item/reagent_containers/food/snacks/produce/fruit/jacksberry/poison))
		output_item = /obj/item/reagent_containers/food/snacks/raw_pie/berry/poison

/datum/orderless_slapcraft/pie/meat
	name = "Unbaked Meat Pie"
	requirements = list(
		/obj/item/reagent_containers/food/snacks/meat/mince/beef = 2,
		list(
			/obj/item/reagent_containers/food/snacks/meat/mince/beef,
			/obj/item/reagent_containers/food/snacks/egg) = 1)
	overlay_state = "fill_meat"
	output_item = /obj/item/reagent_containers/food/snacks/raw_pie/meat



/*	.................   Cheap dye crafting   ................... */
/datum/orderless_slapcraft/cheapdye
	name = "cheap dyes"
	recipe_name = "Cheap dyes"
	starting_item = /obj/item/ash
	related_skill = /datum/skill/misc/sewing
	skill_xp_gained = 2
	requirements = list(
		list(
			/obj/item/reagent_containers/food/snacks/produce/fruit/jacksberry/poison,
			/obj/item/reagent_containers/food/snacks/produce/fruit/jacksberry,
			/obj/item/reagent_containers/food/snacks/produce/swampweed) = 2
	)
	output_item = /obj/item/dye_pack/cheap
