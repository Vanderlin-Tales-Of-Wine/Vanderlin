/obj/effect/proc_holder/spell/invoked/projectile/arcanebolt
	name = "Arcane Bolt"
	desc = "Shoot out rapid bolts of arcane magic, that firmly hits on impact."
	range = 12
	projectile_type = /obj/projectile/energy/rogue3
	overlay_state = "force_dart"
	sound = list('sound/magic/vlightning.ogg')
	active = FALSE
	releasedrain = 20
	chargedrain = 1
	chargetime = 7
	recharge_time = 5 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	cost = 2
	attunements = list(
		/datum/attunement/arcyne = 0.7,
	)

/obj/projectile/energy/rogue3
	name = "arcane bolt"
	icon_state = "arcane_barrage"
	damage = 30
	damage_type = BRUTE
	armor_penetration = 10
	nodamage = FALSE
	flag =  "piercing"
	hitsound = 'sound/blank.ogg'
	speed = 2

/obj/projectile/energy/rogue3/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		if(M.anti_magic_check())
			visible_message(span_warning("[src] fizzles on contact with [target]!"))
			playsound(get_turf(target), 'sound/magic/magic_nulled.ogg', 100)
			qdel(src)
			return BULLET_ACT_BLOCK
