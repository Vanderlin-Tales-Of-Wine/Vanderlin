#define CHAT_MESSAGE_SPAWN_TIME		0.2 SECONDS
#define CHAT_MESSAGE_LIFESPAN		5 SECONDS
#define CHAT_MESSAGE_EOL_FADE		0.7 SECONDS
#define CHAT_MESSAGE_EXP_DECAY		0.7 // Messages decay at pow(factor, idx in stack)
#define CHAT_MESSAGE_HEIGHT_DECAY	0.9 // Increase message decay based on the height of the message
#define CHAT_MESSAGE_APPROX_LHEIGHT	11 // Approximate height in pixels of an 'average' line, used for height decay
#define CHAT_MESSAGE_WIDTH			96 // pixels
#define CHAT_MESSAGE_MAX_LENGTH		110 // characters

#define WXH_TO_HEIGHT(measurement, return_var) \
	do { \
		var/_measurement = measurement; \
		return_var = text2num(copytext(_measurement, findtextEx(_measurement, "x") + 1)); \
	} while(FALSE);
