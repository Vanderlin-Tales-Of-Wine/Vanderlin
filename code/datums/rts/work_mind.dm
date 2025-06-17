/mob/living/proc/made_into_controller_mob()
	QDEL_NULL(ai_controller)

/datum/worker_mind
	var/mob/camera/strategy_controller/master
	var/mob/living/worker
	var/worker_name
	///10 is default so 20 is double etc
	var/work_speed = 10
	///our worker walk speed
	var/walkspeed = 5
	///100 is default
	var/maximum_stamina = 100
	var/current_stamina = 100

	var/datum/work_order/current_task
	var/turf/movement_target

	var/list/worker_gear
	var/list/worker_moodlets

	var/datum/idle_tendancies/idle

	var/paused = FALSE

	var/atom/movable/screen/controller_ui/controller_ui/stats

	var/list/current_path = list()
	var/next_recalc = 0

	var/datum/persistant_workorder/assigned_work

	var/paused_until = 0
	var/atom/move_back_after
	var/work_pause = FALSE
	var/datum/work_order/paused_task

	var/datum/worker_attack_strategy/attack_mode

	var/list/personality_traits = list()
	var/mood_level = 50 // 0-100, affects work speed and decisions
	var/experience_level = 0 // Grows over time, unlocks new behaviors
	var/preferred_tasks = list() // Tasks this worker gravitates toward
	var/list/learned_behaviors = list() // Behaviors this worker has learned

/datum/worker_mind/New(mob/living/new_worker, mob/camera/strategy_controller/new_master)
	. = ..()
	idle = new /datum/idle_tendancies/dynamic
	master = new_master
	worker = new_worker

	worker.pass_flags |= PASSMOB
	worker.density = FALSE

	worker_name = pick( world.file2list("strings/rt/names/dwarf/dwarmm.txt") )
	worker.real_name = "[worker_name] the [worker.real_name]"
	worker.name = worker.real_name

	master.add_new_worker(worker)
	worker.made_into_controller_mob()
	stats = new /atom/movable/screen/controller_ui/controller_ui(worker, src)
	START_PROCESSING(SSstrategy_master, src)

/datum/worker_mind/proc/has_learned_behavior(behavior_name)
	return (behavior_name in learned_behaviors)

/datum/worker_mind/proc/learn_behavior(behavior_name)
	if(behavior_name in learned_behaviors)
		return FALSE
	learned_behaviors += behavior_name
	return TRUE

/datum/worker_mind/proc/head_to_target()
	if(!movement_target)
		return

	if(next_recalc < world.time)
		enhanced_pathfinding()
		next_recalc = world.time + 2 SECONDS
	if(!length(current_path) && !worker.CanReach(movement_target))
		enhanced_pathfinding()
		if(!length(current_path))
			current_task.stop_work()
	if(length(current_path) >= 3)
		walk_to(worker, current_path[3],0,5)
		current_path -= current_path[3]
		current_path -= current_path[2]
		current_path -= current_path[1]
	else
		walk_to(worker, current_path[length(current_path)],0,5)
		current_path = list()

/datum/worker_mind/proc/start_task()
	current_task.start_working(worker)

/datum/worker_mind/process()
	if(worker.stat >= DEAD)
		return
	check_worktree()
	update_stat_panel()

/datum/worker_mind/proc/start_idle()
	idle.perform_idle(master, worker)

/datum/worker_mind/proc/try_restore_stamina()
	if(!length(master.constructed_building_nodes))
		var/list/turfs = view(6, worker)
		shuffle_inplace(turfs)
		for(var/turf/open/open in turfs)
			set_current_task(/datum/work_order/nappy_time, open)
			break
	else
		for(var/obj/effect/building_node/node in master.constructed_building_nodes)
			if(!istype(node, /obj/effect/building_node/kitchen))
				continue
			set_current_task(/datum/work_order/go_try_eat, node)
			return

		var/list/turfs = view(6, worker)
		shuffle_inplace(turfs)
		for(var/turf/open/open in turfs)
			set_current_task(/datum/work_order/nappy_time, open)
			break

/datum/worker_mind/proc/set_current_task(datum/work_order/order, ...)
	var/list/arg_list = list(worker) + args
	current_task = new order(arglist(arg_list))
	update_stat_panel()

/datum/worker_mind/proc/finish_work(success, stamina_cost)
	current_stamina = max(0, current_stamina - stamina_cost)
	current_task = null
	movement_target = null
	paused = FALSE
	walk(worker, 0)

/datum/worker_mind/proc/stop_working()
	current_task = null
	movement_target = null
	paused = FALSE
	walk(worker, 0)

/datum/worker_mind/proc/set_movement_target(atom/target)
	walk(worker, 0)
	movement_target = target

/datum/worker_mind/proc/add_gear(obj/item/gear)
	LAZYADD(worker_gear, gear)
	gear.forceMove(worker)

/datum/worker_mind/proc/remove_gear(obj/item/gear)
	LAZYREMOVE(worker_gear, gear)
	gear.forceMove(get_turf(worker))

/datum/worker_mind/proc/add_test_instrument()
	var/obj/item/instrument/guitar/guitar = new(get_turf(worker))
	add_gear(guitar)

/datum/worker_mind/proc/play_testing_song()
	if(current_task)
		current_task.stop_work()

	for(var/obj/item/gear in worker_gear)
		if(!istype(gear, /obj/item/instrument))
			continue

		var/list/turfs = view(6, worker)
		shuffle_inplace(turfs)
		for(var/turf/open/open in turfs)
			set_current_task(/datum/work_order/play_music, open, gear)
			break

/datum/worker_mind/proc/update_stat_panel()
	stats.update_text()

/datum/worker_mind/proc/check_paused_state()
	if(work_pause && (world.time > paused_until) && !current_task)
		set_movement_target(move_back_after)
		work_pause = FALSE
		current_task = paused_task
		paused_task = null
		return TRUE
	return FALSE

/datum/worker_mind/proc/check_worktree()
	if(paused)
		return

	if(attack_mode)
		if(attack_mode.current_target)
			if(!attack_mode.can_attack_target())
				walk_to(worker, attack_mode.current_target, 1, worker.controller_mind.walkspeed)
			return
		else if(attack_mode.find_targets())
			if(!attack_mode.can_attack_target())
				walk_to(worker, attack_mode.current_target, 1, worker.controller_mind.walkspeed)
				return

	if(check_paused_state())
		return

	if(movement_target && (!worker.CanReach(movement_target)))
		head_to_target()
		return
	if(current_task && world.time > paused_until)
		start_task()
		return
	if(current_stamina <= 0)
		try_restore_stamina()
		return
	if(assigned_work && !current_task && !paused_task)
		assigned_work.apply_to_worker(worker)
		return
	if(master.should_stop_idle(src))
		return
	start_idle()

/datum/worker_mind/proc/pause_task_for(duration = 60 SECONDS, atom/after_pause_target)
	move_back_after = after_pause_target
	work_pause = TRUE
	paused_task = current_task
	current_task = null
	paused_until = world.time + duration

/datum/worker_mind/proc/stop_chase()
	walk(worker, 0)

/datum/worker_mind/proc/suppress_attack()
	attack_mode?.lose_target()
	stop_chase()

/datum/worker_mind/proc/apply_attack_strategy(datum/worker_attack_strategy/attack_path = /datum/worker_attack_strategy)
	var/datum/worker_attack_strategy/new_attack = new attack_path(worker)
	attack_mode = new_attack

/datum/worker_mind/proc/check_mood_events()
	// Check for mood-affecting events
	if(current_stamina < 20)
		adjust_mood(-5, "exhausted")

	if(length(worker_gear))
		adjust_mood(2, "well equipped")

	// Social interactions
	var/nearby_workers = 0
	for(var/mob/living/other in view(3, worker))
		if(other.controller_mind && other != worker)
			nearby_workers++

	if(has_personality("social") && nearby_workers > 0)
		adjust_mood(3, "socializing")
	else if(has_personality("social") && nearby_workers == 0)
		adjust_mood(-2, "lonely")

/datum/worker_mind/proc/adjust_mood(amount, reason)
	mood_level = clamp(mood_level + amount, 0, 100)
	if(amount > 0)
		worker.visible_message("[worker] seems happier.")
	else if(amount < -3)
		worker.visible_message("[worker] looks dejected.")

/datum/worker_mind/proc/has_personality(trait_name)
	for(var/datum/personality_trait/trait in personality_traits)
		if(trait.name == trait_name)
			return TRUE
	return FALSE

/datum/worker_mind/proc/check_emergent_behaviors()
	// Workers develop new behaviors based on experience
	if(experience_level > 50 && !has_learned_behavior("leadership"))
		if(prob(20))
			learn_behavior("leadership")
			worker.visible_message("[worker] has learned to coordinate with others!")

	// Spontaneous tool creation
	if(current_task && prob(5) && experience_level > 25)
		try_improvise_tool()

/datum/worker_mind/proc/try_improvise_tool()
	// Look for materials to create simple tools
	var/list/nearby_items = list()
	for(var/obj/item/item in view(2, worker))
		nearby_items += item

	if(length(nearby_items) >= 2)
		worker.visible_message("[worker] starts tinkering with nearby materials...")
		//TODO: Worker tool support

/datum/worker_mind/proc/enhanced_pathfinding()
	if(!movement_target)
		return

	// Workers remember and prefer certain routes
	var/route_key = "[get_turf(worker)]-[get_turf(movement_target)]"
	var/list/preferred_path = master.learned_routes[route_key]

	if(preferred_path && prob(70))
		current_path = preferred_path.Copy()
	else
		current_path = get_path_to(worker, get_turf(movement_target),
			TYPE_PROC_REF(/turf, Heuristic_cardinal_3d), 32 + 1, 250, 1)

		// Store successful routes
		if(length(current_path))
			master.learned_routes[route_key] = current_path.Copy()
