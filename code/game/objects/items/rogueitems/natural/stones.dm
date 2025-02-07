

/obj/item/natural/stone
	name = "stone"
	desc = "A piece of rough ground stone."
	icon_state = "stone1"
	gripped_intents = null
	dropshrink = 0.75
	possible_item_intents = list(INTENT_GENERIC)
	force = 10
	throwforce = 15
	slot_flags = ITEM_SLOT_MOUTH
	w_class = WEIGHT_CLASS_TINY

/obj/item/natural/stone/Initialize()
	icon_state = "stone[rand(1,4)]"
	..()

/obj/item/natural/stone/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_ROTMAN))
		to_chat(user, span_info("The [src] slips through dead fingers..."))
		user.dropItemToGround(src, TRUE)

/obj/item/natural/stone/pre_attack_right(atom/A, mob/living/user, params)
	user.changeNext_move(CLICK_CD_MELEE)
	if(istype(A, /obj/item/natural/stone))
		playsound(src.loc, pick('sound/items/stonestone.ogg'), 100)
		user.visible_message(span_info("[user] strikes the stones together."))
		if(prob(10))
			var/datum/effect_system/spark_spread/S = new()
			var/turf/front = get_step(user,user.dir)
			S.set_up(1, 1, front)
			S.start()
		return
	if(istype(A, /obj/item/natural/rock))
		user.visible_message(span_info("[user] strikes the stone against the rock.</span>"))
		playsound(src.loc, 'sound/items/stonestone.ogg', 100)
		if(prob(35))
			var/datum/effect_system/spark_spread/S = new()
			var/turf/front = get_step(user,user.dir)
			S.set_up(1, 1, front)
			S.start()
		return
	. = ..()

/obj/item/natural/rock
	name = "rock"
	desc = "A large stone that looks breakable."
	icon_state = "stonebig1"
	dropshrink = 0
	throwforce = 25
	throw_range = 2
	force = 15
	obj_flags = CAN_BE_HIT
	force_wielded = 15
	gripped_intents = list(INTENT_GENERIC)
	w_class = WEIGHT_CLASS_HUGE
	twohands_required = TRUE
	var/obj/item/rogueore/mineralType = null
	var/mineralAmt = 1
	blade_dulling = DULLING_BASH
	max_integrity = 50
	destroy_sound = 'sound/foley/smash_rock.ogg'
	attacked_sound = 'sound/foley/hit_rock.ogg'


/obj/item/natural/rock/Initialize()
	if(!isnull(mineralType))
		icon_state = "stonebigshiny[rand(1,2)]"
	else
		icon_state = "stonebig[rand(1,2)]"
	..()


/obj/item/natural/rock/Crossed(mob/living/L)
	if(istype(L) && !L.throwing)
		if(L.m_intent == MOVE_INTENT_RUN)
			L.visible_message(span_warning("[L] trips over the rock!"),span_warning("I trip over the rock!"))
			L.Knockdown(10)
			L.consider_ambush()
	..()

/obj/item/natural/rock/deconstruct(disassembled = FALSE)
	if(!disassembled)
		if(mineralType && mineralAmt)
			new mineralType(src.loc, mineralAmt)
		for(var/i in 1 to rand(1,3))
			var/obj/item/S = new /obj/item/natural/stone(src.loc)
			S.pixel_x = rand(25,-25)
			S.pixel_y = rand(25,-25)
	qdel(src)

/obj/item/natural/rock/take_damage(damage_amount, damage_type = BRUTE, damage_flag = 0, sound_effect = 1, attack_dir)
	. = ..()
	if(.) //damage received
		if(damage_amount > 10)
			if(prob(10))
				var/datum/effect_system/spark_spread/S = new()
				var/turf/front = get_turf(src)
				S.set_up(1, 1, front)
				S.start()

/obj/item/natural/rock/pre_attack_right(atom/A, mob/living/user, params)
	user.changeNext_move(CLICK_CD_MELEE)
	if(istype(A, /obj/item/natural/rock))
		playsound(src.loc, pick('sound/items/stonestone.ogg'), 100)
		user.visible_message(span_info("[user] strikes the rocks together."))
		if(prob(10))
			var/datum/effect_system/spark_spread/S = new()
			var/turf/front = get_step(user,user.dir)
			S.set_up(1, 1, front)
			S.start()
		return
	. = ..()

//begin ore loot rocks
/obj/item/natural/rock/gold
	mineralType = /obj/item/rogueore/gold

/obj/item/natural/rock/iron
	mineralType = /obj/item/rogueore/iron

/obj/item/natural/rock/coal
	mineralType = /obj/item/rogueore/coal

/obj/item/natural/rock/salt
	mineralType = /obj/item/reagent_containers/powder/salt

/obj/item/natural/rock/silver
	mineralType = /obj/item/rogueore/silver

/obj/item/natural/rock/copper
	mineralType = /obj/item/rogueore/copper

/obj/item/natural/rock/tin
	mineralType = /obj/item/rogueore/tin

/obj/item/natural/rock/gemerald
	mineralType = /obj/item/roguegem

/obj/item/natural/rock/random_ore
	name = "rock?"
	desc = "Wait, this shouldn't be here?"
	icon_state = "stonerandom"

/obj/item/natural/rock/random/Initialize()
	. = ..()
	var/obj/item/natural/rock/theboi = pick(list(
		/obj/item/natural/rock/gold,
		/obj/item/natural/rock/iron,
		/obj/item/natural/rock/coal,
		/obj/item/natural/rock/salt,
		/obj/item/natural/rock/silver,
		/obj/item/natural/rock/copper,
		/obj/item/natural/rock/tin,
		/obj/item/natural/rock/gemerald
	))
	new theboi(get_turf(src))
	return INITIALIZE_HINT_QDEL
