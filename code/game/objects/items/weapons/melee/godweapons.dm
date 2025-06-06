//┌─────────────── INHUMEN PANTHEON WEAPONS BELOW ───────────────┐

// god weapons should have 720 durability, and can reach 0 and become unusable but do not break and can be repaired

#define GOREFEAST_UNWORTHY list(\
	span_danger("Unworthy..."),\
	span_danger("You are far too weak to be wielding me."),\
	span_danger("How did you get your hands on me?"),\
	span_danger("Find the nearest orc, and hand me to them."),\
	span_danger("You are not prepared."),\
)

#define GOREFEAST_WORTHY list(\
	span_danger("A worthy one!"),\
	span_danger("Bathe me in their blood."),\
	span_danger("You can smell their fear can't you?"),\
	span_danger("Unleash your fury, soak the soil in their blood."),\
	span_danger("Feast on their organs."),\
	span_danger("Cull the world of the weak!"),\
	span_danger("Fools to challenge us, warlord."),\
)

//┌─────────────── GOREFEAST ───────────────┐//
/obj/item/weapon/polearm/halberd/bardiche/woodcutter/gorefeast
	name = "gorefeast"
	desc = "It is said that with this axe alone, Graggar slew a thousand men. With you, it will slay a thousand more."
	icon = 'icons/roguetown/weapons/godweapons.dmi'
	icon_state = "gorefeast"
	parrysound = "sword"
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	max_blade_int = 200
	max_integrity = 720
	possible_item_intents = list(/datum/intent/axe/cut, /datum/intent/axe/chop)
	gripped_intents = list(/datum/intent/axe/cut, /datum/intent/axe/chop/great, /datum/intent/sword/strike)
	wdefense = GOOD_PARRY
	force = DAMAGE_HEAVYAXE_WIELD
	force_wielded = 35
	minstr = 12
	sellprice = 550

/obj/item/weapon/polearm/halberd/bardiche/woodcutter/gorefeast/pickup(mob/user)
	. = ..()
	var/message
	if(!HAS_TRAIT(user, TRAIT_ORGAN_EATER))
		to_chat(user, span_danger("The beating heart of the blade seems to slow down at the sight of you... disinterested."))
		user.playsound_local(user, pick('sound/misc/godweapons/gorefeast1.ogg', 'sound/misc/godweapons/gorefeast2.ogg', 'sound/misc/godweapons/gorefeast3.ogg'), 100)
		message = pick(GOREFEAST_UNWORTHY)
	else
		to_chat(user, span_danger("Gorefeast begins to thump, ecstatically upon your touch on the boney shaft."))
		user.playsound_local(user, pick('sound/misc/godweapons/gorefeast4.ogg', 'sound/misc/godweapons/gorefeast5.ogg', 'sound/misc/godweapons/gorefeast6.ogg'), 100)
		message = pick(GOREFEAST_WORTHY)
	addtimer(CALLBACK(src, PROC_REF(do_message), message), 2 SECONDS)

/obj/item/weapon/polearm/halberd/bardiche/woodcutter/gorefeast/proc/do_message(message)
	audible_message("gorefeast speaks, \"[message]\"", hearing_distance = 5)

/obj/item/weapon/polearm/halberd/bardiche/woodcutter/gorefeast/pre_attack(atom/A, mob/living/user, params)
	if(!HAS_TRAIT(user, TRAIT_ORGAN_EATER))
		force = 13
		force_wielded = 23
	return ..()

/obj/item/weapon/polearm/halberd/bardiche/woodcutter/gorefeast/afterattack(atom/target, mob/living/user, proximity_flag, click_parameters)
	. = ..()
	// if(prob(20))
	// 	if(!HAS_TRAIT(user, TRAIT_ORGAN_EATER))
	// 		user.playsound_local()
	// 		to_chat(user)
	//		return
	// 	user.playsound_local()
	// 	to_chat(user)

	if(!ishuman(target))
		return
	if(check_zone(user.zone_selected) != BODY_ZONE_CHEST)
		return
	var/mob/living/carbon/human/H = target
	var/heart_crit = H.has_wound(/datum/wound/artery/chest)
	var/dead = H.stat == DEAD
	if((H.health < H.crit_threshold) || heart_crit || dead)
		var/fast = heart_crit || dead
		var/obj/item/organ/heart/heart = H.getorganslot(ORGAN_SLOT_HEART)
		if(!heart)
			to_chat(user, span_warning("Only a hollow chest remains!"))
			return FALSE
		to_chat(user, span_notice("I begin to pull the heart from [H]..."))
		if(do_after(user, fast ? 5 SECONDS : 10 SECONDS, H))
			heart.Remove(H)
			heart.forceMove(H.drop_location())

			H.add_splatter_floor()
			H.adjustBruteLoss(20)
			to_chat(user, span_notice("I finish pulling the heart from [H]!"))

#undef GOREFEAST_UNWORTHY
#undef GOREFEAST_WORTHY

//┌─────────────── NEANT ───────────────┐//
/obj/item/weapon/polearm/neant
	name = "neant"
	desc = "A dark scythe with a long chain, used to cut the life essence from people, or whip them into shape. The blade is an ominous purple."
	icon_state = "neant"
	icon = 'icons/roguetown/weapons/godweapons.dmi'
	drop_sound = 'sound/foley/dropsound/blade_drop.ogg'
	slot_flags = ITEM_SLOT_BACK
	resistance_flags = FIRE_PROOF
	dropshrink = 0.75
	max_blade_int = 200
	max_integrity = 720
	possible_item_intents = list(/datum/intent/polearm/cut)
	gripped_intents = list(/datum/intent/polearm/chop, /datum/intent/whip, /datum/intent/shoot/neant)
	thrown_bclass = BCLASS_CUT
	blade_dulling = DULLING_BASHCHOP
	wdefense = GREAT_PARRY
	force = 20
	force_wielded = 25
	throwforce = 25
	minstr = 10
	sellprice = 550

	COOLDOWN_DECLARE(fire_projectile)

/obj/item/weapon/polearm/neant/attack(mob/living/M, mob/living/user)
	if(user.used_intent.tranged)
		return
	return ..()

/obj/item/weapon/polearm/neant/afterattack(atom/target, mob/living/user, proximity_flag, click_parameters)
	. = ..()
	if(!HAS_TRAIT(user, TRAIT_CABAL))
		return
	if(user.used_intent?.tranged)
		handle_magick(user, target)
		return
	if(!ishuman(target))
		return
	if(check_zone(user.zone_selected) != BODY_ZONE_CHEST)
		return
	var/mob/living/carbon/human/H = target
	if(H.get_lux_status() != LUX_HAS_LUX)
		return
	var/dead = H.stat == DEAD
	if((H.health < H.crit_threshold) || dead)
		var/speed = dead ? 4 SECONDS : 8 SECONDS
		to_chat(user, span_notice("I begin to remove the lux of [target]..."))
		if(!do_after(user, speed, H))
			return
		var/obj/item/bodypart/chest/C = H.get_bodypart(BODY_ZONE_CHEST)
		if(!C)
			return

		C.add_wound(/datum/wound/slash/incision)
		C.add_wound(/datum/wound/fracture/chest)

		new /obj/item/reagent_containers/lux(get_turf(target))

		H.apply_status_effect(/datum/status_effect/buff/lux_drained)
		SEND_SIGNAL(user, COMSIG_LUX_EXTRACTED, target)
		record_featured_stat(FEATURED_STATS_CRIMINALS, user)
		GLOB.vanderlin_round_stats[STATS_LUX_HARVESTED]++

		H.add_splatter_floor()
		H.adjustBruteLoss(20)
		to_chat(user, span_notice("I finish removing the lux from [target]!"))

/obj/item/weapon/polearm/neant/proc/handle_magick(mob/living/user, atom/target)
	if(!COOLDOWN_FINISHED(src, fire_projectile))
		return
	var/client/client = user.client
	if(!client?.chargedprog)
		return

	var/startloc = get_turf(src)
	var/obj/projectile/bullet/neant/PJ = new(startloc)
	PJ.starting = startloc
	PJ.firer = user
	PJ.fired_from = src
	PJ.original = target

	if(user.STAPER > 8)
		PJ.accuracy += (user.STAPER - 8) * 2 //each point of perception above 8 increases standard accuracy by 2.
		PJ.bonus_accuracy += (user.STAPER - 8) //Also, increases bonus accuracy by 1, which cannot fall off due to distance.

	if(user.STAINT > 10) // Every point over 10 INT adds 10% damage
		PJ.damage = PJ.damage * (user.STAINT / 10)
		PJ.accuracy += (user.STAINT - 10) * 3

	new /obj/effect/temp_visual/dir_setting/firing_effect/neant(get_step(user, user.dir), user.dir)
	PJ.preparePixelProjectile(target, user)
	PJ.fire()
	user.changeNext_move(CLICK_CD_RANGE)
	COOLDOWN_START(src, fire_projectile, 4 SECONDS)

/obj/projectile/bullet/neant
	name = "TROL LOLO"
	icon = 'icons/effects/effects.dmi'
	icon_state = "neantprojectile"
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	range = 7
	damage = 35
	armor_penetration = 40
	damage_type = BRUTE
	woundclass = BCLASS_CUT
	flag =  "piercing"
	speed = 1
	accuracy = 80

/obj/effect/temp_visual/dir_setting/firing_effect/neant
	icon = 'icons/effects/effects.dmi'
	icon_state = "neantspecial"
	duration = 4

/datum/intent/shoot/neant
	name = "shoot"
	icon_state = "inshoot"
	warnie = "aimwarn"
	item_damage_type = "stab"
	tranged = TRUE
	chargetime = 2 SECONDS
	no_early_release = TRUE
	noaa = TRUE
	charging_slowdown = 2

/datum/intent/shoot/neant/prewarning()
	if(masteritem && mastermob)
		mastermob.visible_message(span_warning("[mastermob] aims [masteritem]!"), span_notice("I aim [masteritem]."))

//┌─────────────── TURBULENTA ───────────────┐//

/obj/item/gun/ballistic/revolver/grenadelauncher/bow/turbulenta
	name = "turbulenta"
	desc = "Rarely does she even care about combat, but when she does... Baotha was quite the markswoman."
	icon = 'icons/roguetown/weapons/godweapons.dmi'
	icon_state = "turbulenta"
	base_icon = "turbulenta"
	pixel_y = -16
	pixel_x = -16
	bigboy = TRUE
	dropshrink = 0.75
	possible_item_intents = list(/datum/intent/shoot/bow/turbulenta, /datum/intent/arc/bow/turbulenta, /datum/intent/use)
	randomspread = 1
	spread = 1
	force = 9
	damfactor = 0.9

/datum/intent/shoot/bow/turbulenta
	chargetime = 0.75
	chargedrain = 1.5
	charging_slowdown = 2.5

/datum/intent/arc/bow/turbulenta
	chargetime = 0.75
	chargedrain = 1.5
	charging_slowdown = 2.5

// can be used a lyre
// applies spice to arrows shot ( must have baotha's blessing ) be baothan

//┌─────────────── PLEONEXIA ───────────────┐//
/obj/item/weapon/sword/long/pleonexia
	icon_state = "pleonexia"
	icon = 'icons/roguetown/weapons/godweapons.dmi'
	name = "pleonexia"
	desc = "A sword of legend. If they are true, then this blade is the blade of Matthios himself. Rumor has it, it steals space and time."
	swingsound = BLADEWOOSH_LARGE
	parrysound = "largeblade"
	pickup_sound = "brandish_blade"
	possible_item_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/strike)
	gripped_intents = list(/datum/intent/use, /datum/intent/sword/thrust, /datum/intent/sword/strike, /datum/intent/sword/chop)
	sellprice = 550

/obj/item/weapon/sword/long/pleonexia/pickup(mob/user)
	. = ..()

/obj/item/weapon/sword/long/pleonexia/dropped(mob/user, silent)
	. = ..()


// added as a spell
// blinks you through two tiles ( same as a leap ) ahead past windows but not walls / must have matthios' eyes ( be matthiosite)
// anyone caught in the blink gets a very short 1 second knock over
