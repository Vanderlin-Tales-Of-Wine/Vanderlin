#define ACCENT_NONE "No Accent"
#define ACCENT_DEFAULT "Species Accent"
#define ACCENT_DWARF "Dwarf Accent"
#define ACCENT_DELF "Dark-Elf Accent"
#define ACCENT_TIEFLING "Tiefling Accent"
#define ACCENT_STEPPE "Steppe Accent"

GLOBAL_LIST_INIT(accent_list, list(
	ACCENT_NONE = list(),
	ACCENT_DEFAULT = list(),
	ACCENT_DWARF = strings("SKdwarf_replacement.json", "dwarf"),
	ACCENT_DELF = strings("SKdarkelf_replacement.json", "darkelf"),
	ACCENT_TIEFLING = strings("SKtiefling_replacement.json", "tiefling"),
	ACCENT_STEPPE = strings("SKsteppe_replacement.json", "steppe"),
))
