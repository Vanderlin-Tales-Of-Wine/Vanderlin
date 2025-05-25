
/datum/component/walking_stick
	dupe_mode = COMPONENT_DUPE_UNIQUE // Only one of the component can exist on an item

/datum/component/walking_stick/Initialize()
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

/datum/component/walking_stick/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(on_equip))
	RegisterSignal(parent, COMSIG_ITEM_DROPPED, PROC_REF(on_drop))

/datum/component/walking_stick/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_ITEM_EQUIPPED, COMSIG_ITEM_DROPPED))

/// On dropping the item (or not holding the item), check usable_legs
/datum/component/walking_stick/proc/on_drop(datum/source, mob/living/dropper)
	SIGNAL_HANDLER
	if(!istype(dropper))
		return
	if(dropper.usable_legs < 2 && !(dropper.movement_type & (FLYING | FLOATING))) //Check if less than 2 legs
		for(var/obj/item/I in dropper.held_items)
			if(I.GetComponent(/datum/component/walking_stick))
				return
		ADD_TRAIT(dropper, TRAIT_FLOORED, LACKING_LOCOMOTION_APPENDAGES_TRAIT)

/// On equipping the item, remove TRAIT_FLOORED from LACKING_LOCOMOTION_APPENDAGES_TRAIT source
/datum/component/walking_stick/proc/on_equip(obj/item/source, mob/living/equipper, slot)
	SIGNAL_HANDLER
	if(!istype(equipper))
		return
	if(!(slot & SLOT_HANDS)) //If NOT HELD IN HANDS
		on_drop(source, equipper)
		return

	if(equipper.usable_legs < 1)
		return

	REMOVE_TRAIT(equipper, TRAIT_FLOORED, LACKING_LOCOMOTION_APPENDAGES_TRAIT)
