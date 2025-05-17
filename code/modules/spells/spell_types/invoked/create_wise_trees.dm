/obj/effect/proc_holder/spell/invoked/transform_tree
	name = "Transform Tree"
	desc = "Transform a normal tree into a wise tree of Dendor."
	invocation_type = "none"
	action_icon_state = "tree_transform"
	action_background_icon_state = "bg_dendor"
	var/uses = 3

/obj/effect/proc_holder/spell/invoked/transform_tree/cast(list/targets, mob/user = usr)
	var/mob/living/carbon/human/H = user
	if(!istype(H))
		return

	var/obj/structure/flora/tree/target = locate() in get_turf(H)
	if(!istype(target) || istype(target, /obj/structure/flora/tree/wise))
		to_chat(H, span_warning("You must be standing on a normal tree to transform it!"))
		return

	if(uses <= 0)
		to_chat(H, span_warning("Your blessing has been exhausted!"))
		H.mind.RemoveSpell(src)
		return

	target.name = "wise tree"
	target.desc = "Dendor's favored."
	target.icon_state = "mystical"
	target.alpha = 255
	target.max_integrity = initial(target.max_integrity) * 1.5
	target.resistance_flags = FIRE_PROOF
	target.transform = matrix() // Reset any transformations
	target.set_light(2, 2, "#66FF99")

	uses--
	SEND_SIGNAL(user, COMSIG_TREE_TRANSFORMED)
	to_chat(H, span_notice("You transform the tree into a wise tree. [uses] use\s remaining."))

	if(uses <= 0)
		to_chat(H, span_warning("Dendor's blessing fades from you."))
		H.mind.RemoveSpell(src)
