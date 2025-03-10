/datum/element/tipped_item
	element_flags = ELEMENT_DETACH

/datum/element/tipped_item/Attach(atom/movable/target, amount)
	. = ..()
	if(!ismovableatom(target))
		return ELEMENT_INCOMPATIBLE
	if(!target.reagents)
		target.create_reagents(1)
	RegisterSignal(target, COMSIG_PARENT_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(target, COMSIG_ITEM_PRE_ATTACK, PROC_REF(check_dip))
	RegisterSignal(target, COMSIG_ITEM_AFTERATTACK, PROC_REF(try_inject))

/datum/element/tipped_item/Detach(datum/source, force)
	. = ..()
	UnregisterSignal(source, list(COMSIG_PARENT_EXAMINE, COMSIG_ITEM_PRE_ATTACK, COMSIG_ITEM_AFTERATTACK))

/datum/element/tipped_item/proc/check_dip(obj/item/dipper, obj/item/reagent_containers/attacked_container, mob/living/attacker, params)
	SIGNAL_HANDLER

	if(!istype(attacked_container))
		return
	if(!(attacked_container.reagents.flags & DRAINABLE))
		return
	if(dipper.reagents.total_volume == dipper.reagents.maximum_volume)
		return
	if(attacker.cmode)
		return

	INVOKE_ASYNC(src, PROC_REF(start_dipping), dipper, attacked_container, attacker)
	return COMPONENT_NO_ATTACK

/datum/element/tipped_item/proc/start_dipping(obj/item/dipper, obj/item/reagent_containers/attacked_container, mob/living/attacker, params)
	if(!do_after(attacker, 2 SECONDS, attacked_container))
		return
	attacked_container.reagents.trans_to(dipper, 0.5, transfered_by = attacker)
	attacker.visible_message(span_danger("[attacker] dips [dipper] in [attacked_container]!"), "You dip [dipper] in [attacked_container]!", vision_distance = 2)

/datum/element/tipped_item/proc/try_inject(obj/item/source, atom/target, mob/user, proximity_flag, click_parameters)
	if(!proximity_flag)
		return
	if(isliving(target))
		source.reagents.trans_to(target, 1, transfered_by = user)

/datum/element/tipped_item/proc/on_examine(atom/movable/source, mob/user, list/examine_list)
	if(source.reagents.total_volume)
		var/reagent_color = mix_color_from_reagents(source.reagents.reagent_list)
		examine_list += span_red("Has been dipped in <font color=[reagent_color]>something</font>!")
