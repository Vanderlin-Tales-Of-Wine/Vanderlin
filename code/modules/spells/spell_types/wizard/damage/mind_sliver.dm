
/obj/effect/proc_holder/spell/invoked/mindsliver5e
	name = "Mind Sliver"
	desc = "You drive a disorienting spike of psychic energy into the mind of your target. Causing brain damage."
	overlay_state = "null"
	releasedrain = 30
	chargetime = 10
	recharge_time = 15 SECONDS
	range = 6
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	attunements = list(
		/datum/attunement/dark = 0.5,
	)

	miracle = FALSE

	invocation = "Steal their thoughts!"
	invocation_type = "shout" //can be none, whisper, emote and shout
	var/delay = 7


/obj/effect/proc_holder/spell/invoked/mindsliver5e/cast(list/targets, mob/user)
	var/turf/T = get_turf(targets[1])
	new /obj/effect/temp_visual/mindsliver5e_p1(T)
	sleep(delay)
	new /obj/effect/temp_visual/mindsliver5e_p2(T)
	playsound(T,'sound/magic/charged.ogg', 80, TRUE)
	for(var/mob/living/L in T.contents)
		var/obj/item/organ/brain/brain = L.getorganslot(ORGAN_SLOT_BRAIN)
		brain.applyOrganDamage((brain.maxHealth/8))
		playsound(T, "genslash", 80, TRUE)
		to_chat(L, "<span class='userdanger'>Psychic energy is driven into my skull!!</span>")
	return TRUE

/obj/effect/temp_visual/mindsliver5e_p1
	icon = 'icons/effects/effects.dmi'
	icon_state = "bluestream_fade"
	name = "rippeling psionic energy"
	desc = "Get out of the way!"
	light_outer_range = 2
	duration = 7
	layer = ABOVE_ALL_MOB_LAYER //this doesnt render above mobs? it really should

/obj/effect/temp_visual/mindsliver5e_p2
	icon = 'icons/effects/effects.dmi'
	icon_state = "rift"

	randomdir = FALSE
	duration = 1 SECONDS
	layer = ABOVE_ALL_MOB_LAYER
