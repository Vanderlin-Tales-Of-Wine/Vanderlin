/obj/structure/flora/roguegrass/herb
	name = "herbbush"
	desc = "A bush,for an herb. This shouldn't show up."
	icon = 'icons/roguetown/misc/herbfoliage.dmi'
	icon_state = "spritemeplz"
	var/res_replenish
	max_integrity = 10
	climbable = FALSE
	dir = SOUTH
	var/list/looty = list()
	var/herbtype
	var/obj/effect/skill_tracker/alchemy_plants/alchemy_effect

/obj/structure/flora/roguegrass/herb/Initialize()
	. = ..()
	desc = "An herb. This one looks like [name]."
	alchemy_effect = new(get_turf(src), src)

/obj/structure/flora/roguegrass/herb/update_icon()
	return

/obj/structure/flora/roguegrass/herb/attack_hand(mob/user)
	if(isliving(user))
		var/mob/living/L = user
		user.changeNext_move(CLICK_CD_MELEE)
		playsound(src.loc, "plantcross", 80, FALSE, -1)
		if(do_after(L, rand(3,5) DECISECONDS, src))
			if(!looty.len && (world.time > res_replenish))
				loot_replenish()
			if(prob(50) && looty.len)
				if(looty.len == 1)
					res_replenish = world.time + 5 MINUTES
				var/obj/item/B = pick_n_take(looty)
				if(B)
					B = new B(user.loc)
					user.put_in_hands(B)
					user.visible_message(span_notice("[user] finds [B] in [src]."))
					return
			user.visible_message(span_notice("[user] searches through [src]."))
			if(!looty.len)
				to_chat(user, span_warning("Picked clean; but looks healthy. I should try again later."))

/obj/structure/flora/roguegrass/herb/proc/loot_replenish()
	if(herbtype)
		looty += herbtype

/obj/structure/flora/roguegrass/herb/random
	name = "random herb"
	desc = "Haha, im in danger."

/obj/structure/flora/roguegrass/herb/random/Initialize()
	var/type = pick(list(/obj/structure/flora/roguegrass/herb/atropa,/obj/structure/flora/roguegrass/herb/matricaria,
	/obj/structure/flora/roguegrass/herb/symphitum,/obj/structure/flora/roguegrass/herb/taraxacum,
	/obj/structure/flora/roguegrass/herb/euphrasia,/obj/structure/flora/roguegrass/herb/paris,
	/obj/structure/flora/roguegrass/herb/calendula,/obj/structure/flora/roguegrass/herb/mentha,
	/obj/structure/flora/roguegrass/herb/urtica,/obj/structure/flora/roguegrass/herb/salvia,
	/obj/structure/flora/roguegrass/herb/hypericum,/obj/structure/flora/roguegrass/herb/benedictus,
	/obj/structure/flora/roguegrass/herb/valeriana,/obj/structure/flora/roguegrass/herb/artemisia))

	var/obj/structure/flora/roguegrass/herb/boi = new type
	boi.forceMove(get_turf(src))
	boi.pixel_x += rand(-3,3)
	. = ..()

	return INITIALIZE_HINT_QDEL


/obj/structure/flora/roguegrass/herb/atropa
	name = "atropa"
	icon_state = "atropa"

	herbtype = /obj/item/alch/atropa

/obj/structure/flora/roguegrass/herb/matricaria
	name = "matricaria"
	icon_state = "matricaria"

	herbtype = /obj/item/alch/matricaria

/obj/structure/flora/roguegrass/herb/symphitum
	name = "symphitum"
	icon_state = "symphitum"

	herbtype = /obj/item/alch/symphitum

/obj/structure/flora/roguegrass/herb/taraxacum
	name = "taraxacum"
	icon_state = "taraxacum"

	herbtype = /obj/item/alch/taraxacum

/obj/structure/flora/roguegrass/herb/euphrasia
	name = "euphrasia"
	icon_state = "euphrasia"

	herbtype = /obj/item/alch/euphrasia

/obj/structure/flora/roguegrass/herb/paris
	name = "paris"
	icon_state = "paris"

	herbtype = /obj/item/alch/paris

/obj/structure/flora/roguegrass/herb/calendula
	name = "calendula"
	icon_state = "calendula"

	herbtype = /obj/item/alch/calendula

/obj/structure/flora/roguegrass/herb/mentha
	name = "mentha"
	icon_state = "mentha"

	herbtype = /obj/item/alch/mentha

/obj/structure/flora/roguegrass/herb/urtica
	name = "urtica"
	icon_state = "urtica"

	herbtype = /obj/item/alch/urtica

/obj/structure/flora/roguegrass/herb/salvia
	name = "salvia"
	icon_state = "salvia"

	herbtype = /obj/item/alch/salvia

/obj/structure/flora/roguegrass/herb/hypericum
	name = "hypericum"
	icon_state = "hypericum"

	herbtype = /obj/item/alch/hypericum

/obj/structure/flora/roguegrass/herb/benedictus
	name = "benedictus"
	icon_state = "benedictus"

	herbtype = /obj/item/alch/benedictus

/obj/structure/flora/roguegrass/herb/valeriana
	name = "valeriana"
	icon_state = "valeriana"

	herbtype = /obj/item/alch/valeriana

/obj/structure/flora/roguegrass/herb/artemisia
	name = "artemisia"
	icon_state = "artemisia"

	herbtype = /obj/item/alch/artemisia

