//Does the line end in any EOL char that isn't appropriate punctuation OR does it end in a chat-formatted markdown sequence (+bold+, etc) without a period?
GLOBAL_DATUM_INIT(needs_eol_autopunctuation, /regex, regex(@"([a-zA-Z\d\u0400-\u04FF]|[^.?!~-][+|_])$"))

//All non-capitalized 'i' surrounded with whitespace (aka, 'hello >i< am a cat')
GLOBAL_DATUM_INIT(noncapital_i, /regex, regex(@"\b[i]\b", "g"))

/// Ensures sentences end in appropriate punctuation (a period if none exist) and that all whitespace-bounded 'i' characters are capitalized.
/// If the sentence ends in chat-flavored markdown for bolds, italics or underscores and does not have a preceding period, exclamation mark or other flavored sentence terminator, add a period.
/// (e.g: 'Borgs are rogue' becomes 'Borgs are rogue.', '+BORGS ARE ROGUE+ becomes '+BORGS ARE ROGUE+.', '+Borgs are rogue~+' is untouched.)
/proc/autopunct_bare(input_text)
	if (findtext(input_text, GLOB.needs_eol_autopunctuation))
		input_text += "."

	input_text = replacetext(input_text, GLOB.noncapital_i, "I")
	return input_text
