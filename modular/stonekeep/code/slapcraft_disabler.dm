/* * * * * * * * * * * **
 *						*
 *	Slapcraft Disabling	*
 *						*
 *						*
 * * * * * * * * * * * **/

// =================================================================================
/*-----------\
| Structures |
\-----------*/
/datum/slapcraft_recipe/carpentry/structure/barrel
	steps = null
/datum/slapcraft_recipe/carpentry/structure/door
	steps = null
/datum/slapcraft_recipe/carpentry/structure/swingdoor
	steps = null
/datum/slapcraft_recipe/carpentry/structure/deadbolt
	steps = null
/datum/slapcraft_recipe/carpentry/structure/donjon
	steps = null
/datum/slapcraft_recipe/carpentry/structure/fancydoor
	steps = null
/datum/slapcraft_recipe/carpentry/structure/roguebin
	steps = null
/datum/slapcraft_recipe/carpentry/structure/chair
	steps = null
/datum/slapcraft_recipe/carpentry/structure/fancychair
	steps = null
/datum/slapcraft_recipe/carpentry/structure/stool
	steps = null
/datum/slapcraft_recipe/carpentry/structure/loom
	steps = null
/datum/slapcraft_recipe/carpentry/structure/handcart
	steps = null
/datum/slapcraft_recipe/carpentry/structure/noose
	steps = null
/datum/slapcraft_recipe/carpentry/structure/psycrss
	steps = null
/datum/slapcraft_recipe/carpentry/structure/pyre
	steps = null
/datum/slapcraft_recipe/carpentry/structure/stairsd
	steps = null
/datum/slapcraft_recipe/carpentry/structure/railing
	steps = null
/datum/slapcraft_recipe/carpentry/structure/fence
	steps = null
/datum/slapcraft_recipe/carpentry/structure/chest
	steps = null
/datum/slapcraft_recipe/carpentry/structure/closet
	steps = null
/datum/slapcraft_recipe/carpentry/structure/coffin
	steps = null
/datum/slapcraft_recipe/carpentry/structure/nicebed
	steps = null
/datum/slapcraft_recipe/carpentry/structure/sign
	steps = null
/datum/slapcraft_recipe/carpentry/structure/training_dummy
	steps = null
/datum/slapcraft_recipe/carpentry/structure/display_stand
	steps = null
/datum/slapcraft_recipe/carpentry/structure/mannequin_female
	steps = null
/datum/slapcraft_recipe/carpentry/structure/mannequin_male
	steps = null
/datum/slapcraft_recipe/carpentry/structure/wall_ladder
	steps = null
/datum/slapcraft_recipe/carpentry/structure/table
	steps = null
/datum/slapcraft_recipe/carpentry/structure/pillory
	steps = null
/datum/slapcraft_recipe/carpentry/structure/easel
	steps = null
/datum/slapcraft_recipe/carpentry/structure/optable
	steps = null
/datum/slapcraft_recipe/carpentry/structure/meathook
	steps = null

// weapons
/datum/repeatable_crafting_recipe/crafting/sspear
	starting_atom = null
/datum/repeatable_crafting_recipe/crafting/bow
	starting_atom = null
/datum/repeatable_crafting_recipe/crafting/wsword
	starting_atom = null
/datum/repeatable_crafting_recipe/crafting/wshield
	starting_atom = null
/datum/repeatable_crafting_recipe/crafting/heatershield
	starting_atom = null
/datum/repeatable_crafting_recipe/canvas
	starting_atom = null
/datum/repeatable_crafting_recipe/paintbrush
	starting_atom = null
/datum/repeatable_crafting_recipe/paint_palette
	starting_atom = null
/datum/repeatable_crafting_recipe/survival/cloth
	starting_atom = null
/datum/repeatable_crafting_recipe/survival/thorn_needle
	starting_atom = null
/datum/repeatable_crafting_recipe/survival/rope
	starting_atom = null
/datum/repeatable_crafting_recipe/survival/torch
	starting_atom = null
/datum/repeatable_crafting_recipe/survival/stone_axe
	starting_atom = null
/datum/repeatable_crafting_recipe/survival/stone_knife
	starting_atom = null
/datum/repeatable_crafting_recipe/survival/stone_spear
	starting_atom = null
/datum/repeatable_crafting_recipe/survival/bag
	starting_atom = null

/datum/repeatable_crafting_recipe/survival/stone_hoe
	starting_atom = null
/datum/repeatable_crafting_recipe/survival/stone_tongs
	starting_atom = null
/datum/repeatable_crafting_recipe/survival/stone_pick
	starting_atom = null

/datum/repeatable_crafting_recipe/survival/dart
	starting_atom = null


/datum/repeatable_crafting_recipe/soap
	starting_atom = null
/datum/repeatable_crafting_recipe/survival/stone_pot
	starting_atom = null
/datum/repeatable_crafting_recipe/survival/stone_mortar
	starting_atom = null
/datum/repeatable_crafting_recipe/survival/alchemy_mortar
	starting_atom = null
/datum/repeatable_crafting_recipe/survival/pestle
	starting_atom = null

/datum/repeatable_crafting_recipe/fishing/bait
	starting_atom = null

/datum/repeatable_crafting_recipe/fishing/bait/dough
	starting_atom = null

/datum/repeatable_crafting_recipe/fishing/bait/gray
	starting_atom = null

/datum/repeatable_crafting_recipe/fishing/bait/speckled
	starting_atom = null

/datum/repeatable_crafting_recipe/fishing/reel
	starting_atom = null
/datum/repeatable_crafting_recipe/fishing/reel/silk
	starting_atom = null
/datum/repeatable_crafting_recipe/fishing/reel/leather
	starting_atom = null
/datum/repeatable_crafting_recipe/fishing/bobber
	starting_atom = null
/datum/repeatable_crafting_recipe/fishing/bobber/stone
	starting_atom = null
/datum/repeatable_crafting_recipe/fishing/hook
	starting_atom = null
/datum/repeatable_crafting_recipe/fishing/hook/thorn
	starting_atom = null

/datum/repeatable_crafting_recipe/sigdry
	name = "westleach zig"
	output = /obj/item/clothing/face/cigarette/rollie/nicotine
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/dry_westleach
	requirements = list(
		/obj/item/reagent_containers/food/snacks/produce/dry_westleach = 2
	)
	attacked_atom = /obj/item/reagent_containers/food/snacks/produce/dry_westleach

	craft_time = 10 SECONDS
	crafting_message = "starts rolling a westleach zig"
	craftdiff = 0
	uses_attacked_atom = TRUE
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/sigsweet
	name = "swampweed zig"
	output = /obj/item/clothing/face/cigarette/rollie/cannabis
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/swampweed_dried
	requirements = list(
		/obj/item/reagent_containers/food/snacks/produce/swampweed_dried = 2
	)
	attacked_atom = /obj/item/reagent_containers/food/snacks/produce/swampweed_dried

	craft_time = 10 SECONDS
	crafting_message = "starts rolling a swampweed zig"
	craftdiff = 0
	uses_attacked_atom = TRUE
	subtypes_allowed = TRUE


/datum/repeatable_crafting_recipe/leather
	starting_atom = null

/datum/repeatable_crafting_recipe/sewing
	starting_atom = null

/datum/repeatable_crafting_recipe/sewing/weaving
	starting_atom = null


/datum/slapcraft_recipe/masonry/structure/stonerailing
	steps = null
