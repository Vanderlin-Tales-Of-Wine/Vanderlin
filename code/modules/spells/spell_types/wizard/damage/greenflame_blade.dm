/obj/effect/proc_holder/spell/invoked/greenflameblade5e
	name = "Green-Flame Blade"
	desc = "An attack that burns all in an aoe around your target."
	overlay_state = "null"
	releasedrain = 50
	chargetime = 3
	recharge_time = 10 SECONDS
	//chargetime = 10
	//recharge_time = 30 SECONDS
	range = 6
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	miracle = FALSE

	overlay_state = "enchant_weapon"
	invocation = "Green flame blade!"
	invocation_type = "shout" //can be none, whisper, emote and shout

	attunements = list(
		/datum/attunement/fire = 0.3,
	)

/obj/effect/proc_holder/spell/invoked/greenflameblade5e/set_attuned_strength(list/incoming_attunements)
	var/total_value = 1
	for(var/datum/attunement/attunement as anything in attunements)
		if(!(attunement in incoming_attunements))
			continue
		total_value += incoming_attunements[attunement] * attunements[attunement]
	attuned_strength = total_value
	attuned_strength = max(attuned_strength, 0.5)
	return


/obj/effect/proc_holder/spell/invoked/greenflameblade5e/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/carbon/target = targets[1]
		var/obj/item/held_item = target.get_active_held_item() //get held item
		held_item.AddComponent(/datum/component/enchanted_weapon, 5 MINUTES * attuned_strength, TRUE, /datum/skill/magic/arcane, user, SEARING_BLADE_ENCHANT)
	return FALSE

/obj/effect/temp_visual/greenflameblade5e
	icon = 'icons/effects/fire.dmi'
	icon_state = "1"
	name = "green-flame"
	desc = "Magical fire. Interesting."
	randomdir = FALSE
	duration = 1 SECONDS
	layer = ABOVE_ALL_MOB_LAYER
