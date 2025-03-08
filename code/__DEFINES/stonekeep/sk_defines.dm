#define ALL_STONEKEEP_PLAYER_RACES		list("Humen", "Half-Elf", "Dark Elf", "Elf", "Dwarf","Tiefling", "Aasimar", "Changeling","Skylancer","Ogrun","Undine")	// the normal lineup sans Rakshari who are not generally available
#define ALL_STONEKEEP_RACES_NORMALSPRITE		list("Humen", "Half-Elf", "Dark Elf", "Elf", "Tiefling", "Aasimar", "Changeling","Skylancer","Ogrun")	// for clothes without dwarf sprites

#define isgoblin(A) (is_species(A, /datum/species/goblin))

/mob/living/carbon/human
	// Another Boolean. But this time entirely for Kaizoku content to define those whom Abyssariads considers 'impure', and for champions.
	var/burakumin = FALSE
	var/champion = FALSE

	//a var used for a rather niched power.
	var/purification = FALSE


