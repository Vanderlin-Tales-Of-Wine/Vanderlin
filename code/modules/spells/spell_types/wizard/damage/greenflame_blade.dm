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

	invocation = "Green flame blade!"
	invocation_type = "shout" //can be none, whisper, emote and shout

	attunements = list(
		/datum/attunement/fire = 0.3,
	)

/obj/effect/proc_holder/spell/invoked/greenflameblade5e/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/carbon/target = targets[1]
		var/mob/living/L = target
		var/mob/U = user
		var/obj/item/held_item = user.get_active_held_item() //get held item
		var/aoe_range = 1
		if(held_item)
			held_item.melee_attack_chain(U, L)
			L.adjustFireLoss(15) //burn target
			playsound(target, 'sound/items/firesnuff.ogg', 100)
			//burn effect and sound
			for(var/mob/living/M in range(aoe_range, get_turf(target))) //burn non-user mobs in an aoe
				if(!M.anti_magic_check())
					if(M != user)
						M.adjustFireLoss(15) //burn target
						//burn effect and sound
						new /obj/effect/temp_visual/acidsplash5e(get_turf(M))
						playsound(M, 'sound/items/firelight.ogg', 100)
		return TRUE
	return FALSE

/obj/effect/temp_visual/greenflameblade5e
	icon = 'icons/effects/fire.dmi'
	icon_state = "1"
	name = "green-flame"
	desc = "Magical fire. Interesting."
	randomdir = FALSE
	duration = 1 SECONDS
	layer = ABOVE_ALL_MOB_LAYER
