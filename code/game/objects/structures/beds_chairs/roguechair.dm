/obj/structure/chair/bench
	name = "bench"
	icon_state = "bench"
	icon = 'icons/roguetown/misc/structure.dmi'
	buildstackamount = 1
	item_chair = null
	destroy_sound = 'sound/combat/hits/onwood/destroyfurniture.ogg'
	attacked_sound = "woodimpact"
	sleepy = 0.55
//	pixel_y = 10
	layer = OBJ_LAYER
	metalizer_result = /obj/item/statue/iron/deformed

/obj/structure/chair/bench/church
	icon_state = "church_benchleft"

/obj/structure/chair/bench/church/mid
	icon_state = "church_benchmid"

/obj/structure/chair/bench/church/r
	icon_state = "church_benchright"

/obj/structure/chair/bench/Initialize()
	. = ..()
	handle_layer()

/obj/structure/chair/bench/handle_layer()
	if(dir == NORTH)
		layer = ABOVE_MOB_LAYER
		plane = GAME_PLANE_UPPER
	else
		layer = OBJ_LAYER
		plane = GAME_PLANE

/obj/structure/chair/bench/post_buckle_mob(mob/living/M)
	..()
	density = TRUE
//	M.pixel_y = 10

/obj/structure/chair/bench/post_unbuckle_mob(mob/living/M)
	..()
	density = FALSE
//	M.pixel_x = M.get_standard_pixel_x_offset(M.lying)
//	M.pixel_y = M.get_standard_pixel_y_offset(M.lying)


/obj/structure/chair/bench/CanPass(atom/movable/mover, turf/target)
	if(istype(mover, /obj/projectile))
		return TRUE
	if(get_dir(mover,loc) == dir)
		return FALSE
	return !density

/obj/structure/chair/bench/CheckExit(atom/movable/mover, turf/target)
	if(istype(mover, /obj/projectile))
		return TRUE
	if(get_dir(target, mover.loc) == dir)
		return FALSE
	return !density

/obj/structure/chair/bench/couch
	icon_state = "redcouch"

/obj/structure/chair/bench/church/smallbench
	icon_state = "benchsmall"

/obj/structure/chair/bench/couch/r
	icon_state = "redcouch2"

/obj/structure/chair/bench/ultimacouch
	icon_state = "ultimacouchleft"

/obj/structure/chair/bench/ultimacouch/r
	icon_state = "ultimacouchright"

/obj/structure/chair/bench/coucha
	icon_state = "couchaleft"

/obj/structure/chair/bench/coucha/r
	icon_state = "coucharight"

/obj/structure/chair/bench/couchablack
	icon_state = "couchablackaleft"

/obj/structure/chair/bench/couchablack/r
	icon_state = "couchablackaright"

/obj/structure/chair/bench/throne
	name = "small throne"
	icon_state = "thronechair"

/obj/structure/chair/bench/couch/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/structure/chair/bench/couch/Destroy()
	GLOB.lordcolor -= src
	return ..()

/obj/structure/chair/bench/couch/lordcolor(primary,secondary)
	if(!primary || !secondary)
		return
	var/mutable_appearance/M = mutable_appearance(icon, "[icon_state]_primary", -(layer+0.1))
	M.color = secondary //looks better
	add_overlay(M)
	GLOB.lordcolor -= src

// dirtier sofa
/obj/structure/chair/bench/couch/redleft
	icon_state = "redcouch_alt"
/obj/structure/chair/bench/couch/redright
	icon_state = "redcouch2_alt"

/obj/structure/chair/wood/alt
	icon_state = "chair2"
	icon = 'icons/roguetown/misc/structure.dmi'
	item_chair = /obj/item/chair
	blade_dulling = DULLING_BASHCHOP
	destroy_sound = 'sound/combat/hits/onwood/destroyfurniture.ogg'
	attacked_sound = "woodimpact"
	metalizer_result = /obj/item/statue/iron/deformed

/obj/structure/chair/wood/alt/chair3
	icon_state = "chair3"
	icon = 'icons/roguetown/misc/structure.dmi'
	item_chair = /obj/item/chair/chair3
	blade_dulling = DULLING_BASHCHOP
	destroy_sound = 'sound/combat/hits/onwood/destroyfurniture.ogg'
	attacked_sound = "woodimpact"
/obj/item/chair/chair3
	icon_state = "chair3"
	origin_type = /obj/structure/chair/wood/alt/chair3

/*	..................   "Noble" chairs   ................... */
/obj/structure/chair/wood/alt/chair_noble
	name = "fine chair"
	icon_state = "chair_green"
	icon = 'icons/roguetown/misc/structure.dmi'
	item_chair = /obj/item/chair/chair_nobles
	blade_dulling = DULLING_BASHCHOP
	destroy_sound = 'sound/combat/hits/onwood/destroyfurniture.ogg'
	attacked_sound = "woodimpact"
/obj/item/chair/chair_nobles
	icon_state = "chair_green"
	origin_type = /obj/structure/chair/wood/alt/chair_noble

/obj/structure/chair/wood/alt/chair_noble/purple
	icon_state = "chair_purple"
	item_chair = /obj/item/chair/chair_nobles/purple
/obj/item/chair/chair_nobles/purple
	icon_state = "chair_purple"
	origin_type = /obj/structure/chair/wood/alt/chair_noble/purple

/obj/structure/chair/wood/alt/chair_noble/red
	icon_state = "chair_red"
	item_chair = /obj/item/chair/chair_nobles/red
/obj/item/chair/chair_nobles/red
	icon_state = "chair_red"
	origin_type = /obj/structure/chair/wood/alt/chair_noble/red


/obj/structure/chair/wood/alt/CanPass(atom/movable/mover, turf/target)
	if(isliving(mover))
		var/mob/living/M = mover
		if((M.mobility_flags & MOBILITY_STAND))
			if(isturf(loc))
				var/movefrom = get_dir(M.loc, loc)
				if(movefrom == dir && item_chair != null)
					playsound(loc, 'sound/foley/chairfall.ogg', 100, FALSE)
					var/obj/item/I = new item_chair(loc)
					item_chair = null
					I.dir = dir
					qdel(src)
					return FALSE
	return ..()


/obj/structure/chair/wood/alt/onkick(mob/user)
	if(!user)
		return
	if(isturf(loc))
		playsound(loc, 'sound/foley/chairfall.ogg', 100, FALSE)
		var/obj/item/I = new item_chair(loc)
		item_chair = null
		I.dir = dir
		qdel(src)
		return FALSE

/obj/structure/chair/wood/alt/CheckExit(atom/movable/O, turf/target)
	if(isliving(O))
		var/mob/living/M = O
		if((M.mobility_flags & MOBILITY_STAND))
			if(isturf(loc))
				var/movefrom = get_dir(M.loc, target)
				if(movefrom == turn(dir, 180) && item_chair != null)
					playsound(loc, 'sound/foley/chairfall.ogg', 100, FALSE)
					var/obj/item/I = new item_chair(loc)
					item_chair = null
					I.dir = dir
					qdel(src)
					return FALSE
	return ..()

/obj/structure/chair/wood/alt/take_damage(damage_amount, damage_type = BRUTE, damage_flag = 0, sound_effect = 1)
	if(damage_amount > 5 && item_chair != null)
		playsound(loc, 'sound/foley/chairfall.ogg', 100, FALSE)
		var/obj/item/I = new item_chair(loc)
		item_chair = null
		I.dir = dir
		qdel(src)
		return FALSE
	else
		..()


/obj/structure/chair/wood/alt/fancy
	icon_state = "chair1"
	item_chair = /obj/item/chair/fancy

/obj/item/chair/fancy
	icon_state = "chair1"
	origin_type = /obj/structure/chair/wood/alt/fancy

/obj/structure/chair/wood/alt/attack_right(mob/user)
	var/datum/component/simple_rotation/rotcomp = GetComponent(/datum/component/simple_rotation)
	if(rotcomp)
		rotcomp.HandRot(rotcomp,user,ROTATION_CLOCKWISE)

/obj/structure/chair/wood/alt
//	pixel_y = 5

/obj/structure/chair/wood/alt/post_buckle_mob(mob/living/M)
	..()
	density = TRUE
//	M.set_mob_offsets("bed_buckle", _x = 0, _y = 5)

/obj/structure/chair/wood/alt/post_unbuckle_mob(mob/living/M)
	..()
	density = FALSE
//	M.reset_offsets("bed_buckle")

/obj/item/chair/stool/bar
	name = "stool"
	icon_state = "baritem"
	icon = 'icons/roguetown/misc/structure.dmi'
	origin_type = /obj/structure/chair/stool
	blade_dulling = DULLING_BASHCHOP
	can_parry = TRUE
	gripped_intents = list(/datum/intent/hit)
	obj_flags = CAN_BE_HIT
	max_integrity = 100
	destroy_sound = 'sound/combat/hits/onwood/destroyfurniture.ogg'
	attacked_sound = "woodimpact"

/obj/item/chair/stool/bar/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("wieldedl")
				return list("shrink" = 0.8,"sx" = 3,"sy" = -8,"nx" = -19,"ny" = -6,"wx" = -13,"wy" = -7,"ex" = 1,"ey" = -5,"westabove" = 1,"eastbehind" = 0,"nturn" = 30,"sturn" = -18,"wturn" = 30,"eturn" = -24,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.8,"sx" = -20,"sy" = -6,"nx" = 0,"ny" = -7,"wx" = -18,"wy" = -5,"ex" = -4,"ey" = -8,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -42,"sturn" = 33,"wturn" = 33,"eturn" = -21,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)

// ------------ GOOD BEDS ----------------------
/obj/structure/bed/inn
	icon_state = "inn_bed"
	sleepy = 3

/obj/structure/bed/inn/double
	icon_state = "double"
	max_buckled_mobs = 2
	sleepy = 3
	debris = list(/obj/item/grown/log/tree/small = 2)
	/// The mob who buckled to this bed second, to avoid other mobs getting pixel-shifted before they unbuckle.
	var/mob/living/goldilocks

/obj/structure/bed/inn/double/post_buckle_mob(mob/living/target)
	. = ..()
	if(length(buckled_mobs) > 1 && !goldilocks) //  Push the second buckled mob a bit higher from the normal lying position
		target.set_mob_offsets("bed_buckle", _x = 0, _y = 12)
		goldilocks = target

/obj/structure/bed/inn/double/post_unbuckle_mob(mob/living/target)
	. = ..()
	if(target == goldilocks)
		goldilocks = null

// ------------ DECENT BEDS ----------------------
/obj/structure/bed/wool
	name = "wool bed"
	desc = "A comfy bed, made from soft cloth"
	icon_state = "woolbed"
	sleepy = 2

/obj/structure/bed/wool/double
	name = "big wool bed"
	desc = "A large soft bed, could fit two people."
	icon_state = "double_wool"
	debris = list(/obj/item/grown/log/tree/small = 2)
	/// The mob who buckled to this bed second, to avoid other mobs getting pixel-shifted before they unbuckle.
	var/mob/living/goldilocks

/obj/structure/bed/wool/double/post_buckle_mob(mob/living/target)
	. = ..()
	if(length(buckled_mobs) > 1 && !goldilocks) //  Push the second buckled mob a bit higher from the normal lying position
		target.set_mob_offsets("bed_buckle", _x = 0, _y = 12)
		goldilocks = target

/obj/structure/bed/wool/double/post_unbuckle_mob(mob/living/target)
	. = ..()
	if(target == goldilocks)
		goldilocks = null

// ------------ ACCEPTABLE BEDS ----------------------
/obj/structure/bed/hay
	name = "hay bed"
	desc = "A bed padded with hay. At least your not sleeping on the floor."
	icon_state = "haybed"
	sleepy = 1
	debris = list(/obj/item/grown/log/tree/small = 1)

/obj/structure/bed/mediocre
	icon_state = "shitbed2"
	sleepy = 1
	metalizer_result = null

// Inhumen boss bed. Sleeping on a bear! Kinda comfy, sort of
/obj/structure/bed/bear
	desc = "A hide of a slain bear. It looks like someone sleeps on it often."
	icon = 'icons/turf/floors/bear.dmi'
	icon_state = "bear"
	sleepy = 1


// ------------ UNCOMFORTABLE BEDS ----------------------
/obj/structure/bed/shit
	name = "uncomfortable bed"
	icon_state = "shitbed"
	sleepy = 0.75
	metalizer_result = null

/obj/structure/bed/sleepingbag
	name = "sleepcloth"
	desc = "So you can sleep on the ground in relative peace."
	icon_state = "sleepingcloth"
	attacked_sound = 'sound/foley/cloth_rip.ogg'
	break_sound = 'sound/foley/cloth_rip.ogg'
	sleepy = 0.75

/obj/structure/bed/sleepingbag/MiddleClick(mob/user, params)
	..()
	user.visible_message("<span class='notice'>[user] begins rolling up \the [src].</span>")
	if(do_after(user, 2 SECONDS, target = src))
		user.put_in_hands(new /obj/item/sleepingbag(get_turf(src)))
		qdel(src)

/obj/item/sleepingbag
	name = "roll of sleepcloth"
	desc = "A quick and simple way to create a resting place on the ground."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "sleepingcloth_rolled"
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BACK
	grid_height = 64
	grid_width = 96

/obj/item/sleepingbag/MiddleClick(mob/user, params)
	..()
	var/turf/T = get_turf(loc)
	if(!isfloorturf(T))
		to_chat(user, "<span class='warning'>I need ground to plant this on!</span>")
		return
	for(var/obj/A in T)
		if(A.density && !(A.flags_1 & ON_BORDER_1))
			to_chat(user, "<span class='warning'>There is already something here!</span>")
			return
	user.visible_message("<span class='notice'>[user] begins placing \the [src] down on the ground.</span>")
	if(do_after(user, 2 SECONDS, src, (IGNORE_HELD_ITEM)))
		new /obj/structure/bed/sleepingbag(get_turf(src))
		qdel(src)

/obj/structure/bed/post_buckle_mob(mob/living/M)
	..()
	M.set_mob_offsets("bed_buckle", _x = 0 + src.pixel_x, _y = 5 + src.pixel_y)

/obj/structure/bed/post_unbuckle_mob(mob/living/M)
	..()
	M.reset_offsets("bed_buckle")
