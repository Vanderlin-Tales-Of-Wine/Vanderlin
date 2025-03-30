#define ACCENT_NONE "No Accent"
#define ACCENT_DEFAULT "Species Accent"
#define ACCENT_DWARF "Dwarf Accent"
#define ACCENT_DELF "Dark-Elf Accent"
#define ACCENT_ELF "Elf Accent"
#define ACCENT_TIEFLING "Tiefling Accent"
#define ACCENT_HORC "Half-Orc Accent"
#define ACCENT_GRENZ "Grenzelhoft Acccent"

GLOBAL_LIST_INIT(accent_list, list(
	ACCENT_NONE = list(),
	ACCENT_DEFAULT = list(),
	ACCENT_DWARF = strings("dwarf_replacement.json", "dwarf"),
	ACCENT_DELF = strings("french_replacement.json", "french"),
	ACCENT_ELF = strings("russian_replacement.json", "russian"),
	ACCENT_TIEFLING = strings("spanish_replacement.json", "spanish"),
	ACCENT_HORC = strings("halforc_replacement.json", "halforc"),
	ACCENT_GRENZ = strings("grenz_replacement.json", "grenz"),
))
