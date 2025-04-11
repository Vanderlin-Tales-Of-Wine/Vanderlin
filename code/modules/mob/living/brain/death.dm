/mob/living/brain/death(gibbed)
	if(stat == DEAD)
		return
	set_stat(DEAD)

	return ..()

/mob/living/brain/gib()
	if(loc)
		if(istype(loc, /obj/item/organ/brain))
			qdel(loc)//Gets rid of the brain item
	..()
