/obj/item/roguemachine/fence
	name = "FENCER"
	desc = "A machine that funnels valuables to a place far, far away..."
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "ballooner"
	density = TRUE
	blade_dulling = DULLING_BASH
	var/next_canister
	var/accepted_items
	var/min_tax_percent = 10
	var/max_tax_percent = 30
	var/tax = 20
	max_integrity = 0
	anchored = TRUE
	w_class = WEIGHT_CLASS_GIGANTIC

/obj/item/roguemachine/fence/New()
	. = ..()
	tax = rand(min_tax_percent, max_tax_percent)

/obj/structure/fake_machine/fence_chute
	name = ""
	desc = ""
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = ""
	density = FALSE
	layer = BELOW_OBJ_LAYER
	anchored = TRUE

/obj/item/roguemachine/fence/attack_hand(mob/living/user)
	if(!anchored)
		return ..()
	user.changeNext_move(CLICK_CD_MELEE)

	var/contents

	contents += "<center>THE DEN<BR>"
	contents += "--------------<BR>"
	contents += "FENCER's Tax: [tax]%<BR>"
	contents += "Next Canister: [time2text((next_canister - world.time), "mm:ss")]</center><BR>"

	if(!user.can_read(src, TRUE))
		contents = stars(contents)
	var/datum/browser/popup = new(user, "VENDORTHING", "", 370, 220)
	popup.set_content(contents)
	popup.open()

/obj/item/roguemachine/fence/update_icon()
	if(!anchored)
		w_class = WEIGHT_CLASS_BULKY
		set_light(0)
		return
	w_class = WEIGHT_CLASS_GIGANTIC
	set_light(1, 1, 1, l_color =  "#9C37B5")

/obj/item/roguemachine/fence/Initialize()
	. = ..()
	if(anchored)
		START_PROCESSING(SSroguemachine, src)
	update_icon()
	for(var/X in GLOB.alldirs)
		var/T = get_step(src, X)
		if(!T)
			continue
		new /obj/structure/fake_machine/fence_chute(T)

/obj/item/roguemachine/fence/Destroy()
	STOP_PROCESSING(SSroguemachine, src)
	set_light(0)
	return ..()

/obj/item/roguemachine/fence/process()
	if(!anchored)
		return TRUE
	if(world.time > next_canister)
		next_canister = world.time + rand(2 MINUTES, 3 MINUTES)
#ifdef TESTSERVER
		next_canister = world.time + 5 SECONDS
#endif
		var/play_sound = FALSE
		for(var/D in GLOB.alldirs)
			var/budgie = 0
			var/turf/T = get_step(src, D)
			if(!T)
				continue
			var/obj/structure/fake_machine/fence_chute/E = locate() in T
			if(!E)
				continue
			for(var/obj/I in T)
				if(I.anchored)
					continue
				if(!isturf(I.loc))
					continue
				if(!(istype(I, /obj/item/statue) || istype(I, /obj/item/painting) || istype(I, /obj/item/gem) || istype(I, /obj/item/reagent_containers/glass/cup/silver) || istype(I, /obj/item/reagent_containers/glass/cup/golden) || istype(I, /obj/item/reagent_containers/glass/carafe) || istype(I, /obj/item/weapon) || istype(I, /obj/item/clothing) || istype(I, /obj/item/reagent_containers/food/snacks/organ) || istype(I, /obj/item/organ)))
					continue
				var/prize = I.get_real_price() * (1 - tax / 100)
				if(prize >= 1)
					play_sound=TRUE
					budgie += prize
					I.visible_message("<span class='warning'>[I] is sucked into the tube!</span>")
					qdel(I)
			budgie = round(budgie)
			if(budgie > 0)
				play_sound=TRUE
				E.budget2change(budgie)
				budgie = 0
		if(play_sound)
			playsound(src.loc, 'sound/misc/stolen.ogg', 50, TRUE, -1)
