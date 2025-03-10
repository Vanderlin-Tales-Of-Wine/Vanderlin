#define BLESSINGOFLIGHT_FILTER "bol_glow"

/obj/effect/proc_holder/spell/targeted/touch/orison
	name = "Orison"
	overlay_state = "thaumaturgy"
	desc = "The basic precept of holy magic orients around the power of prayer and soliciting a Divine Patron for a tiny sliver of Their might."
	clothes_req = FALSE
	drawmessage = "I calm my mind and prepare to draw upon an orison."
	dropmessage = "I return my mind to the now."
	school = "transmutation"
	chargedrain = 0
	chargetime = 0
	releasedrain = 5
	miracle = TRUE
	devotion_cost = 5
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/holy
	hand_path = /obj/item/melee/touch_attack/orison

/obj/item/melee/touch_attack/orison
	name = "\improper lesser prayer"
	desc = "The fundamental teachings of theology return to you:\n \
		<b>Fill</b>: Beseech your Divine to create a small quantity of holy water in a container that you touch for some devotion.\n \
		<b>Touch</b>: Direct a sliver of divine thaumaturgy into your being, causing your voice to become LOUD when you next speak. Can be used on light sources at range, and it will cause them flicker.\n \
		<b>Use</b>: Issue a prayer for illumination, causing you or another living creature to begin glowing with light for five minutes - this stacks each time you cast it, with no upper limit. Using thaumaturgy on a person will remove this blessing from them, and MMB on your praying hand will remove any light blessings from yourself."
	catchphrase = null
	possible_item_intents = list(/datum/intent/fill, INTENT_HELP, /datum/intent/use)
	icon = 'icons/mob/roguehudgrabs.dmi'
	icon_state = "pulling"
	icon_state = "grabbing_greyscale"
	color = "#FFFFFF"
	var/xp_interval = 150
	var/xp_cooldown = 0
	var/right_click = FALSE
	var/thaumaturgy_devotion = 10
	var/light_devotion = 5
	var/water_moisten = 2

/obj/item/melee/touch_attack/orison/attack_self()
	qdel(src)

/obj/item/melee/touch_attack/orison/proc/handle_xp(mob/living/carbon/human/user, fatigue, ignore_cooldown = FALSE)
	if (!ignore_cooldown)
		if (world.time < xp_cooldown + xp_interval)
			return

	xp_cooldown = world.time

	var/obj/effect/proc_holder/spell/targeted/touch/orison/base_spell = attached_spell
	if (user)
		var/skill_level = user.mind?.get_skill_level(attached_spell.associated_skill)
		if (skill_level <= SKILL_LEVEL_EXPERT)
			adjust_experience(user, base_spell.associated_skill, fatigue+attached_spell.devotion_cost)

/obj/item/melee/touch_attack/orison/MiddleClick(mob/living/user, params)
	. = ..()
	if (user.has_status_effect(/datum/status_effect/light_buff))
		user.remove_status_effect(/datum/status_effect/light_buff)
		user.visible_message(span_notice("[user] closes [user.p_their()] eyes, and the holy light surrounding them retreats into their chest and disappears."), span_notice("I relinquish the gift of [user.patron.name]'s light."))
		return

/obj/item/melee/touch_attack/orison/afterattack(atom/target, mob/living/carbon/human/user, proximity)
	var/fatigue_used
	switch (user.used_intent.type)
		if (/datum/intent/fill)
			fatigue_used = create_water(target, user)
			if (fatigue_used)
				handle_xp(user, fatigue_used)
				qdel(src)
		if (INTENT_HELP)
			fatigue_used = thaumaturgy(target, user)
			if (fatigue_used)
				handle_xp(user, fatigue_used)
				user.cleric?.update_devotion(-fatigue_used)
				qdel(src)
		if (/datum/intent/use)
			fatigue_used = cast_light(target, user)
			if (fatigue_used)
				handle_xp(user, fatigue_used)
				user.cleric?.update_devotion(-fatigue_used)
				qdel(src)

/atom/movable/screen/alert/status_effect/light_buff
	name = "Miraculous Light"
	desc = "A blessing of light wards off the darkness surrounding me."
	icon_state = "stressvg"

/datum/status_effect/light_buff
	id = "orison_light_buff"
	alert_type = /atom/movable/screen/alert/status_effect/light_buff
	duration = 5 MINUTES
	status_type = STATUS_EFFECT_REFRESH
	examine_text = "SUBJECTPRONOUN is surrounded by an aura of gentle light."
	var/potency = 1
	var/outline_colour = "#f5edda"
	var/list/mobs_affected

/datum/status_effect/light_buff/on_creation(mob/living/new_owner, light_power)
	potency = light_power
	return ..()

/datum/status_effect/light_buff/refresh()
	// stack this up as much as we can be bothered to cast it
	duration += initial(duration)

/datum/status_effect/light_buff/on_apply()
	to_chat(owner, span_notice("Light blossoms into being around me!"))
	var/filter = owner.get_filter(BLESSINGOFLIGHT_FILTER)
	if (!filter)
		owner.add_filter(BLESSINGOFLIGHT_FILTER, 2, list("type" = "outline", "color" = outline_colour, "alpha" = 60, "size" = 1))
	add_light(owner)
	return TRUE

/datum/status_effect/light_buff/proc/add_light(mob/living/source)
	var/obj/effect/dummy/lighting_obj/moblight/mob_light_obj = source.mob_light(_power = potency)
	LAZYSET(mobs_affected, source, mob_light_obj)
	RegisterSignal(source, COMSIG_PARENT_QDELETING, PROC_REF(on_living_holder_deletion))

/datum/status_effect/light_buff/proc/remove_light(mob/living/source)
	UnregisterSignal(source, COMSIG_PARENT_QDELETING)
	var/obj/effect/dummy/lighting_obj/moblight/mob_light_obj = LAZYACCESS(mobs_affected, source)
	LAZYREMOVE(mobs_affected, source)
	if(mob_light_obj)
		qdel(mob_light_obj)

/datum/status_effect/light_buff/proc/on_living_holder_deletion(mob/living/M)
	remove_light(M)

/datum/status_effect/light_buff/on_remove()
	to_chat(owner, span_notice("The miraculous light surrounding me has fled..."))
	owner.remove_filter(BLESSINGOFLIGHT_FILTER)
	remove_light(owner)

/obj/item/melee/touch_attack/orison/proc/cast_light(atom/thing, mob/living/carbon/human/user)
	var/holy_skill = user.mind?.get_skill_level(attached_spell.associated_skill)
	var/cast_time = 35 - (holy_skill * 3)
	if (!thing.Adjacent(user))
		to_chat(user, span_info("I need to be next to [thing] to channel a blessing of light!"))
		return

	if (isliving(thing))

		if (thing != user)
			user.visible_message(span_notice("[user] reaches gently towards [thing], beads of light glimmering at [user.p_their()] fingertips..."), span_notice("Blessed [user.patron.name], I ask but for a light to guide the way..."))
		else
			user.visible_message(span_notice("[user] closes [user.p_their()] eyes and places a glowing hand upon [user.p_their()] chest..."), span_notice("Blessed [user.patron.name], I ask but for a light to guide the way..."))

		if(do_after(user, cast_time, thing))
			var/mob/living/living_thing = thing
			var/light_power = clamp(4 + (holy_skill - 3), 4, 7)

			if (living_thing.has_status_effect(/datum/status_effect/light_buff))
				user.visible_message(span_notice("The holy light emanating from [living_thing] becomes brighter!"), span_notice("I feed further devotion into [living_thing]'s blessing of light."))
			else
				user.visible_message(span_notice("A gentle illumination suddenly blossoms into being around [living_thing]!"), span_notice("I grant [living_thing] a blessing of light."))

			living_thing.apply_status_effect(/datum/status_effect/light_buff, light_power)

			return light_devotion
	else
		to_chat(user, span_notice("Only living creachers can bear the blessing of [user.patron.name]'s light."))
		return

/atom/movable/screen/alert/status_effect/thaumaturgy
	name = "Thaumaturgical Voice"
	desc = "The power of my god will make the next thing I say much louder!"
	icon_state = "stressvg"

/datum/status_effect/thaumaturgy
	id = "thaumaturgy"
	alert_type = /atom/movable/screen/alert/status_effect/thaumaturgy
	duration = 30 SECONDS

/datum/status_effect/thaumaturgy/on_creation(mob/living/new_owner)
	. = ..()
	if(!.)
		return
	RegisterSignal(new_owner, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/datum/status_effect/thaumaturgy/on_remove(mob/living/new_owner)
	. = ..()
	UnregisterSignal(new_owner, COMSIG_MOB_SAY)

/datum/status_effect/thaumaturgy/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER
	speech_args[SPEECH_SPANS] |= list(SPAN_REALLYBIG)
	UnregisterSignal(owner, COMSIG_MOB_SAY)
	owner.remove_status_effect(/datum/status_effect/thaumaturgy)

/obj/item/melee/touch_attack/orison/proc/thaumaturgy(thing, mob/living/carbon/human/user)
	var/holy_skill = user.mind?.get_skill_level(attached_spell.associated_skill)
	if (thing == user)
		// give us a buff that makes our next spoken thing really loud and also cause any linked, un-muted scom to shriek out the phrase at a 15% chance
		var/cast_time = 50 - (holy_skill * 5)
		user.visible_message(span_notice("[user] lowers [user.p_their()] head solemnly, whispered prayers spilling from [user.p_their()] lips..."), span_notice("O holy [user.patron.name], share unto me a sliver of your power..."))

		if (!user.has_status_effect(/datum/status_effect/thaumaturgy))
			if(do_after(user, cast_time))
				user.apply_status_effect(/datum/status_effect/thaumaturgy)
				user.visible_message(span_notice("[user] throws open [user.p_their()] eyes, suddenly emboldened!"), span_notice("A feeling of power wells up in my throat: speak, and many will hear!"))
				return thaumaturgy_devotion
		else
			to_chat(user, span_notice("I'm already empowered with divine thaumaturgy!"))
			return
	else
		// make a light source flicker, and others around it within a radius
		if (istype(thing, /obj/machinery/light) || istype(thing, /obj/item/flashlight))
			for (var/obj/maybe_light in view(3 + holy_skill, thing))
				if (istype(maybe_light, /obj/machinery/light))
					var/obj/machinery/light/other_light = maybe_light
					other_light.flicker(holy_skill * 5)
					user.cleric?.update_devotion(-1)
				else if (istype(maybe_light, /obj/item/flashlight/flare))
					var/obj/item/flashlight/flare/mobile_light = maybe_light
					if (mobile_light.on)
						mobile_light.turn_off()
						user.cleric?.update_devotion(-1)

			to_chat(user, span_notice("I direct the weight of my faith towards nearby flames, causing them to flicker!"))

			return thaumaturgy_devotion
		else if (isturf(thing))

			var/did_flicker = FALSE
			for (var/obj/machinery/light/other_lights in view(3 + holy_skill, thing))
				other_lights.flicker(holy_skill * 5)
				user.cleric?.update_devotion(-1)
				did_flicker = TRUE

			if (did_flicker)
				to_chat(user, span_notice("I direct the weight of my faith towards nearby flames, causing them to flicker!"))

				return thaumaturgy_devotion
			else
				to_chat(user, span_notice("My faith finds no flames to show its passage..."))
				qdel(src)
		else if (isliving(thing))

			var/mob/living/living_thing = thing
			if (living_thing.has_status_effect(/datum/status_effect/light_buff))
				living_thing.remove_status_effect(/datum/status_effect/light_buff)
				user.visible_message(span_notice("[user] issues a reserved gesture towards [living_thing], and the holy light leaves [living_thing.p_them()]."), span_notice("I gesture towards [living_thing], and [living_thing.p_their()] blessing of light recedes."))
				return
			else
				to_chat(user, span_notice("My divine thaumaturgy can only augment my own voice, or dismiss the blessing of light on others."))
				return
		else
			to_chat(user, span_warning("I can only direct thaumaturgical prayers towards myself, the ground, and any nearby light sources."))
			return

/datum/reagent/water/blessed
	name = "blessed water"
	description = "A gift of Devotion. Very slightly heals wounds."

/datum/reagent/water/blessed/on_mob_life(mob/living/carbon/M)
	. = ..()
	if (M.mob_biotypes & MOB_UNDEAD)
		M.adjustFireLoss(0.5*REM)
	else
		M.adjustBruteLoss(-0.1*REM)
		M.adjustFireLoss(-0.1*REM)
		M.adjustOxyLoss(-0.1, 0)
		var/list/our_wounds = M.get_wounds()
		if (LAZYLEN(our_wounds))
			var/upd = M.heal_wounds(1)
			if (upd)
				M.update_damage_overlays()

/datum/reagent/water/blessed/reaction_mob(mob/living/M, method=TOUCH, reac_volume)
	if (!istype(M))
		return ..()

	if (method == TOUCH)
		if (M.mob_biotypes & MOB_UNDEAD)
			M.adjustFireLoss(2*reac_volume, 0)
			M.visible_message(span_warning("[M] erupts into angry fizzling and hissing!"), span_warning("BLESSED WATER!!! IT BURNS!!!"))
			M.emote("scream")

	return ..()

/datum/reagent/water/cursed
	name = "cursed water"
	description = "A gift of Devotion. Very slightly heals wounds of the dead and the enlightened."

/datum/reagent/water/cursed/on_mob_life(mob/living/carbon/M)
	. = ..()
	if((M.mob_biotypes & MOB_UNDEAD))
		M.adjustBruteLoss(-0.1*REM)
		M.adjustFireLoss(-0.1*REM)
		M.adjustOxyLoss(-0.1, 0)
		var/list/our_wounds = M.get_wounds()
		if (LAZYLEN(our_wounds))
			var/upd = M.heal_wounds(1)
			if (upd)
				M.update_damage_overlays()
	else
		M.adjustBruteLoss(-0.1*REM)
		M.adjustFireLoss(-0.1*REM)
		M.adjustOxyLoss(-0.1, 0)
		var/list/our_wounds = M.get_wounds()
		if (LAZYLEN(our_wounds))
			var/upd = M.heal_wounds(1)
			if (upd)
				M.update_damage_overlays()
		M.adjust_stamina(0.5*REM)

/obj/item/melee/touch_attack/orison/proc/create_water(atom/thing, mob/living/carbon/human/user)
	// normally we wouldn't use fatigue here to keep in line w/ other holy magic, but we have to since water is a persistent resource
	if (!thing.Adjacent(user))
		to_chat(user, span_info("I need to be closer to [thing] in order to try filling it with water."))
		return

	if (thing.is_refillable())
		if (thing.reagents.holder_full())
			to_chat(user, span_warning("[thing] is full."))
			return

		user.visible_message(span_info("[user] closes [user.p_their()] eyes in prayer and extends a hand over [thing] as water begins to stream from [user.p_their()] fingertips..."), span_notice("I utter forth a plea to [user.patron.name] for succour, and hold my hand out above [thing]..."))

		var/holy_skill = user.mind?.get_skill_level(attached_spell.associated_skill)
		var/drip_speed = 5.6 SECONDS - (holy_skill * 8)
		var/fatigue_spent = 0
		var/fatigue_used = max(3, holy_skill)
		while(do_after(user, drip_speed, thing))
			if (thing.reagents.holder_full() || (user.cleric.devotion - fatigue_used <= 0))
				break

			var/water_qty = max(1, holy_skill) + 1
			var/list/water_contents = list(/datum/reagent/water/blessed = water_qty)

			var/datum/reagents/reagents_to_add = new()
			reagents_to_add.add_reagent_list(water_contents)
			reagents_to_add.trans_to(thing, reagents_to_add.total_volume, transfered_by = user, method = INGEST)

			fatigue_spent += fatigue_used
			user.adjust_stamina(fatigue_used)
			user.cleric?.update_devotion(-1.0)

			if (prob(80))
				playsound(user, 'sound/items/fillcup.ogg', 55, TRUE)

		return min(50, fatigue_spent)
	else if (istype(thing, /obj/item/natural/cloth))
		// stupid little easter egg here: you can dampen a cloth to clean with it, because prestidigitation also lets you clean things. also a lot cheaper devotion-wise than filling a bucket
		var/obj/item/natural/cloth/the_cloth = thing
		if (!the_cloth.wet)
			var/holy_skill = user.mind?.get_skill_level(attached_spell.associated_skill)
			the_cloth.wet += holy_skill * 5
			user.visible_message(span_info("[user] closes [user.p_their()] eyes in prayer, beads of moisture coalescing in [user.p_their()] hands to moisten [the_cloth]."), span_notice("I utter forth a plea to [user.patron.name] for succour, and will moisture into [the_cloth]. I should be able to clean with it properly now."))
			return water_moisten
	else
		to_chat(user, span_info("I'll need to find a container that can hold water."))

/obj/effect/proc_holder/spell/targeted/touch/orison/lesser
	hand_path = /obj/item/melee/touch_attack/orison/lesser

/obj/item/melee/touch_attack/orison/lesser
	name = "\improper lesser prayer"
	desc = "The fundamental teachings of theology are still foreign to you, but your mind is malleable to the influence of the Ten:\n \
		<b>Fill</b>: Beseech your Divine to create a small quantity of water in a container that you touch for some devotion."
	possible_item_intents = list(/datum/intent/fill)

/obj/item/melee/touch_attack/orison/MiddleClick(mob/living/user, params)
	return

/obj/item/melee/touch_attack/orison/lesser/create_water(atom/thing, mob/living/carbon/human/user)
	// normally we wouldn't use fatigue here to keep in line w/ other holy magic, but we have to since water is a persistent resource
	if (!thing.Adjacent(user))
		to_chat(user, span_info("I need to be closer to [thing] in order to try filling it with water."))
		return

	if (thing.is_refillable())
		if (thing.reagents.holder_full())
			to_chat(user, span_warning("[thing] is full."))
			return

		user.visible_message(span_info("[user] closes [user.p_their()] eyes in prayer and extends a hand over [thing] as water begins to stream from [user.p_their()] fingertips..."), span_notice("I utter forth a plea to [user.patron.name] for succour, and hold my hand out above [thing]..."))

		var/holy_skill = user.mind?.get_skill_level(attached_spell.associated_skill)
		var/drip_speed = 56 - (holy_skill * 8)
		var/fatigue_spent = 0
		var/fatigue_used = max(3, holy_skill)
		while(do_after(user, drip_speed, thing))
			if (thing.reagents.holder_full() || (user.cleric.devotion - fatigue_used <= 0))
				break

			var/water_qty = max(1, holy_skill) + 1
			var/list/water_contents = list(/datum/reagent/water = water_qty)

			var/datum/reagents/reagents_to_add = new()
			reagents_to_add.add_reagent_list(water_contents)
			reagents_to_add.trans_to(thing, reagents_to_add.total_volume, transfered_by = user, method = INGEST)

			fatigue_spent += fatigue_used
			user.adjust_stamina(fatigue_used)
			user.cleric?.update_devotion(-1.0)

			if (prob(80))
				playsound(user, 'sound/items/fillcup.ogg', 55, TRUE)

		return min(50, fatigue_spent)
	else if (istype(thing, /obj/item/natural/cloth))
		// stupid little easter egg here: you can dampen a cloth to clean with it, because prestidigitation also lets you clean things. also a lot cheaper devotion-wise than filling a bucket
		var/obj/item/natural/cloth/the_cloth = thing
		if (!the_cloth.wet)
			var/holy_skill = user.mind?.get_skill_level(attached_spell.associated_skill)
			the_cloth.wet += holy_skill * 5
			user.visible_message(span_info("[user] closes [user.p_their()] eyes in prayer, beads of moisture coalescing in [user.p_their()] hands to moisten [the_cloth]."), span_notice("I utter forth a plea to [user.patron.name] for succour, and will moisture into [the_cloth]. I should be able to clean with it properly now."))
			return water_moisten
	else
		to_chat(user, span_info("I'll need to find a container that can hold water."))

#undef BLESSINGOFLIGHT_FILTER
