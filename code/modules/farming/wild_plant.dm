/obj/structure/wild_plant
	name = "wild "
	desc = "A wild "
	icon_state = "tea2"
	icon = 'icons/roguetown/misc/crops.dmi'
	var/datum/plant_def/plant_type
	var/spread_chance = 75

/obj/structure/wild_plant/Initialize(mapload, ...)
	. = ..()
	if(!plant_type || !istype(plant_type))
		return
	plant_type = new plant_type
	if(prob(spread_chance))
		try_spread()

	name = name + plant_type.name
	desc = desc + plant_type.name

	pixel_x = rand(-12, 12)
	pixel_y = rand(-12, 12)

	icon_state = "[plant_type.icon_state]2"

/obj/structure/wild_plant/Destroy()
	if(istype(plant_type))
		QDEL_NULL(plant_type)
	return ..()

/obj/structure/wild_plant/Crossed(mob/living/carbon/human/H)
	playsound(loc, "plantcross", 80, FALSE, -1)

/obj/structure/wild_plant/proc/try_spread()
	var/list/dirs = GLOB.cardinals.Copy()

	dirs = shuffle(dirs)

	for(var/direction in dirs)
		var/turf/open/turf = get_step(src, direction)
		if(!istype(turf, /turf/open/floor/dirt) && !istype(turf, /turf/open/floor/grass) && !istype(turf, /turf/open/floor/snow))
			continue
		var/obj/structure/wild_plant/plant = locate(/obj/structure/wild_plant) in turf
		if(plant)
			continue
		if(is_anchored_dense_turf(turf))
			continue
		new /obj/structure/wild_plant(turf, plant_type.type, spread_chance - 20)
		if(!prob(spread_chance))
			return

/obj/structure/wild_plant/attack_hand(mob/user)
	. = ..()
	if(do_after(user, get_farming_do_time(user, 4 SECONDS), src))
		playsound(src,'sound/items/seed.ogg', 100, FALSE)
		user_harvests(user)
	return

/obj/structure/wild_plant/proc/user_harvests(mob/living/user)
	apply_farming_fatigue(user, 4)
	add_sleep_experience(user, /datum/skill/labor/farming, user.STAINT * 2)

	var/farming_skill = user.get_skill_level(/datum/skill/labor/farming)
	var/feedback = "I harvest the produce."
	var/modifier = 0
	var/chance_to_ruin_single = 75 - (farming_skill * 25)
	if(prob(chance_to_ruin_single))
		feedback = "I harvest the produce, ruining a little."
		modifier -= 1
	var/chance_to_get_extra = -75 + (farming_skill * 25)
	if(prob(chance_to_get_extra))
		feedback = "I harvest the produce well."
		modifier += 1

	if(has_world_trait(/datum/world_trait/dendor_fertility))
		feedback = "Praise Dendor for our harvest is bountiful."
		modifier += 3

	record_featured_stat(FEATURED_STATS_FARMERS, user)
	record_featured_object_stat(FEATURED_STATS_CROPS, plant_type.name)
	GLOB.vanderlin_round_stats[STATS_PLANTS_HARVESTED]++
	to_chat(user, span_notice(feedback))
	yield_produce(modifier)

/obj/structure/wild_plant/proc/yield_produce(modifier = 0)
	var/base_amount = rand(plant_type.produce_amount_min, plant_type.produce_amount_max)
	var/spawn_amount = max(base_amount + modifier, 1)
	for(var/i in 1 to spawn_amount)
		new plant_type.produce_type(loc)
	qdel(src)

/obj/structure/wild_plant/random/Initialize()
	plant_type = pick(subtypesof(/datum/plant_def))
	spread_chance = rand(25, 100)
	return ..()

/obj/structure/wild_plant/manabloom
	plant_type = /datum/plant_def/manabloom

/obj/structure/wild_plant/manabloom/Initialize()
	spread_chance = rand(25, 50)
	return ..()

/obj/structure/wild_plant/nospread
	spread_chance = 0

/obj/structure/wild_plant/nospread/manabloom
	icon_state = "manabloom2"
	plant_type = /datum/plant_def/manabloom

/obj/structure/wild_plant/nospread/poppy
	icon_state = "poppy2"
	plant_type = /datum/plant_def/poppy
