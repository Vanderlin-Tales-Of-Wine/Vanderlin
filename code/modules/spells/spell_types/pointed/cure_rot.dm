/datum/action/cooldown/spell/cure_rot
	name = "Cure Rot"
	desc = "Cleanse a body of rot, deadites will perish."
	button_icon_state = "cure_rot"
	sound = 'sound/magic/revive.ogg'
	sound_loop = /datum/looping_sound/invokeholy

	cast_range = 1
	spell_flags = SPELL_MIRACLE
	antimagic_flags = MAGIC_RESISTANCE_HOLY
	associated_skill = /datum/skill/magic/holy
	required_items = list(/obj/item/clothing/neck/psycross/silver)

	charge_time = 5 SECONDS
	charge_drain = 1
	charge_slowdown = 2
	cooldown_time = 2 MINUTES
	spell_cost = 100

	var/was_zombie = FALSE

/datum/action/cooldown/spell/cure_rot/is_valid_target(atom/cast_on)
	return ishuman(cast_on)

/datum/action/cooldown/spell/cure_rot/before_cast(mob/living/carbon/human/cast_on)
	. = ..()
	if(. & SPELL_CANCEL_CAST)
		return

	for(var/obj/structure/fluff/psycross/S in view(5, owner))
		if(S)
			break
		to_chat(owner, span_warning("I need a holy cross."))
		reset_spell_cooldown()
		return . | SPELL_CANCEL_CAST

	if(cast_on.get_lux_status() != LUX_HAS_LUX)
		to_chat(owner, span_warning("This filth cannot be revived by holy light!"))
		reset_spell_cooldown()
		return . | SPELL_CANCEL_CAST

	for(var/obj/item/bodypart/bodypart as anything in cast_on.bodyparts)
		if(bodypart.skeletonized)
			to_chat(owner, span_warning("They are too far gone."))
			reset_spell_cooldown()
			return . | SPELL_CANCEL_CAST

	if(cast_on.mind?.has_antag_datum(/datum/antagonist/zombie))
		was_zombie = TRUE

/datum/action/cooldown/spell/cure_rot/cast(mob/living/carbon/human/cast_on)
	. = ..()
	var/has_rot = FALSE
	if(!was_zombie)
		for(var/obj/item/bodypart/bodypart as anything in cast_on.bodyparts)
			if(bodypart.rotted)
				has_rot = TRUE
				break
	if(!has_rot)
		to_chat(owner, span_warning("Nothing happens."))
		return FALSE

	if(was_zombie)
		cast_on.mind.remove_antag_datum(/datum/antagonist/zombie)
		cast_on.death()

	var/datum/component/rot/rot = cast_on.GetComponent(/datum/component/rot)
	if(rot)
		rot.amount = 0

	for(var/obj/item/bodypart/rotty in cast_on.bodyparts)
		rotty.rotted = FALSE
		rotty.update_limb()
		if(rotty.can_be_disabled)
			rotty.update_disabled()

	cast_on.update_body()
	cast_on.visible_message("<span class='notice'>The rot leaves [cast_on]'s body!</span>", "<span class='green'>I feel the rot leave my body!</span>")

	if(cast_on.funeral)
		if(cast_on.ckey)
			to_chat(cast_on, span_warning("My funeral rites were undone!"))
		else
			var/mob/dead/observer/ghost = cast_on.get_ghost(TRUE, TRUE)
			if(ghost)
				to_chat(ghost, span_warning("My funeral rites were undone!"))

	cast_on.funeral = FALSE
