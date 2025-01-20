
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
	charge_max = 60 SECONDS
	
/obj/effect/proc_holder/spell/invoked/entangler/cast(list/targets, mob/living/user)
    . = ..()
    user.faction |= "plants"
    var/turf/T = get_turf(targets[1])
    user.visible_message("<font color='green'>[user] points at [T]!</font>")
    var/already_grown = locate(/obj/structure/flora/roguegrass/tangler/real) in (T.contents)
    var/area/area = get_area(T)
    if(!area.outdoors)
        to_chat(user, span_notice("The open air is more suited for Dendors miracles..."))
        return FALSE
    if(already_grown)
        to_chat(user, span_notice("There's no room for more vines..."))
        return FALSE
    sound = 'sound/magic/webspin.ogg'
    new /obj/structure/flora/roguegrass/tangler/real(T)
    return ..()

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
	charge_max = 30 MINUTES // cast once every 30 minutes, lasts for 3 minutes
	req_items = list(/obj/item/clothing/neck/roguetown/psycross/silver/dendor)
	invocation = "DENDOR; LEND ME YOUR POWER!!"
	invocation_type = "shout"
	cooldown_min = 25 MINUTES
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


