/obj/item/lipstick
	gender = PLURAL
	name = "red lipstick"
	desc = ""
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "lipstick"
	w_class = WEIGHT_CLASS_TINY
	var/colour = "red"
	var/open = FALSE

/obj/item/lipstick/purple
	name = "purple lipstick"
	colour = "purple"

/obj/item/lipstick/jade
	//It's still called Jade, but theres no HTML color for jade, so we use lime.
	name = "jade lipstick"
	colour = "lime"

/obj/item/lipstick/black
	name = "black lipstick"
	colour = "black"

/obj/item/lipstick/random
	name = "lipstick"
	icon_state = MAP_SWITCH("lipstick", "random_lipstick")

/obj/item/lipstick/random/Initialize()
	. = ..()
	colour = pick("red","purple","lime","black","green","blue","white")
	name = "[colour] lipstick"

/obj/item/lipstick/attack_self(mob/user)
	cut_overlays()
	to_chat(user, "<span class='notice'>I twist \the [src] [open ? "closed" : "open"].</span>")
	open = !open
	if(open)
		var/mutable_appearance/colored_overlay = mutable_appearance(icon, "lipstick_uncap_color")
		colored_overlay.color = colour
		icon_state = "lipstick_uncap"
		add_overlay(colored_overlay)
	else
		icon_state = "lipstick"

/obj/item/lipstick/attack(mob/M, mob/user)
	if(!open)
		return

	if(!ismob(M))
		return

	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.is_mouth_covered())
			to_chat(user, "<span class='warning'>Remove [ H == user ? "your" : "[H.p_their()]" ] mask!</span>")
			return
		if(H.lip_style)	//if they already have lipstick on
			to_chat(user, "<span class='warning'>I need to wipe off the old lipstick first!</span>")
			return
		if(H == user)
			user.visible_message("<span class='notice'>[user] does [user.p_their()] lips with \the [src].</span>", \
								"<span class='notice'>I take a moment to apply \the [src]. Perfect!</span>")
			H.lip_style = "lipstick"
			H.lip_color = colour
			H.update_body_parts()
		else
			user.visible_message("<span class='warning'>[user] begins to do [H]'s lips with \the [src].</span>", \
								"<span class='notice'>I begin to apply \the [src] on [H]'s lips...</span>")
			if(do_after(user, 2 SECONDS, H))
				user.visible_message("<span class='notice'>[user] does [H]'s lips with \the [src].</span>", \
									"<span class='notice'>I apply \the [src] on [H]'s lips.</span>")
				H.lip_style = "lipstick"
				H.lip_color = colour
				H.update_body_parts()
	else
		to_chat(user, "<span class='warning'>Where are the lips on that?</span>")

//you can wipe off lipstick with paper!
/obj/item/paper/attack(mob/M, mob/user)
	if(user.zone_selected == BODY_ZONE_PRECISE_MOUTH)
		if(!ismob(M))
			return

		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			if(!H.lip_style)
				return
			if(H == user)
				to_chat(user, "<span class='notice'>I wipe off the lipstick with [src].</span>")
				H.lip_style = null
				H.update_body_parts()
			else
				user.visible_message("<span class='warning'>[user] begins to wipe [H]'s lipstick off with \the [src].</span>", \
									"<span class='notice'>I begin to wipe off [H]'s lipstick...</span>")
				if(do_after(user, 1 SECONDS, H))
					user.visible_message("<span class='notice'>[user] wipes [H]'s lipstick off with \the [src].</span>", \
										"<span class='notice'>I wipe off [H]'s lipstick.</span>")
					H.lip_style = null
					H.update_body_parts()
	else
		..()
