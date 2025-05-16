// Coral formation - can be used by the boss as cover or to block player movement
/obj/structure/coral_formation
	name = "living coral"
	desc = "A sharp formation of living coral that pulses with an eerie light."
	icon = 'icons/obj/coral.dmi'  // Replace with appropriate icon
	icon_state = "coral"  // Replace with appropriate icon_state
	density = TRUE
	anchored = TRUE
	var/health = 150
	var/max_health = 150
	var/damage_on_contact = 5
	var/can_grow = TRUE
	var/grow_chance = 2

/obj/structure/coral_formation/Initialize()
	. = ..()
	add_filter("coral_glow", 2, list("type" = "outline", "color" = "#3366FF", "size" = 1))
	START_PROCESSING(SSobj, src)

/obj/structure/coral_formation/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/coral_formation/process()
	// Chance to grow to adjacent tiles
	if(can_grow && prob(grow_chance))
		var/list/cardinals = GLOB.cardinals.Copy()
		for(var/direction in cardinals)
			var/turf/T = get_step(src, direction)
			if(istype(T, /turf/open/floor) && !T.density && !locate(/obj/structure/coral_formation) in T)
				if(prob(20))
					new /obj/structure/coral_formation/small(T)
					break

/obj/structure/coral_formation/Bumped(atom/movable/AM)
	. = ..()
	if(isliving(AM) && !AM.faction_check_mob(AM, "deepone"))
		var/mob/living/L = AM
		L.apply_damage(damage_on_contact, BRUTE)
		to_chat(L, "<span class='danger'>The sharp coral cuts into you!</span>")

/obj/structure/coral_formation/attackby(obj/item/W, mob/user, params)
	. = ..()
	health -= W.force
	if(health <= 0)
		to_chat(user, "<span class='notice'>The coral formation crumbles!</span>")
		qdel(src)

/obj/structure/coral_formation/small
	name = "small coral growth"
	desc = "A small formation of sharp coral."
	icon_state = "coral_small"  // Would need a new sprite
	health = 50
	max_health = 50
	damage_on_contact = 2
	can_grow = FALSE

// Add boss ability to create coral walls
/datum/ai_behavior/fishboss_coral_wall
	action_cooldown = 0.5 SECONDS

/datum/ai_behavior/fishboss_coral_wall/perform(delta_time, datum/ai_controller/controller)
	. = ..()
	var/mob/living/simple_animal/hostile/boss/fishboss/boss = controller.pawn
	if(!istype(boss))
		finish_action(controller, FALSE)
		return

	boss.visible_message("<span class='warning'>[boss] gestures, causing coral to violently erupt from the ground!</span>")
	//playsound(boss, 'sound/effects/break_stone.ogg', 100, TRUE) // Replace with appropriate sound

	// Create a line of coral between the boss and its target
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!QDELETED(target))
		var/turf/boss_turf = get_turf(boss)
		var/turf/target_turf = get_turf(target)

		if(boss_turf && target_turf)
			var/list/line = getline(boss_turf, target_turf)
			// Remove the turfs at the beginning and end of the line (boss and target positions)
			if(length(line) > 2)
				line = line.Copy(2, length(line))
				// Only use half the line to not trap the target completely
				var/coral_length = max(1, round(length(line) / 2))
				for(var/i = 1 to coral_length)
					var/turf/T = line[i]
					if(istype(T, /turf/open/floor) && !T.density && !locate(/obj/structure/coral_formation) in T)
						new /obj/structure/coral_formation(T)

	// Set cooldown in the controller blackboard
	controller.set_blackboard_key(BB_FISHBOSS_SPECIAL_COOLDOWN, world.time + 40 SECONDS)
	finish_action(controller, TRUE)
