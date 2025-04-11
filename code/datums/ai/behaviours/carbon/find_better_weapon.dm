/datum/ai_behavior/find_and_set/better_weapon

/datum/ai_behavior/find_and_set/better_weapon/search_tactic(datum/ai_controller/controller, locate_path, search_range)
	var/mob/living/carbon/living_pawn = controller.pawn
	var/obj/item/held_item = living_pawn.get_active_held_item()
	if(istype(held_item, /obj/item/weapon/shield))
		living_pawn.swap_hand()
		held_item = living_pawn.get_active_held_item()

	var/list/weapons = list()
	for(var/obj/item/weapon/local_candidate in oview(search_range, controller.pawn))
		if(!istype(local_candidate, controller.blackboard[BB_WEAPON_TYPE]))
			continue
		if(held_item)
			if(held_item.force >= local_candidate.force)
				continue
		weapons += local_candidate
	if(weapons.len)
		return pick(weapons)
