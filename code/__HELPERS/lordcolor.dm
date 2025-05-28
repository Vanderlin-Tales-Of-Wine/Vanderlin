GLOBAL_LIST_EMPTY(lordcolor)

GLOBAL_VAR(lordprimary)
GLOBAL_VAR(lordsecondary)

#define LORD_PRIMARY (1<<0)
#define LORD_SECONDARY (1<<2)
#define LORD_DETAIL_AND_COLOR (1<<3)

/obj/proc/lordcolor(primary, secondary)
	if(uses_lord_coloring & LORD_PRIMARY)
		color = primary
	if(uses_lord_coloring & LORD_SECONDARY)
		color = secondary

/obj/item/clothing/lordcolor(primary, secondary)
	if(!get_detail_tag())
		return ..()
	if(uses_lord_coloring & LORD_PRIMARY)
		detail_color = primary
	if(uses_lord_coloring & LORD_SECONDARY)
		detail_color = secondary
	if(uses_lord_coloring & LORD_DETAIL_AND_COLOR)
		if(uses_lord_coloring & LORD_PRIMARY)
			color = secondary
		if(uses_lord_coloring & LORD_SECONDARY)
			color = primary
	update_appearance(UPDATE_OVERLAYS)
	if(ismob(loc))
		var/mob/M = loc
		M.update_clothing(slot_flags)

/turf/proc/lordcolor(primary, secondary)
	if(uses_lord_coloring & LORD_PRIMARY)
		color = primary
	if(uses_lord_coloring & LORD_SECONDARY)
		color = secondary

/mob/proc/lord_color_choice()
	if(!client)
		addtimer(CALLBACK(src, PROC_REF(lord_color_choice)), 5 SECONDS)
		return
	var/list/lordcolors = list(
		"PURPLE"="#865c9c",
		"RED"="#8f3636",
		"BLACK"="#2f352f",
		"BROWN"="#685542",
		"GREEN"="#58793f",
		"BLUE"="#395480",
		"YELLOW"="#b5b004",
		"TEAL"="#249589",
		"WHITE"="#c7c0b5",
		"ORANGE"="#b47011",
		"MAJENTA"="#822b52",
	)
	var/choice = browser_input_list(src, "Choose a Primary Color", "VANDERLIN", lordcolors)
	if(!choice)
		choice = pick(lordcolors)
		return
	GLOB.lordprimary = lordcolors[choice]
	lordcolors -= choice
	choice = browser_input_list(src, "Choose a Secondary Color", "VANDERLIN", lordcolors)
	if(!choice)
		choice = pick(lordcolors)
		return
	GLOB.lordsecondary = lordcolors[choice]
