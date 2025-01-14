GLOBAL_LIST_EMPTY(lordcolor)

GLOBAL_VAR(lordprimary)
GLOBAL_VAR(lordsecondary)

/obj/proc/lordcolor(primary,secondary)
	color = primary

/obj/item/clothing/cloak/lordcolor(primary,secondary)
	..()
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_cloak()


/turf/proc/lordcolor(primary,secondary)
	color = primary

/mob/proc/lord_color_choice()
	if(!client)
		addtimer(CALLBACK(src, PROC_REF(lord_color_choice)), 50)
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
"MAJENTA"="#822b52")
	var/prim
	var/sec
	var/choice = input(src, "Choose a Primary Color", "VANDERLIN") as anything in lordcolors
	if(choice)
		prim = lordcolors[choice]
		lordcolors -= choice
	choice = input(src, "Choose a Secondary Color", "VANDERLIN") as anything in lordcolors
	if(choice)
		sec = lordcolors[choice]
	if(!prim || !sec)
		GLOB.lordcolor = list()
		return
	GLOB.lordprimary = prim
	GLOB.lordsecondary = sec
	for(var/obj/O in GLOB.lordcolor)
		O.lordcolor(prim,sec)
		GLOB.lordcolor -= O
	for(var/turf/T in GLOB.lordcolor)
		T.lordcolor(prim,sec)
		GLOB.lordcolor -= T
