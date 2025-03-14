/datum/wound/bite
	name = "bite"
	bleed_rate = 0
	sewn_bleed_rate = 0
	clotting_threshold = null
	sewn_clotting_threshold = null
	whp = 30
	woundpain = 10
	sew_threshold = 50
	mob_overlay = "cut"
	can_sew = FALSE
	can_cauterize = FALSE
	passive_healing = 0.5

	werewolf_infection_probability = 12

/datum/wound/bite/can_apply_to_bodypart(obj/item/bodypart/affected)
	. = ..()
	if(affected.status == BODYPART_ROBOTIC)
		return FALSE

/datum/wound/bite/small
	name = "nip"
	whp = 15
	woundpain = 3

	werewolf_infection_probability = 8

/datum/wound/bite/large
	name = "gnarly bite"
	whp = 40
	sewn_whp = 15
	bleed_rate = 2
	sewn_bleed_rate = 0.2
	clotting_rate = 0.01
	sewn_clotting_rate = 0.01
	clotting_threshold = 0.5
	sewn_clotting_threshold = 0.25
	woundpain = 15
	sewn_woundpain = 5
	can_sew = TRUE
	can_cauterize = TRUE
	passive_healing = 0

	werewolf_infection_probability = 16
