//Note: The template DM (like this file) should be included (checkmarked) in DM!
//The map files themselves (.dmms) should NOT be included, just placed anywhere.
//For ease of file management, the dmms can be placed in a subfolder (in this case "lil_bog_shack")


//First, set the landmark so it can be easily placed
//Note: You can place multiple of the same map mark, it will pick and load them multiple times just fine
//Other note: Loading a .dmm will overwrite whatever was on the tiles but will not delete objects, so clear an area of trees etc in the area you want to make.

/obj/effect/landmark/map_load_mark/bog_shack_small

	//Name can be anything, it doesn't matter
	name = "Bog Shack (small)"

	//This uses the "IDs" as below -- they should not have spaces in them though since they're strings it won't matter much
	//It needs at least 1 to do anything, no limit in max number of templates
	templates = list( "bog_shack_small_1","bog_shack_small_2","bog_shack_small_3" )

//The template path as directly below should be unique, though doesn't matter what it's actually named since we use the ID for everything.
/datum/map_template/bog_shack_small_1
	name = "Bog Shack Variant 1"
	//Your IDs must be unique! Make sure you don't just copy and paste and forget to change it!
	id = "bog_shack_small_1"
	//Mapppath is a direct pointer to the DMM file of your mini map, make sure no typos! The map file can be anywhere as long as this is set properly.
	//Do NOT include (checkmark) the .dmm file! Just stick it in a folder and you're done with it.
	mappath = "_maps/templates/lil_bog_shack/bog_shack_small_1.dmm"

/datum/map_template/bog_shack_small_2
	name = "Bog Shack Variant 2"
	id = "bog_shack_small_2"
	mappath = "_maps/templates/lil_bog_shack/bog_shack_small_2.dmm"

/datum/map_template/bog_shack_small_3
	name = "Bog Shack Variant 3"
	id = "bog_shack_small_3"
	mappath = "_maps/templates/lil_bog_shack/bog_shack_small_3.dmm"
