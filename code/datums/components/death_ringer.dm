/// a component for binding a living body to an object, which will revive them if they die.
/datum/component/death_ringer
	/// a list of weak refs to objects that will revive us.
	var/list/possessed_objects = list() // this is a hack for lich phylacteries honestly.
	/// a weak ref to the head of our parent, in case we get beheaded so we can reattach.
	var/datum/weakref/possessor_head_ref

/datum/component/death_ringer/Initialize()
	if(!living(parent))
		return COMPONENT_INCOMPATIBLE

/datum/component/death_ringer/RegisterWithParent(obj/list/possessed_objects_incoming)
	. = ..()
	for(var/possessed_thing in possessed_objects_incoming)
		var/datum/weak_reference/posessed_object_ref = possessed_thing
		possessed_objects += posessed_object_ref

	if(iscarbon(parent))
		var/living/carbon/carbon_mob = parent
		var/item/bodypart/head/possessor_head = carbon_mob.get_bodypart(BODY_ZONE_HEAD)
		possessor_head_ref = possessor_head

	RegisterSignal(parent, COMSIG_LIVING_DEATH, PROC_REF(on_death))

/datum/component/death_ringer/proc/on_death()
	for(var/datum/weak_reference/possessed_ref in possessed_objects)
		if(!possessed_ref.resolve())
			continue
		var/obj/thingie = possessed_ref
		begin_chargeup(thingie)
		return

/datum/component/death_ringer/proc/begin_chargeup(item, timer = 10 SECONDS)
	var/offset = prob(50) ? -2 : 2
	animate(item, pixel_x = pixel_x + offset, time = 0.2, loop = -1) //start shaking
	visible_message(span_warning("[src] begins to glow and shake violently!"))
	spawn(timer)
		possessor.rise_anew()
		possessor.owner.current.forceMove(get_turf(src))
		qdel(src)

/datum/component/death_ringer/proc/revival()
	if(!parent || QDELETED(parent))
		return // it's over
	var/mob/living/posessor = parent

	if(isbrain(parent)) // we have been decapitated, let's reattach to our old body.
		posessor_mob = lich_body.resolve() // current body isn't a human mob, let's use the reference to our old body.
		if(isnull(posessor_mob))
			return // the old body no longer exists, it's over.
		var/mob/living/brain/possessor_brain = parent
		if(!istype(possessor_brain.loc.loc, /obj/item/bodypart/head))
			return // we have no head, it's over.
		var/obj/item/bodypart/head/lich_head = possessor_brain.loc.loc
		lich_head.attach_limb(posessor_mob)
	else
		if(ishuman(parent))
			posessor_mob = parent // current body is a human mob.

	posessor_mob.revive(TRUE, TRUE) // we live, yay.

	posessor_mob.skeletonize(FALSE)

	posessor_mob.faction = list(FACTION_UNDEAD)
	if(posessor_mob.charflaw)
		QDEL_NULL(posessor_mob.charflaw)
	posessor_mob.mob_biotypes |= MOB_UNDEAD
	posessor_mob.grant_undead_eyes()
