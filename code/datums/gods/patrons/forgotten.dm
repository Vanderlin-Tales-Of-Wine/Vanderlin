/datum/patron/psydon
	name = "Psydon"
	domain = "God of Humenity, Dreams and Creation"
	desc = "Deceased, slain by Necra in His final moments. She ripped His body apart to create The Ten... but He'll return when the Ten are gone, right?"
	flaws = "Grudge-Holding, Judgemental, Self-Sacrificing"
	worshippers = "Grenzelhofters, Inquisitors, Heroes"
	sins = "Apostasy, Demon Worship, Betraying thy Father"
	boons = "None. Psydon is dead, His power divided."
	associated_faith = /datum/faith/psydon
	confess_lines = list(
		"THERE IS ONLY ONE GOD!",
		"THE SUCCESSORS HALT HIS RETURN!",
		"PSYDON LIVES!",
	)

/datum/patron/psydon/can_pray(mob/living/carbon/human/follower)
	//We just kind of assume the follower is a human here
	if(istype(follower.wear_neck, /obj/item/clothing/neck/psycross))
		return TRUE

	to_chat(follower, span_danger("I can not talk to Him... I need His cross on my neck!"))
	return FALSE

/datum/patron/psydon/progressive
	name = "Progressive Psydon"
	desc = "Necra divided His body apart in an act of mercy to create The Ten, and as inheritors of His will it's only natural that they take over His position, right?"
	flaws = "Fatalistic, Sentimental, Acquiescent"
	worshippers = "Idealistic Dreamers, Optimists, Diplomats"
	confess_lines = list(
		"PSYDON AND THE TEN ARE THE RIGHTFUL GODS!",
		"MAY THE SUCCESSORS CARRY ON HIS LEGACY!",
		"PSYDON LIVES THROUGH THE TEN!",
	)
