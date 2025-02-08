#define FAST_GROWING 5 MINUTES
#define VERY_FAST_GROWING 4 MINUTES
#define HUNGRINESS_DEMANDING 35
#define HUNGRINESS_NORMAL 25
#define HUNGRINESS_TINY 15

/datum/plant_def
	abstract_type = /datum/plant_def
	/// Name of the plant
	var/name = "Some plant"

	/// Description of the plant
	var/desc = "Sure is a plant."
	var/icon = 'icons/roguetown/misc/crops.dmi'
	var/icon_state

	/// Loot the plant will yield for uprooting it
	var/list/uproot_loot

	/// Time in ticks the plant will require to mature, before starting to make produce
	var/maturation_time = 6 MINUTES

	/// Time in ticks the plant will require to make produce
	var/produce_time = 3 MINUTES

	/// Typepath of produce to make on harvest
	var/produce_type

	/// Amount of minimum produce to make on harvest
	var/produce_amount_min = 2

	/// Amount of maximum produce to make on harvest
	var/produce_amount_max = 3

	/// How much nutrition will the plant require to mature fully
	var/maturation_nutrition = HUNGRINESS_NORMAL

	/// How much nutrition will the plant require to make produce
	var/produce_nutrition = 20

	/// If not perennial, the plant will uproot itself upon harvesting first produce
	var/perennial = FALSE

	/// Whether the plant is immune to weeds and will naturally deal with them
	var/weed_immune = FALSE

	/// The rate at which the plant drains water, if zero then it'll be able to live without water
	var/water_drain_rate = 2 / (1 MINUTES)

	/// Color all seeds of this plant def will have, randomised on init
	var/seed_color

	/// Whether the plant can grow underground
	var/can_grow_underground = FALSE

/datum/plant_def/New()
	. = ..()
	var/static/list/random_colors = list("#fffbf7", "#f3c877", "#5e533e", "#db7f62", "#f39945")
	seed_color = pick(random_colors)

//................ Quick-growing plants ...............................
/datum/plant_def/cabbage
	name = "cabbage patch"
	icon_state = "cabbage"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/cabbage
	produce_amount_min = 2
	produce_amount_max = 3
	maturation_time = FAST_GROWING

/datum/plant_def/onion
	name = "onion patch"
	icon_state = "onion"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/onion
	produce_amount_min = 3
	produce_amount_max = 4
	maturation_time = FAST_GROWING

/datum/plant_def/wheat
	name = "wheat stalks"
	icon_state = "wheat"
	produce_type = /obj/item/natural/chaff/wheat
	produce_amount_min = 3
	produce_amount_max = 5
	uproot_loot = list(/obj/item/natural/fibers, /obj/item/natural/fibers)
	maturation_nutrition = 30
	maturation_time = FAST_GROWING
	produce_time = 2 MINUTES

/datum/plant_def/oat
	name = "oat stalks"
	icon_state = "oat"
	produce_type = /obj/item/natural/chaff/oat
	produce_amount_min = 3
	produce_amount_max = 5
	uproot_loot = list(/obj/item/natural/fibers, /obj/item/natural/fibers)
	maturation_nutrition = 30
	maturation_time = FAST_GROWING
	produce_time = 2 MINUTES

/datum/plant_def/westleach
	name = "westleach leaf"
	icon_state = "westleach"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/westleach
	produce_amount_min = 3
	produce_amount_max = 5
	maturation_nutrition = 30
	maturation_time = FAST_GROWING
	produce_time = 2 MINUTES



//................ Perennial plants ...............................	(Don't need replanting but generally needs more nutrition refills)
/datum/plant_def/jacksberry
	name = "jacksberry bush"
	icon_state = "berry"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/jacksberry
	uproot_loot = list(/obj/item/grown/log/tree/stick)
	perennial = TRUE
	produce_amount_min = 2
	produce_amount_max = 4
	maturation_nutrition = HUNGRINESS_DEMANDING
	maturation_time = FAST_GROWING

/datum/plant_def/jacksberry_poison
	name = "jacksberry bush"
	icon_state = "berry"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/jacksberry/poison
	uproot_loot = list(/obj/item/grown/log/tree/stick)
	perennial = TRUE
	produce_amount_min = 2
	produce_amount_max = 4
	maturation_nutrition = HUNGRINESS_DEMANDING
	maturation_time = FAST_GROWING

/datum/plant_def/apple
	name = "apple tree"
	icon_state = "apple"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/apple
	uproot_loot = list(/obj/item/grown/log/tree/small)
	perennial = TRUE
	produce_amount_min = 2
	produce_amount_max = 4
	maturation_nutrition = HUNGRINESS_DEMANDING

/datum/plant_def/pear
	name = "pear tree"
	icon_state = "pear"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/pear
	uproot_loot = list(/obj/item/grown/log/tree/small)
	perennial = TRUE
	produce_amount_min = 2
	produce_amount_max = 4
	maturation_nutrition = HUNGRINESS_DEMANDING

//................ Nutrition-efficient plants ...............................
/datum/plant_def/potato
	name = "potato plant"
	icon_state = "potato"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/potato
	produce_amount_min = 3
	produce_amount_max = 5
	maturation_nutrition = HUNGRINESS_TINY
	water_drain_rate = 1 / (1 MINUTES)

/datum/plant_def/turnip
	name = "turnip patch"
	icon_state = "turnip"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/turnip
	produce_amount_min = 4
	produce_amount_max = 6
	maturation_nutrition = HUNGRINESS_TINY
	maturation_time = FAST_GROWING
	water_drain_rate = 1 / (1 MINUTES)

//................ Water-efficient plants ...............................
/datum/plant_def/swampweed
	name = "swampweed"
	icon_state = "swampweed"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/swampweed
	produce_amount_min = 3
	produce_amount_max = 5
	water_drain_rate = 0

//................ Flowers ...............................
/datum/plant_def/sunflower
	name = "sunflowers"
	icon_state = "sunflower"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/sunflower
	produce_amount_min = 3
	produce_amount_max = 4
	maturation_nutrition = HUNGRINESS_TINY
	maturation_time = VERY_FAST_GROWING
	water_drain_rate = 1 / (2 MINUTES)

/datum/plant_def/fyritiusflower
	name = "fyritius flowers"
	icon_state = "fyritius"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/fyritius
	produce_amount_min = 1
	produce_amount_max = 3
	maturation_time = FAST_GROWING
	water_drain_rate = 1 / (2 MINUTES)

/datum/plant_def/poppy
	name = "poppies"
	icon_state = "poppy"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/poppy
	produce_amount_min = 1
	produce_amount_max = 2
	maturation_nutrition = HUNGRINESS_DEMANDING
	water_drain_rate = 1 / (2 MINUTES)

/*
/datum/plant_def/garlic
	name = "garlic patch"
	icon = 'icons/roguetown/misc/crops.dmi'
	icon_state = "garlic"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/garlic
	maturation_nutrition = 25
	produce_nutrition =  15
	maturation_time = 4 MINUTES
	produce_time = 2 MINUTES

/datum/plant_def/amanita
	name = "strange red mushroom patch"
	icon = 'icons/roguetown/misc/crops.dmi'
	icon_state = "amanita"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/amanita
	produce_amount_min = 2
	produce_amount_max = 4
	maturation_nutrition = 25
	produce_nutrition =  15
	maturation_time = 4 MINUTES
	produce_time = 2 MINUTES
	weed_immune = TRUE
	can_grow_underground = TRUE
*/

#undef FAST_GROWING
#undef VERY_FAST_GROWING

#undef HUNGRINESS_DEMANDING
#undef HUNGRINESS_NORMAL
#undef HUNGRINESS_TINY

