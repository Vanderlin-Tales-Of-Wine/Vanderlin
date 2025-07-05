/datum/action/cooldown/spell/attach_bodypart
	name = "Bodypart Miracle"
	desc = "Reattach a held limb instantly."
	button_icon_state = "limb_attach"
	sound = 'sound/gore/flesh_eat_03.ogg'
	sound_loop = /datum/looping_sound/invokeholy

	cast_range = 1
	spell_flags = SPELL_MIRACLE
	antimagic_flags = MAGIC_RESISTANCE_HOLY
	associated_skill = /datum/skill/magic/holy
	required_items = list(/obj/item/clothing/neck/psycross/silver)

	charge_required = FALSE
	cooldown_time = 1 MINUTES
	spell_cost = 60

/datum/action/cooldown/spell/attach_bodypart/is_valid_target(atom/cast_on)
	return ishuman(cast_on)

/datum/action/cooldown/spell/attach_bodypart/cast(mob/living/carbon/human/cast_on)
	. = ..()
	for(var/obj/item/bodypart/limb as anything in get_limbs(cast_on, owner))
		if(!limb?.attach_limb(cast_on))
			continue
		cast_on.visible_message(
			span_info("\The [limb] attaches itself to [cast_on]!"),
			span_notice("\The [limb] attaches itself to me!")
		)
	for(var/obj/item/organ/organ as anything in get_organs(cast_on, owner))
		if(!organ?.Insert(cast_on))
			continue
		cast_on.visible_message(
			span_info("\The [organ] attaches itself to [cast_on]!"),
			span_notice("\The [organ] attaches itself to me!")
		)
	owner.update_inv_hands()
	cast_on.update_body()

/datum/action/cooldown/spell/attach_bodypart/proc/get_organs(mob/living/target, mob/living/user)
	var/list/missing_organs = list(
		ORGAN_SLOT_EARS,
		ORGAN_SLOT_EYES,
		ORGAN_SLOT_TONGUE,
		ORGAN_SLOT_HEART,
		ORGAN_SLOT_LUNGS,
		ORGAN_SLOT_LIVER,
		ORGAN_SLOT_STOMACH,
		ORGAN_SLOT_APPENDIX,
	)
	for(var/missing_organ_slot in missing_organs)
		if(!target.getorganslot(missing_organ_slot))
			continue
		missing_organs -= missing_organ_slot
	if(!length(missing_organs))
		return
	var/list/organs = list()
	//try to get from user's hands first
	for(var/obj/item/organ/potential_organ in user?.held_items)
		if(potential_organ.owner || !(potential_organ.slot in missing_organs))
			continue
		organs += potential_organ
	//then target's hands
	for(var/obj/item/organ/dismembered in target.held_items)
		if(dismembered.owner || !(dismembered.slot in missing_organs))
			continue
		organs += dismembered
	//then finally, 1 tile range around target
	for(var/obj/item/organ/dismembered in range(1, target))
		if(dismembered.owner || !(dismembered.slot in missing_organs))
			continue
		organs += dismembered
	return organs

/datum/action/cooldown/spell/attach_bodypart/proc/get_limbs(mob/living/target, mob/living/user)
	var/list/missing_limbs = target.get_missing_limbs()
	if(!length(missing_limbs))
		return
	var/list/limbs = list()
	//try to get from user's hands first
	for(var/obj/item/bodypart/potential_limb in user?.held_items)
		if(potential_limb.owner || !(potential_limb.body_zone in missing_limbs))
			continue
		limbs += potential_limb
	//then target's hands
	for(var/obj/item/bodypart/dismembered in target.held_items)
		if(dismembered.owner || !(dismembered.body_zone in missing_limbs))
			continue
		limbs += dismembered
	//then finally, 1 tile range around target
	for(var/obj/item/bodypart/dismembered in range(1, target))
		if(dismembered.owner || !(dismembered.body_zone in missing_limbs))
			continue
		limbs += dismembered
	return limbs

