//Legcuffs

/obj/item/restraints/legcuffs
	name = "leg cuffs"
	desc = ""
	gender = PLURAL
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "handcuff"
	flags_1 = CONDUCT_1
	throwforce = 0
	w_class = WEIGHT_CLASS_NORMAL
	slowdown = 7
	breakouttime = 30 SECONDS

/obj/item/restraints/legcuffs/beartrap
	icon = 'icons/roguetown/items/misc.dmi'
	name = "mantrap"
	gender = NEUTER
	throw_speed = 1
	throw_range = 1
	icon_state = "beartrap"
	desc = "A crude and old spring trap, used to snare interlopers, or prey on a hunt. Looks almost like it'll break at any moment."
	var/old = TRUE // Is it an old trap? Will most likely be destroyed if not handled right
	var/armed = FALSE // Is it armed?
	var/trap_damage = 90 // How much brute damage the trap will do to its victim
	var/used_time = 12 SECONDS // How many seconds it takes to disarm the trap
	max_integrity = 100
	grid_width = 64
	grid_height = 64

/obj/item/restraints/legcuffs/beartrap/attack_hand(mob/user)
	var/boon = user?.mind?.get_learning_boon(/datum/skill/craft/traps)
	if(iscarbon(user) && armed && isturf(loc))
		var/mob/living/carbon/C = user
		var/def_zone = "[(C.active_hand_index == 2) ? "r" : "l" ]_arm"
		var/obj/item/bodypart/BP = C.get_bodypart(def_zone)
		if(!BP)
			return FALSE
		if(C.stat_roll(STATKEY_LCK,5,10,TRUE))
			add_mob_blood(C)
			if(!BP.is_object_embedded(src))
				BP.add_embedded_object(src)
			close_trap()
			C.visible_message("<span class='boldwarning'>[C] triggers \the [src].</span>", \
					"<span class='userdanger'>I trigger \the [src]!</span>")
			C.emote("agony")
			C.Stun(80)
			BP.add_wound(/datum/wound/fracture)
			BP.update_disabled()
			C.apply_damage(trap_damage, BRUTE, def_zone, C.run_armor_check(def_zone, "stab", damage = trap_damage))
			C.update_sneak_invis(TRUE)
			C.consider_ambush()
			return FALSE
		else
			if(C.mind)
				used_time -= max((C.mind.get_skill_level(/datum/skill/craft/traps) * 2 SECONDS), 2 SECONDS)
			if(do_after(user, used_time, src))
				armed = FALSE
				anchored = FALSE
				update_icon()
				src.alpha = 255
				C.visible_message("<span class='notice'>[C] disarms \the [src].</span>", \
						"<span class='notice'>I disarm \the [src].</span>")
				C.mind?.adjust_experience(/datum/skill/craft/traps, C.STAINT * boon, FALSE)
				return FALSE
			else
				add_mob_blood(C)
				if(!BP.is_object_embedded(src))
					BP.add_embedded_object(src)
				close_trap()
				C.visible_message("<span class='boldwarning'>[C] triggers \the [src].</span>", \
						"<span class='userdanger'>I trigger \the [src]!</span>")
				C.emote("agony")
				BP.add_wound(/datum/wound/fracture)
				BP.update_disabled()
				C.apply_damage(trap_damage, BRUTE, def_zone, C.run_armor_check(def_zone, "stab", damage = trap_damage))
				C.update_sneak_invis(TRUE)
				C.consider_ambush()
				return FALSE
	..()

/obj/item/restraints/legcuffs/beartrap/attackby(obj/item/W, mob/user)
	if(W.force && armed)
		user.visible_message("<span class='warning'>[user] triggers \the [src] with [W].</span>", \
				"<span class='danger'>I trigger \the [src] with [W]!</span>")
		W.take_damage(20)
		close_trap()
		if(isliving(user))
			var/mob/living/L = user
			L.update_sneak_invis(TRUE)
			L.consider_ambush()
		return
	..()

/obj/item/restraints/legcuffs/beartrap/armed
	armed = TRUE
	anchored = TRUE // Pre mapped traps (bad mapping btw, don't) start anchored

/obj/item/restraints/legcuffs/beartrap/armed/camouflage
	armed = TRUE
	alpha = 80

/obj/item/restraints/legcuffs/beartrap/Initialize()
	. = ..()
	update_icon()

/obj/item/restraints/legcuffs/beartrap/update_icon()
	. = ..()
	icon_state = "[initial(icon_state)][armed]"

/obj/item/restraints/legcuffs/beartrap/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is sticking [user.p_their()] head in the [src.name]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	playsound(loc, 'sound/blank.ogg', 50, TRUE, -1)
	return (BRUTELOSS)

/obj/item/restraints/legcuffs/beartrap/attack_self(mob/user)
	..()
	var/boon = user?.mind?.get_learning_boon(/datum/skill/craft/traps)
	if(ishuman(user) && !user.stat && !user.restrained())
		var/mob/living/L = user
		if(do_after(user, (5 SECONDS) - (L.STASTR*2), user))
			if(prob(50 + (L.mind.get_skill_level(/datum/skill/craft/traps) * 10))) // 100% chance to set traps properly at Master trapping
				armed = TRUE // Impossible to use in hand if it's armed
				L.dropItemToGround(src) // We drop it instantly on the floor beneath us
				anchored = TRUE // And anchor it so that it can't be carried inside chests (prevents exploit)
				update_icon()
				src.alpha = 80 // Set lower visibility for everyone
				L.mind?.adjust_experience(/datum/skill/craft/traps, L.STAINT * boon, FALSE) // We learn how to set them better, little by little.
				to_chat(user, "<span class='notice'>I arm |the [src].</span>")
			else
				if(old)
					user.visible_message("<span class='warning'>The old [src.name] breaks under stress!</span>")
					playsound(src.loc, 'sound/foley/breaksound.ogg', 100, TRUE, -1)
					qdel(src)
				else
					user.visible_message("<span class='warning'>Curses! I couldn't keep [src.name] open tight enough!</span>")
					playsound(src.loc, 'sound/items/beartrap.ogg', 300, TRUE, -1)
					return

/obj/item/restraints/legcuffs/beartrap/proc/close_trap()
	armed = FALSE
	anchored = FALSE // Take it off the ground
	alpha = 255
	update_icon()
	playsound(src.loc, 'sound/items/beartrap.ogg', 300, TRUE, -1)

/obj/item/restraints/legcuffs/beartrap/Crossed(AM as mob|obj)
	if(armed && isturf(loc))
		if(isliving(AM))
			var/mob/living/L = AM
			var/snap = TRUE
			if(istype(L.buckled, /obj/vehicle))
				var/obj/vehicle/ridden_vehicle = L.buckled
				if(!ridden_vehicle.are_legs_exposed) //close the trap without injuring/trapping the rider if their legs are inside the vehicle at all times.
					close_trap()
					ridden_vehicle.visible_message("<span class='danger'>[ridden_vehicle] triggers \the [src].</span>")
					return ..()
			if(L.throwing)
				return ..()

			if(L.movement_type & (FLYING|FLOATING)) //don't close the trap if they're flying/floating over it.
				return ..()

			var/def_zone = BODY_ZONE_CHEST
			if(snap && iscarbon(L))
				var/mob/living/carbon/C = L
				if(C.mobility_flags & MOBILITY_STAND)
					def_zone = pick(BODY_ZONE_PRECISE_L_FOOT, BODY_ZONE_PRECISE_R_FOOT)
					var/obj/item/bodypart/BP = C.get_bodypart(def_zone)
					if(BP)
						add_mob_blood(C)
						if(!BP.is_object_embedded(src))
							BP.add_embedded_object(src)
						C.emote("agony")
				//BP.set_disabled(BODYPART_DISABLED_WOUND)
				// BP.add_wound(/datum/wound/fracture)
			else if(snap && isanimal(L))
				var/mob/living/simple_animal/SA = L
				if(SA.mob_size <= MOB_SIZE_TINY) //don't close the trap if they're as small as a mouse.
					snap = FALSE
			if(snap)
				close_trap()
				L.visible_message("<span class='danger'>[L] triggers \the [src].</span>", \
						"<span class='danger'>I trigger \the [src]!</span>")
				if(L.apply_damage(trap_damage, BRUTE, def_zone, L.run_armor_check(def_zone, "stab", damage = trap_damage)))
					L.Stun(80)
				L.consider_ambush()
	..()

// When craftable beartraps get added, make these the ones crafted.
/obj/item/restraints/legcuffs/beartrap/crafted
	old = FALSE
	desc = "Curious is the trapmaker's art. Their efficacy unwitnessed by their own eyes."
	smeltresult = /obj/item/ingot/iron
