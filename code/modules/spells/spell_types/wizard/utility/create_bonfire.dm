/obj/effect/proc_holder/spell/aoe_turf/conjure/createbonfire5e
	name = "Create Bonfire"
	desc = "Creates a magical bonfire to cook on."
	range = 0
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
	antimagic_allowed = FALSE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	miracle = FALSE

	invocation = "Bonfire!"
	invocation_type = "shout"

	summon_type = list(
		/obj/machinery/light/fueled/campfire/createbonfire5e
	)
	summon_lifespan = 15 MINUTES
	summon_amt = 1

	action_icon_state = "the_traps"
	attunements = list(
		/datum/attunement/fire = 0.3,
	)

	overlay_state = "create_campfire"

/obj/machinery/light/fueled/campfire/createbonfire5e
	name = "magical bonfire"
	icon_state = "churchfire1"
	base_state = "churchfire"
	density = FALSE
	layer = 2.8
	brightness = 7
	fueluse = 10 MINUTES
	color = "#6ab2ee"
	bulb_colour = "#6ab2ee"
	max_integrity = 30

/obj/effect/proc_holder/spell/aoe_turf/conjure/createbonfire5e/test
	antimagic_allowed = TRUE
