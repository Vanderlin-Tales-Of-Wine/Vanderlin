/obj/effect/proc_holder/spell/invoked/entangler
	name = "Entangle"
	overlay_state = "entangle"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 15
	warnie = "spellwarning"
	movement_interrupt = FALSE
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	sound = 'sound/items/dig_shovel.ogg'
	invocation = "By the Treefather's will, entwine and restrain."
	invocation_type = "whisper"
	recharge_time = 50 SECONDS
	devotion_cost = 15
	miracle = TRUE

/obj/effect/proc_holder/spell/invoked/entangler/cast(list/targets, mob/living/user)
	. = ..()
	if (targets[1] == user) // adds the green thumb item when you target yourself
		var/obj/item/melee/touch_attack/greenthumb/I = new /obj/item/melee/touch_attack/greenthumb
		user.put_in_hands(I)
		to_chat(user, "You feel the power of Dendor course through your thumb.")
		user.visible_message("<font color='green'>[user]'s thumb turns green.</font>")
		return TRUE
	user.faction |= FACTION_PLANTS

	var/turf/T = get_turf(targets[1])
	user.visible_message("<font color='green'>[user] points at [T]!</font>")
	var/obj/structure/flora/grass/tangler/real/already_grown = locate(/obj/structure/flora/grass/tangler/real) in (T.contents)
	var/area/area = get_area(T)
	if (!area.outdoors)
		to_chat(user, span_notice("The open air is more suited for Dendor's miracles..."))
		return FALSE
	if (already_grown)
		to_chat(user, span_notice("There's no room for more vines..."))
		return FALSE
	sound = 'sound/magic/webspin.ogg'
	new /obj/structure/flora/grass/tangler/real(T)
	return ..()

/obj/item/melee/touch_attack/greenthumb
	name = "green thumb"
	desc = "You recall the following invocations you've learned:\n \
		<b>Touch</b>: Mark a person's forehead, making your vines friendly with them.\n \
		<b>Shove</b>: Remove the mark from a person's forehead."
	possible_item_intents = list(INTENT_HELP, INTENT_DISARM)
	icon = 'icons/mob/roguehudgrabs.dmi'
	icon_state = "grabbing_greyscale"
	color = "#3ffd9b"

/obj/item/melee/touch_attack/greenthumb/attack_self()
	qdel(src)

/obj/item/melee/touch_attack/greenthumb/afterattack(atom/target, mob/living/carbon/user, proximity)
	if (!user)
		return
	if (get_dist(user, target) > 1)// must be within touching distance
	{
		to_chat(user, "<font color='red'>You must touch a person's forehead.")
		return
	}
	switch (user.used_intent.type)
		if (INTENT_HELP)
			handle_marking(target, user, TRUE)
		if (INTENT_DISARM)
			handle_marking(target, user, FALSE)

/datum/proc/handle_marking(atom/target, mob/living/carbon/user, apply)
	if (!istype(target, /mob/living/carbon/human/))
	{
		to_chat(user, "The spell fizzles without a valid target.")
		return
	}
	var/mob/living/mob_target = target
	if (istype(mob_target, /mob/living/carbon/human/species/skeleton) || istype(mob_target, /mob/living/carbon/human/species/goblin))// prevents taming of monsters
	{
		to_chat(user, "<font color='red'>[mob_target] is incompatible with the Treefather's mark.")
		return
	}
	var/action = apply ? "adding" : "removing"
	user.visible_message("[user] presses thumb on [mob_target]'s forehead and begins [action] Dendor's mark to [mob_target].")
	if(do_after(user, 5 SECONDS, mob_target))//5 second application
		if (apply)
			add_vinemark(mob_target, user)
		else
			remove_vinemark(mob_target, user)

/datum/proc/add_vinemark(atom/target, mob/living/carbon/user) // makes vines ignore them essentially
	var/mob/living/mob_target = target
	mob_target.faction |= FACTION_PLANTS
	playsound(user, 'sound/magic/ahh2.ogg', 55, TRUE)
	user.visible_message("[user] marks [mob_target] forehead.")
	to_chat(target, "<font color='green'> The vines has marked you as one of its own.")

/datum/proc/remove_vinemark(atom/target, mob/living/carbon/user)
	var/mob/living/mob_target = target
	mob_target.faction -= FACTION_PLANTS
	playsound(user, 'sound/magic/swap.ogg', 55, TRUE)
	user.visible_message("[user] removes the mark from [mob_target] forehead.")
	to_chat(target, "<font color='red'> The vines have forsaken you.")
