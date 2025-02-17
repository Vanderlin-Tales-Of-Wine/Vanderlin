
/*-----------------\
|  Dendor Miracles |
\-----------------*/

//===========================================================================================

// ---------------------- BLESS CROPS ----------------------------

/obj/effect/proc_holder/spell/targeted/blesscrop
	name = "Bless Crops"
	range = 5
	overlay_state = "blesscrop"
	releasedrain = 30
	charge_max = 30 SECONDS
	req_items = list(/obj/item/clothing/neck/roguetown/psycross/silver/dendor)
	max_targets = 0
	cast_without_targets = TRUE
	sound = 'sound/magic/churn.ogg'
	associated_skill = /datum/skill/magic/holy
	invocation = "The Treefather commands thee, be fruitful!"
	invocation_type = "shout" //can be none, whisper, emote and shout
	miracle = TRUE
	devotion_cost = 15

/obj/effect/proc_holder/spell/targeted/blesscrop/cast(list/targets,mob/user = usr)
	. = ..()
	var/growed = FALSE
	var/amount_blessed = 0
	for(var/obj/structure/soil/soil in view(4))
		playsound(get_turf(user), 'sound/vo/smokedrag.ogg', 100, TRUE)
		soil.bless_soil()
		growed = TRUE
		amount_blessed++
		// Blessed only up to 5 crops
		if(amount_blessed >= 5)
			break
	if(growed)
		visible_message("<FONT COLOR='green'>[usr] blesses the crop with Dendor's Favour!</FONT><BR>")
		return ..()
	return FALSE
//===========================================================================================

// ---------------------- BESTIAL SENSES ----------------------------

/obj/effect/proc_holder/spell/self/beastsense
	name = "Beastial Senses"
	desc = "Grants the Dendorite a keen sense of smell and excellent vision, to better hunt with."
	overlay_state = "bestialsense"
	charge_max = 12 MINUTES
	req_items = list(/obj/item/clothing/neck/roguetown/psycross/silver/dendor)
	invocation = "Beast-Lord, lend me the eyes of the zad, the nose of the volf."
	invocation_type = "whisper"
	cooldown_min = 10 MINUTES
	releasedrain = 30
	miracle = TRUE
	devotion_cost = 15

/obj/effect/proc_holder/spell/self/beastsense/cast(list/targets,mob/living/user = usr)
	playsound(get_turf(user), 'sound/vo/smokedrag.ogg', 100, TRUE)
	sleep(pick(50,70,90))
	to_chat(user, span_notice("A raven passes overhead....your prayer was heard"))
	playsound(get_turf(user), 'sound/vo/mobs/bird/CROW_01.ogg', 60, TRUE, -1)
	sleep(20)
	if((iself(user)))	// already got night vision so lets not fuck it up, instead get +1 PER
		user.apply_status_effect(/datum/status_effect/buff/beastsense_elf)
	else
		user.apply_status_effect(/datum/status_effect/buff/beastsense)
	return ..()


//===========================================================================================

// ---------------------- TAME BEAST ----------------------------

//At some point, this spell should Awaken beasts, allowing a ghost to possess them. Not for this PR though.
/obj/effect/proc_holder/spell/targeted/beasttame
	name = "Tame Beast"
	range = 5
	overlay_state = "tamebeast"
	releasedrain = 30
	charge_max = 6 MINUTES
	req_items = list(/obj/item/clothing/neck/roguetown/psycross/silver/dendor)
	max_targets = 0
	cast_without_targets = TRUE
	sound = 'sound/magic/churn.ogg'
	associated_skill = /datum/skill/magic/holy
	invocation = "Be still and calm, brotherbeast."
	invocation_type = "whisper" //can be none, whisper, emote and shout
	miracle = TRUE
	devotion_cost = 60

/obj/effect/proc_holder/spell/targeted/beasttame/cast(list/targets,mob/user = usr)
	playsound(get_turf(user), 'sound/vo/smokedrag.ogg', 100, TRUE)
	visible_message("<FONT COLOR='green'>[usr] soothes the beastblood with Dendor's whisper.</FONT><BR>")
	for(var/mob/living/simple_animal/hostile/retaliate/B in oview(2))
		if((B.mob_biotypes & MOB_UNDEAD))
			continue
		B.aggressive = 0
		B.ai_controller?.CancelActions()
		B.tamed(user)
	return ..()


//===========================================================================================
// ---------------------- ENTANGLE ----------------------------

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
	charge_max = 50 SECONDS
	devotion_cost = 15

/obj/effect/proc_holder/spell/invoked/entangler/cast(list/targets, mob/living/user)
	. = ..()
	if (targets[1] == user) // adds the green thumb item when you target yourself
		var/obj/item/melee/touch_attack/greenthumb/I = new /obj/item/melee/touch_attack/greenthumb
		user.put_in_hands(I)
		to_chat(user, "You feel the power of Dendor course through your thumb.")
		user.visible_message("<font color='green'>[user]'s thumb turns green.</font>")
		return TRUE
	user.faction |= "plants"

	var/turf/T = get_turf(targets[1])
	user.visible_message("<font color='green'>[user] points at [T]!</font>")
	var/obj/structure/flora/roguegrass/tangler/real/already_grown = locate(/obj/structure/flora/roguegrass/tangler/real) in (T.contents)
	var/area/area = get_area(T)
	if (!area.outdoors)
		to_chat(user, span_notice("The open air is more suited for Dendor's miracles..."))
		return FALSE
	if (already_grown)
		to_chat(user, span_notice("There's no room for more vines..."))
		return FALSE
	sound = 'sound/magic/webspin.ogg'
	new /obj/structure/flora/roguegrass/tangler/real(T)
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
	mob_target.faction |= "plants"
	playsound(user, 'sound/magic/ahh2.ogg', 55, TRUE)
	user.visible_message("[user] marks [mob_target] forehead.")
	to_chat(target, "<font color='green'> The vines has marked you as one of its own.")

/datum/proc/remove_vinemark(atom/target, mob/living/carbon/user)
	var/mob/living/mob_target = target
	mob_target.faction -= "plants"
	playsound(user, 'sound/magic/swap.ogg', 55, TRUE)
	user.visible_message("[user] removes the mark from [mob_target] forehead.")
	to_chat(target, "<font color='red'> The vines have forsaken you.")

// ---------------------- FUNGAL ILLUMINATION ----------------------------

/obj/effect/proc_holder/spell/targeted/conjure_kneestingers
	name = "Fungal Illumination"
	range = 1
	overlay_state = "kneestinger"
	releasedrain = 30
	charge_max = 30 SECONDS
	max_targets = 0
	cast_without_targets = TRUE
	sound = 'sound/items/dig_shovel.ogg'
	associated_skill = /datum/skill/magic/holy
	req_items = list(/obj/item/clothing/neck/roguetown/psycross/silver/dendor)
	invocation = "Treefather light the way."
	invocation_type = "whisper" //can be none, whisper, emote and shout

/obj/effect/proc_holder/spell/targeted/conjure_kneestingers/cast(list/targets,mob/user = usr)
	playsound(get_turf(user), 'sound/vo/smokedrag.ogg', 100, TRUE)
	var/turf/T = user.loc
	var/already_grown = locate(/obj/structure/kneestingers) in (T)
	var/area/area = get_area(T)
	if(!area.outdoors)
		to_chat(user, span_notice("The open air is more suited for Dendors miracles..."))
		return FALSE
	if(already_grown)
		to_chat(user, span_notice("There are too many mycelia here already..."))
		return FALSE
	playsound(get_turf(user), 'sound/foley/gross.ogg', 90, TRUE)
	new /obj/structure/kneestingers/decaying(T)
	return ..()


//===========================================================================================

// ---------------------- TROLL SHAPE ----------------------------

/obj/effect/proc_holder/spell/self/trollshape
	name = "Troll Shape"
	desc = "Borrow power from the Troll, his favored beast."
	overlay_state = "trollshape"
	charge_max = 12 MINUTES // cast once every 30 minutes, lasts for 3 minutes || Monkey station edit, changed it down from 30 to 12!
	req_items = list(/obj/item/clothing/neck/roguetown/psycross/silver/dendor)
	invocation = "DENDOR; LEND ME YOUR POWER!!"
	invocation_type = "shout"
	cooldown_min = 6 MINUTES
	releasedrain = 100
	miracle = TRUE
	devotion_cost = 100

/obj/effect/proc_holder/spell/self/trollshape/cast(list/targets,mob/living/user = usr)
	. = ..()
	user.emote("rage", forced = TRUE)
	playsound(get_turf(user), 'sound/vo/smokedrag.ogg', 100, TRUE)
	user.Immobilize(30)
	sleep(30)
	playsound(get_turf(user), 'sound/foley/sewflesh.ogg', 100, TRUE)
	user.emote("pain", forced = TRUE)
	to_chat(user, span_warning("My body is transforming, growing! Unbearable pain, Dendor has answered your prayers!"))
	user.do_jitter_animation(40)
	user.Immobilize(40)
	sleep(40)
	playsound(get_turf(user), 'sound/gore/flesh_eat_03.ogg', 100, TRUE)
	user.emote("pain", forced = TRUE)
	user.Immobilize(20)
	user.do_jitter_animation(20)
	sleep(20)
	playsound(get_turf(user), 'sound/vo/mobs/troll/idle1.ogg', 100, TRUE)
	playsound(get_turf(user), 'sound/gore/flesh_eat_03.ogg', 140, TRUE)
	user.apply_status_effect(/datum/status_effect/buff/trollshape)
	to_chat(user, span_warning("For a time, I manifest the power of a troll!"))


