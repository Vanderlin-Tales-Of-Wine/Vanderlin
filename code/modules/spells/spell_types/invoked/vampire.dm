
/obj/effect/proc_holder/spell/targeted/shapeshift/bat
	name = "Bat Form"
	desc = ""
	invocation = ""
	recharge_time = 50
	cooldown_min = 50
	die_with_shapeshifted_form =  FALSE
	convert_damage = FALSE
	shapeshift_type = /mob/living/simple_animal/hostile/retaliate/bat
	attunements = list(
		/datum/attunement/dark = 0.4,
		/datum/attunement/polymorph = 0.5,
	)

/obj/effect/proc_holder/spell/targeted/shapeshift/gaseousform
	name = "Mist Form"
	desc = ""
	invocation = ""
	recharge_time = 50
	cooldown_min = 50
	die_with_shapeshifted_form =  FALSE
	convert_damage = FALSE
	shapeshift_type = /mob/living/simple_animal/hostile/retaliate/gaseousform
	attunements = list(
		/datum/attunement/dark = 0.4,
		/datum/attunement/polymorph = 0.5,
		/datum/attunement/aeromancy = 0.3,
	)

/obj/effect/proc_holder/spell/targeted/mansion_portal
	name = "Mansion Portal"
	desc = "Create a portal to return to MY mansion"
	invocation = ""
	recharge_time = 15 MINUTES
	cooldown_min = 15 MINUTES
	max_targets = 0
	cast_without_targets = TRUE
	associated_skill = /datum/skill/magic/blood

/obj/effect/proc_holder/spell/targeted/mansion_portal/cast(list/targets,mob/user = usr)
	var/obj/structure/vampire/portalmaker/destination
	for(var/obj/structure/vampire/portalmaker/P in GLOB.vampire_objects)
		destination = P
		break
	if(!destination)
		to_chat(user, span_warning("It cannot be, Nothing happens."))
		return FALSE

	var/obj/effect/portal/vampire/portal = new /obj/effect/portal/vampire(get_turf(user), user, 15 MINUTES, null, FALSE, get_turf(destination), FALSE)
	portal.RegisterSignal(destination, COMSIG_PARENT_QDELETING, TYPE_PROC_REF(/obj/effect/portal/vampire, handle_portalmaker_destruction))
	return TRUE

/obj/effect/portal/vampire
	name = "Eerie Portal"
	icon = 'icons/roguetown/topadd/death/vamp-lord.dmi'
	icon_state = "portal"
	density = FALSE

/obj/effect/portal/vampire/proc/handle_portalmaker_destruction()
	visible_message(span_boldnotice("[src] shudders before rapidly closing."))
	qdel(src)
