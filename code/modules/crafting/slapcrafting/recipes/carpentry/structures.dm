/datum/slapcraft_recipe/carpentry/structure/barrel
	name = "wooden barrel"
	steps = list(
		/datum/slapcraft_step/item/small_log,
		/datum/slapcraft_step/use_item/carpentry/hammer
		)
	result_type = /obj/structure/fermentation_keg

/datum/slapcraft_recipe/carpentry/structure/door
	name = "wooden door"
	steps = list(
		/datum/slapcraft_step/item/small_log,
		/datum/slapcraft_step/item/small_log/second,
		/datum/slapcraft_step/use_item/carpentry/hammer
		)
	result_type = /obj/structure/door

/datum/slapcraft_recipe/carpentry/structure/swingdoor
	name = "swing door"
	steps = list(
		/datum/slapcraft_step/item/small_log,
		/datum/slapcraft_step/item/small_log/second,
		/datum/slapcraft_step/use_item/carpentry/hammer
		)
	result_type = /obj/structure/door/swing

/datum/slapcraft_recipe/carpentry/structure/deadbolt
	name = "wooden door (deadbolt)"
	steps = list(
		/datum/slapcraft_step/item/small_log,
		/datum/slapcraft_step/item/small_log/second,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/stick,
		/datum/slapcraft_step/use_item/carpentry/hammer/second
		)
	result_type = /obj/structure/door/weak/bolt

/datum/slapcraft_recipe/carpentry/structure/donjon
	name = "wooden door (viewport)"
	steps = list(
		/datum/slapcraft_step/item/small_log,
		/datum/slapcraft_step/item/small_log/second,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/iron,
		/datum/slapcraft_step/use_item/carpentry/hammer/second
		)
	result_type = /obj/structure/door/viewport
	craftdiff = 2

/datum/slapcraft_recipe/carpentry/structure/fancydoor
	name = "fancy wooden door"
	steps = list(
		/datum/slapcraft_step/item/small_log,
		/datum/slapcraft_step/item/small_log/second,
		/datum/slapcraft_step/use_item/carpentry/hammer
		)
	result_type = /obj/structure/door/fancy
	craftdiff = 3

/datum/slapcraft_recipe/carpentry/structure/roguebin
	name = "wooden bin"
	steps = list(
		/datum/slapcraft_step/item/small_log,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/small_log/second,
		/datum/slapcraft_step/use_item/carpentry/hammer/second
		)
	result_type = /obj/item/bin
	craftdiff = 0

/datum/slapcraft_recipe/carpentry/structure/chair
	name = "wooden chair"
	steps = list(
		/datum/slapcraft_step/item/small_log,
		/datum/slapcraft_step/use_item/carpentry/hammer
		)
	result_type = /obj/structure/chair/wood/alt/chair3/crafted

/obj/structure/chair/wood/alt/chair3/crafted
	item_chair = /obj/item/chair/chair3/crafted
	sellprice = 6

/obj/item/chair/chair3/crafted
	origin_type = /obj/structure/chair/wood/alt/chair3/crafted
	sellprice = 6

/datum/slapcraft_recipe/carpentry/structure/fancychair
	name = "fancy wooden chair"
	steps = list(
		/datum/slapcraft_step/item/small_log,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/silk
		)
	result_type = /obj/structure/chair/wood/alt/fancy/crafted
	craftdiff = 2

/obj/structure/chair/wood/alt/fancy/crafted
	item_chair = /obj/item/chair/fancy/crafted
	sellprice = 12

/obj/item/chair/fancy/crafted
	origin_type = /obj/structure/chair/wood/alt/fancy/crafted
	sellprice = 12

/datum/slapcraft_recipe/carpentry/structure/stool
	name = "wooden stool"
	steps = list(
		/datum/slapcraft_step/item/small_log,
		/datum/slapcraft_step/use_item/carpentry/hammer
		)
	result_type = /obj/structure/chair/stool/crafted

/obj/structure/chair/stool/crafted
	item_chair = /obj/item/chair/stool/bar/crafted
	sellprice = 6

/obj/item/chair/stool/bar/crafted
	origin_type = /obj/structure/chair/stool/crafted
	sellprice = 6

/datum/slapcraft_recipe/carpentry/structure/loom
	name = "loom"
	steps = list(
		/datum/slapcraft_step/item/small_log,
		/datum/slapcraft_step/item/small_log/second,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/stick,
		/datum/slapcraft_step/item/stick/second,
		/datum/slapcraft_step/use_item/carpentry/hammer/second,
		/datum/slapcraft_step/item/fiber,
		/datum/slapcraft_step/item/fiber/second,
		)
	result_type = /obj/machinery/loom


/datum/slapcraft_recipe/carpentry/structure/handcart
	name = "handcart"
	steps = list(
		/datum/slapcraft_step/item/small_log,
		/datum/slapcraft_step/item/small_log/second,
		/datum/slapcraft_step/item/small_log/third,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/rope,
		)
	result_type = /obj/structure/handcart


/datum/slapcraft_recipe/carpentry/structure/noose
	name = "noose"
	steps = list(
		/datum/slapcraft_step/item/rope,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		)
	result_type = /obj/structure/noose
	craftsound = 'sound/foley/noose_idle.ogg'
	craftdiff = 0

/datum/slapcraft_recipe/carpentry/structure/noose/check_craft_requirements(mob/user, turf/T)
	var/turf/checking = get_step_multiz(T, UP)
	if(!checking)
		return FALSE
	if(istype(checking,/turf/open/transparent/openspace))
		return FALSE
	if(locate(/obj/structure/noose) in T)
		return FALSE
	return TRUE

/datum/slapcraft_recipe/carpentry/structure/lanternpost
	name = "lantern post"
	steps = list(
		/datum/slapcraft_step/item/small_log,
		/datum/slapcraft_step/item/small_log/second,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/stick,
		/datum/slapcraft_step/item/stick/second,
		/datum/slapcraft_step/use_item/carpentry/hammer/second,
		)
	result_type = /obj/machinery/light/fueled/lanternpost/unfixed

/datum/slapcraft_recipe/carpentry/structure/lanternpost/check_craft_requirements(mob/user, turf/T)
	if((locate(/obj/machinery/light/fueled/lanternpost) in T)||(locate(/obj/machinery/light/fueledstreet) in T)||(locate(/obj/structure/noose) in T))
		return FALSE
	return ..()

/datum/slapcraft_recipe/carpentry/structure/psycrss
	name = "wooden cross"
	steps = list(
		/datum/slapcraft_step/item/small_log,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/stake,
		/datum/slapcraft_step/item/stake/second,
		/datum/slapcraft_step/item/stake/third,
		/datum/slapcraft_step/use_item/carpentry/hammer/second,
		)
	result_type = /obj/structure/fluff/psycross/crafted

/datum/slapcraft_recipe/carpentry/structure/pyre
	name = "wooden pyre"
	steps = list(
		/datum/slapcraft_step/item/small_log,
		/datum/slapcraft_step/item/small_log/second,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/stake,
		/datum/slapcraft_step/item/stake/second,
		/datum/slapcraft_step/item/stake/third,
		/datum/slapcraft_step/use_item/carpentry/hammer/second,
		)
	result_type = /obj/machinery/light/fueled/campfire/pyre

/datum/slapcraft_recipe/carpentry/structure/stairsd
	name = "wooden stairs (down)"
	steps = list(
		/datum/slapcraft_step/item/small_log,
		/datum/slapcraft_step/item/plank,
		/datum/slapcraft_step/item/plank/second,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		)
	result_type = /obj/structure/stairs/d

/datum/slapcraft_recipe/carpentry/structure/stairsd/check_craft_requirements(mob/user, turf/T)
	var/turf/checking = get_step(T, user.dir)
	if(!checking)
		return FALSE
	if(!istype(checking,/turf/open/transparent/openspace))
		return FALSE
	checking = get_step_multiz(checking, DOWN)
	if(!checking)
		return FALSE
	if(!isopenturf(checking))
		return FALSE
	if(istype(checking,/turf/open/transparent/openspace))
		return FALSE
	for(var/obj/structure/S in checking)
		if(S.density)
			return FALSE
	return TRUE

/datum/slapcraft_recipe/carpentry/structure/railing
	name = "railing"
	steps = list(
		/datum/slapcraft_step/item/small_log,
		/datum/slapcraft_step/use_item/carpentry/hammer
		)
	result_type = /obj/structure/fluff/railing/wood
	craftdiff = 0
	offset_user = TRUE

/datum/slapcraft_recipe/carpentry/structure/railing/check_craft_requirements(mob/user, turf/T)
	for(var/obj/structure/S in T)
		if(istype(S, /obj/structure/fluff/railing))
			if(user.dir == S.dir)
				return FALSE
	return ..()

/datum/slapcraft_recipe/carpentry/structure/fence
	name = "palisade"
	steps = list(
		/datum/slapcraft_step/item/stake,
		/datum/slapcraft_step/item/stake/second,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		)
	result_type = /obj/structure/fluff/railing/fence
	offset_user = TRUE

/datum/slapcraft_recipe/carpentry/structure/fence/check_craft_requirements(mob/user, turf/T)
	for(var/obj/structure/S in T)
		if(istype(S, /obj/structure/fluff/railing))
			if(user.dir == S.dir)
				return FALSE
	return ..()

/datum/slapcraft_recipe/carpentry/structure/chest
	name = "chest"
	steps = list(
		/datum/slapcraft_step/item/stake,
		/datum/slapcraft_step/item/small_log,
		/datum/slapcraft_step/item/small_log/second,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		)
	result_type = /obj/structure/closet/crate/chest/crafted

/obj/structure/closet/crate/chest/crafted
	name = "handcrafted chest"
	icon_state = "chest_neu"
	base_icon_state = "chest_neu"
	sellprice = 6

/datum/slapcraft_recipe/carpentry/structure/closet
	name = "closet"
	steps = list(
		/datum/slapcraft_step/item/small_log,
		/datum/slapcraft_step/item/small_log/second,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/plank,
		/datum/slapcraft_step/use_item/carpentry/hammer/second,
		)
	result_type = /obj/structure/closet/crate/crafted_closet/crafted

/obj/structure/closet/crate/crafted_closet/crafted
	sellprice = 6

/datum/slapcraft_recipe/carpentry/structure/coffin
	name = "wooden coffin"
	steps = list(
		/datum/slapcraft_step/item/plank,
		/datum/slapcraft_step/item/plank/second,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/plank,
		/datum/slapcraft_step/use_item/carpentry/hammer/second,
		)
	result_type = /obj/structure/closet/crate/coffin

/datum/slapcraft_recipe/carpentry/structure/haybed
	name = "hay bed"
	steps = list(
		/datum/slapcraft_step/item/plank,
		/datum/slapcraft_step/item/plank/second,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/cloth,
		/datum/slapcraft_step/use_item/sewing/needle,
		)
	result_type = /obj/structure/bed/hay
	craftdiff = 2

/datum/slapcraft_recipe/carpentry/structure/woolbed
	name = "wool bed"
	steps = list(
		/datum/slapcraft_step/item/plank,
		/datum/slapcraft_step/item/plank/second,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/cloth,
		/datum/slapcraft_step/use_item/sewing/needle,
		)
	result_type = /obj/structure/bed/wool
	craftdiff = 4

/datum/slapcraft_recipe/carpentry/structure/woolbed/double
	name = "double wool bed"
	steps = list(
		/datum/slapcraft_step/item/plank,
		/datum/slapcraft_step/item/plank/second,
		/datum/slapcraft_step/item/plank/third,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/cloth,
		/datum/slapcraft_step/item/cloth/second,
		/datum/slapcraft_step/item/cloth/third,
		/datum/slapcraft_step/use_item/sewing/needle,
		)
	result_type = /obj/structure/bed/wool/double

/datum/slapcraft_recipe/carpentry/structure/nicebed
	name = "nice bed"
	steps = list(
		/datum/slapcraft_step/item/plank,
		/datum/slapcraft_step/item/plank/second,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/cloth,
		/datum/slapcraft_step/item/cloth/second,
		/datum/slapcraft_step/item/fur,
		/datum/slapcraft_step/use_item/sewing/needle,
		)
	result_type = /obj/structure/bed
	craftdiff = 5

/datum/slapcraft_recipe/carpentry/structure/inn_bed
	name = "nice bed without sheets"
	steps = list(
		/datum/slapcraft_step/item/plank,
		/datum/slapcraft_step/item/plank/second,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/cloth,
		/datum/slapcraft_step/item/cloth/second,
		/datum/slapcraft_step/item/fur,
		/datum/slapcraft_step/use_item/sewing/needle,
		)
	result_type = /obj/structure/bed/inn
	craftdiff = 5

/datum/slapcraft_recipe/carpentry/structure/inn_bed/double
	name = "double nice bed"
	steps = list(
		/datum/slapcraft_step/item/plank,
		/datum/slapcraft_step/item/plank/second,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/cloth,
		/datum/slapcraft_step/item/cloth/second,
		/datum/slapcraft_step/item/cloth/third,
		/datum/slapcraft_step/item/cloth/fourth,
		/datum/slapcraft_step/item/fur,
		/datum/slapcraft_step/item/fur/second,
		/datum/slapcraft_step/use_item/sewing/needle,
		)
	result_type = /obj/structure/bed/inn/double

/datum/slapcraft_recipe/carpentry/structure/sign
	name = "custom sign"
	steps = list(
		/datum/slapcraft_step/item/stick,
		/datum/slapcraft_step/item/plank,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		)
	result_type = /obj/structure/fluff/customsign

/datum/slapcraft_recipe/carpentry/structure/training_dummy
	name = "training dummy"
	steps = list(
		/datum/slapcraft_step/item/plank,
		/datum/slapcraft_step/item/small_log,
		/datum/slapcraft_step/item/stick,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		)
	result_type = /obj/structure/fluff/statue/tdummy

/datum/slapcraft_recipe/carpentry/structure/display_stand
	name = "display stand"
	steps = list(
		/datum/slapcraft_step/item/plank,
		/datum/slapcraft_step/item/small_log,
		/datum/slapcraft_step/item/stick,
		/datum/slapcraft_step/item/stick/second,
		/datum/slapcraft_step/item/stick/third,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		)
	result_type = /obj/structure/mannequin
	craftdiff = 2

/datum/slapcraft_recipe/carpentry/structure/mannequin_female
	name = "female mannequin"
	steps = list(
		/datum/slapcraft_step/item/plank,
		/datum/slapcraft_step/item/small_log,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/iron,
		/datum/slapcraft_step/item/cloth,
		/datum/slapcraft_step/use_item/carpentry/hammer/second,
		)
	result_type = /obj/structure/mannequin/male/female
	craftdiff = 2

/datum/slapcraft_recipe/carpentry/structure/mannequin_male
	name = "male mannequin"
	steps = list(
		/datum/slapcraft_step/item/plank,
		/datum/slapcraft_step/item/small_log,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/iron,
		/datum/slapcraft_step/item/cloth,
		/datum/slapcraft_step/use_item/carpentry/hammer/second,
		)
	result_type = /obj/structure/mannequin/male
	craftdiff = 2

/datum/slapcraft_recipe/carpentry/structure/wall_ladder
	name = "wall ladder"
	steps = list(
		/datum/slapcraft_step/item/plank,
		/datum/slapcraft_step/item/plank/second,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/stick,
		/datum/slapcraft_step/item/stick/second,
		/datum/slapcraft_step/item/stick/third,
		/datum/slapcraft_step/use_item/carpentry/hammer/second,
		)
	result_type = /obj/structure/wallladder
	craftdiff = 0

/datum/slapcraft_recipe/carpentry/structure/wall_ladder/check_craft_requirements(mob/user, turf/T)
	var/turf/check_turf = get_step(T, user.dir)
	if(!isclosedturf(check_turf))
		return FALSE
	return TRUE

/datum/slapcraft_recipe/carpentry/structure/table
	name = "wooden table"
	steps = list(
		/datum/slapcraft_step/item/stick,
		/datum/slapcraft_step/item/stick/second,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/plank,
		/datum/slapcraft_step/use_item/carpentry/hammer/second,
		)
	result_type = /obj/structure/table/wood/crafted
	craftdiff = 0

/datum/slapcraft_recipe/carpentry/structure/pillory
	name = "pillory"
	steps = list(
		/datum/slapcraft_step/item/small_log,
		/datum/slapcraft_step/item/iron,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/lock,
		/datum/slapcraft_step/use_item/carpentry/hammer/second,
		)
	result_type = /obj/structure/pillory
	craftdiff = 2

/datum/slapcraft_recipe/carpentry/structure/easel
	name = "wooden easel"
	steps = list(
		/datum/slapcraft_step/item/small_log,
		/datum/slapcraft_step/item/stick,
		/datum/slapcraft_step/item/stick/second,
		/datum/slapcraft_step/use_item/carpentry/hammer
		)
	result_type = /obj/structure/easel

/datum/slapcraft_recipe/carpentry/structure/optable
	name = "operating table"
	steps = list(
		/datum/slapcraft_step/item/plank,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/plank/second,
		/datum/slapcraft_step/use_item/carpentry/hammer/second,
		)
	result_type = /obj/structure/table/optable
	craftdiff = 2

/datum/slapcraft_recipe/carpentry/structure/meathook
	name = "meathook"
	steps = list(
		/datum/slapcraft_step/item/plank,
		/datum/slapcraft_step/item/small_log,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/stone,
		/datum/slapcraft_step/use_item/carpentry/hammer/second,
		)
	result_type = /obj/structure/meathook
	craftdiff = 1

/datum/slapcraft_recipe/carpentry/structure/spider_nest
	name = "spider nesting house"
	steps = list(
		/datum/slapcraft_step/item/plank,
		/datum/slapcraft_step/item/plank/second,
		/datum/slapcraft_step/use_item/carpentry/hammer,
		/datum/slapcraft_step/item/plank/third,
		/datum/slapcraft_step/use_item/carpentry/hammer/second,
		)
	result_type = /obj/structure/spider/nest/constructed
	craftdiff = 1
