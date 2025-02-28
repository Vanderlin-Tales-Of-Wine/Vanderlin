/proc/give_special_items(mob/living/carbon/human/H)
	if(!H.mind)
		return
	switch(H.ckey)
		if("monokrom")
			H.mind.special_items["Winged Cap"] = /obj/item/clothing/head/helmet/winged
		if("hilldric")
			H.mind.special_items["Headband"] = /obj/item/clothing/head/headband
		if("Muaru")
			H.mind.special_items["Headband"] = /obj/item/clothing/head/headband
		if("Stimusz")
			H.mind.special_items["Headband"] = /obj/item/clothing/head/headband
		if("Bonapart")
			H.mind.special_items["Headband"] = /obj/item/clothing/head/headband
