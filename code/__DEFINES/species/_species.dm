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
#define RACE_HUMAN_SPACE "Human"

// ============ USING ID BECAUSE FUCK YOU
/// List of all species. "RACES" in code only, "SPECIES" everywhere else please!
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
	"humanspace",\
	)

/// Species where females get underwear, no underwear for kobold, rakshari and triton, dwarves handled seperately
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
	"humanspace",\
	)

/// Species where males get underwear, identical to above, elves handled seperately
#define RACES_UNDERWEAR_MALE list(\
	"human",\
	"demihuman",\
	"harpy",\
	"tiefling",\
	"aasimar",\
	"halforc",\
	"orc",\
	"zizombie",\
	"humanspace",\
	)

// ============ USING NAME
/// All playable species from character selection menu.
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

/// Species not considered discriminated against in Vanderlin. Used for nobility, etc.
#define RACES_PLAYER_NONDISCRIMINATED list(\
	RACE_HUMEN,\
	RACE_DWARF,\
	RACE_AASIMAR,\
	RACE_ELF,\
	RACE_HALF_ELF,\
)

/// Species who are nonheretical to the church. Excluded species typically have an inhumen god associated, like Zizo. Used for church/faith roles.

#define RACES_PLAYER_NONHERETICAL list(\
	RACE_HUMEN,\
	RACE_DWARF,\
	RACE_AASIMAR,\
	RACE_ELF,\
	RACE_HALF_ELF,\
	RACE_HARPY,\
	RACE_TRITON,\
)

/// Species who are non-exotic to Vanderlin. These are species from foreign lands with no local pull or uncommon species. Used in miscellaneous cases, when they would not be that role.
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

/// Species that lack lux. Any who have no ties to divinity anymore, whether it be their creation story or otherwise taken from them (Hollow-kin)
#define RACES_PLAYER_LUXLESS list(\
	RACE_KOBOLD,\
	RACE_HOLLOWKIN,\
	RACE_RAKSHARI,\
	RACE_HUMAN_SPACE,\
)

/// Species who are affiliated with Grenzelhoft or Psydon specifically.
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

/// Dark elves, half-drow
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

/// Patreon only species.
#define RACES_PLAYER_PATREON list(\
	RACE_KOBOLD,\
	RACE_HOLLOWKIN,\
)

/// Guard Species - No Orcs or Dark Elf
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

/// Foreigner Nobility Species - No Tiefling (you know why) or hollow-kin
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

/// Nonnative species - Anything not native to Psydonia.
/// Probably only will ever contain humans pragmatically, as funny as ethereals pretending to be tieflings would be.
#define RACES_PLAYER_ALIEN list(\
	RACE_HUMAN_SPACE,\
)
