/datum/action/cooldown/spell/projectile/fireball
	name = "Fireball"
	desc = "Shoot out a ball of fire that emits a light explosion on impact, setting the target alight."
	button_icon_state = "fireball"

	point_cost = 4
	attunements = list(
		/datum/attunement/fire = 0.5
	)

	charge_time = 3 SECONDS
	charge_drain = 1
	charge_slowdown = 2
	cooldown_time = 25 SECONDS
	spell_cost = 30

	projectile_type = /obj/projectile/magic/aoe/fireball/rogue

/datum/action/cooldown/spell/projectile/fireball/ready_projectile(obj/projectile/magic/aoe/fireball/to_fire, atom/target, mob/user, iteration)
	. = ..()
	to_fire.damage *= attuned_strength
	to_fire.exp_light *= attuned_strength
	to_fire.exp_fire *= attuned_strength

/obj/projectile/magic/aoe/fireball/rogue
	name = "fireball"
	exp_heavy = 0
	exp_light = 3
	exp_flash = 0
	exp_fire = 3
	damage = 10
	damage_type = BURN
	nodamage = FALSE
	flag = "magic"
	hitsound = 'sound/fireball.ogg'
	aoe_range = 0
	speed = 3

/datum/action/cooldown/spell/projectile/fireball/greater
	name = "Fireball (Greater)"
	desc = "Shoot out an immense ball of fire that explodes on impact."
	button_icon_state = "fireball_greater"

	point_cost = 6
	attunements = list(
		/datum/attunement/fire = 1.1,
	)

	charge_time = 5 SECONDS
	charge_drain = 2
	charge_slowdown = 3
	cooldown_time = 35 SECONDS
	spell_cost = 50

	projectile_type = /obj/projectile/magic/aoe/fireball/rogue/great

/obj/projectile/magic/aoe/fireball/rogue/great
	name = "fireball"
	exp_devi = 0
	exp_heavy = 1
	exp_light = 5
	exp_flash = 0
	exp_fire = 4
	exp_hotspot = 0
	speed = 6
