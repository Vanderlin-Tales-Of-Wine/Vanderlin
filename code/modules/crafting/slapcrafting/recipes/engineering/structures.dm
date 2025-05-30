/datum/slapcraft_recipe/engineering/structure/art_table
	name = "artificer table"
	steps = list(
		/datum/slapcraft_step/item/plank,
		/datum/slapcraft_step/item/stone,
		/datum/slapcraft_step/item/plank/second,
		/datum/slapcraft_step/item/stone/second,
		/datum/slapcraft_step/use_item/engineering/hammer,
		)
	result_type = /obj/machinery/artificer_table
	craftsound = null

/datum/slapcraft_recipe/engineering/structure/lever
	name = "lever"
	steps = list(
		/datum/slapcraft_step/item/cog,
		/datum/slapcraft_step/item/stick,
		/datum/slapcraft_step/use_item/engineering/hammer,
		)
	result_type = /obj/structure/lever
	craftsound = 'sound/foley/Building-01.ogg'

/datum/slapcraft_recipe/engineering/structure/trapdoor
	name = "floorhatch"
	steps = list(
		/datum/slapcraft_step/item/cog,
		/datum/slapcraft_step/item/small_log,
		/datum/slapcraft_step/use_item/engineering/hammer,
		)
	result_type = /obj/structure/floordoor
	craftsound = 'sound/foley/Building-01.ogg'
	offset_forward = TRUE

/datum/slapcraft_recipe/engineering/structure/trapdoor/check_craft_requirements(mob/user, turf/T)
	if(istype(T,/turf/open/transparent/openspace))
		return TRUE
	if(istype(T, /turf/open/water))
		return TRUE
	if(istype(T,/turf/open/lava))
		return TRUE // its just too hilarious not to allow this
	for(var/obj/structure/floordoor/FD in T)
		return FALSE
	return ..()

/datum/slapcraft_recipe/engineering/structure/pressure_plate
	name = "pressure plate"
	steps = list(
		/datum/slapcraft_step/item/cog,
		/datum/slapcraft_step/item/plank,
		/datum/slapcraft_step/item/plank/second,
		/datum/slapcraft_step/use_item/engineering/hammer,
		)
	result_type = /obj/structure/pressure_plate
	craftsound = 'sound/foley/Building-01.ogg'

/datum/slapcraft_recipe/engineering/structure/repeater
	name = "repeater"
	steps = list(
		/datum/slapcraft_step/item/cog,
		/datum/slapcraft_step/item/iron,
		/datum/slapcraft_step/item/iron/second,
		/datum/slapcraft_step/use_item/engineering/hammer,
		/datum/slapcraft_step/item/stick,
		)
	result_type = /obj/structure/repeater
	craftsound = 'sound/foley/Building-01.ogg'

/datum/slapcraft_recipe/engineering/structure/activator
	name = "activator"
	steps = list(
		/datum/slapcraft_step/item/cog,
		/datum/slapcraft_step/item/cog/second,
		/datum/slapcraft_step/item/iron,
		/datum/slapcraft_step/use_item/engineering/hammer,
		/datum/slapcraft_step/item/small_log,
		/datum/slapcraft_step/item/small_log/second,
		/datum/slapcraft_step/use_item/engineering/hammer/second,
		)
	result_type = /obj/structure/activator
	craftsound = 'sound/foley/Building-01.ogg'

/datum/slapcraft_recipe/engineering/structure/passage
	name = "passage"
	steps = list(
		/datum/slapcraft_step/item/cog,
		/datum/slapcraft_step/item/iron,
		/datum/slapcraft_step/use_item/engineering/hammer,
		)
	result_type = /obj/structure/bars/passage
	craftsound = 'sound/foley/Building-01.ogg'


/datum/slapcraft_recipe/engineering/structure/distiller
	name = "copper distiller"
	steps = list(
		/datum/slapcraft_step/item/copper,
		/datum/slapcraft_step/item/copper/second,
		/datum/slapcraft_step/use_item/engineering/hammer,
		/datum/slapcraft_step/item/cog,
		/datum/slapcraft_step/use_item/engineering/hammer/second,
		)
	result_type = /obj/structure/fermentation_keg/distiller
	craftsound = 'sound/foley/Building-01.ogg'

/datum/slapcraft_recipe/engineering/structure/bars
	name = "iron bars"
	steps = list(
		/datum/slapcraft_step/item/iron,
		/datum/slapcraft_step/use_item/engineering/hammer,
		)
	result_type = /obj/structure/bars
	craftsound = 'sound/foley/Building-01.ogg'

/datum/slapcraft_recipe/engineering/structure/bars_bent
	name = "iron bars (bent)"
	steps = list(
		/datum/slapcraft_step/item/iron,
		/datum/slapcraft_step/use_item/engineering/hammer,
		)
	result_type = /obj/structure/bars/bent
	craftsound = 'sound/foley/Building-01.ogg'


/datum/slapcraft_recipe/engineering/structure/orphan_crusher
	name = "Auto Anvil"
	steps = list(
		/datum/slapcraft_step/item/steel,
		/datum/slapcraft_step/item/steel/second,
		/datum/slapcraft_step/use_item/engineering/hammer,
		/datum/slapcraft_step/item/cog,
		/datum/slapcraft_step/item/cog/second,
		/datum/slapcraft_step/use_item/engineering/hammer,
	)

	result_type = /obj/structure/orphan_smasher
	craftsound = 'sound/foley/Building-01.ogg'
