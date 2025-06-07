// ===============================
// GNOME HOMUNCULUS MOB
// ===============================

/mob/living/simple_animal/hostile/gnome_homunculus
	name = "gnome homunculus"
	desc = "A small, industrious magical construct that resembles a tiny gnome. Its eyes glow with arcane energy and it seems eager to help with menial tasks."
	icon = 'icons/mob/gnome2.dmi' // You'll need appropriate sprites
	icon_state = "gnome"
	icon_living = "gnome"
	icon_dead = "gnome_dead"

	pass_flags = PASSMOB

	maxHealth = 50
	health = 50
	harm_intent_damage = 8
	obj_damage = 10
	melee_damage_lower = 5
	melee_damage_upper = 8
	attack_verb_continuous = "punches"
	attack_verb_simple = "punch"
	density = FALSE

	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"

	speed = 1
	move_to_delay = 3

	faction = list("neutral", "silicon", "homunculus")

	gold_core_spawnable = FRIENDLY_SPAWN

	ai_controller = /datum/ai_controller/basic_controller/gnome_homunculus

	var/list/waypoints = list()
	var/max_carry_size = WEIGHT_CLASS_NORMAL
	var/list/item_filters = list()

	var/hat_state

	var/static/list/pet_commands = list(
		/datum/pet_command/follow,
		/datum/pet_command/idle,
		/datum/pet_command/fetch,
		/datum/pet_command/gnome/search_range,

		/datum/pet_command/gnome/set_waypoint,
		/datum/pet_command/gnome/set_waypoint/b,

		/datum/pet_command/gnome/set_filter,
		/datum/pet_command/gnome/clear_filter,

		/datum/pet_command/gnome/use_splitter,
		/datum/pet_command/gnome/stop_splitter,

		/datum/pet_command/gnome/move_item,
		/datum/pet_command/gnome/stop_move_item,

		/datum/pet_command/gnome/tend_crops,
		/datum/pet_command/gnome/stop_tending,

		/datum/pet_command/gnome/select_recipe,
		/datum/pet_command/gnome/start_alchemy,
		/datum/pet_command/gnome/stop_alchemy,
	)

/mob/living/simple_animal/hostile/gnome_homunculus/Initialize()
	. = ..()
	AddComponent(/datum/component/obeys_commands, pet_commands)

/mob/living/simple_animal/hostile/gnome_homunculus/update_icon()
	. = ..()
	cut_overlays()

	if(hat_state)
		overlays += mutable_appearance(icon, hat_state)

/mob/living/simple_animal/hostile/gnome_homunculus/proc/item_matches_filter(obj/item/target_item)
	if(!length(item_filters))
		return TRUE
	return (is_type_in_list(target_item, item_filters))

/mob/living/simple_animal/hostile/gnome_homunculus/proc/hat()
	hat_state = pick("spike_helm", "fungi_helm", "fungi_helm_bog", "gnome_helm", null)
	update_icon()
