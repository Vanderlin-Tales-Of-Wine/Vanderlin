/obj/effect/proc_holder/spell/invoked/beam
	var/beam_icon = 'icons/effects/beam.dmi'
	var/beam_icon_state = "3-full"
	var/beam_color = COLOR_WHITE
	var/beam_time = 50
	var/beam_type = /obj/effect/ebeam/react_to_entry
	var/beam_sleep_time = 1
	var/beam_speed = 2  // How fast the beam moves

/obj/effect/proc_holder/spell/invoked/beam/cast(list/targets, mob/user = usr)
	if(!targets?.len)
		return FALSE

	var/atom/target_loc = targets[1]

	// Create invisible moving object
	var/obj/effect/beam_mover/mover = new(get_turf(user))
	mover.spell_source = src
	mover.beam_caster = user
	mover.target_location = target_loc

	// Start the beam attached to the caster and mover
	var/datum/beam/moving_beam = user.Beam(mover, beam_icon_state, beam_icon, beam_time, range * 2, beam_type, beam_sleep_time, beam_color, spell_source = src)
	mover.attached_beam = moving_beam

	// Start moving
	mover.start_moving()

	return TRUE

// Invisible object that moves to the target location
/obj/effect/beam_mover
	name = ""
	desc = ""
	pass_flags = PASSMOB
	icon = null
	anchored = FALSE
	density = FALSE
	opacity = FALSE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	invisibility = INVISIBILITY_MAXIMUM

	var/obj/effect/proc_holder/spell/invoked/beam/spell_source
	var/mob/beam_caster
	var/atom/target_location
	var/datum/beam/attached_beam
	var/movement_speed = 2  // Lower = faster
	var/max_distance = 10

/obj/effect/beam_mover/proc/start_moving()
	if(!target_location || !beam_caster)
		qdel(src)
		return

	var/spell_speed = spell_source?.beam_speed || movement_speed
	var/total_distance = get_dist(src, target_location)

	if(total_distance > max_distance)
		// Find the furthest tile we can reach in the direction
		var/turf/direction_turf = get_ranged_target_turf(beam_caster, get_dir(beam_caster, target_location), max_distance)
		target_location = direction_turf

	// Use the proper movement system instead of walk_towards
	SSmove_manager.move_to(src, target_location, 0, spell_speed, 10 SECONDS)

	// Set up cleanup timer
	addtimer(CALLBACK(src, PROC_REF(cleanup)), 10 SECONDS)

/obj/effect/beam_mover/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	. = ..()

	// Update spell source in beam elements after moving
	if(attached_beam?.elements?.len && spell_source)
		for(var/obj/effect/ebeam/beam_element in attached_beam.elements)
			beam_element.spell_source = spell_source

	// Check if we've reached the target or close enough
	if(get_dist(src, target_location) <= 1 || loc == get_turf(target_location))
		// Stop moving and start cleanup
		SSmove_manager.stop_looping(src)
		addtimer(CALLBACK(src, PROC_REF(cleanup)), spell_source?.beam_time || 50)

/obj/effect/beam_mover/proc/cleanup()
	SSmove_manager.stop_looping(src)  // Stop any movement
	if(attached_beam)
		qdel(attached_beam)
	qdel(src)

/obj/effect/beam_mover/Destroy()
	SSmove_manager.stop_looping(src)
	if(attached_beam)
		qdel(attached_beam)
	beam_caster = null
	target_location = null
	spell_source = null
	. = ..()

/obj/effect/proc_holder/spell/invoked/beam/rayoffrost5e
	name = "Ray of Frost"
	desc = "Shoots a ray of frost out, slowing anyone hit by it."
	range = 8
	overlay_state = "null"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE
	releasedrain = 30
	chargedrain = 1
	chargetime = 3
	recharge_time = 5 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	antimagic_allowed = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	cost = 1
	attunements = list(
		/datum/attunement/ice = 0.6,
	)
	miracle = FALSE
	invocation = "Chill!"
	invocation_type = "shout"

	// Beam properties
	beam_icon = 'icons/effects/beam.dmi'
	beam_icon_state = "3-full"
	beam_color = "#87CEEB"  // Sky blue color for frost
	beam_time = 30  // How long the beam lasts after reaching target
	beam_type = /obj/effect/ebeam/react_to_entry/rayoffrost5e
	beam_speed = 1  // Fast movement

/obj/effect/proc_holder/spell/invoked/beam/rayoffrost5e/set_attuned_strength(list/incoming_attunements)
	var/total_value = 1
	for(var/datum/attunement/attunement as anything in attunements)
		if(!(attunement in incoming_attunements))
			continue
		total_value += incoming_attunements[attunement] * attunements[attunement]
	attuned_strength = total_value
	attuned_strength = max(attuned_strength, 0.5)
	return

/obj/effect/ebeam/react_to_entry/rayoffrost5e/Initialize(mapload, beam_owner)
	. = ..()
	// Check for existing mobs when the beam spawns
	addtimer(CALLBACK(src, PROC_REF(check_initial_targets)), 1)

/obj/effect/ebeam/react_to_entry/rayoffrost5e/proc/check_initial_targets()
	// Check everything already in this location when the beam spawns
	for(var/mob/living/target in loc)
		if(owner.origin == target)
			continue
		hit_target(target)

/obj/effect/ebeam/react_to_entry/rayoffrost5e/on_entered(datum/source, atom/movable/entering)
	. = ..()

	if(!isliving(entering))
		return

	var/mob/living/target = entering
	hit_target(target)

/obj/effect/ebeam/react_to_entry/rayoffrost5e/proc/hit_target(mob/living/target)
	// Don't hit the same target multiple times
	if(target in owner.hit_targets)
		if(owner.hit_targets[target] > world.time)
			return

	// Anti-magic check
	if(target.anti_magic_check())
		visible_message(span_warning("The frost ray fizzles on contact with [target]!"))
		playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
		return

	owner.hit_targets |= target
	owner.hit_targets[target] = world.time + 1 SECONDS

	// Calculate damage and effects
	var/strength = spell_source?.attuned_strength || 1
	var/damage = round(25 * strength)

	// Apply damage and effects
	target.adjustBruteLoss(damage)
	target.adjustFireLoss(round(5 * strength))
	target.apply_status_effect(/datum/status_effect/buff/rayoffrost5e, strength)

	// Visual and sound effects
	new /obj/effect/temp_visual/snap_freeze(get_turf(target))
	playsound(get_turf(target), 'sound/items/stonestone.ogg', 100)

	visible_message(span_danger("[target] is struck by the ray of frost!"))

/datum/status_effect/buff/rayoffrost5e
	id = "frostbite"
	alert_type = /atom/movable/screen/alert/status_effect/buff/rayoffrost5e
	duration = 6 SECONDS
	var/static/mutable_appearance/frost = mutable_appearance('icons/roguetown/mob/coldbreath.dmi', "breath_m", ABOVE_ALL_MOB_LAYER)
	effectedstats = list("speed" = -2)
	var/strength_multiplier = 1

/datum/status_effect/buff/rayoffrost5e/New(atom/A, strength = 1)
	strength_multiplier = strength
	duration = round(6 SECONDS * strength)
	effectedstats = list("speed" = round(-2 * strength))
	. = ..()

/atom/movable/screen/alert/status_effect/buff/rayoffrost5e
	name = "Frostbite"
	desc = "I can feel myself slowing down."
	icon_state = "debuff"

/datum/status_effect/buff/rayoffrost5e/on_apply()
	. = ..()
	var/mob/living/target = owner
	target.add_overlay(frost)
	target.update_vision_cone()
	var/newcolor = rgb(136, 191, 255)
	target.add_atom_colour(newcolor, TEMPORARY_COLOUR_PRIORITY)
	addtimer(CALLBACK(target, TYPE_PROC_REF(/atom, remove_atom_colour), TEMPORARY_COLOUR_PRIORITY, newcolor), duration)
	target.add_movespeed_modifier(MOVESPEED_ID_ADMIN_VAREDIT, update=TRUE, priority=100, multiplicative_slowdown=round(4 * strength_multiplier), movetypes=GROUND)

/datum/status_effect/buff/rayoffrost5e/on_remove()
	var/mob/living/target = owner
	target.cut_overlay(frost)
	target.update_vision_cone()
	target.remove_movespeed_modifier(MOVESPEED_ID_ADMIN_VAREDIT, TRUE)
	. = ..()
