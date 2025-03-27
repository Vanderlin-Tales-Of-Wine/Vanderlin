#define CONVERT_TO_ATTUNEMENT_MULT(to_convert) \
	if (to_convert != 0) { \
		if (to_convert > 0) { \
			to_convert = (1/(1+to_convert)); \
		} \
		else { \
			to_convert = (-to_convert+1); \
		} \
	} \
// Elements

#define MAGIC_ELEMENT_FIRE /datum/attunement/fire
#define MAGIC_ELEMENT_ICE /datum/attunement/ice
#define MAGIC_ELEMENT_BLOOD /datum/attunement/blood

#define MAGIC_ELEMENT_EARTH /datum/attunement/earth
#define MAGIC_ELEMENT_WIND /datum/attunement/aeromancy

#define MAGIC_ELEMENT_LIFE /datum/attunement/life
#define MAGIC_ELEMENT_DEATH /datum/attunement/death
#define MAGIC_ELEMENT_LIGHT /datum/attunement/light

#define MAGIC_ELEMENT_ELECTRIC /datum/attunement/electric
// When other elements are used, add them here

// Alignments
#define MAGIC_ALIGNMENT_NORMAL "Follower of Noc"
#define MAGIC_ALIGNMENT_NECROMANCER "Child of Zizo"

/// Returns the raw attunement correspondance between args 1 and 3. Its fine if both are negative, since thats a positive correspondance.
/// The direction and intensity of the correspondance should correspond to altered casting cost - intense positive correspondance should lower
/// casting cost by a large amount-but a weak negative correspondance should increase casting cost by a small amount.
#define GET_RAW_ATTUNEMENT_CORRESPONDANCE(attunements, intensity, attunement) (attunements[attunement] * intensity)

/// Compares the two lists of attunements and combines the raw correspondance.
/proc/get_total_correspondance(list/attunements, list/other_attunements)
	. = 0

	for (var/datum/attunement/iterated_attunement as anything in attunements)
		. += GET_RAW_ATTUNEMENT_CORRESPONDANCE(attunements, other_attunements[iterated_attunement], iterated_attunement)

/// Returns the "mult" value using the correspondance between attunements and intensity. This value should be multiplied against
/// the mana cost of an action to determine how much "effective" mana a certain mana source can provide to it.
/// Should NEVER return anything negative, ever. The minimum is 0.
/proc/get_total_attunement_mult(list/mana_attunements, list/user_attunements, atom/caster)
	. = 1
	var/total_correspondance = get_total_correspondance(mana_attunements, user_attunements)

	if (total_correspondance != 0)
		. = convert_to_attunement_mult(total_correspondance)

	var/bias_amount = get_total_attunement_bias(caster, mana_attunements)
	if (bias_amount != 0)
		. *= convert_to_attunement_mult(bias_amount)

/// attunements should only ever be attunements of a mana source, not mana user.
/proc/get_total_attunement_bias(atom/caster, list/attunements)
	. = 0
	var/total_attunement = 0
	for (var/datum/attunement/iterated_attunement as anything in attunements)
		total_attunement += abs(attunements[iterated_attunement])
	if (total_attunement == 0)
		return
	for (var/datum/attunement/iterated_attunement as anything in attunements)
		if (attunements[iterated_attunement] == 0)
			continue
		var/datum/attunement/singleton_instance = GLOB.magic_attunements[iterated_attunement]
		. += singleton_instance.get_bias_mult_increment(caster) * ((attunements[iterated_attunement])/total_attunement) //access singleton

/proc/convert_to_attunement_mult(amount)
	if (amount != 0)
		if (amount > 0)
			amount = (1/(1+amount))
		else
			amount = (-amount+1)
	return amount
