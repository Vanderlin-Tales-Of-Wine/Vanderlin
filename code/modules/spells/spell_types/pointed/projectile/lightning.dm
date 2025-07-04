/datum/action/cooldown/spell/projectile/lightning
	name = "Bolt of Lightning"
	desc = "Emit a bolt of lightning that burns and stuns a target."
	button_icon_state = "lightning"
	sound = 'sound/magic/lightning.ogg'
	sound_loop = /datum/looping_sound/invokelightning
	sparks_amt = 5

	charge_time = 3 SECONDS
	charge_drain = 1
	charge_slowdown = 2
	cooldown_time = 30 SECONDS
	spell_cost = 40

	projectile_type = /obj/projectile/magic/lightning

/obj/projectile/magic/lightning
	name = "bolt of lightning"
	tracer_type = /obj/effect/projectile/tracer/stun
	muzzle_type = null
	impact_type = null
	hitscan = TRUE
	movement_type = PHASING
	light_color = LIGHT_COLOR_WHITE
	damage = 15
	damage_type = BURN
	nodamage = FALSE
	speed = 0.3
	light_color = "#dbe72c"
	light_outer_range =  7
