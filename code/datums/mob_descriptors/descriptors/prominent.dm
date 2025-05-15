/datum/mob_descriptor/prominent
	abstract_type = /datum/mob_descriptor/prominent
	slot = MOB_DESCRIPTOR_SLOT_PROMINENT

/datum/mob_descriptor/prominent/none
	name = "None"

/datum/mob_descriptor/prominent/none/can_describe(mob/living/described)
	return FALSE

/datum/mob_descriptor/prominent/custom
	var/custom_index

/datum/mob_descriptor/prominent/custom/can_describe(mob/living/described)
	if(length(described.custom_descriptors) < custom_index)
		return FALSE
	return TRUE

/datum/mob_descriptor/prominent/custom/get_description(mob/living/described)
	var/datum/custom_descriptor_entry/entry = described.custom_descriptors[custom_index]
	return entry.content_text

/datum/mob_descriptor/prominent/custom/get_pre_string(mob/living/described)
	var/datum/custom_descriptor_entry/entry = described.custom_descriptors[custom_index]
	switch(entry.prefix_type)
		if(CUSTOM_PREFIX_HAS)
			return null
		if(CUSTOM_PREFIX_HAS_A)
			return "a "
		if(CUSTOM_PREFIX_HAS_AN)
			return "an "
		if(CUSTOM_PREFIX_IS)
			return null
		if(CUSTOM_PREFIX_LOOKS)
			return null

/datum/mob_descriptor/prominent/custom/get_verbage(mob/living/described)
	var/datum/custom_descriptor_entry/entry = described.custom_descriptors[custom_index]
	switch(entry.prefix_type)
		if(CUSTOM_PREFIX_HAS)
			return "%HAVE%"
		if(CUSTOM_PREFIX_HAS_A)
			return "%HAVE%"
		if(CUSTOM_PREFIX_HAS_AN)
			return "%HAVE%"
		if(CUSTOM_PREFIX_IS)
			return "is"
		if(CUSTOM_PREFIX_LOOKS)
			return "looks"

/datum/mob_descriptor/prominent/custom/one
	name = "Custom #1"
	custom_index = 1

/datum/mob_descriptor/prominent/custom/two
	name = "Custom #2"
	custom_index = 2

/datum/mob_descriptor/prominent/hunched_over
	name = "Hunched Over"
	verbage = "is"

/datum/mob_descriptor/prominent/crooked_nose
	name = "Crooked Nose"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/drooling
	name = "Drooling"
	verbage = "is"

/datum/mob_descriptor/prominent/lazy_eye
	name = "Lazy Eye"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/bloodshot_eye
	name = "Bloodshot Eyes"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/baggy_eye
	name = "Baggy Eyes"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/deadfish_eye
	name = "Dead Fish Eyes"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/twitchy
	name = "Twitchy"
	verbage = "is"

/datum/mob_descriptor/prominent/clumsy
	name = "Clumsy"
	verbage = "is"

/datum/mob_descriptor/prominent/unkempt
	name = "Unkempt"
	verbage = "is"

/datum/mob_descriptor/prominent/tidy
	name = "Tidy"
	verbage = "is"

/datum/mob_descriptor/prominent/eloquent
	name = "Eloquent"
	verbage = "is"

/datum/mob_descriptor/prominent/thick_tail/can_describe(mob/living/described)
	if(!ishuman(described))
		return TRUE
	var/mob/living/carbon/humanoid/human = described
	if(!human.getorganslot(ORGAN_SLOT_TAIL))
		return FALSE
	return TRUE

/datum/mob_descriptor/prominent/cleft_lip
	name = "Cleft Lip"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/physically_deformed
	name = "Physically Deformed"
	verbage = "is"

/datum/mob_descriptor/prominent/extensive_scars
	name = "Extensive Scarring"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/move_strange
	name = "Moves Strangely"

/datum/mob_descriptor/prominent/ghoulish_appearance
	name = "Ghoulish Appearance"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/prominent_chest
	name = "Prominent Chest"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/prominent_bottom
	name = "Prominent Posterior"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/prominent_potbelly
	name = "Potbelly"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/prominent_thighs
	name = "Fat Thighs"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/prominent_shoulders
	name = "Broad Shoulders"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/prominent_jawline
	name = "Jutting Jawline"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/cold_gaze
	name = "Cold Gaze"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/piercing_gaze
	name = "Piercing Gaze"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/innocent_gaze
	name = "Innocent Gaze"
	verbage = "%HAVE%"
	prefix = "an"

/datum/mob_descriptor/prominent/intimidating_presence
	name = "Intimidating Presence"
	verbage = "%HAVE%"
	prefix = "an"

/datum/mob_descriptor/prominent/meek_presence
	name = "Meek Presence"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/adorable_presence
	name = "Adorable Presence"
	verbage = "%HAVE%"
	prefix = "an"

/datum/mob_descriptor/prominent/lordly_presence
	name = "Lordly Presence"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/doting_presence
	name = "Doting Presence"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/aristocratic_haughtiness
	name = "Aristocratic Disdain"
	verbage = "%HAVE%"
	prefix = "an"

/datum/mob_descriptor/prominent/ghastly_pale
	name = "Ghastly Pale"
	verbage = "is"

/datum/mob_descriptor/prominent/elaborate_tattoos
	name = "Elaborate Tattoos"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/ritual_tattoos
	name = "Ritual Tattoos"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/tribal_tattoos
	name = "Tribal Tattoos"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/slave_tattoos
	name = "Slave Tattoos"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/enigmatic_tattoos
	name = "Enigmatic Tattoos"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/mean_look
	name = "Mean Look"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/haughty_atmosphere
	name = "Haughty Mannerisms"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/untrustworthy
	name = "Untrustworthy"
	verbage = "appears"

/datum/mob_descriptor/prominent/ratty_hair
	name = "Ratty Hair"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/predatory_look
	name = "Predatory Look"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/chaste_mannerism
	name = "Chaste Mannerisms"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/whimsy
	name = "Air of Whimsy"
	verbage = "%HAVE%"
	prefix = "an"
	suffix = "about %HIM%"

/datum/mob_descriptor/prominent/dim_look
	name = "Dim Look"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/keen_look
	name = "Keen Look"
	verbage = "%HAVE%"
	prefix = "a"


/datum/mob_descriptor/prominent/presence_stoic
	name = "Stoic Prescence"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/hands_platters
	name = "Hands like platters"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/hands_delicate
	name = "Delicate hands"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/fingers_long
	name = "Long fingers"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/teeth_fine
	name = "Fine Teeth"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/teeth_rotting
	name = "Rotting Teeth"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/teeth_missing
	name = "Missing Teeth"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/teeth_fine
	name = "Fine Teeth"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/laugh_donkey
	name = "Donkey-like Laugh"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/nose_crooked
	name = "Crooked Nose"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/nose_broken
	name = "Broken Nose"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/nose_button
	name = "Button Nose"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/nose_hawk
	name = "Hawkish Nose"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/nose_aquiline
	name = "Aquiline Nose"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/neck_bull
	name = "Bull Neck"
	verbage = "%HAVE%"
	prefix = "a"

/datum/mob_descriptor/prominent/hair_perfumed
	name = "Perfumed Hair"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/hair_oiled
	name = "Oiled Hair"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/hair_curly
	name = "Curly Hair"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/hair_coarse
	name = "Coarse Hair"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/hair_thin
	name = "Thin Hair"
	verbage = "%HAVE%"

/datum/mob_descriptor/prominent/ears_large
	name = "Large Ears"
	verbage = "%HAVE%"

