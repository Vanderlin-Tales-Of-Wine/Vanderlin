/datum/action/cooldown/spell/projectile/moonlit_dagger
	name = "Moonlit Dagger"
	desc = "Fire off a piercing moonlit-dagger, smiting unholy creechers!"
	button_icon_state = "moondagger"
	sound = 'sound/misc/area.ogg'
	sound_loop = /datum/looping_sound/invokeholy

	spell_flags = SPELL_MIRACLE
	antimagic_flags = MAGIC_RESISTANCE_HOLY
	associated_skill = /datum/skill/magic/holy
	required_items = list(/obj/item/clothing/neck/psycross/noc)

	invocation = "Begone foul beasts!"
	invocation_type = INVOCATION_SHOUT

	charge_time = 3 SECONDS
	charge_drain = 1
	charge_slowdown = 1
	cooldown_time = 40 SECONDS
	spell_cost = 40

	projectile_type = /obj/projectile/magic/moondagger

/obj/projectile/magic/moondagger
	name = "moondagger"
	icon_state = "moondagger"
	nodamage = FALSE
	damage_type = BRUTE
	damage = DAMAGE_DAGGER * 1.5
	range = 7

/obj/projectile/magic/moondagger/on_hit(mob/living/carbon/human/target, blocked = FALSE)
	. = ..()
	if(!ishuman(target))
		return

	var/datum/antagonist/werewolf/wolf_datum = target.mind?.has_antag_datum(/datum/antagonist/werewolf/)
	var/datum/antagonist/vampire/sucker_datum = target.mind?.has_antag_datum(/datum/antagonist/vampire/)
	if(istype(sucker_datum, /datum/antagonist/vampire/lord))
		var/datum/antagonist/vampire/lord/sucker_lord = sucker_datum //I am very mature
		if(sucker_lord.ascended >= 4)
			target.visible_message(span_danger("\The [src] fails to affect [target]!"), span_userdanger("Feeble metal cannot hurt me, I AM THE ANCIENT!"))
			return

	if(wolf_datum?.transformed || sucker_datum)
		target.visible_message(span_danger("\The [src] weakens [target]'s curse temporarily!"), span_userdanger("I'm hit by my BANE!"))
		target.apply_status_effect(/datum/status_effect/debuff/silver_curse)
