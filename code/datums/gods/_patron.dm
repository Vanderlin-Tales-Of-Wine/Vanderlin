#define CLERIC_SPELLS "Cleric"
#define PRIEST_SPELLS "Priest"

GLOBAL_LIST_EMPTY(patronlist)
GLOBAL_LIST_EMPTY(patrons_by_faith)
GLOBAL_LIST_EMPTY(preference_patrons)

/datum/patron
	/// Name of the god
	var/name
	/// Domain of the god, such as earth, fire, water, murder etc
	var/domain = "Bad coding practices"
	/// Description of the god
	var/desc = "A god that ordains you to report this on GitHub - You shouldn't be seeing this, someone forgot to set the description of this patron."
	/// String that represents who worships this guy
	var/worshippers = "Shitty coders"
	///String that represents the god's flaws
	var/flaws = "This spagetti code"
	///Strong that represents what this god views as sins
	var/sins = "Codersocks"
	/// What boons the god may offer:______qdel_list_wrapper(list/L)
	var/boons = "Code errors"
	/// Faith this god belongs to
	var/datum/faith/associated_faith = /datum/faith
	/// Whether or not we are accessible in preferences
	var/preference_accessible = TRUE
	/// All gods have related confessions
	var/list/confess_lines
	/// Tier 0 spell
	var/t0
	/// Tier 1 spell
	var/t1
	/// Tier 2 spell
	var/t2
	/// Final tier spell
	var/t3

	///our traits thats applied by set_patron and removed when changed
	var/list/added_traits
	var/non_faith = FALSE

/datum/patron/proc/on_gain(mob/living/pious)
	for(var/trait in added_traits)
		ADD_TRAIT(pious, trait, "[type]")

/datum/patron/proc/on_remove(mob/living/pious)
	for(var/trait in added_traits)
		REMOVE_TRAIT(pious, trait, "[type]")
