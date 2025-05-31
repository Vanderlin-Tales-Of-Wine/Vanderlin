/obj/item/clothing/pants/tights
	name = "tights"
	desc = "Comfortable loose pants."
	gender = PLURAL
	icon_state = "tights"
	item_state = "tights"

/obj/item/clothing/pants/tights/random/Initialize()
	color = pick_assoc(GLOB.peasant_dyes)
	return ..()

/obj/item/clothing/pants/tights/uncolored
	color = CLOTHING_LINEN

/obj/item/clothing/pants/tights/black
	color = CLOTHING_SOOT_BLACK

/obj/item/clothing/pants/tights/red
	color = CLOTHING_BLOOD_RED

/obj/item/clothing/pants/tights/purple
	color = CLOTHING_PLUM_PURPLE

/obj/item/clothing/pants/tights/green
	color = CLOTHING_FOREST_GREEN

/obj/item/clothing/pants/tights/jester
	desc = "Funny tights!"
	color = CLOTHING_SALMON

/obj/item/clothing/pants/tights/lord
	color = CLOTHING_PLUM_PURPLE

/obj/item/clothing/pants/tights/vagrant
	r_sleeve_status = SLEEVE_TORN
	body_parts_covered = GROIN|LEG_LEFT
	torn_sleeve_number = 1

/obj/item/clothing/pants/tights/vagrant/l
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_TORN
	body_parts_covered = GROIN|LEG_RIGHT

/obj/item/clothing/pants/tights/vagrant/Initialize()
	color = pick(CLOTHING_MUD_BROWN, CLOTHING_OLD_LEATHER, CLOTHING_SPRING_GREEN, CLOTHING_BARK_BROWN, CLOTHING_CANVAS	)
	return ..()

/obj/item/clothing/pants/tights/guard
	color = CLOTHING_PLUM_PURPLE

/obj/item/clothing/pants/tights/guard/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/pants/tights/guard/Destroy()
	GLOB.lordcolor -= src
	return ..()

/obj/item/clothing/pants/tights/guardsecond
	color = CLOTHING_BLOOD_RED

/obj/item/clothing/pants/tights/guardsecond/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/pants/tights/guardsecond/lordcolor(primary,secondary)
	if(secondary)
		color = secondary

/obj/item/clothing/pants/tights/guardsecond/Destroy()
	GLOB.lordcolor -= src
	return ..()

/obj/item/clothing/pants/tights/sailor
	name = "pants"
	icon_state = "sailorpants"
