
/datum/crafting_recipe/roguetown/cooking
	req_table = TRUE
	subtype_reqs = FALSE
	skillcraft = /datum/skill/craft/cooking

/datum/crafting_recipe/roguetown/cooking/soap
	name = "soap"
	reqs = list(
		/obj/item/ash = 1,
		/datum/reagent/water = 10,
		/obj/item/reagent_containers/food/snacks/fat = 1)
	result = /obj/item/soap
	craftdiff = 5
