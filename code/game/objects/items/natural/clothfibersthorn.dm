/obj/item/natural/fibers
	name = "fiber"
	desc = "Plant fiber. The peasants make their living sewing these into fabrics and clothing."
	icon_state = "fibers"
	possible_item_intents = list(/datum/intent/use)
	force = 0
	throwforce = 0
	color = "#454032"
	firefuel = 5 MINUTES
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_MOUTH
	max_integrity = 20
	muteinmouth = TRUE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE
	bundletype = /obj/item/natural/bundle/fibers

/obj/item/natural/silk
	name = "silk"
	icon_state = "fibers"
	possible_item_intents = list(/datum/intent/use)
	desc = "Silken strands. Their usage in clothing is exotic in all places save the Underdark."
	force = 0
	throwforce = 0
	color = "#e6e3db"
	firefuel = 5 MINUTES
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_MOUTH
	max_integrity = 20
	muteinmouth = TRUE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE
	bundletype = /obj/item/natural/bundle/silk

#ifdef TESTSERVER

/client/verb/bloodnda()
	set category = "DEBUGTEST"
	set name = "bloodnda"
	set desc = ""

	var/obj/item/I
	I = mob.get_active_held_item()
	if(I)
		if(I.return_blood_DNA())
			testing("yep")
		else
			testing("nope")

#endif

/obj/item/natural/cloth
	name = "cloth"
	desc = "A square of cloth mended from fibers."
	icon_state = "cloth"
	possible_item_intents = list(/datum/intent/use)
	force = 0
	throwforce = 0
	firefuel = 5 MINUTES
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_MOUTH|ITEM_SLOT_HIP|ITEM_SLOT_MASK
	body_parts_covered = null
	experimental_onhip = TRUE
	max_integrity = 20
	muteinmouth = TRUE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE
	bundletype = /obj/item/natural/bundle/cloth
	var/wet = 0
	/// Effectiveness when used as a bandage, how much bloodloss we can tampon
	var/bandage_effectiveness = 0.9
	obj_flags = CAN_BE_HIT //enables splashing on by containers

/obj/item/natural/cloth/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot == SLOT_WEAR_MASK)
		user.become_blind("blindfold_[REF(src)]")

/obj/item/natural/cloth/dropped(mob/living/carbon/human/user)
	..()
	user.cure_blind("blindfold_[REF(src)]")

/obj/item/natural/cloth/examine(mob/user)
	. = ..()
	if(wet)
		. += span_notice("It's wet!")

/obj/item/natural/cloth/bandit
	color = "#ff0000"

// CLEANING

/obj/item/natural/cloth/attack_obj(obj/O, mob/living/user)
	testing("attackobj")
	if(user.client && ((O in user.client.screen) && !user.is_holding(O)))
		to_chat(user, span_warning("I need to take that [O.name] off before cleaning it!"))
		return
	if(istype(O, /obj/effect/decal/cleanable))
		var/cleanme = TRUE
		if(istype(O, /obj/effect/decal/cleanable/blood))
			if(!wet)
				to_chat(user, span_warning("[src] is too dry to clean [O]!"))
				cleanme = FALSE
			add_blood_DNA(O.return_blood_DNA())
		if(prob(40 + (wet*10)) && cleanme)
			wet = max(wet-0.50, 0)
			user.visible_message(span_info("[user] wipes \the [O.name] with [src]."), span_info("I wipe \the [O.name] with [src]."))
			qdel(O)
		playsound(user, "clothwipe", 100, TRUE)
	else
		if(prob(40 + (wet*10)))
			user.visible_message(span_info("[user] wipes \the [O.name] with [src]."), span_info("I wipe \the [O.name] with [src]."))

			if(O.return_blood_DNA())
				add_blood_DNA(O.return_blood_DNA())
			for(var/obj/effect/decal/cleanable/C in O)
				qdel(C)
			if(!wet)
				SEND_SIGNAL(O, COMSIG_COMPONENT_CLEAN_ACT, CLEAN_WEAK)
			else
				SEND_SIGNAL(O, COMSIG_COMPONENT_CLEAN_ACT, CLEAN_STRONG)
			wet = max(wet-0.50, 0)
		playsound(user, "clothwipe", 100, TRUE)

/obj/item/natural/cloth/attack_turf(turf/T, mob/living/user)
	if(istype(T, /turf/open/water))
		return ..()
	if(prob(40 + (wet*10)))
		if(wet)
			user.visible_message(span_info("[user] wipes \the [T.name] with [src]."), span_info("I wipe \the [T.name] with [src]."))
			for(var/obj/effect/decal/cleanable/C in T)
				qdel(C)
			wet = max(wet-0.50, 0)
	playsound(user, "clothwipe", 100, TRUE)


// BANDAGING
/obj/item/natural/cloth/attack(mob/living/M, mob/user)
	testing("attack")
	bandage(M, user)

/obj/item/natural/cloth/wash_act()
	. = ..()
	wet = 6

/obj/item/natural/cloth/proc/bandage(mob/living/M, mob/user)
	if(!M.can_inject(user, TRUE))
		return
	if(!ishuman(M))
		return
	var/mob/living/carbon/human/H = M
	var/obj/item/bodypart/affecting = H.get_bodypart(check_zone(user.zone_selected))
	if(!affecting)
		return
	if(affecting.bandage)
		to_chat(user, "<span class='warning'>There is already a bandage.</span>")
		return
	var/used_time = 70
	if(H.mind)
		used_time -= (H.mind.get_skill_level(/datum/skill/misc/medicine) * 10)
	playsound(loc, 'sound/foley/bandage.ogg', 100, FALSE)
	if(!do_after(user, used_time, M))
		return
	playsound(loc, 'sound/foley/bandage.ogg', 100, FALSE)

	user.dropItemToGround(src)
	affecting.try_bandage(src)
	H.update_damage_overlays()

	if(M == user)
		user.visible_message("<span class='notice'>[user] bandages [user.p_their()] [affecting].</span>", "<span class='notice'>I bandage my [affecting].</span>")
	else
		user.visible_message("<span class='notice'>[user] bandages [M]'s [affecting].</span>", "<span class='notice'>I bandage [M]'s [affecting].</span>")

/obj/item/natural/thorn
	name = "thorn"
	desc = "This bog-grown thorn is sharp and resistant like a needle."
	icon_state = "thorn"
	force = 10
	throwforce = 0
	possible_item_intents = list(/datum/intent/stab)
	firefuel = 5 MINUTES
	embedding = list("embedded_unsafe_removal_time" = 20, "embedded_pain_chance" = 10, "embedded_pain_multiplier" = 1, "embed_chance" = 35, "embedded_fall_chance" = 0)
	resistance_flags = FLAMMABLE
	max_integrity = 20
/obj/item/natural/thorn/attack_self(mob/living/user)
	user.visible_message("<span class='warning'>[user] snaps [src].</span>")
	playsound(user,'sound/items/seedextract.ogg', 100, FALSE)
	qdel(src)

/obj/item/natural/thorn/Crossed(mob/living/L)
	. = ..()
	if(istype(L))
		var/prob2break = 33
		if(L.m_intent == MOVE_INTENT_SNEAK)
			prob2break = 0
		if(L.m_intent == MOVE_INTENT_RUN)
			prob2break = 100
		if(prob(prob2break))
			playsound(src,'sound/items/seedextract.ogg', 100, FALSE)
			qdel(src)
			if (L.alpha == 0 && L.rogue_sneaking) // not anymore you're not
				L.update_sneak_invis(TRUE)
			L.consider_ambush()

/obj/item/natural/bundle/fibers
	name = "fiber bundle"
	desc = "Fibers, bundled together."
	icon_state = "fibersroll1"
	possible_item_intents = list(/datum/intent/use)
	force = 0
	throwforce = 0
	maxamount = 6
	color = "#454032"
	firefuel = 5 MINUTES
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_MOUTH
	max_integrity = 20
	muteinmouth = TRUE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE
	stacktype = /obj/item/natural/fibers
	icon1step = 3
	icon2step = 6

/obj/item/natural/bundle/fibers/full
	icon_state = "fibersroll2"
	amount = 6
	firefuel = 30 MINUTES

/obj/item/natural/bundle/silk
	name = "silken weave"
	icon_state = "fibersroll1"
	possible_item_intents = list(/datum/intent/use)
	desc = "Silk neatly woven together."
	force = 0
	throwforce = 0
	maxamount = 6
	color = "#e6e3db"
	firefuel = 5 MINUTES
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_MOUTH
	max_integrity = 20
	muteinmouth = TRUE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE
	stacktype = /obj/item/natural/silk
	icon1step = 3
	icon2step = 6

/obj/item/natural/bundle/cloth
	name = "bundle of cloth"
	icon_state = "clothroll1"
	possible_item_intents = list(/datum/intent/use)
	desc = "A cloth roll of several pieces of fabric."
	force = 0
	throwforce = 0
	maxamount = 10
	firefuel = 5 MINUTES
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE
	stacktype = /obj/item/natural/cloth
	stackname = "cloth"
	icon1 = "clothroll1"
	icon1step = 5
	icon2 = "clothroll2"
	icon2step = 10

/obj/item/natural/bundle/stick
	name = "bundle of sticks"
	desc = "A bundle of wooden sticks, looks like they all need to stick together!"
	icon_state = "stickbundle1"
	possible_item_intents = list(/datum/intent/use)
	maxamount = 10
	force = 0
	throwforce = 0
	firefuel = 5 MINUTES
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE
	stacktype = /obj/item/grown/log/tree/stick
	stackname = "sticks"
	icon1 = "stickbundle1"
	icon1step = 4
	icon2 = "stickbundle2"
	icon2step = 7
	icon3 = "stickbundle3"

/obj/item/natural/bowstring
	name = "fibre bowstring"
	desc = "A simple cord of bowstring."
	icon_state = "fibers"
	possible_item_intents = list(/datum/intent/use)
	force = 0
	throwforce = 0
	color = COLOR_BEIGE
	firefuel = 5 MINUTES
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_MOUTH
	max_integrity = 20
	muteinmouth = TRUE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE

/obj/item/natural/bundle/worms
	name = "worms"
	desc = "Multiple wriggly worms."
	icon_state = "worm2"
	color = "#964B00"
	maxamount = 6
	icon1 = "worm2"
	icon1step = 3
	icon2 = "worm3"
	icon2step = 5
	icon3 = "worm4"
	stacktype = /obj/item/natural/worms
	stackname = "worms"

/obj/item/natural/bundle/bone
	name = "stack of bones"
	icon_state = "bonestack1"
	possible_item_intents = list(/datum/intent/use)
	desc = "Bones stacked upon one another."
	force = 0
	throwforce = 0
	maxamount = 6
	color = null
	firefuel = null
	resistance_flags = FLAMMABLE
	slot_flags = ITEM_SLOT_MOUTH
	max_integrity = 20
	muteinmouth = TRUE
	w_class = WEIGHT_CLASS_TINY
	spitoutmouth = FALSE
	stacktype = /obj/item/alch/bone
	stackname = "bones"
	icon1 = "bonestack1"
	icon1step = 2
	icon2 = "bonestack2"
	icon2step = 4

/obj/item/natural/bundle/bone/full
	amount = 6

/*/obj/item/alch/bone/attackby(obj/item/I, mob/living/user, params)
	var/mob/living/carbon/human/H = user
	user.changeNext_move(CLICK_CD_MELEE)
	if(istype(I, /obj/item/alch/bone))
		var/obj/item/natural/bundle/bone/F = new(src.loc)
		H.put_in_hands(F)
		H.visible_message("[user] ties the bones into a bundle.")
		qdel(I)
		qdel(src)
	if(istype(I, /obj/item/natural/bundle/bone))
		var/obj/item/natural/bundle/bone/B = I
		if(B.amount < B.maxamount)
			H.visible_message("[user] adds the [src] to the bundle.")
			B.amount += 1
			B.update_bundle()
			qdel(src)
	..()*/
