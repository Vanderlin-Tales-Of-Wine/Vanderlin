/datum/action/cooldown/spell/projectile/fetch
	name = "Fetch"
	desc = "Shoot out a magical bolt that draws in the target struck towards the caster."
	button_icon_state = "fetch"
	cast_range = 15
	sound = 'sound/magic/magnet.ogg'

	point_cost = 2
	attunements = list(
		/datum/attunement/aeromancy = 0.4,
	)

	charge_time = 3 SECONDS
	charge_drain = 2
	charge_slowdown = 1
	cooldown_time = 20 SECONDS
	spell_cost = 30

	projectile_type = /obj/projectile/magic/fetch
