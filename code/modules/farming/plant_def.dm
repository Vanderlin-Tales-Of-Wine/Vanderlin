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
	produce_type = /obj/item/reagent_containers/food/snacks/produce/vegetable/cabbage
	produce_amount_min = 2
	produce_amount_max = 3
	maturation_time = FAST_GROWING

/datum/plant_def/onion
	name = "onion patch"
	icon_state = "onion"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/vegetable/onion
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
	produce_type = /obj/item/reagent_containers/food/snacks/produce/fruit/jacksberry
	uproot_loot = list(/obj/item/grown/log/tree/stick)
	perennial = TRUE
	produce_amount_min = 2
	produce_amount_max = 4
	maturation_nutrition = HUNGRINESS_DEMANDING
	maturation_time = FAST_GROWING

/datum/plant_def/jacksberry_poison
	name = "jacksberry bush"
	icon_state = "berry"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/fruit/jacksberry/poison
	uproot_loot = list(/obj/item/grown/log/tree/stick)
	perennial = TRUE
	produce_amount_min = 2
	produce_amount_max = 4
	maturation_nutrition = HUNGRINESS_DEMANDING
	maturation_time = FAST_GROWING

/datum/plant_def/strawberry
	name = "strawberry bush"
	icon_state = "strawberry"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/fruit/strawberry
	uproot_loot = list(/obj/item/grown/log/tree/stick)
	perennial = TRUE
	produce_amount_min = 2
	produce_amount_max = 4
	maturation_nutrition = HUNGRINESS_DEMANDING
	maturation_time = FAST_GROWING

/datum/plant_def/blackberry
	name = "blackberry bush"
	icon_state = "blackberry"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/fruit/blackberry
	uproot_loot = list(/obj/item/grown/log/tree/stick)
	perennial = TRUE
	produce_amount_min = 2
	produce_amount_max = 4
	maturation_nutrition = HUNGRINESS_DEMANDING
	maturation_time = FAST_GROWING

/datum/plant_def/raspberry
	name = "raspberry bush"
	icon_state = "raspberry"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/fruit/raspberry
	uproot_loot = list(/obj/item/grown/log/tree/stick)
	perennial = TRUE
	produce_amount_min = 2
	produce_amount_max = 4
	maturation_nutrition = HUNGRINESS_DEMANDING
	maturation_time = FAST_GROWING

/datum/plant_def/apple
	name = "apple tree"
	icon_state = "apple"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/fruit/apple
	uproot_loot = list(/obj/item/grown/log/tree/small)
	perennial = TRUE
	produce_amount_min = 2
	produce_amount_max = 4
	maturation_nutrition = HUNGRINESS_DEMANDING

/datum/plant_def/pear
	name = "pear tree"
	icon_state = "pear"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/fruit/pear
	uproot_loot = list(/obj/item/grown/log/tree/small)
	perennial = TRUE
	produce_amount_min = 2
	produce_amount_max = 4
	maturation_nutrition = HUNGRINESS_DEMANDING

/datum/plant_def/plum
	name = "plum tree"
	icon_state = "plumtree"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/fruit/plum
	uproot_loot = list(/obj/item/grown/log/tree/small)
	perennial = TRUE
	produce_amount_min = 2
	produce_amount_max = 4
	maturation_nutrition = HUNGRINESS_DEMANDING

/datum/plant_def/tangerine
	name = "tangerine tree"
	icon_state = "tangerinetree"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/fruit/tangerine
	uproot_loot = list(/obj/item/grown/log/tree/small)
	perennial = TRUE
	produce_amount_min = 2
	produce_amount_max = 4
	maturation_nutrition = HUNGRINESS_DEMANDING

/datum/plant_def/lime
	name = "lime tree"
	icon_state = "limetree"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/fruit/lime
	uproot_loot = list(/obj/item/grown/log/tree/small)
	perennial = TRUE
	produce_amount_min = 2
	produce_amount_max = 4
	maturation_nutrition = HUNGRINESS_DEMANDING

/datum/plant_def/lemon
	name = "lemon tree"
	icon_state = "lemontree"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/fruit/lemon
	uproot_loot = list(/obj/item/grown/log/tree/small)
	perennial = TRUE
	produce_amount_min = 2
	produce_amount_max = 4
	maturation_nutrition = HUNGRINESS_DEMANDING

/datum/plant_def/sugarcane
	name = "sugarcane"
	icon_state = "sugarcane"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/sugarcane
	perennial = TRUE
	produce_amount_min = 2
	produce_amount_max = 4
	maturation_nutrition = HUNGRINESS_DEMANDING

//................ Nutrition-efficient plants ...............................
/datum/plant_def/potato
	name = "potato plant"
	icon_state = "potato"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/vegetable/potato
	produce_amount_min = 3
	produce_amount_max = 5
	maturation_nutrition = HUNGRINESS_TINY
	water_drain_rate = 1 / (1 MINUTES)

/datum/plant_def/turnip
	name = "turnip patch"
	icon_state = "turnip"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/vegetable/turnip
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

/datum/plant_def/manabloom
	name = "manabloom"
	icon_state = "manabloom"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/manabloom
	produce_amount_min = 1
	produce_amount_max = 3
	maturation_time = FAST_GROWING
	water_drain_rate = 1 / (2 MINUTES)
	can_grow_underground = TRUE

/datum/plant_def/poppy
	name = "poppies"
	icon_state = "poppy"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/poppy
	produce_amount_min = 1
	produce_amount_max = 2
	maturation_nutrition = HUNGRINESS_DEMANDING
	water_drain_rate = 1 / (2 MINUTES)

//................ Alchemical Herbs ...............................
/datum/plant_def/alchemical
	name = ""
	icon = 'icons/roguetown/misc/herbfoliage.dmi'
	icon_state = "herb"
	uproot_loot = list(/obj/item/grown/log/tree/stick)
	perennial = TRUE
	produce_amount_min = 1
	produce_amount_max = 3
	maturation_time = FAST_GROWING
	water_drain_rate = 1 / (2 MINUTES)
	can_grow_underground = TRUE

/datum/plant_def/alchemical/atropa
	name = "atropa"
	icon_state = "atropa"
	produce_type = /obj/item/alch/atropa

/datum/plant_def/alchemical/matricaria
	name = "matricaria"
	icon_state = "matricaria"
	produce_type = /obj/item/alch/matricaria

/datum/plant_def/alchemical/symphitum
	name = "symphitum"
	icon_state = "symphitum"
	produce_type = /obj/item/alch/symphitum

/datum/plant_def/alchemical/taraxacum
	name = "taraxacum"
	icon_state = "taraxacum"
	produce_type = /obj/item/alch/taraxacum

/datum/plant_def/alchemical/euphrasia
	name = "euphrasia"
	icon_state = "euphrasia"
	produce_type = /obj/item/alch/euphrasia

/datum/plant_def/alchemical/urtica
	name = "urtica"
	icon_state = "urtica"
	produce_type = /obj/item/alch/urtica

/datum/plant_def/alchemical/calendula
	name = "calendula"
	icon_state = "calendula"
	produce_type = /obj/item/alch/calendula

/datum/plant_def/alchemical/mentha
	name = "mentha"
	icon_state = "mentha"
	produce_type = /obj/item/alch/mentha

/datum/plant_def/alchemical/salvia
	name = "salvia"
	icon_state = "salvia"
	produce_type = /obj/item/alch/salvia

/datum/plant_def/alchemical/hypericum
	name = "hypericum"
	icon_state = "hypericum"
	produce_type = /obj/item/alch/hypericum

/datum/plant_def/alchemical/benedictus
	name = "benedictus"
	icon_state = "benedictus"
	produce_type = /obj/item/alch/benedictus

/datum/plant_def/alchemical/valeriana
	name = "valeriana"
	icon_state = "valeriana"
	produce_type = /obj/item/alch/valeriana

/datum/plant_def/alchemical/paris
	name = "paris"
	icon_state = "paris"
	produce_type = /obj/item/alch/paris

/datum/plant_def/alchemical/artemisia
	name = "artemisia"
	icon_state = "artemisia"
	produce_type = /obj/item/alch/artemisia

/datum/plant_def/alchemical/rosa
	name = "rosa"
	icon_state = "rosa"
	produce_type = /obj/item/alch/rosa

/datum/plant_def/alchemical/euphorbia
	name = "euphorbia"
	icon_state = "euphorbia"
	produce_type = /obj/item/alch/euphorbia

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

