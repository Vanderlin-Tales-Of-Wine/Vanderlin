/datum/storyteller/noc
	name = "Noc"
	desc = "Noc will try to send more magical events."
	weight = 4
	always_votable = TRUE

	tag_multipliers = list(
		TAG_MAGICAL = 1.2,
		TAG_HAUNTED = 1.1,
	)
	cost_variance = 25

/datum/storyteller/ravox
	name = "Ravox"
	desc = "Ravox will cause raids to happen naturally instead of only when people are dying alot."
	weight = 4
	always_votable = TRUE

	tag_multipliers = list(
		TAG_RAID = 1.3,
	)

	point_gains_multipliers = list(
		EVENT_TRACK_MUNDANE = 0.75,
		EVENT_TRACK_MODERATE = 1,
		EVENT_TRACK_INTERVENTION = 1,
		EVENT_TRACK_CHARACTER_INJECTION = 1,
		EVENT_TRACK_OMENS = 1,
		EVENT_TRACK_RAIDS = 2,
	)

/datum/storyteller/abyssor
	name = "Abyssor"
	desc = "Abyssor likes to send water and trade related events."
	weight = 4
	always_votable = TRUE

	tag_multipliers = list(
		TAG_WATER = 1.3,
		TAG_TRADE = 1.2,
	)

/datum/storyteller/xylix
	name = "Xylix"
	desc = "Xylix is a wildcard, spinning the wheels of fate."
	weight = 4
	always_votable = TRUE
	event_repetition_multiplier = 0
	forced = TRUE

	point_gains_multipliers = list(
		EVENT_TRACK_MUNDANE = 1,
		EVENT_TRACK_MODERATE = 0,
		EVENT_TRACK_INTERVENTION = 0,
		EVENT_TRACK_CHARACTER_INJECTION = 0,
		EVENT_TRACK_OMENS = 0,
		EVENT_TRACK_RAIDS = 0,
	)


/datum/storyteller/xylix/find_and_buy_event_from_track(track)
	///we spin the dies of fate
	track = pick(EVENT_TRACKS)
	. = ..()

/datum/storyteller/necra
	name = "Necra"
	desc = "Necra takes things very slow, rarely bringing in newcomers."
	weight = 4
	always_votable = TRUE

	tag_multipliers = list(
		TAG_HAUNTED = 1.3,
	)

	point_gains_multipliers = list(
		EVENT_TRACK_MUNDANE = 1.25,
		EVENT_TRACK_MODERATE = 1.25,
		EVENT_TRACK_INTERVENTION = 1.25,
		EVENT_TRACK_CHARACTER_INJECTION = 0.5,
		EVENT_TRACK_OMENS = 1.25,
		EVENT_TRACK_RAIDS = 0.5,
	)

/datum/storyteller/pestra
	name = "Pestra"
	desc = "Pestra keeps things simple, with a slight bias towards alchemy."

	tag_multipliers = list(
		TAG_ALCHEMY = 1.2,
		TAG_MEDICAL = 1.2,
		TAG_NATURE = 1.1,
	)

/datum/storyteller/malum
	name = "Malum"
	desc = "Malum believes in hard work intervening more often then other."

	tag_multipliers = list(
		TAG_WORK = 1.5,
	)

	point_gains_multipliers = list(
		EVENT_TRACK_MUNDANE = 1,
		EVENT_TRACK_MODERATE = 1,
		EVENT_TRACK_INTERVENTION = 2,
		EVENT_TRACK_CHARACTER_INJECTION = 1,
		EVENT_TRACK_OMENS = 1,
		EVENT_TRACK_RAIDS = 1,
	)

/datum/storyteller/eora
	name = "Eora"
	desc = "Eora hates death, and promotes love. Raids will never naturally progress only death will bring them"

	tag_multipliers = list(
		TAG_WIDESPREAD = 1.5,
		TAG_BOON = 1.2,
	)

	point_gains_multipliers = list(
		EVENT_TRACK_MUNDANE = 1,
		EVENT_TRACK_MODERATE = 1,
		EVENT_TRACK_INTERVENTION = 2,
		EVENT_TRACK_CHARACTER_INJECTION = 1,
		EVENT_TRACK_OMENS = 1,
		EVENT_TRACK_RAIDS = 0,
	)

/datum/storyteller/dendor
	name = "Dendor"
	desc = "Dendor likes to send nature themed events."
	weight = 4
	always_votable = TRUE

	tag_multipliers = list(
		TAG_NATURE = 1.5,
	)

	point_gains_multipliers = list(
		EVENT_TRACK_MUNDANE = 1,
		EVENT_TRACK_MODERATE = 1,
		EVENT_TRACK_INTERVENTION = 2,
		EVENT_TRACK_CHARACTER_INJECTION = 1,
		EVENT_TRACK_OMENS = 1,
		EVENT_TRACK_RAIDS = 1,
	)
