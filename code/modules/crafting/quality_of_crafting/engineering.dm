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
	output_amount = 12
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
	output_amount = 4
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
	output = 2
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE

/datum/repeatable_crafting_recipe/engineering/gearbox
	name = "gearbox"
	requirements = list(
		/obj/item/grown/log/tree/small= 2,
		/obj/item/natural/wood/plank = 4,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom= /obj/item/weapon/knife
	output = /obj/item/rotation_contraption/horizontal
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE

/datum/repeatable_crafting_recipe/engineering/vertical_gearbox
	name = "vertical gearbox"
	requirements = list(
		/obj/item/grown/log/tree/small= 2,
		/obj/item/natural/wood/plank = 4,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom= /obj/item/weapon/knife
	output = /obj/item/rotation_contraption/vertical
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE

/datum/repeatable_crafting_recipe/engineering/rails
	name = "minecart rails"
	requirements = list(
		/obj/item/grown/log/tree/stick= 1,
		/obj/item/ingot/iron = 1,
	)
	tool_usage = list(
		/obj/item/weapon/hammer = list(span_notice("starts to hammer"), span_notice("start to hammer"), 'sound/items/bsmith2.ogg'),
	)
	attacked_atom = /obj/item/ingot/iron
	starting_atom= /obj/item/weapon/hammer
	output = /obj/item/rotation_contraption/minecart_rail
	output_amount = 6
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE

/datum/repeatable_crafting_recipe/engineering/water_pipe
	name = "fluid transport pipe"
	requirements = list(
		/obj/item/ingot/bronze = 1,
	)
	tool_usage = list(
		/obj/item/weapon/hammer = list(span_notice("starts to hammer"), span_notice("start to hammer"), 'sound/items/bsmith2.ogg'),
	)
	attacked_atom = /obj/item/ingot/bronze
	starting_atom= /obj/item/weapon/hammer
	output = /obj/item/rotation_contraption/water_pipe
	output_amount = 18
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE

/datum/repeatable_crafting_recipe/engineering/minecart
	name = "minecart"
	requirements = list(
		/obj/item/ingot/iron = 3,
	)
	tool_usage = list(
		/obj/item/weapon/hammer = list(span_notice("starts to hammer"), span_notice("start to hammer"), 'sound/items/bsmith2.ogg'),
	)
	attacked_atom = /obj/item/ingot/iron
	starting_atom= /obj/item/weapon/hammer
	output = /obj/structure/closet/crate/miningcar
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE

/datum/repeatable_crafting_recipe/engineering/boiler
	name = "boiler"
	requirements = list(
		/obj/item/ingot/copper = 3,
	)
	tool_usage = list(
		/obj/item/weapon/hammer = list(span_notice("starts to hammer"), span_notice("start to hammer"), 'sound/items/bsmith2.ogg'),
	)
	attacked_atom = /obj/item/ingot/copper
	starting_atom= /obj/item/weapon/hammer
	output = /obj/item/rotation_contraption/boiler
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE

/datum/repeatable_crafting_recipe/engineering/pump
	name = "liquid pump"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
		/obj/item/ingot/bronze = 3,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'sound/items/wood_sharpen.ogg'),
		/obj/item/weapon/hammer = list(span_notice("starts to hammer"), span_notice("start to hammer"), 'sound/items/bsmith2.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom= /obj/item/weapon/knife
	output = /obj/item/rotation_contraption/pump
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE

/datum/repeatable_crafting_recipe/engineering/gunpowder
	name = "blastpowder"
	requirements = list(
		/obj/item/natural/stone= 1,
		/obj/item/reagent_containers/food/snacks/rotten/egg = 1,
		/obj/item/reagent_containers/food/snacks/produce/fyritius = 1,

	)
	tool_usage = list(
		/obj/item/pestle = list(span_notice("starts to grind together"), span_notice("start to grind together"), 'sound/foley/mortarpestle.ogg'),
	)

	attacked_atom = /obj/item/reagent_containers/glass/mortar
	starting_atom = /obj/item/pestle
	output = /obj/item/reagent_containers/powder/blastpowder
	output_amount = 3
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE

/datum/repeatable_crafting_recipe/engineering/breaching_charge
	name = "Breaching Charge"
	requirements = list(
		/obj/item/reagent_containers/powder/blastpowder = 2,
		/obj/item/natural/fibers = 1,
		/obj/item/natural/cloth = 1,

	)

	attacked_atom = /obj/item/natural/cloth
	starting_atom = /obj/item/reagent_containers/powder/blastpowder
	output = /obj/item/breach_charge
	craft_time = 5 SECONDS
