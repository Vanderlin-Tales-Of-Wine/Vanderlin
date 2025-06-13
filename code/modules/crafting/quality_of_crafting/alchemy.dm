/datum/repeatable_crafting_recipe/alchemy
	abstract_type = /datum/repeatable_crafting_recipe/alchemy
	skillcraft = /datum/skill/craft/alchemy
	craftdiff = 0
	category = "Misc"

/datum/repeatable_crafting_recipe/alchemy/essence_connector
	name = "Essence Connector"
	output = /obj/item/essence_connector
	requirements = list(
		/obj/item/ingot/thaumic = 1,
		/obj/item/natural/glass = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out a rune", "start to carve a rune")
	)

	attacked_atom = /obj/item/ingot/thaumic
	starting_atom = /obj/item/weapon/knife
	subtypes_allowed = TRUE // so you can use any subtype of knife

/datum/repeatable_crafting_recipe/alchemy/essence_jar
	name = "Essence Node Jar"
	output = /obj/item/essence_node_jar
	requirements = list(
		/obj/item/ingot/thaumic = 1,
		/obj/item/natural/glass = 3,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out a rune", "start to carve a rune")
	)

	attacked_atom = /obj/item/natural/glass
	starting_atom = /obj/item/weapon/knife
	subtypes_allowed = TRUE // so you can use any subtype of knife

/datum/repeatable_crafting_recipe/alchemy/essence_gauntlet
	name = "Essence Gauntlet"
	output = /obj/item/clothing/gloves/essence_gauntlet
	requirements = list(
		/obj/item/ingot/thaumic = 3,
		/obj/item/natural/glass = 4,
		/obj/item/mana_battery/mana_crystal = 2,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out a rune", "start to carve a rune")
	)

	attacked_atom = /obj/item/natural/glass
	starting_atom = /obj/item/weapon/knife
	subtypes_allowed = TRUE // so you can use any subtype of knife

/datum/repeatable_crafting_recipe/alchemy/essence_vial
	name = "Essence Vial"
	output = /obj/item/essence_vial
	requirements = list(
		/obj/item/natural/glass = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out a rune", "start to carve a rune")
	)

	attacked_atom = /obj/item/natural/glass
	starting_atom = /obj/item/weapon/knife
	subtypes_allowed = TRUE // so you can use any subtype of knife
	output_amount = 3
