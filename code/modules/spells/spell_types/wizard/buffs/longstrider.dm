/obj/effect/proc_holder/spell/invoked/longstrider
	name = "Longstrider"
	desc = "Grant yourself and any creatures adjacent to you free movement through rough terrain."
	cost = 1
	school = "transmutation"
	releasedrain = 50
	chargedrain = 0
	chargetime = 4 SECONDS
	recharge_time = 5 MINUTES
	warnie = "spellwarning"
	no_early_release = TRUE
	charging_slowdown = 1
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	attunements = list(
		/datum/attunement/aeromancy = 0.8,
	)
	overlay_state = "longstride"

/obj/effect/proc_holder/spell/invoked/longstrider/cast(list/targets, mob/user = usr)
	. = ..()
	user.visible_message("[user] mutters an incantation and a dim pulse of light radiates out from them.")

	var/duration_increase = min(0, attuned_strength * 2 MINUTES)
	for(var/mob/living/L in range(1, usr))
		L.apply_status_effect(/datum/status_effect/buff/duration_modification/longstrider, duration_increase)

/datum/status_effect/buff/duration_modification/longstrider
	id = "longstrider"
	alert_type = /atom/movable/screen/alert/status_effect/buff/longstrider
	duration = 5 MINUTES

/datum/status_effect/buff/duration_modification/longstrider/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_LONGSTRIDER, MAGIC_TRAIT)

/datum/status_effect/buff/duration_modification/longstrider/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_LONGSTRIDER, MAGIC_TRAIT)

/atom/movable/screen/alert/status_effect/buff/longstrider
	name = "Longstrider"
	desc = span_nicegreen("I can easily walk through rough terrain.")
	icon_state = "buff"
