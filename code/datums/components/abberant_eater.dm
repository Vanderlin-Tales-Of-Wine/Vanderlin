/datum/component/abberant_eater
	var/list/extra_foods = list()


/datum/component/abberant_eater/Initialize(list/food_list)
	if(!length(food_list))
		return COMPONENT_INCOMPATIBLE

	extra_foods = food_list

	RegisterSignal(parent, COMSIG_MOB_ITEM_ATTACK, PROC_REF(try_eat))

/datum/component/abberant_eater/proc/try_eat(mob/living/user, mob/living/M, obj/item/source)
	if(user.cmode)
		return FALSE
	if(user != M)
		return FALSE

	if(!is_type_in_list(source, extra_foods))
		return FALSE

	var/eatverb = pick("bite","chew","nibble","gnaw","gobble","chomp")
	M.nutrition += 10

	switch(M.nutrition)
		if(NUTRITION_LEVEL_FAT to INFINITY)
			user.visible_message("<span class='notice'>[user] forces [M.p_them()]self to eat \the [source].</span>", "<span class='notice'>I force myself to eat \the [source].</span>")
		if(NUTRITION_LEVEL_STARVING to NUTRITION_LEVEL_FAT)
			user.visible_message("<span class='notice'>[user] [eatverb]s \the [source].</span>", "<span class='notice'>I [eatverb] \the [source].</span>")
		if(0 to NUTRITION_LEVEL_STARVING)
			user.visible_message("<span class='notice'>[user] hungrily [eatverb]s \the [source], gobbling it down!</span>", "<span class='notice'>I hungrily [eatverb] \the [source], gobbling it down!</span>")
			M.changeNext_move(CLICK_CD_MELEE * 0.5)

	playsound(M.loc,'sound/misc/eat.ogg', rand(30,60), TRUE)
	SEND_SIGNAL(source, COMSIG_FOOD_EATEN, M, user)
	source.on_consume(user)
	qdel(source)
	return TRUE
