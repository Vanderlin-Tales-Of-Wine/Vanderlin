/datum/job/mercenary
	title = "Mercenary"
	flag = SK_MERCENARY
	department_flag = OUTSIDERS
	total_positions = 3
	spawn_positions = 3

	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_STATION
	bypass_lastclass = TRUE

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar"
	)
	tutorial = "<br>Blood stained hands, do you even see it when they line your palms with golden treasures?  <br><br>\
	You are a paid killer, redeemable only by fact that your loyalty can be bought,  \
	gold is the great hypocritical lubricant in life, founding empires, driving brothers to kill one another.  <br><br>\
	You care not. Another day, another mammon.<br>"
	display_order = MERCENARY_ORDER
	give_bank_account = 3
	min_pq = -10
	outfit = null
	outfit_female = null
	advclass_cat_rolls = list(CTAG_SKMERCENARY = 20)
	is_foreigner = TRUE

/*
/datum/outfit/job/stonekeep/merc // Reminder message
	var/tutorial = "<br><br><font color='#855b14'><span class='bold'>Your sponsor, the Merchant, representing the MGE guild, might have work for you todae, go find out.</span></font><br><br>"

/datum/outfit/job/stonekeep/merc/post_equip(mob/living/carbon/human/H)
	..()
	to_chat(H, tutorial)
*/
