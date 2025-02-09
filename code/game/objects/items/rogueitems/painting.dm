
/obj/item/rogue/painting
	name = "painting"
	icon_state = "painting"
	desc = ""
	w_class = WEIGHT_CLASS_NORMAL
	dropshrink = 0.65
	static_price = TRUE
	sellprice = 20
	icon = 'icons/roguetown/misc/decoration.dmi'
	var/deployed_structure = /obj/structure/fluff/walldeco/painting

/obj/item/rogue/painting/attack_turf(turf/T, mob/living/user)
	if(isclosedturf(T))
		if(get_dir(T,user) in GLOB.cardinals)
			to_chat(user, "<span class='warning'>I place [src] on the wall.</span>")
			var/obj/structure/S = new deployed_structure(user.loc)
			switch(get_dir(T,user))
				if(NORTH)
					S.pixel_y = -32
				if(SOUTH)
					S.pixel_y = 32
				if(WEST)
					S.pixel_x = 32
				if(EAST)
					S.pixel_x = -32
			qdel(src)
			return
	..()

/obj/structure/fluff/walldeco/painting
	name = "painting"
	desc = "The artist is unknown. The subject is unknown. Maybe a memorial to a corpse that was trampled on the trail to this reality."
	icon = 'icons/roguetown/misc/decoration.dmi'
	icon_state = "painting_deployed"
	anchored = TRUE
	density = FALSE
	max_integrity = 0
	layer = ABOVE_MOB_LAYER
	var/stolen_painting = /obj/item/rogue/painting

/obj/structure/fluff/walldeco/painting/attack_hand(mob/user)
	if(do_after(user, 3 SECONDS, user))
		var/obj/item/I = new stolen_painting(user.loc)
		user.put_in_hands(I)
		qdel(src)
		return
	..()

/* Paintings */
/obj/item/rogue/painting/queen
	icon_state = "queenpainting"
	desc = "A portrait of Queen Samantha I of Psydonia. Her late husband would be so proud of what she has accomplished in his realm. These mass-reproduced paintings are unfortunately devalued."
	sellprice = 40
	deployed_structure = /obj/structure/fluff/walldeco/painting/queen

/obj/structure/fluff/walldeco/painting/queen
	desc = "A portrait of Queen Samantha I of Enigma. Her late husband would be so proud of what she has accomplished in his realm."
	icon_state = "queenpainting_deployed"
	stolen_painting = /obj/item/rogue/painting/queen

/obj/item/rogue/painting/seraphina
	icon_state = "seraphinapainting"
	desc = "A portrait of holy priest Seraphina, first of her name, blessed be her name."
	sellprice = 40
	deployed_structure = /obj/structure/fluff/walldeco/painting/seraphina

/obj/structure/fluff/walldeco/painting/seraphina
	desc = "A portrait of holy priest Seraphina, first of her name, blessed be her name."
	icon_state = "seraphinapainting_deployed"
	stolen_painting = /obj/item/rogue/painting/seraphina

/obj/item/rogue/painting/skull
	icon_state = "skullpainting"
	desc = "A moody scene depicting a skull and candles on a table. Memento mori."
	sellprice = 40
	deployed_structure = /obj/structure/fluff/walldeco/painting/skull

/obj/structure/fluff/walldeco/painting/skull
	desc = "A moody scene depicting a skull and candles on a table. Memento mori."
	icon_state = "skullpainting_deployed"
	stolen_painting = /obj/item/rogue/painting/skull

/obj/item/rogue/painting/castle
	icon_state = "castlepainting"
	desc = "A painting of a dark tower looming beyond mountains and mist."
	sellprice = 40
	deployed_structure = /obj/structure/fluff/walldeco/painting/castle

/obj/structure/fluff/walldeco/painting/castle
	desc = "A painting of a dark tower looming beyond mountains and mist."
	icon_state = "castlepainting_deployed"
	stolen_painting = /obj/item/rogue/painting/castle

/obj/item/rogue/painting/crown
	icon_state = "crownpainting"
	desc = "A painting of a kingly crown resting on a book."
	sellprice = 40
	deployed_structure = /obj/structure/fluff/walldeco/painting/crown

/obj/structure/fluff/walldeco/painting/crown
	desc = "A painting of a kingly crown resting on a book."
	icon_state = "crownpainting_deployed"
	stolen_painting = /obj/item/rogue/painting/crown
