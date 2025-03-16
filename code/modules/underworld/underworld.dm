// Verbs
/mob/verb/returntolobby()
	set name = "{RETURN TO LOBBY}"
	set category = "Options"
	set hidden = 1

	if(key)
		GLOB.respawntimes[key] = world.time

	log_game("[key_name(usr)] respawned from underworld")

	to_chat(src, "<span class='info'>Returned to lobby successfully.</span>")

	if(!client)
		log_game("[key_name(usr)] AM failed due to disconnect.")
		return
	client.screen.Cut()
	client.screen += client.void
//	stop_all_loops()
	SSdroning.kill_rain(src.client)
	SSdroning.kill_loop(src.client)
	SSdroning.kill_droning(src.client)
	remove_client_colour(/datum/client_colour/monochrome)
	if(!client)
		log_game("[key_name(usr)] AM failed due to disconnect.")
		return

	var/mob/dead/new_player/M = new /mob/dead/new_player()
	if(!client)
		log_game("[key_name(usr)] AM failed due to disconnect.")
		qdel(M)
		return

	client?.verbs -= /client/proc/descend
	M.key = key
	qdel(src)
	return

// shit that eventually will need moved elsewhere
/obj/item/flashlight/flare/torch/lantern/shrunken
	name = "shrunken lamp"
	icon = 'icons/obj/lighting.dmi'
	icon_state = "shrunkenlamp"
	item_state = "shrunkenlamp"
	lefthand_file = 'icons/mob/inhands/equipment/mining_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/mining_righthand.dmi'
	desc = "A beacon."
	light_outer_range = 3.5			// luminosity when on
	light_power = 20
	light_color = LIGHT_COLOR_LIGHT_CYAN


/obj/structure/underworld/carriageman
	name = "The Carriageman"
	desc = "They will take the reigns and lead the way. But only if the price I can pay."
	icon = 'icons/roguetown/underworld/enigma_carriageman.dmi'
	icon_state = "carriageman"
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE_UPPER
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE

/obj/structure/underworld/carriageman/Initialize()
	. = ..()
	set_light(5, 4, 30, l_color = LIGHT_COLOR_BLUE)

/obj/structure/underworld/carriageman/attack_hand(mob/living/carbon/spirit/user)
	if(!user.paid)
		user << sound(pick('sound/misc/carriage1.ogg', 'sound/misc/carriage2.ogg', 'sound/misc/carriage3.ogg', 'sound/misc/carriage4.ogg'), 0, 0 ,0, 50)
		to_chat(user, "<br><font color=purple><span class='bold'>FETCH THE TOLL AND YOU MAY BOARD</span></font>")
	else
		to_chat(user, "<br><font color=purple><span class='bold'>HANDS EXCHANGE PAY, BE ON YOUR WAY</span></font>")
		user << sound(pick('sound/misc/carriage1.ogg', 'sound/misc/carriage2.ogg', 'sound/misc/carriage3.ogg', 'sound/misc/carriage4.ogg'), 0, 0 ,0, 50)

/obj/structure/underworld/carriageman/attackby(obj/item/W, mob/living/user)
	var/mob/living/carbon/spirit/ghost = user
	if(istype(W, /obj/item/underworld/coin))
		if(!ghost.paid)
			qdel(W)
			to_chat(ghost, "<br><font color=purple><span class='bold'>THE TOLL IS PAID, THROUGH THE CARRIAGE THE UNDERMAIDEN WAITS.</span></font>")
			user << sound(pick('sound/misc/carriage1.ogg', 'sound/misc/carriage2.ogg', 'sound/misc/carriage3.ogg', 'sound/misc/carriage4.ogg'), 0, 0 ,0, 50)
			ghost.paid = TRUE
			SSdeath_arena.remove_fighter(ghost)
			return
		if(ghost.paid)
			to_chat(ghost, "<br><font color=purple><span class='bold'>FURTHER PAYMENT WILL NOT CHANGE HER JUDGEMENT.</span></font>")
			user << sound(pick('sound/misc/carriage1.ogg', 'sound/misc/carriage2.ogg', 'sound/misc/carriage3.ogg', 'sound/misc/carriage4.ogg'), 0, 0 ,0, 50)
	else
		to_chat(ghost, "<br><font color=purple><span class='bold'>ONLY THE TOLL WILL I ACCEPT</span></font>")
		user << sound(pick('sound/misc/carriage1.ogg', 'sound/misc/carriage2.ogg', 'sound/misc/carriage3.ogg', 'sound/misc/carriage4.ogg'), 0, 0 ,0, 50)

/obj/structure/underworld/barrier //Blocks sprite locations
	name = "DONT STAND HERE"
	desc = "The Undermaiden awaits."
	icon = 'icons/roguetown/underworld/underworld.dmi'
	icon_state = "spiritpart"
	density = TRUE
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE

/obj/structure/underworld/carriage
	name = "Carriage"
	desc = "The Undermaiden awaits."
	icon = 'icons/roguetown/underworld/enigma_carriage.dmi'
	icon_state = "carriage_lit"
	layer = ABOVE_MOB_LAYER
	plane = GAME_PLANE_UPPER
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE


/obj/structure/underworld/carriage/Initialize()
	. = ..()
	set_light(5, 3, 30, l_color = LIGHT_COLOR_BLUE)

/obj/structure/underworld/carriage/attack_hand(mob/living/carbon/spirit/user)
	if(user.paid)
		switch(alert("Are you ready to be judged?",,"Yes","No"))
			if("Yes")
				playsound(user, 'sound/misc/deadbell.ogg', 50, TRUE, -2, ignore_walls = TRUE)
				add_abstract_elastic_data(ELASCAT_COMBAT, ELASDATA_COIN_REVIVES, 1)
				user.returntolobby()
			if("No")
				to_chat(user,span_notice("You delay fate."))
	else
		to_chat(user, "<B><font size=3 color=red>It's LOCKED.</font></B>")


/obj/structure/underworld/coinspawner
	name = "The Hand"
	desc = "A coin?"
	icon = 'icons/roguetown/underworld/enigma_husks.dmi'
	icon_state = "the_hand_c"
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE
	var/has_coin = TRUE

/obj/structure/underworld/coinspawner/attack_hand(mob/user)
	. = ..()
	if(has_coin && isroguespirit(user))
		on_activation(user)

/obj/structure/underworld/coinspawner/Crossed(atom/movable/AM)
	. = ..()
	if(has_coin && isroguespirit(AM))
		on_activation(AM)

/obj/structure/underworld/coinspawner/proc/on_activation(mob/living/carbon/spirit/fool)
	/* Re-enable if you ever make them respawn
	if(SSdeath_arena.tollless_clients[fool.client] <= (world.time + 5 MINUTES))
		to_chat(fool,span_notice("You can't seem to interact with \the [src] at this moment..."))
		return
		*/
	var/obj/item/underworld/coin/toll = new(get_turf(src))
	if(!GLOB.underworld_coinpull_locs.len)
		if(fool.put_in_hands(toll))
			to_chat(fool,span_notice("\The [src] puts \the [toll] in your hand..."))
		else
			to_chat(fool,span_notice("\The [src] drops \the [toll]..."))
			toll.forceMove(get_turf(fool))
		set_coin_taken()
		return
	var/turf/moveloc = pick(GLOB.underworld_coinpull_locs)
	fool.forceMove(moveloc)
	if(fool.put_in_hands(toll))
		to_chat(fool, span_alertwarning("\The [src] swiftly drags you under; but leaves you with \the [toll]!"))
	else
		to_chat(fool, span_alertwarning("\The [src] swiftly drags you under; but leaves \the [toll] at your feet!"))
	set_coin_taken()

/obj/structure/underworld/coinspawner/proc/set_coin_taken()
	has_coin = FALSE
	icon_state = "the_hand"
	desc = "A hand?"
	//addtimer(CALLBACK(src,TYPE_PROC_REF(/obj/structure/underworld/coinspawner,regenerate_coin)),20 MINUTES)

/obj/structure/underworld/coinspawner/proc/regenerate_coin()
	has_coin = TRUE
	icon_state = "the_hand_c"
	desc = "A coin?"

/obj/item/underworld/coin
	name = "The Toll"
	desc = "This is more than just a coin."
	icon = 'icons/roguetown/underworld/enigma_husks.dmi'
	icon_state = "soultoken_floor"

/obj/item/underworld/coin/pickup(mob/user)
	..()
	icon_state = "soultoken"

/obj/item/underworld/coin/dropped(mob/user)
	..()
	icon_state = "soultoken_floor"

// why not also some mob stuff too
/mob/living/simple_animal/hostile/dragger
	name = "dragger"
	desc = ""
	icon = 'icons/roguetown/underworld/enigma_dragger.dmi'
	icon_state = "dragger"
	icon_living = "dragger"
	icon_dead = "dragger_dead"
	mob_biotypes = MOB_UNDEAD|MOB_HUMANOID
	movement_type = FLYING
	environment_smash = ENVIRONMENT_SMASH_NONE
	pass_flags = PASSTABLE|PASSGRILLE
	base_intents = list(/datum/intent/simple/slash)
	gender = MALE
	speak_chance = 0
	turns_per_move = 5
	response_help_continuous = "passes through"
	response_help_simple = "pass through"
	maxHealth = 50
	health = 50
	layer = 16
	plane = 16
	spacewalk = TRUE
	stat_attack = UNCONSCIOUS
	robust_searching = 1
	speed = 1
	move_to_delay = 5 //delay for the automated movement.
	harm_intent_damage = 1
	obj_damage = 1
	melee_damage_lower = 15
	melee_damage_upper = 25
	attack_same = FALSE
	attack_sound = 'sound/combat/wooshes/bladed/wooshmed (1).ogg'
	dodge_sound = 'sound/combat/dodge.ogg'
	parry_sound = "sword"
	d_intent = INTENT_PARRY
	speak_emote = list("growls")
	limb_destroyer = 1
	del_on_death = TRUE
	TOTALLUC = 11
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	faction = list("undead")
	footstep_type = null
	defprob = 50 //decently skilled
	defdrain = 20
	canparry = TRUE
	retreat_health = null

/mob/living/simple_animal/hostile/dragger/electrocute_act(shock_damage, source, siemens_coeff = 1, flags = NONE)
	return FALSE

/mob/living/simple_animal/hostile/dragger/simple_limb_hit(zone)
	if(!zone)
		return ""
	switch(zone)
		if(BODY_ZONE_PRECISE_R_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_L_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_NOSE)
			return "head"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "head"
		if(BODY_ZONE_PRECISE_SKULL)
			return "head"
		if(BODY_ZONE_PRECISE_EARS)
			return "head"
		if(BODY_ZONE_PRECISE_NECK)
			return "neck"
		if(BODY_ZONE_PRECISE_L_HAND)
			return "hand"
		if(BODY_ZONE_PRECISE_R_HAND)
			return "hand"
		if(BODY_ZONE_PRECISE_L_FOOT)
			return "tail"
		if(BODY_ZONE_PRECISE_R_FOOT)
			return "tail"
		if(BODY_ZONE_PRECISE_STOMACH)
			return "body"
		if(BODY_ZONE_PRECISE_GROIN)
			return "body"
		if(BODY_ZONE_PRECISE_R_INHAND)
			return "body"
		if(BODY_ZONE_PRECISE_L_INHAND)
			return "body"
		if(BODY_ZONE_HEAD)
			return "head"
		if(BODY_ZONE_R_LEG)
			return "tail"
		if(BODY_ZONE_L_LEG)
			return "tail"
		if(BODY_ZONE_R_ARM)
			return "arm"
		if(BODY_ZONE_L_ARM)
			return "arm"
		if(BODY_ZONE_CHEST)
			return "chest"

	return ..()

/mob/living/simple_animal/hostile/dragger/taunted(mob/user)
	GiveTarget(user)
	return

/mob/living/simple_animal/hostile/dragger/Initialize()
	. = ..()
	set_light(2, 2, 2, l_color =  "#c0523f")
	ADD_TRAIT(src, TRAIT_IGNOREDAMAGESLOWDOWN, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOPAINSTUN, TRAIT_GENERIC)


/mob/living/simple_animal/hostile/dragger/death(gibbed)
	emote("death")
	..()

/mob/living/simple_animal/hostile/dragger/Life()
	. = ..()

/mob/living/simple_animal/hostile/dragger/get_sound(input)
	switch(input)
		if("laugh")
			return pick('sound/vo/mobs/ghost/laugh (1).ogg','sound/vo/mobs/ghost/laugh (2).ogg','sound/vo/mobs/ghost/laugh (3).ogg','sound/vo/mobs/ghost/laugh (4).ogg','sound/vo/mobs/ghost/laugh (5).ogg','sound/vo/mobs/ghost/laugh (6).ogg')
		if("moan")
			return pick('sound/vo/mobs/ghost/moan (1).ogg','sound/vo/mobs/ghost/laugh (2).ogg','sound/vo/mobs/ghost/laugh (3).ogg')
		if("death")
			return 'sound/vo/mobs/ghost/death.ogg'
		if("whisper")
			return pick('sound/vo/mobs/ghost/whisper (1).ogg','sound/vo/mobs/ghost/whisper (2).ogg','sound/vo/mobs/ghost/whisper (3).ogg')
		if("aggro")
			return pick('sound/vo/mobs/ghost/aggro (1).ogg','sound/vo/mobs/ghost/aggro (2).ogg','sound/vo/mobs/ghost/aggro (3).ogg','sound/vo/mobs/ghost/aggro (4).ogg','sound/vo/mobs/ghost/aggro (5).ogg','sound/vo/mobs/ghost/aggro (6).ogg')

/mob/living/simple_animal/hostile/dragger/AttackingTarget()
	. = ..()
	if(. && prob(8) && iscarbon(target))
		var/mob/living/carbon/C = target
		C.Immobilize(50)
		C.visible_message(span_danger("\The [src] paralyzes \the [C] in fear!"), \
				span_danger("\The [src] paralyzes me!"))
		emote("laugh")

/obj/effect/landmark/underworldsafe/Crossed(atom/movable/AM, oldloc)
	if(istype(AM, /mob/living/simple_animal/hostile/dragger))
		for(var/mob/living/carbon/human/A in view(4))
			to_chat(A, "The monster's form dematerializes as it nears the Carriage.")
		qdel(AM)
