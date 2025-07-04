/datum/action/cooldown/spell/persistence
	name = "Persistence"
	desc = ""
	button_icon_state = "astrata"
	sound = 'sound/magic/timestop.ogg'

	spell_flags = SPELL_MIRACLE
	antimagic_flags = MAGIC_RESISTANCE_HOLY
	associated_skill = /datum/skill/magic/holy
	required_items = list(/obj/item/clothing/neck/psycross/silver/ravox)

	invocation = "Ravox guides my strike against the unjust!"
	invocation_type = INVOCATION_SHOUT

	charge_required = FALSE
	cooldown_time = 20 SECONDS
	spell_cost = 50

/datum/action/cooldown/spell/persistence/is_valid_target(atom/cast_on)
	return isliving(cast_on)

/datum/action/cooldown/spell/persistence/cast(mob/living/cast_on)
	. = ..()
	if(cast_on.mob_biotypes & MOB_UNDEAD)
		if(ishuman(cast_on)) //BLEED AND PAIN
			var/mob/living/carbon/human/human_target = cast_on
			var/datum/physiology/phy = human_target.physiology
			phy.bleed_mod *= 1.5
			phy.pain_mod *= 1.5
			addtimer(VARSET_CALLBACK(phy, bleed_mod, phy.bleed_mod /= 1.5), 19 SECONDS)
			addtimer(VARSET_CALLBACK(phy, pain_mod, phy.pain_mod /= 1.5), 19 SECONDS)
			human_target.visible_message(span_danger("[cast_on]'s wounds become inflammed as their vitality is sapped away!"), span_userdanger("Ravox inflammes my wounds and weakens my body!"))
		return

	cast_on.visible_message(span_info("Warmth radiates from [cast_on] as their wounds seal over!"), span_notice("The pain from my wounds fade as warmth radiates from my soul!"))
	var/situational_bonus = 0.25
	for(var/obj/effect/decal/cleanable/blood/O in view(5, cast_on))
		situational_bonus = min(situational_bonus + 0.015, 1)
	if(situational_bonus > 0.25)
		to_chat(owner, "Channeling Ravox's power is easier in these conditions!")

	if(iscarbon(cast_on))
		var/mob/living/carbon/C = cast_on
		var/obj/item/bodypart/affecting = C.get_bodypart(check_zone(owner.zone_selected))
		if(affecting)
			for(var/datum/wound/bleeder in affecting.wounds)
				bleeder.woundpain = max(bleeder.sewn_woundpain, bleeder.woundpain * 0.25)
				if(!isnull(bleeder.clotting_threshold) && bleeder.bleed_rate > bleeder.clotting_threshold)
					var/difference = bleeder.bleed_rate - bleeder.clotting_threshold
					bleeder.bleed_rate = max(bleeder.clotting_threshold, bleeder.bleed_rate - difference * situational_bonus)
	else if(HAS_TRAIT(cast_on, TRAIT_SIMPLE_WOUNDS))
		for(var/datum/wound/bleeder in cast_on.simple_wounds)
			bleeder.woundpain = max(bleeder.sewn_woundpain, bleeder.woundpain * 0.25)
			if(!isnull(bleeder.clotting_threshold) && bleeder.bleed_rate > bleeder.clotting_threshold)
				var/difference = bleeder.bleed_rate - bleeder.clotting_threshold
				bleeder.bleed_rate = max(bleeder.clotting_threshold, bleeder.bleed_rate - difference * situational_bonus)
