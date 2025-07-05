/datum/action/cooldown/spell/projectile/blood_steal
	name = "Blood Steal"
	desc = "Launch a bolt which leeches the blood of those hit."
	button_icon_state = "bloodsteal"
	sound = 'sound/magic/vlightning.ogg'

	associated_skill = /datum/skill/magic/blood
	attunements = list(
		/datum/attunement/blood = 0.7,
	)

	charge_time = 3 SECONDS
	charge_drain = 1
	charge_slowdown = 2
	cooldown_time = 20 SECONDS
	spell_cost = 30

	projectile_type = /obj/projectile/magic/bloodsteal

/obj/projectile/magic/bloodsteal
	name = "blood steal"
	tracer_type = /obj/effect/projectile/tracer/bloodsteal
	muzzle_type = null
	impact_type = null
	hitscan = TRUE
	movement_type = PHASING
	damage = 25
	damage_type = BRUTE
	nodamage = FALSE
	speed = 0.3
	light_color = "#e74141"
	light_outer_range =  7

/obj/projectile/magic/bloodsteal/on_hit(target)
	. = ..()
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		var/datum/antagonist/vampire/VDrinker = sender.mind?.has_antag_datum(/datum/antagonist/vampire)
		H.blood_volume = max(H.blood_volume - 45, 0)
		if(VDrinker)
			if(H.vitae_pool >= 500) // You'll only get vitae IF they have vitae.
				H.vitae_pool -= 500
				VDrinker.adjust_vitae(500)
		H.visible_message(
			span_danger("[H] has their blood ripped from their body!"),
			span_userdanger("Blood erupts from my body!"),
			span_hear("I hear a fluid spill..."),
		)
		new /obj/effect/decal/cleanable/blood/puddle(get_turf(H))
