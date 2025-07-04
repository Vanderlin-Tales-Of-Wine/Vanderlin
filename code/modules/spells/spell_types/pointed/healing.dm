/datum/action/cooldown/spell/healing
	name = "Miracle"
	button_icon_state = "lesserheal"
	sound = 'sound/magic/heal.ogg'
	sound_loop = /datum/looping_sound/invokeholy

	cast_range = 3
	spell_flags = SPELL_MIRACLE
	antimagic_flags = MAGIC_RESISTANCE_HOLY
	associated_skill = /datum/skill/magic/holy
	required_items = list(/obj/item/clothing/neck/psycross)

	charge_time = 1 SECONDS
	charge_slowdown = 1
	cooldown_time = 20 SECONDS
	spell_cost = 25

	/// Base healing before adjustments
	var/base_healing = 25
	/// Wound healing modifier
	var/wound_modifier = 0.25
	/// Blood healing amount
	var/blood_restoration = BLOOD_VOLUME_SURVIVE / 2
	/// Stuns undead
	var/stun_undead = FALSE

/datum/action/cooldown/spell/healing/is_valid_target(atom/cast_on)
	return isliving(cast_on)

/datum/action/cooldown/spell/healing/cast(mob/living/cast_on)
	. = ..()
	if(HAS_TRAIT(cast_on, TRAIT_ASTRATA_CURSE))
		cast_on.visible_message(span_danger("[cast_on] recoils in pain!"), span_userdanger("Divine healing shuns me!"))
		cast_on.cursed_freak_out()
		return
	if(cast_on.mob_biotypes & MOB_UNDEAD) //positive energy harms the undead
		cast_on.visible_message(span_danger("[cast_on] is burned by holy light!"), span_userdanger("I'm burned by holy light!"))
		if(stun_undead)
			cast_on.Paralyze(5 SECONDS)
		cast_on.adjustFireLoss(base_healing)
		cast_on.adjust_divine_fire_stacks(1)
		cast_on.IgniteMob()
		return
	if(cast_on.real_name in GLOB.excommunicated_players)
		cast_on.visible_message(
			span_warning("The angry Ten the flesh of [cast_on]! a foolish blasphemer and heretic!"),
			span_notice("I am despised by the Ten, rejected, and they remind me just how unlovable I am with a wave of pain!"),
		)
		cast_on.emote("scream")
		cast_on.adjustFireLoss(base_healing)
		return

	var/conditional_buff = FALSE
	var/situational_bonus = 10
	//this if chain is stupid, replace with variables on /datum/patron when possible?
	if(isliving(owner))
		var/mob/living/living_owner = owner
		switch(living_owner.patron?.type)
			if(/datum/patron/psydon)
				cast_on.visible_message(span_info("A strange stirring feeling pours from [cast_on]!"), span_notice("Sentimental thoughts drive away my pains!"))
			if(/datum/patron/divine/astrata)
				cast_on.visible_message(span_info("A wreath of gentle light passes over [cast_on]!"), span_notice("I'm bathed in holy light!"))
				// during the day, heal 10 more (basic as fuck)
				if(GLOB.tod == "day")
					conditional_buff = TRUE
			if(/datum/patron/divine/noc)
				cast_on.visible_message(span_info("A shroud of soft moonlight falls upon [cast_on]!"), span_notice("I'm shrouded in gentle moonlight!"))
				// during the night, heal 10 more (i wish this was more interesting but they're twins so whatever)
				if(GLOB.tod == "night")
					conditional_buff = TRUE
			if(/datum/patron/divine/dendor)
				cast_on.visible_message(span_info("A rush of primal energy spirals about [cast_on]!"), span_notice("I'm infused with primal energies!"))
				var/static/list/natural_stuff = list(/obj/structure/flora/grass, /obj/structure/flora/tree, /obj/structure/flora/shroom_tree, /obj/structure/fluff/clodpile)
				situational_bonus = 0
				// the more natural stuff around US, the more we heal
				for(var/obj/O in oview(5, owner))
					if(O in natural_stuff)
						situational_bonus = min(situational_bonus + 1, 25)
				if(situational_bonus > 0)
					conditional_buff = TRUE
			if(/datum/patron/divine/abyssor)
				cast_on.visible_message(span_info("A mist of salt-scented vapour settles on [cast_on]!"), span_notice("I'm invigorated by healing vapours!"))
				// if our owner or cast_on is standing in water, heal a flat amount extra
				if(istype(get_turf(cast_on), /turf/open/water) || istype(get_turf(owner), /turf/open/water))
					conditional_buff = TRUE
					situational_bonus = 15
			if(/datum/patron/divine/ravox)
				cast_on.visible_message(span_info("An air of righteous defiance rises near [cast_on]!"), span_notice("I'm filled with an urge to fight on!"))
				situational_bonus = 0
				// the bloodier the area around our cast_on is, the more we heal
				for(var/obj/effect/decal/cleanable/blood/O in oview(5, cast_on))
					situational_bonus = min(situational_bonus + 1, 25)
				conditional_buff = TRUE
			if(/datum/patron/divine/necra)
				cast_on.visible_message(span_info("A sense of quiet respite radiates from [cast_on]!"), span_notice("I feel the Undermaiden's gaze turn from me for now!"))
				if (iscarbon(cast_on))
					var/mob/living/carbon/C = cast_on
					// if the cast_on is "close to death" (at or below 25% health)
					if (C.health <= (C.maxHealth * 0.25))
						conditional_buff = TRUE
						situational_bonus = 25
			if(/datum/patron/divine/xylix)
				cast_on.visible_message(span_info("A fugue seems to manifest briefly across [cast_on]!"), span_notice("My wounds vanish as if they had never been there! "))
				// half of the time, heal a little (or a lot) more - flip the coin
				if (prob(50))
					conditional_buff = TRUE
					situational_bonus = rand(1, 25)
			if(/datum/patron/divine/pestra)
				cast_on.visible_message(span_info("An aura of clinical care encompasses [cast_on]!"), span_notice("I'm sewn back together by sacred medicine!"))
				// pestra always heals a little more toxin damage and restores a bit more blood
				cast_on.adjustToxLoss(-situational_bonus)
				cast_on.blood_volume += BLOOD_VOLUME_SURVIVE/2
			if(/datum/patron/divine/malum)
				cast_on.visible_message(span_info("A tempering heat is discharged out of [cast_on]!"), span_notice("I feel the heat of a forge soothing my pains!"))
				// var/list/firey_stuff = list(/obj/machinery/light/fueled/torchholder, /obj/machinery/light/fueled/campfire, /obj/machinery/light/fueled/hearth, /obj/machinery/light/fueled/wallfire, /obj/machinery/light/fueled/wallfire/candle, /obj/machinery/light/fueled/forge, /obj/machinery/light/fueled/firebowl/stump)
				// extra healing for every source of fire/light near us
				situational_bonus = 0
				for (var/obj/machinery/light/fueled/O in oview(5, owner))
					if(!O.on)
						continue
					situational_bonus = min(situational_bonus + 3, 25)
				if (situational_bonus > 0)
					conditional_buff = TRUE
			if(/datum/patron/divine/eora)
				cast_on.visible_message(span_info("An eminence of love blossoms around [cast_on]!"), span_notice("I'm filled with the restorative warmth of love!"))
				// if they're wearing an eoran bud (or are a pacifist), pretty much double the healing.
				situational_bonus = 0
				if (HAS_TRAIT(cast_on, TRAIT_PACIFISM))
					conditional_buff = TRUE
					situational_bonus = 25
			if(/datum/patron/inhumen/zizo)
				cast_on.visible_message(span_info("Vital energies are sapped towards [cast_on]!"), span_notice("The life around me pales as I am restored!"))
				// set up a ritual pile of bones (or just cast near a stack of bones whatever) around us for massive bonuses, cap at 50 for 75 healing total (wowie)
				situational_bonus = 0
				for (var/obj/item/alch/bone/O in oview(5, owner))
					situational_bonus = min(situational_bonus + 5, 50)
				if (situational_bonus > 0)
					conditional_buff = TRUE
			if(/datum/patron/inhumen/graggar)
				cast_on.visible_message(span_info("Foul fumes billow outward as [cast_on] is restored!"), span_notice("A noxious scent burns my nostrils, but I feel better!"))
				// if you've got lingering toxin damage, you get healed more, but your bonus healing doesn't affect toxin
				var/toxloss = cast_on.getToxLoss()
				if (toxloss >= 10)
					conditional_buff = TRUE
					situational_bonus = 25
					cast_on.adjustToxLoss(situational_bonus) // remember we do a global toxloss adjust down below so this is okay
			if(/datum/patron/inhumen/matthios)
				cast_on.visible_message(span_info("A wreath of... strange light passes over [cast_on]?"), span_notice("I'm bathed in a... strange holy light?"))
				// COMRADES! WE MUST BAND TOGETHER!
				if (HAS_TRAIT(cast_on, TRAIT_BANDITCAMP))
					conditional_buff = TRUE
					situational_bonus = 25
			if(/datum/patron/godless)
				cast_on.visible_message(span_info("No Gods answer these prayers."), span_notice("No Gods answer these prayers."))
				return
			else
				cast_on.visible_message(span_info("A choral sound comes from above and [cast_on] is healed!"), span_notice("I am bathed in healing choral hymns!"))

	if(conditional_buff)
		to_chat(owner, span_greentext("Channeling my patron's power is easier in these conditions!"))
		base_healing += situational_bonus

	cast_on.adjustToxLoss(-base_healing)
	cast_on.adjustOxyLoss(-base_healing)
	cast_on.blood_volume += blood_restoration
	if(!iscarbon(cast_on))
		cast_on.adjustBruteLoss(-base_healing)
		cast_on.adjustFireLoss(-base_healing)
		return

	var/mob/living/carbon/C = cast_on
	var/obj/item/bodypart/affecting = C.get_bodypart(check_zone(owner.zone_selected))
	if(affecting)
		affecting.heal_damage(base_healing, base_healing)
		affecting.heal_wounds(base_healing * wound_modifier)
		C.update_damage_overlays()

// For churchlings or something idk
/datum/action/cooldown/spell/healing/lesser
	name = "Lesser Miracle"

	cast_range = 2

	cooldown_time = 30 SECONDS
	spell_cost = 30

	base_healing = 20
	wound_modifier = 0.4
	blood_restoration = 0

/datum/action/cooldown/spell/healing/greater
	name = "Greater Miracle"
	button_icon_state = "astrata"

	cast_range = 4

	charge_time = 1 SECONDS
	charge_slowdown = 1
	cooldown_time = 25 SECONDS
	spell_cost = 45

	base_healing = 50
	wound_modifier = 0.5
	blood_restoration = BLOOD_VOLUME_SURVIVE
	stun_undead = TRUE
