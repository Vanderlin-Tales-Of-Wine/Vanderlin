/obj/structure/fireaxecabinet
	name = "sword rack"
	desc = ""
	icon = 'icons/obj/wallmounts.dmi'
	icon_state = "fireaxe"
	anchored = TRUE
	density = FALSE
	armor = list("blunt" = 50, "slash" = 50, "stab" = 50,  "piercing" = 20, "fire" = 90, "acid" = 50)
	max_integrity = 150
	integrity_failure = 0
	var/obj/item/weapon/sword/long/heirloom

/obj/structure/fireaxecabinet/Initialize()
	. = ..()
	heirloom = new /obj/item/weapon/sword/long/heirloom(src)
	update_appearance(UPDATE_ICON_STATE)

/obj/structure/fireaxecabinet/Destroy()
	if(heirloom)
		QDEL_NULL(heirloom)
	return ..()

/obj/structure/fireaxecabinet/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/weapon/sword/long/heirloom) && !heirloom)
		var/obj/item/weapon/sword/long/heirloom/F = I
		if(F.wielded)
			to_chat(user, "<span class='warning'>Unwield the [F.name] first.</span>")
			return
		if(!user.transferItemToLoc(F, src))
			return
		heirloom = F
		to_chat(user, "<span class='notice'>I place the [F.name] back in the [name].</span>")
		update_appearance(UPDATE_ICON_STATE)
		return
	return ..()

/obj/structure/fireaxecabinet/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(heirloom)
		user.put_in_hands(heirloom)
		heirloom = null
		to_chat(user, "<span class='notice'>I take the sword from the [name].</span>")
		src.add_fingerprint(user)
		update_appearance(UPDATE_ICON_STATE)
		return

/obj/structure/fireaxecabinet/attack_paw(mob/living/user)
	return attack_hand(user)

/obj/structure/fireaxecabinet/update_icon_state()
	. = ..()
	icon_state = "fireaxe"
	if(heirloom)
		icon_state = "axe"

/obj/structure/fireaxecabinet/south
	dir = SOUTH
	pixel_y = 32
