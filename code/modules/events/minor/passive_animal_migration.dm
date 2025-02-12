GLOBAL_LIST_INIT(animal_migration_points, list())

/obj/effect/landmark/events/animal_migration_point
	name = "Migration Point"

/obj/effect/landmark/events/animal_migration_point/Initialize(mapload)
	. = ..()
	GLOB.animal_migration_points += src
	icon_state = ""

/datum/round_event_control/passive_animal_migration
	name = "Passive Animal Migration"
	track = EVENT_TRACK_MUNDANE
	typepath = /datum/round_event/animal_migration/passive
	weight = 5
	max_occurrences = 8
	min_players = 0
	earliest_start = 5 MINUTES

	tags = list(
		TAG_NATURE,
		TAG_BOON,
	)

/datum/round_event/animal_migration
	var/list/animals = list()

/datum/round_event/animal_migration/start()
	. = ..()
	var/list/tiles = list()
	for(var/obj/structure/fluff/traveltile/tile in GLOB.traveltiles)
		if(tile.aportalid != "vanderlin-forest_town-town")
			continue
		tiles |= tile

	var/turf/start_turf = get_turf(pick(tiles))
	var/turf/end_turf = get_turf(pick(GLOB.animal_migration_points))
	var/mob/living/simple_animal/hostile/retaliate/rogue/animal = pick(animals)
	for(var/i = 1 to rand(3, 5))
		var/mob/living/simple_animal/hostile/retaliate/rogue/created = new animal(start_turf)
		if(created.ai_controller)
			created.ai_controller.set_blackboard_key(BB_WANDER_POINT, end_turf)
			created.ai_controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_WANDER_POINT)
		else
			created.GiveTarget(end_turf)

/datum/round_event/animal_migration/passive
	animals = list(
		/mob/living/simple_animal/hostile/retaliate/rogue/cow,
		/mob/living/simple_animal/hostile/retaliate/rogue/bull,
		/mob/living/simple_animal/hostile/retaliate/rogue/chicken,
		/mob/living/simple_animal/hostile/retaliate/rogue/trufflepig,
		/mob/living/simple_animal/hostile/retaliate/rogue/goat,
		/mob/living/simple_animal/hostile/retaliate/rogue/saiga,
	)
