
/datum/element/walking_stick
	element_flags = ELEMENT_BESPOKE

/datum/element/walking_stick/Attach(datum/target, fov_angle)
	. = ..()
	if(!isitem(target))
		return ELEMENT_INCOMPATIBLE

	RegisterSignal(target, COMSIG_ITEM_EQUIPPED, PROC_REF(on_equip))
	RegisterSignal(target, COMSIG_ITEM_DROPPED, PROC_REF(on_drop))

/datum/element/walking_stick/Detach(datum/target)
	UnregisterSignal(target, list(COMSIG_ITEM_EQUIPPED, COMSIG_ITEM_DROPPED))
	return ..()

/// On dropping the item (or not holding the item), check usable_legs
/datum/element/walking_stick/proc/on_drop(datum/source, mob/living/dropper)
	SIGNAL_HANDLER
	if(!istype(dropper))
		return
	if(dropper.usable_legs < 2 && !(dropper.movement_type & (FLYING | FLOATING))) //Check if less than 2 legs
		ADD_TRAIT(dropper, TRAIT_FLOORED, LACKING_LOCOMOTION_APPENDAGES_TRAIT)

/// On equipping the item, remove TRAIT_FLOORED from LACKING_LOCOMOTION_APPENDAGES_TRAIT source
/datum/element/walking_stick/proc/on_equip(obj/item/source, mob/living/equipper, slot)
	SIGNAL_HANDLER
	if(!istype(equipper))
		return
	if(!(slot & SLOT_HANDS)) //If NOT HELD IN HANDS
		on_drop(source, equipper)
		return

	REMOVE_TRAIT(equipper, TRAIT_FLOORED, LACKING_LOCOMOTION_APPENDAGES_TRAIT)
