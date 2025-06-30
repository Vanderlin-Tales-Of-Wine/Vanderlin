/obj/effect/proc_holder/spell/invoked/projectile/repel
	name = "Repel"
	desc = "Shoot out a magical bolt that pushes out the target struck away from the caster. If in throw mode, throw your held item with the same force."
	range = 10
	projectile_type = /obj/projectile/magic/repel
	overlay_state = ""
	sound = list('sound/magic/unmagnet.ogg')
	releasedrain = 5
	chargedrain = 0
	chargetime = 20
	recharge_time = 15 SECONDS
	warnie = "spellwarning"
	overlay_state = "fetch"
	no_early_release = TRUE
	charging_slowdown = 1
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	cost = 2
	attunements = list(
		/datum/attunement/aeromancy = 0.6,
	)

/obj/effect/proc_holder/spell/invoked/projectile/repel/fire_projectile(mob/living/user, atom/target)
	if(iscarbon(user))
		var/mob/living/carbon/carbon = user
		var/obj/held_item = carbon.get_active_held_item()
		if(carbon.in_throw_mode && held_item)
			if(carbon.dropItemToGround(held_item))
				held_item.throw_at(target, 7, 4)
				carbon.throw_mode_off()
				return
	. = ..()

/obj/projectile/magic/repel
	name = "bolt of repeling"
	icon = 'icons/effects/effects.dmi'
	icon_state = "curseblob"
	range = 15

/obj/projectile/magic/repel/on_hit(target)
	. = ..()
	var/atom/throw_target = get_edge_target_turf(firer, get_dir(firer, target)) //ill be real I got no idea why this worked.
	if(ismob(target))
		var/mob/M = target
		if(M.anti_magic_check() || !firer)
			M.visible_message(span_warning("[src] vanishes on contact with [target]!"))
			return BULLET_ACT_BLOCK
		M.throw_at(throw_target, 7, 4)
	else
		if(isitem(target))
			var/obj/item/I = target
			var/mob/living/carbon/human/carbon_firer
			if (ishuman(firer))
				carbon_firer = firer
				if (carbon_firer?.can_catch_item())
					throw_target = get_edge_target_turf(firer, get_dir(firer, target))
			I.throw_at(throw_target, 7, 4)
