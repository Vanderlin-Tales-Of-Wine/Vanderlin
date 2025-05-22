
GLOBAL_LIST_INIT(character_flaws, list(
	"Alcoholic"=/datum/charflaw/addiction/alcoholic,
	"Devout Follower"=/datum/charflaw/addiction/godfearing,
	"Pacifist"=/datum/charflaw/pacifist,
	"Smoker"=/datum/charflaw/addiction/smoker,
	"Junkie"=/datum/charflaw/addiction/junkie,
	"Cyclops (R)"=/datum/charflaw/noeyer,
	"Cyclops (L)"=/datum/charflaw/noeyel,
	"Tongueless"=/datum/charflaw/tongueless,
	"Greedy"=/datum/charflaw/greedy,
	"Narcoleptic"=/datum/charflaw/narcoleptic,
	"Masochist"=/datum/charflaw/masochist,
	"Wooden Arm (R)"=/datum/charflaw/limbloss/arm_r,
	"Wooden Arm (L)"=/datum/charflaw/limbloss/arm_l,
	"Bad Sight"=/datum/charflaw/badsight,
	"Paranoid"=/datum/charflaw/paranoid,
	"Clingy"=/datum/charflaw/clingy,
	"Isolationist"=/datum/charflaw/isolationist,
	"Fire Servant"=/datum/charflaw/addiction/pyromaniac,
	"Thief-Borne"=/datum/charflaw/addiction/kleptomaniac,
	"Pain Freek"=/datum/charflaw/addiction/masochist,
	"Hunted"=/datum/charflaw/hunted,
	"Random Flaw or No Flaw"=/datum/charflaw/randflaw,
	"Guaranteed No Flaw (3 TRI)"=/datum/charflaw/noflaw,))

/datum/charflaw
	var/name
	var/desc
	/// This flaw is currently disabled and will not process
	var/ephemeral = FALSE
	/// The mob affected by the character flaw
	var/mob/owner

/datum/charflaw/New(mob/new_owner)
	. = ..()
	if(new_owner)
		owner = new_owner
		on_mob_creation(owner)

/// Applies when the user mob is created without mind
/datum/charflaw/proc/on_mob_creation(mob/user)
	return

/// Aplies after the user mob is fully spawned and has mind
/datum/charflaw/proc/after_spawn(mob/user)
	return

/datum/charflaw/Destroy()
	on_remove()
	return ..()

/// Applies when the flaw is deleted
/datum/charflaw/proc/on_remove()
	return

/mob/proc/get_flaw(flaw_type)
	return

/mob/living/carbon/human/get_flaw(flaw_type)
	if(!flaw_type)
		return
	if(charflaw != flaw_type)
		return
	return charflaw

/datum/charflaw/proc/flaw_on_life(mob/user)
	return

/mob/proc/has_flaw(flaw)
	return

/mob/living/carbon/human/has_flaw(flaw)
	if(!flaw)
		return
	if(istype(charflaw, flaw))
		return TRUE

/// Replaces mob's flaw with a random one excluding no flaw
/mob/proc/get_random_flaw()
	return

/mob/living/carbon/human/get_random_flaw()
	var/list/flaws = GLOB.character_flaws.Copy() - list(/datum/charflaw/randflaw, /datum/charflaw/noflaw)
	var/new_charflaw = pick_n_take(flaws)
	new_charflaw = GLOB.character_flaws[new_charflaw]
	if(charflaw)
		QDEL_NULL(charflaw)
	charflaw = new new_charflaw(src)

/datum/charflaw/randflaw
	name = "Random Flaw"
	desc = "Chooses a random flaw (50% chance for no flaw)"
	var/nochekk = TRUE

/datum/charflaw/randflaw/flaw_on_life(mob/user)
	if(!nochekk)
		return
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.ckey)
			nochekk = FALSE
			if(prob(50))
				H.get_random_flaw()
			else
				H.charflaw = new /datum/charflaw/eznoflaw(H)

/datum/charflaw/eznoflaw
	name = "No Flaw"
	desc = "I'm a normal person, how rare!"

/datum/charflaw/noflaw
	name = "No Flaw (3 TRI)"
	desc = "I'm a normal person, how rare! (Consumes 3 triumphs or randomizes)"
	var/nochekk = TRUE

/datum/charflaw/noflaw/flaw_on_life(mob/user)
	if(!nochekk)
		return
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.ckey)
			if(H.get_triumphs() < 3)
				nochekk = FALSE
				var/flawz = GLOB.character_flaws.Copy()
				var/charflaw = pick_n_take(flawz)
				charflaw = GLOB.character_flaws[charflaw]
				if((charflaw == type) || (charflaw == /datum/charflaw/randflaw))
					charflaw = pick_n_take(flawz)
					charflaw = GLOB.character_flaws[charflaw]
				if((charflaw == type) || (charflaw == /datum/charflaw/randflaw))
					charflaw = pick_n_take(flawz)
					charflaw = GLOB.character_flaws[charflaw]
				H.charflaw = new charflaw(H)
			else
				nochekk = FALSE
				H.adjust_triumphs(-3)

/datum/charflaw/badsight
	name = "Bad Eyesight"
	desc = "I need spectacles to see normally from my years spent reading books."

/datum/charflaw/badsight/after_spawn(mob/user)
	. = ..()
	var/mob/living/carbon/human/H = user
	if(H.mind)
		H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)

/datum/charflaw/badsight/flaw_on_life(mob/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(H.wear_mask)
		if(isclothing(H.wear_mask))
			if(istype(H.wear_mask, /obj/item/clothing/face/spectacles))
				var/obj/item/I = H.wear_mask
				if(!I.obj_broken)
					return
	H.blur_eyes(2)
	H.apply_status_effect(/datum/status_effect/debuff/badvision)

/datum/status_effect/debuff/badvision
	id = "badvision"
	alert_type = null
	effectedstats = list(STATKEY_PER = -20, STATKEY_SPD = -5, STATKEY_LCK = -20)
	duration = 100

/datum/charflaw/badsight/after_spawn(mob/user)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(H.wear_mask)
		var/type = H.wear_mask.type
		QDEL_NULL(H.wear_mask)
		H.put_in_hands(new type(get_turf(H)))
	H.equip_to_slot_or_del(new /obj/item/clothing/face/spectacles(H), SLOT_WEAR_MASK)

/datum/charflaw/paranoid
	name = "Paranoid"
	desc = "I'm even more anxious than most towners. I'm extra paranoid of other races, the price of higher intelligence."
	var/last_check = 0

/datum/charflaw/paranoid/flaw_on_life(mob/user)
	if(world.time < last_check + 10 SECONDS)
		return
	if(!user)
		return
	last_check = world.time
	var/cnt = 0
	for(var/mob/living/carbon/human/L in hearers(7, user))
		if(L == src)
			continue
		if(L.stat)
			continue
		if(L.dna?.species)
			if(ishuman(user))
				var/mob/living/carbon/human/H = user
				if(L.dna.species.id != H.dna.species.id)
					cnt++
		if(cnt > 2)
			break
	var/mob/living/carbon/P = user
	if(cnt > 2)
		P.add_stress(/datum/stressevent/paracrowd)
	cnt = 0
	for(var/obj/effect/decal/cleanable/blood/B in view(7, user))
		cnt++
		if(cnt > 3)
			break
	if(cnt > 6)
		P.add_stress(/datum/stressevent/parablood)

/datum/charflaw/isolationist
	name = "Isolationist"
	desc = "I don't like being near people. They might be trying to do something to me..."
	var/last_check = 0

/datum/charflaw/isolationist/flaw_on_life(mob/user)
	. = ..()
	if(world.time < last_check + 10 SECONDS)
		return
	if(!user)
		return
	last_check = world.time
	var/cnt = 0
	for(var/mob/living/carbon/human/L in hearers(7, user))
		if(L == src)
			continue
		if(L.stat)
			continue
		if(L.dna.species)
			cnt++
		if(cnt > 2)
			break
	var/mob/living/carbon/P = user
	if(cnt > 2)
		P.add_stress(/datum/stressevent/crowd)

/datum/charflaw/clingy
	name = "Clingy"
	desc = "I like being around people, it's just so lively..."
	var/last_check = 0

/datum/charflaw/clingy/flaw_on_life(mob/user)
	. = ..()
	if(world.time < last_check + 10 SECONDS)
		return
	if(!user)
		return
	last_check = world.time
	var/cnt = 0
	for(var/mob/living/carbon/human/L in hearers(7, user))
		if(L == src)
			continue
		if(L.stat)
			continue
		if(L.dna.species)
			cnt++
		if(cnt > 2)
			break
	var/mob/living/carbon/P = user
	if(cnt < 2)
		P.add_stress(/datum/stressevent/nopeople)

/datum/charflaw/noeyer
	name = "Cyclops (R)"
	desc = "I lost my right eye long ago. But it made me great at noticing things."

/datum/charflaw/noeyer/after_spawn(mob/user)
	..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(H.wear_mask)
		var/type = H.wear_mask.type
		QDEL_NULL(H.wear_mask)
		H.put_in_hands(new type(get_turf(H)))
	H.equip_to_slot_or_del(new /obj/item/clothing/face/eyepatch(H), SLOT_WEAR_MASK)

	var/obj/item/bodypart/head/head = H.get_bodypart(BODY_ZONE_HEAD)
	head?.add_wound(/datum/wound/facial/eyes/right/permanent)
	H.update_fov_angles()

/datum/charflaw/noeyel
	name = "Cyclops (L)"
	desc = "I lost my left eye long ago. But it made me great at noticing things."

/datum/charflaw/noeyel/after_spawn(mob/user)
	..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user

	if(H.wear_mask)
		var/type = H.wear_mask.type
		QDEL_NULL(H.wear_mask)
		H.put_in_hands(new type(get_turf(H)))
	H.equip_to_slot_or_del(new /obj/item/clothing/face/eyepatch/left(H), SLOT_WEAR_MASK)

	var/obj/item/bodypart/head/head = H.get_bodypart(BODY_ZONE_HEAD)
	head?.add_wound(/datum/wound/facial/eyes/left/permanent)
	H.update_fov_angles()

/datum/charflaw/noeyerandom
	name = "Cyclops (Random)"
	desc = "I lost my eye long ago. But it made me great at noticing things."

/datum/charflaw/noeyerandom/after_spawn(mob/user)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		switch(rand(1,2))
			if(1)
				H.charflaw = new /datum/charflaw/noeyel(H)
			else
				H.charflaw = new /datum/charflaw/noeyer(H)
	qdel(src)

/datum/charflaw/tongueless
	name = "Tongueless"
	desc = "I was too annoying. (Being mute is not an excuse to forego roleplay. Use of custom emotes is recommended.)"

/datum/charflaw/tongueless/on_mob_creation(mob/user)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	var/obj/item/bodypart/head/head = H.get_bodypart(BODY_ZONE_HEAD)
	head?.add_wound(/datum/wound/facial/tongue/permanent)

/datum/charflaw/hunted
	name = "Hunted"
	desc = "Something in my past has made me a target. I'm always looking over my shoulder.	\
	THIS IS A DIFFICULT FLAW, YOU WILL BE HUNTED AND HAVE ASSASINATION ATTEMPTS MADE AGAINST YOU WITHOUT ANY ESCALATION. \
	EXPECT A MORE DIFFICULT EXPERIENCE. PLAY AT YOUR OWN RISK."
	var/logged = FALSE

/datum/charflaw/hunted/flaw_on_life(mob/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(logged == FALSE)
		if(H.name) // If you don't check this, the log entry wont have a name as flaw_on_life is checked at least once before the name is set.
			log_hunted("[H.ckey] playing as [H.name] had the hunted flaw by vice.")
			logged = TRUE


/datum/charflaw/greedy
	name = "Greedy"
	desc = "I can't get enough of mammons, I need more and more!"
	var/last_checked_mammons = 0
	var/required_mammons = 0
	var/next_mammon_increase = 0
	var/last_passed_check = 0
	var/first_tick = FALSE
	var/extra_increment_value = 0

/datum/charflaw/greedy/on_mob_creation(mob/user)
	next_mammon_increase = world.time + rand(15 MINUTES, 25 MINUTES)
	last_passed_check = world.time

/datum/charflaw/greedy/flaw_on_life(mob/user)
	if(!first_tick)
		determine_starting_mammons(user)
		first_tick = TRUE
		return
	if(world.time >= next_mammon_increase)
		mammon_increase(user)
	mammon_check(user)

/datum/charflaw/greedy/proc/determine_starting_mammons(mob/living/carbon/human/user)
	var/starting_mammons = get_mammons_in_atom(user)
	required_mammons = round(starting_mammons * 0.7)
	extra_increment_value = round(starting_mammons * 0.15)

/datum/charflaw/greedy/proc/mammon_increase(mob/living/carbon/human/user)
	if(last_passed_check + (50 MINUTES) < world.time) //If we spend a REALLY long time without being able to satisfy, then pity downgrade
		required_mammons -= rand(10, 20)
		to_chat(user, span_blue("Maybe a little less mammons is enough..."))
	else
		required_mammons += rand(25, 35) + extra_increment_value
	required_mammons = min(required_mammons, 250) //Cap at 250 coins maximum
	next_mammon_increase = world.time + rand(35 MINUTES, 40 MINUTES)
	var/current_mammons = get_mammons_in_atom(user)
	if(current_mammons >= required_mammons)
		to_chat(user, span_blue("I'm quite happy with the amount of mammons I have..."))
	else
		to_chat(user, span_boldwarning("I need more mammons, what I have is not enough..."))

	last_checked_mammons = current_mammons

/datum/charflaw/greedy/proc/mammon_check(mob/living/carbon/human/user)
	var/new_mammon_amount = get_mammons_in_atom(user)
	var/ascending = (new_mammon_amount > last_checked_mammons)

	var/do_update_msg = TRUE
	if(new_mammon_amount >= required_mammons)
		// Feel better
		if(user.has_stress(/datum/stressevent/vice))
			to_chat(user, span_blue("[new_mammon_amount] mammons... That's more like it.."))
		user.remove_stress(/datum/stressevent/vice)
		user.remove_status_effect(/datum/status_effect/debuff/addiction)
		last_passed_check = world.time
		do_update_msg = FALSE
	else
		// Feel bad
		user.add_stress(/datum/stressevent/vice)
		user.apply_status_effect(/datum/status_effect/debuff/addiction)

	if(new_mammon_amount == last_checked_mammons)
		do_update_msg = FALSE

	if(do_update_msg)
		if(ascending)
			to_chat(user, span_warning("Only [new_mammon_amount] mammons.. I need more..."))
		else
			to_chat(user, span_boldwarning("No! My precious mammons..."))

	last_checked_mammons = new_mammon_amount

/datum/charflaw/narcoleptic
	name = "Narcoleptic"
	desc = "I get drowsy during the day and tend to fall asleep suddenly, but I can sleep easier if I want to, and moon dust can help me stay awake."
	var/last_unconsciousness = 0
	var/next_sleep = 0
	var/concious_timer = (10 MINUTES)
	var/do_sleep = FALSE
	var/pain_pity_charges = 3
	var/drugged_up = FALSE

/datum/charflaw/narcoleptic/on_mob_creation(mob/user)
	ADD_TRAIT(user, TRAIT_FASTSLEEP, "[type]")
	reset_timer()

/datum/charflaw/narcoleptic/proc/reset_timer()
	do_sleep = FALSE
	last_unconsciousness = world.time
	concious_timer = rand(7 MINUTES, 15 MINUTES)
	pain_pity_charges = rand(2,4)

/datum/charflaw/narcoleptic/flaw_on_life(mob/living/carbon/human/user)
	if(user.stat != CONSCIOUS)
		reset_timer()
		return
	if(do_sleep)
		if(next_sleep <= world.time)
			var/pain = user.get_complex_pain()
			if(pain >= 40 && pain_pity_charges > 0)
				pain_pity_charges--
				concious_timer = rand(1 MINUTES, 2 MINUTES)
				to_chat(user, span_warning("The pain keeps me awake..."))
			else
				if(prob(40) || drugged_up)
					drugged_up = FALSE
					concious_timer = rand(4 MINUTES, 6 MINUTES)
					to_chat(user, span_info("The feeling has passed."))
				else
					concious_timer = rand(7 MINUTES, 15 MINUTES)
					to_chat(user, span_boldwarning("I can't keep my eyes open any longer..."))
					user.Sleeping(rand(30 SECONDS, 50 SECONDS))
					user.visible_message(span_warning("[user] suddenly collapses!"))
			do_sleep = FALSE
			last_unconsciousness = world.time
	else
		// Been conscious for ~10 minutes (whatever is the conscious timer)
		if(last_unconsciousness + concious_timer < world.time)
			drugged_up = FALSE
			to_chat(user, span_blue("I'm getting drowsy..."))
			user.emote("yawn", forced = TRUE)
			next_sleep = world.time + rand(7 SECONDS, 11 SECONDS)
			do_sleep = TRUE

/proc/narcolepsy_drug_up(mob/living/living)
	var/datum/charflaw/narcoleptic/narco = living.get_flaw(/datum/charflaw/narcoleptic)
	if(!narco)
		return
	narco.drugged_up = TRUE

#define MASO_THRESHOLD_ONE 1
#define MASO_THRESHOLD_TWO 2
#define MASO_THRESHOLD_THREE 3
#define MASO_THRESHOLD_FOUR 4

/datum/charflaw/masochist
	name = "Masochist"
	desc = "I love the feeling of pain, so much I can't get enough of it."
	var/next_paincrave = 0
	var/last_pain_threshold = NONE

/datum/charflaw/masochist/on_mob_creation(mob/living/carbon/human/user)
	next_paincrave = world.time + rand(15 MINUTES, 25 MINUTES)

/datum/charflaw/masochist/flaw_on_life(mob/living/carbon/human/user)
	if(next_paincrave > world.time)
		last_pain_threshold = NONE
		return
	user.add_stress(/datum/stressevent/vice)
	user.apply_status_effect(/datum/status_effect/debuff/addiction)
	var/current_pain = user.get_complex_pain()
	// Bloodloss makes the pain count as extra large to allow people to bloodlet themselves with cutting weapons to satisfy vice
	var/bloodloss_factor = clamp(1.0 - (user.blood_volume / BLOOD_VOLUME_NORMAL), 0.0, 0.5)
	var/new_pain_threshold = get_pain_threshold(current_pain * (1.0 + (bloodloss_factor * 1.4))) // Bloodloss factor goes up to 50%, and then counts at 140% value of that
	if(last_pain_threshold == NONE)
		to_chat(user, span_boldwarning("I could really use some pain right now..."))
	else if (new_pain_threshold != last_pain_threshold)
		var/ascending = (new_pain_threshold > last_pain_threshold)
		switch(new_pain_threshold)
			if(MASO_THRESHOLD_ONE)
				to_chat(user, span_warning("The pain is gone..."))
			if(MASO_THRESHOLD_TWO)
				if(ascending)
					to_chat(user, span_blue("Yes, more pain!"))
				else
					to_chat(user, span_warning("No, my pain!"))
			if(MASO_THRESHOLD_THREE)
				to_chat(user, span_blue("More, I love it!"))

	last_pain_threshold = new_pain_threshold
	if(new_pain_threshold == MASO_THRESHOLD_FOUR)
		to_chat(user, span_blue("<b>That's more like it...</b>"))
		next_paincrave = world.time + rand(35 MINUTES, 45 MINUTES)
		user.remove_stress(/datum/stressevent/vice)
		user.remove_status_effect(/datum/status_effect/debuff/addiction)


/datum/charflaw/masochist/proc/get_pain_threshold(pain_amt)
	switch(pain_amt)
		if(-INFINITY to 50)
			return MASO_THRESHOLD_ONE
		if(50 to 95)
			return MASO_THRESHOLD_TWO
		if(95 to 140)
			return MASO_THRESHOLD_THREE
		if(140 to INFINITY)
			return MASO_THRESHOLD_FOUR

/proc/get_mammons_in_atom(atom/movable/movable)
	var/static/list/coins_types = typecacheof(/obj/item/coin)
	var/mammons = 0
	if(coins_types[movable.type])
		var/obj/item/coin/coin = movable
		mammons += coin.quantity * coin.sellprice
	for(var/atom/movable/content in movable.contents)
		mammons += get_mammons_in_atom(content)
	return mammons

/datum/charflaw/pacifist
	name = "Pacifist"
	desc = "I don't want to harm other living beings!"

/datum/charflaw/pacifist/after_spawn(mob/user, force = FALSE)
	var/mob/living/carbon/human/human_user = user
	if(!force && ((human_user.mind in GLOB.pre_setup_antags) || human_user.mind.has_antag_datum(/datum/antagonist)))
		human_user.get_random_flaw()
		human_user?.charflaw.after_spawn(human_user)
	else
		. = ..()
		ADD_TRAIT(user, TRAIT_PACIFISM, "[type]")

/datum/charflaw/pacifist/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_PACIFISM, "[type]")
