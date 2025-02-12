//................	Glass panes	............... //
/obj/item/natural/glass
	name = "glass"
	desc = "Windowpanes for construction work."
	icon = 'icons/roguetown/items/crafting.dmi'
	lefthand_file = 'icons/roguetown/onmob/lefthand.dmi'
	righthand_file = 'icons/roguetown/onmob/righthand.dmi'
	experimental_inhand = FALSE
	icon_state = "glasspane"
	dropshrink = 0.8
	grid_width = 64
	grid_height = 64
	drop_sound = 'sound/foley/dropsound/glass_drop.ogg'
	possible_item_intents = list(/datum/intent/use)
	force = 0
	throwforce = 8
	throw_range = 5
	obj_flags = null
	max_integrity = 20
	w_class = WEIGHT_CLASS_BULKY
	bundletype = /obj/item/natural/bundle/glass
	sellprice = 6
/obj/item/natural/glass/attackby(obj/item, mob/living/user)
	if(item_flags & IN_STORAGE)
		return
	. = ..()
/obj/item/natural/glass/throw_impact(atom/hit_atom, datum/thrownthing/thrownthing)
	if(!..()) //was it caught by a mob?
		new /obj/item/natural/glass_shard(get_turf(src))
		pixel_x = rand(-3, 3)
		pixel_y = rand(-3, 3)
		new /obj/effect/decal/cleanable/debris/glassy(get_turf(src))
		playsound(src, 'sound/foley/glass_shatter.ogg', 90, TRUE)
		qdel(src)


//................	Glass panes stack	............... //
/obj/item/natural/bundle/glass
	name = "stack of glass"
	desc = "A stack of fragile glass panes."
	icon = 'icons/roguetown/items/crafting.dmi'
	lefthand_file = 'icons/roguetown/onmob/lefthand.dmi'
	righthand_file = 'icons/roguetown/onmob/righthand.dmi'
	experimental_inhand = FALSE
	icon_state = "glasspane1"
	item_state = "glasspane"
	dropshrink = 0.8
	grid_width = 64
	grid_height = 64
	drop_sound = 'sound/foley/dropsound/glass_drop.ogg'
	possible_item_intents = list(/datum/intent/use)
	force = 15
	throwforce = 18
	throw_range = 2
	firefuel = null
	resistance_flags = null
	firemod = null
	w_class = WEIGHT_CLASS_HUGE
	stackname = "glass"
	stacktype = /obj/item/natural/glass
	maxamount = 3
	icon1 = "glasspane1"
	icon1step = 2
	icon2 = "glasspane2"
	icon2step = 3
/obj/item/natural/bundle/glass/throw_impact(atom/hit_atom, datum/thrownthing/thrownthing)
	if(!..()) //was it caught by a mob?
		new /obj/item/natural/glass_shard(get_turf(src))
		pixel_x = rand(-3, 3)
		pixel_y = rand(-3, 3)
		new /obj/item/natural/glass_shard(get_turf(src))
		new /obj/effect/decal/cleanable/debris/glassy(get_turf(src))
		playsound(src, 'sound/foley/glass_shatter.ogg', 95, TRUE)
		qdel(src)

//................	Glass shard	............... //
/obj/item/natural/glass_shard
	name = "shard"
	desc = "A sharp shard of glass."
	icon = 'icons/roguetown/items/crafting.dmi'
	lefthand_file = 'icons/roguetown/onmob/lefthand.dmi'
	righthand_file = 'icons/roguetown/onmob/righthand.dmi'
	experimental_inhand = FALSE
	icon_state = "shard1"
	item_state = "shard"
	drop_sound = 'sound/foley/dropsound/glass_drop.ogg'
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/stab)
	force = 3
	throwforce = 5
	resistance_flags = null
	w_class = WEIGHT_CLASS_TINY
	attack_verb = list("stabbed", "slashed", "sliced", "cut")
	max_integrity = 40
	smeltresult = /obj/item/natural/glass
/obj/item/natural/glass_shard/New()
	..()
	icon_state = "shard[rand(1,3)]"
/obj/item/natural/glass_shard/Crossed(mob/living/L)
	. = ..()
	playsound(loc,'sound/foley/glass_step.ogg', 35, FALSE)



