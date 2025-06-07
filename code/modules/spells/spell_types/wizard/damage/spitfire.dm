/obj/effect/proc_holder/spell/invoked/projectile/spitfire
	name = "Spitfire"
	desc = "Shoot out a low-powered ball of fire that shines brightly on impact, potentially blinding a target."
	range = 8
	projectile_type = /obj/projectile/magic/aoe/fireball/rogue2
	overlay_state = "fireball_multi"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE
	releasedrain = 30
	chargedrain = 1
	chargetime = 10
	recharge_time = 8 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokefire
	associated_skill = /datum/skill/magic/arcane
	cost = 3
	attunements = list(
		/datum/attunement/fire = 0.3,
	)

/obj/effect/proc_holder/spell/invoked/projectile/spitfire/set_attuned_strength(list/incoming_attunements)
	var/total_value = 1
	for(var/datum/attunement/attunement as anything in attunements)
		if(!(attunement in incoming_attunements))
			continue
		total_value += incoming_attunements[attunement] * attunements[attunement]
	attuned_strength = total_value
	attuned_strength = max(attuned_strength, 0.5)
	return

/obj/projectile/magic/aoe/fireball/rogue2/modify_matrix(matrix/matrix)
	var/strength = min(max(0.1, spell_source?.attuned_strength || 1),10)
	return matrix.Scale(strength, strength)

/obj/projectile/magic/aoe/fireball/rogue2
	name = "spitfire"
	exp_heavy = 0
	exp_light = 0
	exp_flash = 1
	exp_fire = 0
	damage = 20
	damage_type = BURN
	nodamage = FALSE
	flag = "magic"
	hitsound = 'sound/blank.ogg'
	aoe_range = 0
	speed = 2.5

/obj/projectile/magic/aoe/fireball/rogue2/Initialize(mapload, incoming_spell)
	. = ..()
	var/obj/effect/proc_holder/spell/spell_ref = spell_source
	if(spell_ref?.attuned_strength)
		var/strength = spell_ref.attuned_strength
		damage = round(damage * strength)
		exp_light = round(exp_light * strength)

/obj/projectile/magic/aoe/fireball/rogue2/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [target]!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK
