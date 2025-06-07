/obj/effect/proc_holder/spell/invoked/projectile/fireball
	name = "Fireball"
	desc = "Shoot out a ball of fire that emits a light explosion on impact, setting the target alight."
	range = 8
	projectile_type = /obj/projectile/magic/aoe/fireball/rogue
	overlay_state = "fireball"
	sound = list('sound/magic/fireball.ogg')
	active = FALSE
	releasedrain = 30
	chargedrain = 1
	chargetime = 15
	recharge_time = 10 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = TRUE
	chargedloop = /datum/looping_sound/invokefire
	associated_skill = /datum/skill/magic/arcane
	attunements = list(
		/datum/attunement/fire = 0.5
		)
	cost = 4

/obj/effect/proc_holder/spell/invoked/projectile/fireball/set_attuned_strength(list/incoming_attunements)
	var/total_value = 1
	for(var/datum/attunement/attunement as anything in attunements)
		if(!(attunement in incoming_attunements))
			continue
		total_value += incoming_attunements[attunement] * attunements[attunement]
	attuned_strength = total_value
	attuned_strength = max(attuned_strength, 0.5)
	return

/obj/projectile/magic/aoe/fireball/rogue/modify_matrix(matrix/matrix)
	var/strength = min(max(0.1, spell_source?.attuned_strength || 1),10)
	return matrix.Scale(strength, strength)


/obj/projectile/magic/aoe/fireball/rogue/Initialize()
	. = ..()
	var/obj/effect/proc_holder/spell/spell_ref = spell_source
	if(spell_ref?.attuned_strength)
		var/strength = spell_ref.attuned_strength
		damage = round(damage * strength)
		exp_light = round(exp_light * strength)
		exp_fire = round(exp_fire * strength)
		var/matrix/matrix = matrix()
		matrix.Scale(strength, strength)
		transform = matrix

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

/obj/projectile/magic/aoe/fireball/rogue/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [target]!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK
		else
			// Experience gain!
			var/boon = sender?.get_learning_boon(/datum/skill/magic/arcane)
			var/amt2raise = sender?.STAINT*2
			sender?.adjust_experience(/datum/skill/magic/arcane, floor(amt2raise * boon), FALSE)
