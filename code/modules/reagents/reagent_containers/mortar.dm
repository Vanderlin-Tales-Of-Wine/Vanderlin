
/obj/item/pestle
	name = "pestle"
	desc = ""
	icon = 'icons/roguetown/misc/alchemy.dmi'
	icon_state = "pestle"
	force = 7
	dropshrink = 0.9
	grid_height = 64
	grid_width = 32
/obj/item/reagent_containers/glass/mortar
	name = "mortar"
	desc = "A versatile mortar for both alchemy and reagent processing."
	icon = 'icons/roguetown/misc/alchemy.dmi'
	icon_state = "mortar"
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5, 10, 15, 20, 25, 30, 50, 100)
	volume = 100
	reagent_flags = OPENCONTAINER
	spillable = TRUE
	var/obj/item/to_grind
	grid_height = 32
	grid_width = 64
	dropshrink = 0.9

/obj/item/reagent_containers/glass/mortar/attack_right(mob/user)
	user.changeNext_move(CLICK_CD_MELEE)
	if(to_grind)
		var/obj/item/N = to_grind
		N.forceMove(get_turf(user))
		to_chat(user, "<span class='notice'>I remove [to_grind] from the mortar.</span>")
		to_grind = null
		return
	to_chat(user, "<span class='notice'>It's empty.</span>")

/obj/item/reagent_containers/glass/mortar/AltClick(mob/user)
	if(to_grind)
		to_grind.forceMove(drop_location())
		to_grind = null
		to_chat(user, "<span class='notice'>I eject the item inside.</span>")

/obj/item/reagent_containers/glass/mortar/attackby(obj/item/I, mob/living/carbon/human/user)
	if(istype(I,/obj/item/pestle))
		if(!to_grind)
			if(user.try_recipes(src, I, user))
				user.changeNext_move(CLICK_CD_FAST)
				return TRUE
			to_chat(user, "<span class='warning'>There's nothing to grind.</span>")
			return

		// Check for alchemical recipe first
		var/datum/alch_grind_recipe/foundrecipe = find_recipe()

		var/choice
		// If item has grind/juice results but no alchemical recipe, default to reagent processing
		if((to_grind.grind_results || to_grind.juice_results))
			choice = "Process"
			if(foundrecipe) // If both options are valid
				choice = input(user, "What would you like to do?", "Grinding Options") as null|anything in list("Alchemy", "Process")
				if(!choice)
					return

		if(choice == "Process")
			to_chat(user, "<span class='notice'>I start grinding...</span>")
			if((do_after(user, 2.5 SECONDS, src)) && to_grind)
				if(to_grind.juice_results) //prioritize juicing
					to_grind.on_juice()
					reagents.add_reagent_list(to_grind.juice_results)
					to_chat(user, "<span class='notice'>I juice [to_grind] into a fine liquid.</span>")
					if(to_grind.reagents) //food and pills
						to_grind.reagents.trans_to(src, to_grind.reagents.total_volume, transfered_by = user)
					QDEL_NULL(to_grind)
					return
				to_grind.on_grind()
				reagents.add_reagent_list(to_grind.grind_results)
				to_chat(user, "<span class='notice'>I break [to_grind] into powder.</span>")
				QDEL_NULL(to_grind)
			return

		if(!foundrecipe)
			to_chat(user, "<span class='warning'>You dont think that will work!</span>")
			return

		// Process alchemical recipe
		user.visible_message("<span class='info'>[user] begins grinding up [I].</span>")
		playsound(loc, 'sound/foley/mortarpestle.ogg', 100, FALSE)
		if(do_after(user, 1 SECONDS, src))
			for(var/output in foundrecipe.valid_outputs)
				for(var/i in 1 to foundrecipe.valid_outputs[output])
					new output(get_turf(src))
			var/bonus_modifier = 1
			switch(user.mind?.get_learning_boon(/datum/skill/craft/alchemy))
				if(SKILL_LEVEL_JOURNEYMAN)
					bonus_modifier = 1.4
				if(SKILL_LEVEL_EXPERT)
					bonus_modifier = 1.6
				if(SKILL_LEVEL_MASTER)
					bonus_modifier = 1.8
				if(SKILL_LEVEL_LEGENDARY)
					bonus_modifier = 2
			if(foundrecipe.bonus_chance_outputs.len > 0)
				for(var/i in 1 to foundrecipe.bonus_chance_outputs.len)
					if((foundrecipe.bonus_chance_outputs[foundrecipe.bonus_chance_outputs[i]] * bonus_modifier) >= roll(1,100))
						var/obj/item/bonusduck = foundrecipe.bonus_chance_outputs[i]
						new bonusduck(get_turf(src))
			if(istype(to_grind,/obj/item/ore) || istype(to_grind,/obj/item/ingot))
				user.flash_fullscreen("whiteflash")
				var/datum/effect_system/spark_spread/S = new()
				var/turf/front = get_turf(src)
				S.set_up(1, 1, front)
				S.start()
			QDEL_NULL(to_grind)
			if(user.mind)
				user.mind.adjust_experience(/datum/skill/craft/alchemy, user.STAINT * user.mind.get_learning_boon(/datum/skill/craft/alchemy), FALSE)
		return

	if(to_grind)
		to_chat(user, "<span class='warning'>[src] is full!</span>")
		return
	if(!user.transferItemToLoc(I,src))
		to_chat(user, "<span class='warning'>[I] is stuck to my hand!</span>")
		return
	if(!to_grind && user.transferItemToLoc(I,src))
		to_chat(user, "<span class='info'>I add [I] to [src].</span>")
		to_grind = I
		return
	. = ..()

// Looks through all the alch grind recipes to find what it should create, returns the correct one.
/obj/item/reagent_containers/glass/mortar/proc/find_recipe()
	for(var/datum/alch_grind_recipe/grindRec in GLOB.alch_grind_recipes)
		if(grindRec.picky)
			if(to_grind.type == grindRec.valid_input)
				return grindRec
		else
			if(istype(to_grind,grindRec.valid_input))
				return grindRec
	return null
