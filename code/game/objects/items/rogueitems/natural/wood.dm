/obj/item/grown/log/tree
	icon = 'icons/roguetown/items/natural.dmi'
	seed = null
	name = "log"
	desc = "Refined lumber, ready for use or processing."
	icon_state = "log"
	attacked_sound = 'sound/misc/woodhit.ogg'
	blade_dulling = DULLING_CUT
	max_integrity = 30
	static_debris = list(/obj/item/grown/log/tree/small = 2)
	obj_flags = CAN_BE_HIT
	resistance_flags = FLAMMABLE
	twohands_required = TRUE
	gripped_intents = list(/datum/intent/hit)
	possible_item_intents = list(/datum/intent/hit)
	obj_flags = CAN_BE_HIT
	w_class = WEIGHT_CLASS_HUGE
	metalizer_result = /obj/structure/bars/pipe
	var/quality = SMELTERY_LEVEL_NORMAL // For it not to ruin recipes that need it
	var/lumber = /obj/item/grown/log/tree/small //These are solely for lumberjack calculations
	var/lumber_alt
	var/lumber_amount = 1

/obj/item/grown/log/tree/attacked_by(obj/item/I, mob/living/user) //This serves to reward woodcutting
	if(user.used_intent.blade_class == BCLASS_CHOP && lumber_amount && lumber)
		var/skill_level = user.mind.get_skill_level(/datum/skill/labor/lumberjacking)
		var/lumber_time = (4 SECONDS - (skill_level * 5))
		var/minimum = 1
		playsound(src, 'sound/misc/woodhit.ogg', 100, TRUE)
		if(!do_after(user, lumber_time, user))
			return
		if(skill_level > 0) // If skill level is 1 or higher, we get more minimum wood!
			minimum = 2
		lumber_amount = rand(minimum, max(round(skill_level), minimum))
		var/essense_sound_played = FALSE //This is here so the sound wont play multiple times if the essense itself spawns multiple times
		for(var/i = 0; i < lumber_amount; i++)
			if(prob(skill_level + prob(CLAMP((user.STALUC - 10)*2,0,100))))
				new /obj/item/grown/log/tree/small/essence(get_turf(src))
				if(!essense_sound_played)
					essense_sound_played = TRUE
					to_chat(user, span_warning("Dendor watches over us..."))
					playsound(src,pick('sound/items/gem.ogg'), 100, FALSE)
			else
				new lumber(get_turf(src))
		if(!skill_level)
			to_chat(user, span_info("My poor skill has me ruin some of the timber..."))
		user.mind.add_sleep_experience(/datum/skill/labor/lumberjacking, (user.STAINT*0.5))
		playsound(src, destroy_sound, 100, TRUE)
		qdel(src)
		return TRUE
	..()


/obj/item/grown/log/tree/attack_right(mob/living/user)
	. = ..()
	var/obj/item/I = user.get_active_held_item()
	if(!I)
		return

	if(user.used_intent.blade_class == BCLASS_CHOP && lumber_amount && lumber_alt)
		var/skill_level = user.mind.get_skill_level(/datum/skill/labor/lumberjacking)
		var/lumber_time = (4 SECONDS - (skill_level * 5))
		var/minimum = 1
		playsound(src, 'sound/misc/woodhit.ogg', 100, TRUE)
		if(!do_after(user, lumber_time, user))
			return
		if(skill_level > 0) // If skill level is 1 or higher, we get more minimum wood!
			minimum = 2
		lumber_amount = rand(minimum, max(round(skill_level), minimum))
		var/essense_sound_played = FALSE //This is here so the sound wont play multiple times if the essense itself spawns multiple times
		for(var/i = 0; i < lumber_amount; i++)
			if(prob(skill_level + prob(CLAMP((user.STALUC - 10)*2,0,100))))
				new /obj/item/grown/log/tree/small/essence(get_turf(src))
				if(!essense_sound_played)
					essense_sound_played = TRUE
					to_chat(user, span_warning("Dendor watches over us..."))
					playsound(src,pick('sound/items/gem.ogg'), 100, FALSE)
			else
				new lumber_alt(get_turf(src))
		if(!skill_level)
			to_chat(user, span_info("My poor skill has me ruin some of the timber..."))
		user.mind.add_sleep_experience(/datum/skill/labor/lumberjacking, (user.STAINT*0.5))
		playsound(src, destroy_sound, 100, TRUE)
		qdel(src)
		return TRUE
	..()

/*
* Okay so the root of this proc defines dissasemble
* but doesnt do anything with it. This means despite
* burn() calling deconstruct(FALSE) it will still
* spawn the debris.
*/
/obj/item/grown/log/tree/deconstruct(disassembled = TRUE)
	if(disassembled)
		return ..()
	qdel(src)

/obj/item/grown/log/tree/obj_destruction(damage_flag)
	obj_destroyed = TRUE
	if(damage_flag == "acid")
		acid_melt()
	else if(damage_flag == "fire")
		burn()
	else
		if(destroy_sound)
			playsound(src, destroy_sound, 100, TRUE)
		if(destroy_message)
			visible_message(destroy_message)
		deconstruct(TRUE)
	return TRUE

/obj/item/grown/log/tree/small
	name = "small log"
	desc = "A smaller log that came from a larger log. Suitable for building."
	icon_state = "logsmall"
	attacked_sound = 'sound/misc/woodhit.ogg'
	max_integrity = 30
	static_debris = list(/obj/item/grown/log/tree/stick = 3)
	firefuel = 20 MINUTES
	twohands_required = FALSE
	gripped_intents = null
	w_class = WEIGHT_CLASS_BULKY
	smeltresult = /obj/item/rogueore/coal
	lumber = /obj/item/natural/wood/plank
	lumber_alt = /obj/item/grown/log/tree/stick
	lumber_amount = 2

/obj/item/grown/log/tree/stick
	seed = null
	name = "stick"
	desc = "A wooden stick, a mighty weapon to the imaginative."
	icon_state = "stick1"
	blade_dulling = 0
	max_integrity = 20
	static_debris = null
	firefuel = 5 MINUTES
	w_class = WEIGHT_CLASS_NORMAL
	twohands_required = FALSE
	gripped_intents = null
	slot_flags = ITEM_SLOT_MOUTH|ITEM_SLOT_HIP
	lumber_amount = 0
	lumber = null

/obj/item/grown/log/tree/stick/Crossed(mob/living/L)
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

/obj/item/grown/log/tree/stick/Initialize()
	icon_state = "stick[rand(1,2)]"
	..()

/obj/item/grown/log/tree/stick/attack_self(mob/living/user)
	user.visible_message("<span class='warning'>[user] snaps [src].</span>")
	playsound(user,'sound/items/seedextract.ogg', 100, FALSE)
	qdel(src)

/obj/item/grown/log/tree/stick/attackby(obj/item/I, mob/living/user, params)
	user.changeNext_move(CLICK_CD_MELEE)
	if(user.used_intent?.blade_class == BCLASS_CUT)
		playsound(get_turf(src.loc), 'sound/items/wood_sharpen.ogg', 100)
		if(do_after(user, 2 SECONDS))
			user.visible_message("<span class='notice'>[user] sharpens [src].</span>")
			var/obj/item/grown/log/tree/stake/S = new /obj/item/grown/log/tree/stake(get_turf(src.loc))
			if(user.is_holding(src))
				user.dropItemToGround(src)
				user.put_in_hands(S)
			qdel(src)
		else
			user.visible_message("<span class='warning'>[user] sharpens [src].</span>")
		return
	if(istype(I, /obj/item/natural/bundle/stick))
		var/obj/item/natural/bundle/stick/B = I
		if(B.amount < B.maxamount)
			to_chat(user, span_notice("I add [src] to [B]."))
			B.amount += 1
			B.update_bundle()
			qdel(src)
		return
	return ..()

/obj/item/grown/log/tree/stick/attack_right(mob/living/user)
	. = ..()
	var/obj/item/I = user.get_active_held_item()
	if(istype(I, /obj/item/grown/log/tree/stick))
		var/obj/item/natural/bundle/stick/F = new(src.loc)
		qdel(I)
		qdel(src)
		user.put_in_hands(F)
		to_chat(user, "You collect the [F.stackname] into a bundle.")

/obj/item/grown/log/tree/stake
	name = "stake"
	desc = "A sharpened piece of wood, fantastic for piercing"
	icon_state = "stake"
	force = 2
	throwforce = 2
	possible_item_intents = list(/datum/intent/stab, /datum/intent/pick)
	firefuel = 1 MINUTES
	blade_dulling = 0
	max_integrity = 20
	static_debris = null
	w_class = WEIGHT_CLASS_SMALL
	twohands_required = FALSE
	gripped_intents = null
	slot_flags = ITEM_SLOT_MOUTH|ITEM_SLOT_HIP
	lumber = null
	lumber_amount = 0
	tool_behaviour = TOOL_IMPROVISED_RETRACTOR

/obj/item/natural/wood/plank
	name = "wood plank"
	desc = "A wooden plank ready to be worked."
	icon_state = "wplank"
	firefuel = 5 MINUTES
	w_class = WEIGHT_CLASS_NORMAL
	smeltresult = /obj/item/ash
	bundletype = /obj/item/natural/bundle/plank

/obj/item/natural/bundle/plank
	name = "wooden planks"
	icon_state = "planks1"
	possible_item_intents = list(/datum/intent/use)
	desc = "Wooden planks bundled together for easy handling."
	force = 0
	throwforce = 0
	maxamount = 10
	firefuel = 30 MINUTES
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_BULKY
	spitoutmouth = FALSE
	stacktype = /obj/item/natural/wood/plank
	stackname = "plank"
	icon1 = "planks1"
	icon1step = 5
	icon2 = "planks2"
	icon2step = 10
	smeltresult = /obj/item/ash

/obj/item/grown/log/tree/small/essence
	name = "essence of lumber"
	desc = "A mystical essense embued with the power of Dendor. Very good source of fuel."
	icon_state = "lessence"
	static_debris = null
	firefuel = 60 MINUTES // Extremely poweful fuel.
	w_class = WEIGHT_CLASS_SMALL
