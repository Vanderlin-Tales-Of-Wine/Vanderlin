/obj/item/pestle
	name = "pestle"
	desc = ""
	icon = 'icons/roguetown/misc/alchemy.dmi'
	icon_state = "pestle"
	force = 7
	dropshrink = 0.9

/obj/item/mortar
	name = "alchemical mortar"
	desc = "An industrial mortar used to grind alchemical ingredients."
	icon = 'icons/roguetown/misc/alchemy.dmi'
	icon_state = "mortar"
	dropshrink = 0.9
	color = COLOR_LIME
	var/obj/item/to_grind

/obj/item/mortar/attack_right(mob/user)
	user.changeNext_move(CLICK_CD_MELEE)
	if(to_grind)
		var/obj/item/N = to_grind
		N.forceMove(get_turf(user))
		to_chat(user, "<span class='notice'>I remove [to_grind] from the mortar.</span>")
		to_grind = null
		return
	to_chat(user, "<span class='notice'>It's empty.</span>")

/obj/item/mortar/attackby(obj/item/I, mob/living/carbon/human/user)
	if(istype(I,/obj/item/pestle))
		if(!to_grind)
			if(user.try_recipes(src, I, user))
				user.changeNext_move(CLICK_CD_FAST)
				return TRUE
			to_chat(user, "<span class='warning'>There's nothing to grind.</span>")
			return
		var/datum/alch_grind_recipe/foundrecipe = find_recipe()
		if(foundrecipe == null)
			to_chat(user, "<span class='warning'>You dont think that will work!</span>")
			return
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
			if(istype(to_grind,/obj/item/rogueore) || istype(to_grind,/obj/item/ingot))
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

///Looks through all the alch grind recipes to find what it should create, returns the correct one.
/obj/item/mortar/proc/find_recipe()
	for(var/datum/alch_grind_recipe/grindRec in GLOB.alch_grind_recipes)
		if(grindRec.picky)
			if(to_grind.type == grindRec.valid_input)
				return grindRec
		else
			if(istype(to_grind,grindRec.valid_input))
				return grindRec
	return null
