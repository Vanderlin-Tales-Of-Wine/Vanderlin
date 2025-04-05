/obj/effect/proc_holder/spell/invoked/projectile/bloodsteal
	name = "Blood Steal"
	desc = ""
	overlay_state = "bloodsteal"
	sound = 'sound/magic/vlightning.ogg'
	range = 8
	projectile_type = /obj/projectile/magic/bloodsteal
	releasedrain = 30
	chargedrain = 1
	chargetime = 25
	recharge_time = 20 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/blood
	attunements = list(
		/datum/attunement/blood = 0.7,
	)

/obj/projectile/magic/bloodsteal
	name = "blood steal"
	tracer_type = /obj/effect/projectile/tracer/bloodsteal
	muzzle_type = null
	impact_type = null
	hitscan = TRUE
	movement_type = UNSTOPPABLE
	damage = 25
	damage_type = BRUTE
	nodamage = FALSE
	speed = 0.3
	flag = "magic"
	light_color = "#e74141"
	light_outer_range =  7

/obj/projectile/magic/bloodsteal/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [target]!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK
		if(ishuman(target))
			var/mob/living/carbon/human/H = target
			var/datum/antagonist/vampire/VDrinker = sender.mind.has_antag_datum(/datum/antagonist/vampire)
			H.blood_volume = max(H.blood_volume-45, 0)
			if(H.vitae_pool >= 500) // You'll only get vitae IF they have vitae.
				H.vitae_pool -= 500
				VDrinker.adjust_vitae(500)
			var/boon = sender.mind?.get_learning_boon(/datum/skill/magic/blood)
			var/amt2raise = sender.STAINT*2
			sender.mind?.adjust_experience(/datum/skill/magic/blood, floor(amt2raise * boon), FALSE)
			H.handle_blood()
			H.visible_message(span_danger("[target] has their blood ripped from their body!"), \
					span_userdanger("My blood erupts from my body!"), span_hear("..."), COMBAT_MESSAGE_RANGE, target)
			new /obj/effect/decal/cleanable/blood/puddle(H.loc)
	qdel(src)
