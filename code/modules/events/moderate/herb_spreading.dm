GLOBAL_LIST_INIT(herb_locations, list())

/datum/round_event_control/herb_spread
	name = "Herb Spread"
	track = EVENT_TRACK_MODERATE
	typepath = /datum/round_event/herb_spread
	weight = 7
	max_occurrences = 8
	min_players = 0

	tags = list(
		TAG_NATURE,
		TAG_BOON,
		TAG_ALCHEMY,
	)

/datum/round_event/herb_spread/start()
	. = ..()
	for(var/i = 1 to rand(1, 9))
		var/obj/structure/flora/roguegrass/herb/herb = pick(GLOB.herb_locations)
		var/list/turfs = list()
		var/list/range_atoms = view(5, herb)
		for(var/turf/open/turf in range_atoms)
			if(istransparentturf(turf) || islava(turf) || istype(turf, /turf/open/water))
				continue
			turfs |= turf
		for(var/num = 1 to rand(3, 5))
			var/turf/open/spawn_turf = pick_n_take(turfs)
			new herb.type(spawn_turf)
