/datum/action/cooldown/spell/hammer_fall
	name = "Hammerfall"
	desc = ""
	button_icon_state = "craft_buff"
	sound = 'sound/items/bsmithfail.ogg'
	sound_loop = /datum/looping_sound/invokeholy

	cast_range = 2
	spell_flags = SPELL_MIRACLE
	antimagic_flags = MAGIC_RESISTANCE_HOLY
	associated_skill = /datum/skill/magic/holy
	required_items = list(/obj/item/clothing/neck/psycross/silver/malum)

	invocation = "Let the weight of Malum's hammer fall!"
	invocation_type = INVOCATION_SHOUT

	charge_time = 2 SECONDS
	charge_drain = 1
	charge_slowdown = 3
	cooldown_time = 3 MINUTES
	spell_cost = 75

	var/static/list/hammer_weapons = typecacheof(list(
		/obj/item/weapon/hammer,
		/obj/item/weapon/mace/goden/steel/warhammer,
		/obj/item/weapon/mace/warhammer,
		/obj/item/weapon/mace/goden/steel/malum,
	))

/datum/action/cooldown/spell/hammer_fall/can_cast_spell(feedback)
	. = ..()
	if(!.)
		return
	for(var/obj/item/I in owner.held_items)
		if(is_type_in_typecache(I.type, hammer_weapons))
			break
		if(feedback)
			to_chat(owner, "I need a hammer to cast this.")
		return FALSE

/datum/action/cooldown/spell/hammer_fall/cast(atom/cast_on)
	. = ..()
	var/turf/target = get_turf(cast_on)
	if(target != get_turf(owner))
		if(!leap_towards(target))
			return
	do_slam()

/datum/action/cooldown/spell/hammer_fall/proc/leap_towards(atom/A)
	if(!isliving(owner))
		return FALSE
	var/mob/living/living_owner = owner
	if(istype(get_turf(owner), /turf/open/water))
		to_chat(owner, span_warning("I can't jump while floating."))
		return FALSE
	if(living_owner.usable_legs < 2)
		return FALSE
	if(living_owner.IsOffBalanced())
		to_chat(living_owner, span_warning("I haven't regained my balance yet."))
		return FALSE
	if(living_owner.pulledby && living_owner.pulledby != living_owner)
		to_chat(src, span_warning("I'm being grabbed."))
		living_owner.resist_grab()
		return FALSE
	if(living_owner.body_position == LYING_DOWN)
		to_chat(living_owner, span_warning("I should stand up first."))
		return FALSE
	if(A.z != living_owner.z)
		if(!HAS_TRAIT(src, TRAIT_ZJUMP))
			return FALSE
	//Time to fly
	living_owner.changeNext_move(CLICK_CD_MELEE)
	living_owner.face_atom(A)
	var/jadded
	var/jrange
	var/jextra = FALSE
	if(living_owner.m_intent == MOVE_INTENT_RUN)
		living_owner.OffBalance(30)
		jadded = 15
		jrange = 3
		jextra = TRUE
	else
		living_owner.OffBalance(20)
		jadded = 10
		jrange = 2
	if(ishuman(living_owner))
		var/mob/living/carbon/human/H = living_owner
		jadded += H.get_complex_pain() / 50
		if(H.get_encumbrance() > 0.6)
			jadded += 50
			jrange = 1
	if(living_owner.adjust_stamina(min(jadded, 100)))
		if(jextra)
			living_owner.throw_at(A, jrange, 1, living_owner, spin = FALSE)
			while(living_owner.throwing)
				sleep(1)
			living_owner.throw_at(get_step(living_owner, living_owner.dir), 1, 1, living_owner, spin = FALSE)
		else
			living_owner.throw_at(A, jrange, 1, living_owner, spin = FALSE)
			while(living_owner.throwing)
				sleep(1)
		if(isopenturf(living_owner.loc))
			var/turf/open/T = living_owner.loc
			if(T.landsound)
				playsound(T, T.landsound, 100, FALSE)
			T.Entered(living_owner)
	else
		living_owner.throw_at(A, 1, 1, living_owner, spin = FALSE)

	return TRUE

/datum/action/cooldown/spell/hammer_fall/proc/do_slam()
	var/static/damage = 250 //Structural damage the spell does. At 250, it would take 4 casts (12 minutes and 320 devotion) to destroy a normal door.
	var/static/radius = 1 //Radius of the spell
	var/static/shakeradius = 3 //Radius of the quake
	var/static/dc = 42 //Code will roll 2d20 and add target's perception and Speed then compare to this to see if they fall down or not. 42 Means they need to roll 2x 20 with Speed and Perception at I
	var/static/delay = 5 // Delay between the ground marking appearing and the shake effect.
	var/turf/T = get_turf(owner)
	if(istype(T, /turf/closed))
		return
	owner.visible_message("<font color='yellow'>[owner] hurls their hammer towards the ground, shaking its very foundations!</font>", "<font color='yellow'>You hurl your hammer toward the ground and shake its very foundations!</font>")
	for (var/turf/open/visual in view(radius, T))
		var/obj/effect/temp_visual/lavastaff/Lava = new /obj/effect/temp_visual/lavastaff(visual)
		animate(Lava, alpha = 255, time = 5)
	sleep(delay)
	for (var/mob/living/carbon/shaken in view(shakeradius, T))
		shake_camera(shaken, 5, 5)
		if(shaken == owner)
			continue
		var/diceroll = 0
		diceroll = roll(2,20) + shaken.STAPER + shaken.STASPD
		if (diceroll > dc)
			shaken.Immobilize(1 SECONDS)
			to_chat(shaken, span_notice("The ground quakes but I manage to keep my footing."))
		else
			shaken.Knockdown(1 SECONDS)
			to_chat(shaken, span_warning("The ground quakes, causing me to fall over!"))

	for(var/obj/structure/damaged in view(radius, T))
		damaged.take_damage(damage, BRUTE, "blunt", 1)

	for(var/turf/closed/wall/damagedwalls in view(radius, T))
		damagedwalls.take_damage(damage, BRUTE, "blunt", 1)

	for(var/turf/closed/mineral/aoemining in view(radius, T))
		aoemining.lastminer = owner
		aoemining.take_damage(damage * 2, BRUTE, "blunt", 1)

/obj/effect/temp_visual/lavastaff
	icon_state = "lavastaff_warn"
