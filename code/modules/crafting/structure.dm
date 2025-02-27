
/datum/crafting_recipe/structure
	req_table = FALSE

/datum/crafting_recipe/structure/TurfCheck(mob/user, turf/T)
	if(istype(T,/turf/open/transparent/openspace))
		return FALSE
	return ..()

/datum/crafting_recipe/structure/anvil
	name = "anvil"
	result = /obj/machinery/anvil
	reqs = list(/obj/item/ingot/iron = 1)

	verbage = "build"
	verbage_tp = "builds"
	craftsound = 'sound/foley/Building-01.ogg'

/datum/crafting_recipe/structure/campfire
	name = "campfire"
	result = /obj/machinery/light/fueled/campfire
	reqs = list(/obj/item/grown/log/tree/stick = 2)
	verbage = "build"
	verbage_tp = "builds"
	craftdiff = 0

/datum/crafting_recipe/structure/densefire
	name = "greater campfire"
	result = /obj/machinery/light/fueled/campfire/densefire
	reqs = list(/obj/item/grown/log/tree/stick = 2,
				/obj/item/natural/stone = 2)
	verbage = "build"
	verbage_tp = "builds"

/datum/crafting_recipe/structure/cookpit
	name = "hearth"
	result = /obj/machinery/light/fueled/hearth
	reqs = list(/obj/item/grown/log/tree/stick = 1,
				/obj/item/natural/stone = 3)
	verbage = "build"
	verbage_tp = "builds"
	craftdiff = 0

/datum/crafting_recipe/structure/brazier
	name = "brazier"
	result = /obj/machinery/light/fueled/firebowl/stump
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/ore/coal = 1)
	verbage = "build"
	verbage_tp = "builds"

/datum/crafting_recipe/structure/standing
	name = "standing fire"
	result = /obj/machinery/light/fueled/firebowl/standing
	reqs = list(/obj/item/natural/stone = 1,
				/obj/item/ore/coal = 1)
	verbage = "build"
	verbage_tp = "builds"

/datum/crafting_recipe/structure/standingblue
	name = "standing fire (blue)"
	result = /obj/machinery/light/fueled/firebowl/standing/blue
	reqs = list(/obj/item/natural/stone = 1,
				/obj/item/ore/coal = 1,
				/obj/item/ash = 1)
	verbage = "build"
	verbage_tp = "builds"

/datum/crafting_recipe/structure/rack
	name = "rack"
	result = /obj/structure/rack
	reqs = list(/obj/item/grown/log/tree/stick = 3)
	verbage = "construct"
	verbage_tp = "constructs"
	craftdiff = 0

/datum/crafting_recipe/structure/dryingrack
	name = "drying rack"
	result = /obj/machinery/tanningrack
	reqs = list(/obj/item/grown/log/tree/stick = 3)
	verbage = "construct"
	verbage_tp = "constructs"
	craftsound = 'sound/foley/Building-01.ogg'

/datum/crafting_recipe/structure/bed
	name = "bed"
	result = /obj/structure/bed/shit
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/fibers = 1)
	verbage = "carpent"
	verbage_tp = "carpents"
	craftsound = 'sound/foley/Building-01.ogg'
	craftdiff = 0

/datum/crafting_recipe/structure/millstone
	name = "millstone"
	result = /obj/structure/fluff/millstone
	reqs = list(/obj/item/natural/stone = 3)
	verbage = "mason"
	verbage_tp = "masons"
	craftsound = null
	skillcraft = /datum/skill/craft/masonry

/datum/crafting_recipe/structure/torchholder
	name = "sconce"
	result = /obj/machinery/light/fueled/torchholder
	reqs = list(/obj/item/natural/stone = 2)
	verbage = "build"
	verbage_tp = "builds"
	skillcraft = /datum/skill/craft/masonry
	wallcraft = TRUE
	craftdiff = 0

/datum/crafting_recipe/structure/wallcandle
	name = "wall candles"
	result = /obj/machinery/light/fueled/wallfire/candle
	reqs = list(/obj/item/natural/stone = 1, /obj/item/candle/yellow = 1)
	verbage = "build"
	verbage_tp = "builds"
	skillcraft = /datum/skill/craft/masonry
	wallcraft = TRUE
	craftdiff = 0

/datum/crafting_recipe/structure/wallcandleblue
	name = "wall candles (blue)"
	result = /obj/machinery/light/fueled/wallfire/candle/blue
	reqs = list(/obj/item/natural/stone = 1, /obj/item/candle/yellow = 1, /obj/item/ash = 1)
	verbage = "build"
	verbage_tp = "builds"
	skillcraft = /datum/skill/craft/masonry
	wallcraft = TRUE
	craftdiff = 0
