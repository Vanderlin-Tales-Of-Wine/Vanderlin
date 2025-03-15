/datum/idle_tendancies

/datum/idle_tendancies/proc/perform_idle(mob/camera/strategy_controller/master, mob/living/worker)
	return

/datum/idle_tendancies/basic/perform_idle(mob/camera/strategy_controller/master, mob/living/worker)
	switch(rand(1, 100))
		if(1 to 25)
			if(length(master.constructed_building_nodes))
				worker.controller_mind.set_current_task(/datum/work_order/wander_to_building, pick(master.constructed_building_nodes))
			else
				var/list/turfs = view(6, worker)
				shuffle_inplace(turfs)
				for(var/turf/open/open in turfs)
					worker.controller_mind.set_current_task(/datum/work_order/nappy_time, open)
					break

		if(26 to 60)
			var/list/turfs = view(6, worker)
			shuffle_inplace(turfs)
			for(var/turf/open/open in turfs)
				worker.controller_mind.set_current_task(/datum/work_order/nappy_time, open)
				break

		if(61 to 70)
			if(length(master.worker_mobs) - 1 > 0)
				var/list/mobs_minus_src = master.worker_mobs.Copy()
				mobs_minus_src -= worker
				worker.controller_mind.set_current_task(/datum/work_order/socialize_with, pick(mobs_minus_src))
			else
				var/list/turfs = view(6, worker)
				shuffle_inplace(turfs)
				for(var/turf/open/open in turfs)
					worker.controller_mind.set_current_task(/datum/work_order/nappy_time, open)
					break

		if(71 to 80)
			if(length(worker.controller_mind.worker_gear))
				for(var/obj/item/gear in worker.controller_mind.worker_gear)
					if(!istype(gear, /obj/item/instrument))
						continue

					var/list/turfs = view(6, worker)
					shuffle_inplace(turfs)
					for(var/turf/open/open in turfs)
						worker.controller_mind.set_current_task(/datum/work_order/play_music, open, gear)
						break
			else
				var/list/turfs = view(6, worker)
				shuffle_inplace(turfs)
				for(var/turf/open/open in turfs)
					worker.controller_mind.set_current_task(/datum/work_order/nappy_time, open)
					break

		if(81 to 100)
			if(length(master.dead_workers))
				worker.controller_mind.set_current_task(/datum/work_order/mourn_dead, pick(master.dead_workers))
			else
				var/list/turfs = view(6, worker)
				shuffle_inplace(turfs)
				for(var/turf/open/open in turfs)
					worker.controller_mind.set_current_task(/datum/work_order/nappy_time, open)
					break
