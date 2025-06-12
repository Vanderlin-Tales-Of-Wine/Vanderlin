/obj/effect/proc_holder/spell/invoked/poisonspray5e
	name = "Poison Cloud" //renamed to better reflect wtf this does -- vide
	desc = "Hold a container in your hand, it's contents turn into a 3-radius smoke"
	overlay_state = "null"
	releasedrain = 50
	chargetime = 3
	recharge_time = 20 SECONDS
	//chargetime = 10
	//recharge_time = 30 SECONDS
	range = 6
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	antimagic_allowed = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy
	cost = 1

	attunements = list(
		/datum/attunement/blood = 0.3,
		/datum/attunement/death = 0.3,
	)

	miracle = FALSE

	overlay_state = "aerosolize"
	invocation = "Poison Cloud!"
	invocation_type = "shout" //can be none, whisper, emote and shout

/obj/effect/proc_holder/spell/invoked/poisonspray5e/cast(list/targets, mob/living/user)
	var/turf/T = get_turf(targets[1]) //check for turf
	if(T)
		var/obj/item/held_item = user.get_active_held_item() //get held item
		var/obj/item/reagent_containers/con = held_item //get held item
		if(con)
			if(con.spillable)
				if(con.reagents.total_volume > 0)
					var/datum/reagents/R = con.reagents
					var/datum/effect_system/smoke_spread/chem/smoke = new
					smoke.set_up(R, 1, T, FALSE)
					smoke.start()

					user.visible_message(span_warning("[user] sprays the contents of the [held_item], creating a cloud!"), span_warning("You spray the contents of the [held_item], creating a cloud!"))
					con.reagents.clear_reagents() //empty the container
					playsound(user, 'sound/magic/webspin.ogg', 100)
				else
					to_chat(user, "<span class='warning'>The [held_item] is empty!</span>")
					return FALSE
			else
				to_chat(user, "<span class='warning'>I can't get access to the contents of this [held_item]!</span>")
				return FALSE
		else
			to_chat(user, "<span class='warning'>I need to hold a container to cast this!</span>")
			return FALSE
	else
		to_chat(user, "<span class='warning'>I couldn't find a good place for this!</span>")
		return FALSE
	return TRUE

/obj/effect/proc_holder/spell/invoked/poisonspray5e/test
	antimagic_allowed = TRUE
