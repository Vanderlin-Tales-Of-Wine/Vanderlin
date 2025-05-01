/datum/job/mercenary
	title = "Mercenary"
	tutorial = "Blood stained hands, do you even see it when they line your palms with golden treasures?\
	\n\n\
	You are a paid killer, redeemable only by fact that your loyalty can be bought,  \
	gold is the great hypocritical lubricant in life, founding empires, driving brothers to kill one another. \
	\n\n\
	You care not. Another day, another mammon."
	flag = GRAVETENDER
	department_flag = OUTSIDERS
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_MERCENARY
	faction = FACTION_STATION
	total_positions = 4
	spawn_positions = 4
	min_pq = 5
	bypass_lastclass = TRUE

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_ALL

	outfit = null
	outfit_female = null
	give_bank_account = 3
	advclass_cat_rolls = list(CTAG_MERCENARY = 20)
	is_foreigner = TRUE

/datum/outfit/job/mercenary // Reminder message
	var/tutorial = "<br><br><font color='#855b14'><span class='bold'>Your sponsor, the Merchant, representing the MGE guild, might have work for you todae, go find out.</span></font><br><br>"

/datum/outfit/job/mercenary/post_equip(mob/living/carbon/human/H)
	..()
	to_chat(H, tutorial)
