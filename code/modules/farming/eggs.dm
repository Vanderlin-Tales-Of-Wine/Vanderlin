
/obj/item/reagent_containers/food/snacks/egg
	icon = 'modular/Neu_Food/icons/food.dmi'
	name = "cackleberry"
	desc = ""
	icon_state = "egg"
	dropshrink = 0.8
	list_reagents = list(/datum/reagent/consumable/eggyolk = 5)
	cooked_type = null
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/friedegg
	filling_color = "#F0E68C"
	foodtype = MEAT
	grind_results = list()
	rotprocess = 15 MINUTES
	become_rot_type = /obj/item/reagent_containers/food/snacks/rotten/egg

	var/fertile = FALSE

/obj/item/reagent_containers/food/snacks/egg/become_rotten()
	. = ..()
	if(.)
		fertile = FALSE


/obj/item/reagent_containers/food/snacks/egg/Crossed(mob/living/carbon/human/H)
	..()
	if(istype(H))
		var/turf/T = get_turf(src)
		var/obj/O = new /obj/effect/decal/cleanable/food/egg_smudge(T)
		O.pixel_x = rand(-8,8)
		O.pixel_y = rand(-8,8)
		visible_message("<span class='warning'>[H] crushes [src] underfoot.</span>")
		qdel(src)

/obj/item/reagent_containers/food/snacks/egg/proc/hatch(mob/living/simple_animal/hostile/retaliate/rogue/chicken/parent)
	new /mob/living/simple_animal/hostile/retaliate/rogue/chicken/chick(get_turf(parent))
