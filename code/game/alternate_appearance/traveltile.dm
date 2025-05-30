/datum/atom_hud/alternate_appearance/basic/traveltile/mobShouldSee(mob/M)
	if(HAS_TRAIT(M, appearance_key))
		return TRUE
	. = ..()
