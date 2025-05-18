/obj/item/clothing/gloves/plate/steam
	name = "steamknight gloves"
	desc = "Part of the steamknight set."

	icon = 'icons/roguetown/clothing/steamknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/steamknight_onmob.dmi'
	icon_state = "steamknight_gloves"

	sleeved =  'icons/roguetown/clothing/onmob/steamknight_onmob.dmi'
	sleevetype = "steamknight_gloves"

	anvilrepair = /datum/skill/craft/engineering
	smeltresult = null
	item_weight = 7 * BRONZE_MULTIPLIER

/obj/item/clothing/gloves/plate/steam/equipped(mob/living/user, slot)
	update_armor(user, slot)
	. = ..()

/obj/item/clothing/gloves/plate/steam/dropped(mob/living/user)
	update_armor(user)
	. = ..()

/obj/item/clothing/gloves/plate/steam/proc/update_armor(mob/living/user, slot)
	if(QDELETED(user))
		return
	var/list/equipped_types = list()
	var/list/equipped_items = list()
	for(var/obj/item/clothing/V as anything in user.get_equipped_items(FALSE))
		if(!is_type_in_list(V, GLOB.steam_armor))
			continue
		equipped_types |= V.type
		equipped_items |= V

	if(length(equipped_types) != length(GLOB.steam_armor))
		power_off(user)
		remove_status_effect(user)
		for(var/obj/item/clothing/clothing as anything in equipped_items)
			clothing:power_off(user)
		return

	if(!slot || !(slotdefine2slotbit(slot) & slot_flags))
		power_off(user)
		remove_status_effect(user)
		for(var/obj/item/clothing/clothing as anything in equipped_items)
			clothing:power_off(user)
		return

	power_on(user)
	apply_status_effect(user)
	for(var/obj/item/clothing/clothing as anything in equipped_items)
		clothing:power_on(user)

/obj/item/clothing/gloves/plate/steam/proc/power_on(mob/living/user)
	return

/obj/item/clothing/gloves/plate/steam/proc/power_off(mob/living/user)
	return

/obj/item/clothing/gloves/plate/steam/proc/apply_status_effect(mob/living/user)
	user.apply_status_effect(/datum/status_effect/buff/powered_steam_armor)

/obj/item/clothing/gloves/plate/steam/proc/remove_status_effect(mob/living/user)
	user.remove_status_effect(/datum/status_effect/buff/powered_steam_armor)

