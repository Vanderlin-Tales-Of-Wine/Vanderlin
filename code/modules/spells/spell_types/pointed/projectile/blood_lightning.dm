/datum/action/cooldown/spell/projectile/blood_bolt
	name = "Blood Bolt"
	desc = "Launch a bolt of blood infused with lightning."
	button_icon_state = "bloodlightning"
	sound = 'sound/magic/vlightning.ogg'

	associated_skill = /datum/skill/magic/blood
	attunements = list(
		/datum/attunement/electric = 0.3,
		/datum/attunement/blood = 0.7,
	)

	charge_time = 3 SECONDS
	charge_drain = 1
	charge_slowdown = 2
	cooldown_time = 30 SECONDS
	spell_cost = 40

	projectile_type = /obj/projectile/magic/bloodlightning

/obj/projectile/magic/bloodlightning
	name = "blood bolt"
	tracer_type = /obj/effect/projectile/tracer/blood
	hitscan = TRUE
	movement_type = PHASING
	damage = 35
	damage_type = BURN
	nodamage = FALSE
	speed = 0.3
	light_color = "#802121"
	light_outer_range =  7
