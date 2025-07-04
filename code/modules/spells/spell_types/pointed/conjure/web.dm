/datum/action/cooldown/spell/conjure/web
	name = "Conjure Web"
	desc = "Create a small web to block foes."

	sound = 'sound/magic/webspin.ogg'

	charge_time = 4 SECONDS
	charge_drain = 3
	cooldown_time = 60 SECONDS
	spell_cost = 40

	summon_type = list(/obj/structure/spider/stickyweb)
	summon_radius = 3
	summon_amount = 0

	attunements = list(
		/datum/attunement/death = 0.3,
	)
