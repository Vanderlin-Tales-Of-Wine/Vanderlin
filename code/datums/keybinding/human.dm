/datum/keybinding/human
	category = CATEGORY_HUMAN
	weight = WEIGHT_MOB

/datum/keybinding/human/can_use(client/user)
	return ishuman(user.mob)

/*
/datum/keybinding/human/quick_equip
	hotkey_keys = list("E")
	name = "quick_equip"
	full_name = "Quick Equip"
	description = "Quickly puts an item in the best slot available"

/datum/keybinding/human/quick_equip/down(client/user)
	var/mob/living/carbon/human/H = user.mob
	H.quick_equip()
	return TRUE

/datum/keybinding/human/quick_equipbelt
	hotkey_keys = list("ShiftE")
	name = "quick_equipbelt"
	full_name = "Quick equip belt"
	description = "Put held thing in belt or take out most recent thing from belt"

/datum/keybinding/human/quick_equipbelt/down(client/user)
	var/mob/living/carbon/human/H = user.mob
	H.smart_equipbelt()
	return TRUE

/datum/keybinding/human/bag_equip
	hotkey_keys = list("ShiftB")
	name = "bag_equip"
	full_name = "Bag equip"
	description = "Put held thing in backpack or take out most recent thing from backpack"

/datum/keybinding/human/bag_equip/down(client/user)
	var/mob/living/carbon/human/H = user.mob
	H.smart_equipbag()
	return TRUE
*/

/datum/keybinding/human/quick_equipbelt
	hotkey_keys = list("ShiftB")
	name = "quick_equipbelt"
	full_name = "Quick equip belt"
	description = "Put held thing in belt or take out most recent thing from belt"

/datum/keybinding/human/quick_equipbelt/down(client/user)
	var/mob/living/carbon/human/H = user.mob
	H.smart_equipbelt()
	return TRUE

/datum/keybinding/human/bag_equip_backl
	hotkey_keys = list("ShiftQ")
	name = "bag_equip_backl"
	full_name = "Bag Equip Left"
	description = "Put held item in the left backpack slot or take out the most recent item from the left backpack slot"

/datum/keybinding/human/bag_equip_backl/down(client/user)
	var/mob/living/carbon/human/H = user.mob
	H.smart_equipbag(SLOT_BACK_R) // They're reversed to match the UI.
	return TRUE

/datum/keybinding/human/bag_equip_backr
	hotkey_keys = list("ShiftE")
	name = "bag_equip_backr"
	full_name = "Bag Equip Right"
	description = "Put held item in the right backpack slot or take out the most recent item from the right backpack slot"

/datum/keybinding/human/bag_equip_backr/down(client/user)
	var/mob/living/carbon/human/H = user.mob
	H.smart_equipbag(SLOT_BACK_L) // They're reversed to match the UI.
	return TRUE

/datum/keybinding/human/fixeye
	hotkey_keys = list("F")
	name = "fix_eye"
	full_name = "Fixed Eye"
	description = "Focus in a direction."

/datum/keybinding/human/fixeye/down(client/user)
	var/mob/living/carbon/human/H = user.mob
	H.toggle_eye_intent(H)
	return TRUE
