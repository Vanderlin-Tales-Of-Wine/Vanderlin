/datum/action/cooldown/spell/projectile/eldritch_blast
	name = "Eldritch Blast"
	desc = "A beam of crackling energy streaks toward a target, causing moderate damage."
	button_icon_state = "eldritch_blast"
	sound = 'sound/magic/whiteflame.ogg'

	point_cost = 1
	attunements = list(
		/datum/attunement/dark = 0.3,
	)

	invocation = "Eldritch blast!"
	invocation_type = INVOCATION_SHOUT

	charge_time = 3 SECONDS
	charge_drain = 1
	charge_slowdown = 2
	cooldown_time = 15 SECONDS
	spell_cost = 30

	projectile_type = /obj/projectile/magic/eldritchblast

/obj/projectile/magic/eldritchblast
	name = "eldritch blast"
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "eldritch_blast"
	damage = 25
	damage_type = BRUTE
	range = 15
	woundclass = BCLASS_STAB

/obj/projectile/magic/eldritchblast/on_hit(atom/target, blocked = FALSE, pierce_hit)
	. = ..()
	playsound(src, 'sound/magic/swap.ogg', 100)

/datum/action/cooldown/spell/projectile/eldritch_blast/empowered
	name = "Empowered Eldritch Blast"
	cooldown_time = 20 SECONDS
	spell_cost = 40

	projectile_type = /obj/projectile/magic/eldritchblast/empowered

/obj/projectile/magic/eldritchblast5e/empowered
	damage = 35
	range = 25

/obj/projectile/magic/eldritchblast/empowered/on_hit(atom/target, blocked = FALSE, pierce_hit)
	. = ..()
	var/atom/throw_target = get_step(target, get_dir(firer, target))
	if(isliving(target))
		var/mob/living/L = target
		if(L.can_block_magic(MAGIC_RESISTANCE))
			return BULLET_ACT_BLOCK
		L.safe_throw_at(throw_target, 7, 4)
	else
		if(isitem(target))
			var/obj/item/I = target
			I.safe_throw_at(throw_target, 7, 4)
