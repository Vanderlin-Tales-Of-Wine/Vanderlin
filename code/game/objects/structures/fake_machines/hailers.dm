//N/A this is mostly a noticeboard clone, but it works!

/obj/structure/fake_machine/hailer
	name = "HAILER"
	desc = ""
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "mail"
	density = FALSE
	blade_dulling = DULLING_BASH
	pixel_y = 32

/obj/structure/fake_machine/hailer/Initialize(mapload)
	. = ..()
	SSroguemachine.hailer = src

/obj/structure/fake_machine/hailer/attackby(obj/item/H, mob/user, params)
	if((!HAS_TRAIT(user, TRAIT_BURDEN)))
		to_chat(user, "<span class='notice'>stranger danger! the [src] closes its teeth as you extend your hand to it</span>")
		return
	if(!istype(H, /obj/item/paper))
		to_chat(user, "<span class='notice'>the [src] only accepts paper</span>")
		return
	if(istype(H, /obj/item/reagent_containers/powder/salt)) //mmmm, salt.
		to_chat(user, "<span class='notice'>the [src]'s tongue slips between its bronze teeth to lap at the salt in [user]'s hand, finishing with effectionate licks across their palm... gross </span>")
		qdel(H)
		return
	if(istype(H, /obj/item/paper) && (HAS_TRAIT(user, TRAIT_BURDEN)))
		if(!user.transferItemToLoc(H, src))
			return
		to_chat(user, "<span class='notice'>I pin the [H] to the noticeboard.</span>")
	return ..()

/obj/structure/fake_machine/hailer/interact(mob/user)
	ui_interact(user)

/obj/structure/fake_machine/hailer/ui_interact(mob/user)
	. = ..()
	var/auth = TRUE
	var/dat = "<B>[name]</B><BR>"
	for(var/obj/item/H in src)
		if(istype(H, /obj/item/paper))
			dat += "<A href='byond://?src=[REF(src)];read=[REF(H)]'>[H.name]</A> [auth ? "<A href='byond://?src=[REF(src)];write=[REF(H)]'>Write</A> <A href='byond://?src=[REF(src)];remove=[REF(H)]'>Remove</A><A href='byond://?src=[REF(src)];rename=[REF(H)]'>Rename</A>": ""]<BR>"
		else
			dat += "<A href='byond://?src=[REF(src)];read=[REF(H)]'>[H.name]</A> [auth ? "<A href='byond://?src=[REF(src)];remove=[REF(H)]'>Remove</A>" : ""]<BR>"
	user << browse("<HEAD><TITLE>Notices</TITLE></HEAD>[dat]","window=HAILER")
	onclose(user, "HAILER")

/obj/structure/fake_machine/hailer/Topic(href, href_list)
	..()
	usr.set_machine(src)
	if(href_list["remove"])
		if((usr.stat || usr.restrained()))	//For when a player is handcuffed while they have the notice window open
			return
		var/obj/item/I = locate(href_list["remove"]) in contents
		if(istype(I) && I.loc == src)
			I.forceMove(usr.loc)
			usr.put_in_hands(I)



	if(href_list["write"])
		if((usr.stat || usr.restrained())) //For when a player is handcuffed while they have the notice window open
			return
		var/obj/item/P = locate(href_list["write"]) in contents
		if(istype(P) && P.loc == src)
			var/obj/item/I = usr.is_holding_item_of_type(/obj/item/natural/feather)
			if(I)
				add_fingerprint(usr)
				P.attackby(I, usr)
			else
				to_chat(usr, "<span class='warning'>You'll need something to write with!</span>")

	if(href_list["read"])
		var/obj/item/I = locate(href_list["read"]) in contents
		if(istype(I) && I.loc == src)
			usr.examinate(I)

	if(href_list["rename"])
		var/obj/item/I = locate(href_list["rename"]) in contents
		var/n_name = stripped_input(usr, "What would you like to label the paper?", "Paper Labelling", null, MAX_NAME_LEN)
		if((loc == usr && usr.stat == CONSCIOUS))
			I.name = "paper[(n_name ? text("- '[n_name]'") : null)]"

/obj/structure/fake_machine/hailerboard
	name = "HAILER BOARD"
	desc = ""
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "mail"
	density = FALSE
	blade_dulling = DULLING_BASH

/obj/structure/fake_machine/hailerboard/attack_hand(mob/user)
	. = ..()
	ui_interact(user)

/obj/structure/fake_machine/hailerboard/ui_interact(mob/user)
	. = ..()
	var/dat = "<B>[name]</B><BR>"
	for(var/obj/item/H in SSroguemachine.hailer)
		if(istype(H, /obj/item/paper))
			dat += "<A href='byond://?src=[REF(src)];read=[REF(H)]'>[H.name]</A>]<BR>"

	user << browse("<HEAD><TITLE>Notices</TITLE></HEAD>[dat]","window=HAILER BOARD")
	onclose(user, "HAILER BOARD")

/obj/structure/fake_machine/hailerboard/Topic(href, href_list)
	..()
	if(href_list["read"])
		var/obj/item/I = locate(href_list["read"]) in SSroguemachine.hailer.contents
		if(istype(I) && I.loc == src)
			usr.examinate(I)
