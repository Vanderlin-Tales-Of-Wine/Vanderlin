SUBSYSTEM_DEF(dungeon_generator)
	name = "Matthios Creation"
	wait = 1 SECONDS

	init_order = INIT_ORDER_DUNGEON
	runlevels = RUNLEVEL_GAME | RUNLEVEL_INIT | RUNLEVEL_LOBBY
	lazy_load = FALSE

	var/list/parent_types = list()

	var/list/created_types = list()

	var/list/markers = list()

	var/list/placed_types = list()

	var/created_since = 0
	var/unlinked_dungeon_length = 0

/datum/controller/subsystem/dungeon_generator/Initialize(start_timeofday)
	unlinked_dungeon_length = length(GLOB.unlinked_dungeon_entries)
	while(length(markers))
		for(var/obj/effect/dungeon_directional_helper/helper as anything in markers)
			if(!get_turf(helper))
				continue
			find_soulmate(helper.dir, get_turf(helper), helper)
			markers -= helper
	return ..()

/datum/controller/subsystem/dungeon_generator/fire(resumed)
	var/current_run = 0
	if(length(markers))
		for(var/obj/effect/dungeon_directional_helper/helper as anything in markers)
			if(current_run >= 4)
				return
			if(!get_turf(helper))
				continue
			find_soulmate(helper.dir, get_turf(helper), helper)
			markers -= helper
			if(TICK_CHECK_LOW)
				return
			current_run++

/datum/controller/subsystem/dungeon_generator/proc/find_soulmate(direction, turf/creator, obj/effect/dungeon_directional_helper/looking_for_love)
	creator = get_step(creator, direction)
	if(!creator)
		return
	if(creator.type != /turf/closed/dungeon_void)
		return
	switch(direction)
		if(NORTH)
			direction = SOUTH
		if(SOUTH)
			direction = NORTH
		if(EAST)
			direction = WEST
		if(WEST)
			direction = EAST

	if(!length(parent_types))
		for(var/datum/map_template/dungeon/path as anything in subtypesof(/datum/map_template/dungeon))
			if(!is_abstract(path))
				continue
			if(!initial(path.type_weight))
				continue
			parent_types += path
			parent_types[path] = initial(path.type_weight)

	if(!length(created_types))
		for(var/path in subtypesof(/datum/map_template/dungeon))
			if(is_abstract(path))
				continue
			var/datum/map_template/dungeon/template = new path
			created_types += template
			created_types[template] = template.rarity

	var/picked_type = pickweight(parent_types)
	var/picking = TRUE
	if(unlinked_dungeon_length > 0)
		if(created_since > 30)
			if(prob(10 + created_since))
				picked_type = /datum/map_template/dungeon/entry

	if(!try_pickedtype_first(picked_type, direction, creator, looking_for_love))
		var/list/true_list = created_types.Copy()
		while(picking)
			if(!GET_TURF_ABOVE(creator))
				message_admins("[ADMIN_JMP(creator)] A dungeon piece was set to spawn on a top level z. This is not intended, their is a bad template.")
				return
			if(!length(true_list))
				return
			var/datum/map_template/dungeon/template = pickweight(true_list)
			true_list -= template
			if(is_abstract(template))
				continue
			if(is_type_in_list(template, list(subtypesof(picked_type) + subtypesof(/datum/map_template/dungeon/entry))))
				continue
			var/turf/true_spawn
			switch(direction)
				if(WEST)
					if(!template.west_offset)
						continue
					if(creator.y - template.west_offset < 0)
						continue
					var/turf/turf = locate(creator.x, creator.y - template.west_offset, creator.z)
					if(turf?.type != /turf/closed/dungeon_void)
						continue
					var/turf/turf2 = locate(creator.x + template.width, creator.y - template.east_offset, creator.z)
					if(turf2?.type != /turf/closed/dungeon_void)
						continue
					true_spawn = get_offset_target_turf(creator, 0, -(template.west_offset))
					if(true_spawn.x + template.width > world.maxx)
						continue
					if(true_spawn.y + template.height > world.maxy)
						continue
					var/list/turfs = block(true_spawn, locate(true_spawn.x + template.width, true_spawn.y + template.height, true_spawn.z))
					var/fail = FALSE
					for(var/turf/list_turf in turfs)
						if(list_turf.type != /turf/closed/dungeon_void)
							fail = TRUE
							break
					if(fail)
						continue
					if(!template.load(true_spawn))
						continue

				if(NORTH)
					if(!template.north_offset)
						continue
					if(creator.x - template.north_offset < 0)
						continue
					if(creator.y - template.height < 0)
						continue
					var/turf/turf = locate(creator.x - template.north_offset - 1, creator.y + template.height, creator.z)
					if(turf?.type != /turf/closed/dungeon_void)
						continue
					var/turf/turf2 = locate(creator.x -(template.north_offset - 1) + template.width, creator.y + template.height, creator.z)
					if(turf2?.type != /turf/closed/dungeon_void)
						continue
					true_spawn = get_offset_target_turf(creator, -(template.north_offset), -(template.height-1))
					if(true_spawn.x + template.width > world.maxx)
						continue
					if(true_spawn.y + template.height > world.maxy)
						continue
					var/list/turfs = block(true_spawn, locate(true_spawn.x + template.width, true_spawn.y + template.height-1, true_spawn.z))
					var/fail = FALSE
					for(var/turf/list_turf in turfs)
						if(list_turf.type != /turf/closed/dungeon_void)
							fail = TRUE
							break
					if(fail)
						continue
					if(!template.load(true_spawn))
						continue

				if(SOUTH)
					if(!template.south_offset)
						continue
					if(creator.y - template.south_offset < 0)
						continue
					var/turf/turf = locate(creator.x, creator.y + template.height, creator.z)
					if(turf?.type != /turf/closed/dungeon_void)
						continue
					var/turf/turf2 = locate(creator.x + template.width - template.south_offset, creator.y + template.height, creator.z)
					if(turf2?.type != /turf/closed/dungeon_void)
						continue
					true_spawn = get_offset_target_turf(creator, -template.south_offset, 0)
					if(true_spawn.x + template.width > world.maxx)
						continue
					if(true_spawn.y + template.height > world.maxy)
						continue
					var/list/turfs = block(true_spawn, locate(true_spawn.x + template.width, true_spawn.y + template.height, true_spawn.z))
					var/fail = FALSE
					for(var/turf/list_turf in turfs)
						if(list_turf.type != /turf/closed/dungeon_void)
							fail = TRUE
							break
					if(fail)
						continue
					if(!template.load(true_spawn))
						continue

				if(EAST)
					if(!template.east_offset)
						continue
					if(creator.y - template.east_offset < 0)
						continue
					if(creator.x - template.width < 0)
						continue
					var/turf/turf = locate(creator.x - (template.width-1), creator.y - template.east_offset, creator.z)
					if(turf?.type != /turf/closed/dungeon_void)
						continue
					var/turf/turf2 = locate(creator.x, creator.y - template.east_offset, creator.z)
					if(turf2?.type != /turf/closed/dungeon_void)
						continue
					true_spawn = get_offset_target_turf(creator, -(template.width-1), -template.east_offset)
					if(true_spawn.x + template.width > world.maxx)
						continue
					if(true_spawn.y + template.height > world.maxy)
						continue
					var/list/turfs = block(true_spawn, locate(true_spawn.x + template.width-1, true_spawn.y + template.height, true_spawn.z))
					var/fail = FALSE
					for(var/turf/list_turf in turfs)
						if(list_turf.type != /turf/closed/dungeon_void)
							fail = TRUE
							break
					if(fail)
						continue
					if(!template.load(true_spawn))
						continue

			picking = FALSE
			placed_types |= template.type
			placed_types[template.type]++
			created_since++

/datum/controller/subsystem/dungeon_generator/proc/try_pickedtype_first(picked_type, direction, turf/creator, obj/effect/dungeon_directional_helper/looking_for_love)
	var/picking = TRUE

	var/list/true_list = created_types.Copy()
	while(picking)
		if(!length(true_list))
			return FALSE
		var/datum/map_template/dungeon/template = pickweight(true_list)
		true_list -= template
		if(is_abstract(template))
			continue
		if(!is_type_in_list(template, subtypesof(picked_type)))
			continue
		var/turf/true_spawn
		switch(direction)
			if(WEST)
				if(!template.west_offset)
					continue
				if(creator.y - template.west_offset < 0)
					continue
				var/turf/turf = locate(creator.x, creator.y - template.west_offset, creator.z)
				if(turf?.type != /turf/closed/dungeon_void)
					continue
				var/turf/turf2 = locate(creator.x + template.width, creator.y - template.east_offset, creator.z)
				if(turf2?.type != /turf/closed/dungeon_void)
					continue
				true_spawn = get_offset_target_turf(creator, 0, -(template.west_offset))
				if(true_spawn.x + template.width > world.maxx)
					continue
				if(true_spawn.y + template.height > world.maxy)
					continue
				var/list/turfs = block(true_spawn, locate(true_spawn.x + template.width, true_spawn.y + template.height, true_spawn.z))
				var/fail = FALSE
				for(var/turf/list_turf in turfs)
					if(list_turf.type != /turf/closed/dungeon_void)
						fail = TRUE
						break
				if(fail)
					continue
				if(!template.load(true_spawn))
					continue

			if(NORTH)
				if(!template.north_offset)
					continue
				if(creator.x - template.north_offset < 0)
					continue
				if(creator.y - template.height < 0)
					continue
				var/turf/turf = locate(creator.x - template.north_offset - 1, creator.y + template.height, creator.z)
				if(turf?.type != /turf/closed/dungeon_void)
					continue
				var/turf/turf2 = locate(creator.x -(template.north_offset - 1) + template.width, creator.y + template.height, creator.z)
				if(turf2?.type != /turf/closed/dungeon_void)
					continue
				true_spawn = get_offset_target_turf(creator, -(template.north_offset), -(template.height-1))
				if(true_spawn.x + template.width > world.maxx)
					continue
				if(true_spawn.y + template.height > world.maxy)
					continue
				var/list/turfs = block(true_spawn, locate(true_spawn.x + template.width, true_spawn.y + template.height-1, true_spawn.z))
				var/fail = FALSE
				for(var/turf/list_turf in turfs)
					if(list_turf.type != /turf/closed/dungeon_void)
						fail = TRUE
						break
				if(fail)
					continue
				if(!template.load(true_spawn))
					continue

			if(SOUTH)
				if(!template.south_offset)
					continue
				if(creator.y - template.south_offset < 0)
					continue
				var/turf/turf = locate(creator.x, creator.y + template.height, creator.z)
				if(turf?.type != /turf/closed/dungeon_void)
					continue
				var/turf/turf2 = locate(creator.x + template.width - template.south_offset, creator.y + template.height, creator.z)
				if(turf2?.type != /turf/closed/dungeon_void)
					continue
				true_spawn = get_offset_target_turf(creator, -template.south_offset, 0)
				if(true_spawn.x + template.width > world.maxx)
					continue
				if(true_spawn.y + template.height > world.maxy)
					continue
				var/list/turfs = block(true_spawn, locate(true_spawn.x + template.width, true_spawn.y + template.height, true_spawn.z))
				var/fail = FALSE
				for(var/turf/list_turf in turfs)
					if(list_turf.type != /turf/closed/dungeon_void)
						fail = TRUE
						break
				if(fail)
					continue
				if(!template.load(true_spawn))
					continue

			if(EAST)
				if(!template.east_offset)
					continue
				if(creator.y - template.east_offset < 0)
					continue
				if(creator.x - template.width < 0)
					continue
				var/turf/turf = locate(creator.x - (template.width-1), creator.y - template.east_offset, creator.z)
				if(turf?.type != /turf/closed/dungeon_void)
					continue
				var/turf/turf2 = locate(creator.x, creator.y - template.east_offset, creator.z)
				if(turf2?.type != /turf/closed/dungeon_void)
					continue
				true_spawn = get_offset_target_turf(creator, -(template.width-1), -template.east_offset)
				if(true_spawn.x + template.width > world.maxx)
					continue
				if(true_spawn.y + template.height > world.maxy)
					continue
				var/list/turfs = block(true_spawn, locate(true_spawn.x + template.width-1, true_spawn.y + template.height, true_spawn.z))
				var/fail = FALSE
				for(var/turf/list_turf in turfs)
					if(list_turf.type != /turf/closed/dungeon_void)
						fail = TRUE
						break
				if(fail)
					continue
				if(!template.load(true_spawn))
					continue

		picking = FALSE
		created_since++
		placed_types |= template.type
		placed_types[template.type]++
	if(picked_type == /datum/map_template/dungeon/entry)
		created_since = 0
		unlinked_dungeon_length--
	return TRUE
