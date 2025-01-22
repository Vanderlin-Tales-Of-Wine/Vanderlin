/datum/objective/bandit
	name = "bandit"
	explanation_text = "Feed valuables to the idol."

/datum/objective/bandit/check_completion()
	if(SSticker.mode)
		var/datum/game_mode/chaosmode/C = SSticker.mode
		if(C.banditcontrib >= C.banditgoal)
			return TRUE

/datum/objective/bandit/update_explanation_text()
	..()
	if(SSticker.mode)
		var/datum/game_mode/chaosmode/C = SSticker.mode
		if(C)
			explanation_text = "Feed [C.banditgoal] mammon to an idol of greed."
		else
			explanation_text = "Pray to ZIZO."


/datum/objective/delf
	name = "delf"
	explanation_text = "Feed honeys to the mother."

/datum/objective/delf/check_completion()
	if(SSticker.mode)
		var/datum/game_mode/chaosmode/C = SSticker.mode
		if(C.delfcontrib >= C.delfgoal)
			return TRUE

/datum/objective/delf/update_explanation_text()
	..()
	if(SSticker.mode)
		var/datum/game_mode/chaosmode/C = SSticker.mode
		if(C)
			explanation_text = "Feed [C.delfgoal] honeys to the mother."
		else
			explanation_text = "Pray to ZIZO."

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
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(istype(C))
		if(C.vampire_werewolf() == "werewolf")
			return TRUE

/datum/objective/werewolf/spread
	name = "spread"
	explanation_text = "Have 6 lesser werewolf."
	triumph_count = 5

/datum/objective/werewolf/spread/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(C.werewolves.len >= 6)
		return TRUE

/datum/objective/werewolf/infiltrate/one
	name = "infiltrate1"
	explanation_text = "Infect a member of the Church my spawn."
	triumph_count = 5

/datum/objective/werewolf/infiltrate/one/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	var/list/churchjobs = list("Priest", "Priestess", "Cleric", "Acolyte", "Templar", "Churchling", "Crusader", "Inquisitor")
	for(var/datum/mind/V in C.werewolves)
		if(V.current.job in churchjobs)
			return TRUE

/datum/objective/werewolf/infiltrate/two
	name = "infiltrate2"
	explanation_text = "Infect a member of the Nobility."
	triumph_count = 5

/datum/objective/werewolf/infiltrate/two/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	var/list/noblejobs = list("Monarch", "Consort", "Prince", "Captain", "Hand", "Steward")
	for(var/datum/mind/V in C.werewolves)
		if(V.current.job in noblejobs)
			return TRUE

/datum/objective/werewolf/survive
	name = "survive"
	explanation_text = "My lycanthropia won't allow me to die, I musn't die."
	triumph_count = 3

/datum/objective/werewolf/survive/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(!C.werewolf.stat)
		return TRUE

/// Vampire related (OLD)

/datum/objective/vampire
	name = "conquer"
	explanation_text = "Destroy all alpha werewolves in Vanderlin. I can detect them in my true form."
	team_explanation_text = ""
	triumph_count = 5

/datum/objective/vampire/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(istype(C))
		if(C.vampire_werewolf() == "vampire")
			return TRUE

/// Vampire related (NEW)

/datum/objective/vampirelord/conquer
	name = "conquer"
	explanation_text = "Make the Ruler of Enigma bow to my will."
	team_explanation_text = ""
	triumph_count = 5

/datum/objective/vampirelord/conquer/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(istype(C))
		if(C.kingsubmit)
			return TRUE

/datum/objective/vampirelord/ascend
	name = "sun"
	explanation_text = "Astrata has spurned me long enough. I must conquer the Sun."
	team_explanation_text = ""
	triumph_count = 5

/datum/objective/vampirelord/ascend/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(C.ascended)
		return TRUE

/datum/objective/vampirelord/destroy
	name = "destroy"
	explanation_text = "Destroy all alpha werewolves in Vanderlin. I can detect them in my true form."
	team_explanation_text = ""
	triumph_count = 5

/datum/objective/vampirelord/destroy/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(istype(C))
		if(C.vampire_werewolf() == "vampire")
			return TRUE


/datum/objective/vampirelord/infiltrate/one
	name = "infiltrate1"
	explanation_text = "Make a member of the Church my spawn."
	triumph_count = 5

/datum/objective/vampirelord/infiltrate/one/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	var/list/churchjobs = list("Priest", "Priestess", "Cleric", "Acolyte", "Templar", "Churchling", "Crusader", "Inquisitor")
	for(var/datum/mind/V in C.vampires)
		if(V.current.job in churchjobs)
			return TRUE

/datum/objective/vampirelord/infiltrate/two
	name = "infiltrate2"
	explanation_text = "Make a member of the Nobility my spawn."
	triumph_count = 5

/datum/objective/vampirelord/infiltrate/two/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	var/list/noblejobs = list("Monarch", "Consort", "Prince", "Captain", "Hand", "Steward")
	for(var/datum/mind/V in C.vampires)
		if(V.current.job in noblejobs)
			return TRUE

/datum/objective/vampirelord/spread
	name = "spread"
	explanation_text = "Have 10 vampire spawn."
	triumph_count = 5

/datum/objective/vampirelord/spread/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(C.vampires.len >= 10)
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
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(!C.vlord.stat)
		return TRUE

/datum/objective/vlordserve
	name = "serve"
	explanation_text = "I must serve my master, and ensure that they triumph."
	triumph_count = 3

/datum/objective/vlordserve/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(!C.vlord.stat)
		return TRUE
