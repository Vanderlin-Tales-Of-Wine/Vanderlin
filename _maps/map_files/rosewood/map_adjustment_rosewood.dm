/*
			< ATTENTION >
	If you need to add more map_adjustment, check 'map_adjustment_include.dm'
	These 'map_adjustment.dm' files shouldn't be included in 'dme'
*/

#define POINTY_EARS list(\
	"Elf",\
	"Half-Elf"\
)

/datum/map_adjustment/rosewood
	map_file_name = "rosewood.dmm"
	species_adjust = list(
		/datum/job/lord = POINTY_EARS,
		/datum/job/prince = POINTY_EARS,
		/datum/job/hand = POINTY_EARS,
		/datum/job/captain = POINTY_EARS
	)

#undef POINTY_EARS
