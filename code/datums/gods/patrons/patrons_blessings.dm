/// Admin proc to apply or remove blessings from a character
/// Supports timed expiration, auto-removal on sleep, and dynamic flavor text injection
/datum/admins/proc/admin_bless(mob/living/carbon/human/M in GLOB.mob_list)
	set name = "Bless"
	set desc = "Bless or lift a blessing from a character"
	set category = "GameMaster"

	if(!check_rights())
		return FALSE

	var/category = input("Select Blessing Category") as null|anything in list("Divine", "Food", "Special", "Mending")
	if(!category)
		return FALSE

	var/blessing_path
	switch(category)
		if("Divine")
			blessing_path = input("Choose Divine Blessing") as null|anything in list( \
				/datum/status_effect/buff/noc, \
				/datum/status_effect/buff/ravox, \
				/datum/status_effect/buff/beastsense, \
				/datum/status_effect/buff/trollshape, \
				/datum/status_effect/buff/divine_beauty, \
				/datum/status_effect/buff/call_to_arms, \
				/datum/status_effect/buff/craft_buff)
		if("Food")
			blessing_path = input("Choose Food Blessing") as null|anything in list( \
				/datum/status_effect/buff/foodbuff, \
				/datum/status_effect/buff/clean_plus)
		if("Special")
			blessing_path = input("Choose Special Blessing") as null|anything in list( \
				/datum/status_effect/buff/duration_modification/featherfall, \
				/datum/status_effect/buff/duration_modification/darkvision, \
				/datum/status_effect/buff/duration_modification/haste, \
				/datum/status_effect/buff/calm, \
				/datum/status_effect/buff/barbrage)
		if("Mending")
			var/mending_amount = input("Choose Lifeblood Amount") as null|anything in list(5, 10, 15, 20, 25, 30)
			if(!mending_amount)
				return FALSE

			if(!M || !M.reagents)
				to_chat(usr, span_warning("[M] has no reagent container."))
				return FALSE

			M.reagents.add_reagent(/datum/reagent/medicine/stronghealth, mending_amount)
			var/patron_name = (M.patron && istype(M.patron)) ? M.patron.name : "a divine presence"
			to_chat(M, span_nicegreen("You feel your body renewing. [patron_name] has renewed your body with temporary divinity."))
			to_chat(usr, span_notice("You mended [M] with [mending_amount] units of Lifeblood."))
			log_admin("[key_name(usr)] mended [key_name(M)] with [mending_amount] units of Lifeblood.")
			return TRUE

	if(!blessing_path)
		return FALSE

	var/duration_choice = input("Select Duration for the Blessing:") as null|anything in list( \
		"1 Minute", "5 Minutes", "10 Minutes", "20 Minutes", \
		"30 Minutes", "60 Minutes", "Until Sleep", "Infinite")
	if(!duration_choice)
		return FALSE

	var/until_sleep = FALSE
	var/duration = -1
	switch(duration_choice)
		if("1 Minute") duration = 1 MINUTES
		if("5 Minutes") duration = 5 MINUTES
		if("10 Minutes") duration = 10 MINUTES
		if("20 Minutes") duration = 20 MINUTES
		if("30 Minutes") duration = 30 MINUTES
		if("60 Minutes") duration = 60 MINUTES
		if("Until Sleep") until_sleep = TRUE
		if("Infinite") duration = -1

	/// Apply Blessing
	if(M.apply_status_effect(blessing_path))
		message_admins(span_notice("Admin [key_name_admin(usr)] blessed [key_name_admin(M)] with [blessing_path]! Duration: [duration_choice]."))
		log_admin("[key_name(usr)] blessed [key_name(M)] with [blessing_path] for [duration_choice].")

		M.playsound_local(get_turf(M), 'sound/magic/bless.ogg', 100, FALSE)

		var/flavor_text = get_patron_blessing_text(M, blessing_path)
		if(flavor_text)
			to_chat(M, span_nicegreen("[flavor_text]"))

		/// Set actual expiration if needed (manual override for duration_modification types)
		if(duration > 0)
			var/datum/status_effect/active = M.get_status_effect(blessing_path)
			if(active && istype(active, /datum/status_effect/buff/duration_modification))
				active.duration = world.time + duration
			M.start_blessing_duration_timer(blessing_path, duration)

		if(until_sleep)
			M.start_blessing_sleep_monitor(blessing_path)

		var/alert_desc = flavor_text ? span_nicegreen("[flavor_text]") : span_nicegreen("A divine force blesses you!")
		M.modify_blessing_alert_desc(blessing_path, alert_desc)

		return TRUE

	/// Toggle Off: Remove if present
	else if(M.remove_status_effect(blessing_path))
		message_admins(span_notice("Admin [key_name_admin(usr)] lifted blessing [blessing_path] from [key_name_admin(M)]!"))
		log_admin("[key_name(usr)] lifted blessing [key_name(M)] from [blessing_path].")
		return TRUE

	return FALSE


/// Starts a timer to auto-remove the blessing after duration expires
/mob/living/proc/start_blessing_duration_timer(blessing_path, duration)
	spawn(duration)
		if(has_status_effect(blessing_path))
			remove_status_effect(blessing_path)
			to_chat(src, span_warning("Your blessing fades with time..."))

/// Monitors if the mob falls asleep, removing the blessing if so
/mob/living/proc/start_blessing_sleep_monitor(blessing_path)
	spawn while(has_status_effect(blessing_path))
		if(IsSleeping())
			remove_status_effect(blessing_path)
			to_chat(src, span_warning("Your blessing fades as you fall asleep..."))
			return
		sleep(10)  /// Adjust check frequency as needed

/// Dynamically modifies the alert description for the active blessing
/// Can be used to customize Trollshape or any other active buff's description
/mob/living/proc/modify_blessing_alert_desc(blessing_path, new_desc)
	if(!blessing_path || !new_desc)
		return FALSE

	var/datum/status_effect/B = get_status_effect(blessing_path)
	if(!B || !B.alert_type)
		to_chat(src, span_warning("No active buff or invalid blessing path found to modify."))
		return FALSE

	for(var/atom/movable/screen/alert/A in client.screen)
		if(istype(A, B.alert_type))
			A.desc = new_desc
			//to_chat(src, span_notice("Blessing visual updated: [new_desc]"))
			return TRUE

	to_chat(src, span_warning("Could not find active alert instance for the blessing."))
	return FALSE

/// Returns the active status effect datum for the given type if it exists on the mob
/mob/living/proc/get_status_effect(path)
	if(!status_effects)
		return null
	for(var/datum/status_effect/B in status_effects)
		if(istype(B, path))
			return B
	return null

/// Returns the immersive flavor text based on both the target's patron and the specific blessing applied
/// Falls back to generic patron text or a default generic divine message
/// Returns the immersive flavor text based on both the target's patron and the specific blessing applied
/// Fully extended for Abyssor, Astrata, Baotha, Dendor, Eora, Graggar, Malum, Matthios, Necra, Noc, Pestra, Ravox, Xylix, Zizo
/proc/get_patron_blessing_text(mob/living/carbon/human/M, blessing_path)
	var/patron_type = M.patron?.type
	if(!patron_type)
		return "A divine force surges through you, wrapping your soul in unseen power."

	/// Specific god -> specific blessing mapping
	var/static/list/blessing_flavor = list(
		/// Abyssor – The Sunken God
		/datum/patron/divine/abyssor = list(
			/datum/status_effect/buff/beastsense = "Abyssor whispers: \"The sea calls your senses forth. Smell the salt, taste the fear.\"",
			/datum/status_effect/buff/trollshape = "Abyssor groans: \"The abyss grants form... and hungers for more.\"",
			/datum/status_effect/buff/divine_beauty = "Abyssor rumbles: \"Even beauty drowns. But for now, you rise.\"",
			/datum/status_effect/buff/call_to_arms = "Abyssor intones: \"The currents surge. You follow, or you sink.\"",
			/datum/status_effect/buff/craft_buff = "Abyssor echoes: \"Stone crumbles, but the deep remembers your craft.\"",
			/datum/status_effect/buff/foodbuff = "Abyssor bubbles: \"Eat... but know the sea waits to feast in turn.\"",
			/datum/status_effect/buff/clean_plus = "Abyssor sighs: \"The salt cleanses... for now.\"",
			/datum/status_effect/buff/duration_modification/featherfall = "Abyssor murmurs: \"Float... like a corpse on the tide.\"",
			/datum/status_effect/buff/duration_modification/darkvision = "Abyssor growls: \"See the depths, where no sun reaches.\"",
			/datum/status_effect/buff/duration_modification/haste = "Abyssor growls: \"Flee if you must... the sea is patient.\"",
			/datum/status_effect/buff/calm = "Abyssor whispers: \"Still... as the trench waits.\"",
			/datum/status_effect/buff/barbrage = "Abyssor bellows: \"Like the storm tide, break them!\""
		),

		/// (Repeat this block, tailored for each god)
		/// Astrata - The Sun Queen
		/datum/patron/divine/astrata = list(
			/datum/status_effect/buff/beastsense = "Astrata commandeth: \"LET THY SIGHT BE CLEARED. THE LIGHT REVEALETH ALL.\"",
			/datum/status_effect/buff/trollshape = "Astrata proclaimeth: \"BECOME THE HAMMER OF MINE WILL. STRIKE WITH PURPOSE.\"",
			/datum/status_effect/buff/divine_beauty = "Astrata speaketh: \"RADIATE THY DUTY. LET NONE AVERT THEIR GAZE.\"",
			/datum/status_effect/buff/call_to_arms = "Astrata belloweth: \"RISE, O RIGHTEOUS ONE. MARCH TO GLORY IN MINE NAME.\"",
			/datum/status_effect/buff/craft_buff = "Astrata declareth: \"LET THINE HANDS BUILD THAT WHICH SHALL ENDURE.\"",
			/datum/status_effect/buff/foodbuff = "Astrata blesseth: \"FEAST AND GROW STRONG BENEATH MINE EVER-WATCHFUL GAZE.\"",
			/datum/status_effect/buff/clean_plus = "Astrata proclaims: \"THE LIGHT CLEANSETH ALL. DIRT SHALL NOT ENDURE.\"",
			/datum/status_effect/buff/duration_modification/featherfall = "Astrata commandeth: \"ASCEND, FOR THOU ART WORTHY OF HEIGHT.\"",
			/datum/status_effect/buff/duration_modification/darkvision = "Astrata scoffeth: \"SHADOWS ARE FOR THE FAINT. THOU NEEDST THEM NOT.\"",
			/datum/status_effect/buff/duration_modification/haste = "Astrata ordereth: \"SWIFT BE THY FEET. DUTY BROOKETH NO DELAY.\"",
			/datum/status_effect/buff/calm = "Astrata whispereth: \"BE STILL. THE SUN KEEPETH THEE SAFE.\"",
			/datum/status_effect/buff/barbrage = "Astrata declareth: \"LET THY RIGHTEOUS FURY BURN AS MINE SUN.\""
		),

		/// Baotha - The Mad God
		/datum/patron/inhumen/baotha = list(
			/datum/status_effect/buff/beastsense = "Baotha shrieks: \"See it! Smell it! Rip it apart! Or hug it! Both are valid!\"",
			/datum/status_effect/buff/trollshape = "Baotha howls: \"Big. Ugly. Perfect. You’re gonna cause SUCH a scene!\"",
			/datum/status_effect/buff/divine_beauty = "Baotha swoons: \"Beauty fit for a queen. I'd know.\"",
			/datum/status_effect/buff/call_to_arms = "Baotha cackles: \"Ready to finally have some FUN?\"",
			/datum/status_effect/buff/craft_buff = "Baotha snorts: \"Glue it wrong. Smash it anyway! If it works, it’s ART!\"",
			/datum/status_effect/buff/foodbuff = "Baotha hoots: \"Eat it! If it giggles back... bonus!\"",
			/datum/status_effect/buff/clean_plus = "Baotha coughs: \"CLEAN? Hah! Let’s see how long it lasts, neat freak.\"",
			/datum/status_effect/buff/duration_modification/featherfall = "Baotha shrieks: \"WHEEEEE! Don’t die!\"",
			/datum/status_effect/buff/duration_modification/darkvision = "Baotha giggles: \"Oooo, secrets! Don’t blink or you’ll miss the eyes!\"",
			/datum/status_effect/buff/duration_modification/haste = "Baotha screams: \"FASTER! It’s a dance, not a walk!\"",
			/datum/status_effect/buff/calm = "Baotha reassures: \"Sink into the serenity of mindlessness. Let NO-ONE stop you!\"",
			/datum/status_effect/buff/barbrage = "Baotha squeals: \"BREAK SOMETHING BEAUTIFUL! It’s therapeutic!\""
		),

		/// Dendor - The Wildfather
		/datum/patron/divine/dendor = list(
			/datum/status_effect/buff/beastsense = "Dendor growls: \"The hunt begins. Death follows.\"",
			/datum/status_effect/buff/trollshape = "Dendor mutters: \"Flesh grows thick, bone bends. Still, rot awaits.\"",
			/datum/status_effect/buff/divine_beauty = "Dendor sighs: \"Bloom... then wilt.\"",
			/datum/status_effect/buff/call_to_arms = "Dendor commands: \"Tear the earth, spill the blood. Return it all to soil.\"",
			/datum/status_effect/buff/craft_buff = "Dendor states: \"Stone. Wood. All things decay. But build... while you can.\"",
			/datum/status_effect/buff/foodbuff = "Dendor grunts: \"Eat. All feeds the earth, eventually.\"",
			/datum/status_effect/buff/clean_plus = "Dendor rasps: \"You wipe the rot... but it returns.\"",
			/datum/status_effect/buff/duration_modification/featherfall = "Dendor warns: \"Even leaves fall in the end.\"",
			/datum/status_effect/buff/duration_modification/darkvision = "Dendor growls: \"See the dark roots. Smell the rot.\"",
			/datum/status_effect/buff/duration_modification/haste = "Dendor grumbles: \"Run fast. The wolves do.\"",
			/datum/status_effect/buff/calm = "Dendor breathes: \"Stillness... before the end.\"",
			/datum/status_effect/buff/barbrage = "Dendor growls: \"Rend them. Spill the red.\""
		),

		/// Eora - The Heart of Psydon
		/datum/patron/divine/eora = list(
			/datum/status_effect/buff/beastsense = "Eora whispers: \"Even the beasts know love's call.\"",
			/datum/status_effect/buff/trollshape = "Eora coos: \"Strong arms, tender heart.\"",
			/datum/status_effect/buff/divine_beauty = "Eora smiles: \"You shine, beloved. All gaze upon you with wonder.\"",
			/datum/status_effect/buff/call_to_arms = "Eora urges: \"Fight for love. For them.\"",
			/datum/status_effect/buff/craft_buff = "Eora hums: \"Hands that build with love make wonders eternal.\"",
			/datum/status_effect/buff/foodbuff = "Eora sings: \"Eat well, my sweet. Love fuels you.\"",
			/datum/status_effect/buff/clean_plus = "Eora beams: \"I wash away your hurts, my dear.\"",
			/datum/status_effect/buff/duration_modification/featherfall = "Eora hums: \"Softly now. I hold you.\"",
			/datum/status_effect/buff/duration_modification/darkvision = "Eora comforts: \"See even where light fears to go.\"",
			/datum/status_effect/buff/duration_modification/haste = "Eora nudges: \"Hurry, beloved. They wait for you.\"",
			/datum/status_effect/buff/calm = "Eora soothes: \"Hush... Breathe... You are safe.\"",
			/datum/status_effect/buff/barbrage = "Eora whispers: \"Love rages too. Protect what’s yours.\""
		),

		/// Graggar - The Warborn Beast
		/datum/patron/inhumen/graggar = list(
			/datum/status_effect/buff/beastsense = "Graggar growls: \"Sniff it. Smell the fear, thu fool.\"",
			/datum/status_effect/buff/trollshape = "Graggar roars: \"Meat swells. Thu strong. Thu crush now.\"",
			/datum/status_effect/buff/divine_beauty = "Graggar spits: \"Pah! Pretty? WASTE! Git bloody, thu fole!\"",
			/datum/status_effect/buff/call_to_arms = "Graggar bellows: \"Raise swerd. Kill 'em fast. Or die, weakling!\"",
			/datum/status_effect/buff/craft_buff = "Graggar smirks: \"Build? HA! Smash it till 'tis strong!\"",
			/datum/status_effect/buff/foodbuff = "Graggar snorts: \"Meat good. Git strong.\"",
			/datum/status_effect/buff/clean_plus = "Graggar spits: \"Clean? Bah. Mud good fer ya.\"",
			/datum/status_effect/buff/duration_modification/featherfall = "Graggar snorts: \"Pah! Drop faster next time.\"",
			/datum/status_effect/buff/duration_modification/darkvision = "Graggar huffs: \"See 'em hidin'. Then kill 'em.\"",
			/datum/status_effect/buff/duration_modification/haste = "Graggar yells: \"Fast now! Get killin'!\"",
			/datum/status_effect/buff/calm = "Graggar grumbles: \"Pff. Calm’s fer weaklings.\"",
			/datum/status_effect/buff/barbrage = "Graggar roars: \"RAAAGH! Smash 'em flat!\""
		),

		/// Malum - The Iron Lord
		/datum/patron/divine/malum = list(
			/datum/status_effect/buff/beastsense = "Malum grunts: \"Even beasts know craft. So should you.\"",
			/datum/status_effect/buff/trollshape = "Malum states: \"Strong arms make stronger tools.\"",
			/datum/status_effect/buff/divine_beauty = "Malum hammers: \"Beauty fades. Steel remains.\"",
			/datum/status_effect/buff/call_to_arms = "Malum intones: \"Hammer strikes. Blood flows. This is labor's price.\"",
			/datum/status_effect/buff/craft_buff = "Malum orders: \"Work harder. Or break.\"",
			/datum/status_effect/buff/foodbuff = "Malum grunts: \"Eat. Fuel the forge within.\"",
			/datum/status_effect/buff/clean_plus = "Malum nods: \"Clean steel. Good steel.\"",
			/datum/status_effect/buff/duration_modification/featherfall = "Malum mutters: \"Floatin’s for feathers... not iron.\"",
			/datum/status_effect/buff/duration_modification/darkvision = "Malum growls: \"See what lurks. Strike it down.\"",
			/datum/status_effect/buff/duration_modification/haste = "Malum commands: \"Faster. The forge waits not.\"",
			/datum/status_effect/buff/calm = "Malum states: \"Temper your rage. Forge it right.\"",
			/datum/status_effect/buff/barbrage = "Malum snarls: \"Unleash it. Strike like the hammer.\""
		),

		/// Matthios - The Bandit God
		/datum/patron/inhumen/matthios = list(
			/datum/status_effect/buff/beastsense = "Matthios laughs: \"Sniff it out, lad. Something worth stealing.\"",
			/datum/status_effect/buff/trollshape = "Matthios grins: \"Ugly sells well in some towns, friend.\"",
			/datum/status_effect/buff/divine_beauty = "Matthios smirks: \"Pretty coin, pretty face... both stolen easy.\"",
			/datum/status_effect/buff/call_to_arms = "Matthios shouts: \"Fight dirty. Win rich.\"",
			/datum/status_effect/buff/craft_buff = "Matthios shrugs: \"Build fast. Sell faster.\"",
			/datum/status_effect/buff/foodbuff = "Matthios grins: \"Eat now... pay later.\"",
			/datum/status_effect/buff/clean_plus = "Matthios cackles: \"Cleaned up nice... for a mark.\"",
			/datum/status_effect/buff/duration_modification/featherfall = "Matthios chuckles: \"Fall soft... means you live to steal again.\"",
			/datum/status_effect/buff/duration_modification/darkvision = "Matthios winks: \"See the dark? Hide better.\"",
			/datum/status_effect/buff/duration_modification/haste = "Matthios shouts: \"Quick hands win riches.\"",
			/datum/status_effect/buff/calm = "Matthios smirks: \"Calm? Nah, means they don’t see you comin'.\"",
			/datum/status_effect/buff/barbrage = "Matthios yells: \"Break stuff. Blame someone else!\""
		),

		/// Necra - The Undermaiden
		/datum/patron/divine/necra = list(
			/datum/status_effect/buff/beastsense = "Necra murmurs: \"The grave knows your scent... and waits.\"",
			/datum/status_effect/buff/trollshape = "Necra hums: \"Mass returns to earth. Let the soil remember you.\"",
			/datum/status_effect/buff/divine_beauty = "Necra whispers: \"Even beauty rots. But for now... wear it.\"",
			/datum/status_effect/buff/call_to_arms = "Necra states: \"Raise thy blade. All paths end the same.\"",
			/datum/status_effect/buff/craft_buff = "Necra sighs: \"All things break. But make them still.\"",
			/datum/status_effect/buff/foodbuff = "Necra croons: \"Feast while you breathe. The hunger ends soon.\"",
			/datum/status_effect/buff/clean_plus = "Necra sighs: \"You may wash the flesh... but not the fate.\"",
			/datum/status_effect/buff/duration_modification/featherfall = "Necra hums: \"Fall gently. The earth shall catch you.\"",
			/datum/status_effect/buff/duration_modification/darkvision = "Necra whispers: \"The dark is not empty. It welcomes.\"",
			/datum/status_effect/buff/duration_modification/haste = "Necra murmurs: \"Quickly now. Time thins beneath your feet.\"",
			/datum/status_effect/buff/calm = "Necra soothes: \"Rest... the silence shall come for all.\"",
			/datum/status_effect/buff/barbrage = "Necra intones: \"Rage, if you must. The dead are silent, but not still.\""
		),

		/// Noc - The Shadow Walker
		/datum/patron/divine/noc = list(
			/datum/status_effect/buff/beastsense = "Noc whispers: \"The dark sees what the day fears.\"",
			/datum/status_effect/buff/trollshape = "Noc hisses: \"Shadows swell your shape... for now.\"",
			/datum/status_effect/buff/divine_beauty = "Noc murmurs: \"Beauty hidden. Power unseen.\"",
			/datum/status_effect/buff/call_to_arms = "Noc fades: \"Strike from shadow. Leave none to tell.\"",
			/datum/status_effect/buff/craft_buff = "Noc breathes: \"Build in secret. None must know.\"",
			/datum/status_effect/buff/foodbuff = "Noc hisses: \"Feed. But stay unseen.\"",
			/datum/status_effect/buff/clean_plus = "Noc rasps: \"Shadows clean better than light.\"",
			/datum/status_effect/buff/duration_modification/featherfall = "Noc whispers: \"Float... like shadow.\"",
			/datum/status_effect/buff/duration_modification/darkvision = "Noc hisses: \"See what others fear.\"",
			/datum/status_effect/buff/duration_modification/haste = "Noc murmurs: \"Swift... unseen...\"",
			/datum/status_effect/buff/calm = "Noc soothes: \"Quiet... the dark waits.\"",
			/datum/status_effect/buff/barbrage = "Noc snarls: \"Kill... from the dark.\""
		),

		/// Pestra - The Plague Mother
		/datum/patron/divine/pestra = list(
			/datum/status_effect/buff/beastsense = "Pestra bemuses: \"Sniff it. Identify its substance—not that cycles of rot would harm you.\"",
			/datum/status_effect/buff/trollshape = "Pestra wheezes: \"Thick skin, bad breath. You’re a fascinating specimen.\"",
			/datum/status_effect/buff/divine_beauty = "Pestra muses: \"Unblemished... Curious. Beauty often masks the most virulent flaws.\"",
			/datum/status_effect/buff/call_to_arms = "Pestra howls: \"Some bones must be broken before one may mend them.\"",
			/datum/status_effect/buff/craft_buff = "Pestra giggles: \"Change is divine. One compound into another—chaos with purpose.\"",
			/datum/status_effect/buff/foodbuff = "Pestra comments: \"Be nourished. Spoilage is just misunderstood fermentation.\"",
			/datum/status_effect/buff/clean_plus = "Pestra scoffs: \"Cleanliness? Temporary at best. Let’s see how long it lasts.\"",
			/datum/status_effect/buff/duration_modification/featherfall = "Pestra hiccups: \"You sink through water but fall through air. What if we reversed this?\"",
			/datum/status_effect/buff/duration_modification/darkvision = "Pestra grins: \"Observe! Mold reveals more than sunlight ever could.\"",
			/datum/status_effect/buff/duration_modification/haste = "Pestra snaps: \"Faster now! Spores don’t wait to bloom.\"",
			/datum/status_effect/buff/calm = "Pestra whispers: \"Stillness... Let the fever sleep awhile.\"",
			/datum/status_effect/buff/barbrage = "Pestra shrieks: \"Break what you cannot understand. Reassembly is half the fun.\""
		),

		/// Ravox - The Warlord
		/datum/patron/divine/ravox = list(
			/datum/status_effect/buff/beastsense = "Ravox growls: \"Smell your enemy. Hunt him down with purpose.\"",
			/datum/status_effect/buff/trollshape = "Ravox commands: \"Let might serve justice. Let strength carry duty.\"",
			/datum/status_effect/buff/divine_beauty = "Ravox declares: \"Wear your glory well, warrior. Let honor shine brighter.\"",
			/datum/status_effect/buff/call_to_arms = "Ravox bellows: \"To war! Let no coward stain the front lines.\"",
			/datum/status_effect/buff/craft_buff = "Ravox nods: \"Forge victory with your hands. Let each blow ring true.\"",
			/datum/status_effect/buff/foodbuff = "Ravox grunts: \"Eat. Even the strong must endure the march.\"",
			/datum/status_effect/buff/clean_plus = "Ravox commands: \"Clean your blade. It shall be tainted again soon.\"",
			/datum/status_effect/buff/duration_modification/featherfall = "Ravox scoffs: \"Even the bold must fall with grace.\"",
			/datum/status_effect/buff/duration_modification/darkvision = "Ravox growls: \"See the coward. Bring them to justice.\"",
			/datum/status_effect/buff/duration_modification/haste = "Ravox barks: \"Swift feet carry righteous blades.\"",
			/datum/status_effect/buff/calm = "Ravox grunts: \"Still thy heart. The battle shall come.\"",
			/datum/status_effect/buff/barbrage = "Ravox roars: \"BE FILLED WITH RIGHTEOUS ANGER!\""
		),

		/// Xylix - The Trickster
		/datum/patron/divine/xylix = list(
			/datum/status_effect/buff/beastsense = "Xylix laughs: \"Sniff sniff! What's behind that tree? Chaos, I hope!\"",
			/datum/status_effect/buff/trollshape = "Xylix grins: \"Big, dumb, and hilarious. Perfect.\"",
			/datum/status_effect/buff/divine_beauty = "Xylix cackles: \"Shiny! Pretty! Now trip over it!\"",
			/datum/status_effect/buff/call_to_arms = "Xylix shouts: \"Time for a fun fight. Maybe you'll win. Maybe not!\"",
			/datum/status_effect/buff/craft_buff = "Xylix winks: \"Stack it wrong. Bet it still works!\"",
			/datum/status_effect/buff/foodbuff = "Xylix giggles: \"Eat that. Could be poison!\"",
			/datum/status_effect/buff/clean_plus = "Xylix chuckles: \"Clean now. Mess later.\"",
			/datum/status_effect/buff/duration_modification/featherfall = "Xylix howls: \"Whee! Hope ya bounce!\"",
			/datum/status_effect/buff/duration_modification/darkvision = "Xylix snickers: \"Ooo... spooky. Boo!\"",
			/datum/status_effect/buff/duration_modification/haste = "Xylix screams: \"FAST! Trip 'em!\"",
			/datum/status_effect/buff/calm = "Xylix hums: \"Calm... until it ain’t.\"",
			/datum/status_effect/buff/barbrage = "Xylix roars: \"Break it! Then break it twice!\""
		),

		/// Zizo - The Ascended Goddess
		/datum/patron/inhumen/zizo = list(
			/datum/status_effect/buff/beastsense = "Zizo hisses: \"Zey crawl. Zey beg. Zey are prey. Hunt zem.\"",
			/datum/status_effect/buff/trollshape = "Zizo croons: \"Zis form? Power. Ztrength. Zat is mine gift.\"",
			/datum/status_effect/buff/divine_beauty = "Zizo sneers: \"Zey shall kneel before zis visage. Et zey shall weep.\"",
			/datum/status_effect/buff/call_to_arms = "Zizo commands: \"Fight. Et break zem. Only strength matters.\"",
			/datum/status_effect/buff/craft_buff = "Zizo states: \"Ztrong. Unbending. Prove ze craft is worthy.\"",
			/datum/status_effect/buff/foodbuff = "Zizo smirks: \"Eat. Power grows.\"",
			/datum/status_effect/buff/clean_plus = "Zizo sneers: \"Clean. Now you are worthy of gaze.\"",
			/datum/status_effect/buff/duration_modification/featherfall = "Zizo hisses: \"Float above zem. They are beneath you.\"",
			/datum/status_effect/buff/duration_modification/darkvision = "Zizo purrs: \"See what zey hide. See all.\"",
			/datum/status_effect/buff/duration_modification/haste = "Zizo commands: \"Move. Do not stumble.\"",
			/datum/status_effect/buff/calm = "Zizo whispers: \"Calm now. Power awaits.\"",
			/datum/status_effect/buff/barbrage = "Zizo roars: \"Rend zem. Show zis strength!\""
		)
	)

	/// Return specific blessing line if available
	if(blessing_flavor[patron_type] && blessing_flavor[patron_type][blessing_path])
		return blessing_flavor[patron_type][blessing_path]

	/// Generic fallback
	return "A divine force surges through you, wrapping your soul in unseen power."
