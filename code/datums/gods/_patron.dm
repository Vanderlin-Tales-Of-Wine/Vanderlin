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

	/// List of words that this god considers profane.
	var/list/profane_words = list("zizo","cock","dick","fuck","shit","pussy","ass","cuck","fucker","fucked","cunt","asshole")

	///our traits thats applied by set_patron and removed when changed
	var/list/added_traits
	var/non_faith = FALSE

/datum/patron/proc/on_gain(mob/living/pious)
	for(var/trait in added_traits)
		ADD_TRAIT(pious, trait, "[type]")

/datum/patron/proc/on_remove(mob/living/pious)
	for(var/trait in added_traits)
		REMOVE_TRAIT(pious, trait, "[type]")

/// Called when a patron's follower attempts to pray.
/// Returns TRUE if they satisfy the needed conditions.
/datum/patron/proc/can_pray(mob/living/follower)
	SHOULD_CALL_PARENT(FALSE)
	return TRUE // how nice!

/// Called when a patron's follower prays to them.
/// Returns TRUE if their prayer was heard and the patron was not insulted
/datum/patron/proc/hear_prayer(mob/living/follower, message, in_underworld)
	if(!follower || !message)
		return FALSE
	var/prayer = sanitize_hear_message(message)

	if(length(profane_words))
		for(var/word in profane_words)
			if(findtext(prayer, word))
				punish_prayer(follower, in_underworld)
				return FALSE

	if(length(prayer) <= 15)
		to_chat(follower, span_danger("My prayer was kinda short..."))
		return FALSE

	. = TRUE //the prayer has succeeded by this point forward

	if(follower.has_flaw(/datum/charflaw/addiction/godfearing)) //make this a fucking signal!!!!
		follower.sate_addiction() //why is this being handled by the mob!!!!

	if(findtext(prayer, "[follower.patron]"))
		reward_prayer(follower, in_underworld)

/// The follower has offended the Patron and is now being punished.
/datum/patron/proc/punish_prayer(mob/living/follower, in_underworld)
	follower.adjust_fire_stacks(100)
	follower.IgniteMob()
	SSticker.pplsmited++
	follower.add_stress(/datum/stressevent/psycurse)

/// The follower has prayed correctly to the Patron and is being rewarded.
/datum/patron/proc/reward_prayer(mob/living/follower, in_underworld)
	follower.playsound_local(follower, 'sound/misc/notice (2).ogg', 100, FALSE)
	follower.add_stress(/datum/stressevent/psyprayer)
