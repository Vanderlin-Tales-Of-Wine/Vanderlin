/datum/migrant_role/inquisitor
	name = "Episcopal Inquisitor"
	greet_text = "These lands have forfeited Psydon and the Tens, you came with a troop of devouts from Grenzelhoft to restore the True faith to them."
	antag_datum = /datum/antagonist/purishep
	outfit = /datum/outfit/job/inquisitor
	show_wanderer_examine = FALSE
	allowed_races = list("Humen","Dwarf")

/datum/migrant_role/crusader
	name = "Crusaders"
	greet_text = "Crusader of the True faith, you came from Grenzelhoft under the command of the Inquisitor, obey them as he lead you to smite the heatens."
	outfit = /datum/outfit/job/adventurer/crusader
	allowed_races = list("Humen","Dwarf")

/datum/migrant_wave/crusade
	name = "The Holy Crusade"
	shared_wave_type = /datum/migrant_wave/crusade
	downgrade_wave = /datum/migrant_wave/crusade_down_one
	weight = 5
	max_spawns = 1
	roles = list(
		/datum/migrant_role/inquisitor = 2,
		/datum/migrant_role/crusader = 5)
	greet_text = "These heatens, they have forsaken the teaching of everything that is good. We shan't let them insults the true Gods no more. The Inquisitor will lead us to make sure of that."

/datum/migrant_wave/crusade_down_one
	name = "The Holy Crusade"
	shared_wave_type = /datum/migrant_wave/crusade
	downgrade_wave = /datum/migrant_wave/crusade_down_two
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/inquisitor = 1,
		/datum/migrant_role/crusader = 4)
	greet_text = "These heatens, they have forsaken the teaching of everything that is good. We shan't let them insults the true Gods no more. The Inquisitor will lead us to make sure of that."

/datum/migrant_wave/crusade_down_two
	name = "The Holy Crusade"
	shared_wave_type = /datum/migrant_wave/crusade
	downgrade_wave = /datum/migrant_wave/crusade_down_three
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/inquisitor = 1,
		/datum/migrant_role/crusader = 3)
	greet_text = "These heatens, they have forsaken the teaching of everything that is good. We shan't let them insults the true Gods no more. The Inquisitor will lead us to make sure of that."

/datum/migrant_wave/crusade_down_three
	name = "The Holy Crusade"
	shared_wave_type = /datum/migrant_wave/crusade
	downgrade_wave = /datum/migrant_wave/crusade_down_four
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/inquisitor = 1,
		/datum/migrant_role/crusader = 2)
	greet_text = "These heatens, they have forsaken the teaching of everything that is good. We shan't let them insults the true Gods no more. The Inquisitor will lead us to make sure of that."

/datum/migrant_wave/crusade_down_four
	name = "The Holy Crusade"
	shared_wave_type = /datum/migrant_wave/crusade
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/inquisitor = 1,
		/datum/migrant_role/crusader = 1)
	greet_text = "These heatens, they have forsaken the teaching of everything that is good. We shan't let them insults the true Gods no more. The Inquisitor will lead us to make sure of that."
