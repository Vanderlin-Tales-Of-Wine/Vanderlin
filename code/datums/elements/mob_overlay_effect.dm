///The alpha mask used on mobs submerged in liquid turfs or standing on high ground
#define MOB_MOVING_EFFECT_MASK "mob_moving_effect_mask"
///mob_overlay_effect component. adds and removes
/datum/element/mob_overlay_effect
	element_flags = ELEMENT_BESPOKE | ELEMENT_DETACH
	id_arg_index = 2

	var/y_offset = 0
	var/mask_y_offset = 0
	var/effect_alpha = 0

/datum/element/mob_overlay_effect/Attach(datum/target, _y_offset = 0, _mask_y_offset = 0, _effect_alpha = 0)
	. = ..()
	y_offset = _y_offset
	mask_y_offset = _mask_y_offset
	effect_alpha = _effect_alpha

	RegisterSignal(get_turf(target), COMSIG_TURF_EXITED, TYPE_PROC_REF(/datum/element/mob_overlay_effect, on_remove), override = TRUE)
	RegisterSignal(get_turf(target), COMSIG_TURF_ENTERED, TYPE_PROC_REF(/datum/element/mob_overlay_effect, on_add), override = TRUE)
	RegisterSignal(target, COMSIG_MOB_OVERLAY_FORCE_REMOVE, TYPE_PROC_REF(/datum/element/mob_overlay_effect, on_remove), override = TRUE)
	RegisterSignal(target, COMSIG_MOB_OVERLAY_FORCE_UPDATE, TYPE_PROC_REF(/datum/element/mob_overlay_effect, on_add), override = TRUE)

/datum/element/mob_overlay_effect/Detach(datum/source)
	. = ..()
	UnregisterSignal(get_turf(source), COMSIG_TURF_EXITED)
	UnregisterSignal(get_turf(source), COMSIG_TURF_ENTERED)
	UnregisterSignal(source, COMSIG_MOB_OVERLAY_FORCE_REMOVE)
	UnregisterSignal(source, COMSIG_MOB_OVERLAY_FORCE_UPDATE)

/datum/element/mob_overlay_effect/proc/on_remove(datum/source, datum/target)
	SIGNAL_HANDLER
	var/mob/mob = target
	if(mob.get_filter(MOB_MOVING_EFFECT_MASK))
		animate(mob.get_filter(MOB_MOVING_EFFECT_MASK), y = -32, time = 0)
		if(ismob(mob))
			mob.update_vision_cone()
		for(var/mob/living/carbon/human/human in view(mob, 7))
			human.update_vision_cone()
	UnregisterSignal(target, COMSIG_ITEM_PICKUP)

/datum/element/mob_overlay_effect/proc/on_add(datum/source, datum/target)
	SIGNAL_HANDLER
	for(var/obj/structure/S in get_turf(target))
		if(S.obj_flags & BLOCK_Z_OUT_DOWN)
			return

	if(isobj(target))
		var/obj/obj = target
		if(obj.obj_flags & IGNORE_SINK)
			return

	if(istype(target, /obj/structure/hotspring))
		return

	var/offset = 0
	if(istype(target, /obj/structure/flora/tree))
		offset = -24
	if(isitem(target))
		offset += 7
	var/mob/arrived_mob = target
	if(arrived_mob.get_filter(MOB_MOVING_EFFECT_MASK))
		arrived_mob.remove_filter(MOB_MOVING_EFFECT_MASK)
		arrived_mob.add_filter(MOB_MOVING_EFFECT_MASK, 1, alpha_mask_filter(0, mask_y_offset + offset, icon('icons/effects/icon_cutter.dmi', "icon_cutter"), null, MASK_INVERSE))
		if(isliving(arrived_mob))
			arrived_mob.update_vision_cone()
		for(var/mob/living/carbon/human/human in view(arrived_mob, 7))
			human.update_vision_cone()
	else
		if(effect_alpha)
			arrived_mob.add_filter(MOB_MOVING_EFFECT_MASK, 1, alpha_mask_filter(0, mask_y_offset + offset, icon('icons/effects/icon_cutter.dmi', "icon_cutter"), null, MASK_INVERSE))
			if(isliving(arrived_mob))
				arrived_mob.update_vision_cone()
			for(var/mob/living/carbon/human/human in view(arrived_mob, 7))
				human.update_vision_cone()
		RegisterSignal(arrived_mob, COMSIG_ITEM_PICKUP, TYPE_PROC_REF(/datum/element/mob_overlay_effect, on_remove_proxy), override = TRUE)

/datum/element/mob_overlay_effect/proc/on_remove_proxy(atom/source)
	SIGNAL_HANDLER
	on_remove(src, source)

#undef MOB_MOVING_EFFECT_MASK
