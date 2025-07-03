/obj/effect/forcefield
	name = "FORCEWALL"
	desc = "A wizard's magic wall."
	icon_state = "m_shield"
	anchored = TRUE
	opacity = FALSE
	density = TRUE
	CanAtmosPass = ATMOS_PASS_DENSITY
	/// If set, how long the force field lasts after it's created. Set to 0 to have infinite duration forcefields.
	var/initial_duration = 30 SECONDS

/obj/effect/forcefield/Initialize(mapload)
	. = ..()
	if(initial_duration > 0 SECONDS)
		QDEL_IN(src, initial_duration)

/obj/effect/forcefield/singularity_pull()
	return

/// The wizard's forcefield, summoned by forcewall
/obj/effect/forcefield/wizard
	/// Flags for what antimagic can just ignore our forcefields
	var/antimagic_flags = MAGIC_RESISTANCE
	/// A weakref to whoever casted our forcefield.
	var/datum/weakref/caster_weakref

/obj/effect/forcefield/wizard/Initialize(mapload, mob/caster, flags = MAGIC_RESISTANCE)
	. = ..()
	if(caster)
		caster_weakref = WEAKREF(caster)
	antimagic_flags = flags

/obj/effect/forcefield/wizard/CanAllowThrough(atom/movable/mover, border_dir)
	if(IS_WEAKREF_OF(mover, caster_weakref))
		return TRUE
	if(isliving(mover))
		var/mob/living/living_mover = mover
		if(living_mover.can_block_magic(antimagic_flags, charge_cost = 0))
			return TRUE

	return ..()

/obj/structure/forcefield
	name = "arcyne wall"
	desc = "A wall of pure arcyne force."
	icon = 'icons/effects/effects.dmi'
	icon_state = "forcefield"
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onstone/wallhit.ogg', 'sound/combat/hits/onstone/wallhit2.ogg', 'sound/combat/hits/onstone/wallhit3.ogg')
	density = TRUE
	max_integrity = 80
	CanAtmosPass = ATMOS_PASS_DENSITY
	/// If set, how long the force field lasts after it's created. Set to 0 to have infinite duration forcefields.
	var/initial_duration = 30 SECONDS

/obj/structure/forcefield/Initialize()
	. = ..()
	if(initial_duration > 0 SECONDS)
		QDEL_IN(src, initial_duration)

/obj/structure/forcefield/strong
	max_integrity = 200

/obj/structure/forcefield/casted
	/// Flags for what antimagic can just ignore our forcefields
	var/antimagic_flags = MAGIC_RESISTANCE
	/// A weakref to whoever casted our forcefield.
	var/datum/weakref/caster_weakref

/obj/structure/forcefield/casted/strong
	max_integrity = 200

/obj/structure/forcefield/casted/Initialize(mapload, mob/caster, flags = MAGIC_RESISTANCE)
	. = ..()
	if(caster)
		caster_weakref = WEAKREF(caster)
	antimagic_flags = flags

/obj/structure/forcefield/casted/CanAllowThrough(atom/movable/mover, turf/target)
	if(IS_WEAKREF_OF(mover, caster_weakref))
		return TRUE
	if(isliving(mover))
		var/mob/living/living_mover = mover
		if(living_mover.can_block_magic(antimagic_flags, charge_cost = 0))
			return TRUE

	return ..()
