/mob/living/carbon/Life()
	set invisibility = 0

	if(grab_fatigue > 0 && !pulling)
		grab_fatigue = max(0, grab_fatigue - 0.5)

	if(notransform)
		return

	if(damageoverlaytemp)
		damageoverlaytemp = 0
		update_damage_hud()

	//Reagent processing needs to come before breathing, to prevent edge cases.
	handle_organs()

	. = ..()

	if (QDELETED(src))
		return

	handle_lingering_pain()
	handle_wounds()
	handle_embedded_objects()
	handle_blood()
	handle_roguebreath()
	update_stress()
	handle_nausea()
	if((blood_volume > BLOOD_VOLUME_SURVIVE) || HAS_TRAIT(src, TRAIT_BLOODLOSS_IMMUNE))
		if(!heart_attacking)
			if(oxyloss)
				adjustOxyLoss(-1.6)
		else
			if(getOxyLoss() < 20)
				heart_attacking = FALSE

	handle_sleep()

	handle_brain_damage()


	check_cremation()

	if(stat != DEAD)
		return 1

/mob/living/carbon/DeadLife()
	set invisibility = 0

	if(notransform)
		return

	. = ..()
	if (QDELETED(src))
		return
	handle_wounds()
	handle_embedded_objects()
	handle_blood()

	check_cremation()

/mob/living/carbon/handle_random_events() //BP/WOUND BASED PAIN
	if(HAS_TRAIT(src, TRAIT_NOPAIN))
		return
	if(!stat)
		// Calculate current shock level
		var/current_shock = calculate_shock_stage()
		var/raw_pain = get_complex_pain()

		// Base pain calculation - endurance affects how much pain you feel from damage
		var/painpercent = raw_pain / (STAEND * 10)
		painpercent = painpercent * 100

		// Endurance-based pain resistance - higher endurance = better pain tolerance
		var/endurance_resistance = 1.0 - (STAEND * 0.03) // 3% reduction per endurance point
		endurance_resistance = max(0.4, endurance_resistance) // Minimum 40% pain felt
		painpercent *= endurance_resistance

		// Shock reduces pain perception (adrenaline effect)
		if(current_shock >= 30)
			var/shock_reduction = min(0.6, current_shock * 0.01) // Max 60% reduction
			painpercent *= (1.0 - shock_reduction)

		// Pain tolerance system - builds up to prevent infinite stunning
		// High endurance characters build tolerance faster and lose it slower
		var/tolerance_gain_rate = 5 + (STAEND * 0.5) // More endurance = faster adaptation
		var/tolerance_decay_rate = max(1, 3 - (STAEND * 0.2)) // More endurance = slower decay

		if(world.time - last_major_pain_time < 30 SECONDS)
			pain_tolerance = min(pain_tolerance + tolerance_gain_rate, 60 + (STAEND * 2)) // Higher max tolerance with endurance
		else
			pain_tolerance = max(pain_tolerance - tolerance_decay_rate, 0)

		// Apply pain tolerance to reduce effective pain
		var/effective_pain = painpercent * (1.0 - (pain_tolerance * 0.01))

		// Endurance-based pain threshold - higher endurance means higher pain threshold
		var/pain_threshold = 100 - (STAEND * 1) // 1% lower threshold per endurance point
		pain_threshold = max(70, pain_threshold) // Minimum threshold of 70%

		if(world.time > mob_timers[MT_PAINSTUN])
			mob_timers[MT_PAINSTUN] = world.time + 10 SECONDS

			// Base stun probability - endurance makes you much more resistant
			var/probby = max(5, 50 - (STAEND * 1)) // 1% reduction per endurance point, minimum 5%

			// Endurance affects recovery from stuns - higher endurance = shorter cooldowns
			var/endurance_cooldown_reduction = STAEND * 0.25 // 0.25 seconds per endurance point

			// Reduce stun probability based on shock stage and pain tolerance
			if(current_shock >= 40)
				probby *= 0.5 // Shock makes you less likely to be stunned by pain
			if(pain_tolerance > 20)
				probby *= (1.0 - (pain_tolerance * 0.008)) // Tolerance reduces stun chance

			if(body_position == LYING_DOWN || HAS_TRAIT(src, TRAIT_FLOORED))
				if(prob(3) && (effective_pain >= 80))
					emote("painmoan")
			else
				if(effective_pain >= pain_threshold) // Dynamic threshold based on endurance
					if(prob(probby) && !HAS_TRAIT(src, TRAIT_NOPAINSTUN))
						// Major pain event - increase tolerance
						pain_tolerance += tolerance_gain_rate
						last_major_pain_time = world.time

						// Endurance affects stun duration - tougher people recover faster
						var/base_stun = current_shock >= 50 ? 60 : 110
						var/endurance_stun_reduction = STAEND * 2 // 2 deciseconds per endurance point
						var/stun_duration = max(30, base_stun - endurance_stun_reduction)

						var/base_immobilize = current_shock >= 50 ? 5 : 10
						var/immobilize_duration = max(2, base_immobilize - (STAEND * 0.1))

						Immobilize(immobilize_duration)
						emote("painscream")
						stuttering += max(1, 5 - STAEND) // Less stuttering with high endurance
						addtimer(CALLBACK(src, PROC_REF(Stun), stun_duration), immobilize_duration)
						addtimer(CALLBACK(src, PROC_REF(Knockdown), stun_duration), immobilize_duration)

						// Shorter cooldown with higher endurance
						var/base_cooldown = current_shock >= 50 ? 20 SECONDS : 16 SECONDS
						var/cooldown = max(8 SECONDS, base_cooldown - (endurance_cooldown_reduction SECONDS))
						mob_timers[MT_PAINSTUN] = world.time + cooldown
					else
						emote("painmoan")
						stuttering += max(1, 5 - STAEND)
				else
					// Lower threshold for minor pain with high endurance
					var/minor_pain_threshold = 80 - STAEND
					if(effective_pain >= minor_pain_threshold)
						if(prob(probby * 0.5)) // Reduced chance for minor pain reactions
							emote("painmoan")

		// Stress effects - endurance helps resist stress from pain
		if(effective_pain >= pain_threshold)
			if(current_shock < 40) // Only add stress if not in shock-induced numbness
				// High endurance characters are less stressed by pain
				if(prob(max(20, 100 - (STAEND * 2)))) // 2% less likely per endurance point (40% at 20 )
					add_stress(/datum/stressevent/painmax)

/mob/living/carbon/proc/handle_roguebreath()
	return

/mob/living/carbon/human/handle_roguebreath()
	..()
	if(HAS_TRAIT(src, TRAIT_NOBREATH))
		return TRUE
	if(istype(loc, /obj/structure/closet/dirthole))
		adjustOxyLoss(5)
	if(istype(loc, /obj/structure/closet/burial_shroud))
		var/obj/O = loc
		if(istype(O.loc, /obj/structure/closet/dirthole))
			adjustOxyLoss(5)
	if(isopenturf(loc))
		var/turf/open/T = loc
		if(reagents&& T.pollution)
			T.pollution.breathe_act(src)
			if(next_smell <= world.time)
				next_smell = world.time + 30 SECONDS
				T.pollution.smell_act(src)

/mob/living/proc/handle_inwater(turf/open/water/W)
	if(body_position == LYING_DOWN || W.water_level == 3)
		SoakMob(FULL_BODY)
	else
		if(W.water_level == 2)
			SoakMob(BELOW_CHEST)

/mob/living/carbon/handle_inwater(turf/open/water/W)
	..()
	if(HAS_TRAIT(src, TRAIT_NOBREATH))
		return TRUE
	if(stat == DEAD)
		return TRUE
/*	if(W.water_level == 3)	// deep water, to dissuade diving in dirty lakes. Does not work quite right not worth the effort right now, TO DO
		var/datum/reagents/reagentstouch = new()
		reagentstouch.add_reagent(W.water_reagent, 2)
		reagentstouch.trans_to(src, reagents.total_volume, transfered_by = src, method = TOUCH)	*/
	if(body_position == LYING_DOWN && !HAS_TRAIT(src, TRAIT_WATER_BREATHING))
		var/drown_damage = has_world_trait(/datum/world_trait/abyssor_rage) ? 10 : 5
		adjustOxyLoss(drown_damage)
		emote("drown")
		if(stat == DEAD && client)
			GLOB.vanderlin_round_stats[STATS_PEOPLE_DROWNED]++
		var/datum/reagents/reagents = new()
		reagents.add_reagent(W.water_reagent, 2)
		reagents.trans_to(src, reagents.total_volume, transfered_by = src, method = INGEST)

/mob/living/carbon/human/handle_inwater()
	. = ..()
	if(body_position != LYING_DOWN)
		if(istype(loc, /turf/open/water/bath))
			if(!wear_armor && !wear_shirt && !wear_pants)
				var/mob/living/carbon/V = src
				V.add_stress(/datum/stressevent/bathwater)

/mob/living/carbon/proc/get_complex_pain()
	var/total_pain = 0

	for(var/I in bodyparts)
		var/obj/item/bodypart/BP = I
		if(BP.status == BODYPART_ROBOTIC)
			continue

		var/bodypart_pain = 0

		// Acute pain from current damage (immediate, sharp pain)
		var/acute_pain = 0
		acute_pain += ((BP.brute_dam / BP.max_damage) * 50)
		acute_pain += ((BP.burn_dam / BP.max_damage) * 50)

		// Wound-specific pain (can be higher intensity)
		var/wound_pain = 0
		for(var/W in BP.wounds)
			var/datum/wound/WO = W
			if(WO.woundpain > 0)
				wound_pain += WO.woundpain

		// Lingering pain (decays over time, separate from current damage)
		if(!BP.lingering_pain)
			BP.lingering_pain = 0

		// Add new lingering pain when taking significant damage
		var/current_damage_percent = ((BP.brute_dam + BP.burn_dam) / BP.max_damage) * 100
		if(current_damage_percent > 20) // Only significant injuries cause lingering pain
			var/new_lingering = (current_damage_percent - 20) * 0.5 // Scale factor
			BP.lingering_pain = max(BP.lingering_pain, new_lingering)

			// Track severe injuries for chronic pain development
			if(current_damage_percent > 60)
				BP.last_severe_injury_time = world.time

		// Chronic pain system
		if(!BP.chronic_pain)
			BP.chronic_pain = 0
		if(!BP.chronic_pain_type)
			BP.chronic_pain_type = null

		// Develop chronic pain from repeated or severe injuries
		//process_chronic_pain_development(BP, current_damage_percent) //TODO seperate TM for balancing this lol

		// Calculate chronic pain contribution
		var/chronic_pain_amount = get_chronic_pain_amount(BP)

		// Combine all pain sources for this bodypart
		bodypart_pain = acute_pain + wound_pain + BP.lingering_pain + chronic_pain_amount

		// Apply species pain modifier
		bodypart_pain *= (dna?.species?.pain_mod || 1)

		total_pain += bodypart_pain

	// Apply pain medications/modifiers
	total_pain *= pain_resistance_multiplier()

	return max(0, total_pain)

/mob/living/carbon/proc/process_chronic_pain_development(obj/item/bodypart/BP, current_damage_percent)
	// Don't develop chronic pain if you already have it at max level
	if(BP.chronic_pain >= 100)
		return

	// Factors that increase chronic pain development
	var/development_chance = 0

	// Severe current damage
	if(current_damage_percent > 80)
		development_chance += 0.1
	else if(current_damage_percent > 60)
		development_chance += 0.05

	// Recent severe injury history (within last hour)
	if(BP.last_severe_injury_time && (world.time - BP.last_severe_injury_time) < 1 HOURS)
		development_chance += 0.08

	// High lingering pain suggests tissue damage
	if(BP.lingering_pain > 30)
		development_chance += 0.05

	// Poor general health increases chronic pain risk
	if(getToxLoss() > 20 || nutrition < 200)
		development_chance += 0.03

	// Random chance to develop chronic pain
	if(prob(development_chance * 100))
		// Determine chronic pain type based on injury pattern
		if(!BP.chronic_pain_type)
			if(BP.brute_dam > BP.burn_dam)
				BP.chronic_pain_type = prob(50) ? CHRONIC_OLD_FRACTURE : CHRONIC_SCAR_TISSUE
			else
				BP.chronic_pain_type = prob(50) ? CHRONIC_NERVE_DAMAGE : CHRONIC_SCAR_TISSUE

		// Increase chronic pain level slowly
		BP.chronic_pain = min(BP.chronic_pain + rand(1, 3), 100)

		// Notify player when chronic pain develops significantly
		if(BP.chronic_pain == 25 || BP.chronic_pain == 50 || BP.chronic_pain == 75)
			var/bodypart_name = BP.name
			var/pain_desc = get_chronic_pain_description(BP.chronic_pain_type, BP.chronic_pain)
			to_chat(src, span_warning("You feel [pain_desc] developing in your [bodypart_name]."))

/mob/living/carbon/proc/get_chronic_pain_amount(obj/item/bodypart/BP)
	if(!BP.chronic_pain || !BP.chronic_pain_type)
		return 0

	var/base_pain = BP.chronic_pain * 0.3 // Base chronic pain

	// Weather effects (if your game has weather)
	/*
	if(SSweather?.current_weather?.pressure == "low")
		base_pain *= 1.3 // Arthritis flares up in low pressure
	*/

	// Activity level affects chronic pain
	if(body_position == LYING_DOWN)
		base_pain *= 0.8 // Rest helps
	else if(m_intent == MOVE_INTENT_RUN)
		base_pain *= 1.4 // Running aggravates chronic pain

	// Time of day effects (morning stiffness)
	var/game_hour = world.time / (1 HOURS) % 24
	if(game_hour >= 6 && game_hour <= 8) // Morning hours
		base_pain *= 1.2

	// Chronic pain type modifiers
	switch(BP.chronic_pain_type)
		if(CHRONIC_ARTHRITIS)
			// Worse when cold, better when warm
			if(bodytemperature < BODYTEMP_NORMAL - 10)
				base_pain *= 1.5
			else if(bodytemperature > BODYTEMP_NORMAL + 10)
				base_pain *= 0.8

		if(CHRONIC_NERVE_DAMAGE)
			// Consistent pain, hard to treat
			base_pain *= 1.1

		if(CHRONIC_OLD_FRACTURE)
			// Worse with activity and weather
			if(m_intent == MOVE_INTENT_RUN)
				base_pain *= 1.3

		if(CHRONIC_SCAR_TISSUE)
			// Causes stiffness, worse with movement
			if(m_intent != MOVE_INTENT_WALK)
				base_pain *= 1.2

	return base_pain

/mob/living/carbon/proc/get_chronic_pain_description(pain_type, severity)
	var/intensity = ""
	switch(severity)
		if(1 to 25)
			intensity = "a mild ache"
		if(26 to 50)
			intensity = "a persistent discomfort"
		if(51 to 75)
			intensity = "a chronic pain"
		if(76 to 100)
			intensity = "a severe chronic condition"

	switch(pain_type)
		if(CHRONIC_ARTHRITIS)
			return "[intensity] and stiffness"
		if(CHRONIC_NERVE_DAMAGE)
			return "[intensity] and tingling sensation"
		if(CHRONIC_OLD_FRACTURE)
			return "[intensity] from old bone damage"
		if(CHRONIC_SCAR_TISSUE)
			return "[intensity] from scar tissue"

	return "[intensity]"

/mob/living/carbon/proc/handle_lingering_pain()
	for(var/I in bodyparts)
		var/obj/item/bodypart/BP = I
		if(BP.status == BODYPART_ROBOTIC)
			continue

		// Process lingering pain decay
		if(BP.lingering_pain > 0)
			var/decay_rate = 0.5

			if(nutrition > 300 && !has_status_effect(/datum/status_effect/debuff/sleepytime))
				decay_rate *= 1.5
			if(getToxLoss() > 20 || getOxyLoss() > 20)
				decay_rate *= 0.5

			BP.lingering_pain = max(0, BP.lingering_pain - decay_rate)

		// Chronic pain can very slowly improve with good care
		if(BP.chronic_pain > 0)
			// Chance for improvement if healthy and well-cared for
			if(nutrition > 400 && getToxLoss() < 10 && getOxyLoss() < 10 && !has_status_effect(/datum/status_effect/debuff/sleepytime))
				if(prob(0.1)) // Very small chance
					BP.chronic_pain = max(0, BP.chronic_pain - 1)
					if(BP.chronic_pain == 0)
						BP.chronic_pain_type = null
						to_chat(src, span_green("The chronic pain in your [BP.name] seems to have finally subsided."))


/mob/living/carbon/proc/pain_resistance_multiplier()
	var/multiplier = 1.0

	// Check for pain medications in bloodstream
	if(reagents)
		// Ozium
		if(reagents.has_reagent(/datum/reagent/ozium))
			multiplier *= 0.3 // 70% pain reduction

		if(reagents.has_reagent(/datum/reagent/buff/herbal/battle_stim))
			multiplier *= 0.4 // 60% pain reduction

		// Alcohol (mild pain relief)
		if(reagents.has_reagent(/datum/reagent/consumable/ethanol))
			var/alcohol_amount = reagents.get_reagent_amount(/datum/reagent/consumable/ethanol)
			multiplier *= max(0.8, 1.0 - (alcohol_amount * 0.01)) // Diminishing returns

	return multiplier


/mob/living/carbon/proc/calculate_shock_stage()
	var/shock = 0

	// Physical trauma contributes to shock
	shock += getBruteLoss() * 0.7
	shock += getFireLoss() * 0.8
	shock += getToxLoss() * 0.4

	// Blood loss is a major shock factor
	if(blood_volume < 100)
		shock += max(0, 100 - blood_volume) * 1.2

	// Severe pain itself can cause shock
	var/pain_level = get_complex_pain()
	if(pain_level > 80)
		shock += (pain_level - 80) * 0.5

	// Endurance helps resist going into shock
	shock *= (1.0 - (STAEND * 0.02)) // 2% shock resistance per endurance point (40% at 20)
	shock = max(0, shock)

	// Gradually reduce shock over time if conditions improve
	if(shock < shock_stage)
		// Higher endurance = faster shock recovery
		var/recovery_rate = 2 + (STAEND * 0.3)
		shock_stage = max(shock, shock_stage - recovery_rate)
	else
		shock_stage = shock

	return shock_stage


/mob/living/carbon/human/get_complex_pain()
	. = ..()
	if(physiology)
		. *= physiology.pain_mod

///////////////
// BREATHING //
///////////////

/mob/living/carbon/handle_temperature()
	var/turf/open/turf = get_turf(src)
	if(!istype(turf))
		return
	var/temp = turf.return_temperature()

	if(temp < 0 )
		snow_shiver = world.time + 3 SECONDS + abs(temp)

//Start of a breath chain, calls breathe()
/mob/living/carbon/handle_breathing(times_fired)
	var/breath_effect_prob = 0
	var/turf/turf = get_turf(src)
	var/turf_temp = turf.temperature

	if(turf_temp <= T0C - 50)
		breath_effect_prob = 100
	else if(turf_temp <= T0C - 25)
		breath_effect_prob = 50
	else if(turf_temp <= T0C - 10)
		breath_effect_prob = 25
	else if(turf_temp <= T0C)
		breath_effect_prob = 15

	var/turf/snow_turf = get_turf(src)
	if(snow_shiver > world.time)
		breath_effect_prob += 50
	else if(snow_turf.snow)
		breath_effect_prob += 50

	if(prob(breath_effect_prob))
		// Breathing into your mask, no particle. We can add fogged up glasses later
		if(is_mouth_covered())
			return
		emit_breath_particle(/particles/fog/breath)

	return

/mob/living/proc/emit_breath_particle(particle_type)
	ASSERT(ispath(particle_type, /particles))

	var/obj/effect/abstract/particle_holder/holder = new(src, particle_type)
	var/particles/breath_particle = holder.particles
	var/breath_dir = dir

	var/list/particle_grav = list(0, 0.1, 0)
	var/list/particle_pos = list(0, 6, 0)
	if(breath_dir & NORTH)
		particle_grav[2] = 0.2
		breath_particle.rotation = pick(-45, 45)
		// Layer it behind the mob since we're facing away from the camera
		holder.pixel_w -= 4
		holder.pixel_y += 4
	if(breath_dir & WEST)
		particle_grav[1] = -0.2
		particle_pos[1] = -5
		breath_particle.rotation = -45
	if(breath_dir & EAST)
		particle_grav[1] = 0.2
		particle_pos[1] = 5
		breath_particle.rotation = 45
	if(breath_dir & SOUTH)
		particle_grav[2] = 0.2
		breath_particle.rotation = pick(-45, 45)
		// Shouldn't be necessary but just for parity
		holder.pixel_w += 4
		holder.pixel_y -= 4

	breath_particle.gravity = particle_grav
	breath_particle.position = particle_pos

	QDEL_IN(holder, breath_particle.lifespan)

/mob/living/carbon/proc/has_smoke_protection()
	if(HAS_TRAIT(src, TRAIT_NOBREATH))
		return TRUE
	return FALSE

/mob/living/carbon/proc/handle_organs()
	if(stat != DEAD)
		for(var/V in internal_organs)
			var/obj/item/organ/O = V
			O.on_life()
	else
		for(var/V in internal_organs)
			var/obj/item/organ/O = V
			O.on_death() //Needed so organs decay while inside the body.

/mob/living/carbon/handle_embedded_objects()
	for(var/obj/item/bodypart/bodypart as anything in bodyparts)
		for(var/obj/item/embedded as anything in bodypart.embedded_objects)
			if(embedded.on_embed_life(src, bodypart))
				continue

			if(prob(embedded.embedding.embedded_pain_chance))
				bodypart.receive_damage(embedded.w_class*embedded.embedding.embedded_pain_multiplier)
				to_chat(src, "<span class='danger'>[embedded] in my [bodypart.name] hurts!</span>")

			if(prob(embedded.embedding.embedded_fall_chance))
				bodypart.receive_damage(embedded.w_class*embedded.embedding.embedded_fall_pain_multiplier)
				bodypart.remove_embedded_object(embedded)
				to_chat(src,"<span class='danger'>[embedded] falls out of my [bodypart.name]!</span>")

/*
Alcohol Poisoning Chart
Note that all higher effects of alcohol poisoning will inherit effects for smaller amounts (i.e. light poisoning inherts from slight poisoning)
In addition, severe effects won't always trigger unless the drink is poisonously strong
All effects don't start immediately, but rather get worse over time; the rate is affected by the imbiber's alcohol tolerance

0: Non-alcoholic
1-10: Barely classifiable as alcohol - occassional slurring
11-20: Slight alcohol content - slurring
21-30: Below average - imbiber begins to look slightly drunk
31-40: Just below average - no unique effects
41-50: Average - mild disorientation, imbiber begins to look drunk
51-60: Just above average - disorientation, vomiting, imbiber begins to look heavily drunk
61-70: Above average - small chance of blurry vision, imbiber begins to look smashed
71-80: High alcohol content - blurry vision, imbiber completely shitfaced
81-90: Extremely high alcohol content - light brain damage, passing out
91-100: Dangerously toxic - swift death
*/
#define BALLMER_POINTS 5
GLOBAL_LIST_INIT(ballmer_good_msg, list("Hey guys, what if we rolled out a bluespace wiring system so mice can't destroy the powergrid anymore?",
										"Hear me out here. What if, and this is just a theory, we made R&D controllable from our PDAs?",
										"I'm thinking we should roll out a git repository for our research under the AGPLv3 license so that we can share it among the other stations freely.",
										"I dunno about you guys, but IDs and PDAs being separate is clunky as fuck. Maybe we should merge them into a chip in our arms? That way they can't be stolen easily.",
										"Why the fuck aren't we just making every pair of shoes into galoshes? We have the technology."))
GLOBAL_LIST_INIT(ballmer_windows_me_msg, list("Yo man, what if, we like, uh, put a webserver that's automatically turned on with default admin passwords into every PDA?",
												"So like, you know how we separate our codebase from the master copy that runs on our consumer boxes? What if we merged the two and undid the separation between codebase and server?",
												"Dude, radical idea: H.O.N.K mechs but with no bananium required.",
												"Best idea ever: Disposal pipes instead of hallways.",
												"We should store bank records in a webscale datastore, like /dev/null.",
												"You ever wonder if /dev/null supports sharding?",
												"Do you know who ate all the donuts?",
												"What if we use a language that was written on a napkin and created over 1 weekend for all of our servers?"))

//this updates all special effects: stun, sleeping, knockdown, druggy, stuttering, etc..
/mob/living/carbon/handle_status_effects()
	..()

	var/restingpwr = 1 + 4 * resting

	//Dizziness
	if(dizziness)
		var/client/C = client
		var/pixel_x_diff = 0
		var/pixel_y_diff = 0
		var/temp
		var/saved_dizz = dizziness
		if(C)
			var/oldsrc = src
			var/amplitude = dizziness*(sin(dizziness * world.time) + 1) // This shit is annoying at high strength
			src = null
			spawn(0)
				if(C)
					temp = amplitude * sin(saved_dizz * world.time)
					pixel_x_diff += temp
					C.pixel_x += temp
					temp = amplitude * cos(saved_dizz * world.time)
					pixel_y_diff += temp
					C.pixel_y += temp
					sleep(3)
					if(C)
						temp = amplitude * sin(saved_dizz * world.time)
						pixel_x_diff += temp
						C.pixel_x += temp
						temp = amplitude * cos(saved_dizz * world.time)
						pixel_y_diff += temp
						C.pixel_y += temp
					sleep(3)
					if(C)
						C.pixel_x -= pixel_x_diff
						C.pixel_y -= pixel_y_diff
			src = oldsrc
		dizziness = max(dizziness - restingpwr, 0)

	if(drowsyness)
		drowsyness = max(drowsyness - restingpwr, 0)
		blur_eyes(2)
		if(prob(5))
			AdjustSleeping(100)

	//Jitteriness
	if(jitteriness)
		do_jitter_animation(jitteriness)
		jitteriness = max(jitteriness - restingpwr, 0)
		SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "jittery", /datum/mood_event/jittery)
	else
		SEND_SIGNAL(src, COMSIG_CLEAR_MOOD_EVENT, "jittery")

	if(stuttering)
		stuttering = max(stuttering-1, 0)

	if(slurring)
		slurring = max(slurring-1,0)

	if(cultslurring)
		cultslurring = max(cultslurring-1, 0)

	if(silent)
		silent = max(silent-1, 0)

	if(druggy)
		adjust_drugginess(-1)

	if(drunkenness)
		drunkenness = max(drunkenness - (drunkenness * 0.04) - 0.01, 0)
		if(drunkenness >= 1)
			if(has_flaw(/datum/charflaw/addiction/alcoholic))
				sate_addiction()
		if(drunkenness >= 3)
			if(prob(3))
				slurring += 2
			jitteriness = max(jitteriness - 3, 0)
			apply_status_effect(/datum/status_effect/buff/drunk)
		else
			remove_stress(/datum/stressevent/drunk)
		if(drunkenness >= 11 && slurring < 5)
			slurring += 1.2
		if(drunkenness >= 41)
			if(prob(25))
				confused += 2
			Dizzy(10)

		if(drunkenness >= 51)
			adjustToxLoss(1)
			if(prob(3))
				confused += 15
				vomit() // vomiting clears toxloss, consider this a blessing
			Dizzy(25)

		if(drunkenness >= 61)
			adjustToxLoss(1)
			if(prob(50))
				blur_eyes(5)

		if(drunkenness >= 71)
			adjustToxLoss(1)
			if(prob(10))
				blur_eyes(5)

		if(drunkenness >= 81)
			adjustToxLoss(3)
			if(prob(5) && !stat)
				to_chat(src, "<span class='warning'>Maybe I should lie down for a bit...</span>")

		if(drunkenness >= 91)
			adjustToxLoss(5)
			if(prob(20) && !stat)
				to_chat(src, "<span class='warning'>Just a quick nap...</span>")
				Sleeping(900)

		if(drunkenness >= 101)
			adjustToxLoss(5) //Let's be honest you shouldn't be alive by now

//used in human and monkey handle_environment()
/mob/living/carbon/proc/natural_bodytemperature_stabilization()
	var/body_temperature_difference = BODYTEMP_NORMAL - bodytemperature
	switch(bodytemperature)
		if(-INFINITY to BODYTEMP_COLD_DAMAGE_LIMIT) //Cold damage limit is 50 below the default, the temperature where you start to feel effects.
			return max((body_temperature_difference * metabolism_efficiency / BODYTEMP_AUTORECOVERY_DIVISOR), BODYTEMP_AUTORECOVERY_MINIMUM)
		if(BODYTEMP_COLD_DAMAGE_LIMIT to BODYTEMP_NORMAL)
			return max(body_temperature_difference * metabolism_efficiency / BODYTEMP_AUTORECOVERY_DIVISOR, min(body_temperature_difference, BODYTEMP_AUTORECOVERY_MINIMUM/4))
		if(BODYTEMP_NORMAL to BODYTEMP_HEAT_DAMAGE_LIMIT) // Heat damage limit is 50 above the default, the temperature where you start to feel effects.
			return min(body_temperature_difference * metabolism_efficiency / BODYTEMP_AUTORECOVERY_DIVISOR, max(body_temperature_difference, -BODYTEMP_AUTORECOVERY_MINIMUM/4))
		if(BODYTEMP_HEAT_DAMAGE_LIMIT to INFINITY)
			return min((body_temperature_difference / BODYTEMP_AUTORECOVERY_DIVISOR), -BODYTEMP_AUTORECOVERY_MINIMUM)	//We're dealing with negative numbers

/////////
//LIVER//
/////////

///Decides if the liver is failing or not.
/mob/living/carbon/proc/handle_liver()
	if(!dna)
		return
	var/obj/item/organ/liver/liver = getorganslot(ORGAN_SLOT_LIVER)
	if(!liver)
		liver_failure()

/mob/living/carbon/proc/undergoing_liver_failure()
	var/obj/item/organ/liver/liver = getorganslot(ORGAN_SLOT_LIVER)
	if(liver && (liver.organ_flags & ORGAN_FAILING))
		return TRUE

/mob/living/carbon/proc/liver_failure()
	reagents.end_metabolization(src, keep_liverless = TRUE) //Stops trait-based effects on reagents, to prevent permanent buffs
	reagents.metabolize(src, can_overdose=FALSE, liverless = TRUE)
	if(HAS_TRAIT(src, TRAIT_NOMETABOLISM))
		return
	adjustToxLoss(4, TRUE,  TRUE)
//	if(prob(30))
//		to_chat(src, "<span class='warning'>I feel a stabbing pain in your abdomen!</span>")

/////////////
//CREMATION//
/////////////
/mob/living/carbon/proc/check_cremation()
	//Only cremate while actively on fire
	if(!on_fire)
		return

	if(stat != DEAD)
		return

	//Only starts when the chest has taken full damage
	var/obj/item/bodypart/chest = get_bodypart(BODY_ZONE_CHEST)
	if(!(chest.get_damage() >= (chest.max_damage - 5)))
		return

	//Burn off limbs one by one
	var/obj/item/bodypart/limb
	var/list/limb_list = list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
	var/should_update_body = FALSE
	for(var/zone in limb_list)
		limb = get_bodypart(zone)
		if(limb && !limb.skeletonized)
			if(limb.get_damage() >= (limb.max_damage - 5))
				limb.cremation_progress += rand(2,5)
				if(dna && dna.species && !(NOBLOOD in dna.species.species_traits))
					blood_volume = max(blood_volume - 10, 0)
				if(limb.cremation_progress >= 50)
					if(limb.status == BODYPART_ORGANIC) //Non-organic limbs don't burn
						limb.skeletonize()
						should_update_body = TRUE
						limb.drop_limb()
						limb.visible_message("<span class='warning'>[src]'s [limb.name] crumbles into ash!</span>")
						qdel(limb)
					else
						limb.drop_limb()
						limb.visible_message("<span class='warning'>[src]'s [limb.name] detaches from [p_their()] body!</span>")

	//Burn the head last
	var/obj/item/bodypart/head = get_bodypart(BODY_ZONE_HEAD)
	if(head && !head.skeletonized)
		if(head.get_damage() >= (head.max_damage - 5))
			head.cremation_progress += rand(1,4)
			if(head.cremation_progress >= 50)
				if(head.status == BODYPART_ORGANIC) //Non-organic limbs don't burn
					head.skeletonize()
					should_update_body = TRUE
					head.drop_limb()
					head.visible_message("<span class='warning'>[src]'s head crumbles into ash!</span>")
					qdel(head)
				else
					head.drop_limb()
					head.visible_message("<span class='warning'>[src]'s head detaches from [p_their()] body!</span>")

	//Nothing left: dust the body, drop the items (if they're flammable they'll burn on their own)
	if(chest && !chest.skeletonized)
		if(chest.get_damage() >= (chest.max_damage - 5))
			chest.cremation_progress += rand(1,4)
			if(chest.cremation_progress >= 100)
				visible_message("<span class='warning'>[src]'s body crumbles into a pile of ash!</span>")
				dust(TRUE, TRUE)
				chest.skeletonized = TRUE
				if(ishuman(src))
					var/mob/living/carbon/human/H = src
					H.underwear = "Nude"
				should_update_body = TRUE
				if(dna && dna.species)
					if(dna && dna.species && !(NOBLOOD in dna.species.species_traits))
						blood_volume = 0
					dna.species.species_traits |= NOBLOOD

	if(should_update_body)
		update_body()

////////////////
//BRAIN DAMAGE//
////////////////

/mob/living/carbon/proc/handle_brain_damage()
	for(var/T in get_traumas())
		var/datum/brain_trauma/BT = T
		BT.on_life()

/////////////////////////////////////
//MONKEYS WITH TOO MUCH CHOLOESTROL//
/////////////////////////////////////

/mob/living/carbon/proc/can_heartattack()
	if(!needs_heart())
		return FALSE
	var/obj/item/organ/heart/heart = getorganslot(ORGAN_SLOT_HEART)
	if(!heart || (heart.organ_flags & ORGAN_SYNTHETIC))
		return FALSE
	return TRUE

/mob/living/carbon/proc/needs_heart()
	if(HAS_TRAIT(src, TRAIT_STABLEHEART))
		return FALSE
	if(dna && dna.species && (NOBLOOD in dna.species.species_traits)) //not all carbons have species!
		return FALSE
	return TRUE

/*
 * The mob is having a heart attack
 *
 * NOTE: this is true if the mob has no heart and needs one, which can be suprising,
 * you are meant to use it in combination with can_heartattack for heart attack
 * related situations (i.e not just cardiac arrest)
 */
/mob/living/carbon/proc/undergoing_cardiac_arrest()
	var/obj/item/organ/heart/heart = getorganslot(ORGAN_SLOT_HEART)
	if(istype(heart) && heart.beating)
		return FALSE
	else if(!needs_heart())
		return FALSE
	return TRUE

/mob/living/proc/set_heartattack(status)
	return

/mob/living/carbon/set_heartattack(status)
	if(!can_heartattack())
		return FALSE

	var/obj/item/organ/heart/heart = getorganslot(ORGAN_SLOT_HEART)
	if(!istype(heart))
		return

	heart.beating = !status

/// Handles sleep. Mobs with no_sleep trait cannot sleep.
/*
*	The mob tries to go to sleep or IS sleeping
*
*	Accounts for...
*	TRAIT_NOSLEEP
*	CANT_SLEEP_IN
*	Hunger and Hydration.
*/

/mob/living/carbon/proc/handle_sleep()
	if(HAS_TRAIT(src, TRAIT_NOSLEEP))
		return
	var/cant_fall_asleep = FALSE
	var/cause = "I just can't..."
	var/list/equipped_items = get_equipped_items(FALSE)
	if(HAS_TRAIT(src, TRAIT_NUDE_SLEEPER) && length(equipped_items))
		cant_fall_asleep = TRUE
		cause = "I can't sleep in clothes, it's too uncomfortable.."
	else
		for(var/obj/item/clothing/thing in equipped_items)
			if(thing.clothing_flags & CANT_SLEEP_IN)
				cant_fall_asleep = TRUE
				cause = "\The [thing] bothers me..."
				break

	//Healing while sleeping in a bed
	if(stat >= UNCONSCIOUS)
		var/sleepy_mod = buckled?.sleepy || 0.5
		var/bleed_rate = get_bleed_rate()
		var/yess = HAS_TRAIT(src, TRAIT_NOHUNGER)
		if(nutrition > 0 || yess)
			adjust_energy(sleepy_mod * (max_energy * 0.02))
		if(HAS_TRAIT(src, TRAIT_BETTER_SLEEP))
			adjust_energy(sleepy_mod * (max_energy * 0.004))
		if(locate(/obj/item/bedsheet) in get_turf(src))
			adjust_energy(sleepy_mod * (max_energy * 0.004))
		if(hydration > 0 || yess)
			if(!bleed_rate)
				blood_volume = min(blood_volume + (4 * sleepy_mod), BLOOD_VOLUME_NORMAL)
			for(var/obj/item/bodypart/affecting as anything in bodyparts)
				//for context, it takes 5 small cuts (0.4 x 5) or 3 normal cuts (0.8 x 3) for a bodypart to not be able to heal itself
				if(affecting.get_bleed_rate() >= 2)
					continue
				if(affecting.heal_damage(sleepy_mod * 1.5, sleepy_mod * 1.5, required_status = BODYPART_ORGANIC, updating_health = FALSE)) // multiplier due to removing healing from sleep effect
					src.update_damage_overlays()
				for(var/datum/wound/wound as anything in affecting.wounds)
					if(!wound.sleep_healing)
						continue
					wound.heal_wound(wound.sleep_healing * sleepy_mod)
			adjustToxLoss( - ( sleepy_mod * 0.5) )
			updatehealth()
			if(eyesclosed && !HAS_TRAIT(src, TRAIT_NOSLEEP))
				Sleeping(300)
		tiredness = 0
	else if(!IsSleeping() && !HAS_TRAIT(src, TRAIT_NOSLEEP))
		// Resting on a bed or something
		if(buckled?.sleepy)
			if(eyesclosed && !cant_fall_asleep || (eyesclosed && !(fallingas >= 10 && cant_fall_asleep)))
				if(!fallingas)
					to_chat(src, span_warning("I'll fall asleep soon..."))
				fallingas++
				if(fallingas > 15)
					Sleeping(300)
			else if(eyesclosed && fallingas >= 10 && cant_fall_asleep)
				if(fallingas != 13)
					to_chat(src, span_boldwarning("I can't sleep...[cause]"))
				fallingas -= 5
			else
				adjust_energy(buckled.sleepy * (max_energy * 0.01))
		// Resting on the ground (not sleeping or with eyes closed and about to fall asleep)
		else if(body_position == LYING_DOWN)
			if(eyesclosed && !cant_fall_asleep || (eyesclosed && !(fallingas >= 10 && cant_fall_asleep)))
				if(!fallingas)
					to_chat(src, span_warning("I'll fall asleep soon, although a bed would be more comfortable..."))
				fallingas++
				if(fallingas > 25)
					Sleeping(300)
			else if(eyesclosed && fallingas >= 10 && cant_fall_asleep)
				if(fallingas != 13)
					to_chat(src, span_boldwarning("I can't sleep...[cause]"))
				fallingas -= 5
			else
				adjust_energy((max_energy * 0.01))
		else if(fallingas)
			fallingas = 0
		tiredness = min(tiredness + 1, 100)
