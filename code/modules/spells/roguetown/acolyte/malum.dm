/obj/effect/proc_holder/spell/invoked/vigorouscraft
	name = "Virgorous Craftsmanship"
	overlay_state = "craft_buff"
	releasedrain = 0
	chargedrain = 0
	range = 2
	warnie = "sydwarning"
	movement_interrupt = FALSE
	no_early_release = TRUE
	req_items = list(/obj/item/clothing/neck/roguetown/psycross/silver/malum)
	invocation = "Through ash and flame! Legere librum!"
	invocation_type = "shout"
	miracle = TRUE
	antimagic_allowed = FALSE
	sound = 'sound/items/bsmithfail.ogg'
	associated_skill = /datum/skill/magic/holy
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	charge_max = 3 MINUTES
	chargetime = 2 SECONDS
	devotion_cost = 30

/obj/effect/proc_holder/spell/invoked/vigorouscraft/cast(list/targets, mob/living/carbon/user = usr)
	var/const/starminatoregen = 50 // How much energy should the spell give
	if(!isliving(targets[1]))
		return FALSE
	var/mob/living/L = targets[1]
	if (L == user)
		user.adjust_energy(starminatoregen)
		user.apply_status_effect(/datum/status_effect/buff/craft_buff)
		user.visible_message("<font color='yellow'>Vibrant flames swirl around [user].</font>", "<font color='yellow'>Vibrant flames swirl around you, energizing your mind and muscles.</font>")
		return ..()
	else if (user.energy > (starminatoregen * 2))
		user.adjust_energy(-(starminatoregen * 2))
		L.adjust_energy(starminatoregen * 2)
		L.apply_status_effect(/datum/status_effect/buff/craft_buff)
		L.visible_message("<font color='yellow'>Vibrant flames swirl around [L] as a dance of energy flows from [user].</font>", "<font color='yellow'>A dance of energy flows from [user], fueling vibrant flames that energize your mind and muscles.</font>")
		return ..()
	else
		to_chat(user, span_warning("You don't have enough strength to energize [L]!"))
		return FALSE

/obj/effect/proc_holder/spell/invoked/hammerfall
	name = "Hammerfall"
	overlay_state = "hammerfall"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	warnie = "sydwarning"
	movement_interrupt = FALSE
	no_early_release = TRUE
	req_items = list(/obj/item/clothing/neck/roguetown/psycross/silver/malum)
	sound = 'sound/items/bsmithfail.ogg'
	invocation = "Let the weight of Malum's hammer fall!"
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 3 MINUTES
	chargetime = 2 SECONDS
	miracle = TRUE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	devotion_cost = 75
	var/static/list/hammer_weapons = typecacheof(list(/obj/item/rogueweapon/hammer, /obj/item/rogueweapon/mace/goden/steel/warhammer, /obj/item/rogueweapon/mace/warhammer))

/obj/effect/proc_holder/spell/invoked/hammerfall/cast(list/targets, mob/user = usr)
	var/atom/A = targets[1]
	if(!istype(A) || !get_turf(A))
		return FALSE
	var/found = FALSE
	for(var/obj/item/I in user.held_items)
		if(is_type_in_typecache(I.type, hammer_weapons))
			found = TRUE
			break
	if(!found) //you need a hammer, it's in the name
		return FALSE
	if(get_turf(A) != get_turf(user))
		if(!leap_towards(A, user))
			return FALSE
	do_slam(get_turf(user), user)
	. = ..()

//Reused jump intent code
/obj/effect/proc_holder/spell/invoked/hammerfall/proc/leap_towards(atom/A, mob/living/user)
	if(!istype(user))
		return FALSE
	if(istype(user.loc, /turf/open/water))
		to_chat(user, span_warning("I can't jump while floating."))
		return FALSE
	if(user.get_num_legs() < 2)
		return FALSE
	if(user.IsOffBalanced())
		to_chat(user, span_warning("I haven't regained my balance yet."))
		return FALSE
	if(user.pulledby && user.pulledby != user)
		to_chat(src, span_warning("I'm being grabbed."))
		user.resist_grab()
		return FALSE
	if(!(user.mobility_flags & MOBILITY_STAND))
		to_chat(user, span_warning("I should stand up first."))
		return FALSE
	if(A.z != user.z)
		if(!HAS_TRAIT(src, TRAIT_ZJUMP))
			return FALSE
	//Time to fly
	user.changeNext_move(CLICK_CD_MELEE)
	user.face_atom(A)
	var/jadded
	var/jrange
	var/jextra = FALSE
	if(user.m_intent == MOVE_INTENT_RUN)
		user.OffBalance(30)
		jadded = 15
		jrange = 3
		jextra = TRUE
	else
		user.OffBalance(20)
		jadded = 10
		jrange = 2
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		jadded += H.get_complex_pain()/50
		if(!H.check_armor_skill())
			jadded += 50
			jrange = 1
	if(user.adjust_stamina(min(jadded,100)))
		if(jextra)
			user.throw_at(A, jrange, 1, user, spin = FALSE)
			while(user.throwing)
				sleep(1)
			user.throw_at(get_step(user, user.dir), 1, 1, user, spin = FALSE)
		else
			user.throw_at(A, jrange, 1, user, spin = FALSE)
			while(user.throwing)
				sleep(1)
		if(isopenturf(user.loc))
			var/turf/open/T = user.loc
			if(T.landsound)
				playsound(T, T.landsound, 100, FALSE)
			T.Entered(user)
	else
		user.throw_at(A, 1, 1, user, spin = FALSE)
	return TRUE

/obj/effect/proc_holder/spell/invoked/hammerfall/proc/do_slam(turf/T, mob/user)
	var/const/damage = 250 //Structural damage the spell does. At 250, it would take 4 casts (12 minutes and 320 devotion) to destroy a normal door.
	var/const/radius = 1 //Radius of the spell
	var/const/shakeradius = 3 //Radius of the quake
	var/const/dc = 42 //Code will roll 2d20 and add target's perception and Speed then compare to this to see if they fall down or not. 42 Means they need to roll 2x 20 with Speed and Perception at I
	var/const/delay = 5 // Delay between the ground marking appearing and the shake effect.
	if (istype(T, /turf/closed))
		return
	user.visible_message("<font color='yellow'>[user] hurls their hammer towards the ground, shaking its very foundations!</font>", "<font color='yellow'>You hurl your hammer toward the ground and shake its very foundations!</font>")
	for (var/turf/open/visual in view(radius, T))
		var/obj/effect/temp_visual/lavastaff/Lava = new /obj/effect/temp_visual/lavastaff(visual)
		animate(Lava, alpha = 255, time = 5)
	sleep(delay)
	for (var/mob/living/carbon/shaken in view(shakeradius, T))
		shake_camera(shaken, 5, 5)
		if(shaken == user)
			continue
		var/diceroll = 0
		diceroll = roll(2,20) + shaken.STAPER + shaken.STASPD
		if (diceroll > dc)
			shaken.Immobilize(1 SECONDS)
			to_chat(shaken, span_notice("The ground quakes but I manage to keep my footing."))
		else
			shaken.Knockdown(1 SECONDS)
			to_chat(shaken, span_warning("The ground quakes, causing me to fall over!"))
	for (var/obj/structure/damaged in view(radius, T))
		if(!istype(damaged, /obj/structure/flora/newbranch))
			damaged.take_damage(damage,BRUTE,"blunt",1)
	for (var/turf/closed/wall/damagedwalls in view(radius, T))
		damagedwalls.take_damage(damage,BRUTE,"blunt",1)
	for (var/turf/closed/mineral/aoemining in view(radius, T))
		aoemining.lastminer = user
		aoemining.take_damage(damage*2,BRUTE,"blunt",1)

/obj/effect/temp_visual/lavastaff
	icon_state = "lavastaff_warn"

/obj/effect/proc_holder/spell/invoked/heatmetal
	name = "Heat Metal"
	overlay_state = "heatmetal"
	releasedrain = 30
	chargedrain = 0
	warnie = "sydwarning"
	movement_interrupt = FALSE
	no_early_release = TRUE
	req_items = list(/obj/item/clothing/neck/roguetown/psycross/silver/malum)
	sound = 'sound/items/bsmithfail.ogg'
	invocation = "Metal bends to the heat of Malum's forge!"
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = FALSE
	charge_max = 2 MINUTES
	chargetime = 2 SECONDS
	miracle = TRUE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	devotion_cost = 40

/obj/effect/proc_holder/spell/invoked/heatmetal/cast(list/targets, mob/user = usr)
	var/target = targets[1]
	if (istype(target, /obj/item))
		if(handle_item_smelting(target, user))
			return ..()
		return FALSE
	else if(istype(target, /obj/machinery/anvil))
		handle_anvil(target, user)
		return ..()
	else if (iscarbon(target))
		if(handle_living_entity(target, user))
			return ..()
		return FALSE
	else
		return FALSE

/obj/effect/proc_holder/spell/invoked/heatmetal/proc/handle_item_smelting(obj/item/target, mob/user)
	if(istype(target, /obj/item/rogueweapon/tongs))
		return handle_tongs(target, user)
	if(!target.smeltresult || target.smeltresult == /obj/item/ash)
		return
	var/atom/target_loc = target.loc
	var/obj/item/itemtospawn
	//Only ores can be smelted remotely, other items must be held by the user
	if(istype(target, /obj/item/rogueore))
		target.visible_message("<font color='yellow'>After [user]'s incantation, [target] melts into an ingot.</font>")
		itemtospawn = new target.smeltresult(get_turf(target))
	else if(target_loc == user)
		user.visible_message("<font color='yellow'>[user] channels Malum's power to smelt [target] [user.p_theyre()] holding.</font>")
		itemtospawn = new target.smeltresult(get_turf(target))
	else
		return FALSE
	qdel(target)
	if(ismob(target_loc))
		var/mob/holding_mob = target_loc
		holding_mob.put_in_hands(itemtospawn)
	else
		SEND_SIGNAL(target_loc, COMSIG_TRY_STORAGE_INSERT, itemtospawn, null, TRUE, FALSE)
	var/datum/effect_system/spark_spread/sparks = new()
	sparks.set_up(1, 1, target.loc)
	sparks.start()
	return TRUE

/obj/effect/proc_holder/spell/invoked/heatmetal/proc/handle_tongs(obj/item/rogueweapon/tongs/T, mob/user) //Stole the code from smithing.
	if(!T.hingot)
		return
	var/tyme = world.time + 20 SECONDS
	T.hott = tyme
	addtimer(CALLBACK(T, TYPE_PROC_REF(/obj/item/rogueweapon/tongs, make_unhot), tyme), 30 SECONDS)
	T.update_icon()
	T.visible_message("<font color='yellow'>After [user]'s incantation, [T.hingot] inside [T] starts glowing from divine heat.</font>")
	return TRUE

/obj/effect/proc_holder/spell/invoked/heatmetal/proc/handle_anvil(obj/machinery/anvil/A, mob/user) //Stole the code from smithing.
	if(A.hingot)
		A.hott = world.time
		START_PROCESSING(SSmachines, A)
	A.cool_time = 30 SECONDS
	addtimer(VARSET_CALLBACK(A, cool_time, 10 SECONDS), 30 SECONDS)
	A.update_icon()
	A.visible_message("<font color='yellow'>After [user]'s incantation, [A] begins to glow from divine heat.</font>")
	return TRUE

/obj/effect/proc_holder/spell/invoked/heatmetal/proc/handle_living_entity(mob/target, mob/user, list/nosmeltore)
	var/obj/item/targeteditem = get_targeted_item(user, target)
	if(!targeteditem)
		return FALSE

	if(istype(targeteditem, /obj/item/rogueweapon/tongs))
		return handle_tongs(targeteditem, user)

	if(!targeteditem.smeltresult || targeteditem.smeltresult == /obj/item/ash || target.anti_magic_check(TRUE))
		user.visible_message("<font color='yellow'>After their incantation, [user] points at [target], but nothing happens.</font>", "<font color='yellow'>After your incantation, you point at [target], but nothing happens.</font>")
		return TRUE

	if(iscarbon(target))
		if(target.is_holding(targeteditem))
			handle_heating_in_hand(target, targeteditem, user)
		else
			handle_heating_equipped(target, targeteditem, user)
	return TRUE

/obj/effect/proc_holder/spell/invoked/heatmetal/proc/handle_heating_in_hand(mob/living/carbon/target, obj/item/targeteditem, mob/user)
	var/adth_damage_to_apply = 10 //How much damage should burning your hand before dropping the item do.
	var/obj/item/bodypart/affecting
	var/hand_index = target.get_held_index_of_item(targeteditem)
	switch(hand_index)
		if(2)
			affecting = target.get_bodypart(BODY_ZONE_R_ARM)
		if(1)
			affecting = target.get_bodypart(BODY_ZONE_L_ARM)
	if(!affecting)
		return
	affecting.receive_damage(burn = adth_damage_to_apply)
	target.dropItemToGround(targeteditem)
	target.visible_message("<font color='yellow'>[target]'s [targeteditem.name] glows brightly and sears their flesh!</font>", "<font color='yellow'>Your [targeteditem.name] glows brightly, burning your hand!</font>")
	target.emote("painscream")
	playsound(target.loc, 'sound/misc/frying.ogg', 80, FALSE, -1)
	var/datum/effect_system/spark_spread/sparks = new()
	sparks.set_up(1, 1, target.loc)
	sparks.start()

/obj/effect/proc_holder/spell/invoked/heatmetal/proc/handle_heating_equipped(mob/living/carbon/target, obj/item/clothing/targeteditem, mob/user)
	var/damage_to_apply = 20 // How much damage should your armor burning you should do.
	var/part_bitflags = targeteditem.body_parts_covered
	var/list/body_zones = body_parts_covered2organ_names(part_bitflags) //list of precise and main body zones
	if(!length(body_zones))
		return
	var/list/filtered_zones = list()
	for(var/body_zone in body_zones)
		filtered_zones |= check_zone(body_zone)
	if(BODY_ZONE_CHEST in filtered_zones)
		var/chest_damage = damage_to_apply
		var/obj/item/armor = target.get_item_by_slot(SLOT_ARMOR)
		var/obj/item/shirt = target.get_item_by_slot(SLOT_SHIRT)
		var/armor_can_heat = armor && armor.smeltresult && armor.smeltresult != /obj/item/ash
		var/shirt_can_heat = shirt && shirt.smeltresult && shirt.smeltresult != /obj/item/ash //Full damage if no shirt
		if(armor_can_heat && (shirt && !shirt_can_heat))
			chest_damage = damage_to_apply / 2 //Halve the damage if only armor can heat but shirt can't.
		else if(armor_can_heat && shirt_can_heat)
			chest_damage = damage_to_apply * 2 //Damage is doubled if both shirt and armor are metallic
		var/obj/item/bodypart/affecting = target.get_bodypart(BODY_ZONE_CHEST)
		affecting?.receive_damage(burn = chest_damage)
		filtered_zones -= BODY_ZONE_CHEST
	for(var/body_zone in filtered_zones)
		var/obj/item/bodypart/affecting = target.get_bodypart(body_zone)
		affecting?.receive_damage(burn = damage_to_apply)

	target.visible_message("<font color='yellow'>[target]'s [targeteditem.name] glows brightly, searing their flesh!</font>", "<font color='yellow'>My [targeteditem.name] glows brightly, burning me!</font>")

	target.emote("painscream")
	playsound(target.loc, 'sound/misc/frying.ogg', 80, FALSE, -1)
	var/datum/effect_system/spark_spread/sparks = new()
	sparks.set_up(1, 1, target.loc)
	sparks.start()

/obj/effect/proc_holder/spell/invoked/heatmetal/proc/get_targeted_item(mob/user, mob/target)
	var/target_item
	switch(user.zone_selected)
		if(BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_PRECISE_R_INHAND)
			target_item = target.held_items[2]
			if(!target_item)
				target_item = target.get_item_by_slot(SLOT_GLOVES)
		if(BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_PRECISE_L_INHAND)
			target_item = target.held_items[1]
			if(!target_item)
				target_item = target.get_item_by_slot(SLOT_GLOVES)
		if(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_SKULL, BODY_ZONE_PRECISE_EARS)
			target_item = target.get_item_by_slot(SLOT_HEAD)
		if(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_STOMACH)
			target_item = target.get_item_by_slot(SLOT_ARMOR)
			if(!target_item)
				target_item = target.get_item_by_slot(SLOT_SHIRT)
		if(BODY_ZONE_PRECISE_NECK)
			target_item = target.get_item_by_slot(SLOT_NECK)
		if(BODY_ZONE_PRECISE_R_EYE, BODY_ZONE_PRECISE_L_EYE, BODY_ZONE_PRECISE_NOSE)
			target_item = target.get_item_by_slot(SLOT_WEAR_MASK)
			if(!target_item)
				target_item = target.get_item_by_slot(SLOT_HEAD)
		if(BODY_ZONE_PRECISE_MOUTH)
			target_item = target.get_item_by_slot(SLOT_MOUTH)
			if(!target_item)
				target_item = target.get_item_by_slot(SLOT_HEAD)
		if(BODY_ZONE_R_ARM)
			target_item = target.get_item_by_slot(SLOT_WRISTS)
			if(!target_item)
				target_item = target.held_items[2]
		if(BODY_ZONE_L_ARM)
			target_item = target.get_item_by_slot(SLOT_WRISTS)
			if(!target_item)
				target_item = target.held_items[1]
		if(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG, BODY_ZONE_PRECISE_GROIN)
			target_item = target.get_item_by_slot(SLOT_PANTS)
		if(BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_PRECISE_L_FOOT)
			target_item = target.get_item_by_slot(SLOT_SHOES)
	return target_item
