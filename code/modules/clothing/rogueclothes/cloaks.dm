/obj/item/clothing/cloak
	name = "cloak"
	icon = 'icons/roguetown/clothing/cloaks.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	slot_flags = ITEM_SLOT_CLOAK
	desc = "A simple cloak covering the body."
	edelay_type = 1
	equip_delay_self = 10
	equip_sound = 'sound/foley/equip/cloak_equip.ogg'
	pickup_sound = 'sound/foley/equip/cloak_take_off.ogg'
	bloody_icon_state = "bodyblood"
	sewrepair = TRUE
	anvilrepair = null
	smeltresult = /obj/item/ash

	grid_width = 64
	grid_height = 64


//////////////////////////
/// TABARD
////////////////////////

/obj/item/clothing/cloak/tabard
	name = "tabard"
	desc = "A common short coat commonly worn by just about anyone."
	color = null
	icon_state = "tabard"
	item_state = "tabard"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/detailed/tabards.dmi'
	alternate_worn_layer = TABARD_LAYER
	body_parts_covered = CHEST|GROIN
	boobed = TRUE
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_CLOAK
	var/picked

/obj/item/clothing/cloak/tabard/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/cloak/tabard/attack_right(mob/user)
	if(picked)
		return
	var/the_time = world.time
	var/design = input(user, "Select a design.","Tabard Design") as null|anything in list("None", "Symbol", "Split", "Quadrants", "Boxes", "Diamonds")
	if(!design)
		return
	if(world.time > (the_time + 30 SECONDS))
		return
	if(design == "Symbol")
		design = null
		design = input(user, "Select a symbol.","Tabard Design") as null|anything in list("chalice","psy","peace","z","imp","skull","widow","arrow")
		if(!design)
			return
		design = "_[design]"
	var/colorone = input(user, "Select a primary color.","Tabard Design") as null|anything in CLOTHING_COLOR_NAMES
	if(!colorone)
		return
	var/colortwo
	if(design != "None")
		colortwo = input(user, "Select a primary color.","Tabard Design") as null|anything in CLOTHING_COLOR_NAMES
		if(!colortwo)
			return
	if(world.time > (the_time + 30 SECONDS))
		return
	if(design != "None")
		detail_tag = design
	switch(design)
		if("Split")
			detail_tag = "_spl"
		if("Quadrants")
			detail_tag = "_quad"
		if("Boxes")
			detail_tag = "_box"
		if("Diamonds")
			detail_tag = "_dim"
	color = clothing_color2hex(colorone)
	if(colortwo)
		detail_color = clothing_color2hex(colortwo)
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()
	if(alert("Are you pleased with your heraldry?", "Heraldry", "Yes", "No") != "Yes")
		color = initial(color)
		detail_tag = initial(detail_tag)
		detail_color = initial(detail_color)
		update_icon()
		if(ismob(loc))
			var/mob/L = loc
			L.update_inv_cloak()
		return
	picked = TRUE

/obj/item/clothing/cloak/tabard/knight
	color = CLOTHING_PLUM_PURPLE

/obj/item/clothing/cloak/tabard/knight/attack_right(mob/user)
	return

/obj/item/clothing/cloak/tabard/knight/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/cloak/tabard/knight/Destroy()
	GLOB.lordcolor -= src
	return ..()

/obj/item/clothing/cloak/tabard/crusader
	detail_tag = "_psy"

/obj/item/clothing/cloak/tabard/crusader/Initialize()
	. = ..()
	update_icon()

/obj/item/clothing/cloak/tabard/crusader/attack_right(mob/user)
	if(picked)
		return
	var/the_time = world.time
	var/design = input(user, "Select a design.","Tabard Design") as null|anything in list("Default", "Gold Cross", "Jeruah", "BlackGold", "BlackWhite")
	if(!design)
		return
	if(world.time > (the_time + 30 SECONDS))
		return
	if(design == "Gold Cross")
		detail_color = "#b5b004"
	if(design == "Jeruah")
		detail_color = "#b5b004"
		color = "#249589"
	if(design == "BlackGold")
		detail_color = CLOTHING_MUSTARD_YELLOW
		color = CLOTHING_SOOT_BLACK
	if(design == "BlackWhite")
		detail_color = CLOTHING_WHITE
		color = CLOTHING_SOOT_BLACK
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()
	if(alert("Are you pleased with your heraldry?", "Heraldry", "Yes", "No") != "Yes")
		detail_color = initial(detail_color)
		color = initial(color)
		update_icon()
		if(ismob(loc))
			var/mob/L = loc
			L.update_inv_cloak()
		return
	picked = TRUE

/obj/item/clothing/cloak/tabard/crusader/tief/attack_right(mob/user)
	if(picked)
		return
	var/the_time = world.time
	var/design = input(user, "Select a design.","Tabard Design") as null|anything in list("Default", "RedBlack", "BlackRed")
	if(!design)
		return
	if(world.time > (the_time + 30 SECONDS))
		return
	if(design == "RedBlack")
		detail_color = CLOTHING_SOOT_BLACK
		color = CLOTHING_BLOOD_RED
	if(design == "BlackRed")
		detail_color = CLOTHING_BLOOD_RED
		color = CLOTHING_SOOT_BLACK
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()
	if(alert("Are you pleased with your heraldry?", "Heraldry", "Yes", "No") != "Yes")
		detail_color = initial(detail_color)
		color = initial(color)
		update_icon()
		if(ismob(loc))
			var/mob/L = loc
			L.update_inv_cloak()
		return
	picked = TRUE

/obj/item/clothing/cloak/tabard/knight/guard
	desc = "A tabard with the lord's heraldic colors."
	color = CLOTHING_BLOOD_RED
	detail_tag = "_spl"
	detail_color = CLOTHING_PLUM_PURPLE

/obj/item/clothing/cloak/tabard/knight/guard/attack_right(mob/user)
	if(picked)
		return
	var/the_time = world.time
	var/chosen = input(user, "Select a design.","Tabard Design") as null|anything in list("Split", "Quadrants", "Boxes", "Diamonds")
	if(world.time > (the_time + 10 SECONDS))
		return
	if(!chosen)
		return
	switch(chosen)
		if("Split")
			detail_tag = "_spl"
		if("Quadrants")
			detail_tag = "_quad"
		if("Boxes")
			detail_tag = "_box"
		if("Diamonds")
			detail_tag = "_dim"
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()
	if(alert("Are you pleased with your heraldry?", "Heraldry", "Yes", "No") != "Yes")
		detail_tag = initial(detail_tag)
		update_icon()
		if(ismob(loc))
			var/mob/L = loc
			L.update_inv_cloak()
		return
	picked = TRUE

/obj/item/clothing/cloak/tabard/knight/guard/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/cloak/tabard/knight/guard/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/cloak/tabard/knight/guard/lordcolor(primary,secondary)
	color = primary
	detail_color = secondary
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()

/obj/item/clothing/cloak/tabard/knight/guard/Destroy()
	GLOB.lordcolor -= src
	return ..()

/obj/item/clothing/cloak/tabard/adept
	detail_tag = "_psy"
	color = CLOTHING_SOOT_BLACK
	detail_color = CLOTHING_WHITE

/obj/item/clothing/cloak/tabard/adept/Initialize()
	..()
	update_icon()

/obj/item/clothing/cloak/tabard/adept/attack_right(mob/user)
	return

//////////////////////////
/// SOLDIER TABARD
////////////////////////

/obj/item/clothing/cloak/stabard
	name = "surcoat"
	icon_state = "stabard"
	alternate_worn_layer = TABARD_LAYER
	body_parts_covered = CHEST|GROIN
	boobed = TRUE
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/detailed/tabards.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/detailed/tabards.dmi'
	sleevetype = "shirt"
	nodismemsleeves = TRUE
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_CLOAK
	var/picked

/obj/item/clothing/cloak/stabard/attack_right(mob/user)
	if(picked)
		return
	var/the_time = world.time
	var/design = input(user, "Select a design.","Tabard Design") as null|anything in list("None","Split", "Quadrants", "Boxes", "Diamonds")
	if(!design)
		return
	var/colorone = input(user, "Select a primary color.","Tabard Design") as null|anything in CLOTHING_COLOR_NAMES
	if(!colorone)
		return
	var/colortwo
	if(design != "None")
		colortwo = input(user, "Select a primary color.","Tabard Design") as null|anything in CLOTHING_COLOR_NAMES
		if(!colortwo)
			return
	if(world.time > (the_time + 30 SECONDS))
		return
	switch(design)
		if("Split")
			detail_tag = "_spl"
		if("Quadrants")
			detail_tag = "_quad"
		if("Boxes")
			detail_tag = "_box"
		if("Diamonds")
			detail_tag = "_dim"
	color = clothing_color2hex(colorone)
	if(colortwo)
		detail_color = clothing_color2hex(colortwo)
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()
	if(alert("Are you pleased with your heraldry?", "Heraldry", "Yes", "No") != "Yes")
		detail_color = initial(detail_color)
		color = initial(color)
		detail_tag = initial(detail_tag)
		update_icon()
		if(ismob(loc))
			var/mob/L = loc
			L.update_inv_cloak()
		return
	picked = TRUE

/obj/item/clothing/cloak/stabard/guard
	desc = "A tabard with the lord's heraldic colors. This one is worn typically by guards."
	color = CLOTHING_BLOOD_RED
	detail_tag = "_spl"
	detail_color = CLOTHING_PLUM_PURPLE

/obj/item/clothing/cloak/stabard/guard/attack_right(mob/user)
	if(picked)
		return
	var/the_time = world.time
	var/chosen = input(user, "Select a design.","Tabard Design") as null|anything in list("Split", "Quadrants", "Boxes", "Diamonds")
	if(world.time > (the_time + 10 SECONDS))
		return
	if(!chosen)
		return
	switch(chosen)
		if("Split")
			detail_tag = "_spl"
		if("Quadrants")
			detail_tag = "_quad"
		if("Boxes")
			detail_tag = "_box"
		if("Diamonds")
			detail_tag = "_dim"
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()
	if(alert("Are you pleased with your heraldry?", "Heraldry", "Yes", "No") != "Yes")
		detail_tag = initial(detail_tag)
		update_icon()
		if(ismob(loc))
			var/mob/L = loc
			L.update_inv_cloak()
		return
	picked = TRUE

/obj/item/clothing/cloak/stabard/guard/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/cloak/stabard/guard/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/cloak/stabard/guard/lordcolor(primary,secondary)
	color = primary
	detail_color = secondary
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()

/obj/item/clothing/cloak/stabard/guard/Destroy()
	GLOB.lordcolor -= src
	return ..()

/obj/item/clothing/cloak/stabard/dungeon
	color = CLOTHING_SOOT_BLACK

/obj/item/clothing/cloak/stabard/dungeon/attack_right(mob/user)
	return

/obj/item/clothing/cloak/stabard/mercenary
	detail_tag = "_quad"

/obj/item/clothing/cloak/stabard/mercenary/Initialize()
	. = ..()
	detail_tag = pick("_quad", "_spl", "_box", "_dim")
	color = clothing_color2hex(pick(CLOTHING_COLOR_NAMES))
	detail_color = clothing_color2hex(pick(CLOTHING_COLOR_NAMES))
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()

//////////////////////////
/// CRUSADER
////////////////////////

/obj/item/clothing/cloak/stabard/templar
	name = "surcoat of the golden order"
	icon_state = "tabard_weeping"
	item_state = "tabard_weeping"
	icon = 'icons/roguetown/clothing/special/templar.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/templar.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/templar.dmi'

/obj/item/clothing/cloak/stabard/templar/astrata
	name = "surcoat of the solar order"
	icon_state = "tabard_astrata"
	item_state = "tabard_astrata"

/obj/item/clothing/cloak/stabard/templar/astrata/alt
	icon_state = "tabard_astrata_alt"
	item_state = "tabard_astrata_alt"

/obj/item/clothing/cloak/stabard/templar/necra
	name = "surcoat of the necran order"
	icon_state = "tabard_necra"
	item_state = "tabard_necra"

/obj/item/clothing/cloak/stabard/templar/necra/alt
	icon_state = "tabard_necra_alt"
	item_state = "tabard_necra_alt"

/obj/item/clothing/cloak/stabard/templar/dendor
	name = "surcoat of the dendorian order"
	icon_state = "tabard_dendor"
	item_state = "tabard_dendor"

/obj/item/clothing/cloak/stabard/templar/noc
	name = "surcoat of the lunar order"
	icon_state = "tabard_noc"
	item_state = "tabard_noc"

/obj/item/clothing/cloak/stabard/templar/noc/alt
	icon_state = "tabard_noc_alt"
	item_state = "tabard_noc_alt"

/obj/item/clothing/cloak/stabard/templar/abyssor
	name = "surcoat of the abyssal order"
	icon_state = "tabard_abyssor"
	item_state = "tabard_abyssor"

/obj/item/clothing/cloak/stabard/templar/malum
	name = "surcoat of the malumite order"
	icon_state = "tabard_malum"
	item_state = "tabard_malum"

/obj/item/clothing/cloak/stabard/templar/eora
	name = "surcoat of the eoran order"
	icon_state = "tabard_eora"
	item_state = "tabard_eora"

/obj/item/clothing/cloak/stabard/templar/pestra
	name = "surcoat of the pestran order"
	icon_state = "tabard_pestra"
	item_state = "tabard_pestra"

/obj/item/clothing/cloak/stabard/templar/ravox
	name = "surcoat of the ravoxian order"
	icon_state = "tabard_ravox"
	item_state = "tabard_ravox"

//////////////////////////
/// SURCOATS
////////////////////////

/obj/item/clothing/cloak/stabard/surcoat
	name = "jupon"
	icon_state = "surcoat"

/obj/item/clothing/cloak/stabard/surcoat/attack_right(mob/user)
	if(picked)
		return
	var/the_time = world.time
	var/design = input(user, "Select a design.","Tabard Design") as null|anything in list("None","Split", "Quadrants", "Boxes", "Diamonds")
	if(!design)
		return
	var/colorone = input(user, "Select a primary color.","Tabard Design") as null|anything in CLOTHING_COLOR_NAMES
	if(!colorone)
		return
	var/colortwo
	if(design != "None")
		colortwo = input(user, "Select a primary color.","Tabard Design") as null|anything in CLOTHING_COLOR_NAMES
		if(!colortwo)
			return
	if(world.time > (the_time + 30 SECONDS))
		return
	switch(design)
		if("Split")
			detail_tag = "_spl"
		if("Quadrants")
			detail_tag = "_quad"
		if("Boxes")
			detail_tag = "_box"
		if("Diamonds")
			detail_tag = "_dim"
	color = clothing_color2hex(colorone)
	if(colortwo)
		detail_color = clothing_color2hex(colortwo)
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()
	if(alert("Are you pleased with your heraldry?", "Heraldry", "Yes", "No") != "Yes")
		detail_color = initial(detail_color)
		color = initial(color)
		detail_tag = initial(detail_tag)
		update_icon()
		if(ismob(loc))
			var/mob/L = loc
			L.update_inv_cloak()
		return
	picked = TRUE

/obj/item/clothing/cloak/stabard/surcoat/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/cloak/stabard/surcoat/guard
	desc = "A surcoat with the lord's heraldic colors."
	color = CLOTHING_BLOOD_RED
	detail_tag = "_quad"
	detail_color = CLOTHING_PLUM_PURPLE

/obj/item/clothing/cloak/stabard/surcoat/guard/attack_right(mob/user)
	if(picked)
		return
	var/the_time = world.time
	var/chosen = input(user, "Select a design.","Tabard Design") as null|anything in list("Split", "Quadrants", "Boxes", "Diamonds")
	if(world.time > (the_time + 10 SECONDS))
		return
	if(!chosen)
		return
	switch(chosen)
		if("Split")
			detail_tag = "_spl"
		if("Quadrants")
			detail_tag = "_quad"
		if("Boxes")
			detail_tag = "_box"
		if("Diamonds")
			detail_tag = "_dim"
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()
	if(alert("Are you pleased with your heraldry?", "Heraldry", "Yes", "No") != "Yes")
		detail_tag = initial(detail_tag)
		update_icon()
		if(ismob(loc))
			var/mob/L = loc
			L.update_inv_cloak()
		return
	picked = TRUE

/obj/item/clothing/cloak/stabard/surcoat/guard/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/cloak/stabard/surcoat/guard/lordcolor(primary,secondary)
	color = primary
	detail_color = secondary
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()

/obj/item/clothing/cloak/stabard/surcoat/guard/Destroy()
	GLOB.lordcolor -= src
	return ..()

//Royal cloaks.
/obj/item/clothing/cloak/lordcloak
	name = "lordly cloak"
	desc = "Ermine trimmed, handed down."
	color = null
	icon_state = "lord_cloak"
	item_state = "lord_cloak"
	alternate_worn_layer = CLOAK_BEHIND_LAYER
	slot_flags = ITEM_SLOT_BACK_R|ITEM_SLOT_CLOAK
	boobed = TRUE
	sleeved = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	sleevetype = "shirt"
	nodismemsleeves = TRUE
	inhand_mod = TRUE
	allowed_race = list("human", "tiefling", "elf", "aasimar")
	detail_tag = "_det"
	detail_color = CLOTHING_PLUM_PURPLE

/obj/item/clothing/cloak/lordcloak/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/cloak/lordcloak/lordcolor(primary,secondary)
	detail_color = primary
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()

/obj/item/clothing/cloak/lordcloak/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/cloak/lordcloak/Destroy()
	GLOB.lordcolor -= src
	return ..()


/obj/item/clothing/cloak/lordcloak/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/storage/concrete/roguetown/cloak/lord)

/obj/item/clothing/cloak/lordcloak/dropped(mob/living/carbon/human/user)
	..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		var/list/things = STR.contents()
		for(var/obj/item/I in things)
			STR.remove_from_storage(I, get_turf(src))

/obj/item/clothing/cloak/lordcloak/ladycloak
	name = "ladylike shortcloak"
	desc = "Ermine trimmed, handed down."
	color = null
	icon_state = "shortcloak"
	item_state = "shortcloak"
	alternate_worn_layer = CLOAK_BEHIND_LAYER
	slot_flags = ITEM_SLOT_BACK_R|ITEM_SLOT_CLOAK
	boobed = TRUE
	sleeved = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	sleevetype = "shirt"
	nodismemsleeves = TRUE
	allowed_race = list("human", "tiefling", "elf", "aasimar", "dwarf", "halforc")
	detail_tag = "_detail"
	detail_color = CLOTHING_SOOT_BLACK

//End royal cloaks.

/obj/item/clothing/cloak/apron
	name = "apron"
	desc = ""
	color = null
	icon_state = "apron"
	item_state = "apron"
	alternate_worn_layer = TABARD_LAYER
	body_parts_covered = CHEST|GROIN
	boobed = TRUE
	salvage_result = /obj/item/natural/cloth

/obj/item/clothing/cloak/apron/brown
	color = CLOTHING_BARK_BROWN
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/cloak/apron/waist
	name = "apron"
	desc = ""
	color = null
	icon_state = "waistpron"
	item_state = "waistpron"
	body_parts_covered = GROIN
	boobed = FALSE

/obj/item/clothing/cloak/apron/waist/brown
	color = CLOTHING_BARK_BROWN

/obj/item/clothing/cloak/apron/waist/bar
	color = "#251f1d"


/obj/item/clothing/cloak/apron/cook
	name = "cook apron"
	desc = "An apron covering the frontal part of the body. Apart of protection from spills, won't prevent you from getting cut in half."
	color = null
	icon_state = "aproncook"
	item_state = "aproncook"
	body_parts_covered = GROIN
	boobed = FALSE

/*
/obj/item/clothing/cloak/apron/waist/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = 21
	STR.max_w_class = WEIGHT_CLASS_SMALL
	STR.max_items = 1

/obj/item/clothing/cloak/apron/waist/attack_right(mob/user)
	var/datum/component/storage/CP = GetComponent(/datum/component/storage)
	CP.on_attack_hand(CP, user)
	return TRUE*/

/obj/item/clothing/cloak/raincloak
	name = "cloak"
	desc = "A typical raincloak used to protect the wearer against various elements."
	color = null
	icon_state = "rain_cloak"
	item_state = "rain_cloak"
	alternate_worn_layer = CLOAK_BEHIND_LAYER
	slot_flags = ITEM_SLOT_BACK_R|ITEM_SLOT_CLOAK
//	body_parts_covered = ARMS|CHEST
	boobed = TRUE
	sleeved = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	sleevetype = "shirt"
	nodismemsleeves = TRUE
	inhand_mod = TRUE
	hoodtype = /obj/item/clothing/head/hooded/rainhood
	toggle_icon_state = FALSE
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/wash_act(clean)
	. = ..()
	if(hood)
		wash_atom(hood,clean)

/obj/item/clothing/cloak/raincloak/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/storage/concrete/roguetown/cloak)

/obj/item/clothing/cloak/raincloak/dropped(mob/living/carbon/human/user)
	..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		var/list/things = STR.contents()
		for(var/obj/item/I in things)
			STR.remove_from_storage(I, get_turf(src))



/obj/item/clothing/cloak/raincloak/red
	color = CLOTHING_BLOOD_RED

/obj/item/clothing/cloak/raincloak/purple
	color = CLOTHING_PLUM_PURPLE

/obj/item/clothing/cloak/raincloak/mortus
	name = "funeral cloak"
	desc = "You're always shrouded by death."
	color = CLOTHING_SOOT_BLACK

/obj/item/clothing/cloak/raincloak/brown
	color = CLOTHING_BARK_BROWN

/obj/item/clothing/cloak/raincloak/green
	color = CLOTHING_FOREST_GREEN

/obj/item/clothing/cloak/raincloak/blue
	color = CLOTHING_SKY_BLUE

/obj/item/clothing/cloak/raincloak/random/Initialize()
	color = pick(CLOTHING_BLOOD_RED, CLOTHING_PLUM_PURPLE, CLOTHING_SOOT_BLACK, CLOTHING_BARK_BROWN, CLOTHING_FOREST_GREEN, CLOTHING_SKY_BLUE)
	..()

/obj/item/clothing/head/hooded/rainhood
	name = "hood"
	desc = "A hood that's attached to the raincoat."
	icon_state = "rain_hood"
	item_state = "rain_hood"
	slot_flags = ITEM_SLOT_HEAD
	dynamic_hair_suffix = ""
	edelay_type = 1 // Leaving as 1 so you get that small do_after for dramatic purposes
	body_parts_covered = HEAD
	flags_inv = HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	block2add = FOV_BEHIND

/obj/item/clothing/head/hooded/equipped(mob/user, slot)
	. = ..()
	user.update_fov_angles()

/obj/item/clothing/head/hooded/dropped(mob/user)
	. = ..()
	user.update_fov_angles()

/obj/item/clothing/cloak/raincloak/furcloak
	name = "fur cloak"
	icon_state = "furgrey"
	inhand_mod = FALSE
	hoodtype = /obj/item/clothing/head/hooded/rainhood/furhood
	salvage_amount = 1
	salvage_result = /obj/item/natural/fur

/obj/item/clothing/cloak/raincloak/furcloak/crafted/Initialize()
	. = ..()
	if(prob(50))
		color = pick("#685542","#66564d")

/obj/item/clothing/cloak/raincloak/furcloak/brown
	color = CLOTHING_MUD_BROWN

/obj/item/clothing/cloak/raincloak/furcloak/black
	color = CLOTHING_ASH_GREY

/obj/item/clothing/head/hooded/rainhood/furhood
	icon_state = "fur_hood"
	block2add = FOV_BEHIND

/obj/item/clothing/cloak/cape
	name = "cape"
	desc = ""
	color = null
	icon_state = "cape"
	item_state = "cape"
	alternate_worn_layer = CLOAK_BEHIND_LAYER
	boobed = TRUE
	sleeved = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	sleevetype = "shirt"
	nodismemsleeves = TRUE
	inhand_mod = FALSE
	slot_flags = ITEM_SLOT_BACK_R|ITEM_SLOT_CLOAK

/obj/item/clothing/cloak/cape/knight
	color = CLOTHING_PLUM_PURPLE

/obj/item/clothing/cloak/cape/guard
	color = CLOTHING_BLOOD_RED
/obj/item/clothing/cloak/cape/guard/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src
/obj/item/clothing/cloak/cape/guard/lordcolor(primary,secondary)
	color = secondary
	update_icon()
	if(ismob(loc))
		var/mob/L = loc
		L.update_inv_cloak()
/obj/item/clothing/cloak/cape/guard/Destroy()
	GLOB.lordcolor -= src
	return ..()

/obj/item/clothing/cloak/captain
	name = "captain's cape"
	desc = "A cape with a gold embroided heraldry of Vanderlin."
	icon = 'icons/roguetown/clothing/special/captain.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/captain.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/captain.dmi'
	sleevetype = "shirt"
	icon_state = "capcloak"
	detail_tag = "_detail"
	alternate_worn_layer = CLOAK_BEHIND_LAYER
	detail_color = CLOTHING_BERRY_BLUE

/obj/item/clothing/cloak/captain/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/cloak/captain/lordcolor(primary,secondary)
	detail_color = primary
	update_icon()

/obj/item/clothing/cloak/captain/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/cloak/captain/Destroy()
	GLOB.lordcolor -= src
	return ..()

/obj/item/clothing/cloak/cape/archivist
	icon_state = "puritan_cape"
	color = CLOTHING_SOOT_BLACK
	allowed_race = list("human", "tiefling", "elf", "dwarf", "aasimar")

/obj/item/clothing/cloak/cape/rogue
	name = "cape"
	icon_state = "chasuble"

/obj/item/clothing/cloak/chasuble
	name = "chasuble"
	desc = "Pristine white liturgical vestments with a golden psycross adornment."
	icon_state = "chasuble"
	body_parts_covered = CHEST|GROIN|ARMS
	sleeved = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	sleevetype = "shirt"
	slot_flags = ITEM_SLOT_CLOAK
	allowed_sex = list(MALE)
	allowed_race = list("human", "tiefling", "aasimar")
	nodismemsleeves = TRUE


/obj/item/clothing/cloak/stole
	name = "stole"
	desc = "Garments of a priest, usually worn when giving mass to the people."
	icon_state = "stole_gold"
	sleeved = null
	sleevetype = null
	body_parts_covered = null
	flags_inv = null

/obj/item/clothing/cloak/stole/red
	icon_state = "stole_red"

/obj/item/clothing/cloak/stole/purple
	icon_state = "stole_purple"

/obj/item/clothing/cloak/black_cloak
	name = "fur coat"
	desc = "A coat made out of fur that covers chest, arms, groin and a chest. Has no protection capacities."
	icon_state = "black_cloak"
	body_parts_covered = CHEST|GROIN|VITALS|ARMS
	sleeved = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	sleevetype = "shirt"
	slot_flags = ITEM_SLOT_CLOAK
	allowed_sex = list(MALE)
	allowed_race = list("human", "tiefling", "aasimar")
	sellprice = 50
	nodismemsleeves = TRUE

/obj/item/clothing/cloak/tribal
	name = "tribal pelt"
	desc = "A haphazardly cured pelt of a creecher, thrown on top of one's body or armor, to serve as additional protection against the cold. Itchy."
	icon_state = "tribal"
	alternate_worn_layer = CLOAK_BEHIND_LAYER
	slot_flags = ITEM_SLOT_BACK_R|ITEM_SLOT_CLOAK
	body_parts_covered = CHEST|GROIN|VITALS
	allowed_sex = list(MALE, FEMALE)
	// allowed_race = list("human", "tiefling", "elf", "aasimar", "dwarf")
	sleeved = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	nodismemsleeves = TRUE
	boobed = FALSE
	sellprice = 10

/obj/item/clothing/cloak/heartfelt
	name = "red cloak"
	desc = "A typical cloak, this one is in red colours."
	icon_state = "heartfelt_cloak"
	body_parts_covered = CHEST|GROIN|VITALS|ARMS
	sleeved = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	sleevetype = "shirt"
	slot_flags = ITEM_SLOT_CLOAK
	allowed_sex = list(MALE)
	allowed_race = list("human", "tiefling", "aasimar")
	sellprice = 50
	nodismemsleeves = TRUE

/obj/item/clothing/cloak/half
	name = "half cloak"
	desc = "A cloak that covers only half of the body."
	color = null
	icon_state = "halfcloak"
	alternate_worn_layer = CLOAK_BEHIND_LAYER
	slot_flags = ITEM_SLOT_BACK_R|ITEM_SLOT_CLOAK
//	body_parts_covered = ARMS|CHEST
	boobed = TRUE
	sleeved = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	sleevetype = "shirt"
	nodismemsleeves = TRUE
	inhand_mod = TRUE
	hoodtype = null
	toggle_icon_state = FALSE
	color = CLOTHING_SOOT_BLACK
	allowed_sex = list(MALE, FEMALE)
	allowed_race = list("human", "tiefling", "elf", "aasimar")

/obj/item/clothing/cloak/half/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/storage/concrete/roguetown/cloak)

/obj/item/clothing/cloak/half/dropped(mob/living/carbon/human/user)
	..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		var/list/things = STR.contents()
		for(var/obj/item/I in things)
			STR.remove_from_storage(I, get_turf(src))

/obj/item/clothing/cloak/half/shadowcloak
	name = "stalker cloak"
	desc = "A heavy leather cloak held together by a gilded pin. The pin depicts a spider with disconnected legs."
	icon_state = "shadowcloak"
	item_state = "shadowcloak"
	color = null
	alternate_worn_layer = CLOAK_BEHIND_LAYER
	mob_overlay_icon = 'icons/roguetown/clothing/newclothes/onmob/shadowcloak.dmi'
	sleeved = 'icons/roguetown/clothing/newclothes/onmob/shadowcloak.dmi'
	nodismemsleeves = TRUE
	inhand_mod = TRUE
	toggle_icon_state = FALSE
	salvage_result = /obj/item/natural/silk

/obj/item/clothing/cloak/half/shadowcloak/cult
	name = "ominous cloak"
	desc = "Those who wear, thy should beware, for those who do; never come back as who they once were again."
	allowed_race = ALL_RACES_LIST
	body_parts_covered = ARMS|CHEST
	armor = ARMOR_MAILLE_GOOD

/obj/item/clothing/cloak/half/brown
	color = CLOTHING_BARK_BROWN

/obj/item/clothing/cloak/half/red
	color = CLOTHING_BLOOD_RED

/obj/item/clothing/cloak/half/vet
	name = "town watch cloak"
	icon_state = "guardcloak"
	color = CLOTHING_BLOOD_RED
	allowed_sex = list(MALE)
	allowed_race = list("human", "tiefling", "aasimar")
	inhand_mod = FALSE

/obj/item/clothing/cloak/half/vet/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/cloak/half/vet/Destroy()
	GLOB.lordcolor -= src
	return ..()

/obj/item/clothing/cloak/half/random/Initialize()
	color = pick(CLOTHING_WINESTAIN_RED, CLOTHING_MUSTARD_YELLOW, CLOTHING_SOOT_BLACK, CLOTHING_BARK_BROWN, CLOTHING_FOREST_GREEN, CLOTHING_BERRY_BLUE)
	..()

/obj/item/clothing/cloak/matron
	name = "matron cloak"
	desc = "A cloak that only the meanest of old crones bother to wear."
	icon_state = "matroncloak"
	icon = 'icons/roguetown/clothing/cloaks.dmi'
	mob_overlay_icon ='icons/roguetown/clothing/onmob/cloaks.dmi'
	body_parts_covered = CHEST|GROIN|VITALS|ARMS
	sleeved = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	sleevetype = "shirt"
	slot_flags = ITEM_SLOT_CLOAK
	nodismemsleeves = TRUE
	slot_flags = ITEM_SLOT_CLOAK

//............... Battle Nun ........................... (unique kit for the role, tabard for aesthetics)
/obj/item/clothing/cloak/battlenun
	name = "nun vestments"
	desc = "Chaste, righteous, merciless to the wicked."
	color = null
	icon_state = "battlenun"
	allowed_sex = list(FEMALE)
	item_state = "battlenun"
	alternate_worn_layer = TABARD_LAYER
	body_parts_covered = CHEST|GROIN
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_CLOAK
//.............inquisitor cloaks......... (For inquisitors..)
/obj/item/clothing/cloak/cape/puritan
	icon_state = "puritan_cape"
	allowed_race = list("human", "tiefling", "elf", "dwarf", "aasimar")

/obj/item/clothing/cloak/cape/inquisitor
	name = "Inquisitors Cloak"
	desc = "A time honored cloak Valorian design, used by founding clans of the Valorian Lodge"
	icon_state = "inquisitor_cloak"
	icon = 'icons/roguetown/clothing/cloaks.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/cloaks.dmi'

// Dumping old black knight stuff here
/obj/item/clothing/cloak/cape/blkknight
	name = "blood cape"
	icon_state = "bkcape"
	icon = 'icons/roguetown/clothing/special/blkknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'

/obj/item/clothing/head/roguetown/helmet/heavy/blkknight
	name = "blacksteel helmet"
	desc = "A helmet black as nite, with blue decorations. Instills fear upon those that gaze upon it."
	icon_state = "bkhelm"
	icon = 'icons/roguetown/clothing/special/blkknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'

/obj/item/clothing/cloak/tabard/blkknight
	name = "blood sash"
	icon_state = "bksash"
	icon = 'icons/roguetown/clothing/special/blkknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'

/obj/item/clothing/under/roguetown/platelegs/blk
	name = "blacksteel legs"
	icon_state = "bklegs"
	icon = 'icons/roguetown/clothing/special/blkknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/blacksteel

/obj/item/clothing/gloves/roguetown/plate/blk
	name = "blacksteel gauntlets"
	icon_state = "bkgloves"
	icon = 'icons/roguetown/clothing/special/blkknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/blacksteel

/obj/item/clothing/neck/roguetown/blkknight
	name = "dragonscale necklace"
	desc = ""
	icon_state = "bktrinket"
	icon = 'icons/roguetown/clothing/special/blkknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	//dropshrink = 0.75
	resistance_flags = FIRE_PROOF
	sellprice = 666
	static_price = TRUE

/obj/item/clothing/shoes/roguetown/boots/armor/blkknight
	name = "blacksteel boots"
	icon_state = "bkboots"
	icon = 'icons/roguetown/clothing/special/blkknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/blacksteel


/obj/item/clothing/cloak/volfmantle
	name = "volf mantle"
	desc = "A warm cloak made using the hide and head of a slain volf. A status symbol if ever there was one."
	color = null
	icon_state = "volfpelt"
	item_state = "volfpelt"
	sleeved = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	sleevetype = "shirt"
	nodismemsleeves = TRUE
	inhand_mod = FALSE
	slot_flags = ITEM_SLOT_BACK_R|ITEM_SLOT_CLOAK

/obj/item/clothing/cloak/wickercloak
	name = "wicker cloak"
	desc = "A makeshift cloak constructed with mud, sticks and fibers."
	icon_state = "wicker_cloak"
	item_state = "wicker_cloak"
	alternate_worn_layer = CLOAK_BEHIND_LAYER
	slot_flags = ITEM_SLOT_BACK_R|ITEM_SLOT_CLOAK
	sleeved = 'icons/roguetown/clothing/onmob/cloaks.dmi'
	sleevetype = "shirt"
	nodismemsleeves = TRUE
	inhand_mod = TRUE
	allowed_race = list("human", "tiefling", "elf", "aasimar")
