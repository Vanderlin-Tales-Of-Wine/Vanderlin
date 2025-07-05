/datum/action/cooldown/spell/aoe/repulse
	name = "Repulse"
	desc = "This spell throws everything around the user away."
	button_icon_state = "repulse"

	point_cost = 3

	school = SCHOOL_EVOCATION
	invocation = "GITTAH WEIGH"
	invocation_type = INVOCATION_SHOUT
	aoe_radius = 2

	cooldown_time = 25 SECONDS
	cooldown_reduction_per_rank = 6.25 SECONDS

	spell_cost = 50
	charge_time = 3 SECONDS
	charge_drain = 1
	charge_slowdown = 2

	attunements = list(
		/datum/attunement/aeromancy = 0.4,
	)

	/// The max throw range of the repulsioon.
	var/max_throw = 3
	/// A visual effect to be spawned on people who are thrown away.
	var/obj/effect/sparkle_path = /obj/effect/temp_visual/kinetic_blast
	/// The moveforce of the throw done by the repulsion.
	var/repulse_force = MOVE_FORCE_EXTREMELY_STRONG

/datum/action/cooldown/spell/aoe/repulse/get_things_to_cast_on(atom/center)
	var/list/things = list()
	for(var/atom/movable/nearby_movable in oview(aoe_radius, center))
		if(nearby_movable == owner)
			continue
		if(nearby_movable.anchored)
			continue

		things += nearby_movable

	return things

/datum/action/cooldown/spell/aoe/repulse/cast_on_thing_in_aoe(atom/movable/victim, atom/caster)
	if(ismob(victim))
		var/mob/victim_mob = victim
		if(victim_mob.can_block_magic(antimagic_flags))
			return

	var/turf/throwtarget = get_edge_target_turf(caster, get_dir(caster, get_step_away(victim, caster)))
	var/dist_from_caster = get_dist(victim, caster)

	if(sparkle_path)
		// Created sparkles will disappear on their own
		new sparkle_path(get_turf(victim), get_dir(caster, victim))

	if(dist_from_caster == 0)
		if(isliving(victim))
			var/mob/living/victim_living = victim
			victim_living.Paralyze(5 SECONDS)
			victim_living.adjustBruteLoss(5)
			to_chat(victim, span_userdanger("You're slammed into the floor by [caster]!"))
		return

	if(isliving(victim))
		var/mob/living/victim_living = victim
		victim_living.Paralyze(3 SECONDS)
		to_chat(victim, span_userdanger("You're thrown back by [caster]!"))

	// So stuff gets tossed around at the same time.
	victim.safe_throw_at(
		throwtarget,
		((clamp((max_throw - (clamp(dist_from_caster - 2, 0, dist_from_caster))), 3, max_throw))),
		1,
		caster,
		force = repulse_force
	)

/datum/action/cooldown/spell/aoe/repulse/dragon
	name = "Tail Sweep"
	desc = "Throw back attackers with a sweep of your tail."
	button_icon_state = "tailsweep"

	point_cost = 0

	sound = 'sound/misc/tail_swing.ogg'

	invocation = null
	invocation_type = INVOCATION_NONE

	cooldown_time = 30 SECONDS
	cooldown_reduction_per_rank = 0

	sparkle_path = /obj/effect/temp_visual/dir_setting/tailsweep

/datum/action/cooldown/spell/aoe/repulse/dragon/cast(atom/target)
	. = ..()
	playsound(get_turf(owner), 'sound/combat/hits/punch/punch_hard (3).ogg', 80, TRUE, TRUE)
	owner.spin(6, 1)
