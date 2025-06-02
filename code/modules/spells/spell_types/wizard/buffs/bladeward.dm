/obj/effect/proc_holder/spell/self/bladeward5e
	name = "Blade Ward"
	desc = "Improves your targets constitution for a brief duration."
	range = 8
	overlay_state = "null"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE

	releasedrain = 30
	chargedrain = 1
	chargetime = 3
	recharge_time = 60 SECONDS //cooldown

	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	miracle = FALSE

	invocation = "Blades, be dulled!"
	invocation_type = "shout" //can be none, whisper, emote and shout

// Notes: Bard, Sorcerer, Warlock, Wizard

/obj/effect/proc_holder/spell/self/bladeward5e/cast(mob/user = usr)
	var/mob/living/target = user
	target.apply_status_effect(/datum/status_effect/buff/duration_modification/bladeward5e)
	user.visible_message("<span class='info'>[user] traces a warding sigil in the air.</span>", "<span class='notice'>I trace a a sigil of warding in the air.</span>")

	return TRUE

/datum/status_effect/buff/duration_modification/bladeward5e
	id = "blade ward"
	alert_type = /atom/movable/screen/alert/status_effect/buff/bladeward5e
	effectedstats = list("constitution" = 3)
	duration = 20 SECONDS
	var/static/mutable_appearance/ward = mutable_appearance('icons/effects/beam.dmi', "purple_lightning", -MUTATIONS_LAYER)

/atom/movable/screen/alert/status_effect/buff/bladeward5e
	name = "Blade Ward"
	desc = "I am resistant to damage."
	icon_state = "buff"

/datum/status_effect/buff/duration_modification/bladeward5e/on_apply()
	. = ..()
	var/mob/living/target = owner
	target.add_overlay(ward)
	target.update_vision_cone()

/datum/status_effect/buff/duration_modification/bladeward5e/on_remove()
	var/mob/living/target = owner
	target.cut_overlay(ward)
	target.update_vision_cone()
	. = ..()

/obj/effect/proc_holder/spell/self/bladeward5e/test
	antimagic_allowed = TRUE
