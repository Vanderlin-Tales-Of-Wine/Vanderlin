/datum/action/cooldown/spell/aoe/churn_undead
	name = "Churn Undead"
	desc = ""
	button_icon_state = "necra"
	sound = 'sound/magic/churn.ogg'

	cast_range = 2
	spell_flags = SPELL_MIRACLE
	antimagic_flags = MAGIC_RESISTANCE_HOLY
	associated_skill = /datum/skill/magic/holy
	required_items = list(/obj/item/clothing/neck/psycross/silver/necra)

	invocation = "The Undermaiden rebukes!"
	invocation_type = INVOCATION_SHOUT

	charge_time = 4 SECONDS
	charge_drain = 1
	charge_slowdown = 2
	cooldown_time = 40 SECONDS
	spell_cost = 60

	aoe_radius = 4

/datum/action/cooldown/spell/aoe/churn_undead/cast_on_thing_in_aoe(atom/victim, atom/caster)
	. = ..()
	if(!isliving(victim))
		return
	var/mob/living/L = victim
	if(L.stat == DEAD)
		return
	if(L.mind)
		if(L.mind.has_antag_datum(/datum/antagonist/vampire/lord))
			L.visible_message(span_warning("[L] overpowers being churned!"), span_greentext("I overpower being churned!"))
			to_chat(owner, span_userdanger("[L] is too strong, I am churned!"))
			if(isliving(owner))
				var/mob/living/fool = owner
				fool.Stun(50)
			owner.throw_at(get_ranged_target_turf(owner, get_dir(owner, L), 7), 7, 1, L, spin = FALSE)
			return
	if((L.mob_biotypes & MOB_UNDEAD))
		var/prob2explode = 10 * owner.get_skill_level(associated_skill)
		if(prob(prob2explode))
			L.visible_message(span_warning("[L] HAS BEEN CHURNED BY NECRA'S GRIP!"), span_userdanger("I'VE BEEN CHURNED BY NECRA'S GRIP!"))
			explosion(get_turf(L), light_impact_range = 1, flash_range = 1, smoke = FALSE)
			L.Stun(50)
		else
			L.visible_message(span_warning("[L] resists being churned!"), span_greentext("I resist being churned!"))
