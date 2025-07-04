/proc/mix_color_from_reagents(list/reagent_list)
	if(!istype(reagent_list))
		return

	var/mixcolor
	var/vol_counter = 0
	var/vol_temp

	for(var/datum/reagent/R as anything in reagent_list)
		vol_temp = R.volume
		vol_counter += vol_temp

		if (R.random_reagent_color == TRUE)
			R.color = GLOB.chemical_reagents_color_list[R.name]

		if(!mixcolor)
			mixcolor = R.color

		else if (length(mixcolor) >= length(R.color))
			mixcolor = BlendRGB(mixcolor, R.color, vol_temp/vol_counter)
		else
			mixcolor = BlendRGB(R.color, mixcolor, vol_temp/vol_counter)

	return mixcolor

/proc/mix_alpha_from_reagents(list/reagent_list)
	if(!istype(reagent_list))
		return

	var/mixalpha = 0

	for(var/datum/reagent/R as anything in reagent_list)
		if(R.alpha > mixalpha)
			mixalpha = R.alpha

	return mixalpha
