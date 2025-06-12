/obj/effect/proc_holder/spell/invoked/utility
	name = "Utility Spell"
	desc = "A minor utility spell."
	school = "utility"
	releasedrain = 5
	chargedrain = 0
	chargetime = 0
	recharge_time = 30 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	cost = 2
	spell_flag = SPELL_ESSENCE
	uses_mana = TRUE

/obj/effect/proc_holder/spell/invoked/utility/breeze
	name = "Gentle Breeze"
	desc = "Creates a small breeze that can blow out candles or scatter light objects."
	overlay_state = "breeze"
	//sound = 'sound/magic/whiff.ogg'
	range = 3
	attunements = list(/datum/attunement/aeromancy = 0.2)

/obj/effect/proc_holder/spell/invoked/utility/breeze/cast(list/targets, mob/user)
	var/turf/target_turf = get_turf(targets[1])
	if(!target_turf)
		return FALSE

	visible_message(span_notice("[user] gestures, creating a gentle breeze."))
	//playsound(target_turf, 'sound/magic/whiff.ogg', 50, TRUE)

	for(var/obj/item/candle/C in range(1, target_turf))
		if(C.lit)
			C.extinguish()

	for(var/obj/item/I in target_turf)
		if(I.w_class <= WEIGHT_CLASS_SMALL && prob(50))
			step_rand(I)

	return TRUE

/obj/effect/proc_holder/spell/invoked/utility/cleanse
	name = "Cleanse"
	desc = "Removes dirt and minor stains from objects or surfaces."
	overlay_state = "cleanse"
	//sound = 'sound/magic/splash.ogg'
	range = 1
	attunements = list(/datum/attunement/blood)

/obj/effect/proc_holder/spell/invoked/utility/cleanse/cast(list/targets, mob/user)
	var/atom/target = targets[1]
	if(!target)
		return FALSE

	visible_message(span_notice("[user] gestures, creating a cleansing mist around [target]."))
	//playsound(get_turf(target), 'sound/magic/splash.ogg', 50, TRUE)

	target.wash(CLEAN_WASH)

	return TRUE

/obj/effect/proc_holder/spell/invoked/utility/spark
	name = "Spark"
	desc = "Creates a small spark that can light candles or torches."
	overlay_state = "spark"
	sound = 'sound/magic/fireball.ogg'
	range = 1
	attunements = list(/datum/attunement/fire)

/obj/effect/proc_holder/spell/invoked/utility/spark/cast(list/targets, mob/user)
	var/atom/target = targets[1]
	if(!target)
		return FALSE
	target = get_turf(target)

	visible_message(span_notice("[user] creates a small spark near [target]."))
	playsound(get_turf(target), 'sound/magic/fireball.ogg', 30, TRUE)

	for(var/obj/item/item in target.contents)
		if(istype(item, /obj/item/candle))
			var/obj/item/candle/C = item
			if(!C.lit)
				C.light()

		else if(istype(item, /obj/item/flashlight/flare/torch))
			var/obj/item/flashlight/flare/torch/T = item
			if(!T.on)
				T.fuel += 5 MINUTES
				T.fire_act()

	return TRUE

/obj/effect/proc_holder/spell/invoked/utility/mend
	name = "Minor Mend"
	desc = "Repairs minor damage to simple objects."
	overlay_state = "mend"
	//sound = 'sound/magic/staff_healing.ogg'
	range = 1
	attunements = list(/datum/attunement/earth)
	cost = 3

/obj/effect/proc_holder/spell/invoked/utility/mend/cast(list/targets, mob/user)
	var/obj/item/target = targets[1]
	if(!isobj(target))
		return FALSE

	visible_message(span_notice("[user] gestures, mending minor damage to [target]."))
	//playsound(get_turf(target), 'sound/magic/staff_healing.ogg', 50, TRUE)

	// Restore some durability or repair minor damage
	if(target.obj_integrity < target.max_integrity)
		target.obj_integrity = min(target.max_integrity, target.obj_integrity + 10)
		target.update_icon()

	return TRUE

/obj/effect/proc_holder/spell/invoked/utility/chill
	name = "Frost Touch"
	desc = "Creates a small patch of frost that can preserve food or cool drinks."
	overlay_state = "chill"
	//sound = 'sound/magic/whiff.ogg'
	range = 1
	attunements = list(/datum/attunement/ice)

/obj/effect/proc_holder/spell/invoked/utility/chill/cast(list/targets, mob/user)
	var/atom/target = targets[1]
	if(!target)
		return FALSE
	target = get_turf(target)

	visible_message(span_notice("[user] gestures, creating a small patch of frost around [target]."))
	//playsound(get_turf(target), 'sound/magic/whiff.ogg', 50, TRUE)

	// Cool down hot food/drinks and reduce rot buildup on foods
	for(var/obj/item/reagent_containers/item in target.contents)
		item.reagents?.expose_temperature(273) // Set to freezing
		if(istype(item, /obj/item/reagent_containers/food/snacks))
			var/obj/item/reagent_containers/food/snacks/food = item
			food.warming += 5 MINUTES

	return TRUE

/obj/effect/proc_holder/spell/invoked/utility/illuminate
	name = "Illuminate"
	desc = "Creates a small, temporary light source."
	overlay_state = "light"
	//sound = 'sound/magic/staff_healing.ogg'
	range = 0
	attunements = list(/datum/attunement/light)
	cost = 1

/obj/effect/proc_holder/spell/invoked/utility/illuminate/cast(list/targets, mob/user)
	visible_message(span_notice("[user] creates a small orb of light."))
	//playsound(get_turf(user), 'sound/magic/staff_healing.ogg', 30, TRUE)

	// Create temporary light
	var/obj/effect/temp_visual/light_orb/orb = new(get_turf(user))
	orb.set_light(3, 1, "#FFFFFF")
	QDEL_IN(orb, 30 SECONDS)

	return TRUE

/obj/effect/proc_holder/spell/invoked/utility/haste
	name = "Swift Step"
	desc = "Briefly increases movement speed."
	overlay_state = "haste"
	//sound = 'sound/magic/whiff.ogg'
	range = 0
	cost = 4
	attunements = list(/datum/attunement/aeromancy)

/obj/effect/proc_holder/spell/invoked/utility/haste/cast(list/targets, mob/living/user)
	visible_message(span_notice("[user] moves with enhanced speed."))
	//playsound(get_turf(user), 'sound/magic/whiff.ogg', 50, TRUE)

	user.apply_status_effect(/datum/status_effect/buff/duration_modification/haste, 10 SECONDS)

	return TRUE

/obj/effect/proc_holder/spell/invoked/utility/refresh
	name = "Refresh"
	desc = "Removes minor fatigue and restores a small amount of stamina."
	overlay_state = "refresh"
	//sound = 'sound/magic/staff_healing.ogg'
	range = 1
	cost = 3
	attunements = list(/datum/attunement/life)

/obj/effect/proc_holder/spell/invoked/utility/refresh/cast(list/targets, mob/user)
	var/mob/living/target = targets[1]
	if(!istype(target))
		target = user
	visible_message(span_notice("[target] appears refreshed."))
	//playsound(get_turf(user), 'sound/magic/staff_healing.ogg', 50, TRUE)

	target.adjust_stamina(20)
	target.adjust_energy(20)

	return TRUE

// Temporary light effect
/obj/effect/temp_visual/light_orb
	name = "light orb"
	desc = "A small, glowing orb of magical light."
	icon = 'icons/effects/effects.dmi'
	icon_state = "orb"
	duration = 30 SECONDS

// Air Essence Spells
/obj/effect/proc_holder/spell/invoked/utility/air_walk
	name = "Air Walk"
	desc = "Allows brief movement over chasms or gaps by creating temporary air platforms."
	overlay_state = "air_walk"
	range = 0
	cost = 5
	attunements = list(/datum/attunement/aeromancy)

/obj/effect/proc_holder/spell/invoked/utility/air_walk/cast(list/targets, mob/living/user)
	visible_message(span_notice("[user] steps onto solidified air."))
	user.apply_status_effect(/datum/status_effect/buff/air_walking, 15 SECONDS)
	return TRUE

// Water Essence Spells
/obj/effect/proc_holder/spell/invoked/utility/water_breathing
	name = "Water Breathing"
	desc = "Allows breathing underwater for a short duration."
	overlay_state = "water_breathing"
	range = 1
	cost = 4
	attunements = list(/datum/attunement/blood)

/obj/effect/proc_holder/spell/invoked/utility/water_breathing/cast(list/targets, mob/living/user)
	var/mob/living/target = targets[1]
	if(!istype(target))
		target = user
	visible_message(span_notice("[target] gains the ability to breathe underwater."))
	target.apply_status_effect(/datum/status_effect/buff/water_breathing, 60 SECONDS)
	return TRUE

// Fire Essence Spells
/obj/effect/proc_holder/spell/invoked/utility/warmth
	name = "Warmth"
	desc = "Provides resistance to cold and warms the body."
	overlay_state = "warmth"
	range = 1
	cost = 3
	attunements = list(/datum/attunement/fire)

/obj/effect/proc_holder/spell/invoked/utility/warmth/cast(list/targets, mob/living/user)
	var/mob/living/target = targets[1]
	if(!istype(target))
		target = user
	visible_message(span_notice("[target] radiates gentle warmth."))
	target.apply_status_effect(/datum/status_effect/buff/warmth, 120 SECONDS)
	return TRUE

// Earth Essence Spells
/obj/effect/proc_holder/spell/invoked/utility/stone_shape
	name = "Stone Shape"
	desc = "Slightly reshapes stone surfaces or creates small stone implements."
	overlay_state = "stone_shape"
	range = 2
	cost = 4
	attunements = list(/datum/attunement/earth)

/obj/effect/proc_holder/spell/invoked/utility/stone_shape/cast(list/targets, mob/user)
	var/turf/target_turf = get_turf(targets[1])
	if(!target_turf)
		return FALSE
	visible_message(span_notice("[user] shapes the stone with magical force."))

	// Create small stone tools or reshape minor features
	if(prob(30))
		new /obj/item/natural/stone(target_turf)
	return TRUE

// Frost Essence Spells
/obj/effect/proc_holder/spell/invoked/utility/preserve
	name = "Preserve"
	desc = "Prevents food from spoiling and extends its freshness."
	overlay_state = "preserve"
	range = 1
	cost = 2
	attunements = list(/datum/attunement/ice)

/obj/effect/proc_holder/spell/invoked/utility/preserve/cast(list/targets, mob/user)
	var/atom/target = targets[1]
	if(!target)
		return FALSE
	visible_message(span_notice("[user] preserves [target] with frost magic."))

	if(istype(target, /obj/item/reagent_containers/food/snacks))
		var/obj/item/reagent_containers/food/snacks/food = target
		food.warming += 2 HOURS
	return TRUE

// Light Essence Spells
/obj/effect/proc_holder/spell/invoked/utility/daylight
	name = "Daylight"
	desc = "Creates a bright light that mimics natural sunlight."
	overlay_state = "daylight"
	range = 0
	cost = 4
	attunements = list(/datum/attunement/light)

/obj/effect/proc_holder/spell/invoked/utility/daylight/cast(list/targets, mob/user)
	visible_message(span_notice("[user] creates a brilliant daylight orb."))
	var/obj/effect/temp_visual/daylight_orb/orb = new(get_turf(user))
	orb.set_light(5, 2, "#FFFFAA")
	QDEL_IN(orb, 60 SECONDS)
	return TRUE

// Motion Essence Spells
/obj/effect/proc_holder/spell/invoked/utility/phase_step
	name = "Phase Step"
	desc = "Allows brief passage through solid objects."
	overlay_state = "phase_step"
	range = 0
	cost = 6
	attunements = list(/datum/attunement/aeromancy)

/obj/effect/proc_holder/spell/invoked/utility/phase_step/cast(list/targets, mob/living/user)
	visible_message(span_notice("[user] becomes translucent momentarily."))
	user.apply_status_effect(/datum/status_effect/buff/phase_walking, 5 SECONDS)
	return TRUE

// Life Essence Spells
/obj/effect/proc_holder/spell/invoked/utility/vigor
	name = "Vigor"
	desc = "Increases physical strength and endurance temporarily."
	overlay_state = "vigor"
	range = 1
	cost = 4
	attunements = list(/datum/attunement/life)

/obj/effect/proc_holder/spell/invoked/utility/vigor/cast(list/targets, mob/living/user)
	var/mob/living/target = targets[1]
	if(!istype(target))
		target = user
	visible_message(span_notice("[target] appears invigorated."))
	target.apply_status_effect(/datum/status_effect/buff/vigor, 60 SECONDS)
	return TRUE

/obj/effect/proc_holder/spell/invoked/utility/stabilize
	name = "Stabilize"
	desc = "Prevents objects from moving or falling for a short time."
	overlay_state = "stabilize"
	range = 2
	cost = 4
	attunements = list(/datum/attunement/earth)

/obj/effect/proc_holder/spell/invoked/utility/stabilize/cast(list/targets, mob/user)
	var/obj/target = targets[1]
	if(!target)
		return FALSE
	if(!istype(target))
		return FALSE
	if(target.anchored)
		return

	visible_message(span_notice("[user] stabilizes [target] with magical force."))
	target.anchored = TRUE
	addtimer(VARSET_CALLBACK(target, anchored, FALSE), 30 SECONDS)

	return TRUE

/obj/effect/proc_holder/spell/invoked/utility/randomize
	name = "Randomize"
	desc = "Causes minor random effects in the area."
	overlay_state = "randomize"
	range = 2
	cost = 3
	attunements = list(/datum/attunement/fire)

/obj/effect/proc_holder/spell/invoked/utility/randomize/cast(list/targets, mob/user)
	var/turf/target_turf = get_turf(targets[1])
	if(!target_turf)
		return FALSE
	visible_message(span_notice("[user] causes unpredictable magical effects."))

	switch(rand(1, 4))
		if(1)
			for(var/mob/living/M in range(1, target_turf))
				M.adjust_stamina(rand(-10, 10))
		if(2)
			new /obj/effect/temp_visual/cult/sparks(target_turf)
		if(3)
			playsound(target_turf, pick('sound/magic/fireball.ogg'), 30, TRUE)
		if(4)
			target_turf.visible_message(span_notice("The air shimmers with chaotic energy."))
	return TRUE

// Void Essence Spells
/obj/effect/proc_holder/spell/invoked/utility/silence
	name = "Silence"
	desc = "Creates a zone of magical silence that muffles all sounds."
	overlay_state = "silence"
	range = 2
	cost = 4
	attunements = list(/datum/attunement/fire)

/obj/effect/proc_holder/spell/invoked/utility/silence/cast(list/targets, mob/user)
	var/turf/target_turf = get_turf(targets[1])
	if(!target_turf)
		return FALSE
	visible_message(span_notice("[user] creates a zone of absolute silence."))

	var/obj/effect/temp_visual/silence_zone/zone = new(target_turf)
	QDEL_IN(zone, 30 SECONDS)
	return TRUE

// Poison Essence Spells
/obj/effect/proc_holder/spell/invoked/utility/neutralize
	name = "Neutralize"
	desc = "Removes harmful toxins and poisons from objects or creatures."
	overlay_state = "neutralize"
	range = 1
	cost = 4
	attunements = list(/datum/attunement/life)

/obj/effect/proc_holder/spell/invoked/utility/neutralize/cast(list/targets, mob/user)
	var/atom/target = targets[1]
	if(!target)
		return FALSE
	visible_message(span_notice("[user] neutralizes toxins in [target]."))

	if(istype(target, /mob/living))
		var/mob/living/L = target
		L.reagents?.remove_all_type(/datum/reagent/toxin, 5)
	return TRUE

/obj/effect/proc_holder/spell/invoked/utility/detect_poison
	name = "Detect Poison"
	desc = "Reveals the presence of toxins or poisons in nearby objects."
	overlay_state = "detect_poison"
	range = 2
	cost = 2
	attunements = list(/datum/attunement/life)

/obj/effect/proc_holder/spell/invoked/utility/detect_poison/cast(list/targets, mob/user)
	var/turf/target_turf = get_turf(targets[1])
	if(!target_turf)
		return FALSE
	visible_message(span_notice("[user] scans for toxins in the area."))

	var/found_poison = FALSE
	for(var/obj/item/I in range(1, target_turf))
		if(I.reagents && I.reagents.has_reagent(/datum/reagent/toxin))
			I.visible_message(span_warning("[I] glows with a sickly light!"))
			found_poison = TRUE

	if(!found_poison)
		to_chat(user, span_notice("No toxins detected in the area."))
	return TRUE

/obj/effect/proc_holder/spell/invoked/utility/gem_detect
	name = "Gem Detect"
	desc = "Reveals the location of precious stones and crystals nearby."
	overlay_state = "gem_detect"
	range = 3
	cost = 4
	attunements = list(/datum/attunement/earth)

/obj/effect/proc_holder/spell/invoked/utility/gem_detect/cast(list/targets, mob/user)
	var/turf/target_turf = get_turf(targets[1])
	if(!target_turf)
		return FALSE
	visible_message(span_notice("[user] searches for precious stones."))

	var/found_gems = FALSE
	for(var/obj/item/gem/G in range(2, target_turf))
		G.visible_message(span_notice("[G] sparkles briefly!"))
		found_gems = TRUE

	for(var/atom/movable/movable in range(2, target_turf))
		for(var/obj/item/gem/G in movable.contents)
			G.visible_message(span_notice("[G] sparkles briefly!"))
			found_gems = TRUE
		if(isliving(movable))
			for(var/obj/item/gem/G in movable:get_contents())
				G.visible_message(span_notice("[G] sparkles briefly!"))
				found_gems = TRUE

	if(!found_gems)
		to_chat(user, span_notice("No gems detected in the area."))
	return TRUE

/obj/effect/proc_holder/spell/invoked/utility/arcane_mark
	name = "Arcane Mark"
	desc = "Places an invisible magical mark on an object for identification."
	overlay_state = "arcane_mark"
	range = 1
	cost = 2
	attunements = list(/datum/attunement/light)

/obj/effect/proc_holder/spell/invoked/utility/arcane_mark/cast(list/targets, mob/user)
	var/obj/item/target = targets[1]
	if(!isobj(target))
		return FALSE
	visible_message(span_notice("[user] places an arcane mark on [target]."))
	target.desc += " <i>It bears a faint magical mark.</i>"
	return TRUE

// Energia Essence Spells
/obj/effect/proc_holder/spell/invoked/utility/energize
	name = "Energize"
	desc = "Restores energy to magical devices or provides a burst of vitality."
	overlay_state = "energize"
	range = 1
	cost = 4
	attunements = list(/datum/attunement/light)

/obj/effect/proc_holder/spell/invoked/utility/energize/cast(list/targets, mob/user)
	var/atom/target = targets[1]
	if(!target)
		return FALSE
	visible_message(span_notice("[user] channels energy into [target]."))

	if(istype(target, /mob/living))
		var/mob/living/L = target
		L.adjust_stamina(30)
		L.adjust_energy(30)

	if(istype(target, /obj/structure/mana_pylon))
		var/obj/structure/mana_pylon/pylon = target
		pylon.mana_pool.adjust_mana(30)

	return TRUE

/obj/effect/proc_holder/spell/invoked/utility/power_surge
	name = "Power Surge"
	desc = "Creates a brief surge of magical energy that can power devices."
	overlay_state = "power_surge"
	range = 2
	cost = 5
	attunements = list(/datum/attunement/light)

/obj/effect/proc_holder/spell/invoked/utility/power_surge/cast(list/targets, mob/user)
	var/turf/target_turf = get_turf(targets[1])
	if(!target_turf)
		return FALSE
	visible_message(span_notice("[user] creates a surge of magical power."))

	var/obj/effect/temp_visual/power_surge/surge = new(target_turf)
	QDEL_IN(surge, 10 SECONDS)
	return TRUE

// Cycle Essence Spells
/obj/effect/proc_holder/spell/invoked/utility/seasonal_attune
	name = "Seasonal Attune"
	desc = "Attunes the caster to natural cycles, providing minor benefits."
	overlay_state = "seasonal_attune"
	range = 0
	cost = 3
	attunements = list(/datum/attunement/light)

/obj/effect/proc_holder/spell/invoked/utility/seasonal_attune/cast(list/targets, mob/living/user)
	visible_message(span_notice("[user] harmonizes with the natural cycles."))
	user.apply_status_effect(/datum/status_effect/buff/seasonal_attunement, 600 SECONDS)
	return TRUE

// Temporary visual effects for spells
/obj/effect/temp_visual/daylight_orb
	name = "daylight orb"
	desc = "A brilliant orb of magical daylight."
	icon = 'icons/effects/effects.dmi'
	icon_state = "orb"
	duration = 60 SECONDS

/obj/effect/temp_visual/silence_zone
	name = "silence zone"
	desc = "An area of magical silence."
	icon = 'icons/effects/effects.dmi'
	icon_state = "bhole3"
	duration = 30 SECONDS

/obj/effect/temp_visual/power_surge
	name = "power surge"
	desc = "Crackling magical energy."
	icon = 'icons/effects/effects.dmi'
	icon_state = "electricity"
	duration = 10 SECONDS

// COMBO SPELLS - Two Essence Combinations

// Fire + Air Combo
/obj/effect/proc_holder/spell/invoked/utility/flame_jet
	name = "Flame Jet"
	desc = "Creates a controlled jet of flame for precise heating or light welding."
	overlay_state = "flame_jet"
	range = 2
	cost = 6
	attunements = list(/datum/attunement/fire, /datum/attunement/aeromancy)

/obj/effect/proc_holder/spell/invoked/utility/flame_jet/cast(list/targets, mob/user)
	var/turf/target_turf = get_turf(targets[1])
	if(!target_turf)
		return FALSE
	visible_message(span_notice("[user] creates a precise jet of flame."))

	var/obj/effect/temp_visual/flame_jet/jet = new(target_turf)
	QDEL_IN(jet, 15 SECONDS)
	return TRUE

/obj/effect/temp_visual/flame_jet
	name = "flame jet"
	desc = "A concentrated jet of magical flame."
	icon = 'icons/effects/fire.dmi'
	icon_state = "fire"
	duration = 15 SECONDS

/obj/effect/temp_visual/flame_jet/Initialize()
	. = ..()
	propagate_temp_change(40, 12, 0.8, 1) // High heat, high weight, low falloff, very short range (focused)

/obj/effect/temp_visual/flame_jet/Destroy()
	remove_temp_effect()
	return ..()

// Water + Earth Combo
/obj/effect/proc_holder/spell/invoked/utility/mud_shape
	name = "Mud Shape"
	desc = "Combines water and earth to create moldable mud for construction."
	overlay_state = "mud_shape"
	range = 2
	cost = 5
	attunements = list(/datum/attunement/blood, /datum/attunement/earth)

/obj/effect/proc_holder/spell/invoked/utility/mud_shape/cast(list/targets, mob/user)
	var/turf/target_turf = get_turf(targets[1])
	if(!target_turf)
		return FALSE
	visible_message(span_notice("[user] creates moldable mud from earth and water."))
	new /obj/item/natural/clay(target_turf)
	return TRUE

/obj/effect/proc_holder/spell/invoked/utility/fertile_soil
	name = "Fertile Soil"
	desc = "Enriches soil to promote plant growth."
	overlay_state = "fertile_soil"
	range = 2
	cost = 4
	attunements = list(/datum/attunement/blood, /datum/attunement/earth)

/obj/effect/proc_holder/spell/invoked/utility/fertile_soil/cast(list/targets, mob/user)
	var/turf/target_turf = get_turf(targets[1])
	if(!target_turf)
		return FALSE
	visible_message(span_notice("[user] enriches the soil with life-giving properties."))

	for(var/obj/structure/soil/plant in range(1, target_turf))
		plant.bless_soil()
	return TRUE

// Fire + Earth Combo
/obj/effect/proc_holder/spell/invoked/utility/forge_heat
	name = "Forge Heat"
	desc = "Generates intense heat suitable for metalworking."
	overlay_state = "forge_heat"
	range = 1
	cost = 6
	attunements = list(/datum/attunement/fire, /datum/attunement/earth)

/obj/effect/proc_holder/spell/invoked/utility/forge_heat/cast(list/targets, mob/user)
	var/turf/target_turf = get_turf(targets[1])
	if(!target_turf)
		return FALSE
	visible_message(span_notice("[user] generates forge-level heat."))

	var/obj/effect/temp_visual/forge_heat/heat = new(target_turf)
	heat.set_light(3, 2, "#FF4400")
	QDEL_IN(heat, 60 SECONDS)
	return TRUE

// Frost + Water Combo
/obj/effect/proc_holder/spell/invoked/utility/ice_bridge
	name = "Ice Bridge"
	desc = "Creates a temporary bridge of solid ice over gaps or water."
	overlay_state = "ice_bridge"
	range = 3
	cost = 7
	attunements = list(/datum/attunement/ice, /datum/attunement/blood)

/obj/effect/proc_holder/spell/invoked/utility/ice_bridge/cast(list/targets, mob/user)
	var/turf/target_turf = get_turf(targets[1])
	if(!target_turf)
		return FALSE
	visible_message(span_notice("[user] creates a bridge of solid ice."))

	var/obj/structure/ice_bridge/bridge = new(target_turf)
	QDEL_IN(bridge, 300 SECONDS)
	return TRUE

/obj/effect/proc_holder/spell/invoked/utility/frozen_storage
	name = "Frozen Storage"
	desc = "Creates a magical ice chest that preserves items indefinitely."
	overlay_state = "frozen_storage"
	range = 1
	cost = 6
	attunements = list(/datum/attunement/ice, /datum/attunement/blood)

/obj/effect/proc_holder/spell/invoked/utility/frozen_storage/cast(list/targets, mob/user)
	var/turf/target_turf = get_turf(targets[1])
	if(!target_turf)
		return FALSE
	visible_message(span_notice("[user] creates a chest of magical ice."))

	var/obj/structure/closet/crate/chest/magical/chest = new(target_turf)
	QDEL_IN(chest, 5 MINUTES)

// Light + Fire Combo Spells
/obj/effect/proc_holder/spell/invoked/utility/brilliant_flame
	name = "Brilliant Flame"
	desc = "Creates an intensely bright flame that provides both light and heat."
	overlay_state = "brilliant_flame"
	range = 2
	cost = 6
	attunements = list(/datum/attunement/light, /datum/attunement/fire)

/obj/effect/proc_holder/spell/invoked/utility/brilliant_flame/cast(list/targets, mob/user)
	var/turf/target_turf = get_turf(targets[1])
	if(!target_turf)
		return FALSE
	visible_message(span_notice("[user] creates a brilliant flame that illuminates the area."))

	var/obj/effect/temp_visual/brilliant_flame/flame = new(target_turf)
	flame.set_light(6, 3, "#FFFFDD")
	QDEL_IN(flame, 120 SECONDS)
	return TRUE

/obj/effect/proc_holder/spell/invoked/utility/solar_focus
	name = "Solar Focus"
	desc = "Concentrates light and heat into a precise beam for cutting or heating."
	overlay_state = "solar_focus"
	range = 3
	cost = 7
	attunements = list(/datum/attunement/light, /datum/attunement/fire)

/obj/effect/proc_holder/spell/invoked/utility/solar_focus/cast(list/targets, mob/user)
	var/turf/target_turf = get_turf(targets[1])
	if(!target_turf)
		return FALSE
	visible_message(span_notice("[user] focuses solar energy into a concentrated beam."))

	var/obj/effect/temp_visual/solar_beam/beam = new(target_turf)
	QDEL_IN(beam, 20 SECONDS)
	return TRUE

// Life + Water Combo Spells
/obj/effect/proc_holder/spell/invoked/utility/healing_spring
	name = "Healing Spring"
	desc = "Creates a small spring of healing water that slowly restores health."
	overlay_state = "healing_spring"
	range = 2
	cost = 8
	attunements = list(/datum/attunement/life, /datum/attunement/blood)

/obj/effect/proc_holder/spell/invoked/utility/healing_spring/cast(list/targets, mob/user)
	var/turf/target_turf = get_turf(targets[1])
	if(!target_turf)
		return FALSE
	visible_message(span_notice("[user] causes a healing spring to bubble forth from the ground."))

	var/obj/structure/healing_spring/spring = new(target_turf)
	QDEL_IN(spring, 600 SECONDS)
	return TRUE

/obj/effect/proc_holder/spell/invoked/utility/purify_water
	name = "Purify Water"
	desc = "Removes all impurities and toxins from water, making it pure and safe."
	overlay_state = "purify_water"
	range = 1
	cost = 5
	attunements = list(/datum/attunement/life, /datum/attunement/blood)

/obj/effect/proc_holder/spell/invoked/utility/purify_water/cast(list/targets, mob/user)
	var/obj/item/target = targets[1]
	if(!isobj(target))
		return FALSE
	visible_message(span_notice("[user] purifies [target] with life-giving energy."))

	if(target.reagents)
		target.reagents.remove_all_type(/datum/reagent/toxin)
		target.reagents.remove_reagent(/datum/reagent/water/gross, 999)
		target.reagents.add_reagent(/datum/reagent/water, 20)
	return TRUE

// Earth + Crystal Combo Spells
/obj/effect/proc_holder/spell/invoked/utility/gem_growth
	name = "Gem Growth"
	desc = "Encourages the natural formation of gems within suitable stone."
	overlay_state = "gem_growth"
	range = 2
	cost = 8
	attunements = list(/datum/attunement/earth, /datum/attunement/earth)

/obj/effect/proc_holder/spell/invoked/utility/gem_growth/cast(list/targets, mob/user)
	var/turf/target_turf = get_turf(targets[1])
	if(!target_turf)
		return FALSE
	visible_message(span_notice("[user] encourages gem formation in the surrounding stone."))

	if(prob(40))
		new /obj/item/gem(target_turf)
		visible_message(span_notice("A gem crystallizes from the stone!"))
	return TRUE

/obj/effect/proc_holder/spell/invoked/utility/mineral_sense
	name = "Mineral Sense"
	desc = "Detects valuable minerals and ores hidden within stone."
	overlay_state = "mineral_sense"
	range = 4
	cost = 6
	attunements = list(/datum/attunement/earth, /datum/attunement/earth)

/obj/effect/proc_holder/spell/invoked/utility/mineral_sense/cast(list/targets, mob/user)
	var/turf/target_turf = get_turf(targets[1])
	if(!target_turf)
		return FALSE
	visible_message(span_notice("[user] senses for valuable minerals in the area."))

	var/found_minerals = FALSE
	for(var/obj/item/natural/stone/S in range(3, target_turf))
		S.visible_message(span_notice("[S] resonates with mineral energy!"))
		found_minerals = TRUE

	if(!found_minerals)
		to_chat(user, span_notice("No valuable minerals detected nearby."))
	return TRUE

// Motion + Air Combo Spells
/obj/effect/proc_holder/spell/invoked/utility/wind_step
	name = "Wind Step"
	desc = "Allows rapid movement by riding currents of air."
	overlay_state = "wind_step"
	range = 0
	cost = 6
	attunements = list(/datum/attunement/aeromancy, /datum/attunement/aeromancy)

/obj/effect/proc_holder/spell/invoked/utility/wind_step/cast(list/targets, mob/living/user)
	visible_message(span_notice("[user] steps upon the wind itself."))
	user.apply_status_effect(/datum/status_effect/buff/wind_walking, 30 SECONDS)
	return TRUE

/obj/effect/proc_holder/spell/invoked/utility/aerial_dash
	name = "Aerial Dash"
	desc = "Provides a burst of speed through magical air currents."
	overlay_state = "aerial_dash"
	range = 0
	cost = 5
	attunements = list(/datum/attunement/aeromancy, /datum/attunement/aeromancy)

/obj/effect/proc_holder/spell/invoked/utility/aerial_dash/cast(list/targets, mob/living/user)
	visible_message(span_notice("[user] is propelled by rushing air currents."))
	user.apply_status_effect(/datum/status_effect/buff/aerial_speed, 15 SECONDS)
	return TRUE

// Order + Light Combo Spells
/obj/effect/proc_holder/spell/invoked/utility/divine_order
	name = "Divine Order"
	desc = "Brings perfect organization to an area through divine light."
	overlay_state = "divine_order"
	range = 3
	cost = 7
	attunements = list(/datum/attunement/earth, /datum/attunement/light)

/obj/effect/proc_holder/spell/invoked/utility/divine_order/cast(list/targets, mob/user)
	var/turf/target_turf = get_turf(targets[1])
	if(!target_turf)
		return FALSE
	visible_message(span_notice("[user] calls upon divine light to bring perfect order."))

	for(var/obj/item/I in range(2, target_turf))
		I.pixel_x = 0
		I.pixel_y = 0
		I.transform = matrix()

	var/obj/effect/temp_visual/divine_light/light = new(target_turf)
	light.set_light(4, 2, "#FFFFFF")
	QDEL_IN(light, 60 SECONDS)
	return TRUE

/obj/effect/proc_holder/spell/invoked/utility/sacred_geometry
	name = "Sacred Geometry"
	desc = "Creates perfect geometric patterns that provide structural stability."
	overlay_state = "sacred_geometry"
	range = 2
	cost = 6
	attunements = list(/datum/attunement/earth, /datum/attunement/light)

/obj/effect/proc_holder/spell/invoked/utility/sacred_geometry/cast(list/targets, mob/user)
	var/turf/target_turf = get_turf(targets[1])
	if(!target_turf)
		return FALSE
	visible_message(span_notice("[user] inscribes sacred geometric patterns."))

	var/obj/effect/temp_visual/sacred_pattern/pattern = new(target_turf)
	QDEL_IN(pattern, 300 SECONDS)
	return TRUE

// Chaos + Void Combo Spells
/obj/effect/proc_holder/spell/invoked/utility/reality_shift
	name = "Reality Shift"
	desc = "Temporarily alters local reality in unpredictable ways."
	overlay_state = "reality_shift"
	range = 2
	cost = 8
	attunements = list(/datum/attunement/fire, /datum/attunement/fire)

/obj/effect/proc_holder/spell/invoked/utility/reality_shift/cast(list/targets, mob/user)
	var/turf/target_turf = get_turf(targets[1])
	if(!target_turf)
		return FALSE
	visible_message(span_notice("[user] causes reality to shift and warp."))

	switch(rand(1, 6))
		if(1)
			target_turf.visible_message(span_warning("Gravity briefly reverses!"))
		if(2)
			target_turf.visible_message(span_notice("Colors shift and change!"))
		if(3)
			target_turf.visible_message(span_warning("Time seems to skip a beat!"))
		if(4)
			new /obj/effect/temp_visual/reality_crack(target_turf)
		if(5)
			playsound(target_turf, 'sound/magic/ethereal_exit.ogg', 50, TRUE)
		if(6)
			target_turf.visible_message(span_danger("Reality tears briefly!"))
	return TRUE

/obj/effect/proc_holder/spell/invoked/utility/probability_warp
	name = "Probability Warp"
	desc = "Alters the likelihood of minor events occurring."
	overlay_state = "probability_warp"
	range = 3
	cost = 7
	attunements = list(/datum/attunement/fire, /datum/attunement/fire)

/obj/effect/proc_holder/spell/invoked/utility/probability_warp/cast(list/targets, mob/user)
	var/turf/target_turf = get_turf(targets[1])
	if(!target_turf)
		return FALSE
	visible_message(span_notice("[user] warps probability in the local area."))

	for(var/mob/living/M in range(2, target_turf))
		M.apply_status_effect(/datum/status_effect/buff/probability_flux, 60 SECONDS)
	return TRUE

/obj/effect/proc_holder/spell/invoked/utility/toxic_cleanse
	name = "Toxic Cleanse"
	desc = "Completely purges an area of all toxic substances and poisons."
	overlay_state = "toxic_cleanse"
	range = 3
	cost = 7
	attunements = list(/datum/attunement/life, /datum/attunement/blood)

/obj/effect/proc_holder/spell/invoked/utility/toxic_cleanse/cast(list/targets, mob/user)
	var/turf/target_turf = get_turf(targets[1])
	if(!target_turf)
		return FALSE
	visible_message(span_notice("[user] cleanses all toxins from the area."))

	for(var/mob/living/M in range(2, target_turf))
		M.reagents?.remove_all_type(/datum/reagent/toxin)
		M.apply_status_effect(/datum/status_effect/buff/toxin_immunity, 300 SECONDS)
	return TRUE

// Magic + Crystal Combo Spells
/obj/effect/proc_holder/spell/invoked/utility/spell_crystal
	name = "Spell Crystal"
	desc = "Creates a crystal that can store and later release a spell."
	overlay_state = "spell_crystal"
	range = 1
	cost = 9
	attunements = list(/datum/attunement/light, /datum/attunement/earth)

/obj/effect/proc_holder/spell/invoked/utility/spell_crystal/cast(list/targets, mob/user)
	var/turf/target_turf = get_turf(targets[1])
	if(!target_turf)
		return FALSE
	visible_message(span_notice("[user] creates a crystal capable of storing magical energy."))

	new /obj/item/spell_crystal(target_turf)
	return TRUE

/obj/effect/proc_holder/spell/invoked/utility/arcane_focus
	name = "Arcane Focus"
	desc = "Creates a crystal focus that enhances magical abilities."
	overlay_state = "arcane_focus"
	range = 0
	cost = 8
	attunements = list(/datum/attunement/light, /datum/attunement/earth)

/obj/effect/proc_holder/spell/invoked/utility/arcane_focus/cast(list/targets, mob/living/user)
	visible_message(span_notice("[user] creates an arcane focusing crystal."))
	user.apply_status_effect(/datum/status_effect/buff/arcane_focus, 600 SECONDS)
	return TRUE

// Energia + Motion Combo Spells
/obj/effect/proc_holder/spell/invoked/utility/kinetic_burst
	name = "Kinetic Burst"
	desc = "Releases stored energy as a burst of kinetic force."
	overlay_state = "kinetic_burst"
	range = 3
	cost = 7
	attunements = list(/datum/attunement/light, /datum/attunement/aeromancy)

/obj/effect/proc_holder/spell/invoked/utility/kinetic_burst/cast(list/targets, mob/user)
	var/turf/target_turf = get_turf(targets[1])
	if(!target_turf)
		return FALSE
	visible_message(span_notice("[user] releases a burst of kinetic energy."))

	for(var/obj/item/I in range(1, target_turf))
		if(I.w_class <= WEIGHT_CLASS_NORMAL)
			var/distfromcaster = get_dist(user, I)
			var/throwtarget = get_edge_target_turf(user, get_dir(user, get_step_away(I, user)))
			I.safe_throw_at(throwtarget, ((CLAMP((5 - (CLAMP(distfromcaster - 2, 0, distfromcaster))), 3, 5))), 1,user, force = 5)


	var/obj/effect/temp_visual/kinetic_burst/burst = new(target_turf)
	QDEL_IN(burst, 5 SECONDS)
	return TRUE


/obj/effect/proc_holder/spell/invoked/utility/momentum_transfer
	name = "Momentum Transfer"
	desc = "Transfers kinetic energy between objects or creatures."
	overlay_state = "momentum_transfer"
	range = 2
	cost = 6
	attunements = list(/datum/attunement/light, /datum/attunement/aeromancy)

/obj/effect/proc_holder/spell/invoked/utility/momentum_transfer/cast(list/targets, mob/user)
	var/atom/target = targets[1]
	if(!target)
		return FALSE
	visible_message(span_notice("[user] transfers momentum to [target]."))

	if(ismob(target))
		var/mob/living/M = target
		M.apply_status_effect(/datum/status_effect/buff/momentum_boost, 30 SECONDS)
	return TRUE

// Cycle + Life Combo Spells
/obj/effect/proc_holder/spell/invoked/utility/regeneration_cycle
	name = "Regeneration Cycle"
	desc = "Establishes a cycle of continuous healing over time."
	overlay_state = "regeneration_cycle"
	range = 1
	cost = 8
	attunements = list(/datum/attunement/light, /datum/attunement/life)

/obj/effect/proc_holder/spell/invoked/utility/regeneration_cycle/cast(list/targets, mob/living/user)
	var/mob/living/target = targets[1]
	if(!istype(target))
		target = user
	visible_message(span_notice("[target] begins a cycle of natural regeneration."))
	target.apply_status_effect(/datum/status_effect/buff/regeneration_cycle, 300 SECONDS)
	return TRUE

/obj/effect/proc_holder/spell/invoked/utility/growth_acceleration
	name = "Growth Acceleration"
	desc = "Dramatically speeds up natural growth processes."
	overlay_state = "growth_acceleration"
	range = 2
	cost = 7
	attunements = list(/datum/attunement/light, /datum/attunement/life)

/obj/effect/proc_holder/spell/invoked/utility/growth_acceleration/cast(list/targets, mob/user)
	var/turf/target_turf = get_turf(targets[1])
	if(!target_turf)
		return FALSE
	visible_message(span_notice("[user] accelerates natural growth in the area."))

	for(var/obj/structure/soil/plant in range(1, target_turf))
		plant.accellerated_growth = world.time + 600 SECONDS
	return TRUE

// RACIAL COMBO SPELLS

// Dwarf Racial Spells
/obj/effect/proc_holder/spell/invoked/utility/create_beer
	name = "Create Beer"
	desc = "A dwarven secret - transforms water and grain into fine ale."
	overlay_state = "create_beer"
	range = 1
	cost = 4
	attunements = list(/datum/attunement/earth, /datum/attunement/blood)

/obj/effect/proc_holder/spell/invoked/utility/create_beer/cast(list/targets, mob/user)
	var/atom/movable/target = targets[1]
	visible_message(span_notice("[user] works dwarven brewing magic."))

	if(isopenturf(target))
		var/turf/open/open = target
		if(open.liquids)
			var/water_amount = open.liquids.liquid_group.reagents.get_reagent_amount(/datum/reagent/water)
			if(water_amount)
				open.liquids.liquid_group.remove_specific(open.liquids, water_amount, /datum/reagent/water)
				open.liquids.liquid_group.add_reagent(open.liquids, /datum/reagent/consumable/ethanol/beer, water_amount)
			else
				open.liquids.liquid_group.add_reagent(open.liquids, /datum/reagent/consumable/ethanol/beer, 20)
		else
			open.add_liquid(/datum/reagent/consumable/ethanol/beer, 20)
	else if(istype(target, /obj/item/reagent_containers/glass))
		var/obj/item/reagent_containers/glass/glass = target
		glass.reagents.add_reagent(/datum/reagent/consumable/ethanol/beer, 20)

	return TRUE

/obj/effect/proc_holder/spell/invoked/utility/master_forge
	name = "Master Forge"
	desc = "Creates a temporary forge of legendary dwarven quality."
	overlay_state = "master_forge"
	range = 2
	cost = 8
	attunements = list(/datum/attunement/fire, /datum/attunement/earth)

/obj/effect/proc_holder/spell/invoked/utility/master_forge/cast(list/targets, mob/user)
	var/turf/target_turf = get_turf(targets[1])
	if(!target_turf)
		return FALSE
	visible_message(span_notice("[user] creates a forge worthy of the greatest dwarven smiths."))

	var/obj/machinery/light/fueled/forge/arcane/forge = new(target_turf)
	QDEL_IN(forge, 1800 SECONDS)
	return TRUE

/obj/effect/proc_holder/spell/invoked/utility/ancestral_smithing
	name = "Ancestral Smithing"
	desc = "Channels the spirits of ancient dwarven smiths to guide crafting."
	overlay_state = "ancestral_smithing"
	range = 0
	cost = 7
	attunements = list(/datum/attunement/fire, /datum/attunement/earth)

/obj/effect/proc_holder/spell/invoked/utility/ancestral_smithing/cast(list/targets, mob/living/user)
	visible_message(span_notice("[user] calls upon the wisdom of ancient dwarven smiths."))
	user.apply_status_effect(/datum/status_effect/buff/ancestral_smithing, 600 SECONDS)
	return TRUE

// Elf Racial Spells
/obj/effect/proc_holder/spell/invoked/utility/elven_grace
	name = "Elven Grace"
	desc = "Grants the ethereal grace and agility of the ancient elves."
	overlay_state = "elven_grace"
	range = 0
	cost = 6
	attunements = list(/datum/attunement/life, /datum/attunement/light)

/obj/effect/proc_holder/spell/invoked/utility/elven_grace/cast(list/targets, mob/living/user)
	visible_message(span_notice("[user] moves with the grace of the ancient elves."))
	user.apply_status_effect(/datum/status_effect/buff/elven_grace, 300 SECONDS)
	return TRUE

// Human Racial Spells
/obj/effect/proc_holder/spell/invoked/utility/balanced_mind
	name = "Balanced Mind"
	desc = "Achieves perfect mental balance between order and chaos."
	overlay_state = "balanced_mind"
	range = 0
	cost = 6
	attunements = list(/datum/attunement/earth, /datum/attunement/fire)

/obj/effect/proc_holder/spell/invoked/utility/balanced_mind/cast(list/targets, mob/living/user)
	visible_message(span_notice("[user] achieves perfect mental equilibrium."))
	user.apply_status_effect(/datum/status_effect/buff/balanced_mind, 450 SECONDS)
	return TRUE

// Supporting structures and items for the new spells
/obj/effect/temp_visual/brilliant_flame
	name = "brilliant flame"
	desc = "A flame that burns with intense light and heat."
	icon = 'icons/effects/fire.dmi'
	icon_state = "fire"
	duration = 120 SECONDS

/obj/effect/temp_visual/brilliant_flame/Initialize()
	. = ..()
	propagate_temp_change(30, 8, 0.6, 3) // Moderate heat, good range

/obj/effect/temp_visual/brilliant_flame/Destroy()
	remove_temp_effect()
	return ..()

/obj/effect/temp_visual/solar_beam
	name = "solar beam"
	desc = "A concentrated beam of solar energy."
	icon = 'icons/effects/beam.dmi'
	icon_state = "solar"
	duration = 20 SECONDS

/obj/effect/temp_visual/solar_beam/Initialize()
	. = ..()
	propagate_temp_change(60, 15, 0.9, 1) // Very high heat, very focused

/obj/effect/temp_visual/solar_beam/Destroy()
	remove_temp_effect()
	return ..()

/obj/structure/healing_spring
	name = "healing spring"
	desc = "A mystical spring that bubbles with healing waters."
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "well"
	density = FALSE
	anchored = TRUE

/obj/structure/ice_bridge
	name = "ice bridge"
	desc = "A solid bridge made of magical ice."
	icon = 'icons/turf/floors.dmi'
	icon_state = "ice"
	density = FALSE
	anchored = TRUE
	obj_flags = CAN_BE_HIT | BLOCK_Z_OUT_DOWN | BLOCK_Z_IN_UP

/obj/structure/ice_bridge/Initialize()
	. = ..()
	propagate_temp_change(-20, 8, 0.5, 2) // Cooling effect

/obj/structure/ice_bridge/Destroy()
	remove_temp_effect()
	return ..()

/obj/effect/temp_visual/forge_heat
	name = "forge heat"
	desc = "Intense heat suitable for metalworking."
	icon = 'icons/effects/fire.dmi'
	icon_state = "fire"
	color = COLOR_RED
	duration = 60 SECONDS

/obj/effect/temp_visual/forge_heat/Initialize()
	. = ..()
	// Start heat propagation when created
	propagate_temp_change(50, 10, 0.7, 2) // High heat, medium weight, decent falloff, short range

/obj/effect/temp_visual/forge_heat/Destroy()
	remove_temp_effect()
	return ..()

/obj/effect/temp_visual/mist_veil
	name = "concealing mist"
	desc = "A veil of mist that provides concealment."
	icon = 'icons/effects/effects.dmi'
	icon_state = "mist"
	duration = 60 SECONDS

/obj/effect/temp_visual/divine_light
	name = "divine light"
	desc = "Pure, organizing divine light."
	icon = 'icons/effects/effects.dmi'
	icon_state = "holy_light"
	duration = 60 SECONDS

/obj/effect/temp_visual/sacred_pattern
	name = "sacred geometric pattern"
	desc = "A perfect geometric pattern inscribed with divine light."
	icon = 'icons/effects/effects.dmi'
	icon_state = "rune_holy"
	duration = 300 SECONDS

/obj/effect/temp_visual/reality_crack
	name = "reality crack"
	desc = "A brief tear in the fabric of reality."
	icon = 'icons/effects/effects.dmi'
	icon_state = "reality_crack"
	duration = 10 SECONDS

/obj/effect/temp_visual/kinetic_burst
	name = "kinetic burst"
	desc = "A burst of pure kinetic energy."
	icon = 'icons/effects/effects.dmi'
	icon_state = "kinetic_wave"
	duration = 5 SECONDS

// Additional supporting items and structures
/obj/item/reagent_containers/glass/bottle/antidote
	name = "universal antidote"
	desc = "A potent brew that counters multiple types of poison."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle_green"

/obj/item/reagent_containers/glass/bottle/antidote/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/medicine/antidote, 50)

/obj/item/spell_crystal
	name = "spell storage crystal"
	desc = "A crystal capable of storing magical energy for later use."
	icon_state = "crystal_blue"
	w_class = WEIGHT_CLASS_SMALL
	var/stored_spell = null
	var/stored_charges = 0

// Status effects for the spell buffs
/datum/status_effect/buff/wind_walking
	id = "wind_walking"
	alert_type = /atom/movable/screen/alert/status_effect/wind_walking
	duration = 30 SECONDS

/datum/status_effect/buff/wind_walking/on_apply()
	owner.add_movespeed_modifier("wind_walking", multiplicative_slowdown = -0.3)
	to_chat(owner, span_notice("You step upon the wind itself!"))

/datum/status_effect/buff/wind_walking/on_remove()
	owner.remove_movespeed_modifier("wind_walking")

/datum/status_effect/buff/aerial_speed
	id = "aerial_speed"
	alert_type = /atom/movable/screen/alert/status_effect/aerial_speed
	duration = 15 SECONDS


/datum/status_effect/buff/aerial_speed/on_apply()
	owner.add_movespeed_modifier("aerial_speed", multiplicative_slowdown = -0.5)
	to_chat(owner, span_notice("Air currents propel you forward!"))

/datum/status_effect/buff/aerial_speed/on_remove()
	owner.remove_movespeed_modifier("aerial_speed")

/datum/status_effect/buff/probability_flux
	id = "probability_flux"
	alert_type = /atom/movable/screen/alert/status_effect/probability_flux
	duration = 60 SECONDS
	effectedstats = list(STATKEY_LCK = 2)

/datum/status_effect/buff/toxin_immunity
	id = "toxin_immunity"
	alert_type = /atom/movable/screen/alert/status_effect/toxin_immunity
	duration = 300 SECONDS

/datum/status_effect/buff/toxin_immunity/on_apply()
	ADD_TRAIT(owner, TRAIT_TOXINLOVER, MAGIC_TRAIT)
	to_chat(owner, span_notice("Toxins cannot harm you!"))

/datum/status_effect/buff/toxin_immunity/on_remove()
	REMOVE_TRAIT(owner, TRAIT_TOXINLOVER, MAGIC_TRAIT)

/datum/status_effect/buff/arcane_focus
	id = "arcane_focus"
	alert_type = /atom/movable/screen/alert/status_effect/arcane_focus
	duration = 600 SECONDS

/datum/status_effect/buff/arcane_focus/on_apply()
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		for(var/obj/effect/proc_holder/spell/S in H.mind?.spell_list)
			S.charge_counter = S.recharge_time
	to_chat(owner, span_notice("Your magical focus intensifies!"))

/datum/status_effect/buff/momentum_boost
	id = "momentum_boost"
	alert_type = /atom/movable/screen/alert/status_effect/momentum_boost
	duration = 30 SECONDS

/datum/status_effect/buff/momentum_boost/on_apply()
	owner.add_movespeed_modifier("momentum", multiplicative_slowdown = -0.4)
	ADD_TRAIT(owner, TRAIT_PUSHIMMUNE, MAGIC_TRAIT)
	to_chat(owner, span_notice("Kinetic energy surges through you!"))

/datum/status_effect/buff/momentum_boost/on_remove()
	owner.remove_movespeed_modifier("momentum")
	REMOVE_TRAIT(owner, TRAIT_PUSHIMMUNE, MAGIC_TRAIT)

/datum/status_effect/buff/regeneration_cycle
	id = "regeneration_cycle"
	alert_type = /atom/movable/screen/alert/status_effect/regeneration_cycle
	duration = 300 SECONDS
	tick_interval = 10 SECONDS

/datum/status_effect/buff/regeneration_cycle/tick()
	if(owner.health < owner.maxHealth)
		owner.adjustBruteLoss(-1)
		owner.adjustFireLoss(-1)

/datum/status_effect/buff/ancestral_smithing
	id = "ancestral_smithing"
	alert_type = /atom/movable/screen/alert/status_effect/ancestral_smithing
	duration = 600 SECONDS

/datum/status_effect/buff/elven_grace
	id = "elven_grace"
	alert_type = /atom/movable/screen/alert/status_effect/elven_grace
	duration = 300 SECONDS

/datum/status_effect/buff/elven_grace/on_apply()
	owner.add_movespeed_modifier("elven_grace", multiplicative_slowdown = -0.2)

/datum/status_effect/buff/elven_grace/on_remove()
	owner.remove_movespeed_modifier("elven_grace")

/datum/status_effect/buff/balanced_mind
	id = "balanced_mind"
	alert_type = /atom/movable/screen/alert/status_effect/balanced_mind
	duration = 450 SECONDS
	var/balance_value = 10 // What value to balance all stats to
	var/source_key

/datum/status_effect/buff/balanced_mind/on_apply()
	. = ..()
	if(!owner)
		return
	source_key = "balanced_mind_[ref(src)]"
	owner.set_stat_modifier(source_key, STATKEY_STR, balance_value - owner.STASTR)
	owner.set_stat_modifier(source_key, STATKEY_PER, balance_value - owner.STAPER)
	owner.set_stat_modifier(source_key, STATKEY_END, balance_value - owner.STAEND)
	owner.set_stat_modifier(source_key, STATKEY_CON, balance_value - owner.STACON)
	owner.set_stat_modifier(source_key, STATKEY_INT, balance_value - owner.STAINT)
	owner.set_stat_modifier(source_key, STATKEY_SPD, balance_value - owner.STASPD)
	owner.set_stat_modifier(source_key, STATKEY_LCK, balance_value - owner.STALUC)

/datum/status_effect/buff/balanced_mind/on_remove()
	. = ..()
	if(!owner || !source_key)
		return
	owner.set_stat_modifier(source_key, STATKEY_STR, 0)
	owner.set_stat_modifier(source_key, STATKEY_PER, 0)
	owner.set_stat_modifier(source_key, STATKEY_END, 0)
	owner.set_stat_modifier(source_key, STATKEY_CON, 0)
	owner.set_stat_modifier(source_key, STATKEY_INT, 0)
	owner.set_stat_modifier(source_key, STATKEY_SPD, 0)
	owner.set_stat_modifier(source_key, STATKEY_LCK, 0)

/atom/movable/screen/alert/status_effect/wind_walking
	name = "Wind Walking"
	desc = "You step upon the wind itself, moving with supernatural grace."
	icon_state = "wind_walking"

/atom/movable/screen/alert/status_effect/aerial_speed
	name = "Aerial Speed"
	desc = "Air currents propel you forward with incredible speed."
	icon_state = "aerial_speed"

/atom/movable/screen/alert/status_effect/probability_flux
	name = "Probability Flux"
	desc = "The odds seem to be in your favor... or against you."
	icon_state = "probability_flux"

/atom/movable/screen/alert/status_effect/toxin_immunity
	name = "Toxin Immunity"
	desc = "You are completely immune to all toxins and poisons."
	icon_state = "toxin_immunity"

/atom/movable/screen/alert/status_effect/arcane_focus
	name = "Arcane Focus"
	desc = "Your magical abilities are enhanced by arcane focus."
	icon_state = "arcane_focus"

/atom/movable/screen/alert/status_effect/momentum_boost
	name = "Momentum Boost"
	desc = "Kinetic energy flows through you, enhancing your movement."
	icon_state = "momentum_boost"

/atom/movable/screen/alert/status_effect/regeneration_cycle
	name = "Regeneration Cycle"
	desc = "Your body continuously heals itself through natural cycles."
	icon_state = "regeneration_cycle"

/atom/movable/screen/alert/status_effect/ancestral_smithing
	name = "Ancestral Smithing"
	desc = "The spirits of ancient dwarven smiths guide your craft."
	icon_state = "ancestral_smithing"

/atom/movable/screen/alert/status_effect/elven_grace
	name = "Elven Grace"
	desc = "You move with the ethereal grace of the ancient elves."
	icon_state = "elven_grace"

/atom/movable/screen/alert/status_effect/balanced_mind
	name = "Balanced Mind"
	desc = "Perfect mental equilibrium between order and chaos."
	icon_state = "balanced_mind"

/datum/status_effect/buff/air_walking
	id = "air_walking"
	alert_type = /atom/movable/screen/alert/status_effect/air_walking
	duration = 15 SECONDS

/datum/status_effect/buff/air_walking/on_apply()
	ADD_TRAIT(owner, TRAIT_HOLLOWBONES, MAGIC_TRAIT)
	owner.movement_type |= FLYING
	to_chat(owner, span_notice("You feel light as air, able to step over gaps and chasms."))

/datum/status_effect/buff/air_walking/on_remove()
	REMOVE_TRAIT(owner, TRAIT_HOLLOWBONES, MAGIC_TRAIT)
	owner.movement_type &= ~FLYING
	to_chat(owner, span_notice("Your feet return to solid ground."))

/datum/status_effect/buff/water_breathing
	id = "water_breathing"
	alert_type = /atom/movable/screen/alert/status_effect/water_breathing
	duration = 60 SECONDS

/datum/status_effect/buff/water_breathing/on_apply()
	ADD_TRAIT(owner, TRAIT_WATER_BREATHING, MAGIC_TRAIT)
	to_chat(owner, span_notice("You can now breathe underwater."))

/datum/status_effect/buff/water_breathing/on_remove()
	REMOVE_TRAIT(owner, TRAIT_WATER_BREATHING, MAGIC_TRAIT)
	to_chat(owner, span_notice("Your ability to breathe underwater fades."))

/datum/status_effect/buff/warmth
	id = "warmth"
	alert_type = /atom/movable/screen/alert/status_effect/warmth
	duration = 120 SECONDS

/datum/status_effect/buff/warmth/on_apply()
	ADD_TRAIT(owner, TRAIT_RESISTCOLD, MAGIC_TRAIT)
	owner.bodytemperature = max(owner.bodytemperature, BODYTEMP_NORMAL)
	to_chat(owner, span_notice("A gentle warmth spreads through your body."))

/datum/status_effect/buff/warmth/on_remove()
	REMOVE_TRAIT(owner, TRAIT_RESISTCOLD, MAGIC_TRAIT)
	to_chat(owner, span_notice("The magical warmth fades away."))

/datum/status_effect/buff/phase_walking
	id = "phase_walking"
	alert_type = /atom/movable/screen/alert/status_effect/phase_walking
	duration = 5 SECONDS

/datum/status_effect/buff/phase_walking/on_apply()
	owner.pass_flags |= PASSMOB | PASSBLOB | PASSTABLE | PASSGLASS
	owner.alpha = 128
	to_chat(owner, span_notice("You become translucent and can pass through objects."))

/datum/status_effect/buff/phase_walking/on_remove()
	owner.pass_flags &= ~(PASSMOB | PASSBLOB | PASSTABLE | PASSGLASS)
	owner.alpha = 255
	to_chat(owner, span_notice("You return to solid form."))

/datum/status_effect/buff/vigor
	id = "vigor"
	alert_type = /atom/movable/screen/alert/status_effect/vigor
	duration = 60 SECONDS
	effectedstats = list("strength" = 1, "endurance" = 1)

/datum/status_effect/buff/vigor/on_apply()
	if(isliving(owner))
		var/mob/living/L = owner
		L.adjust_stamina(50)
		ADD_TRAIT(owner, TRAIT_STRONG_GRABBER, MAGIC_TRAIT)
		to_chat(owner, span_notice("You feel invigorated with supernatural strength."))

/datum/status_effect/buff/vigor/on_remove()
	REMOVE_TRAIT(owner, TRAIT_STRONG_GRABBER, MAGIC_TRAIT)
	to_chat(owner, span_notice("The supernatural vigor fades."))

/datum/status_effect/buff/seasonal_attunement
	id = "seasonal_attunement"
	alert_type = /atom/movable/screen/alert/status_effect/seasonal_attunement
	duration = 600 SECONDS

/datum/status_effect/buff/seasonal_attunement/on_apply()
	// Minor resistances based on current season/time
	ADD_TRAIT(owner, TRAIT_RESISTCOLD, MAGIC_TRAIT)
	ADD_TRAIT(owner, TRAIT_RESISTHEAT, MAGIC_TRAIT)
	to_chat(owner, span_notice("You harmonize with the natural cycles."))

/datum/status_effect/buff/seasonal_attunement/on_remove()
	REMOVE_TRAIT(owner, TRAIT_RESISTCOLD, MAGIC_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_RESISTHEAT, MAGIC_TRAIT)
	to_chat(owner, span_notice("Your connection to natural cycles fades."))

// Alert types for status effects
/atom/movable/screen/alert/status_effect/air_walking
	name = "Air Walking"
	desc = "You can step on solidified air over gaps."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/water_breathing
	name = "Water Breathing"
	desc = "You can breathe underwater."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/warmth
	name = "Warmth"
	desc = "Magical warmth protects you from cold."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/phase_walking
	name = "Phase Walking"
	desc = "You can pass through solid objects."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/vigor
	name = "Vigor"
	desc = "You feel supernaturally strong and energetic."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/seasonal_attunement
	name = "Seasonal Attunement"
	desc = "You are harmonized with natural cycles."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/wind_walking
	name = "Wind Walking"
	desc = "You move with supernatural speed on air currents."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/aerial_speed
	name = "Aerial Speed"
	desc = "Air currents propel you forward rapidly."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/probability_flux
	name = "Probability Flux"
	desc = "Reality bends around you in unpredictable ways."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/toxin_immunity
	name = "Toxin Immunity"
	desc = "You are protected from all toxins and poisons."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/arcane_focus
	name = "Arcane Focus"
	desc = "Your magical abilities are enhanced."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/momentum_boost
	name = "Momentum Boost"
	desc = "Kinetic energy surges through you."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/regeneration_cycle
	name = "Regeneration Cycle"
	desc = "Your body heals itself continuously."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/accelerated_growth
	name = "Accelerated Growth"
	desc = "Growth processes are dramatically sped up."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/ancestral_smithing
	name = "Ancestral Smithing"
	desc = "The spirits of ancient smiths guide your hands."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/elven_grace
	name = "Elven Grace"
	desc = "You move with ethereal grace and agility."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/nature_communion
	name = "Nature Communion"
	desc = "You are deeply connected to the natural world."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/balanced_mind
	name = "Balanced Mind"
	desc = "Your mind is in perfect equilibrium."
	icon_state = "buff"


/obj/structure/closet/crate/chest/magical
	name = "magical ice chest"
	desc = "A chest made of supernatural ice that preserves items indefinitely."
	icon_state = "freezer"
	color = LIGHT_COLOR_LIGHT_CYAN

/obj/structure/closet/crate/chest/magical/Initialize()
	. = ..()
	propagate_temp_change(-15, 6, 0.4, 2)

/obj/structure/closet/crate/chest/magical/Destroy()
	remove_temp_effect()
	return ..()
