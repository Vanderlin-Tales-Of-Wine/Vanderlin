
/mob/living/carbon/humanoid/Stun(amount, ignore_canstun = FALSE)
	amount = dna?.species?.spec_stun(src, amount)
	return ..()

/mob/living/carbon/humanoid/Knockdown(amount, ignore_canstun = FALSE)
	amount = dna?.species?.spec_stun(src, amount)
	return ..()

/mob/living/carbon/humanoid/Paralyze(amount, ignore_canstun = FALSE)
	amount = dna?.species?.spec_stun(src, amount)
	return ..()

/mob/living/carbon/humanoid/Immobilize(amount, ignore_canstun = FALSE)
	amount = dna?.species?.spec_stun(src, amount)
	return ..()

/mob/living/carbon/humanoid/Unconscious(amount, ignore_canstun = FALSE)
	amount = dna?.species?.spec_stun(src, amount)
	return ..()

/mob/living/carbon/humanoid/Sleeping(amount)
	return ..()

/mob/living/carbon/humanoid/cure_husk(list/sources)
	. = ..()
	if(.)
		update_body()

/mob/living/carbon/humanoid/become_husk(source)
	. = ..()
	if(.)
		update_body()

/mob/living/carbon/humanoid/set_drugginess(amount)
	..()
//	if(!amount)
//		remove_language(/datum/language/beachbum)

/mob/living/carbon/humanoid/adjust_drugginess(amount)
	..()
//	if(!dna.check_mutation(STONER))
//		if(druggy)
//			grant_language(/datum/language/beachbum)
//		else
//			remove_language(/datum/language/beachbum)
