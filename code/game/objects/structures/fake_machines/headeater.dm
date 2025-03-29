//N/A lamerd version of the headeater until Aberra actually gives the thumbs up for the real one
//doesnt even give headprices for assassin or bandits like I wanted

/obj/item //this whole thing is ineffective, find a better way of handling this stuff
	var/headprice = 0
	var/headpricemi
	var/headpricemax


/obj/item/examine(mob/user)
	. = ..()
	if(headprice > 0 && (HAS_TRAIT(user, TRAIT_BURDEN)))
		. += "<span class='info'>HEADEATER value: [headprice]</span>"



/obj/structure/fake_machine/headeater
	name = "head eating HAILER"
	desc = "A machine that feeds on certain heads for coin, this itteration seems unfinished, what a sell out"
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "mail"
	density = FALSE
	blade_dulling = DULLING_BASH
	pixel_y = 32

/obj/structure/fake_machine/headeater/r
	pixel_y = 0
	pixel_x = 32

/obj/structure/fake_machine/headeater/l
	pixel_y = 0
	pixel_x = -32

/obj/structure/fake_machine/headeater/attackby(obj/item/H, mob/user, params)
	. = ..()
	if((!istype(H, /obj/item/natural/head) || !istype(H, /obj/item/bodypart/head) || !istype(H, /obj/item/painting/lorehead)) && H.headprice <= 0)
		to_chat(user, span_danger("It seems uninterested by the [H]"))
		return

	if(!HAS_TRAIT(user, TRAIT_BURDEN))
		to_chat(user, span_danger("you are can't feed the [src] without carrying his burden"))
		return

	if(istype(H, /obj/item/painting/lorehead) && user.mind.assigned_role == "Gaffer") //this will hopefully be more thematic when the HEAD EATER is in its real form
		to_chat(user, span_danger("as the [src] consumes [H] without a trace, you are hit with a wistful feeling, your past...gone in an instant."))
		user.add_stress(/datum/stressevent/destroyed_past)
		budget2change(H.headprice, user)
		H.forceMove(src)
		return
	to_chat(user, span_danger("the [src] consumes the [H] spitting out coins in its place!"))
	budget2change(H.headprice, user)
	H.forceMove(src)
