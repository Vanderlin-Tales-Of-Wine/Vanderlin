/obj/effect/proc_holder/spell/self/craft_buff
	name = "Exquisite Craftsdwarfship"
	desc = "Grants you and all nearby a buff to their intelligence."
	overlay_state = "craft_buff"
	charge_max = 5 MINUTES
	req_items = list(/obj/item/clothing/neck/roguetown/psycross/silver/malum)
	invocation = "Legere Librum!"
	invocation_type = "shout"
	releasedrain = 30
	miracle = TRUE
	devotion_cost = 50

/obj/effect/proc_holder/spell/self/craft_buff/cast(list/targets,mob/living/user = usr)
	for(var/mob/living/carbon/target in view(3, get_turf(user)))
		target.apply_status_effect(/datum/status_effect/buff/craft_buff)
	return ..()
