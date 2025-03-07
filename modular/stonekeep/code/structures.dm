/* * * * * * * * * * * **
 *						*
 *		 Structures		*
 *						*
 *						*
 * * * * * * * * * * * **/

// =================================================================================
/*--------\
| Closets |
\--------*/

/obj/structure/closet/crate/crafted_closet
	icon = 'modular/stonekeep/icons/structure.dmi'

/obj/structure/rack/shelf
	icon = 'modular/stonekeep/icons/structure.dmi'



// =================================================================================
/*----------------\
| Lighting tweaks |
\----------------*/
// base was 8, 5 for torches

/obj/machinery/light/fueled/firebowl
	brightness = 9
/obj/machinery/light/fueled/firebowl/Initialize()
	. = ..()
	brightness = 9
	light_outer_range =  9

/obj/machinery/light/fueled/wallfire
	brightness = 7
/obj/machinery/light/fueled/wallfire/Initialize()
	light_outer_range =  8
	brightness = 7
	. = ..()

/obj/machinery/light/fueled/wallfire/candle/Initialize()
	light_outer_range =  6
	brightness = 7
	. = ..()

/obj/machinery/light/fueled/torchholder
	brightness = 7
/obj/machinery/light/fueled/torchholder/Initialize()
	. = ..()
	light_outer_range =  6
	brightness = 6

/obj/machinery/light/fueled/campfire
	brightness = 7
/obj/machinery/light/fueled/campfire/Initialize()
	. = ..()
	light_outer_range =  6
	brightness = 7

/obj/machinery/light/fueled/torchholder/empty
	lacks_torch = TRUE
	pixel_y = 32

/obj/machinery/light/fueled/torchholder/cold
	unlit_torch = TRUE
	pixel_y = 32

/obj/machinery/light/fueled/firebowl/cold/Initialize(mapload)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(extinguish)), 10)

/obj/machinery/light/fueled/wallfire/candle/open	// starts cold, light it when open is the idea.
	name = "open candle"
	icon = 'modular/stonekeep/icons/structure.dmi'
	icon_state = "storecandle1"
	base_state = "storecandle"
/obj/machinery/light/fueled/wallfire/candle/open/Initialize(mapload)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(extinguish)), 10)

/obj/machinery/light/fueled/firebowl/standing/lamp
	name = "standing lamp"
	icon = 'modular/stonekeep/icons/structure.dmi'

// =================================================================================
/*-------\
| Tables |
\-------*/

/obj/structure/table/wood/plain
	icon = 'modular/stonekeep/icons/tables.dmi'

/obj/structure/table/wood/plain_alt
	icon = 'modular/stonekeep/icons/tables.dmi'

/obj/structure/table/wood/reinforced_alt
	icon = 'modular/stonekeep/icons/tables.dmi'

/obj/structure/table/vtable // modify with varedit for map1 big one
	icon = 'modular/stonekeep/icons/tables.dmi'

/obj/structure/table/wood/nice/decorated
	icon = 'modular/stonekeep/icons/tables.dmi'
	icon_state = "tablefine"
/obj/structure/table/wood/nice/decorated_alt
	icon = 'modular/stonekeep/icons/tables.dmi'
	icon_state = "tablefine2"

/obj/structure/table/wood/large_new
	icon = 'modular/stonekeep/icons/tables.dmi'
/obj/structure/table/wood/large_new/red
	icon_state = "largetable"
/obj/structure/table/wood/large_new/blue
	icon_state = "largetable_alt2"
/obj/structure/table/wood/large_new/yellow
	icon_state = "largetable_alt"
/obj/structure/table/wood/large/corner_new
	icon = 'modular/stonekeep/icons/tables.dmi'
/obj/structure/table/wood/large/corner_new/red
	icon_state = "largetable"
/obj/structure/table/wood/large/corner_new/blue
	icon_state = "largetable_alt2"
/obj/structure/table/wood/large/corner_new/yellow
	icon_state = "largetable_alt"


/obj/structure/table/vtable
	icon = 'modular/stonekeep/icons/tables.dmi'
/obj/structure/table/vtable/v2
	icon = 'modular/stonekeep/icons/tables.dmi'

/obj/structure/table/wood/crafted
	icon = 'modular/stonekeep/icons/tables.dmi'
	icon_state = "wsmall_poor"
/obj/structure/table/wood/crafted/better
	icon_state = "wsmall_average"
/obj/structure/table/wood/crafted/good
	icon_state = "wsmall_good"



/obj/structure/table/church
	name = "altar"
	icon = 'modular/stonekeep/icons/tables.dmi'
	icon_state = "church_r"
	debris = list(/obj/item/natural/stoneblock = 1)

/obj/structure/table/church/m
	icon = 'modular/stonekeep/icons/tables.dmi'
	icon_state = "church_mid"

/obj/structure/table/church/left
	icon_state = "church_l"

/obj/structure/table/stone
	name = "stone table"
	desc = ""
	icon = 'modular/stonekeep/icons/tables.dmi'
	icon_state = "stonetable_mid"
	max_integrity = 300
	smooth = 0
	climb_offset = 10
/obj/structure/table/stone/OnCrafted(dirin, user)
	if(dirin == NORTH)
		dir = NORTH
	if(dirin == SOUTH)
		dir = SOUTH
	if(dirin == WEST)
		dir = WEST
	if(dirin == EAST)
		dir = EAST
	. = ..()

/obj/structure/table/stone_end
	name = "stone table"
	desc = ""
	icon = 'modular/stonekeep/icons/tables.dmi'
	icon_state = "stonetable_end"
	max_integrity = 300
	smooth = 0
	climb_offset = 10
/obj/structure/table/stone_end/OnCrafted(dirin, user)
	if(dirin == NORTH)
		dir = NORTH
	if(dirin == SOUTH)
		dir = SOUTH
	if(dirin == WEST)
		dir = WEST
	if(dirin == EAST)
		dir = EAST
	. = ..()

/obj/structure/table/wood/long
	name = "table"
	desc = ""
	icon = 'modular/stonekeep/icons/tables.dmi'
	icon_state = "longtable"
	max_integrity = 100
	smooth = 0
	climb_offset = 8

/obj/structure/fluff/walldeco/customflag
	name = "royal flag"


// Temple pillars. Default is offset to north
/obj/structure/fluff/walldeco/pillar
	icon = 'modular/stonekeep/icons/temple.dmi'
	icon_state = "sandstone"
	pixel_y = 32

/obj/structure/fluff/walldeco/pillar/doric
	icon_state = "doric"
/obj/structure/fluff/walldeco/pillar/aztec
	icon_state = "aztec"
/obj/structure/fluff/walldeco/pillar/ionic
	icon_state = "ionic"
/obj/structure/fluff/walldeco/pillar/solomon
	icon_state = "solomon"
/obj/structure/fluff/walldeco/pillar/solomonalt
	icon_state = "solomon2"
/obj/structure/fluff/walldeco/pillar/egypt
	icon_state = "egypt"
/obj/structure/fluff/walldeco/pillar/nordic
	icon_state = "nordic"

// Placeholder shrines. Migth get better code at some point but use for now
/obj/machinery/light/fueled/wallfire/candle/lamp/temple
	icon = 'modular/stonekeep/icons/temple.dmi'

/obj/machinery/light/fueled/wallfire/candle/lamp/temple/noc
	icon_state = "noc1"
	base_state = "noc"
/obj/machinery/light/fueled/wallfire/candle/lamp/temple/pestra
	icon_state = "pestra1"
	base_state = "pestra"
/obj/machinery/light/fueled/wallfire/candle/lamp/temple/xylix
	icon_state = "xylix1"
	base_state = "xylix"
/obj/machinery/light/fueled/wallfire/candle/lamp/temple/eora
	icon_state = "eora1"
	base_state = "eora"
/obj/machinery/light/fueled/wallfire/candle/lamp/temple/malum
	icon_state = "malum1"
	base_state = "malum"
/obj/machinery/light/fueled/wallfire/candle/lamp/temple/ravox
	icon_state = "ravox1"
	base_state = "ravox"

// Sandstone brick wall
/turf/closed/wall/mineral/stonebrick/sandstone
	name = "sandstone wall"
	icon = 'modular/stonekeep/icons/sandstonebrick.dmi'


//AKA cryosleep.

/obj/structure/far_travel //Shamelessly jury-rigged from the way Fallout13 handles this.
	name = "far travel"
	desc = "Anywhere is better than here.\n(Drag your sprite onto this to exit the round!)"
	icon = 'modular/stonekeep/icons/turfs.dmi'
	icon_state = "fartravel"
	layer = BELOW_OBJ_LAYER
	density = FALSE
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	var/in_use = FALSE

/obj/structure/far_travel/MouseDrop_T(atom/dropping, mob/user)
	. = ..()
	if(!isliving(user) || user.incapacitated())
		return //No ghosts or incapacitated folk allowed to do this.
	if(!ishuman(dropping))
		return //Only humans have job slots to be freed.
	if(in_use) // Someone's already going in.
		return
	var/mob/living/carbon/human/departing_mob = dropping
	var/datum/job/mob_job
	if(departing_mob != user && departing_mob.client)
		to_chat(user, "<span class='warning'>This one retains their free will. It's their choice if they want to leave or not.</span>")
		return
	if(alert("Are you sure you want to [departing_mob == user ? "depart for good (you" : "send this person away (they"] will be removed from the current round)?", "Departing", "Confirm", "Cancel") != "Confirm")
		return
	if(user.incapacitated() || QDELETED(departing_mob) || (departing_mob != user && departing_mob.client) || get_dist(src, dropping) > 2 || get_dist(src, user) > 2)
		return //Things have changed since the alert happened.
	user.visible_message("<span class='warning'>[user] [departing_mob == user ? "is trying to depart from these lands!" : "is trying to send [departing_mob] away!"]</span>", "<span class='notice'>You [departing_mob == user ? "are trying to depart from Azure Peak." : "are trying to send [departing_mob] away."]</span>")
	in_use = TRUE
	if(!do_after(user, 50, target = src))
		in_use = FALSE
		return
	in_use = FALSE
	update_icon()
	var/dat = "[key_name(user)] has despawned [departing_mob == user ? "themselves" : departing_mob], job [departing_mob.job], at [AREACOORD(src)]. Contents despawned along:"
	if(departing_mob.mind)
		mob_job = SSjob.GetJob(departing_mob.mind.assigned_role)
		if(mob_job)
			mob_job.current_positions = max(0, mob_job.current_positions - 1)
	if(!length(departing_mob.contents))
		dat += " none."
	else
		var/atom/movable/content = departing_mob.contents[1]
		dat += " [content.name]"
		for(var/i in 2 to length(departing_mob.contents))
			content = departing_mob.contents[i]
			dat += ", [content.name]"
		dat += "."
	if(departing_mob.mind)
		departing_mob.mind.unknow_all_people()
		for(var/datum/mind/MF in get_minds())
			departing_mob.mind.become_unknown_to(MF)
	GLOB.chosen_names -= departing_mob.real_name
//	LAZYREMOVE(GLOB.actors_list, departing_mob.mobid)	If actors added re-enable ROGTODO
//	LAZYREMOVE(GLOB.roleplay_ads, departing_mob.mobid)
	message_admins(dat)
	log_admin(dat)
	if(departing_mob.stat == DEAD)
		departing_mob.visible_message("<span class='notice'>[user] sends the body of [departing_mob] away. They're someone else's problem now.</span>")
	else
		departing_mob.visible_message("<span class='notice'>[departing_mob == user ? "Out of their own volition, " : "Ushered by [user], "][departing_mob] leaves these lands.</span>")
	qdel(departing_mob)
// Trellises
/obj/structure/trellise
	icon = 'modular/stonekeep/icons/structure.dmi'
	icon_state = "trellise_empty"



/obj/structure/flora/rock/pile
	density = FALSE

/obj/structure/chimney
	density = TRUE
	icon = 'modular/stonekeep/icons/structure.dmi'
	icon_state = "chimney"


/obj/structure/bars/cemetery/vines
	icon = 'modular/stonekeep/icons/structure.dmi'
/obj/structure/bars/cemetery/vines/Initialize()
	dir = pick(GLOB.cardinals)
	. = ..()

/obj/structure/table/stone_small/gravekeeper
	name = "body preparation slate"
	color = "#b4b4b6"

/obj/structure/giantfur
	layer = BELOW_OPEN_DOOR_LAYER


/obj/structure/mineral_door/swing_door/horizontal
	icon = 'modular/stonekeep/icons/structure.dmi'


/obj/structure/fluff/railing/stonehedge
	icon = 'modular/stonekeep/icons/railing.dmi'
	passcrawl = FALSE
	pass_flags = LETPASSTHROW

/obj/effect/decal/stonehedge_corner
	name = "stone hedge"
	desc = ""
	icon = 'modular/stonekeep/icons/railing.dmi'
	icon_state = "stone_decorn"
	mouse_opacity = 0
