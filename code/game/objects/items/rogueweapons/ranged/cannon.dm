// 1:1 Port from Stonekeep's warmonger thing


/obj/structure/cannon // cannon
	name = "barkstone"
	desc = "A large weapon mainly hoisted on warships."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "cannona"
	anchored = FALSE
	density = TRUE
	max_integrity = 450
	drag_slowdown = 1 // If it took so long it would be not really fun.
	w_class = WEIGHT_CLASS_GIGANTIC // INSTANTLY crushed
	var/obj/projectile/bullet/reusable/cannonball/loaded

/obj/structure/cannon/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/projectile/bullet/reusable/cannonball))
		if(loaded)
			return
		user.visible_message("<span class='notice'>\The [user] begins loading \the [I] into \the [src].</span>")
		playsound(src, 'sound/combat/cannon_loading.ogg', 35)
		if(!do_after(user, 5 SECONDS, TRUE, src))
			return
		I.forceMove(src)
		loaded = I
		user.visible_message("<span class='notice'>\The [user] loads \the [I] into \the [src].</span>")
		playsound(src, 'sound/foley/trap_arm.ogg', 65)
	if(istype(I, /obj/item/flashlight/flare/torch))
		var/obj/item/flashlight/flare/torch/LR = I
		if(!loaded)
			return
		if(LR.on)
			playsound(src.loc, 'sound/items/firelight.ogg', 100)
			user.visible_message("<span class='danger'>\The [user] lights \the [src]!</span>")
			fire()
	else
		return ..()

/obj/structure/cannon/fire_act(added, maxstacks)
	if(!loaded)
		return
	playsound(src.loc, 'sound/items/firelight.ogg', 100)
	fire()

/obj/structure/cannon/spark_act()
	if(!loaded)
		return
	playsound(src.loc, 'sound/items/firelight.ogg', 100)
	fire()

/obj/structure/cannon/proc/fire()
	for(var/mob/living/carbon/H in hearers(7, src))
		shake_camera(H, 6, 5)
		H.blur_eyes(4)
		if(prob(30))
			H.playsound_local(get_turf(H), 'sound/foley/tinnitus.ogg', 45, FALSE)
	for(var/mob/living/carbon/human/H in get_step(src, turn(dir, 180)))
		var/turf/turfa = get_ranged_target_turf(src, turn(dir, 180), 2)
		H.throw_at(turfa, 2, 1, null, FALSE)
		H.take_overall_damage(45)
		visible_message("<span class='danger'>\The [H] is thrown back from \the [src]'s recoil!</span>")
	flick("cannona_fire", src)
	if(!loaded)
		return
	var/obj/projectile/fired_projectile = new loaded.projectile_type(get_turf(src))
	fired_projectile.firer = src
	fired_projectile.fired_from = src
	fired_projectile.fire(dir2angle(dir))
	QDEL_NULL(loaded)
	playsound(src.loc, 'sound/misc/explode/explosion.ogg', 100, FALSE)
	sleep(4)
	new /obj/effect/particle_effect/smoke(get_turf(src))

/obj/item/gun/ballistic/revolver/grenadelauncher/flintlock/handcannon // for the memes
	name = "hand barkstone"
	desc = "HOLY FUCK!"
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "cannona"
	fire_sound = 'sound/misc/explode/explosion.ogg'
	mag_type = /obj/projectile/bullet/reusable/cannonball
	dropshrink = 0.5
