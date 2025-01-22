/obj/item/storage/belt
	name = "belt"
	desc = ""
	icon = 'icons/obj/clothing/belts.dmi'
	icon_state = "utilitybelt"
	item_state = "utility"
	slot_flags = ITEM_SLOT_BELT
	attack_verb = list("whipped", "lashed", "disciplined")
	max_integrity = 300
	equip_sound = 'sound/blank.ogg'
	var/content_overlays = FALSE //If this is true, the belt will gain overlays based on what it's holding

/obj/item/storage/belt/suicide_act(mob/living/carbon/user)
	user.visible_message("<span class='suicide'>[user] begins belting [user.p_them()]self with \the [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return BRUTELOSS

/obj/item/storage/belt/update_icon()
	cut_overlays()
	if(content_overlays)
		for(var/obj/item/I in contents)
			var/mutable_appearance/M = I.get_belt_overlay()
			add_overlay(M)
	..()

/obj/item/storage/belt/Initialize()
	. = ..()
	update_icon()
