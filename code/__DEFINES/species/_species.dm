#define RACE_HUMEN "Humen"
#define RACE_DWARF "Dwarf"
#define RACE_AASIMAR "Aasimar"
#define RACE_ELF "Elf"
#define RACE_HALF_ELF "Half-Elf"
#define RACE_DROW "Dark Elf"
#define RACE_HALF_DROW "Half-Drow"
#define RACE_TIEFLING "Tiefling"
#define RACE_HALF_ORC "Half-Orc"
#define RACE_RAKSHARI "Rakshari"
#define RACE_KOBOLD "Kobold"
#define RACE_HOLLOWKIN "Hollow-Kin"
#define RACE_HARPY "Harpy"
#define RACE_TRITON "Triton"

// ============ USING ID BECAUSE FUCK YOU
/// List of all species
#define ALL_RACES_LIST list(\
	"human",\
	"demihuman",\
	"harpy",\
	"rakshari",\
	"dwarf",\
	"elf",\
	"tiefling",\
	"aasimar",\
	"halforc",\
	"orc",\
	"zizombie",\
	"kobold",\
	"triton",\
	)

/// Races where females get underwear, no underwear for kobold, rakshari and triton, dwarves handled seperately
#define RACES_UNDERWEAR_FEMALE list(\
	"human",\
	"demihuman",\
	"harpy",\
	"tiefling",\
	"aasimar",\
	"halforc",\
	"orc",\
	"zizombie",\
	"elf",\
	)

/// Races where males get underwear, identical to above, elves handled seperately
#define RACES_UNDERWEAR_MALE list(\
	"human",\
	"demihuman",\
	"harpy",\
	"tiefling",\
	"aasimar",\
	"halforc",\
	"orc",\
	"zizombie",\
	)

// ============ USING NAME
/// All playable races from character selection menu.
#define RACES_PLAYER_ALL list(\
	RACE_HUMEN,\
	RACE_DWARF,\
	RACE_AASIMAR,\
	RACE_ELF,\
	RACE_HALF_ELF,\
	RACE_DROW,\
	RACE_HALF_DROW,\
	RACE_TIEFLING,\
	RACE_HARPY,\
	RACE_RAKSHARI,\
	RACE_TRITON,\
	RACE_KOBOLD,\
	RACE_HOLLOWKIN,\
	RACE_HALF_ORC,\
)

/// Races not considered discriminated against in Vanderlin. Used for nobility, etc.
#define RACES_PLAYER_NONDISCRIMINATED list(\
	RACE_HUMEN,\
	RACE_DWARF,\
	RACE_AASIMAR,\
	RACE_ELF,\
	RACE_HALF_ELF,\
)

/// Races who are nonheretical to the church. Excluded races typically have an inhumen god associated, like Zizo. Used for church/faith roles.

#define RACES_PLAYER_NONHERETICAL list(\
	RACE_HUMEN,\
	RACE_DWARF,\
	RACE_AASIMAR,\
	RACE_ELF,\
	RACE_HALF_ELF,\
	RACE_HARPY,\
	RACE_TRITON,\
)

/// Races who are non-exotic to Vanderlin. These are races from foreign lands with no local pull or uncommon races. Used in miscellaneous cases, when they would not be that role.
#define RACES_PLAYER_NONEXOTIC list(\
	RACE_HUMEN,\
	RACE_DWARF,\
	RACE_AASIMAR,\
	RACE_ELF,\
	RACE_HALF_ELF,\
	RACE_DROW,\
	RACE_HALF_DROW,\
	RACE_TIEFLING,\
	RACE_HARPY,\
	RACE_TRITON,\
	RACE_HOLLOWKIN,\
	RACE_HALF_ORC,\
)

///Races that lack lux
#define RACES_PLAYER_LUXLESS list(\
	RACE_KOBOLD,\
	RACE_HOLLOWKIN,\
	RACE_RAKSHARI,\
)

/// Races who are affiliated with Grenzelhoft or Psydon specifically.
#define RACES_PLAYER_GRENZ list(\
	RACE_HUMEN,\
	RACE_DWARF,\
	RACE_AASIMAR,\
)

/// Elves and Half-Elves
#define RACES_PLAYER_ELF list(\
	RACE_ELF,\
	RACE_HALF_ELF,\
)

#define RACES_PLAYER_DROW list(\
	RACE_DROW,\
	RACE_HALF_DROW,\
)

/// Elves, Half-Elves, Half-Drow, Dark Elves
#define RACES_PLAYER_ELF_ALL list(\
	RACE_ELF,\
	RACE_HALF_ELF,\
	RACE_DROW,\
	RACE_HALF_DROW,\
)

/// Patreon only races.
#define RACES_PLAYER_PATREON list(\
	RACE_KOBOLD,\
	RACE_HOLLOWKIN,\
)

/// Guard Races - No Orcs or Dark Elf
#define RACES_PLAYER_GUARD list(\
	RACE_HUMEN,\
	RACE_DWARF,\
	RACE_AASIMAR,\
	RACE_ELF,\
	RACE_HALF_ELF,\
	RACE_HALF_DROW,\
	RACE_TIEFLING,\
	RACE_HARPY,\
	RACE_RAKSHARI,\
	RACE_TRITON,\
)

/// Foreigner Nobility Races - No Tiefling (you know why) or hollow-kin
#define RACES_PLAYER_FOREIGNNOBLE list(\
	RACE_HUMEN,\
	RACE_DWARF,\
	RACE_AASIMAR,\
	RACE_ELF,\
	RACE_HALF_ELF,\
	RACE_DROW,\
	RACE_HALF_DROW,\
	RACE_HALF_ORC,\
	RACE_HARPY,\
	RACE_RAKSHARI,\
	RACE_TRITON,\
	RACE_KOBOLD,\
)
