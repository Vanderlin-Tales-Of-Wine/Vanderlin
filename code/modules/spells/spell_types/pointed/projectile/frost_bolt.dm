/datum/action/cooldown/spell/projectile/frost_bolt
	name = "Frost Bolt"
	desc = "A ray of frozen energy, slowing the first thing it touches and lightly damaging it."
	button_icon = "frostbolt"
	sound = 'sound/magic/whiteflame.ogg'

	point_cost = 1
	attunements = list(
		/datum/attunement/ice = 0.7,
	)

	charge_time = 3 SECONDS
	charge_drain = 1
	charge_slowdown = 2
	cooldown_time = 25 SECONDS
	spell_cost = 30

	projectile_type = /obj/projectile/magic/frostbolt

/datum/action/cooldown/spell/projectile/frost_bolt/cast(atom/cast_on)
	. = ..()
	owner.visible_message(span_warning("[owner] hurls a frosty beam at [cast_on]!"), span_notice("You hurl a frosty beam at [cast_on]!"))

/datum/action/cooldown/spell/projectile/frost_bolt/ready_projectile(obj/projectile/to_fire, atom/target, mob/user, iteration)
	. = ..()
	to_fire.damage *= attuned_strength

/obj/projectile/magic/frostbolt
	name = "frost bolt"
	icon_state = "ice_2"
	damage = 25
	damage_type = BURN
	range = 10
	speed = 1

/obj/projectile/magic/frostbolt/on_hit(atom/target, blocked = FALSE, pierce_hit)
	. = ..()
	if(isliving(target))
		var/mob/living/L = target
		L.apply_status_effect(/datum/status_effect/buff/frostbite)
		new /obj/effect/temp_visual/snap_freeze(get_turf(L))
