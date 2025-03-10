/*
 * Do not touch the values of these definitions
 * unless you are able to change them on the Elasticsearch engine as well.
 *
 * Hopefully, you know what you're doing.
 */

/* Categories */
	#define ELASCAT_GENERIC "generic"

	#define ELASCAT_COMBAT "combat"
	#define ELASCAT_CRAFTING "crafting"
	#define ELASCAT_ECONOMY "economy"
	#define ELASCAT_STORYTELLER "storyteller"

	#define ELASCAT_RUNTIMES "runtimes"

/* Abstract Data */
	/* Combat */
		/// A mob has had its head dismembered.
		#define ELASDATA_DECAPITATIONS "decapitations"
		/// An animal mob has eaten a corpse.
		#define ELASDATA_EATEN_BODIES "eaten_bodies"
	/* Underworld */
		/// An underworld spirit has been revived with a Toll.
		#define ELASDATA_COIN_REVIVES "coin_revive"
		/// An underworld spirit has won a pit fight.
		#define ELASDATA_FIGHT_REVIVES "fight_revives"
	/* Economy */
		#define ELASDATA_MAMMONS_GAINED "mammons_gained"
		#define ELASDATA_MAMMONS_SPENT "mammons_spent"
