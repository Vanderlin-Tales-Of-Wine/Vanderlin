

/datum/devotion/cleric_holder/proc/grant_spells_sohei(mob/living/carbon/human/H)
	if(!H || !H.mind)
		return

	var/datum/patron/A = H.patron
	var/list/spelllist = list(/obj/effect/proc_holder/spell/invoked/icebind, A.t0)
	for(var/spell_type in spelllist)
		if(!spell_type || H.mind.has_spell(spell_type))
			continue
		H.mind.AddSpell(new spell_type)
	level = CLERIC_T0
	max_devotion = 150




// =================================================================
// ========================		STATUS EFFECT	====================

//frozentomb

/datum/status_effect/abyssaltomb //Abyssor-followers should instantly break away from this coffin.
	id = "abyssor_frozen"
	status_type = STATUS_EFFECT_UNIQUE
	duration = -1
	examine_text = "You've been frozen within an abyssal tomb."
	alert_type = /atom/movable/screen/alert/status_effect/frozen
	var/obj/structure/abyssaltomb/tomb
	var/attempts = 0 // special feature that increases difficulty with each failed struggle attempt against the ice coffin. Or that's what I intended for it to be.

/atom/movable/screen/alert/status_effect/frozen
	name = "Abyssal Submission"
	desc = "Imprisoned by frozen tides, beneath the deep blue."
	icon_state = "intomb"
	icon = 'modular/stonekeep/kaizoku/icons/misc/screen_alert.dmi'

//Normal Freeze

/atom/movable/screen/alert/status_effect/debuff/freezing //the abyss is cold.
	name = "Abyssal Frostnip"
	desc = "<span class='boldwarning'>Frost-bitten and touched by the ancient god, seeping through time and existence. The god feels, spreads and carves your skin.</span>\n" //that's abyssor.
	icon_state = "freezing"
	icon = 'modular/stonekeep/kaizoku/icons/misc/screen_alert.dmi'

/atom/movable/screen/alert/status_effect/debuff/freezing/severe //the abyss is VERY cold.
	name = "Abyssal Frostbite"
	desc = "<span class='boldwarning'>It carries his touch, the cold for those who trespassed his domain. Ice crystals carves patterns upon where he gazes, the stare is on you.</span>\n" //that's abyssor.
	icon_state = "freezing_severe"
	icon = 'modular/stonekeep/kaizoku/icons/misc/screen_alert.dmi'

/datum/status_effect/debuff/freezing
	id = "freezing"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/freezing
	duration = 30 SECONDS
	effectedstats = list("speed" = -3, "endurance" = -2)

/datum/status_effect/debuff/freezing/tick()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.adjustOxyLoss(-6, 0) //it will actually allow you to breath underwater.
		if(prob(50))
			C.adjustFireLoss(2)
			C.Jitter(3)

/datum/status_effect/debuff/freezing/on_apply()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		to_chat(C, "<span class='info'>The frigid spike manifests supernatural cold within me.</span>")

/datum/status_effect/debuff/freezing/on_remove()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.remove_status_effect(/datum/status_effect/debuff/freezing)
		to_chat(C, "<span class='info'>I feel the suffocating cold vanishing, as body warmth returns to me.</span>")
// severe freezing

/datum/status_effect/debuff/freezing
	id = "freezing"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/freezing/severe
	duration = 30 SECONDS
	effectedstats = list("speed" = -5, "endurance" = -4, "strength" = -2)

/datum/status_effect/debuff/freezing/severe/on_apply()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		if(C.has_status_effect(/datum/status_effect/debuff/freezing))
			C.remove_status_effect(/datum/status_effect/debuff/freezing)
			to_chat(C, "<span class='info'>The biting cold intensified. Cold, abyssal tendrils roams and invades the surface of my skin.</span>")
		else
			to_chat(C, "<span class='info'>Torturous, carving frost upon my core! It reaches down into my spine in soul-rending agony!</span>")
		return ..()

/datum/status_effect/debuff/freezing/severe/on_remove()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.apply_status_effect(/datum/status_effect/debuff/freezing)// Allows transition from severe freezing to normal freezing. Your body is warming up.
		to_chat(C, "<span class='info'>The excruciating icy tendrils retreats, leaving behind a bone-chilling cold weighting upon my muscles.</span>")

/datum/status_effect/debuff/freezing/severe/tick()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.adjustOxyLoss(-6, 0) // Same underwater breathing
		if(prob(50))
			C.adjustFireLoss(4)
			C.Jitter(3)


// =================================================================
// =====================	STRUCTURE	============================

/obj/structure/frontierjustice
	name = "frontier justice"
	desc = "The manifestation extrajudicidal punishment by vigilantism, or performed by evil doers to instill fear. One may never know."
	icon = 	'modular/stonekeep/kaizoku/icons/mapset/frontierjustice.dmi'
	icon_state = "edgy1"
	anchored = TRUE
	density = FALSE
	opacity = 0
	blade_dulling = DULLING_CUT
	max_integrity = 50
	layer = ABOVE_OBJ_LAYER
	destroy_sound = 'sound/foley/bodyfall (1).ogg'

/obj/structure/frontierjustice/Initialize()
	. = ..()
	icon_state = "edgy[rand(1,5)]"

/obj/structure/frontierjustice/examine_status(mob/user)
	if(max_integrity)
		var/healthpercent = (obj_integrity/max_integrity) * 100
		switch(healthpercent)
			if(50 to 99)
				return  "The flesh is still in place."
			if(25 to 50)
				return  "Damage has set its toll."
			if(1 to 25)
				return  "<span class='warning'>The corpse is almost butchered.</span>"

/obj/structure/frontierjustice/Destroy()
	var/turf/T = loc
	if(isturf(T)) // Ensure `T` is a valid turf
		var/obj/item/reagent_containers/food/snacks/meat/steak/meat_piece = new(T)
		if(meat_piece)
			meat_piece.name = "humen meat" //funny
	. = ..()

/obj/structure/frontierjustice/dead
	name = "fated as you"
	desc = "Killed off and left to rot."
	icon_state = "dead1"
	destroy_sound = 'sound/combat/dismemberment/dismem (1).ogg'

/obj/structure/frontierjustice/dead/Initialize()
	. = ..()
	icon_state = "dead1" //had to put that otherwise OG frontier justice would kill it off

/obj/structure/frontierjustice/canibalism
	name = "the meal"
	desc = "Poor victim of the greenskins or wood elven."
	icon_state = "cannibalism1"
	destroy_sound = 'sound/combat/dismemberment/dismem (1).ogg'

/obj/structure/frontierjustice/canibalism/Initialize()
	. = ..()
	icon_state = "cannibalism[rand(1,2)]"

/obj/structure/frontierjustice/canibalism/Destroy()
	var/turf/T = loc
	if(isturf(T)) // Ensure `T` is a valid turf
		var/obj/item/reagent_containers/food/snacks/cooked/frysteak/meat_piece = new(T)
		if(meat_piece)
			meat_piece.name = "cooked humen meat" //funny
			meat_piece.desc = "A slab of manflesh, slow-cooked over glowing coals."
	. = ..()

/obj/structure/frontierjustice/crossed
	name = "believer"
	desc = "If one forgot the meaning of some religious symbols, surely this will remind them."
	icon_state = "crossed1"
	destroy_sound = 'sound/foley/breaksound.ogg'

/obj/structure/frontierjustice/crossed/Initialize()
	. = ..()
	icon_state = "crossed[rand(1,3)]"

/obj/structure/frontierjustice/caged
	name = "cage"
	desc = "Better check if someone is already inside, awaiting for salvation that never came."
	icon_state = "cage1"
	destroy_sound = 'sound/combat/hits/blunt/metalblunt (2).ogg'

/obj/structure/frontierjustice/caged/Initialize()
	. = ..()
	icon_state = "cage[rand(1,3)]"

/obj/structure/frontierjustice/caged/Destroy()
	. = ..()


// =================================================================
// ========================		TURF	============================

/turf/closed/wall/mineral/stone/abyssal
	name = "abyssal ishigaki wall"
	desc = "Made from large, interlocking uncut stones without the use of mortar, so a castle is built above it. However, many make simple walls out of it."
	icon = 	'modular/stonekeep/kaizoku/icons/wallset/abyssalstone.dmi'
	icon_state = "abyssabyssal"
	sheet_type = /obj/item/natural/stone
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onstone/wallhit.ogg', 'sound/combat/hits/onstone/wallhit2.ogg', 'sound/combat/hits/onstone/wallhit3.ogg')
	canSmoothWith = list(/turf/closed/wall/mineral/stone/abyssal)
	above_floor = /turf/open/floor/blocks
	baseturfs = list(/turf/open/floor/blocks)
	climbdiff = 1
	damage_deflection = 10

/turf/closed/wall/mineral/stone/abyssal/window
	name = "abyssal ishigaki window"
	desc = "An simple hole within a Ishigaki wall."
	opacity = FALSE
	max_integrity = 800

/turf/closed/wall/mineral/stone/window/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && ((mover.pass_flags & PASSTABLE) || (mover.pass_flags & PASSGRILLE)) )
		return 1
	return ..()

/turf/closed/wall/mineral/stone/abyssal/window/Initialize()
	. = ..()
	icon_state = "abyssal"
	var/mutable_appearance/M = mutable_appearance(icon, "abyssalhole", layer = ABOVE_NORMAL_TURF_LAYER)
	add_overlay(M)

/turf/closed/wall/mineral/wood/abyssal
	name = "wagoya wall"
	desc = "wooden wall of abyssal architecture that uses wooden joinery that fits together seamlessly to avoid use of nails or screws, increasing protection against earthshakes."
	icon = 	'modular/stonekeep/kaizoku/icons/wallset/eastern_wood.dmi'
	icon_state = "wood"
	break_sound = 'sound/combat/hits/onwood/destroywalldoor.ogg'
	attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')
	canSmoothWith = list(/turf/closed/wall/mineral/wood, /obj/structure/window, /obj/structure/roguetent, /turf/closed/wall/mineral/wooddark)
//	sheet_type = /obj/item/grown/log/tree/lumber
	above_floor = /turf/open/floor/woodturned
	baseturfs = list(/turf/open/floor/woodturned)
	neighborlay = "dirtedge"
	climbdiff = 3

/turf/closed/wall/mineral/wood/abyssal/window
	name = "wagoya no sama"
	desc = "A murderhole on a wooden wall that lacks nails and screws."
	opacity = FALSE
	max_integrity = 550

/turf/closed/wall/mineral/wood/abyssal/window/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && ((mover.pass_flags & PASSTABLE) || (mover.pass_flags & PASSGRILLE)) )
		return 1
	return ..()

/turf/closed/wall/mineral/wood/abyssal/window/Initialize()
	. = ..()
	var/mutable_appearance/M = mutable_appearance(icon, "woodhole", layer = ABOVE_NORMAL_TURF_LAYER)
	add_overlay(M)



// =================================================================
// ========================		SPELL	========================

/obj/effect/proc_holder/spell/invoked/lesser_heal/abyssal //for now just an abyssal version of the same spell, just with a different sprite. Placeholder.
	name = "Lesser Miracle"
	overlay_state = "purification"
	overlay_icon = 'modular/stonekeep/kaizoku/icons/misc/spells.dmi'
	action_icon_state = "spell0"
	action_icon = 'modular/stonekeep/kaizoku/icons/misc/spells.dmi'

/obj/effect/proc_holder/spell/invoked/icebind
	name = "Barotrauma Bind" //People faithful to Abyssor will instantly be released from this spell.
	overlay_state = "waternet"
	overlay_icon = 'modular/stonekeep/kaizoku/icons/misc/spells.dmi'
	chargedrain = 5
	releasedrain = 30
	recharge_time  = 50 SECONDS
	range = 8
	warnie = "aimwarn"
	movement_interrupt = FALSE
	sound = 'sound/magic/magic_nulled.ogg'
	action_icon_state = "spell0"
	action_icon = 'modular/stonekeep/kaizoku/icons/misc/spells.dmi'
	invocation_type = "none"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	recharge_time  = 60 SECONDS
	req_items = list(/obj/item/clothing/neck/psycross/silver/abyssanctum)
	devotion_cost = 45

/turf/open/proc/apply_ice_turf()
	var/prev_icon_state = icon_state //that code saves the original attributes of the turf to avoid a black void.
	icon_state = "ice"
	density = FALSE
	MakeSlippery(TURF_WET_PERMAFROST, min_wet_time = 100, wet_time_to_add = 5)
	spawn(100)
		if(icon_state == "ice")
			icon_state = prev_icon_state
			density = initial(density)

/obj/effect/proc_holder/spell/invoked/icebind/cast(list/targets, mob/living/user)
	if(!targets.len || !targets[1])
		to_chat(user, span_warning("<span class='userdanger'>Your spell fails to take hold, victimless.</span>"))
		return FALSE
	var/target = targets[1]

	if(isliving(target))
		var/mob/living/target_mob = target
		if(!target_mob.has_status_effect(/datum/status_effect/abyssaltomb))
			target_mob.apply_status_effect(/datum/status_effect/abyssaltomb)
			target_mob.visible_message("<span class='warning'>[target_mob] is sealed within a crystalline abyssal tomb!</span>")
		else
			to_chat(user, span_warning("<span class='userdanger'>Your target is already immobilized within a frigid tomb from the ocean!</span>"))
		return TRUE

	if(isturf(target))
		var/turf/open/T = target
		if(!isclosedturf(T))
			T.apply_ice_turf()
			to_chat(user, "<span class='warning'>Without a target, the ground becomes victim of the abyssal oppression.</span>")
			return TRUE
		else
			to_chat(user, "<span class='warning'>There is no space for a proper icespyre or cold to be settled.</span>")
			return FALSE

	to_chat(user, span_warning("<span class='userdanger'>Your spell fails to take hold, victimless.</span>"))
	return FALSE

/datum/status_effect/abyssaltomb/on_apply()
	tomb = new /obj/structure/abyssaltomb(get_turf(owner)) // Create the ice tomb, THEN move the victim inside
	tomb.encased_mob = owner
	if(istype(owner, /mob/living/carbon/human))
		tomb.buckle_mob(owner, TRUE, check_loc = FALSE)
		if(owner.patron && owner.patron.type == /datum/patron/divine/abyssor)
			to_chat(src, "<span class='debug'>Abyssor follower = no processing..</span>")
			tomb.processing = FALSE
		else
			to_chat(src, "<span class='debug'>Unbased person that don't follow abyssor, start to purify their ass.</span>")
			START_PROCESSING(SSobj, tomb) // Processing for non-Abyssor followers
	owner.forceMove(tomb) // Move the owner inside the tomb
	tomb.max_integrity = 300
	tomb.density = TRUE
	owner.visible_message("<span class='warning'>[owner] is encased in a crystalline tomb of ice.</span>")
	return ..()

/datum/status_effect/abyssaltomb/on_remove()
	if(tomb)
		tomb.unbuckle_all_mobs() //Avoid Qdelling the mob
		qdel(tomb)
	tomb = null
	return ..()

/obj/structure/abyssaltomb
	name = "abyssal tomb"
	desc = "A solid block of ice encasing a victim inside a pocket dimension deep on the ocean. One requires to break the coffin to be released from such depths."
	icon = 'modular/stonekeep/kaizoku/icons/misc/freezesprite.dmi'
	icon_state = "icespyre"
	density = TRUE
	max_integrity = 150
	buckle_lying = 0
	buckle_prevents_pull = 1
	layer = FLY_LAYER
	var/processing = TRUE
	var/last_attack
	var/mob/living/carbon/human/encased_mob

/obj/structure/abyssaltomb/Destroy()
	for(var/atom/movable/M in contents)
		M.forceMove(loc)
	if(encased_mob) // Use the linked mob reference
		encased_mob.remove_status_effect(/datum/status_effect/abyssaltomb)
	playsound(src, 'sound/combat/hits/onglass/glassbreak (2).ogg', 50, TRUE)
	return ..()

/obj/structure/abyssaltomb/process()
	to_chat(src, "<span class='debug'>Abyssal Tomb is processing properly.</span>")
	if(!has_buckled_mobs()) // If there are no mobs buckled, delete the tomb
		to_chat(src, "<span class='debug'>No buckled mobs found, deleting tomb.</span>")
		qdel(src)
		return
	for(var/mob/living/L in buckled_mobs)
		if(!iscarbon(L) || L.buckled != src)
			to_chat(src, "<span class='debug'>Invalid buckled mob detected, skipping.</span>")
			continue
		if(!last_attack) // Time tracking for damaging the buckled person
			last_attack = world.time
		var/barotrauma = 50 // 5 seconds for each
		if(world.time >= last_attack + barotrauma) // Pressure damage after enough time has passed
			last_attack = world.time
			src.visible_message("<span class='danger'>[src]'s crushing pressure squeezes [L] mercilessly!</span>")
			L.flash_fullscreen("whiteflash3")
			L.adjustBruteLoss(rand(10, 30))
			playsound(src, pick('modular/stonekeep/kaizoku/sound/spells/abyssalpressure.ogg','modular/stonekeep/kaizoku/sound/spells/abyssalpressure1.ogg','modular/stonekeep/kaizoku/sound/spells/abyssalpressure2.ogg'), 100, FALSE)
		if(L.stat == DEAD)
			src.visible_message("<span class='danger'>[L]'s squeezed body is now released after death.</span>")
			qdel(src)

/obj/structure/abyssaltomb/user_unbuckle_mob(mob/living/carbon/human/M, mob/living/carbon/human/user)
	if(obj_broken)
		..()
		return

	if(isliving(user))
		var/mob/living/L = user
		var/willpower = CLAMP((L.STAINT * 2 - 10), 1, 99)
		var/barotrauma_roll = rand(1, 100)
		to_chat(user, "<span class='debug'>DEBUG: willpower=[willpower], barotrauma_roll=[barotrauma_roll]; To be released, have more Willpower than Barotrauma</span>")

		if(processing == FALSE)
			to_chat(M, "<span class='info'>[M]'s purified body quickly breaks away from the abyssal tomb.</span>")
			M.remove_status_effect(/datum/status_effect/abyssaltomb)
			qdel(src)
			return

		user.changeNext_move(CLICK_CD_RAPID)
		if(user != M)
			if(barotrauma_roll <= willpower) //Freeing someone else.
				to_chat(user, "<span class='info'>Your body warmth releases [M]'s from the pocket dimension.</span>")
				to_chat(M, "<span class='info'>You feel [user]'s warmth as light comes over to your eyes.</span>")
				M.remove_status_effect(/datum/status_effect/abyssaltomb)
				if(processing == TRUE)
					STOP_PROCESSING(SSobj, src)
				qdel(src)
			else
				to_chat(user, "<span class='danger'>You try to free [M], but you hand ricochets.</span>")
				to_chat(M, "<span class='info'>[user] attempts to free you, but your world spins instead.</span>")
				M.Stun(40)
				shake_camera(M, 15, 1)
			return

		if(barotrauma_roll <= willpower) // Freeing themselves
			to_chat(M, "<span class='info'>You push the pressure towards itself, finally released from its grasp.</span>")
			src.visible_message("<span class='info'>[M] manages to break down the abyssal tomb!</span>")
			M.remove_status_effect(/datum/status_effect/abyssaltomb)
			if(processing == TRUE)
				STOP_PROCESSING(SSobj, src)
			qdel(src)
		else
			to_chat(user, "<span class='warning'>You struggle to break free of the tomb, but remain trapped.</span>")
			user.Stun(40)
			shake_camera(user, 15, 1)

///Purification///

/obj/effect/proc_holder/spell/invoked/projectile/purify
	name = "Purifying filter"
	overlay_state = "icespike"
	overlay_icon = 'modular/stonekeep/kaizoku/icons/misc/spells.dmi'
	action_icon_state = "spell0"
	action_icon = 'modular/stonekeep/kaizoku/icons/misc/spells.dmi'
	releasedrain = 50
	chargetime = 30
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	projectile_type = /obj/projectile/magic/purify
	chargedloop = null
	req_items = list(/obj/item/clothing/neck/psycross/silver/abyssanctum)
	sound = 'sound/magic/magic_nulled.ogg'
	invocation_type = "none"
	//invocation = "delivers sharp jabs and a sudden clap, unleashing a freezing shockwave that forms and launches a jagged ice spike."

	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	recharge_time  = 10 SECONDS
	devotion_cost = -45

/obj/projectile/magic/purify
	name = "purification"
	icon_state = "icespikeproj"
	icon = 'modular/stonekeep/kaizoku/icons/misc/spells.dmi'
	paralyze = 50
	damage = 0
	range = 7
	hitsound = 'sound/blank.ogg'
	nondirectional_sprite = TRUE
	impact_effect_type = /obj/effect/temp_visual/icespikeproj_projectile_impact //See if we can set it to be a projectile if CMODE, and a invocation if !CMODE

/obj/effect/temp_visual/icespikeproj_projectile_impact
	name = "purifying spike"
	icon = 'modular/stonekeep/kaizoku/icons/misc/spells.dmi'
	icon_state = "icespikeproj_break"
	layer = ABOVE_ALL_MOB_LAYER
	duration = 3

/obj/projectile/magic/purify/on_hit(atom/target, mob/living/user, blocked = FALSE)
	..()
	var/mob/living/carbon/C = target
	if(iscarbon(target))
		if(C.mob_biotypes & MOB_SPIRIT) // Abyssor's purifying filter absolutely destroys demonic essence.
			C.visible_message("<span class='info'>An otherworldly divine freeze encircles [target], filtering out their very existence!</span>", "<span class='notice'>My breath shallows- my ears rings, my senses overwhelmed with the crushing grip! I'M GOING TO IMPLODE FROM INSIDE OUT! PLEASE MERCY!</span>")
			C.adjustFireLoss(rand(50, 100)) //Random damage between 50 and 100. Very brutal, and proper for killing demons. Cold damage will come together with it after.
			C.Knockdown(40) //Purification successful. You will be paralyzed.
			C.Paralyze(1)
			C.apply_status_effect(/datum/status_effect/debuff/freezing/severe)
			C.flash_fullscreen("whiteflash3")
			return
		if((C.faction = "orcs") || (C.dna.species?.id == "tiefling") ||(HAS_TRAIT(C, TRAIT_NASTY_EATER ))) // Had to give them these ones because there's a bunch of different goblin IDs. So Trait will have to stay until I care about giving each a respective var.
			C.visible_message("<span class='danger'>[target]'s body is distorced by the crushing force of the abyssal waters!</span>", "<span class='userdanger'>I feel the suffocating pressure of the deep crushing my lungs!</span>")
			C.adjustFireLoss(rand(30, 50)) // 30 to 50 damage, less than full demons. More damage comes from freezing.
			C.Knockdown(20) //Purification successful. You will be paralyzed.
			C.Paralyze(1) // Creatures with demon essence from Apotheosis war gets the second end of the stick.
			C.apply_status_effect(/datum/status_effect/debuff/freezing/severe)
			C.flash_fullscreen("whiteflash3")
			return
		if(C.dna.species?.id == "abyssariad"||C.dna.species?.id == "aasimar") //Barely does anything to "Pure" creatures. This proves their 'divinity' and purity ingame.
			C.visible_message("<span class='danger'>[target]'s body shivers slightly, yet remains sturdy.</span>", "<span class='userdanger'>A cold travel down my spine, yet I feel little to no pain.</span>")
			C.adjustBruteLoss(rand(5, 15)) // 10 to 15 damage. Don't even bother attacking these. They will not be frozen either.
			return
		else //Does not paralyze.
			C.visible_message("<span class='danger'>[target]'s body is being crushed!</span>", "<span class='userdanger'>I feel a suffocating pressure building on my body!</span>")
			C.adjustFireLoss(rand(20, 35)) //Normal creatures will still suffer the effects of Barotrauma, yet less in terms of damage. Will still freeze.
			C.apply_status_effect(/datum/status_effect/debuff/freezing)
			C.flash_fullscreen("whiteflash3")
			return

////////NOT FINISHED YET//////////

/*
/obj/effect/proc_holder/spell/invoked/elemental //chooses attackable people by clicking on them.
	name = "Ice elemental"
	overlay_state = "waterspirit"
	overlay_icon = 'modular/stonekeep/kaizoku/icons/misc/spells.dmi'
	releasedrain = 30
	chargedrain = 4
	chargetime = 5
	range = 8
	warnie = "aimwarn"
	movement_interrupt = FALSE
	sound = 'modular/stonekeep/kaizoku/sound/spells/martialart_abyssanctum.ogg'
	action_icon_state = "spell0"
	action_icon = 'modular/stonekeep/kaizoku/icons/misc/spells.dmi'
	invocation_type = "emote"
	invocation = "punches and spins, unleashing a surge of freezing energy."
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = FALSE
	recharge_time  = 10 SECONDS



/obj/effect/proc_holder/spell/invoked/icebind/cast(list/targets, mob/living/user)
	if(!targets.len || !targets[1])
		to_chat(user, span_warning("<span class='userdanger'>Your spell fails to take hold, victimless.</span>"))
		return FALSE

	var/target = targets[1]

	if(isliving(target))
		var/mob/living/target_mob = target
		if(!target_mob.has_status_effect(/datum/status_effect/frozentomb))
			target_mob.apply_status_effect(/datum/status_effect/frozentomb)


/obj/effect/proc_holder/spell/invoked/icebind/cast(list/targets, mob/living/user, mob/living/carbon/human/H)
	if(!targets.len || !targets[1])
		to_chat(user, span_warning("<span class='userdanger'>Your spell fails to take hold, victimless.</span>"))
		return FALSE

	var/mob/living/target = targets[1]
	if(target.stat < DEAD)
		to_chat(user, "<span class='warning'>Nothing happens.</span>")
		return FALSE
	if(target != user)
		target.faction = "enemy" // You're targeted to DIE
		return TRUE

	if(isturf(target))
		var/turf/open/T = target
		if(!isclosedturf(T))
			new /mob/living/simple_animal/retaliate/purifier(target)
			to_chat(user, "<span class='warning'>You create an elemental to do your bidding.</span>")
			return FALSE
		else
			to_chat(user, "<span class='warning'>You cannot mark someone for purification or create an elemental here.</span>")
			return FALSE

/mob/living/simple_animal/retaliate/purifier
	name = "Abyssal Elemental"
	desc = "A creature which the presence damages "
	health = 300
	maxHealth = 300
	icon = 'modular/stonekeep/kaizoku/icons/misc/waterspirit.dmi'
	icon_state = "waterspirit"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	movement_type = GROUND
	speak_emote = list("roars")
	wander = TRUE
	del_on_death = TRUE
	deathmessage = "falls to the ground, decaying into glowing particles."
	deathsound = "bodyfall"
	footstep_type = FOOTSTEP_MOB_HEAVY
	turns_per_move = 3
	STACON = 15
	STASTR = 11
	STASPD = 12
	var/list/currently_affected = list()
	var/ticks_to_next_process = 3

/mob/living/simple_animal/retaliate/purifier/process()
	if(stat)
		return
	var/list/affected = hearers(7, src)
	var/to_fire = 5
	for(var/mob/living/A in affected)
		if(istype(A, /mob/living/carbon/human/species))
			if(A.stat != DEAD)
				A.adjustBruteLoss(rand(2,10))
				if(!--to_fire)
					return
		else if(istype(A, /mob/living/simple_animal/hostile))
			if(A.stat != DEAD)
				A.adjustBruteLoss(rand(2,10))
				if(!--to_fire)
					return

*/


