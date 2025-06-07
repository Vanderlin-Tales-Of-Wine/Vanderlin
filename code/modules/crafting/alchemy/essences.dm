/obj/item/essence_vial
	name = "essence vial"
	desc = "A small crystalline vial designed to hold thaumaturgical essences."
	icon = 'icons/roguetown/items/glass_reagent_container.dmi'
	icon_state = "essence_vial"
	w_class = WEIGHT_CLASS_TINY
	var/datum/thaumaturgical_essence/contained_essence = null
	var/essence_amount = 0
	var/max_essence = 10
	var/extract_amount = 10 // Amount to try to extract when used

/obj/item/essence_vial/Initialize()
	. = ..()
	update_icon()

/obj/item/essence_vial/attack_self(mob/user)
	if(extract_amount == 10)
		extract_amount = 1
	else
		extract_amount = 10

	to_chat(user, span_info("You adjust the vial to extract [extract_amount] unit[extract_amount > 1 ? "s" : ""] of essence."))

/obj/item/essence_vial/proc/check_vial_menu_validity(mob/user)
	return user && (src in user.contents)

/obj/item/essence_vial/update_icon()
	..()
	cut_overlays()
	if(contained_essence && essence_amount > 0)
		icon_state = "essence_vial"
		var/mutable_appearance/essence_overlay = mutable_appearance(icon, "essence_liquid")
		essence_overlay.color = contained_essence.color
		essence_overlay.alpha = min(255, 100 + (essence_amount * 15))
		add_overlay(essence_overlay)
		var/mutable_appearance/emissive = mutable_appearance(icon, "essence_liquid")
		emissive.plane = EMISSIVE_PLANE
		emissive.alpha = min(255, 100 + (essence_amount * 15))
		add_overlay(emissive)
	else
		icon_state = "essence_vial"

/obj/item/essence_vial/examine(mob/user)
	. = ..()
	if(contained_essence && essence_amount > 0)
		if(!HAS_TRAIT(user, TRAIT_LEGENDARY_ALCHEMIST))
			. += span_notice("Contains [essence_amount] units of essence smelling of [contained_essence.smells_like].")
		else
			. += span_notice("Contains [essence_amount] units of [contained_essence.name].")
			. += span_notice("It smells of [contained_essence.smells_like].")
	else
		. += span_notice("It appears to be empty.")

	. += span_notice("Set to extract [extract_amount] unit[extract_amount > 1 ? "s" : ""] when used. Use in hand to adjust.")

/obj/item/essence_vial/proc/can_hold_essence()
	return essence_amount < max_essence

/obj/item/essence_vial/proc/get_available_space()
	return max_essence - essence_amount


/datum/thaumaturgical_essence
	var/name = "essence"
	var/desc = "A concentrated magical essence."
	var/tier = 0 // 0 = Basic, 1 = First Compound, 2 = Second Compound
	var/color = "#FFFFFF"
	var/icon_state = "essence_basic"
	var/smells_like = "magic"

// =============================================================================
// TIER 0 - BASIC ESSENCES
// =============================================================================

/datum/thaumaturgical_essence/air
	name = "Air Essence"
	desc = "The essence of wind and movement."
	color = "#E6F3FF"
	icon_state = "essence_air"
	smells_like = "fresh breeze"

/datum/thaumaturgical_essence/water
	name = "Water Essence"
	desc = "The essence of flowing water."
	color = "#4A90E2"
	icon_state = "essence_water"
	smells_like = "clear streams"

/datum/thaumaturgical_essence/fire
	name = "Fire Essence"
	desc = "The essence of burning flame."
	color = "#FF6B35"
	icon_state = "essence_fire"
	smells_like = "smoke and ash"

/datum/thaumaturgical_essence/earth
	name = "Earth Essence"
	desc = "The essence of solid ground."
	color = "#8B4513"
	icon_state = "essence_earth"
	smells_like = "rich soil"

/datum/thaumaturgical_essence/order
	name = "Order Essence"
	desc = "The essence of structure and harmony."
	color = "#FFD700"
	icon_state = "essence_order"
	smells_like = "purity"

/datum/thaumaturgical_essence/chaos
	name = "Chaos Essence"
	desc = "The essence of change and discord."
	color = "#8A2BE2"
	icon_state = "essence_chaos"
	smells_like = "uncertainty"

// =============================================================================
// TIER 1 - FIRST COMPOUND ESSENCES
// =============================================================================

/datum/thaumaturgical_essence/frost
	name = "Frost Essence"
	desc = "The essence of bitter cold."
	tier = 1
	color = "#87CEEB"
	icon_state = "essence_frost"
	smells_like = "winter air"

/datum/thaumaturgical_essence/light
	name = "Light Essence"
	desc = "The essence of illumination."
	tier = 1
	color = "#FFFF99"
	icon_state = "essence_light"
	smells_like = "dawn"

/datum/thaumaturgical_essence/motion
	name = "Motion Essence"
	desc = "The essence of movement and speed."
	tier = 1
	color = "#32CD32"
	icon_state = "essence_motion"
	smells_like = "rushing wind"

/datum/thaumaturgical_essence/cycle
	name = "Cycle Essence"
	desc = "The essence of renewal and time."
	tier = 1
	color = "#20B2AA"
	icon_state = "essence_cycle"
	smells_like = "changing seasons"

/datum/thaumaturgical_essence/energia
	name = "Energia Essence"
	desc = "The essence of raw energy."
	tier = 1
	color = "#FF1493"
	icon_state = "essence_energia"
	smells_like = "crackling energy"

/datum/thaumaturgical_essence/void
	name = "Void Essence"
	desc = "The essence of emptiness."
	tier = 1
	color = "#2F2F2F"
	icon_state = "essence_void"
	smells_like = "the abyss"

/datum/thaumaturgical_essence/poison
	name = "Poison Essence"
	desc = "The essence of toxicity."
	tier = 1
	color = "#9ACD32"
	icon_state = "essence_poison"
	smells_like = "death"

/datum/thaumaturgical_essence/life
	name = "Life Essence"
	desc = "The essence of vitality."
	tier = 1
	color = "#FF69B4"
	icon_state = "essence_life"
	smells_like = "blooming flowers"

/datum/thaumaturgical_essence/crystal
	name = "Crystal Essence"
	desc = "The essence of crystalline structure."
	tier = 1
	color = "#DA70D6"
	icon_state = "essence_crystal"
	smells_like = "gem dust"

// =============================================================================
// TIER 2 - SECOND COMPOUND ESSENCES
// =============================================================================

/datum/thaumaturgical_essence/magic
	name = "Magic Essence"
	desc = "The essence of pure arcane power."
	tier = 2
	color = "#9370DB"
	icon_state = "essence_magic"
	smells_like = "raw magic"
