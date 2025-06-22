/obj/effect/proc_holder/spell/invoked/projectile/eldritchblast5e
	name = "Eldritch Blast"
	desc = "A beam of crackling energy streaks toward a target, causing moderate damage."
	range = 8
	projectile_type = /obj/projectile/magic/eldritchblast5e
	overlay_state = "eldritch_blast"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE

	releasedrain = 30
	chargedrain = 1
	chargetime = 3
	recharge_time = 5 SECONDS //cooldown

	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	antimagic_allowed = FALSE //can you use it if you are antimagicked?
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	miracle = FALSE

	invocation = "Eldritch blast!" // Bad incantation but it's funny.
	invocation_type = "shout"

	attunements = list(
		/datum/attunement/dark = 0.3,
	)


/obj/projectile/magic/eldritchblast5e
	name = "eldritch blast"
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "eldritch_blast"
	damage = 25
	damage_type = BRUTE
	flag = "magic"
	range = 15
	woundclass = BCLASS_STAB

/obj/projectile/magic/eldritchblast5e/on_hit(atom/target, blocked = FALSE)
	. = ..()
	playsound(src, 'sound/magic/swap.ogg', 100)

/obj/effect/proc_holder/spell/invoked/projectile/eldritchblast5e/empowered
	name = "empowered eldritch blast"
	recharge_time = 8 SECONDS //cooldown
	releasedrain = 40
	projectile_type = /obj/projectile/magic/eldritchblast5e/empowered

/obj/projectile/magic/eldritchblast5e/empowered
	damage = 35
	range = 25

/obj/projectile/magic/eldritchblast5e/empowered/on_hit(atom/target, blocked = FALSE)
	var/atom/throw_target = get_step(target, get_dir(firer, target))
	if(isliving(target))
		var/mob/living/L = target
		if(L.anti_magic_check())
			return BULLET_ACT_BLOCK
		L.throw_at(throw_target, 200, 4)
	else
		if(isitem(target))
			var/obj/item/I = target
			I.throw_at(throw_target, 200, 4)
	playsound(src, 'sound/magic/swap.ogg', 100)
