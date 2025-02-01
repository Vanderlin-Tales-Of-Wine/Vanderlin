SUBSYSTEM_DEF(chat)
	name = "Chat"
	flags = SS_TICKER
	wait = 1
	priority = FIRE_PRIORITY_CHAT
	init_order = INIT_ORDER_CHAT

	var/static/list/payload = list()

/datum/controller/subsystem/chat/fire(resumed)
	for (var/client/C as anything in payload)
		C << output(payload[C], "browseroutput:output")
		payload -= C
		if (MC_TICK_CHECK)
			return

/datum/controller/subsystem/chat/proc/queue(target, message, handle_whitespace = TRUE, trailing_newline = TRUE)
	if (!target || !message)
		return
	if (!istext(message))
		CRASH("to_chat called with invalid input type")
	if (target == world)
		target = GLOB.clients
	var/original_message = message //Some macros resist parsing elsewhere; strip them here
	message = replacetext(message, "\improper", "")
	message = replacetext(message, "\proper", "")
	if (handle_whitespace)
		message = replacetext(message, "\n", "<br>")
		message = replacetext(message, "\t", "[FOURSPACES][FOURSPACES]")
	if (trailing_newline)
		message += "<br>"
	var/twiceEncoded = url_encode(url_encode(message)) // Double encode so that JS can consume utf-8
	if (islist(target))
		for(var/I in target)
			queuePartTwo(I, message, original_message, twiceEncoded)
	else
		queuePartTwo(target, message, original_message, twiceEncoded)


/datum/controller/subsystem/chat/proc/queuePartTwo(client/C, message, original, encoded)
	C = resolve_client(C)
	if (!C)
		return
	SEND_TEXT(C, original)
	if (!C.chatOutput || C.chatOutput.broken)
		return
	if (!C.chatOutput.loaded)
		C.chatOutput.messageQueue += message
		return
	payload[C] += encoded
