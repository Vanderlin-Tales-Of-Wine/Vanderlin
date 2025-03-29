/datum/language/beast
	name = "Beastish"
	desc = ""
	speech_verb = "growls"
	ask_verb = "grrs"
	exclaim_verb = "howls"
	key = "b"
	flags = LANGUAGE_HIDE_ICON_IF_UNDERSTOOD
	space_chance = 15
	sentence_chance = 0
	between_word_sentence_chance = 10
	between_word_space_chance = 75
	additional_syllable_low = -1
	additional_syllable_high = 1
	default_priority = 100
	icon_state = "beastial"
	spans = list(SPAN_BEAST)
	syllables = list("GRRrrrr",
"GGGrrr",
"RRRRrr",
"GRrr",
"Rr",
"Rrrr",
"Rrrrr")
