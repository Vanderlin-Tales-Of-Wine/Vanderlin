/datum/map_template/dungeon
	///the pickweight of this dungeon type
	var/rarity = 100
	///our type_pick weight
	var/type_weight = 1

	///basically if these are set we assume it exists
	///I will close any pr that attempts to add the spawners outside the middle
	///this is to be assumed how many to the left
	var/north_offset
	///this is to be assumed how many to the left
	var/south_offset
	///this is to be assumed how many down
	var/east_offset
	///this is to be assumed how many down
	var/west_offset
