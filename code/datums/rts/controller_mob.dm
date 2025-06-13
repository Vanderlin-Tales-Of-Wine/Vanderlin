/mob/camera/strategy_controller
	name = "Strategy Controller"
	real_name = "Strategy Controller"
	desc = "The overmind. It controls the kobolds."
	icon = 'icons/mob/cameramob.dmi'
	icon_state = "yalp_elor"
	mouse_opacity = MOUSE_OPACITY_ICON
	invisibility = INVISIBILITY_OBSERVER
	layer = FLY_LAYER
	plane = GAME_PLANE_UPPER
	see_invisible = SEE_INVISIBLE_LIVING
	uses_intents = FALSE
	lighting_alpha = LIGHTING_PLANE_ALPHA_INVISIBLE
	pass_flags = PASSCLOSEDTURF | PASSMOB | PASSTABLE
	next_move_modifier = 0

	var/list/learned_routes = list() // AI learns efficient paths
	var/list/worker_relationships = list() // Track worker interactions
	var/list/recent_events = list() // Event history affects behavior

	var/list/worker_mobs = list()
	var/list/dead_workers = list()

	var/datum/stockpile/resource_stockpile
	var/datum/stockpile_requests/requests

	var/list/possible_job_actions = list()

	var/list/in_progress_workorders = list()
	var/list/building_requests = list()

	var/list/constructed_building_nodes = list()

	var/atom/movable/screen/controller_ui/controller_ui/displayed_mob_ui
	var/atom/movable/screen/strategy_ui/controller_ui/displayed_base_ui
	var/atom/movable/screen/building_backdrop/building_icon

	var/datum/building_datum/held_build

	var/worker_type = /mob/living/simple_animal/hostile/retaliate/fae/sprite

/mob/camera/strategy_controller/Initialize()
	. = ..()
	displayed_base_ui = new
	building_icon = new
	START_PROCESSING(SSstrategy_master, src)

/mob/camera/strategy_controller/proc/close_building_ui()
	building_icon.close_uis(src)

/mob/camera/strategy_controller/proc/add_assignments(list/assignments)
	possible_job_actions |= assignments

/mob/camera/strategy_controller/proc/add_new_worker(mob/living/worker)
	worker_mobs |= worker

/mob/camera/strategy_controller/proc/test_place_stockpile()
	queue_building_build(/datum/building_datum/stockpile, get_turf(src))

/mob/camera/strategy_controller/proc/create_testing_controlled_mob()
	var/turf/new_turf = get_turf(src)
	var/mob/living/simple_animal/hostile/retaliate/leylinelycan/new_rat = new(new_turf)
	new_rat.controller_mind = new(new_rat, src)

/mob/camera/strategy_controller/proc/create_new_worker_mob(atom/spawn_loc)
	var/turf/turf = get_turf(spawn_loc)
	var/mob/living/new_mob = new worker_type(turf)
	new_mob.controller_mind = new(new_mob, src)

/mob/camera/strategy_controller/proc/try_setup_build(datum/building_datum/building)
	if(held_build)
		held_build.clean_up(success = FALSE)

	var/datum/building_datum/build = new building(src)
	build.setup_building_ghost()

/mob/camera/strategy_controller/proc/process_dynamic_events()
	if(prob(2)) // 2% chance per process
		trigger_random_event()


/mob/camera/strategy_controller/proc/trigger_random_event()
	if(!length(worker_mobs))
		return

	var/list/possible_events = list(
		"resource_discovery",
		"weather_change",
		"trader_arrival",
		"pest_infestation",
		"tool_breakdown",
		"inspiration_boost"
	)

	var/chosen_event = pick(possible_events)
	recent_events += "[world.time]: [chosen_event]"

	switch(chosen_event)
		if("resource_discovery")
			// Spawn resources near workers
			for(var/mob/living/worker in worker_mobs)
				if(prob(30))
					worker.visible_message("Something glints in the ground near [worker]!")

		if("inspiration_boost")
			// Random worker gets temporary mood/speed boost
			var/mob/living/lucky_worker = pick(worker_mobs)
			lucky_worker.controller_mind.adjust_mood(20, "sudden inspiration")
			lucky_worker.controller_mind.work_speed *= 1.5
			addtimer(CALLBACK(src, PROC_REF(remove_inspiration), lucky_worker), 5 MINUTES)

/mob/camera/strategy_controller/proc/remove_inspiration(mob/living/worker)
	if(worker && worker.controller_mind)
		worker.controller_mind.work_speed /= 1.5

/mob/camera/strategy_controller/proc/queue_building_build(datum/building_datum/building, turf/source_turf)
	new building(src, source_turf)

/mob/camera/strategy_controller/ClickOn(atom/A, params)
	var/list/modifiers = params2list(params)
	if(modifiers["left"] && get_turf(A))
		if(held_build)
			if(held_build.try_place_building(src, get_turf(A)))
				var/datum/building_datum/last_type = held_build.type
				held_build.clean_up(success = TRUE)
				if(modifiers["shift"])
					try_setup_build(last_type)

			else
				building_requests -= held_build
				held_build.clean_up()
			return
	. = ..()

/mob/camera/strategy_controller/RightClickOn(atom/A, params)
	var/allow_break = FALSE
	for(var/obj/structure/structure in A.contents)
		if(is_type_in_list(structure, GLOB.breakable_types))
			allow_break = TRUE
			break

	if (istype(A, /obj/effect/building_node) && displayed_mob_ui)
		var/mob/living/worker_mob = displayed_mob_ui.worker_mob
		if(!A:override_click(src))
			var/datum/persistant_workorder/old_workorder = worker_mob.controller_mind.assigned_work
			var/datum/persistant_workorder/chosen_workorder = A:select_workorder(src)
			if(chosen_workorder)
				worker_mob.controller_mind.assigned_work = chosen_workorder
				if(worker_mob.controller_mind.current_task && (old_workorder != chosen_workorder))
					worker_mob.controller_mind.current_task.stop_work()
				worker_mob.controller_mind.assigned_work.apply_to_worker(worker_mob)

	else if(isliving(A))
		var/mob/living/living = A
		if(living.controller_mind)
			displayed_base_ui.remove_ui(client)
			if(displayed_mob_ui)
				displayed_mob_ui.remove_ui(client)
			displayed_mob_ui  = living.controller_mind.stats
			displayed_mob_ui.add_ui(client)

	else if(isclosedturf(A) || allow_break)
		var/turf/turf = A
		if(turf.break_overlay)
			SEND_SIGNAL(turf, COMSIG_CANCEL_TURF_BREAK)
		else
			var/datum/queued_workorder/new_queued = new /datum/queued_workorder(/datum/work_order/break_turf, src, A)
			in_progress_workorders += new_queued
	. = ..()

/mob/camera/strategy_controller/process()
	building_icon?.update(src)

	process_dynamic_events()

	if(length(building_requests))
		for(var/mob/living/mob in worker_mobs)
			if(mob.stat >= DEAD)
				return
			if(!length(building_requests))
				return
			if(mob.controller_mind.current_task)
				continue
			if(mob.controller_mind.check_paused_state())
				continue

			for(var/datum/building_datum/building in building_requests)
				if(building.try_work_on(mob))
					return

	if(length(constructed_building_nodes))
		if(resource_stockpile)
			for(var/obj/effect/building_node/node in constructed_building_nodes)
				if(length(node.materials_to_store))
					for(var/mob/living/mob in worker_mobs)
						if(mob.stat >= DEAD)
							return
						if(mob.controller_mind.current_task)
							continue
						if(mob.controller_mind.check_paused_state())
							continue
						mob.controller_mind.set_current_task(/datum/work_order/store_materials, node, src)

				if(length(node.material_requests))
					var/passed = TRUE
					for(var/request in node.material_requests)
						if(!resource_stockpile.has_any_resources(node.material_requests[request]))
							passed = FALSE
					if(!passed)
						continue

					for(var/mob/living/mob in worker_mobs)
						if(mob.stat >= DEAD)
							return
						if(mob.controller_mind.current_task)
							continue
						if(mob.controller_mind.check_paused_state())
							continue
						mob.controller_mind.set_current_task(/datum/work_order/haul_materials, node, src)

	if(length(in_progress_workorders))
		for(var/mob/living/mob in worker_mobs)
			if(mob.stat >= DEAD)
				return
			if(!length(in_progress_workorders))
				return
			if(mob.controller_mind.current_task)
				continue
			if(mob.controller_mind.check_paused_state())
				continue

			for(var/datum/queued_workorder/workorder in in_progress_workorders)
				if(workorder.arg_1)
					if(!length(get_path_to(mob, workorder.arg_1, TYPE_PROC_REF(/turf, Heuristic_cardinal_3d), 32 + 1, 250,1)))
						continue
				mob.controller_mind.set_current_task(workorder.work_path, workorder.arg_1, workorder.arg_2, workorder.arg_3, workorder.arg_4)
				in_progress_workorders -= workorder
				qdel(workorder)
				return

/mob/camera/strategy_controller/proc/should_stop_idle(datum/worker_mind/mind)
	if(length(in_progress_workorders))
		return TRUE
	if(length(building_requests))
		return TRUE
	if(length(constructed_building_nodes))
		if(resource_stockpile)
			for(var/obj/effect/building_node/node in constructed_building_nodes)
				if(length(node.materials_to_store))
					return TRUE
				if(length(node.material_requests))
					return TRUE

	return FALSE


/mob/camera/strategy_controller/Login()
	. = ..()
	displayed_base_ui.add_ui(client)
	displayed_base_ui.add_ui_buttons(client)

	var/turf/T = get_turf(src)
	if (isturf(T))
		update_z(T.z)

/mob/camera/auto_deadmin_on_login()
	return

/mob/camera/Logout()
	update_z(null)
	return ..()

/mob/camera/onTransitZ(old_z,new_z)
	..()
	update_z(new_z)

/mob/camera/proc/update_z(new_z) // 1+ to register, null to unregister
	if (registered_z != new_z)
		if (registered_z)
			SSmobs.camera_players_by_zlevel[registered_z] -= src
		if (client)
			if (new_z)
				SSmobs.camera_players_by_zlevel[new_z] += src
			registered_z = new_z
		else
			registered_z = null
