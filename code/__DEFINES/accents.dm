#define ACCENT_NONE "No Accent"
#define ACCENT_DEFAULT "Species Accent"
#define ACCENT_DWARF "Dwarf Accent"
#define ACCENT_DELF "Dark-Elf Accent"
#define ACCENT_ELF "Elf Accent"
#define ACCENT_TIEFLING "Tiefling Accent"
#define ACCENT_HORC "Half-Orc Accent"
#define ACCENT_GRENZ "Grenzelhoft Acccent"
#define ACCENT_PIRATE "Pirate Accent"
#define ACCENT_MIDDLE_SPEAK "Middle Speak (Old Half-Orc)"
#define ACCENT_ZYBANTINE "Zybantine Accent"

GLOBAL_LIST_INIT(accent_list, list(
	ACCENT_NONE = list(),
	ACCENT_DEFAULT = list(),
	ACCENT_DWARF = strings("accents/dwarf_replacement.json", "dwarf"),
	ACCENT_DELF = strings("accents/french_replacement.json", "french"),
	ACCENT_ELF = strings("accents/russian_replacement.json", "russian"),
	ACCENT_TIEFLING = strings("accents/spanish_replacement.json", "spanish"),
	ACCENT_HORC = strings("accents/halforc_replacement.json", "halforc"),
	ACCENT_GRENZ = strings("accents/grenz_replacement.json", "grenz"),
	ACCENT_PIRATE = strings("accents/pirate_replacement.json", "pirate"),
	ACCENT_MIDDLE_SPEAK = strings("accents/middlespeak.json", "full"),
	ACCENT_ZYBANTINE = strings("accents/zybantine_replacement.json", "arabic"),
))
