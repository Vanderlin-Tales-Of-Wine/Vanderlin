/datum/job/roguetown/mercenary
	title = "Mercenary"
	flag = GRAVETENDER
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 4
	spawn_positions = 4

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Rakshari",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar",
		"Half-Orc"
	)
	tutorial = "<br>Blood stained hands, do you even see it when they line your palms with golden treasures?  <br><br>\
	You are a paid killer, redeemable only by fact that your loyalty can be bought,  \
	gold is the great hypocritical lubricant in life, founding empires, driving brothers to kill one another.  <br><br>\
	You care not. Another day, another mammon.<br>"
	display_order = JDO_MERCENARY
	bypass_lastclass = TRUE
	give_bank_account = 3
	min_pq = 2
	outfit = null
	outfit_female = null
	advclass_cat_rolls = list(CTAG_MERCENARY = 20)

/datum/job/roguetown/mercenary/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

/datum/outfit/job/roguetown/mercenary // Reminder message
	var/tutorial = "<br><br><font color='#855b14'><span class='bold'>Your sponsor, the Merchant, representing the MGE guild, might have work for you todae, go find out.</span></font><br><br>"

/datum/outfit/job/roguetown/mercenary/post_equip(mob/living/carbon/human/H)
	..()
	to_chat(H, tutorial)
