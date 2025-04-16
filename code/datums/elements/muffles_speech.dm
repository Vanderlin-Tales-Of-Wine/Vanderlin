//Properly port https://github.com/tgstation/tgstation/pull/83721 later

/datum/element/muffles_speech

/datum/element/muffles_speech/Attach(datum/target)
	. = ..()
	if(!isitem(target))
		return ELEMENT_INCOMPATIBLE

	RegisterSignal(target, COMSIG_ITEM_EQUIPPED, PROC_REF(equipped))
	RegisterSignal(target, COMSIG_ITEM_DROPPED, PROC_REF(dropped))

/datum/element/muffles_speech/Detach(datum/source)
	. = ..()
	UnregisterSignal(source, list(COMSIG_ITEM_EQUIPPED, COMSIG_ITEM_DROPPED))

/datum/element/muffles_speech/proc/equipped(obj/item/source, mob/user, slot)
	SIGNAL_HANDLER
	if(slot == SLOT_MOUTH) //Needs a refactor to fix...
		RegisterSignal(user, COMSIG_MOB_TRY_SPEECH, PROC_REF(muzzle_talk))

/datum/element/muffles_speech/proc/dropped(obj/item/source, mob/user)
	SIGNAL_HANDLER
	UnregisterSignal(user, list(COMSIG_MOB_TRY_SPEECH))

/datum/element/muffles_speech/proc/muzzle_talk()
	return COMPONENT_CANNOT_SPEAK
