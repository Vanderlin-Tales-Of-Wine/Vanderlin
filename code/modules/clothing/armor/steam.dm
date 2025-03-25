/obj/item/clothing/armor/steam
	name = "steam armor"
	desc = "The center piece of the steam armor set."

	icon = 'icons/roguetown/clothing/steamknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/steamknight_onmob.dmi'
	icon_state = "steamknight_chest"

	sleeved =  'icons/roguetown/clothing/onmob/steamknight_onmob.dmi'
	sleevetype = "steamknight_chest"

	anvilrepair = /datum/skill/craft/engineering

	clothing_flags = CANT_SLEEP_IN

	equip_delay_self = 4 SECONDS
	unequip_delay_self = 4 SECONDS

	armor_class = AC_HEAVY
	armor = ARMOR_PLATE_GOOD
	body_parts_covered = COVERAGE_FULL
	prevent_crits = ALL_EXCEPT_STAB
	max_integrity = INTEGRITY_STRONGEST

/obj/item/clothing/armor/steam/equipped(mob/living/user, slot)
	if(!(slotdefine2slotbit(slot) & slot_flags))
		return

	var/list/equipped_types = list()
	var/list/equipped_items = list()
	for(var/obj/item/clothing/V in user.get_equipped_items(FALSE))
		if(!is_type_in_list(V, GLOB.steam_armor))
			continue
		equipped_types |= V.type
		equipped_items |= V

	if(length(equipped_types) != length(GLOB.steam_armor))
		power_off(user)
		remove_status_effect(user)
		for(var/obj/item/clothing/clothing in equipped_items)
			clothing:power_off(user)
		return
	power_on(user)
	apply_status_effect(user)
	for(var/obj/item/clothing/clothing in equipped_items)
		clothing:power_on(user)
	. = ..()

/obj/item/clothing/armor/steam/dropped(mob/living/user)
	var/list/equipped_types = list()
	var/list/equipped_items = list()
	for(var/obj/item/clothing/V in user.get_equipped_items(FALSE))
		if(!is_type_in_list(V, GLOB.steam_armor))
			continue
		equipped_types |= V.type
		equipped_items |= V

	if(length(equipped_types) != length(GLOB.steam_armor))
		power_off(user)
		remove_status_effect(user)
		for(var/obj/item/clothing/clothing in equipped_items)
			clothing:power_off(user)
		return
	power_on(user)
	apply_status_effect(user)
	for(var/obj/item/clothing/clothing in equipped_items)
		clothing:power_on(user)
	. = ..()

/obj/item/clothing/armor/steam/proc/power_on(mob/living/user)
	return

/obj/item/clothing/armor/steam/proc/power_off(mob/living/user)
	return

/obj/item/clothing/armor/steam/proc/apply_status_effect(mob/living/user)
	user.apply_status_effect(/datum/status_effect/buff/powered_steam_armor)

/obj/item/clothing/armor/steam/proc/remove_status_effect(mob/living/user)
	user.remove_status_effect(/datum/status_effect/buff/powered_steam_armor)

