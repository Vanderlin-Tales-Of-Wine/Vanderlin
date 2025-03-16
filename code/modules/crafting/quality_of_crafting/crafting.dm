/datum/repeatable_crafting_recipe/crafting
	abstract_type = /datum/repeatable_crafting_recipe/crafting
	skillcraft = /datum/skill/craft/crafting

/datum/repeatable_crafting_recipe/crafting/sspear
	name = "stone spear"
	requirements = list(
		/obj/item/natural/stone = 1,
		/obj/item/weapon/polearm/woodstaff = 1,
	)

	starting_atom = /obj/item/weapon/polearm/woodstaff
	attacked_atom = /obj/item/natural/stone
	output = /obj/item/weapon/polearm/spear/stone
	craftdiff = 0
	uses_attacked_atom = TRUE

/datum/repeatable_crafting_recipe/crafting/bow
	name = "wooden bow"
	requirements = list(
		/obj/item/natural/wood/plank = 1,
		/obj/item/natural/fibers = 3,
	)

	starting_atom = /obj/item/natural/fibers
	attacked_atom = /obj/item/natural/wood/plank
	output = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	craftdiff = 2
	uses_attacked_atom = TRUE

/datum/repeatable_crafting_recipe/crafting/wsword
	name = "wooden sword"
	requirements = list(
		/obj/item/natural/wood/plank = 1,
		/obj/item/grown/log/tree/stick = 1,
	)

	starting_atom = /obj/item/grown/log/tree/stick
	attacked_atom = /obj/item/natural/wood/plank
	output = /obj/item/weapon/mace/woodclub/train_sword
	craftdiff = 0
	uses_attacked_atom = TRUE

/datum/repeatable_crafting_recipe/crafting/wshield
	name = "wooden shield"
	requirements = list(
		/obj/item/natural/wood/plank = 2,
	)

	starting_atom = /obj/item/natural/wood/plank
	attacked_atom = /obj/item/natural/wood/plank
	output = /obj/item/weapon/shield/wood/crafted
	uses_attacked_atom = TRUE

/obj/item/weapon/shield/wood/crafted
	sellprice = 6

/datum/repeatable_crafting_recipe/crafting/heatershield
	name = "heater shield"
	requirements = list(
		/obj/item/natural/wood/plank = 2,
		/obj/item/natural/hide/cured = 1,
	)

	starting_atom = /obj/item/natural/hide
	attacked_atom = /obj/item/natural/wood/plank
	output = /obj/item/weapon/shield/heater/crafted
	craftdiff = 2
	uses_attacked_atom = TRUE

/datum/repeatable_crafting_recipe/crafting/blowgun
	name = "blowgun"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to whittle", "start whittling", 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom  = /obj/item/weapon/knife
	output = /obj/item/gun/ballistic/revolver/grenadelauncher/blowgun
	uses_attacked_atom = FALSE

/datum/repeatable_crafting_recipe/crafting/candle
	name = "candle"
	requirements = list(
		/obj/item/reagent_containers/food/snacks/fat= 1,
		/obj/item/natural/fibers= 1,
	)
	starting_atom = /obj/item/natural/fibers
	attacked_atom = /obj/item/reagent_containers/food/snacks/fat
	output = /obj/item/candle/yellow
	output_amount = 2
	uses_attacked_atom = TRUE

/datum/repeatable_crafting_recipe/crafting/woodclub
	name = "wood club"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
		/obj/item/natural/fibers= 1,
	)
	starting_atom = /obj/item/grown/log/tree/small
	attacked_atom = /obj/item/natural/fibers
	output = /obj/item/weapon/mace/woodclub/crafted
	uses_attacked_atom = TRUE
	craftdiff = 0

/datum/repeatable_crafting_recipe/crafting/woodstaff
	name = "wood staff"
	requirements = list(
		/obj/item/grown/log/tree= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to whittle", "start whittling", 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree
	starting_atom = /obj/item/weapon/knife
	output = /obj/item/weapon/polearm/woodstaff
	output_amount = 2
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE

/datum/repeatable_crafting_recipe/crafting/spoon
	name = "wooden spoon (x2)"
	requirements = list(
		/obj/item/grown/log/tree= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to whittle", "start whittling", 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree
	starting_atom = /obj/item/weapon/knife
	output = /obj/item/kitchen/spoon
	output_amount = 2
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE

/datum/repeatable_crafting_recipe/crafting/rollingpin
	name = "wooden rollingpin"
	requirements = list(
		/obj/item/grown/log/tree= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to whittle", "start whittling", 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree
	starting_atom = /obj/item/weapon/knife
	output = /obj/item/kitchen/rollingpin
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE

/datum/repeatable_crafting_recipe/crafting/woodenbucket
	name = "wooden bucket"
	requirements = list(
		/obj/item/grown/log/tree/small = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to whittle", "start whittling", 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom = /obj/item/weapon/knife
	output = /obj/item/reagent_containers/glass/bucket/wooden
	craft_time = 5 SECONDS
	craftdiff = 0
	uses_attacked_atom = FALSE

/datum/repeatable_crafting_recipe/crafting/woodbowl
	name = "wooden bowl (x3)"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to whittle", "start whittling", 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom= /obj/item/weapon/knife
	output = /obj/item/reagent_containers/glass/bowl
	output_amount = 3
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE

/datum/repeatable_crafting_recipe/crafting/woodcup
	name = "wooden cup (x3)"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to whittle", "start whittling", 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom= /obj/item/weapon/knife
	output = /obj/item/reagent_containers/glass/cup/wooden/crafted
	output_amount = 3
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE

/datum/repeatable_crafting_recipe/crafting/woodtray
	name = "wooden tray (x2)"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to whittle", "start whittling", 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom= /obj/item/weapon/knife
	output = /obj/item/plate/tray
	output_amount = 2
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE

/datum/repeatable_crafting_recipe/crafting/woodplatter
	name = "wooden platter"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to whittle", "start whittling", 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom= /obj/item/weapon/knife
	output = /obj/item/kitchen/platter
	output_amount = 2
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE

/datum/repeatable_crafting_recipe/crafting/woodspade
	name = "wooden spade"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
		/obj/item/grown/log/tree/stick = 1,
	)
	starting_atom = /obj/item/grown/log/tree/small
	attacked_atom = /obj/item/grown/log/tree/stick
	output = /obj/item/weapon/shovel/small
	craft_time = 2 SECONDS

/datum/repeatable_crafting_recipe/crafting/arrow
	name = "stone arrow (x2)"
	requirements = list(
		/obj/item/grown/log/tree/stick= 1,
		/obj/item/natural/stone = 1,
	)
	starting_atom = /obj/item/grown/log/tree/stick
	attacked_atom = /obj/item/natural/stone
	output = /obj/item/ammo_casing/caseless/arrow/stone
	output_amount = 2
	craft_time = 1 SECONDS
	uses_attacked_atom = TRUE

/datum/repeatable_crafting_recipe/crafting/pipe
	name = "wooden pipe"
	requirements = list(
		/obj/item/grown/log/tree/stick= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to whittle", "start whittling", 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/stick
	starting_atom  = /obj/item/weapon/knife
	output = /obj/item/clothing/face/cigarette/pipe/crafted
	uses_attacked_atom = FALSE

/datum/repeatable_crafting_recipe/crafting/stake
	name = "wooden stake"
	requirements = list(
		/obj/item/grown/log/tree/stick= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to whittle", "start whittling", 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/stick
	starting_atom  = /obj/item/weapon/knife
	output = /obj/item/grown/log/tree/stake
	craftdiff = 0
	uses_attacked_atom = FALSE

/datum/repeatable_crafting_recipe/crafting/broom
	name = "broom"
	requirements = list(
		/obj/item/grown/log/tree/stick= 4,
		/obj/item/natural/fibers = 1,
	)
	attacked_atom = /obj/item/grown/log/tree/stick
	starting_atom  = /obj/item/natural/fibers
	output = /obj/item/broom

/datum/repeatable_crafting_recipe/crafting/wicker_basket
	name = "wicker basket"
	requirements = list(
		/obj/item/natural/fibers = 4,
	)
	attacked_atom = /obj/item/natural/fibers
	starting_atom  = /obj/item/natural/fibers
	output = /obj/structure/closet/crate/chest/wicker
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/wood_hammer
	name = "wooden hammer"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to whittle", "start whittling", 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom= /obj/item/weapon/knife
	output = /obj/item/weapon/hammer/wood
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE

/datum/repeatable_crafting_recipe/crafting/wpsycross
	name = "wooden psycross"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to whittle", "start whittling", 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom= /obj/item/weapon/knife
	output = /obj/item/clothing/neck/psycross
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE

/datum/repeatable_crafting_recipe/crafting/pyro_arrow
	name = "pyroclastic arrow"
	requirements = list(
		/obj/item/ammo_casing/caseless/arrow= 1,
		/obj/item/reagent_containers/food/snacks/produce/fyritius = 1,
	)
	starting_atom = /obj/item/ammo_casing/caseless/arrow
	attacked_atom = /obj/item/reagent_containers/food/snacks/produce/fyritius
	output = /obj/item/ammo_casing/caseless/arrow/pyro
	craftdiff = 1
	skillcraft = /datum/skill/craft/engineering
	craft_time = 1 SECONDS
	uses_attacked_atom = TRUE

/datum/repeatable_crafting_recipe/crafting/pyro_bolt
	name = "pyroclastic bolt"
	requirements = list(
		/obj/item/ammo_casing/caseless/bolt= 1,
		/obj/item/reagent_containers/food/snacks/produce/fyritius = 1,
	)
	starting_atom = /obj/item/ammo_casing/caseless/bolt
	attacked_atom = /obj/item/reagent_containers/food/snacks/produce/fyritius
	output = /obj/item/ammo_casing/caseless/bolt/pyro
	craftdiff = 1
	skillcraft = /datum/skill/craft/engineering
	craft_time = 1 SECONDS
	uses_attacked_atom = TRUE

/datum/repeatable_crafting_recipe/crafting/bigflail
	name = "great militia flail"
	requirements = list(
		/obj/item/weapon/thresher= 1,
		/obj/item/rope/chain = 1,
		/obj/item/ingot/iron = 1,
	)
	tool_usage = list(
		/obj/item/weapon/hammer = list("starts to hammer", "start hammering", 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom =/obj/item/weapon/thresher
	starting_atom= /obj/item/weapon/hammer
	output = /obj/item/weapon/thresher/military
	craftdiff = 3
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE

/datum/repeatable_crafting_recipe/crafting/militia_flail
	name = "militia flail"
	requirements = list(
		/obj/item/weapon/flail/towner= 1,
		/obj/item/ingot/iron = 1,
	)
	tool_usage = list(
		/obj/item/weapon/hammer = list("starts to hammer", "start hammering", 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/weapon/flail/towner
	starting_atom= /obj/item/weapon/hammer
	output = /obj/item/weapon/flail/militia
	craftdiff = 3
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE

/datum/repeatable_crafting_recipe/crafting/ironcudgel
	name = "peasant cudgel"
	requirements = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/ingot/iron = 1,
	)
	tool_usage = list(
		/obj/item/weapon/hammer = list("starts to hammer", "start hammering", 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom= /obj/item/weapon/hammer
	output = /obj/item/weapon/mace/cudgel/carpenter
	output_amount = 2
	craftdiff = 3
	craft_time = 5 SECONDS
	uses_attacked_atom = FALSE

/datum/repeatable_crafting_recipe/crafting/scroll
	name = "parchment scroll"
	requirements = list(
		/obj/item/paper = 3,
	)
	starting_atom = /obj/item/paper
	attacked_atom = /obj/item/paper
	output = /obj/item/paper/scroll
	uses_attacked_atom = TRUE
	craftdiff = 0

/datum/repeatable_crafting_recipe/crafting/cart_upgrade
	name = "cart upgrade"
	requirements = list(
		/obj/item/natural/wood/plank= 2,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to whittle", "start whittling", 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/natural/wood/plank
	starting_atom  = /obj/item/weapon/knife
	output = /obj/item/gear/wood/basic
	craftdiff = 3
	skillcraft = /datum/skill/labor/lumberjacking
	uses_attacked_atom = FALSE

/datum/repeatable_crafting_recipe/crafting/flint
	name = "flint"
	requirements = list(
		/obj/item/natural/stone = 1,
		/obj/item/ingot/iron = 1,
	)
	attacked_atom = /obj/item/natural/stone
	starting_atom  = /obj/item/ingot/iron
	output = /obj/item/flint
	craftdiff = 0
	skillcraft = /datum/skill/craft/engineering
