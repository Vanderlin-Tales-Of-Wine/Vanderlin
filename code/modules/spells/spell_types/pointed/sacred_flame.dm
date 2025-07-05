/datum/action/cooldown/spell/sacred_flame
	name = "Sacred Flame"
	desc = "Burn the target with divine light."
	button_icon_state = "pflower"
	sound = 'sound/magic/heal.ogg'
	sound_loop = /datum/looping_sound/invokeholy

	spell_flags = SPELL_MIRACLE
	antimagic_flags = MAGIC_RESISTANCE_HOLY
	associated_skill = /datum/skill/magic/holy
	required_items = list(/obj/item/clothing/neck/psycross/silver/astrata)

	invocation = "Cleansing flames, kindle!"
	invocation_type = INVOCATION_SHOUT

	charge_time = 3 SECONDS
	charge_drain = 1
	charge_slowdown = 2
	cooldown_time = 20 SECONDS
	spell_cost = 50

	var/stacks_to_add = 3

/datum/action/cooldown/spell/sacred_flame/cast(atom/cast_on)
	. = ..()
	if(!ismob(cast_on))
		if(cast_on.fire_act())
			owner.visible_message(
				"<font color='yellow'>[owner] points at [cast_on], igniting it with sacred flames!</font>",
				"<font color='yellow'>I point at [cast_on], igniting it with sacred flames!</font>",
			)
		else
			owner.visible_message(
				"<font color='yellow'>[owner] points at [cast_on], but it fails to catch fire.</font>",
				"<font color='yellow'>I point at [cast_on], but it fails to catch fire.</font>",
			)
		return
	if(!isliving(cast_on))
		return
	var/mob/living/heretic = cast_on
	owner.visible_message(
		"<font color='yellow'>[owner] points at [heretic]!</font>",
		"<font color='yellow'>I point at [heretic]!</font>",
	)
	playsound(heretic, 'sound/items/flint.ogg', 150, FALSE)
	heretic.adjust_divine_fire_stacks(stacks_to_add)
	heretic.IgniteMob()
