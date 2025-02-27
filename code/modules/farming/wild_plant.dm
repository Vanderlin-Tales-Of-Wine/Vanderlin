/obj/structure/wild_plant
	name = "wild "
	desc = "A wild "
	icon = 'icons/roguetown/misc/crops.dmi'
	var/datum/plant_def/plant_type
	var/spread_chance = 75


/obj/structure/wild_plant/New(loc, datum/plant_def/incoming_type, spread_chance = 75)
	. = ..()
	src.plant_type = new incoming_type

	if(prob(spread_chance))
		try_spread()

	name = name + src.plant_type.name
	desc = desc + src.plant_type.name
	icon_state = "[src.plant_type.icon_state]2"



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

	var/farming_skill = user.mind.get_skill_level(/datum/skill/labor/farming)
	var/chance_to_ruin = 50 - (farming_skill * 25)
	if(prob(chance_to_ruin))
		to_chat(user, span_warning("I ruin the produce..."))
		qdel(src)
		return
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

	to_chat(user, span_notice(feedback))
	yield_produce(modifier)

/obj/structure/wild_plant/proc/yield_produce(modifier = 0)
	var/base_amount = rand(plant_type.produce_amount_min, plant_type.produce_amount_max)
	var/spawn_amount = max(base_amount + modifier, 1)
	for(var/i in 1 to spawn_amount)
		new plant_type.produce_type(loc)
	qdel(src)


/obj/structure/wild_plant/random/New(loc, datum/plant_def/incoming_type, spread_chance)
	incoming_type = pick(subtypesof(/datum/plant_def))
	spread_chance = rand(25, 100)
	. = ..()
