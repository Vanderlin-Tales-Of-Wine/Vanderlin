/datum/species
	var/amtfail = 0

/datum/species/proc/get_accent(mob/living/carbon/human)
	return

/datum/species/proc/handle_speech(datum/source, list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	if(message)
		var/list/accent_words = strings("spellcheck.json", "spellcheck")

		//var/failed = FALSE
		var/mob/living/carbon/human/H
		if(ismob(source))
			H = source
		for(var/key in accent_words)
			var/value = accent_words[key]
			if(islist(value))
				value = pick(value)

			if(findtextEx(message,key))
				if(H)
					to_chat(H, "<span class='warning'>[key] -> [value]</span>")
				amtfail++
				//failed = TRUE

			message = replacetextEx(message, "[key]", "[value]")

	if(message)
		if(message[1])
			if(message[1] != "*")
				message = " [message]"
				var/list/accent_words = strings("accent_universal.json", "universal")

				for(var/key in accent_words)
					var/value = accent_words[key]
					if(islist(value))
						value = pick(value)

					message = replacetextEx(message, " [uppertext(key)]", " [uppertext(value)]")
					message = replacetextEx(message, " [capitalize(key)]", " [capitalize(value)]")
					message = replacetextEx(message, " [key]", " [value]")

		var/list/species_accent = get_accent(source)
		if(species_accent)
			if(message[1] != "*")
				message = " [message]"
				for(var/key in species_accent)
					var/value = species_accent[key]
					if(islist(value))
						value = pick(value)

					message = replacetextEx(message, " [uppertext(key)]", " [uppertext(value)]")
					message = replacetextEx(message, " [capitalize(key)]", " [capitalize(value)]")
					message = replacetextEx(message, " [key]", " [value]")

	speech_args[SPEECH_MESSAGE] = trim(message)
