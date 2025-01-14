/obj/effect/proc_holder/spell/self/call_to_arms
	name = "Call to Arms"
	desc = "Grants you and all allies nearby a buff to their strength, endurance, and constitution."
	overlay_state = "call_to_arms"
	charge_max = 10 MINUTES
	req_items = list(/obj/item/clothing/neck/roguetown/psycross/silver/ravox)
	invocation = "MAY THE FIGHT BE BLOODY!"
	invocation_type = "shout"
	releasedrain = 30
	miracle = TRUE
	devotion_cost = 40

/obj/effect/proc_holder/spell/self/call_to_arms/cast(list/targets,mob/living/user = usr)
	for(var/mob/living/carbon/target in view(3, get_turf(user)))
		if(!user.faction_check_mob(target))
			continue
		if(target.mob_biotypes & MOB_UNDEAD)
			continue
		target.apply_status_effect(/datum/status_effect/buff/call_to_arms)
	return ..()
