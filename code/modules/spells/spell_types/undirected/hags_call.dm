/datum/action/cooldown/spell/undirected/hag_call
	name = "Hag's Call"
	desc = "Callout for my children, or my old friends."
	button_icon_state = "message"

	charge_required = FALSE
	cooldown_time = 3 MINUTES

	var/brat_name

/datum/action/cooldown/spell/undirected/hag_call/before_cast(atom/cast_on)
	. = ..()
	if(. & SPELL_CANCEL_CAST)
		return
	brat_name = browser_input_text(owner, "Which one of those brats am I trying to call?", "Hag's Call")
	if(QDELETED(src) || QDELETED(cast_on) || !can_cast_spell())
		return . | SPELL_CANCEL_CAST
	if(!brat_name)
		reset_cooldown()
		return . | SPELL_CANCEL_CAST

	return TRUE

/datum/action/cooldown/spell/undirected/hag_call/cast(atom/cast_on)
	. = ..()
	owner.say("[brat_name]!!", spans = list("reallybig"))
	for(var/mob/living/carbon/human/HL in GLOB.human_list)
		if(!HL.mind)
			continue
		if(HL.real_name == brat_name)
			if(HAS_TRAIT(HL, TRAIT_ORPHAN) || HAS_TRAIT(HL, TRAIT_OLDPARTY))
				to_chat(HL, span_reallybig("[brat_name]!"))
				if(HAS_TRAIT(HL, TRAIT_ORPHAN))
					HL.add_stress(/datum/stressevent/mother_calling)
				else
					HL.add_stress(/datum/stressevent/friend_calling)
