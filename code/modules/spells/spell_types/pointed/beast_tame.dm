/datum/action/cooldown/spell/beast_tame
	name = "Tame Beast"
	desc = "Attempt to turn a beast of Dendor to your favor."
	button_icon_state = "tamebeast"
	sound = 'sound/vo/smokedrag.ogg'
	sound_loop = /datum/looping_sound/invokeholy

	cast_range = 4
	spell_flags = SPELL_MIRACLE
	antimagic_flags = MAGIC_RESISTANCE_HOLY
	associated_skill = /datum/skill/magic/holy
	required_items = list(/obj/item/clothing/neck/psycross/silver/dendor)
	attunements = list(
		/datum/attunement/earth = 1,
	)

	invocation = "Be still and calm, brotherbeast."
	invocation_type = INVOCATION_WHISPER

	charge_time = 4 SECONDS
	charge_drain = 1
	charge_slowdown = 2
	cooldown_time = 6 MINUTES
	spell_cost = 60

	var/static/list/pet_commands = list(
		/datum/pet_command/idle,
		/datum/pet_command/free,
		/datum/pet_command/good_boy,
		/datum/pet_command/follow,
		/datum/pet_command/attack,
		/datum/pet_command/fetch,
		/datum/pet_command/play_dead,
		/datum/pet_command/protect_owner,
		/datum/pet_command/aggressive,
		/datum/pet_command/calm,
	)

/datum/action/cooldown/spell/beast_tame/is_valid_target(atom/cast_on)
	. = ..()
	if(. & SPELL_CANCEL_CAST)
		return
	if(!istype(cast_on, /mob/living/simple_animal/hostile/retaliate))
		reset_spell_cooldown()
		return . | SPELL_CANCEL_CAST
	var/mob/living/simple_animal/hostile/retaliate/SP = cast_on
	if(!SP.dendor_taming_chance || !SP.ai_controller || (SP.mob_biotypes & MOB_UNDEAD))
		reset_spell_cooldown()
		return . | SPELL_CANCEL_CAST

/datum/action/cooldown/spell/beast_tame/cast(/mob/living/simple_animal/hostile/retaliate/cast_on)
	. = ..()
	if(!prob(cast_on.dendor_taming_chance))
		to_chat(owner, span_warning("\The [cast_on] resists your soothing!"))
		return
	owner.visible_message(
		span_greentext("[owner] soothes \the [cast_on] with Dendor's whisper."),
		span_notice("I tame the beast with Dendor's whisper."),
	)
	cast_on.LoadComponent(/datum/component/obeys_commands, pet_commands)
	cast_on.ai_controller.can_idle = FALSE
	cast_on.ai_controller.add_to_top(/datum/ai_planning_subtree/pet_planning)
	cast_on.ai_controller.CancelActions()
	cast_on.ai_controller.set_blackboard_key(BB_PET_TARGETING_DATUM, new /datum/targetting_datum/basic/not_friends())
	cast_on.befriend(owner)
	cast_on.pet_passive = TRUE
