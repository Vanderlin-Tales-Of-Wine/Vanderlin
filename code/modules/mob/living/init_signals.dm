///Called on /mob/living/Initialize(), for the mob to register to relevant signals.
/mob/living/proc/register_init_signals()
	RegisterSignal(src, SIGNAL_ADDTRAIT(TRAIT_KNOCKEDOUT), PROC_REF(on_knockedout_trait_gain))
	RegisterSignal(src, SIGNAL_REMOVETRAIT(TRAIT_KNOCKEDOUT), PROC_REF(on_knockedout_trait_loss))

	RegisterSignal(src, SIGNAL_ADDTRAIT(TRAIT_DEATHCOMA), PROC_REF(on_deathcoma_trait_gain))
	RegisterSignal(src, SIGNAL_REMOVETRAIT(TRAIT_DEATHCOMA), PROC_REF(on_deathcoma_trait_loss))

	/* ROGUE */
	RegisterSignal(src, SIGNAL_ADDTRAIT(TRAIT_LEPROSY), PROC_REF(on_leprosy_trait_gain))
	RegisterSignal(src, SIGNAL_REMOVETRAIT(TRAIT_LEPROSY), PROC_REF(on_leprosy_trait_loss))

///Called when TRAIT_KNOCKEDOUT is added to the mob.
/mob/living/proc/on_knockedout_trait_gain(datum/source)
	if(stat < UNCONSCIOUS)
		set_stat(UNCONSCIOUS)

///Called when TRAIT_KNOCKEDOUT is removed from the mob.
/mob/living/proc/on_knockedout_trait_loss(datum/source)
	if(stat < DEAD)
		update_stat()

///Called when TRAIT_DEATHCOMA is added to the mob.
/mob/living/proc/on_deathcoma_trait_gain(datum/source)
	ADD_TRAIT(src, TRAIT_KNOCKEDOUT, TRAIT_DEATHCOMA)

///Called when TRAIT_DEATHCOMA is removed from the mob.
/mob/living/proc/on_deathcoma_trait_loss(datum/source)
	REMOVE_TRAIT(src, TRAIT_KNOCKEDOUT, TRAIT_DEATHCOMA)

/* ROGUE */

///Called when TRAIT_LEPROSY is added to the mob.
/mob/living/proc/on_leprosy_trait_gain(datum/source)
	set_stat_modifier(TRAIT_LEPROSY, STATKEY_STR, -5)
	set_stat_modifier(TRAIT_LEPROSY, STATKEY_SPD, -5)
	set_stat_modifier(TRAIT_LEPROSY, STATKEY_END, -2)
	set_stat_modifier(TRAIT_LEPROSY, STATKEY_CON, -2)
	set_stat_modifier(TRAIT_LEPROSY, STATKEY_INT, -5)
	set_stat_modifier(TRAIT_LEPROSY, STATKEY_LCK, -5)

///Called when TRAIT_LEPROSY is removed from the mob.
/mob/living/proc/on_leprosy_trait_loss(datum/source)
	remove_stat_modifier(TRAIT_LEPROSY)
