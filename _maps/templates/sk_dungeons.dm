//Note: The template DM (like this file) should be included (checkmarked) in DM!
//The map files themselves (.dmms) should NOT be included, just placed anywhere.
//For ease of file management, the dmms can be placed in a subfolder (in this case "lil_bog_shack")


//First, set the landmark so it can be easily placed
//Note: You can place multiple of the same map mark, it will pick and load them multiple times just fine
//Other note: Loading a .dmm will overwrite whatever was on the tiles but will not delete objects, so clear an area of trees etc in the area you want to make.

/obj/effect/landmark/map_load_mark/stonekeep_dungeon

	//Name can be anything, it doesn't matter
	name = "The Bog Dungeon"

	//This uses the "IDs" as below -- they should not have spaces in them though since they're strings it won't matter much
	//It needs at least 1 to do anything, no limit in max number of templates

//The template path as directly below should be unique, though doesn't matter what it's actually named since we use the ID for everything.
/datum/map_template/bog_dungeon_1
	name = "Bog Dungeon 1"
	//Your IDs must be unique! Make sure you don't just copy and paste and forget to change it!
	id = "bog_dungeon_1"
	//Mapppath is a direct pointer to the DMM file of your mini map, make sure no typos! The map file can be anywhere as long as this is set properly.
	//Do NOT include (checkmark) the .dmm file! Just stick it in a folder and you're done with it.
	mappath = "_maps/templates/sk_dungeon/bog_dungeon_1.dmm"

/datum/map_template/bog_dungeon_2
	name = "Bog Dungeon 2"
	id = "bog_dungeon_2"
	mappath = "_maps/templates/sk_dungeon/bog_dungeon_2.dmm"

/obj/effect/landmark/map_load_mark/stonekeep_dungeon/roguetown_bog

	//Name can be anything, it doesn't matter
	name = "The Small Bog Dungeon"

	templates = list( "small_bog_dungeon_1","small_bog_dungeon_2","small_bog_dungeon_3","small_bog_dungeon_4","small_bog_dungeon_5" )

/datum/map_template/small_bog_dungeon_1
	name = "Small Bog Dungeon 1"
	id = "small_bog_dungeon_1"
	mappath = "_maps/templates/sk_dungeon/small_bog_dungeon_1.dmm"

/datum/map_template/small_bog_dungeon_2
	name = "Small Bog Dungeon 2"
	id = "small_bog_dungeon_2"
	mappath = "_maps/templates/sk_dungeon/small_bog_dungeon_2.dmm"

/datum/map_template/small_bog_dungeon_3
	name = "Small Bog Dungeon 3"
	id = "small_bog_dungeon_3"
	mappath = "_maps/templates/sk_dungeon/small_bog_dungeon_3.dmm"

/datum/map_template/small_bog_dungeon_4
	name = "Small Bog Dungeon 4"
	id = "small_bog_dungeon_4"
	mappath = "_maps/templates/sk_dungeon/small_bog_dungeon_4.dmm"

/datum/map_template/small_bog_dungeon_5
	name = "Small Bog Dungeon 5"
	id = "small_bog_dungeon_5"
	mappath = "_maps/templates/sk_dungeon/small_bog_dungeon_5.dmm"
