
/mob/living/simple_animal/grenchensnacker
	name = "grenchensnacker"
	desc = "Why is it smiling like that?"
	icon_state = "grenchen"
	icon_living = "grenchen"
	icon_dead = "grenchen_dead"
	gender = MALE
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak = list("GRA","AH!","HEEHEHE")
	speak_emote = list("squeeks")
	emote_hear = list("chops.")
	emote_see = list("dances.", "stares.")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	butcher_results = list(/obj/item/key/porta = 1)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	attack_verb_continuous = "kicks"
	attack_verb_simple = "kick"
	attack_sound = 'sound/blank.ogg'
	health = 100
	maxHealth = 100
	gold_core_spawnable = FRIENDLY_SPAWN
	blood_volume = BLOOD_VOLUME_NORMAL
	food_type = list(/obj/item/ore/gold, /obj/item/ore/silver)
	tame_chance = 25
	bonus_tame_chance = 15
	footstep_type = FOOTSTEP_MOB_SHOE
