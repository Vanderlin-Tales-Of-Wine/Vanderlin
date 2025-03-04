
/datum/crafting_recipe/roguetown/structure
	req_table = FALSE
	craftdiff = 0
	verbage = "build"
	verbage_tp = "builds"

/datum/crafting_recipe/roguetown/structure/TurfCheck(mob/user, turf/T)
	if(istype(T,/turf/open/transparent/openspace))
		return FALSE
	return ..()


/*========= CARPENTRY SKILL ==========*/
/datum/crafting_recipe/roguetown/structure/carpentry
	skillcraft = /datum/skill/craft/carpentry
	time = 3 SECONDS
	verbage = "carpent"
	verbage_tp = "carpents"
	craftsound = 'sound/foley/Building-01.ogg'
	tools = list(/obj/item/weapon/hammer)

/datum/crafting_recipe/roguetown/structure/carpentry/stool
	name = "chair (stool)"
	result = /obj/item/chair/stool/bar/crafted
	reqs = list(/obj/item/grown/log/tree/small = 1)


/* === SKILL LEVEL 1 === */

/datum/crafting_recipe/roguetown/structure/carpentry/chair
	name = "chair (wood)"
	result = /obj/item/chair
	reqs = list(/obj/item/grown/log/tree/small = 2)
	craftdiff = 1

/datum/crafting_recipe/roguetown/structure/carpentry/composter
	name = "composter"
	result = /obj/structure/composter
	craftdiff = 1

/datum/crafting_recipe/roguetown/structure/carpentry/roguebin // Bins are easier to craft than barrels for pure convenience.
	name = "bin"
	result = /obj/item/bin
	reqs = list(/obj/item/grown/log/tree/small = 2)
	verbage = "construct"
	verbage_tp = "makes"
	craftdiff = 1

/datum/crafting_recipe/roguetown/structure/carpentry/table
	name = "table (wood)"
	result = /obj/structure/table/wood/crafted
	reqs = list(/obj/item/grown/log/tree/small = 2)
	verbage = "carpent"
	verbage_tp = "carpents"
	craftdiff = 1

/datum/crafting_recipe/roguetown/structure/carpentry/wallladder
	name = "wall ladder"
	result = /obj/structure/wallladder
	reqs = list(/obj/item/grown/log/tree/small = 1)
	verbage = "carpent"
	verbage_tp = "carpents"
	wallcraft = TRUE
	craftdiff = 1
/datum/crafting_recipe/roguetown/structure/carpentry/wallladder/TurfCheck(mob/user, turf/T)
	var/turf/check_turf = get_step(T, user.dir)
	if(!isclosedturf(check_turf))
		return FALSE
	return TRUE

/datum/crafting_recipe/roguetown/structure/carpentry/sign
	name = "custom sign"
	result = /obj/structure/fluff/customsign
	verbage = "construct"
	verbage_tp = "constructs"
	craftdiff = 1

/datum/crafting_recipe/roguetown/structure/carpentry/chest
	name = "chest"
	result = /obj/structure/closet/crate/chest/crafted
	reqs = list(/obj/item/grown/log/tree/small = 1)
	verbage = "construct"
	verbage_tp = "constructs"
	craftdiff = 1

/obj/structure/closet/crate/chest/crafted
	name = "sturdy chest"
	icon_state = "chest_neu"
	base_icon_state = "chest_neu"
	keylock = FALSE
	sellprice = 6

/datum/crafting_recipe/roguetown/structure/carpentry/closet
	name = "closet"
	result = /obj/structure/closet/crate/crafted_closet/crafted
	reqs = list(/obj/item/grown/log/tree/small = 2)
	verbage = "construct"
	verbage_tp = "constructs"
	craftdiff = 1

/datum/crafting_recipe/roguetown/structure/carpentry/coffin
	name = "coffin"
	result = /obj/structure/closet/crate/coffin
	reqs = list(/obj/item/grown/log/tree/small=3)
	verbage = "construct"
	verbage_tp = "constructs"
	craftdiff = 1

/datum/crafting_recipe/roguetown/structure/carpentry/psycrss
	name = "psycross (wood)"
	result = /obj/structure/fluff/psycross/crafted
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/grown/log/tree/stake = 3)
	craftdiff = 1

/datum/crafting_recipe/roguetown/structure/carpentry/loom
	name = "loom"
	result = /obj/machinery/loom
	reqs = list(/obj/item/grown/log/tree/small = 2,
				/obj/item/grown/log/tree/stick = 2,
				/obj/item/natural/fibers = 2)

	verbage = "constructs"
	craftdiff = 1

/datum/crafting_recipe/roguetown/structure/carpentry/dummy // Easier to craft than display dummies for convenience, and also because a training dummy isn't actually fitting any measurements. You're just smacking it.
	name = "training dummy"
	result = /obj/structure/fluff/statue/tdummy
	reqs = list(/obj/item/grown/log/tree/small = 1)
	verbage = "construct"
	verbage_tp = "constructs"
	craftdiff = 1

/* === SKILL LEVEL 2 === */

/datum/crafting_recipe/roguetown/structure/carpentry/display_stand
	name = "display stand"
	result = /obj/structure/mannequin
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/grown/log/tree/stick = 3)
	verbage = "construct"
	verbage_tp = "constructs"
	craftdiff = 2

/datum/crafting_recipe/roguetown/structure/carpentry/mannequin
	name = "mannequin (male)"
	result = /obj/structure/mannequin/male
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/cloth = 1,
				/obj/item/ingot/iron = 1)
	verbage = "construct"
	verbage_tp = "constructs"
	craftdiff = 2

/datum/crafting_recipe/roguetown/structure/carpentry/mannequin_f
	name = "mannequin (female)"
	result = /obj/structure/mannequin/male/female
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/cloth = 1,
				/obj/item/ingot/iron = 1)
	verbage = "construct"
	verbage_tp = "constructs"
	craftdiff = 2

/datum/crafting_recipe/roguetown/structure/carpentry/handcart
	name = "handcart"
	result = /obj/structure/handcart
	reqs = list(/obj/item/grown/log/tree/small = 3,
				/obj/item/rope = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/structure/carpentry/barrel
	name = "barrel"
	result = /obj/structure/fermenting_keg/crafted
	reqs = list(/obj/item/grown/log/tree/small=2)
	verbage = "construct"
	verbage_tp = "makes"
	craftdiff = 2

/obj/structure/fermenting_keg/crafted
	sellprice = 6

/datum/crafting_recipe/roguetown/structure/carpentry/stairsd
	name = "stairs (down)"
	result = /obj/structure/stairs/d
	verbage = "construct"
	verbage_tp = "constructs"
	ontile = TRUE
/datum/crafting_recipe/roguetown/structure/carpentry/stairsd/TurfCheck(mob/user, turf/T)
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
		if(istype(S, /obj/structure/stairs))
			return FALSE
		if(S.density)
			return FALSE
	return TRUE



/datum/crafting_recipe/roguetown/structure/carpentry/nicebed
	name = "bed (good)"
	result = /obj/structure/bed
	reqs = list(/obj/item/grown/log/tree/small=2,
				/obj/item/natural/cloth = 1)
	tools = list(/obj/item/needle)
	craftdiff = 2

/datum/crafting_recipe/roguetown/structure/carpentry/door
	name = "door (wood)"
	result = /obj/structure/mineral_door/wood/deadbolt
	reqs = list(/obj/item/grown/log/tree/small=2)
	craftdiff = 2

/datum/crafting_recipe/roguetown/structure/carpentry/railing
	name = "railing"
	result = /obj/structure/fluff/railing/wood
	reqs = list(/obj/item/grown/log/tree/small=2)
	craftdiff = 2
/datum/crafting_recipe/roguetown/structure/carpentry/railing/TurfCheck(mob/user, turf/T)
	for(var/obj/structure/S in T)
		if(istype(S, /obj/structure/fluff/railing))
			if(user.dir == S.dir)
				return FALSE

/datum/crafting_recipe/roguetown/structure/carpentry/easel
	name = "painting (easel)"
	result = /obj/structure/easel
	reqs = list(/obj/item/grown/log/tree/stick = 3)
	verbage = "construct"
	verbage_tp = "makes"
	craftdiff = 3


/datum/crafting_recipe/roguetown/structure/carpentry/optable
	name = "feldsher table"
	result = /obj/structure/table/optable
	reqs = list(/obj/item/grown/log/tree/small=2)
	verbage = "construct"
	verbage_tp = "makes"
	craftdiff = 3

/datum/crafting_recipe/roguetown/structure/carpentry/meathook
	name = "meathook"
	result = /obj/structure/meathook
	reqs = list(/obj/item/grown/log/tree/small=2, /obj/item/rope/chain = 1)
	verbage = "construct"
	verbage_tp = "makes"
	craftdiff = 3


/*========= MASONRY SKILL ==========*/
/datum/crafting_recipe/roguetown/structure/masonry
	skillcraft = /datum/skill/craft/masonry
	time = 3 SECONDS
	verbage = "mason"
	verbage_tp = "masons"
	craftsound = 'sound/foley/Building-01.ogg'

/datum/crafting_recipe/roguetown/structure/masonry/millstone
	name = "millstone"
	result = /obj/structure/fluff/millstone
	reqs = list(/obj/item/natural/stone = 3)
	verbage = "craft"
	verbage_tp = "crafts"
	craftdiff = 1

/datum/crafting_recipe/roguetown/structure/masonry/cauldron
	name = "cauldron"
	result = /obj/machinery/light/fueled/cauldron
	reqs = list(/obj/item/ingot/iron = 2,
				/obj/item/natural/stone = 4,
				/obj/item/grown/log/tree/small = 1)
	verbage = "craft"
	verbage_tp = "crafts"
	craftdiff = 1

/datum/crafting_recipe/roguetown/structure/masonry/oven
	name = "oven"
	result = /obj/machinery/light/fueled/oven
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/stone = 3)
	wallcraft = TRUE
	craftdiff = 1

/datum/crafting_recipe/roguetown/structure/masonry/window
	name = "window (fixed)"
	result = /obj/structure/window/solid
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/glass = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/structure/masonry/windowopen
	name = "window (openable)"
	result = /obj/structure/window/openclose
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/glass = 1,
				/obj/item/ingot/iron = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/structure/masonry/windowstained
	name = "window (stained glass)"
	result = /obj/structure/window/stained
	reqs = list(/obj/item/natural/stoneblock = 3,
				/obj/item/natural/glass = 2,
				/obj/item/ingot/silver = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/structure/masonry/stonetable
	name = "table (stone long mid)"
	result = /obj/structure/table/stone
	reqs = list(/obj/item/natural/stoneblock = 2)
	verbage = "build"
	verbage_tp = "builds"
	craftdiff = 3
/datum/crafting_recipe/roguetown/structure/masonry/stonetable/end
	name = "table (stone long end)"
	result = /obj/structure/table/stone_end

/datum/crafting_recipe/roguetown/structure/masonry/stonetable/small
	name = "table (stone single)"
	result = /obj/structure/table/stone_small

/*========= MISCELLANY/CRAFTING SKILL ==========*/

/* === NO SKILL NEEDED === */

/datum/crafting_recipe/roguetown/structure/noose
	name = "noose"
	result = /obj/structure/noose
	reqs = list(/obj/item/rope = 1)
	verbage = "tie"
	verbage_tp = "ties"
	craftsound = 'sound/foley/noose_idle.ogg'
	ontile = TRUE
/datum/crafting_recipe/roguetown/structure/noose/TurfCheck(mob/user, turf/T)
	var/turf/checking = get_step_multiz(T, UP)
	if(!checking)
		return FALSE
	if(isopenturf(checking))
		return FALSE
	if(istype(checking,/turf/open/transparent/openspace))
		return FALSE
	for(var/obj/structure/noose/N in T)
		return FALSE
	return TRUE

/datum/crafting_recipe/roguetown/structure/fence
	name = "palisade (s x2)"
	result = /obj/structure/fluff/railing/fence
	reqs = list(/obj/item/grown/log/tree/stake = 2)
	ontile = TRUE
	craftsound = 'sound/foley/Building-01.ogg'
	buildsame = TRUE

/datum/crafting_recipe/roguetown/structure/fence/alt
	name = "palisade (l)"
	reqs = list(/obj/item/grown/log/tree/small = 1)
/datum/crafting_recipe/roguetown/structure/fence/TurfCheck(mob/user, turf/T)
	for(var/obj/structure/S in T)
		if(istype(S, /obj/structure/fluff/railing))
			if(user.dir == S.dir)
				return FALSE

/datum/crafting_recipe/roguetown/structure/bed // This one's not in carpentry because it's just a shitty pile of sticks and cloth.
	name = "bed (terrible)"
	result = /obj/structure/bed/shit
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/fibers = 1)

/datum/crafting_recipe/roguetown/structure/campfire
	name = "campfire"
	result = /obj/machinery/light/fueled/campfire
	reqs = list(/obj/item/grown/log/tree/stick = 2)

/datum/crafting_recipe/roguetown/structure/densefire
	name = "greater campfire"
	result = /obj/machinery/light/fueled/campfire/densefire
	reqs = list(/obj/item/grown/log/tree/stick = 2,
				/obj/item/natural/stone = 2)

/datum/crafting_recipe/roguetown/structure/pyre
	name = "wooden pyre"
	result = /obj/machinery/light/fueled/campfire/pyre
	reqs = list(/obj/item/grown/log/tree/small = 2,
				/obj/item/grown/log/tree/stake = 3)
	craftsound = 'sound/foley/Building-01.ogg'

/* === SKILL LEVEL 1 === */

/datum/crafting_recipe/roguetown/structure/cookpit
	name = "cookpit"
	result = /obj/machinery/light/fueled/hearth
	reqs = list(/obj/item/grown/log/tree/stick = 1,
				/obj/item/natural/stone = 3)
	craftdiff = 1

/datum/crafting_recipe/roguetown/structure/brazier
	name = "brazier"
	result = /obj/machinery/light/fueled/firebowl/stump
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/ore/coal = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/structure/dryingrack
	name = "drying rack"
	result = /obj/machinery/tanningrack
	reqs = list(/obj/item/grown/log/tree/stick = 4)
	verbage = "construct"
	verbage_tp = "constructs"
	craftsound = 'sound/foley/Building-01.ogg'
	craftdiff = 1

/* === SKILL LEVEL 2 === */

/datum/crafting_recipe/roguetown/structure/anvil // Call me crazy, but I think there should be some difficulty involved in making these huge structures.
	name = "anvil"
	result = /obj/machinery/anvil
	reqs = list(/obj/item/ingot/iron = 1)
	craftsound = 'sound/foley/Building-01.ogg'
	craftdiff = 2

/datum/crafting_recipe/roguetown/structure/smelter
	name = "ore furnace"
	result = /obj/machinery/light/fueled/smelter
	reqs = list(/obj/item/natural/stone = 6,
			/obj/item/ore/coal = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/structure/smelter_block
	name = "ore furnace"
	result = /obj/machinery/light/fueled/smelter
	reqs = list(/obj/item/natural/stoneblock = 4,
			/obj/item/ore/coal = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/structure/forge
	name = "forge"
	result = /obj/machinery/light/fueled/forge
	reqs = list(/obj/item/natural/stoneblock = 4,
				/obj/item/ore/coal = 1)
	craftdiff = 2

/* === SKILL LEVEL 3 === */

/datum/crafting_recipe/roguetown/structure/sharpwheel
	name = "sharpening wheel"
	result = /obj/structure/grindwheel
	reqs = list(/obj/item/ingot/iron = 1,
				/obj/item/natural/stone = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/structure/greatsmelter // I figure if you've already got a riddle of steel you're a mason making this anyway.
	name = "great furnace"
	result = /obj/machinery/light/fueled/smelter/great
	reqs = list(/obj/item/ingot/iron = 2,
				/obj/item/riddleofsteel = 1,
				/obj/item/ore/coal = 1)
	craftsound = null
	craftdiff = 3


/*========= ENGINEERING SKILL ==========*/
/datum/crafting_recipe/roguetown/structure/engineer
	verbage = "construct"
	verbage_tp = "constructs"
	craftsound = 'sound/foley/Building-01.ogg'
	skillcraft = /datum/skill/craft/engineering

/datum/crafting_recipe/roguetown/structure/engineer/lever
	name = "lever"
	result = /obj/structure/lever
	reqs = list(/obj/item/gear = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/structure/engineer/trapdoor
	name = "floorhatch"
	result = /obj/structure/floordoor
	reqs = list(/obj/item/grown/log/tree/small = 1,
					/obj/item/gear = 1)
	craftdiff = 1
/datum/crafting_recipe/roguetown/structure/engineer/trapdoor/TurfCheck(mob/user, turf/T)
	if(istype(T,/turf/open/transparent/openspace))
		return TRUE
	if(istype(T,/turf/open/lava))
		return TRUE // its just too hilarious not to allow this
	return ..()

/datum/crafting_recipe/roguetown/structure/engineer/pressure
	name = "pressure plate"
	result = /obj/structure/pressure_plate
	reqs = list(/obj/item/grown/log/tree/small = 1,
					/obj/item/gear = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/structure/engineer/repeater
	name = "repeater"
	result = /obj/structure/repeater
	reqs = list(/obj/item/grown/log/tree/small = 1,
					/obj/item/ingot/iron = 2,
					/obj/item/gear = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/structure/engineer/activator
	name = "activator"
	result = /obj/structure/activator
	reqs = list(/obj/item/grown/log/tree/small = 2,
					/obj/item/ingot/iron = 1,
					/obj/item/gear = 2)
	craftdiff = 1

/datum/crafting_recipe/roguetown/structure/engineer/passage
	name = "passage"
	result = /obj/structure/bars/passage
	reqs = list(/obj/item/ingot/iron = 1,
					/obj/item/gear = 1)
	craftdiff = 1
/datum/crafting_recipe/roguetown/structure/engineer/passage/TurfCheck(mob/user, turf/T)
	if(istype(T,/turf/open/transparent/openspace))
		return FALSE
	if(istype(T,/turf/open/lava))
		return FALSE
	if(istype(T,/turf/open/water))
		return FALSE
	return ..()
