/datum/patron/inhumen
	name = null
	associated_faith = /datum/faith/inhumen_pantheon

	profane_words = list()
	confess_lines = list(
		"PSYDON AND HIS CHILDREN ARE THE DEMIURGE!",
		"THE TEN ARE WORTHLESS COWARDS!",
		"THE TEN ARE DECEIVERS!"
	)

/datum/patron/inhumen/can_pray(mob/living/follower)
	for(var/obj/structure/fluff/psycross/cross in view(7, get_turf(follower)))
		if(!cross.obj_broken)
			to_chat(follower, span_danger("That accursed cross won't let me commune with the Forbidden One!"))
			return FALSE

	return TRUE

/* ----------------- */

/datum/patron/inhumen/zizo
	name = "Zizo"
	domain = "Ascended Goddess of Forbidden Magic, Domination, and Power"
	desc = "Snow Elf who slaughtered Her kind in ascension, conquered and remade the Dark Elven empires in Her name. She proves that any with will can achieve divinity... though at a cost."
	flaws = "Hubris, Superiority, Fury"
	worshippers = "Dark Elves, Aspirants, Necromancers"
	sins = "Pearl-clutching, Moralism, Wastefulness"
	boons = "You know other followers of Zizo when you see them."
	added_traits = list(TRAIT_CABAL)
	confess_lines = list(
		"I FOLLOW THE PATH OF ZIZO!",
		"LONG LIVE QUEEN ZIZO!",
		"ZIZO SHOWED ME THE WAY!",
	)

/datum/patron/inhumen/graggar
	name = "Graggar"
	domain = "Ascended God, the Dark Sini-Star of Unnatural Beasts, Unsated Consumption, and Unbridled Hatred"
	desc = "Became the first orc upon ascension through His habit of consuming the bodies of those He conquered. His forces continue to ravage the lands in His name. Through him, one may achieve true strength."
	flaws = "Rage, Hatred, Bloodthirst"
	worshippers = "Greenskins, The Revenge-Driven, Sadists"
	sins = "Compassion, Frailty, Servility"
	boons = "You are drawn to the flavour of raw flesh and organs, and may consume without worry."
	added_traits = list(TRAIT_ORGAN_EATER)
	confess_lines = list(
		"GRAGGAR IS THE BEAST I WORSHIP!",
		"GRAGGAR WILL RAVAGE YOU!",
		"GRAGGAR BRINGS UNHOLY DESTRUCTION!"
	)

/datum/patron/inhumen/matthios
	name = "Matthios"
	domain = "God of Thievery, Ill-Gotten Gains, and Highwaymen"
	desc = "Legendary humen bandit whose greatest thievery was a spark of divinity through which He ascended himself. It is because of He that nobles clutch their coin purses to their chests in town."
	flaws = "Pride, Greed, Orneryness"
	worshippers = "Outlaws, Noble-Haters, Downtrodden Peasantry"
	sins = "Clumsiness, Stupidity, Humility"
	boons = "You can see the most expensive item someone is carrying."
	added_traits = list(TRAIT_MATTHIOS_EYES)
	confess_lines = list(
		"MATTHIOS STEALS FROM THE WORTHLESS!",
		"MATTHIOS IS JUSTICE FOR THE COMMON MAN!",
		"MATTHIOS IS MY LORD, I SHALL BE HIS MARTYR!",
	)

/datum/patron/inhumen/baotha
	name = "Baotha"
	domain = "Goddess of Drugs, Self-Preservation, and Remorseless Joy"
	desc = "Ascended, formerly disgraced tiefling consort notorious for having a mind elsewhere. Through Her envy and callous distaste, she traded her family's life for a shipment of powder. As she preaches to her followers, 'Joy at all costs!'"
	flaws = "Enviousness, Self-Destruction, Willingness to Sacrifice Others"
	worshippers = "Addicts, Gamblers, the Motherless and Maidenless"
	sins = "Sobriety, Self-Sacrifice, Faltering Willpower"
	boons = "You will never overdose on drugs."
	added_traits = list(TRAIT_CRACKHEAD)
	confess_lines = list(
		"LIVE, LAUGH, LOVE! IN BAOTHA'S NAME!",
		"JOY AT ALL COSTS! BAOTHA'S TEACHINGS REIGN!",
		"BAOTHA'S WHISPERS CALM MY MIND!",
	)

/// Maniac Patron
/datum/patron/inhumen/graggar_zizo
	name = "Graggazo"
	domain = "Ascended God who slaughtered Her kind in ascension, the Dark Sini-Star of Unnatural Beasts, Forbidden Magic, and Unbridled Hatred."
	desc = "Became the first Snow orc upon ascension through His habit of consuming the bodies of those He conquered. His forces continue to ravage the lands in His name. She proves that any with will can achieve divinity... though at a cost."
	flaws = "Rage, Superiority, Bloodthirst"
	worshippers = "Dark Elves, The Revenge-Driven, Necromancers"
	sins = "Compassion, Wastefulness, Servility"
	boons = "You are drawn to the flavour of other followers of Zizo, and may see them when you consume without worry."
	added_traits = list(TRAIT_ORGAN_EATER, TRAIT_CABAL)
	confess_lines = list(
		"WHERE AM I!",
		"NONE OF THIS IS REAL!",
		"WHO AM I WORSHIPPING?!"
	)
	non_faith = TRUE

/datum/patron/inhumen/graggar_zizo/can_pray(mob/living/follower)
	var/datum/antagonist/maniac/dreamer = follower.mind.has_antag_datum(/datum/antagonist/maniac)
	if(!dreamer)
		// if a non-maniac somehow gets this patron,
		// something interesting should happen if they try to pray
		return FALSE
	return TRUE

/datum/patron/inhumen/graggar_zizo/hear_prayer(mob/living/follower, message)
	var/datum/antagonist/maniac/dreamer = follower.mind.has_antag_datum(/datum/antagonist/maniac)
	if(!dreamer)
		return FALSE

	// something interesting should happen...

	. = ..()
