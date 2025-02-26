/obj/item/fishing
	name = "fishing tackle"
	icon = 'icons/roguetown/items/fishing.dmi'
	icon_state = "twinereel"
	w_class = WEIGHT_CLASS_TINY
	dropshrink = 1
	//affects line hp
	var/linehealth = 0
	//affects margin of error and error mult
	var/difficultymod
	//multiplier to deep fish added to the fishing list. added to base chance dependent on targeted water tile z level and water tile
	var/deepfishingweight
	//affects fish rarity
	var/list/raritymod
	//affects fish size
	var/list/sizemod
	//affects how long the window is to hook a fish
	var/hookmod
	var/attachtype

/obj/item/fishing/Initialize()
	. = ..()

/obj/item/fishing/reel
	attachtype = "reel"

/obj/item/fishing/reel/twine
	name = "twine fishing line"
	desc = "A simple fishing line made out of woven fibers. Cheap, but breaks easily."
	linehealth = 5
	difficultymod = 1

/obj/item/fishing/reel/leather
	name = "leather fishing line"
	desc = "A fishing line made out of leather. Far stronger than twine, but its visibility makes fish more wary."
	icon_state = "leatherreel"
	linehealth = 8
	hookmod = -3

/obj/item/fishing/reel/silk
	name = "silk fishing line"
	desc = "A fishing line made out of woven silk. Strong and thin, it's a common choice among seasoned fisherman."
	icon_state = "silkreel"
	linehealth = 10
	difficultymod = -1

/obj/item/fishing/reel/deluxe
	name = "deluxe fishing line"
	desc = "Extremely sought after by seasoned fisherman, this fishing line was blessed by Abyssorians in their underwater temples. A perfect fishing line, if not for the cost."
	icon_state = "deluxereel"
	linehealth = 14
	hookmod = 3
	difficultymod = -2

/obj/item/fishing/hook
	attachtype = "hook"

/obj/item/fishing/hook/wooden
	name = "wooden fishing hook"
	desc = "A fishing hook consisting of a small piece of wood, carved to points on both ends. More likely to fall out."
	icon_state = "gorgehook"
	difficultymod = 2
	hookmod = -1
	sizemod = list("normal" = -1, "large" = -1, "prize" = -1)
	deepfishingweight = -1

/obj/item/fishing/hook/thorn
	name = "thorn fishing hook"
	desc = "A fishing hook carved out of a thorn. Effective, but fragile."
	icon_state = "thornhook"
	linehealth = -2

/obj/item/fishing/hook/iron
	name = "iron fishing hook"
	desc = "An iron fishing hook. Reliable."
	icon_state = "ironhook"
	linehealth = 2

/obj/item/fishing/hook/deluxe
	name = "wooden lure"
	desc = "A small wooden lure, painted to look like a small fish. Tends to scare off smaller fish."
	icon_state = "deluxehook"
	raritymod = list("gold" = 1, "ultra" = 1, "rare"= 1, "com"= -3)
	sizemod = list("tiny" = -3, "small" = -2, "normal" = -1, "large" = 1, "prize" = 1)

/obj/item/fishing/line //short for line attachment
	attachtype = "line"
	var/bobber = FALSE

/obj/item/fishing/line/bobber
	name = "wooden bobber"
	desc = "A wooden bobber. Keeps the hook floating in the water and helps you reel in fish."
	icon_state = "bobber"
	hookmod = 4
	deepfishingweight = -2
	bobber = TRUE

/obj/item/fishing/line/sinker
	name = "stone sinker"
	desc = "A stone sinker. Keeps the hook low to catch fish that lurk at the bottom of the water."
	icon_state = "sinker"
	deepfishingweight = 1

/obj/item/fishing/bait
	baitpenalty = 0

	var/list/fishinglist = list(/obj/item/reagent_containers/food/snacks/fish/eel = 2)
	//default is one anglerfish
	var/deeplist
	//whether or not this bait has a special catch behaviour
	var/specialcatch
	//chance to do that behaviour
	var/specialchance
	//whether this behaviour overrides size
	var/specialsize
	//whether this behaviour overrides rarity
	var/specialrarity
	//whether this catches a unique fish/object
	var/specialfishtype
	//whether this specialcatch drops the new thing at the targeted turf instead of at the fisher's feet
	var/specialturfcatch

/obj/item/fishing/bait/proc/makespecial(obj/item/specialify)//put in the new item caught and this should change it in some way, change color, give it a glow and increased size, unique icon, whatever
	return

/obj/item/fishing/bait/meat
	name = "red bait"
	desc = "A small amount of meat, rolled into a ball. Tends to attract eels."
	icon_state = "meatbait"

/obj/item/fishing/bait/dough
	name = "doughy bait"
	desc = "A small amount of dough, rolled into a ball. Tends to attract carps."
	fishinglist = list(/obj/item/reagent_containers/food/snacks/fish/carp = 4,
						/obj/item/reagent_containers/food/snacks/fish/shrimp = 1)
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "doughslice"

/obj/item/fishing/bait/gray
	name = "gray bait"
	desc = "A small amount of dough and meat, rolled into a ball. Attracts a little bit of everything."
	icon_state = "mixedbait"
	fishinglist = list(/obj/item/reagent_containers/food/snacks/fish/carp = 3,
					/obj/item/reagent_containers/food/snacks/fish/eel = 3,
					/obj/item/reagent_containers/food/snacks/fish/shrimp = 1)

/obj/item/fishing/bait/speckled
	name = "speckled bait"
	desc = "A complex blend of meat, flour, and berries rolled into a ball. Its smell scares off smaller fish."
	icon_state = "speckledbait"
	sizemod = list("tiny" = -2, "small" = -2, "normal" = -1, "large" = 1, "prize" = 1)
	fishinglist = list(/obj/item/reagent_containers/food/snacks/fish/carp = 1,
					/obj/item/reagent_containers/food/snacks/fish/eel = 1)
	deeplist = list(/obj/item/reagent_containers/food/snacks/fish/angler = 2,
					/obj/item/reagent_containers/food/snacks/fish/clownfish = 1)

/obj/item/fishing/bait/deluxe
	name = "enchanted bait"
	desc = "A ball of unknown ingredients, formulated by Abyssorian priests." //waiting for more fishing content
	icon_state = "deluxebait"
	raritymod = list("gold" = 1, "ultra" = 1, "rare"= 1, "com"= -3)
	sizemod = list("tiny" = -2, "small" = -2, "normal" = -1, "large" = 1, "prize" = 1)
	deepfishingweight = 1
	fishinglist = list(/obj/item/reagent_containers/food/snacks/fish/carp = 1,
					/obj/item/reagent_containers/food/snacks/fish/angler = 1)
	deeplist = list(/obj/item/reagent_containers/food/snacks/fish/angler = 2,
					/obj/item/reagent_containers/food/snacks/fish/clownfish = 1)

	specialcatch = TRUE
	specialchance = 20

	specialsize = list(
		"diffmod" = 2,
		"accmod" = 3,
		"health" = 5,
		"costmod" = 4,
		"hookmod" = 2,
		"type" = "Titanic",
	)
	specialrarity = list(
		"diffmod" = 1,
		"accmod" = 2,
		"health" = 3,
		"costmod" = 10,
		"hookmod" = 2,
		"type" = "Zizoid",
	)
	specialfishtype = list(
		"diffmod" = 2,
		"accmod" = 3,
		"health" = 5,
		"costmod" = 4,
		"hookmod" = 2,
		"type" = /obj/item/reagent_containers/food/snacks/fish/clownfish,
	)

/proc/pickweightmerge(list/List, list/add)//i need a way to merge multiple lists for my shenanigannery to work. remove this if fishing ever stops needing this
	var/list/returner = List
	var/addlength = length(add)
	while(addlength > 0)
		var/returnerlength = length(returner)
		var/find = FALSE
		while(returnerlength > 0)
			if(add[addlength] == returner[returnerlength])
				find = TRUE
				returner[returner[addlength]] += add[add[addlength]]
				break
			returnerlength--
		if(!find)
			returner += add[addlength]
			returner[add[addlength]] = add[add[addlength]]
		addlength--
	return returner

/proc/removenegativeweights(list/L)
	var/list/R = L
	for(var/item in R)
		if(R[item] < 0)
			R[item] = 0
	return R
