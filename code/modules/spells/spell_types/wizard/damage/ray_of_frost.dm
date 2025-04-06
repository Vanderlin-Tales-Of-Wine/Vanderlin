/obj/effect/proc_holder/spell/invoked/projectile/rayoffrost5e
	name = "Ray of Frost"
	desc = "Shoots a ray of frost out, slowing anyone hit by it."
	range = 8
	projectile_type = /obj/projectile/magic/rayoffrost5e
	overlay_state = "null"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE

	releasedrain = 30
	chargedrain = 1
	chargetime = 3
	recharge_time = 5 SECONDS //cooldown

	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	antimagic_allowed = FALSE //can you use it if you are antimagicked?
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1


	attunements = list(
		/datum/attunement/ice = 0.6,
	)

	miracle = FALSE

	invocation = "Chill!"
	invocation_type = "shout" //can be none, whisper, emote and shout


/obj/projectile/magic/rayoffrost5e
	name = "ray of frost"
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "ice_2"
	damage = 25
	damage_type = BRUTE
	flag = "magic"
	range = 15
	speed = 2

/obj/projectile/magic/rayoffrost5e/on_hit(atom/target, blocked = FALSE)
	. = ..()
	playsound(src, 'sound/items/stonestone.ogg', 100)
	if(isliving(target))
		var/mob/living/carbon/C = target
		C.apply_status_effect(/datum/status_effect/buff/rayoffrost5e/) //apply debuff
		C.adjustFireLoss(5)

/datum/status_effect/buff/rayoffrost5e
	id = "frostbite"
	alert_type = /atom/movable/screen/alert/status_effect/buff/rayoffrost5e
	duration = 6 SECONDS
	var/static/mutable_appearance/frost = mutable_appearance('icons/roguetown/mob/coldbreath.dmi', "breath_m", ABOVE_ALL_MOB_LAYER)
	effectedstats = list("speed" = -2)

/atom/movable/screen/alert/status_effect/buff/rayoffrost5e
	name = "Frostbite"
	desc = "I can feel myself slowing down."
	icon_state = "debuff"

/datum/status_effect/buff/rayoffrost5e/on_apply()
	. = ..()
	var/mob/living/target = owner
	target.add_overlay(frost)
	target.update_vision_cone()
	var/newcolor = rgb(136, 191, 255)
	target.add_atom_colour(newcolor, TEMPORARY_COLOUR_PRIORITY)
	addtimer(CALLBACK(target, TYPE_PROC_REF(/atom, remove_atom_colour), TEMPORARY_COLOUR_PRIORITY, newcolor), 6 SECONDS)
	target.add_movespeed_modifier(MOVESPEED_ID_ADMIN_VAREDIT, update=TRUE, priority=100, multiplicative_slowdown=4, movetypes=GROUND)

/datum/status_effect/buff/rayoffrost5e/on_remove()
	var/mob/living/target = owner
	target.cut_overlay(frost)
	target.update_vision_cone()
	target.remove_movespeed_modifier(MOVESPEED_ID_ADMIN_VAREDIT, TRUE)
	. = ..()
