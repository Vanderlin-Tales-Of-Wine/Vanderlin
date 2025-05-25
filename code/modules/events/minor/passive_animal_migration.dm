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

// For animals traveling into town
/datum/round_event/animal_migration
	var/list/animals = list()
	var/static/list/valid_travel_points = \
	list("vanderlin-forest_town-town", "vanderlin-mountain_town-town", "vanderlin-bog_town-town", \
	"Rosewood_Howling", "rosewood-town-forest", \
	"daftmarsh-town-to-outlands", "daftmarsh-forest-to-outlands", "daftmarsh-basin-to-outlands", "daftmarsh-cave-to-outlands")

/datum/round_event/animal_migration/start()
	. = ..()
	var/list/tiles = list()
	for(var/obj/structure/fluff/traveltile/tile in GLOB.traveltiles)
		if(!(tile.aportalid in valid_travel_points))
			continue
		tiles |= tile

	if(!length(tiles) || !length(GLOB.animal_migration_points))
		return
	var/turf/start_turf = get_turf(pick(tiles))
	var/turf/end_turf = get_turf(pick(GLOB.animal_migration_points))
	var/mob/living/simple_animal/hostile/retaliate/animal = pick(animals)
	for(var/i = 1 to rand(1, 3))
		var/mob/living/simple_animal/hostile/retaliate/created = new animal(start_turf)
		if(created.ai_controller)
			created.ai_controller.set_blackboard_key(BB_WANDER_POINT, end_turf)
			var/list/ai_controller_paths = list()
			for(var/datum/ai_planning_subtree/tree as anything in created.ai_controller.planning_subtrees)
				ai_controller_paths |= tree.type
			ai_controller_paths |= /datum/ai_planning_subtree/travel_to_point/and_clear_target/wander
			created.ai_controller.replace_planning_subtrees(ai_controller_paths)

/datum/round_event/animal_migration/passive
	animals = list(
		/mob/living/simple_animal/hostile/retaliate/cow,
		/mob/living/simple_animal/hostile/retaliate/bull,
		/mob/living/simple_animal/hostile/retaliate/chicken,
		/mob/living/simple_animal/hostile/retaliate/trufflepig,
		/mob/living/simple_animal/hostile/retaliate/goat,
		/mob/living/simple_animal/hostile/retaliate/saiga,
	)
