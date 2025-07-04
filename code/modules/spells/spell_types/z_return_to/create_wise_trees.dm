/obj/effect/proc_holder/spell/invoked/transform_tree
	name = "Transform Tree"
	desc = "Transform a normal tree into a wise tree of Dendor."
	invocation_type = "whisper"
	overlay_state = "entangle"
	range = 1
	recharge_time = 20 SECONDS
	var/uses = 3

/obj/effect/proc_holder/spell/invoked/transform_tree/cast(list/targets, mob/user = usr)
	var/mob/living/carbon/human/H = user
	if(!istype(H))
		return

	var/atom/target_atom = targets[1]
	var/obj/structure/flora/target

	if(istype(target_atom, /obj/structure/flora/tree) && !istype(target_atom, /obj/structure/flora/tree/wise) && !istype(target_atom, /obj/structure/flora/tree/stump))
		target = target_atom
	else if(istype(target_atom, /obj/structure/flora/newtree))
		target = target_atom
	else if(target_atom.loc && (get_dist(user, target_atom.loc) <= 1))
		for(var/obj/structure/flora/tree/T in target_atom.loc)
			if(!istype(T, /obj/structure/flora/tree/wise) && !istype(T, /obj/structure/flora/tree/stump))
				target = T
				break
		if(!target)
			for(var/obj/structure/flora/newtree/NT in target_atom.loc)
				if(!NT.burnt)
					target = NT
					break

	if(!target)
		to_chat(H, span_warning("You must target a normal, living tree adjacent to you!"))
		return

	if(uses <= 0)
		to_chat(H, span_warning("Your blessing has been exhausted!"))
		H.mind.RemoveSpell(src)
		return

	H.visible_message(span_notice("[H] begins chanting to transform the tree."), \
					span_notice("You begin the transformation ritual..."))

	if(!do_after(H, 10 SECONDS, target = target))
		to_chat(H, span_warning("The ritual was interrupted!"))
		return

	var/turf/T = get_turf(target)
	var/obj/structure/flora/tree/wise/new_wise_tree = new(T)
	new_wise_tree.activated = TRUE
	new_wise_tree.set_light(2, 2, 2, l_color = "#66FF99")

	if(istype(target, /obj/structure/flora/newtree))
		for(var/turf/adjacent in range(1, T))
			for(var/obj/structure/flora/newbranch/B in adjacent)
				qdel(B)
			for(var/obj/structure/flora/newleaf/L in adjacent)
				qdel(L)
		var/turf/above = get_step_multiz(T, UP)
		if(istype(above, /turf/open/transparent/openspace))
			for(var/obj/structure/flora/newtree/upper_tree in above)
				qdel(upper_tree)

	qdel(target)

	uses--
	SEND_SIGNAL(user, COMSIG_TREE_TRANSFORMED)
	if(uses > 0)
		to_chat(H, span_notice("You transform the tree into a wise tree. [uses] use\s remaining."))
	else
		to_chat(H, span_notice("You transform the tree into a wise tree."))
	playsound(T, 'sound/ambience/noises/mystical (4).ogg', 50, TRUE)

	if(uses <= 0)
		to_chat(H, span_warning("Dendor's blessing fades from you."))
		H.mind.RemoveSpell(src)

	return ..()
