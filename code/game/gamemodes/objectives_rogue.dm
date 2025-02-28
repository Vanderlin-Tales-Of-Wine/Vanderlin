/datum/objective/bandit
	name = "bandit"
	explanation_text = "Feed valuables to the idol."

/datum/objective/bandit/check_completion()
	if(SSmapping.retainer.bandit_contribute >= SSmapping.retainer.bandit_goal)
		return TRUE

/datum/objective/bandit/update_explanation_text()
	..()
	explanation_text = "Feed [SSmapping.retainer.bandit_goal] mammon to an idol of greed."


/datum/objective/delf
	name = "delf"
	explanation_text = "Feed honeys to the mother."

/datum/objective/delf/check_completion()
	if(SSmapping.retainer.delf_contribute >= SSmapping.retainer.delf_goal)
		return TRUE

/datum/objective/delf/update_explanation_text()
	..()
	explanation_text = "Feed [SSmapping.retainer.delf_goal] honeys to the mother."


/datum/objective/rt_maniac
	name = "slaying"
	explanation_text = "Mark pieces of flesh and leave them to be discovered. Have at least 4 different people witness your crimes."
	martyr_compatible = 0
	triumph_count = 10
	var/people_seen[0]

/datum/objective/rt_maniac/check_completion()
	if(people_seen.len >= 4)
		return TRUE

/// Werewolf related

/datum/objective/werewolf/conquer
	name = "conquer"
	explanation_text = "Destroy all elder vampires in Vanderlin. I can sniff them in my true form."
	team_explanation_text = ""
	triumph_count = 5

/datum/objective/werewolf/conquer/check_completion()
	if(vampire_werewolf() == "werewolf")
		return TRUE

/datum/objective/werewolf/spread
	name = "spread"
	explanation_text = "Have 6 lesser werewolf."
	triumph_count = 5

/datum/objective/werewolf/spread/check_completion()
	if(length(SSmapping.retainer.werewolves) >= 6)
		return TRUE

/datum/objective/werewolf/infiltrate/one
	name = "infiltrate1"
	explanation_text = "Infect a member of the Church my spawn."
	triumph_count = 5

/datum/objective/werewolf/infiltrate/one/check_completion()
	var/list/churchjobs = list("Priest", "Priestess", "Cleric", "Acolyte", "Templar", "Churchling", "Crusader", "Inquisitor")
	for(var/datum/mind/V in SSmapping.retainer.werewolves)
		if(V.current.job in churchjobs)
			return TRUE

/datum/objective/werewolf/infiltrate/two
	name = "infiltrate2"
	explanation_text = "Infect a member of the Nobility."
	triumph_count = 5

/datum/objective/werewolf/infiltrate/two/check_completion()
	var/list/noblejobs = list("Monarch", "Consort", "Prince", "Captain", "Hand", "Steward")
	for(var/datum/mind/V in SSmapping.retainer.werewolves)
		if(V.current.job in noblejobs)
			return TRUE

/datum/objective/werewolf/survive
	name = "survive"
	explanation_text = "My lycanthropia won't allow me to die, I musn't die."
	triumph_count = 3

/datum/objective/werewolf/survive/check_completion()
	if(considered_alive(owner))
		return TRUE

/// Vampire related (OLD)

/datum/objective/vampire
	name = "conquer"
	explanation_text = "Destroy all alpha werewolves in Vanderlin. I can detect them in my true form."
	team_explanation_text = ""
	triumph_count = 5

/datum/objective/vampire/check_completion()
	if(vampire_werewolf() == "vampire")
		return TRUE

/// Vampire related (NEW)

/datum/objective/vampirelord/conquer
	name = "conquer"
	explanation_text = "Make the Ruler of Vanderlin bow to my will."
	team_explanation_text = ""
	triumph_count = 5

/datum/objective/vampirelord/conquer/check_completion()
	if(SSmapping.retainer.king_submitted)
		return TRUE

/datum/objective/vampirelord/ascend
	name = "sun"
	explanation_text = "Astrata has spurned me long enough. I must conquer the Sun."
	team_explanation_text = ""
	triumph_count = 5

/datum/objective/vampirelord/ascend/check_completion()
	if(SSmapping.retainer.ascended)
		return TRUE

/datum/objective/vampirelord/destroy
	name = "destroy"
	explanation_text = "Destroy all alpha werewolves in Vanderlin. I can detect them in my true form."
	team_explanation_text = ""
	triumph_count = 5

/datum/objective/vampirelord/destroy/check_completion()
	if(vampire_werewolf() == "vampire")
		return TRUE


/datum/objective/vampirelord/infiltrate/one
	name = "infiltrate1"
	explanation_text = "Make a member of the Church my spawn."
	triumph_count = 5

/datum/objective/vampirelord/infiltrate/one/check_completion()
	var/list/churchjobs = list("Priest", "Priestess", "Cleric", "Acolyte", "Templar", "Churchling", "Crusader", "Inquisitor")
	for(var/datum/mind/V in SSmapping.retainer.vampires)
		if(V.current.job in churchjobs)
			return TRUE

/datum/objective/vampirelord/infiltrate/two
	name = "infiltrate2"
	explanation_text = "Make a member of the Nobility my spawn."
	triumph_count = 5

/datum/objective/vampirelord/infiltrate/two/check_completion()
	var/list/noblejobs = list("Monarch", "Consort", "Prince", "Captain", "Hand", "Steward")
	for(var/datum/mind/V in SSmapping.retainer.vampires)
		if(V.current.job in noblejobs)
			return TRUE

/datum/objective/vampirelord/spread
	name = "spread"
	explanation_text = "Have 10 vampire spawn."
	triumph_count = 5

/datum/objective/vampirelord/spread/check_completion()
	if(length(SSmapping.retainer.vampires) >= 10)
		return TRUE

/datum/objective/vampirelord/stock
	name = "stock"
	explanation_text = "Have a crimson crucible with 30000 vitae."
	triumph_count = 1

/datum/objective/vlordsurvive
	name = "survive"
	explanation_text = "I am eternal. I must ensure the foolish mortals don't destroy me."
	triumph_count = 3

/datum/objective/vlordsurvive/check_completion()
	if(considered_alive(SSmapping.retainer.vampire_lord?.mind))
		return TRUE

/datum/objective/vlordserve
	name = "serve"
	explanation_text = "I must serve my master, and ensure that they triumph."
	triumph_count = 3

/datum/objective/vlordserve/check_completion()
	if(considered_alive(SSmapping.retainer.vampire_lord?.mind))
		return TRUE
