/datum/surgery
	/// Name of the surgical procedure
	var/name = "surgery"
	/// Description of the surgical procedure
	var/desc = ""
	/// Steps to be performed in order
	var/list/steps = list()
	/// Acceptable mob types
	var/list/target_mobtypes = list(/mob/living/carbon/humanoid)
	/// Acceptable body zones
	var/list/possible_locs = list()
	/// Surgery available only when a bodypart is present
	var/requires_bodypart = TRUE
	/// Surgery available only when a bodypart is missing
	var/requires_missing_bodypart = FALSE
	/// Surgery not available on pseudoparts
	var/requires_real_bodypart = FALSE
	/// Acceptable limb statuses
	var/requires_bodypart_type = BODYPART_ORGANIC

/datum/surgery/advanced
	name = "advanced surgery"
