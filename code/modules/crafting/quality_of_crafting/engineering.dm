/datum/repeatable_crafting_recipe/engineering
	abstract_type = /datum/repeatable_crafting_recipe/engineering
	skillcraft = /datum/skill/craft/engineering

/datum/repeatable_crafting_recipe/engineering/shaft
	name = "wooden shaft"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom= /obj/item/weapon/knife
	output = /obj/item/rotation_contraption/shaft
	output_amount = 2
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE

/datum/repeatable_crafting_recipe/engineering/cog
	name = "cog"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
		/obj/item/ingot/bronze = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom= /obj/item/weapon/knife
	output = /obj/item/rotation_contraption/cog
	output_amount = 2
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE

/datum/repeatable_crafting_recipe/engineering/waterwheel
	name = "waterwheel"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
		/obj/item/natural/wood/plank = 6,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom= /obj/item/weapon/knife
	output = /obj/item/rotation_contraption/waterwheel
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE

/datum/repeatable_crafting_recipe/engineering/large_cog
	name = "large cog"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
		/obj/item/ingot/bronze = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom= /obj/item/weapon/knife
	output = /obj/item/rotation_contraption/large_cog
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE
