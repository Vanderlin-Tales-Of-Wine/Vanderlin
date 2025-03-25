/datum/component/mob_home //isn't an element for future proofing
	var/max_mobs = 6

/datum/component/mob_home/Initialize(max_mobs)
	. = ..()
	src.max_mobs = max_mobs

	RegisterSignal(parent, COMSIG_HABITABLE_HOME, PROC_REF(habitable))

/datum/component/mob_home/proc/habitable(obj/structure/source, mob/living/simple_animal/pawn)
	if(length(source.contents) >= max_mobs)
		return FALSE
	return TRUE
