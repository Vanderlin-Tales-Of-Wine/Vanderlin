/*	..................   Gaseous Form   ................... */
/mob/living/simple_animal/hostile/retaliate/gaseousform
	name = "gaseous mist"
	desc = ""
	icon = 'icons/mob/mob.dmi'
	icon_state = "mist"
	icon_living = "mist"
	mob_biotypes = MOB_SPIRIT
	speak_chance = 0
	turns_per_move = 5
	response_help_continuous = "passes through"
	response_help_simple = "pass through"
	a_intent = INTENT_HARM
	healable = 0
	speed = 0
	maxHealth = 40
	health = 40
	harm_intent_damage = 10
	melee_damage_lower = 15
	melee_damage_upper = 15
	del_on_death = 1
	emote_see = list("blows")
	attack_verb_continuous = "grips"
	attack_verb_simple = "grip"
	attack_sound = 'sound/blank.ogg'
	speak_emote = list("wails")
	deathmessage = "wails, disintegrating into a pile of ectoplasm!"
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = 1500
	movement_type = FLYING
	gold_core_spawnable = NO_SPAWN //too spooky for science
	var/random = TRUE //if you want random names for ghosts or not

/mob/living/simple_animal/hostile/retaliate/gaseousform/Initialize()
	. = ..()
	set_light(1, 1, 2)
	addtimer(CALLBACK(src, TYPE_PROC_REF(/mob/living/simple_animal/hostile/retaliate/gaseousform, revert), "VAMPIRE LORD"), 10 SECONDS)

/mob/living/simple_animal/hostile/retaliate/gaseousform/proc/revert()
	qdel()

/mob/living/simple_animal/hostile/retaliate/gaseousform/Move(NewLoc, direct)
	var/oldloc = loc

	if(NewLoc)
		var/NewLocTurf = get_turf(NewLoc)
		if(istype(NewLocTurf, /turf/closed/mineral/rogue/bedrock)) // prevent going out of bounds.
			return
		if(istype(NewLocTurf, /turf/closed/wall)) // gas can go through doors/windows but not walls
			return
		forceMove(NewLoc)
		update_parallax_contents()
	else
		forceMove(get_turf(src))  //Get out of closets and such as a ghost
		if((direct & NORTH) && y < world.maxy)
			y++
		else if((direct & SOUTH) && y > 1)
			y--
		if((direct & EAST) && x < world.maxx)
			x++
		else if((direct & WEST) && x > 1)
			x--

	Moved(oldloc, direct)





/obj/item/roguecoin/silver/pile/xylix/Initialize()
	. = ..()
	set_quantity(rand(6,9))

/obj/structure/spider/attacked_by(obj/item/I, mob/living/user) //Snipping action for webs, scissors turning webs into silk fast!
	var/snip_time = 50
	var/sewing_skill = user.mind.get_skill_level(/datum/skill/misc/sewing)
	var/amount = rand(1, 2)
	if(user.used_intent.type == /datum/intent/snip)
		snip_time = (50 - (sewing_skill * 10))
		if(!do_after(user, snip_time))
			return TRUE
		for(var/i = 1; i <= amount; i++)
			new /obj/item/natural/silk (get_turf(src))
		user.visible_message(span_notice("[user] snips [src] up into silk."))
		user.mind.add_sleep_experience(/datum/skill/misc/sewing, (user.STAINT / 2)) //We're getting experience for harvesting silk!
		playsound(src, 'sound/items/flint.ogg', 100, TRUE)
		qdel(src)
		return TRUE
	..()

/*	..................   Spider stuff   ................... */
/obj/structure/spider/stickyweb
	name = "web"
	icon = 'icons/roguetown/misc/webbing.dmi'
	icon_state = "stickyweb1"
	resistance_flags = FLAMMABLE
	alpha = 109
	max_integrity = 50
	opacity = TRUE

/obj/structure/spider/stickyweb/CanPass(atom/movable/mover, turf/target)
	if(isliving(mover))
		if(prob(50) && !HAS_TRAIT(mover, TRAIT_WEBWALK))
			to_chat(mover, "<span class='danger'>I get stuck in \the [src] for a moment.</span>")
			return FALSE
	else if(istype(mover, /obj/projectile))
		return prob(30)
	return TRUE

/obj/structure/spider/stickyweb/fire_act(added, maxstacks)
	visible_message("<span class='warning'>[src] catches fire!</span>")
	var/turf/T = get_turf(src)
	qdel(src)
	new /obj/effect/hotspot(T)

/obj/structure/spider/stickyweb/solo
	icon_state = "stickyweb3"

/obj/structure/spider/stickyweb/Initialize()
	if(icon_state == "stickyweb1")
		if(prob(50))
			icon_state = "stickyweb2"
	dir = pick(GLOB.cardinals)
	alpha = rand(80,109)
	switch(pick(1,2))
		if (1)
			static_debris = FALSE
		if (2)
			static_debris = list(/obj/item/natural/silk = 1)
	. = ..()

/obj/structure/spider/cocoon
	name = "cocoon"
	desc = ""
	icon = 'icons/effects/effects.dmi'
	icon_state = "cocoon1"
	max_integrity = 40

/obj/structure/spider/cocoon/container_resist(mob/living/user)
	var/breakout_time = 1 MINUTES
	user.changeNext_move(CLICK_CD_BREAKOUT)
	user.last_special = world.time + CLICK_CD_BREAKOUT
	to_chat(user, "<span class='notice'>I struggle against the tight bonds... (This will take about [DisplayTimeText(breakout_time)].)</span>")
	visible_message("<span class='notice'>I see something struggling and writhing in \the [src]!</span>")
	if(do_after(user, breakout_time, src))
		if(!user || user.stat != CONSCIOUS || user.loc != src)
			return
		qdel(src)

/obj/structure/spider/cocoon/Destroy()
	var/turf/T = get_turf(src)
	src.visible_message("<span class='warning'>\The [src] splits open.</span>")
	for(var/atom/movable/A in contents)
		A.forceMove(T)
	return ..()

/obj/structure/spider/cocoon/Initialize()
	switch(pick(1,2,3,4,5))
		if (1)
			static_debris = list(/obj/item/natural/silk = 3)
			icon_state = pick("cocoon1","cocoon2")
		if (2)
			static_debris = list(/obj/item/natural/silk = 2, /obj/effect/decal/remains/bigrat = 1)
			icon_state = pick("cocoon2","cocoon3")
		if (3)
			static_debris = list(/obj/item/natural/silk = 2, /obj/effect/decal/remains/human = 1)
			icon_state = pick("cocoon_large1","cocoon_large2","cocoon_large3")
		if (4)
			static_debris = list(/obj/item/natural/silk = 2, /obj/effect/decal/cleanable/blood/gibs = 1)
			icon_state = pick("cocoon1","cocoon2","cocoon3")
		if (5)
			static_debris = list(/obj/item/natural/silk = 2, /obj/item/natural/stone = 1)
			icon_state = pick("cocoon1","cocoon2")
	. = ..()



/*	..................   Various mapping aides   ................... */
/obj/machinery/light/rogue/wallfire/big_fireplace
	icon_state = "fireplace1"
	base_state = "fireplace"
	icon = 'icons/roguetown/misc/fireplace64.dmi'

/obj/machinery/light/rogue/hearth/big_fireplace
	name = "fireplace"
	icon_state = "fireplace1"
	base_state = "fireplace"
	icon = 'icons/roguetown/misc/fireplace64.dmi'
	fueluse = -1
	pixel_x = -16
	climb_offset = 4


/*	..................   Wizard Shenanigans   ................... */
/obj/structure/circle_protection
	name = "circle of protection"
	icon = 'icons/roguetown/misc/96x96.dmi'
	icon_state = "circle"
	alpha = 180
	pixel_y = -32
	pixel_x = -32
	var/wall_type = /obj/effect/forcefield/wizard
	var/depleted
/obj/structure/circle_protection/attack_hand(mob/user)
	. = ..()
	var/mob/living/carbon/human/H = user
	if(depleted)
		to_chat(user, "<span class='notice'>The salt circle has been damaged...</span>")
		return
	if(H.virginity)
		playsound(get_turf(user), 'sound/magic/timestop.ogg', 100, TRUE, -1)
		new wall_type(get_step(src, EAST),user)
		new wall_type(get_step(src, WEST),user)
		new wall_type(get_step(src, NORTH),user)
		new wall_type(get_step(src, SOUTH),user)

		new wall_type(get_step(src, NORTHEAST),user)
		new wall_type(get_step(src, NORTHWEST),user)
		new wall_type(get_step(src, SOUTHEAST),user)
		new wall_type(get_step(src, SOUTHWEST),user)

		depleted = TRUE
		alpha = 90
	else
		to_chat(user, "<span class='notice'>The magick forces are beyond your control.</span>")
/obj/structure/circle_protection/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/reagent_containers/powder/salt))
		to_chat(user, "<span class='notice'>Restoring the salt lines...</span>")
		if(do_after(user, 10 SECONDS, src))
			depleted = FALSE
			alpha = 180
			qdel(I)
	else
		return ..()


/*	..................   NOC Device (Fixed scrying ball)   ................... */
/obj/structure/nocdevice
	name = "NOC Device"
	desc = "A intricate lunar observation machine, that allows its user to study the face of Noc in the sky, reflecting he true whereabouts of hidden beings.."
	icon = 'icons/roguetown/misc/96x96.dmi'
	icon_state = "nocdevice"
	plane = -1
	layer = 4.2
	var/mob/current_owner
	var/last_scry
/obj/structure/nocdevice/attack_hand(mob/user)
	. = ..()
	var/mob/living/carbon/human/H = user
	if(H.virginity)
		if(world.time < last_scry + 30 SECONDS)
			to_chat(user, "<span class='warning'>I peer into the sky but cannot focus the lens on the face of Noc. Maybe I should wait.</span>")
			return
		var/input = stripped_input(user, "Who are you looking for?", "Scrying Orb")
		if(!input)
			return
		if(!user.key)
			return
		if(world.time < last_scry + 30 SECONDS)
			to_chat(user, "<span class='warning'>I peer into the sky but cannot focus the lens on the face of Noc. Maybe I should wait.</span>")
			return
		if(!user.mind || !user.mind.do_i_know(name=input))
			to_chat(user, "<span class='warning'>I don't know anyone by that name.</span>")
			return
		for(var/mob/living/carbon/human/HL in GLOB.human_list)
			if(HL.real_name == input)
				var/turf/T = get_turf(HL)
				if(!T)
					continue
				var/mob/dead/observer/screye/S = user.scry_ghost()
				if(!S)
					return
				S.ManualFollow(HL)
				last_scry = world.time
				user.visible_message("<span class='danger'>[user] stares into [src], [p_their()] squinting and concentrating...</span>")
				addtimer(CALLBACK(S, TYPE_PROC_REF(/mob/dead/observer, reenter_corpse)), 8 SECONDS)
				if(!HL.stat)
					if(HL.STAPER >= 15)
						if(HL.mind)
							if(HL.mind.do_i_know(name=user.real_name))
								to_chat(HL, "<span class='warning'>I can clearly see the face of [user.real_name] staring at me!.</span>")
								return
						to_chat(HL, "<span class='warning'>I can clearly see the face of an unknown [user.gender == FEMALE ? "woman" : "man"] staring at me!</span>")
						return
					if(HL.STAPER >= 11)
						to_chat(HL, "<span class='warning'>I feel a pair of unknown eyes on me.</span>")
				return
		to_chat(user, "<span class='warning'>I peer into the viewpiece, but Noc does not reveal where [input] is.</span>")
		return
	else
		to_chat(user, "<span class='notice'>Noc looks angry with me...</span>")


/*	..................   Floor decoration   ................... */
/obj/structure/giantfur
	name = "giant fur"
	desc = "Pelt of some gigantic animal, made into a mat."
	icon = 'icons/roguetown/misc/96x96.dmi'
	icon_state = "fur"
	density = FALSE
	anchored = TRUE

/obj/structure/giantfur/small // the irony
	name = "fur pelt"
	desc = "Pelt of a young animal, made into a mat."
	icon_state = "fur_alt"




/*	..................   Innocent Bush   ................... */
/obj/structure/innocent_bush
	name = "bush"
	desc = "These large bushes are known to be well-liked by silkworms who make their nests in their dark depths."
	icon = 'icons/roguetown/mob/monster/Trolls.dmi'
	icon_state = "Trolls"
	pixel_x = -16
	layer = ABOVE_ALL_MOB_LAYER
	max_integrity = 500
	density = TRUE

/obj/structure/innocent_bush/attack_hand(mob/living/carbon/human/user)
//	playsound(src.loc, "plantcross", 80, FALSE, -1)
//	user.visible_message(span_noticesmall("[user] searches through [src]."))
//	shake_camera(user, 2, 2)
	playsound(src, pick('sound/misc/jumpscare (1).ogg','sound/misc/jumpscare (2).ogg','sound/misc/jumpscare (3).ogg','sound/misc/jumpscare (4).ogg'), 100)
	new /mob/living/simple_animal/hostile/retaliate/rogue/trollbog (get_turf(src))
	qdel(src)

/obj/structure/innocent_bush/attackby(obj/item, /mob/living/user, params)
//	playsound(src.loc, "plantcross", 80, FALSE, -1)
	playsound(src, pick('sound/misc/jumpscare (1).ogg','sound/misc/jumpscare (2).ogg','sound/misc/jumpscare (3).ogg','sound/misc/jumpscare (4).ogg'), 100)
//	shake_camera(user, 2, 2)
	new /mob/living/simple_animal/hostile/retaliate/rogue/trollbog (get_turf(src))
	qdel(src)

/obj/structure/innocent_bush/Bumped(atom/movable/AM)
	playsound(src.loc, "plantcross", 80, FALSE, -1)
	playsound(src, pick('sound/misc/jumpscare (1).ogg','sound/misc/jumpscare (2).ogg','sound/misc/jumpscare (3).ogg','sound/misc/jumpscare (4).ogg'), 100)
	new /mob/living/simple_animal/hostile/retaliate/rogue/trollbog (get_turf(src))
	qdel(src)

/obj/structure/innocent_bush/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	playsound(src.loc, "plantcross", 80, FALSE, -1)
	sleep(4)
	playsound(src, pick('sound/misc/jumpscare (1).ogg','sound/misc/jumpscare (2).ogg','sound/misc/jumpscare (3).ogg','sound/misc/jumpscare (4).ogg'), 100)
	new /mob/living/simple_animal/hostile/retaliate/rogue/trollbog (get_turf(src))
	qdel(src)



/*	..................   Misc   ................... */
/obj/item/roguestatue/silver/gnome
	name = "petrified gnome"
	desc = "A literal gnome, turned to stone mid-step and put on a matching stone platform. Rather unsettling."
	smeltresult = null
	color = "#617163"
