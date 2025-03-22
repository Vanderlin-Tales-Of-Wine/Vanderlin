/datum/antagonist/vampire/lesser
	name = "Vampire Spawn"
	antag_hud_name = "Vspawn"
	confess_lines = list(
		"THE CRIMSON MASTER CALLS!",
		"MY MASTER COMMANDS",
		"THE SUN IS THE ANATHEMA OF OUR MASTER!",
	)
	isspawn = TRUE

/datum/antagonist/vampire/lesser/on_gain()
	. = ..()

	add_objective(/datum/objective/vlordserve)
	owner.current.verbs |= /mob/living/carbon/human/proc/disguise_button

	equip()
	if(!sired)
		addtimer(CALLBACK(owner.current, TYPE_PROC_REF(/mob/living/carbon/human, spawn_pick_class), "[type]"), 5 SECONDS)

/datum/antagonist/vampire/lesser/handle_vitae(change, tribute)
	vitae = clamp(vitae + change, 0, vmax)
	. = ..()

/mob/living/carbon/human/proc/spawn_pick_class()
//TODO: This should just be an advclass spawn
	var/list/classoptions = list("Bard", "Fisher", "Hunter", "Miner", "Peasant", "Carpenter", "Cheesemaker", "Blacksmith", "Carpenter", "Thief", "Treasure Hunter", "Mage")
	var/list/visoptions = list()

	for(var/T in 1 to 5)
		var/picked = pick_n_take(classoptions)
		visoptions |= picked

	var/selected = input(src, "Which class was I?", "VAMPIRE SPAWN") as anything in visoptions

	for(var/datum/advclass/A in SSrole_class_handler.sorted_class_categories[CTAG_ALLCLASS])
		if(A.name == selected)
			equipOutfit(A.outfit)
			return

/datum/antagonist/vampire/lord/equip()
	. = ..()

	owner.adjust_skillrank(/datum/skill/magic/blood, 2, TRUE)
	owner.current.ambushable = FALSE

/datum/antagonist/vampire/lesser/greet()
	to_chat(owner.current, span_userdanger("We are awakened from our slumber, Spawn of the feared Vampire Lord."))
	. = ..()

/datum/antagonist/vampire/lesser/vamp_look()
	. = ..()

/datum/antagonist/vampire/lesser/move_to_spawnpoint()
	owner.current.forceMove(pick(GLOB.vspawn_starts))
