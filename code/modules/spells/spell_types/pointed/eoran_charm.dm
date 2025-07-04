/datum/action/cooldown/spell/eoran_charm
	name = "Eoran Charm"
	desc = "Captivate a target and prevent them from moving."
	button_icon_state = "love"
	sound = 'sound/magic/whiteflame.ogg'

	cast_range = 4
	spell_flags = SPELL_MIRACLE
	antimagic_flags = MAGIC_RESISTANCE_HOLY
	associated_skill = /datum/skill/magic/holy
	required_items = list(/obj/item/clothing/neck/psycross/silver/eora)

	invocation = "Experiamur vim amoris!"
	invocation_type = INVOCATION_SHOUT

	charge_time = 6 SECONDS
	charge_drain = 1
	charge_slowdown = 3
	cooldown_time = 2 MINUTES
	spell_cost = 100

/datum/action/cooldown/spell/eoran_charm/is_valid_target(atom/cast_on)
	return isliving(cast_on)

/datum/action/cooldown/spell/eoran_charm/cast(mob/living/cast_on)
	. = ..()
	var/charm_to_public = pick("<b style='color:pink'>[owner] is influenced by the beauty of Eora's follower.</b>", "<b style='color:pink'>[cast_on] stares mesmerized at [owner] and does not move.</b>")
	var/charm_to_target = pick("<b style='color:pink'>Your eyes cannot move away from [owner].</b>", "<b style='color:pink'>You are enchanted by the beauty of the follower of Eora.</b>")
	cast_on.visible_message(span_warning("[charm_to_public]"), span_warning("[charm_to_target]"))
	cast_on.apply_status_effect(/datum/status_effect/eorapacify)
	cast_on.Immobilize(85)
