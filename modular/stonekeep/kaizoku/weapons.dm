// =================================================================
// ========================		BOMBS	============================
/obj/item/grenade
	name = "grenade"
	desc = ""
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 1
	throw_range = 7
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	resistance_flags = FLAMMABLE
	max_integrity = 40
	var/active = 0
	var/det_time = 50
	var/display_timer = 1
	var/clumsy_check = GRENADE_CLUMSY_FUMBLE

/obj/item/grenade/suicide_act(mob/living/carbon/user)
	user.visible_message("<span class='suicide'>[user] primes [src], then eats it! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	playsound(src, 'sound/blank.ogg', 50, TRUE)
	preprime(user, det_time)
	user.transferItemToLoc(src, user, TRUE)//>eat a grenade set to 5 seconds >rush captain
	sleep(det_time)//so you dont die instantly
	return BRUTELOSS

/obj/item/grenade/deconstruct(disassembled = TRUE)
	if(!disassembled)
		prime()
	if(!QDELETED(src))
		qdel(src)

/obj/item/grenade/examine(mob/user)
	. = ..()
	if(display_timer)
		if(det_time > 0)
			. += "The timer is set to [DisplayTimeText(det_time)]."
		else
			. += "\The [src] is set for instant detonation."


/obj/item/grenade/attack_self(mob/user)
	if(!active)
		preprime(user)

/obj/item/grenade/proc/log_grenade(mob/user, turf/T)
	log_bomber(user, "has primed a", src, "for detonation")

/obj/item/grenade/proc/preprime(mob/user, delayoverride, msg = TRUE, volume = 60)
	var/turf/T = get_turf(src)
	log_grenade(user, T) //Inbuilt admin procs already handle null users
	if(user)
		if(msg)
			to_chat(user, "<span class='warning'>I prime [src]! [capitalize(DisplayTimeText(det_time))]!</span>")
	playsound(src, 'sound/blank.ogg', volume, TRUE)
	active = TRUE
	icon_state = initial(icon_state) + "_active"
	addtimer(CALLBACK(src, PROC_REF(prime)), isnull(delayoverride)? det_time : delayoverride)

/obj/item/grenade/proc/prime()

/obj/item/grenade/proc/update_mob()
	if(ismob(loc))
		var/mob/M = loc
		M.dropItemToGround(src)

/obj/item/grenade/attackby(obj/item/W, mob/user, params)
	if(!active)
		if(W.tool_behaviour == TOOL_MULTITOOL)
			var/newtime = text2num(stripped_input(user, "Please enter a new detonation time", name))
			if (newtime != null && user.canUseTopic(src, BE_CLOSE))
				if(change_det_time(newtime))
					to_chat(user, "<span class='notice'>I modify the time delay. It's set for [DisplayTimeText(det_time)].</span>")
					if (round(newtime * 10) != det_time)
						to_chat(user, "<span class='warning'>The new value is out of bounds. The lowest possible time is 3 seconds and highest is 5 seconds. Instant detonations are also possible.</span>")
			return
		else if(W.tool_behaviour == TOOL_SCREWDRIVER)
			if(change_det_time())
				to_chat(user, "<span class='notice'>I modify the time delay. It's set for [DisplayTimeText(det_time)].</span>")
	else
		return ..()

/obj/item/grenade/proc/change_det_time(time) //Time uses real time.
	. = TRUE
	if(time != null)
		if(time < 3)
			time = 3
		det_time = round(CLAMP(time * 10, 0, 50))
	else
		var/previous_time = det_time
		switch(det_time)
			if (0)
				det_time = 30
			if (30)
				det_time = 50
			if (50)
				det_time = 0
		if(det_time == previous_time)
			det_time = 50

/obj/item/grenade/attack_paw(mob/user)
	return attack_hand(user)

/obj/item/grenade/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	var/obj/projectile/P = hitby
	if(damage && attack_type == PROJECTILE_ATTACK && P.damage_type != STAMINA && prob(15))
		owner.visible_message("<span class='danger'>[attack_text] hits [owner]'s [src], setting it off! What a shot!</span>")
		var/turf/T = get_turf(src)
		log_game("A projectile ([hitby]) detonated a grenade held by [key_name(owner)] at [COORD(T)]")
		message_admins("A projectile ([hitby]) detonated a grenade held by [key_name_admin(owner)] at [ADMIN_COORDJMP(T)]")
		prime()
		return TRUE //It hit the grenade, not them

/obj/item/grenade/afterattack(atom/target, mob/user)
	. = ..()
	if(active)
		user.throw_item(target)


/obj/effect/particle_effect/smoke/bad/stupid
	lifetime = 20
	color = "#1b802c"
	opaque = FALSE

/obj/effect/particle_effect/smoke/bad/stupid/smoke_mob(mob/living/carbon/M)
	if(..())
		M.add_nausea(4)
		M.adjustToxLoss(5, 0)
		M.emote("cough")
		return 1

/datum/effect_system/smoke_spread/bad/stupid
	effect_type = /obj/effect/particle_effect/smoke/bad/stupid


/obj/item/grenade/smoke_bomb
	name = "abyssariad smokebomb"
	desc = "The stealth operation bomb made out of guano, sugar and nahcolite for shinobi usage."
	icon = 'modular/stonekeep/kaizoku/icons/weapons/32.dmi'
	icon_state = "smoke_bomb"
	item_state = "smoke_bomb"
	slot_flags = ITEM_SLOT_BELT

/obj/item/grenade/smoke_bomb/attack_self(mob/user)
	user.visible_message("<span class='warning'>[user]'s hand breaks the ceramic of the [src], releasing smoke!</span>", "<span class='notice'>I squeeze [src] down to release the inner compounds to the air.</span>")
	prime()

/obj/item/grenade/smoke_bomb/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	..()
	prime()

/obj/item/grenade/smoke_bomb/prime()
	update_mob()
	playsound(src, 'sound/blank.ogg', 50, TRUE, -3)
	var/datum/effect_system/smoke_spread/bad/smoke = new
	smoke.set_up(4, src)
	smoke.start()
	qdel(src)

/obj/item/grenade/smoke_bomb/poison
	name = "abyssariad poisonbomb"
	desc = "Ceramic sphere containing toxic composts from within, awaiting to be released."
	icon = 'modular/stonekeep/kaizoku/icons/weapons/32.dmi'
	icon_state = "poison_bomb"
	item_state = "poison_bomb"
	slot_flags = ITEM_SLOT_BELT

/obj/item/grenade/smoke_bomb/poison/attack_self(mob/user)
	user.visible_message("<span class='warning'>[user]'s hand breaks the ceramic of the [src], engulfing themselves on poisonous smoke.</span>", "<span class='notice'>I squeeze [src] down to release the inner compounds- like an IDIOT. RUN AWAY!</span>")
	prime()

/obj/item/grenade/smoke_bomb/poison/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	..()
	prime()

/obj/item/grenade/smoke_bomb/poison/prime()
	update_mob()
	playsound(src, 'sound/blank.ogg', 50, TRUE, -3)
	var/datum/effect_system/smoke_spread/bad/stupid/smoke = new
	smoke.set_up(4, src)
	smoke.start()
	qdel(smoke)
	qdel(src)

/obj/item/zhentianlei
	name = "thunder crash bomb"
	desc = "a bomb made out of cast iron and ceramic, now filled with gunpowder to the brim. Usually, it takes five second before the fire on the fuse reaches the gunpowder."
	icon_state = "zhentianlei"
	icon = 'modular/stonekeep/kaizoku/icons/weapons/32.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 0
	throw_speed = 0.5
	slot_flags = ITEM_SLOT_HIP

	var/lit = FALSE
	var/active = FALSE
	var/fuze = 50  // about five seconds
	var/turf/ignited_turf = null
	var/obj/item/ignited_by = null
	var/initial_icon_state = "zhentianlei"
	var/active_icon_state = "zhentianlei_rewinded"
	var/prob2fail = 23  // chance of failure

/obj/item/zhentianlei/spark_act()
	ignite()

/obj/item/zhentianlei/fire_act()
	ignite()

/obj/item/zhentianlei/ex_act()
	if(!QDELETED(src))
		lit = TRUE
		trigger_explosion(TRUE)

/obj/item/zhentianlei/New()
	..()
	icon_state = initial_icon_state

/obj/item/zhentianlei/proc/ignite(atom/igniter = null)
	if(!lit)
		START_PROCESSING(SSfastprocess, src)  // Start the processing for the fuse
		icon_state = active_icon_state
		lit = TRUE
		active = TRUE
		ignited_by = igniter
		playsound(src.loc, 'sound/items/firelight.ogg', 100)
		to_chat(src.loc, "<span class='warning'>The [name] starts to fizzle!</span>")
		if(ismob(src.loc))
			var/mob/M = src.loc
			M.update_inv_hands()

/obj/item/zhentianlei/proc/stop_ignition()
	if(lit)
		lit = FALSE
		active = FALSE
		STOP_PROCESSING(SSfastprocess, src)
		icon_state = initial_icon_state
		ignited_by = null
		playsound(src.loc, 'sound/items/firesnuff.ogg', 100)
		to_chat(src.loc, "<span class='notice'>\The [name] has been snuffed out.</span>")
		if(ismob(src.loc))
			var/mob/M = src.loc
			M.update_inv_hands()

/obj/item/zhentianlei/proc/trigger_explosion(skipprob = FALSE)
	STOP_PROCESSING(SSfastprocess, src)  // Stop the processing for the fuse
	var/turf/T = get_turf(src)
	if(T)
		if(lit && active)
			var/prob_fail = prob2fail
			if(ignited_by && istype(ignited_by, /obj/item))
				var/obj/item/igniter = ignited_by
				if(igniter.vars["prob2fail"])
					prob_fail = igniter.vars["prob2fail"]
			if(!skipprob && prob(prob_fail))
				stop_ignition()
			else
				explosion(T, light_impact_range = 2, flame_range = 4, smoke = TRUE, soundin = pick('sound/misc/explode/bottlebomb (1).ogg','sound/misc/explode/bottlebomb (2).ogg'))
		else
			if(prob(prob2fail))
				stop_ignition()
			else
				playsound(T, 'sound/items/firesnuff.ogg', 100)
				new /obj/effect/decal/cleanable/debris/clay (T)
	qdel(src)

/obj/item/zhentianlei/proc/is_flammable(atom/target)
	if(isturf(target))
		return (target.vars["flags"] & FLAMMABLE) != 0
	return FALSE

/obj/item/zhentianlei/process()
	if(active && lit)
		fuze -= 1
		if(fuze <= 0)
			trigger_explosion(TRUE)
	else if(active && !lit)
		stop_ignition()

/obj/item/zhentianlei/examine(mob/user)
	var/inspect_text = ..()
	if(active)
		inspect_text += "The fuse is burning!"
	else
		inspect_text += "The fuse is not lit."
	return inspect_text

/obj/item/zhentianlei/attackby(obj/item/C, mob/living/user)
	if(C.sharpness >= 1)
		if(fuze > 30)
			fuze = 30
			to_chat(user, "<span class='warning'>You shorten [src]'s fuse.</span>")
			playsound(src.loc, 'sound/items/sharpen_short2.ogg', 100)
		if(fuze == 0)
			to_chat(user, "<span class='danger'>The fuse is too small to be cut.</span>")
			return
		else
			fuze = 0
			to_chat(user, "<span class='danger'>You shorten [src]'s fuse, turning it into a booby trap!</span>")
			playsound(src.loc, 'sound/items/sharpen_short2.ogg', 100)
		return
	if(istype(C, /obj/item/natural/cloth))
		if(fuze < 30)
			fuze = 30
			to_chat(user, "<span class='danger'>You fully increase the [src]'s fuse with the cloth.</span>")
		else
			return


// =================================================================
// ========================		SHIELD	============================

/obj/item/weapon/shield/wood/rattan //The description about the firearm projectiles protection is actually real for this shield, pretty neat thing to include here. It won't change gamewise tho
	name = "rattan shield"
	desc = "A lightweight rattan shield woven with leather padding and hardened in oil, known for keeping shrapnel and firearm projectiles stuck after being shot at. \nIt can exceptionally block attacks but is more brittle than metal."
	icon = 'modular/stonekeep/kaizoku/icons/weapons/32.dmi'
	icon_state = "rattanshield"
	dropshrink = 0.8
	coverage = 50
	max_integrity = 150

/obj/item/weapon/shield/wood/rattan/attack_hand(mob/user)
		..()

/obj/item/weapon/shield/wood/rattan/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -5,"sy" = -1,"nx" = 6,"ny" = -1,"wx" = 0,"wy" = -2,"ex" = 0,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 1,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.6,"sx" = 1,"sy" = 4,"nx" = 1,"ny" = 2,"wx" = 3,"wy" = 3,"ex" = 0,"ey" = 2,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)

/obj/item/weapon/shield/tower/abyssaltower
	name = "abyssal towershield"
	desc = "The legendary shield frame named 'Naraku-kai no Tate', long used by Abyssariad champions in the old age against demonic incursions on Fog Islands. It has resemblance with Aasimar's tower shields, which was proper for the time."
	icon_state = "abyssaltower"
	icon = 'modular/stonekeep/kaizoku/icons/weapons/32.dmi'
	force = 15
	throwforce = 10
	throw_speed = 1
	throw_range = 3
	wlength = WLENGTH_NORMAL
	wbalance = -1 // Heavy, big shield
	resistance_flags = FLAMMABLE
	wdefense = 6
	coverage = 65
	parrysound = list('sound/combat/parry/shield/towershield (1).ogg','sound/combat/parry/shield/towershield (2).ogg','sound/combat/parry/shield/towershield (3).ogg')
	max_integrity = 300
	smeltresult = /obj/item/ingot/iron // Made with an iron ingot, let us recover it

/obj/item/weapon/shield/abyssaltower/dustcurse/dropped()
	. = ..()
	name = "Dustcurse abyssal towershield"
	minstr = 0 //asset solely to be used by NPCs. This will not be found on the hands of players.
	to_chat(src, "<span class='warning'>A haunting wind scatters [usr] into dust, sweeping it back to the ocean!</span>")
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/weapon/shield/tower/metal/abyssal
	name = "spiked steel aegis"
	desc = "Light steel spikes are visible on this shield to protect the user against the chaotic close-quarter skirmishes where grappling and flanking is common, but can be caught on enemy armor and weapons."
	icon_state = "aegis"
	icon = 'modular/stonekeep/kaizoku/icons/weapons/32.dmi'
	possible_item_intents = list(/datum/intent/shield/bash/metal, /datum/intent/shield/block/metal)
	force = 20
	throwforce = 10
	throw_speed = 1
	throw_range = 3
	wlength = WLENGTH_NORMAL
	resistance_flags = null
	flags_1 = CONDUCT_1
	wdefense = 7
	coverage = 70
	attacked_sound = list('sound/combat/parry/shield/metalshield (1).ogg','sound/combat/parry/shield/metalshield (2).ogg','sound/combat/parry/shield/metalshield (3).ogg')
	parrysound = list('sound/combat/parry/shield/metalshield (1).ogg','sound/combat/parry/shield/metalshield (2).ogg','sound/combat/parry/shield/metalshield (3).ogg')
	max_integrity = 500
	blade_dulling = DULLING_BASH
	sellprice = 30
	smeltresult = /obj/item/ingot/steel // Made with steel, let us repurpose it

/obj/item/weapon/shield/tower/metal/abyssal/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -5,"sy" = -1,"nx" = 6,"ny" = -1,"wx" = 0,"wy" = -2,"ex" = 0,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 1,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.6,"sx" = 1,"sy" = 4,"nx" = 1,"ny" = 2,"wx" = 3,"wy" = 3,"ex" = 0,"ey" = 2,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)
	return ..()

/obj/item/weapon/shield/tower/metal/attack_hand(mob/user)
		..()

/obj/item/weapon/shield/tower/metal/abyssal/dustcurse/dropped()
	. = ..()
	name = "Dustcurse spiked steel aegis"
	minstr = 0 //asset solely to be used by NPCs. This will not be found on the hands of players.
	to_chat(src, "<span class='warning'>A haunting wind scatters [usr] into dust, sweeping it back to the ocean!</span>")
	if(QDELETED(src))
		return
	qdel(src)


// =================================================================
// ========================		AXE		============================

/obj/item/weapon/axe/battle/ono
	slot_flags = ITEM_SLOT_HIP
	name = "nagai ono"
	desc = "A battleaxe of Abyssariad design with a longer handle and shorter blade than its Humen counterpart. The increased leverage, reduced weight, and smaller striking area give it greater use against armor, while the longer handle makes it easier to parry with."
	icon_state = "ono"
	parrysound = list('sound/combat/parry/wood/parrywood (1).ogg', 'sound/combat/parry/wood/parrywood (2).ogg', 'sound/combat/parry/wood/parrywood (3).ogg')
	minstr = 8
	icon = 'modular/stonekeep/kaizoku/icons/weapons/32.dmi'
	max_blade_int = 180
	max_integrity = INTEGRITY_STANDARD
	wdefense = GOOD_PARRY

/obj/item/weapon/axe/battle/ono/getonmobprop(tag)
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -12,"sy" = -10,"nx" = 12,"ny" = -10,"wx" = -8,"wy" = -7,"ex" = 3,"ey" = -9,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 90,"sturn" = -90,"wturn" = -90,"eturn" = 90,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.6,"sx" = -12,"sy" = 3,"nx" = 12,"ny" = 2,"wx" = -8,"wy" = 2,"ex" = 4,"ey" = 2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)
	return ..()

/obj/item/weapon/thrown/ono
	slot_flags = ITEM_SLOT_HIP
	force = 15
	possible_item_intents = list(/datum/intent/axe/cut, /datum/intent/axe/chop) //Added chop because the throwing Ono is still suitable for woodcutting. It's a hatchet.
	name = "nage ono"
	desc = "A well-balanced, short-handled Abyssariad axe designed for throwing. Traditionally used as a hunting weapon as an alternative to archery, as bow wood is scarce on the Fog Isles."
	icon = 'modular/stonekeep/kaizoku/icons/weapons/32.dmi'
	icon_state = "throwing_ono"
	max_blade_int = 500
	smeltresult = /obj/item/ash
	parrysound = list('sound/combat/parry/wood/parrywood (1).ogg', 'sound/combat/parry/wood/parrywood (2).ogg', 'sound/combat/parry/wood/parrywood (3).ogg')
	swingsound = BLADEWOOSH_MED
	wlength = WLENGTH_SHORT
	associated_skill = /datum/skill/combat/axesmaces
	minstr = 6
	max_blade_int = 200
	max_integrity = 300
	wdefense = 3
	throwforce = 40
	axe_cut = 5 //You'd be surprised to know that the axe head design for throwing is the same one for cutting wood, but lighter.
	embedding = list("embedded_pain_multiplier" = 3, "embed_chance" = 20, "embedded_fall_chance" = 60)

/obj/item/weapon/axe/iron/changfu
	name = "iron changfu"
	desc = "The tool of justice, hardwork and destruction, all in one."
	icon_state = "changfu"
	icon = 'modular/stonekeep/kaizoku/icons/weapons/32.dmi'
	wdefense = AVERAGE_PARRY
	axe_cut = 3 //Not as viable for cutting as the other one, less than a hatchet in fact.


// =================================================================
// ========================		MACE	============================

/obj/item/weapon/mace/goden/otsuchi
	force = 10
	force_wielded = 25
	possible_item_intents = list(/datum/intent/mace/strike)
	gripped_intents = list(/datum/intent/mace/strike/heavy, /datum/intent/mace/smash/heavy)
	name = "otsuchi"
	desc = "A wooden greathammer of Abyssariad make, heavy enough to give any warrior pause. Often used by Yamabushi warriors."
	icon_state = "otsuchi"
	icon = 'modular/stonekeep/kaizoku/icons/weapons/64.dmi'
	sharpness = IS_BLUNT
	wlength = WLENGTH_GREAT
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	associated_skill = /datum/skill/combat/axesmaces
	smeltresult = /obj/item/ash
	swingsound = BLUNTWOOSH_HUGE
	max_integrity = 250
	minstr = 10
	wdefense = 3
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	gripsprite = TRUE

/obj/item/weapon/mace/goden/kanabo
	name = "kanabo"
	desc = "A heavy two handed club, reinforced with an iron sleeve. Most commonly seen in the hands of Onis and Yamabushis."
	icon_state = "kanabo"
	possible_item_intents = list(/datum/intent/mace/strike/heavy)
	gripped_intents = list(/datum/intent/mace/smash/heavy) //Can't spear people, but can make them bleed due to spikes.
	sharpness = IS_SHARP
	icon = 'modular/stonekeep/kaizoku/icons/weapons/64.dmi'
	parrysound = "parrywood"
	swingsound = BLUNTWOOSH_MED
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	gripsprite = TRUE
	slowdown = 1

/obj/item/weapon/mace/goden/kanabo/dustcurse/dropped()
	. = ..()
	name = "Dustcurse kanabo"
	to_chat(src, "<span class='warning'>A haunting wind scatters [usr] into dust, sweeping it back to the ocean!</span>")
	minstr = 0 //asset solely to be used by NPCs. This will not be found on the hands of players.
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/weapon/mace/goden/steel/tetsubo
	name = "tetsubo"
	desc = "A heavier variant of the kanabo, fitted with a steel sleeve bearing menacing spikes and favored by Ogrun Warlords. Requires immense strength to use, but hits like a raging bull."
	icon_state = "tetsubo"
	possible_item_intents = list(/datum/intent/mace/strike/heavy)
	gripped_intents = list(/datum/intent/mace/smash/heavy) //Can't spear people, but can make them bleed due to spikes.
	sharpness = IS_SHARP
	icon = 'modular/stonekeep/kaizoku/icons/weapons/64.dmi'
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64

/obj/item/weapon/mace/goden/steel/tetsubo/dustcurse/dropped()
	. = ..()
	name = "Dustcurse tetsubo"
	minstr = 0 //asset solely to be used by NPCs. This will not be found on the hands of players.
	to_chat(src, "<span class='warning'>A haunting wind scatters [usr] into dust, sweeping it back to the ocean!</span>")
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/weapon/mace/ararebo
	name = "ararebo"
	icon = 'modular/stonekeep/kaizoku/icons/weapons/32.dmi'
	icon_state = "ararebo"
	desc = "A large, iron-capped club used by Abyssariads as a armor-breaking tool. Most suitable to breach Grezenholftean cuirass while still holding a shield in the off-hand."

/obj/item/weapon/mace/ararebo/dustcurse/dropped()
	. = ..()
	name = "Dustcurse ararebo"
	to_chat(src, "<span class='warning'>A haunting wind scatters [usr] into dust, sweeping it back to the ocean!</span>")
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/weapon/mace/ararebo/obsidian
	name = "obsidian club"
	icon_state = "obsidian_club"
	desc = "A large, wooden club with sharp flakes of obsidian embedded into it. Its appearance is similar to a flanged mace, but it inflicts deep cuts."
	max_integrity = 150
	wlength = WLENGTH_SHORT
	w_class = WEIGHT_CLASS_NORMAL
	sharpness = IS_SHARP
	wbalance = -1
	minstr = 0
	wdefense = 3

/obj/item/weapon/mace/steel/ararebo
	name = "steel ararebo"
	icon = 'modular/stonekeep/kaizoku/icons/weapons/32.dmi'
	icon_state = "sararebo"
	desc = "A large, steel-capped club used by Abyssariads as a armor-breaking tool. Most suitable to breach Grezenholftean cuirass while still holding a shield in the off-hand."

/obj/item/weapon/mace/steel/ararebo/dustcurse/dropped()
	. = ..()
	name = "Dustcurse steel ararebo"
	to_chat(src, "<span class='warning'>A haunting wind scatters [usr] into dust, sweeping it back to the ocean!</span>")
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/weapon/mace/cudgel/rungu
	force = 15
	force_wielded = 20
	name = "rungu club"
	desc = "A more well defined, chiseled and ashed wooden club that can be throw at enemies. Used by Undine warriors."
	icon_state = "rungu"
	icon = 'modular/stonekeep/kaizoku/icons/weapons/32.dmi'
	wbalance = 0
	wdefense = 1
	wlength = WLENGTH_NORMAL
	w_class = WEIGHT_CLASS_NORMAL
	max_integrity = 150
	possible_item_intents = list(/datum/intent/mace/strike/wood)
	gripped_intents = list(/datum/intent/mace/strike/wood, /datum/intent/mace/smash/wood)
	smeltresult = /obj/item/ash
	minstr = 0
	throwforce = 25

/obj/item/weapon/mace/cudgel/jitte
	name = "jitte"
	desc = "An abyssariad Ashigaru guard weapon. The hook along the shaft allows the club to arrest a blade that has been parried, increasing the defensive utility of a otherwise simple baton."
	icon = 'modular/stonekeep/kaizoku/icons/weapons/32.dmi'
	icon_state = "jitte"
	wdefense = 4


// =================================================================
// ========================		FLAIL	============================

/datum/intent/flail/cut
	name = "cut"
	blade_class = BCLASS_CUT
	attack_verb = list("cuts", "slashes")
	hitsound = list('sound/combat/hits/blunt/flailhit.ogg')
	swingdelay = 5
	penfactor = AP_AXE_CHOP
	icon_state = "incut"
	misscost = 5
	reach = 2
	recovery = 10
	chargedloop = /datum/looping_sound/flailswing
	keep_looping = TRUE
	chargetime = 5
	no_early_release = TRUE

/datum/intent/flail/cut/chop
	name = "chop"
	chargetime = 5
	no_early_release = TRUE
	penfactor = AP_FLAIL_SMASH
	recovery = 10
	damfactor = 1.2
	chargedloop = /datum/looping_sound/flailswing
	keep_looping = TRUE
	icon_state = "inchop"
	blade_class = BCLASS_CHOP
	attack_verb = list("chops")
	hitsound = list('sound/combat/hits/blunt/flailhit.ogg')
	misscost = 10
	chargetime = 10


/obj/item/weapon/flail/sflail/kusarifundo
	name = "kusari fundo"
	icon = 'modular/stonekeep/kaizoku/icons/weapons/32.dmi'
	desc = "A pair of heavy steel weights connected by a long chain. Originally a self-defense weapon during the Blood Apotheosis when iron was running low - so lead balls were used as weight."
	icon_state = "kusarifundo"

/obj/item/weapon/flail/nunchaku
	force = 20
	w_class = WEIGHT_CLASS_SMALL
	name = "nunchaku"
	icon = 'modular/stonekeep/kaizoku/icons/weapons/32.dmi'
	desc = "A pair of wooden rods linked by a short chain, designed for concealment and often used by Abyssariad Plowmen- for where swords was only on the hands of the Zamurai caste."
	icon_state = "nunchaku"

/obj/item/weapon/flail/kusarigama
	possible_item_intents = list(/datum/intent/flail/strike, /datum/intent/flail/strike/smash, /datum/intent/flail/cut, /datum/intent/flail/cut/chop)
	name = "kusarigama"
	desc = "A handle with a sickle-like blade, featuring a chain that ends in a spiked ball. Versatile weapon adapted to defeat sword-wielding foes."
	icon_state = "kusarigama"
	icon = 'modular/stonekeep/kaizoku/icons/weapons/32.dmi'
	sharpness = IS_SHARP
	blade_dulling = DULLING_BASHCHOP
	smeltresult = /obj/item/ingot/steel
	parrysound = list('sound/combat/parry/parrygen.ogg')
	swingsound = BLUNTWOOSH_MED

/obj/item/weapon/flail/kusarigama/peasant
	force = DAMAGE_WEAK_FLAIL
	name = "handmade kusarigama"
	desc = "A handle with a sickle-like blade and a chain with spiked ball, quickly assembled from an actual plowmen's sickle - it is clearly homemade."
	icon_state = "kusarigama_homemade"
	smeltresult = /obj/item/ingot/iron



// =================================================================
// ========================		KNIFE	============================

/obj/item/weapon/huntingknife/kunai //Practically a villager knife with more utility. It helps others to climb walls.
	name = "kunai"
	desc = "A simple stabbing weapon made of iron which originated as a masonry or gardening tool, useful for climbing walls in similar ways to pitons."
	icon = 'modular/stonekeep/kaizoku/icons/weapons/32.dmi'
	icon_state = "kunai"
	force = 8

/obj/item/weapon/knife/kaiken
	name = "iron kaiken"
	desc = "The weapon laws in colonized Abyssariad islands, with high humen or elven population, forbade non-warriors from carrying blades in public, so abyssariad colonists made weapons such as this."
	icon = 'modular/stonekeep/kaizoku/icons/weapons/32.dmi'
	icon_state = "kaiken"
	possible_item_intents = list(/datum/intent/dagger/thrust, /datum/intent/dagger/cut)
	force = DAMAGE_DAGGER
	smeltresult = null
	sellprice = 15

/obj/item/weapon/knife/steel/tanto
	name = "steel tanto"
	desc = "Initially a companion blade to the tachi in a zamurai's daisho, the tanto was later replaced by the wakizashi with the shift to infantry tactics after the Bloody Apotheosis."
	icon = 'modular/stonekeep/kaizoku/icons/weapons/32.dmi'
	icon_state = "tanto"
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/dagger/thrust, /datum/intent/dagger/chop)
	force = DAMAGE_DAGGER+2
	smeltresult = null
	wdefense = AVERAGE_PARRY
	wbalance = VERY_HARD_TO_DODGE
	sellprice = 20

/obj/item/weapon/knife/hunting/sai //I love gundam for helping me on my request on this sai. I love HIM!!!!!!!!!!!!! -Monochrome
	name = "sai"
	desc = "Recognizable by its uniqueness and typically carried in pairs, the sai features a sharply-tapered central rod with two prongs at the cross-guards. It lacks blade for cutting, but it excels in jabbing and defending against other weapons."
	icon = 'modular/stonekeep/kaizoku/icons/weapons/32.dmi'
	icon_state = "sai"
	possible_item_intents = list(/datum/intent/dagger/thrust)
	w_class = WEIGHT_CLASS_NORMAL
	force = 10
	wdefense = 5


// =================================================================
// ========================		POLEARM	============================

/*-----------\
| Mancatching |
\-----------*/

/datum/intent/polearm/thrust/mancatcher //giving it pain, because it having a 'struggle system' to endure stun was a bit too much.
	name = "grabbing thrust"
	blade_class = BCLASS_STAB
	attack_verb = list("stabs")
	animname = "grab"
	icon_state = "ingrab"
	reach = 2
	chargetime = 10
	warnie = "mobwarning"
	hitsound = list('sound/combat/hits/bladed/genstab (1).ogg', 'sound/combat/hits/bladed/genstab (2).ogg', 'sound/combat/hits/bladed/genstab (3).ogg')
	damfactor = 0.5
	candodge = FALSE
	penfactor = 100
	swingdelay = 1
	misscost = 10


/obj/item/weapon/polearm/mancatcher
	force = 10
	force_wielded = 20
	possible_item_intents = list(POLEARM_BASH)
	gripped_intents = list(POLEARM_BASH,MANCATCHER)
	name = "sasumata"
	desc = "A unique polearm featuring a spring-action pincer on the end, lined with spikes designed to cause extreme pain, rather than extreme injury. Referred to as a man-catcher in the Humen tongue due to coastal kidnappings performed by abyssariad Wokous."
	icon_state = "sasumata"
	icon = 'modular/stonekeep/kaizoku/icons/weapons/64.dmi'
	wlength = WLENGTH_GREAT
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	blade_dulling = DULLING_BASHCHOP
	walking_stick = TRUE
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	max_blade_int = 120
	max_integrity = 200
	wdefense = 5
	bigboy = TRUE
	gripsprite = TRUE
	associated_skill = /datum/skill/combat/polearms
	walking_stick = TRUE
	embedding = list(
		"embed_chance" = 75,
		"embedded_pain_multiplier" = 10,
		"embedded_fall_chance" = 0,
	)

/obj/item/weapon/polearm/spear/yari
	name = "su yari"
	desc = "A long, straight-headed spear of Abyssariad design, often used by sea raiders to fend off light cavalry on in-land offensives. Well know for the 'Yari wall' strategy and for being 'Yarimazing' among Abyssariads."
	icon_state = "suyari"
	icon = 'modular/stonekeep/kaizoku/icons/weapons/64.dmi'
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	gripsprite = TRUE
	smeltresult = /obj/item/ingot/iron
	dropshrink = 0.8
	blade_dulling = DULLING_BASHCHOP

/obj/item/weapon/polearm/spear/yari/katakama
	name = "katakama yari"
	desc = "An evolution of the su yari, recognizable for a single scythe-like tang perpendicular to the main point that allows for better defense against the likes of naginata."
	icon_state = "katakamayari"
	wdefense = 5
	smeltresult = /obj/item/ingot/iron
	max_blade_int = 150
	max_integrity = 400

/obj/item/weapon/polearm/spear/billhook/jumonji
	name = "jumonji yari"
	desc = "The design of the katakama yari taken to its logical conclusion, the jumonji yari features an elongated tang on each side that is the same length as the forward point. There is no polearms that offers better defense without harming efficiency."
	icon_state = "jumonjiyari"

/obj/item/weapon/polearm/halberd/bardiche/naginata
	name = "naginata"
	desc = "Its earliest form being a tachi blade mounted upon a long wooden pole, the naginata was the first polearm to come into widespread use by the Abyssariad, who developed the weapon in order to better combat Humen and Elven cavalry."
	icon = 'modular/stonekeep/kaizoku/icons/weapons/64.dmi'
	icon_state = "naginata"
	dropshrink = 0.8

/obj/item/weapon/polearm/halberd/bardiche/naginata/dustcurse/dropped()
	. = ..()
	name = "Dustcurse naginata"
	minstr = 0 //asset solely to be used by NPCs. This will not be found on the hands of players.
	to_chat(src, "<span class='warning'>A haunting wind scatters [usr] into dust, sweeping it back to the ocean!</span>")
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/weapon/polearm/halberd/bardiche/naginata/tsukushi //make two instead of only one
	name = "tsukushi naginata"
	desc = "A cheaper, easier to construct iron Naginata with a blade held by its guard instead of its tang. Likely developed from a scythe, the blade is easily found on poor, wandering monks."
	force_wielded = DAMAGE_SPEAR_WIELD+3
	icon_state = "surplusnaginata"
	smeltresult = /obj/item/ingot/iron
	dropshrink = 0.8
	wdefense = 4
	slot_flags = ITEM_SLOT_BACK

/obj/item/weapon/polearm/halberd/bisento //Giving the Bisento storeable 'back' because, otherwise, people will SUFFER spawning with it. Too bugged for my taste.
	name = "bisento"
	desc = "The Bisento is the direct evolution of the old, outdated Champion Guandao. Akin to a large cleaver or a broad axe."
	icon_state = "bisento"
	dropshrink = 0.8
	icon = 'modular/stonekeep/kaizoku/icons/weapons/64.dmi'

/obj/item/weapon/polearm/halberd/bisento/dustcurse/dropped()
	. = ..()
	name = "Dustcurse bisento"
	minstr = 0 //asset solely to be used by NPCs. This will not be found on the hands of players.
	to_chat(src, "<span class='warning'>A haunting wind scatters [usr] into dust, sweeping it back to the ocean!</span>")
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/weapon/polearm/spear/stone/obsidian //direct upgrade to the stone one.
	force = DAMAGE_SPEAR+2
	force_wielded = DAMAGE_SPEAR+4
	throwforce = DAMAGE_SPEAR
	name = "obsidian spear"
	desc = "A spear with a surprisingly sharp edge from vulcanic glass. Used by Undine tribes."
	icon_state = "obsidian_spear"
	icon = 'modular/stonekeep/kaizoku/icons/weapons/64.dmi'
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	smeltresult = /obj/item/ash
	max_blade_int = 100

/obj/item/weapon/polearm/woodstaff/quarterstaff/bostaff
	name = "bo staff"
	desc = "the bo, or 'abyssariad quarterstaff', is a simple weapon used in martial arts to entrap, strike and sweep the enemy."
	icon_state = "bostaff"
	icon = 'modular/stonekeep/kaizoku/icons/weapons/64.dmi'
	bigboy = TRUE

/obj/item/weapon/polearm/firelance
	name = "sanctiflux firelance"
	desc = "The new iteration of the ancient abyssariad 'Widowmaker', the harbinger of purification against zizodemons, tieflings and grezenhoft. \
	Used safely by the hundred thousand march, by hands whom holds purifying intentions from the abyss." //Hundred thousand march is the definition of champions. But after bloody apotheosis, its just anyone islander-cultured.
	icon = 'modular/stonekeep/kaizoku/icons/weapons/firelance.dmi'
	icon_state = "firelance"
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	can_parry = TRUE
	wlength = WLENGTH_GREAT
	bigboy = TRUE
	gripsprite = FALSE
	resistance_flags = FLAMMABLE // Weapon made mostly of wood
	max_integrity = INTEGRITY_STANDARD
	minstr = 8
	smeltresult = /obj/item/ingot/steel
	associated_skill = /datum/skill/combat/polearms
	drop_sound = 'sound/foley/dropsound/wooden_drop.ogg'
	parrysound = list('sound/combat/parry/wood/parrywood (1).ogg', 'sound/combat/parry/wood/parrywood (2).ogg', 'sound/combat/parry/wood/parrywood (3).ogg')
	dropshrink = 0.8
	blade_dulling = DULLING_BASHCHOP
	walking_stick = TRUE
	wlength = WLENGTH_LONG
	sharpness = IS_BLUNT
	minstr = 8
	sellprice = 400

	var/cocked = FALSE
	var/lit = FALSE
	var/range = 5
	var/fuel_source = FALSE
	var/fuze = 30

/obj/item/weapon/polearm/firelance/proc/ignite(mob/living/user)
	if(lit)
		to_chat(user.loc, "<span class='warning'>The Firelance's fuse is already ignited and fierce as a bull.</span>")
		return

	if(!fuel_source)
		to_chat(user.loc, "<span class='warning'>You cannot burn your enemies without a gourd with sanctiflux.</span>")
		return

	to_chat(src.loc, "<span class='info'>The firelance's fuze starts to rebel in sparking lights.</span>")
	playsound(src.loc, 'modular/stonekeep/kaizoku/sound/spells/firelance_cooking.ogg', 100)
	lit = TRUE
	spawn(20) // 2 seconds
		if(lit)
			to_chat(src.loc, "<span class='warning'>The fuze reaches the composite, building deadly pressure.</span>")
	spawn(40) // 4 seconds
		if(lit)
			to_chat(src.loc, "<span class='danger'>The Firelance is about to release purifying death!</span>")
	spawn(60) // 6 seconds
		if(lit)
			flamefire(user)
			fuel_source = FALSE
			lit = FALSE
			update_icon()

/obj/item/weapon/polearm/firelance/proc/flamefire(mob/living/user)
	if(!user)
		return

	var/turf/start = get_turf(user) 	// VERY important. It determine user's position and firing direction. May remove it for handmade fuels.
	if(!start)
		return

	var/delta_x = 0
	var/delta_y = 0
	switch(user.dir)
		if(NORTH) delta_y = 1
		if(EAST) delta_x = 1
		if(SOUTH) delta_y = -1
		if(WEST) delta_x = -1

	for(var/distance in 1 to range) // This fire pattern widens every second tile. This will be the Abyssariad/Heartfelt 'military' standard.
		var/width = distance / 2 // Calculate when it widens
		for(var/offset in -width to width) // Control the width itself
			var/turf/current_turf
			if(delta_x) // Horizontal spread
				current_turf = locate(start.x + (delta_x * distance), start.y + offset, start.z)
			else if(delta_y) // Vertical spread
				current_turf = locate(start.x + offset, start.y + (delta_y * distance), start.z)

			if(current_turf)
				// Ignite the tile
				new /obj/effect/oilspill(current_turf)
				current_turf.hotspot_expose(500, 30, 1)

				for(var/mob/living/L in current_turf.contents)
					if(iscarbon(L) && L != user)
						L.visible_message("<span class='danger'>[L] is engulfed in flames!</span>")
						L.adjustFireLoss(rand(10, 20)) //Enough damage to ensure the player will move away.
	playsound(src.loc, 'modular/stonekeep/kaizoku/sound/spells/firelance.ogg', 100)
	cocked = FALSE
	fuel_source = FALSE // Consume  fuel after use
	update_icon()

/obj/item/weapon/polearm/firelance/dropped(mob/living/user)
	. = ..()
	if(fuel_source)
		if(HAS_TRAIT(user, TRAIT_KAIZOKU))
			to_chat(src, "<span class='info'>[user] lowered the [usr] with care, sensing the potential calamity bound within, aware of the cost from underestimating it.</span>")
			return
		else
			to_chat(src, "<span class='info'>[user] dropped the [usr] with its gourd's cap unsealed, hissing quietly, as it tells the tales of widowmaking by doing the obvious.</span>")
			user.adjust_fire_stacks(3)
			user.IgniteMob()
			flamefire(user)

/obj/item/weapon/polearm/firelance/attack_self(mob/living/user)
	if(lit) // safeguard
		return
	else
		if(cocked && !fuel_source)
			to_chat(user, "<span class='info'>You open the blades, making it suitable for use. It only requires a gourd filled with fuel.</span>")
			cocked = FALSE
			update_icon()
			return

		if(!cocked && !fuel_source)
			if(HAS_TRAIT(user, TRAIT_KAIZOKU))
				to_chat(user, "<span class='info'>You triggered the mechanism under the blades even without a gourd. No internal repair is needed.</span>")
				cocked = TRUE
				update_icon()
				return
			else
				var/obj/item/bodypart/limb
				var/list/limb_list = list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)
				for(var/zone in limb_list)
					limb = user.get_bodypart(zone)
					if(limb)
						playsound(src,'sound/misc/guillotine.ogg', rand(30,60), TRUE)
						to_chat(user, "<span class='danger'>Without a gourd, [user]'s [limb] was accidentally snatched by jagged blades, bleeding before being severed!</span>")
						limb.dismember()
						qdel(limb)
						user.emote("scream")
						cocked = TRUE
						update_icon()
						return

		if(!cocked && fuel_source)
			to_chat(user, "<span class='info'>You start spinning the mechanisms, watching the jagged blades close. The weapon is now ready, but it needs to be lit.</span>")
			if(do_after(user, 60 - user.STASTR, target = user))
				playsound(user, 'sound/combat/Ranged/crossbow_medium_reload-01.ogg', 100, FALSE)
				cocked = TRUE
				update_icon()
			return
		else
			to_chat(user, "<span class='warning'>Fuel spills due to misuse, rendering the weapon unprepared.</span>")
			cocked = FALSE
			fuel_source = FALSE
			update_icon()

/obj/item/weapon/polearm/firelance/attackby(obj/item/I, mob/living/user)
	if(!istype(I, /obj/item/sanctiflux))
		to_chat(user, "<span class='warning'>[I] is not a valid fuel source!</span>")
		return
	else
		if(fuel_source) // If it already has a fuel source, you can't insert a new one.
			to_chat(user, "<span class='warning'>The firelance already has a gourd on.</span>")
			return
		if(cocked)
			to_chat(user, "<span class='warning'>I shoved the gourd against the steel blades, almost cracking it. I cannot put the gourd inside if the blades are on the way.</span>")
			return
		if(!cocked)
			fuel_source = TRUE
			update_icon()
			qdel(I)
			to_chat(user, "<span class='info'>I press the gourd against the insertion hole. I just need to adjust the mechanisms so the automata within do the rest of the job.</span>")
			..()

/obj/item/weapon/polearm/firelance/spark_act()
	ignite(usr)

/obj/item/weapon/polearm/firelance/fire_act()
	ignite(usr)

/obj/item/weapon/polearm/firelance/update_icon()
	if(lit)
		icon_state = "firelance_lit"
	else
		if(!cocked)
			if(fuel_source)
				icon_state = "firelance_oil"
			else
				icon_state = "firelance"
		else
			if(fuel_source)
				icon_state = "firelance_cocked_oil"
			else
				icon_state = "firelance_cocked"

/obj/item/sanctiflux
	name = "sanctiflux gourd"
	desc = "The abyssariad answer to demonic corruption, purger of zizo and men, malum's essence in sanctifying form to branch with abyssal valors. An Abyssariad secret from Fog Islands."
	icon = 'modular/stonekeep/kaizoku/icons/weapons/items.dmi'
	icon_state = "gourd"

/obj/effect/oilspill
	anchored = TRUE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	icon = 'modular/stonekeep/kaizoku/icons/tileset/fire.dmi'
	icon_state = "newfire"
	layer = GASFIRE_LAYER

	var/life = 120 // Lifespan of the fire in ticks. May decrease later, but I prefer to keep its area-denial use.

/obj/effect/oilspill/Initialize()
	. = ..()
	setDir(pick(GLOB.cardinals))
	START_PROCESSING(SSfastprocess, src)
	return

/obj/effect/oilspill/process()
	for(var/mob/living/carbon/human/H in view(2, src)) 	// Sate pyromaniac addiction. I don't even know if that thing works, but anyway.
		if(H.has_flaw(/datum/charflaw/addiction/pyromaniac))
			H.sate_addiction()
	life--
	if(life <= 0)
		qdel(src)
		return

/obj/effect/oilspill/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	set_light(0)
	return ..()

/obj/effect/oilspill/Crossed(atom/movable/AM, oldLoc)
	..()
	if(isliving(AM))
		var/mob/living/L = AM
		L.fire_act(20, 40)


/*
			This is for later, for when I make different types of oilfuel, all of abyssariad or heartfelt making. Possibly the handmade alternative.
	//This following code spreads the fire in a linear pattern, the first one I made.
	for(var/distance in 1 to range)
		var/turf/current_turf = locate(start.x + (delta_x * distance), start.y + (delta_y * distance), start.z)
		if(!current_turf || current_turf.density) // Stop if obstructed
			break
	// This following code spreads the fire in a triangle pattern.
	for(var/distance in 1 to range)
		for(var/offset in -distance to distance)
			var/turf/current_turf
			if(delta_x) // Horizontal spread (EAST/WEST)
				current_turf = locate(start.x + (delta_x * distance), start.y + offset, start.z)
			else if(delta_y) // Vertical spread (NORTH/SOUTH)
				current_turf = locate(start.x + offset, start.y + (delta_y * distance), start.z)
	//This following code preads the fire in diagonal around the player.
	var/list/diagonal_directions = list(
		list(1, 1),  // NORTHEAST
		list(1, -1), // SOUTHEAST
		list(-1, -1),// SOUTHWEST
		list(-1, 1)  // NORTHWEST
	)
	// Loop through each diagonal direction
	for(var/dir_offset in diagonal_directions)
		var/delta_x = dir_offset[1]
		var/delta_y = dir_offset[2]
		// Generate the fire pattern for the given direction
		for(var/distance in 1 to range)
			var/turf/current_turf = locate(start.x + (delta_x * distance), start.y + (delta_y * distance), start.z)
*/


/obj/item/weapon/tetsubishi //I humbly request someone to cook the 'jump' not causing damage.
	name = "tetsubishi"
	desc = "a sharp spike object used to slow down pursuer, often used by abyssariad shinobis, it has been massproduced and shipped to Heartfell."
	icon_state = "tetsubishi"
	icon = 'modular/stonekeep/kaizoku/icons/weapons/32.dmi'
	force = 5
	throwforce = 10
	w_class = WEIGHT_CLASS_SMALL
	block_chance = 0
	armor_penetration = 5
	sharpness = IS_SHARP
	can_parry = FALSE
	wlength = 6
	sellprice = 1
	has_inspect_verb = TRUE
	parrysound = list('sound/combat/parry/parrygen.ogg')
	anvilrepair = /datum/skill/craft/weaponsmithing
	obj_flags = CAN_BE_HIT
	blade_dulling = DULLING_BASH
	max_integrity = 60
	wdefense = 3
	experimental_onhip = TRUE
	experimental_onback = TRUE
	embedding = list(
		"embed_chance" = 60,
		"embedded_pain_multiplier" = 1,
		"embedded_fall_chance" = 0,
	)
	attack_verb = list("stabbed", "slashed", "sliced", "cut")
	hitsound = 'sound/blank.ogg'
	var/icon_prefix

/obj/item/weapon/tetsubishi/Initialize()
	. = ..()
	AddComponent(/datum/component/kaizoku/caltrop, 20, 30, 100, CALTROP_BYPASS_SHOES)

/obj/item/weapon/tetsubishi/Crossed(mob/living/L)
	playsound(loc, 'sound/foley/flesh_rem2.ogg', TRUE)
	return ..()

/datum/component/kaizoku/caltrop //Less laggy alternative for the server-destroying OG caltrops.
	var/min_damage
	var/max_damage
	var/probability
	var/flags

	var/cooldown = 0

/datum/component/kaizoku/caltrop/Initialize(_min_damage = 0, _max_damage = 0, _probability = 100,  _flags = NONE)
	min_damage = _min_damage
	max_damage = max(_min_damage, _max_damage)
	probability = _probability
	flags = _flags

	RegisterSignal(parent, list(COMSIG_MOVABLE_CROSSED), PROC_REF(Crossed))

/datum/component/kaizoku/caltrop/proc/Crossed(datum/source, atom/movable/AM)
	var/atom/A = parent
	if(!prob(probability))
		return

	if(ishuman(AM))
		var/mob/living/carbon/human/H = AM
		if((flags & CALTROP_IGNORE_WALKERS) && H.m_intent == MOVE_INTENT_WALK)
			return

		var/picked_def_zone = pick(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
		var/obj/item/bodypart/O = H.get_bodypart(picked_def_zone)
		if(!istype(O))
			return

		var/feetCover = (H.wear_armor && (H.wear_armor.body_parts_covered & FEET)) || (H.wear_pants && (H.wear_pants.body_parts_covered & FEET))

		if(!(flags & CALTROP_BYPASS_SHOES) && (H.shoes || feetCover))
			return

		if((H.movement_type & FLYING) || H.buckled)
			return

		var/damage = rand(min_damage, max_damage)
		H.apply_damage(damage, BRUTE, picked_def_zone)


		if(cooldown < world.time - 10) //cooldown to avoid message spam.
			if(!H.incapacitated(ignore_restraints = TRUE))
				H.visible_message("<span class='danger'>[H] steps on [A] as it pierces skin.</span>", \
						"<span class='danger'>I feel my feet being pierced as I step on [A]!</span>")
			else
				H.visible_message("<span class='danger'>[H] slides their bodies on [A]!</span>", \
						"<span class='danger'>I slide on [A]!</span>")

			cooldown = world.time
		H.Stun(60)

/obj/item/throwing_star/ninja
	name = "throwing star"
	desc = "a simple distracting tool used to cause a commotion and bleeding so its user can scramble."
	icon_state = "shuriken"
	icon = 'modular/stonekeep/kaizoku/icons/weapons/32.dmi'


// =================================================================
// ========================		SWORD	============================

/obj/item/weapon/sword/uchigatana
	name = "uchigatana"
	desc = "Shorter and simpler than the Tachi, the Uchigatana is the primary sidearm for the Abyssariad and Heartfelt footsoldiers. As a Zatana, the curved blade favor powerfull chopping strikes - but lacks a protective crossguard and the curve makes it less efficient in thrusting."
	icon = 'modular/stonekeep/kaizoku/icons/weapons/64.dmi'
	icon_state = "uchigatana"
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	bigboy = TRUE
	smeltresult = /obj/item/ingot/steel

/obj/item/weapon/sword/uchigatana/fire //Experimental weapon. Not to be found ingame.
	name = "fire uchigatana"
	desc = "Shorter and simpler than the Tachi, the Uchigatana is the primary sidearm for the Abyssariad and Heartfelt footsoldiers. Unlike other uchigatanas, this sword in specifically seems curiously improved with 'frigus' runes."

/obj/item/weapon/sword/uchigatana/fire/attack(mob/M, mob/living/carbon/human/user)
	if(ismob(M))
		fire_effect(M, user)
		..()

/obj/item/weapon/sword/uchigatana/fire/proc/fire_effect(mob/living/L, mob/user)
	L.adjust_fire_stacks(1)
	L.IgniteMob()
	addtimer(CALLBACK(L, TYPE_PROC_REF(/mob/living, ExtinguishMob)), 5 SECONDS)
	if(user)
		L.lastattacker = user.real_name
		L.lastattackerckey = user.ckey
		L.visible_message("<span class='danger'>[user] has ignited [L] with [src]!</span>", \
								"<span class='danger'>[user] has ignited you with [src]!</span>")
	playsound(loc, 'sound/blank.ogg', 50, TRUE, -1)
	return

/obj/item/weapon/sword/long/tachi //this sword is all fucked. Oh God. Help me.
	name = "tachi"
	desc = "A long, curved Zatana of Abyssariad make, introduced when Wokou raiders returned to the Fog Isles with captured horses and began developing their own cavalry tactics."
	icon = 'modular/stonekeep/kaizoku/icons/weapons/64.dmi'
	icon_state = "tachi"
	item_state = "tachi"
	pixel_y = -16
	pixel_x = -18

/obj/item/weapon/sword/long/tachi/dustcurse/dropped()
	. = ..()
	name = "Dustcurse tachi"
	minstr = 0 //asset solely to be used by NPCs. This will not be found on the hands of players.
	to_chat(src, "<span class='warning'>A haunting wind scatters [usr] into dust, sweeping it back to the ocean!</span>")
	if(QDELETED(src))
		return
	qdel(src)

/obj/item/weapon/sword/long/greatsword/odachi
	name = "odachi"
	desc = "Greatsword traditionally wielded in open battlefields just as it is a ceremonial blade. Though impractical for duels, it breaks spearlines and shields on a whim, requiring momentum with each slash."
	icon_state = "odachi"
	icon = 'modular/stonekeep/kaizoku/icons/weapons/64.dmi'
	parrysound = "bladedlarge"

/obj/item/weapon/sword/iron/jian
	name = "iron jian"
	icon_state = "jian1"
	icon = 'modular/stonekeep/kaizoku/icons/weapons/32.dmi'

/obj/item/weapon/sword/iron/jian/Initialize()
	. = ..()
	var/design = rand(1, 6) //This system will be standardized to other weapons.
	switch(design)
		if(1)
			name = "monk jian"
			desc = "A simple, double-edged iron sword. With a short guard and slim grip, it is easier to use in martial arts that requires constant flick of the wrist."
		if(2)
			name = "frontierman jian"
			desc = "A simple, double-edged iron sword. With a thicker pommel and stretched guard, it becomes more proper as sideweapons during sieges for overhead attacks."
		if(3)
			name = "guardsman jian"
			desc = "A simple, double-edged iron sword of abyssariad with parrying hooks at cost of slashing effectiveness."
		if(4)
			name = "foreigner jian"
			desc = "A simple, double-edged iron sword of abyssariad design with heartfelt influence, taking smithing standards from Zweihanders."
		if(5)
			name = "heartfelt jian"
			desc = "A simple, double-edged iron sword of abyssariad design with heartfelt influence. Keeping a rather imperial style of guard."
		if(6)
			name = "duelist jian"
			desc = "A simple, double-edged iron sword of abyssariad design with hand protection that resembles one side of the firelance apparatus. Usually used for training."
	icon_state = "jian[design]"

/obj/item/weapon/sword/scimitar/messer/dao
	name = "iron dao"
	desc = "A single edged iron saber of Abyssariad making for horseback use. Suitable for chopping."
	icon_state = "dao"
	icon = 'modular/stonekeep/kaizoku/icons/weapons/32.dmi'

/obj/item/weapon/sword/scimitar/falchion/yuntoudao //this sprite disappeared by reasons unknown
	name = "Yuntoudao"
	desc = "A expensive Abyssariad saber with wide middle and tapered ends in a 'willow-leaf' shape, it concentrates the force of a strike in an axe-like blow, while retaining the swiftness of a saber."
	icon_state = "yuntoudao"
	icon = 'modular/stonekeep/kaizoku/icons/weapons/32.dmi'

/obj/item/weapon/sword/short/jian
	name = "short steel jian"
	desc = "A simple, shortened version of the double-edged Jian. This is usually given to Abyssariad citizens as a right for self-defense by the emperor's will."
	icon = 'modular/stonekeep/kaizoku/icons/weapons/32.dmi'
	icon_state = "shortjian"

/obj/item/weapon/sword/short/wakizashi
	name = "wakizashi"
	icon_state = "wakizashi1"
	icon = 'modular/stonekeep/kaizoku/icons/weapons/32.dmi'
	possible_item_intents = list(/datum/intent/sword/cut/sorii, /datum/intent/sword/thrust/sorii)

/obj/item/weapon/sword/short/wakizashi/Initialize()
	. = ..()
	var/design = rand(1, 3) //This system will be standardized to other weapons.
	switch(design)
		if(1)
			name = "wakizashi zatana"
			desc = "A shorter zatana design with circular handguard and heartfelt-influenced pommel. The curveness of the blade makes it better at cutting than thrusting."
		if(2)
			name = "traditional wakizashi"
			desc = "The traditional wakizashi used by abyssariads for centuries, with a lack of a pommel and a broader handguard for hand protection. The sorii of the blade improves the cutting power."
		if(3)
			name = "shirasaya wakizashi"
			desc = "The cheaper adaptation of the Wakizashi with an complete lack of handguard and no tsuka ito covering the "
	icon_state = "wakizashi[design]"

/datum/intent/sword/cut/sorii //It is the reverse of the Shortsword.
	clickcd = 10
	penfactor = 30

/datum/intent/sword/thrust/sorii
	clickcd = 10
	damfactor = 0.85

/obj/item/weapon/sword/sabre/piandao
	name = "piandao"
	desc = "An curved abyssariad sword with a broad, single-edged blade that ends in a heavier curve for powerful and fast sweeping strikes."
	icon_state = "piandao"
	icon = 'modular/stonekeep/kaizoku/icons/weapons/32.dmi'

/obj/item/weapon/sword/sabre/piandao/dec
	name = "decorated piandao"
	desc = "The Abyssariad saber with the hilt covered in gold and letters reflecting the user's family lineage."
	icon_state = "piandaodec"
	max_integrity = 550
	sellprice = 140

/obj/item/weapon/sword/dragonslayer //It's a sword, yes. It will be used as a sword? My dudes we moving that one like warhammers at this point. So it's blunt at this point.
	name = "dragonslayer eclipse sword"
	desc = "Dragonslayers uses swords too big to be called a sword. Massive, thick, heavy and far too rough. Indeed, they use a heap of raw iron. These are not crafted for fnesse, but for raw carnage in steel to obliterate Dragon's almost impenetrable skin."
	gripped_intents = list(/datum/intent/dragonslayer/smash, /datum/intent/polearm/chop) //This is practically a mace... that can chop off heads since it's sharp.
	icon_state = "eclipse_sword"
	resistance_flags = FIRE_PROOF
	smeltresult = /obj/item/ingot/steel
	max_integrity = 500
	force = 5 //You won't get ANYTHING by using in one hand. Trust me. EVEN IF YOU COULD.
	force_wielded = 40 // I thought Gundam would nerf it. He buffed it instead. What a World!
	slowdown = 1
	wbalance = -1
	sellprice = 300
	w_class = WEIGHT_CLASS_HUGE
	wbalance = -1 //haha... yeah.
	wdefense = 3
	minstr = 14
	associated_skill = /datum/skill/combat/axesmaces //if you tell me that fighting with this sword is LIKE a sword, I will kill you (ingame)-Mono
	icon = 'modular/stonekeep/kaizoku/icons/weapons/64.dmi'
	slot_flags = ITEM_SLOT_BACK
	parrysound = "largeblade"
	pickup_sound = "brandish_blade"
	bigboy = TRUE

/datum/intent/dragonslayer/smash
	name = "smash"
	icon_state = "insmash"
	attack_verb = list("clangs")
	animname = "smash"
	blade_class = BCLASS_CHOP
	hitsound = list('modular/stonekeep/kaizoku/sound/dragonslayer.ogg')
	penfactor = 30
	damfactor = 1.2
	chargetime = 5
	swingdelay = 5
	misscost = 35
	warnie = "mobwarning"



// =================================================================
// ========================		BOW & ARROW	========================

/obj/projectile/bullet/reusable/arrow/poison/fog
	name = "fog arrow"
	desc = "An arrow with it's tip drenched in a powerful sedative."
	icon = 'modular/stonekeep/kaizoku/icons/weapons/ammo.dmi'
	icon_state = "arrowfog_proj"
	ammo_type = /obj/item/ammo_casing/caseless/arrow

/obj/item/ammo_casing/caseless/arrow/poison/fog
	name = "fog arrow"
	desc = "An arrow with it's tip drenched in a powerful sedative."
	projectile_type = /obj/projectile/bullet/reusable/arrow/poison/fog
	icon = 'modular/stonekeep/kaizoku/icons/weapons/ammo.dmi'
	icon_state = "arrow_fog"

/obj/projectile/bullet/reusable/arrow/poison/fog/Initialize()
	. = ..()
	create_reagents(50, NO_REACT)

/obj/projectile/bullet/reusable/arrow/poison/fog/on_hit(atom/target, blocked = FALSE)
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		if(blocked != 100) // not completely blocked
			if(M.can_inject(null, FALSE, def_zone, piercing)) // Pass the hit zone to see if it can inject by whether it hit the head or the body.
				..()
				reagents.reaction(M, INJECT)
				reagents.trans_to(M, reagents.total_volume)
				return BULLET_ACT_HIT
			else
				blocked = 100
				target.visible_message("<span class='danger'>\The [src] was deflected!</span>", \
									   "<span class='danger'>My armor protected me against \the [src]!</span>")

	..(target, blocked)
	DISABLE_BITFIELD(reagents.flags, NO_REACT)
	reagents.handle_reactions()
	return BULLET_ACT_HIT

/obj/projectile/bullet/reusable/arrow/poison/fog/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/fogblight, 5)

/obj/item/ammo_casing/caseless/bolt/poison/fog
	name = "fog bolt"
	desc = "A bolt dipped with a potent sedative."
	projectile_type = /obj/projectile/bullet/reusable/bolt/poison/fog
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/dagger/thrust)
	icon = 'modular/stonekeep/kaizoku/icons/weapons/ammo.dmi'
	icon_state = "bolt_fog"

/obj/projectile/bullet/reusable/bolt/poison/fog
	name = "fog bolt"
	desc = "A bolt dipped with a potent sedative."
	damage = 35
	damage_type = BRUTE
	icon = 'modular/stonekeep/kaizoku/icons/weapons/ammo.dmi'
	icon_state = "boltfogn_proj"
	ammo_type = /obj/item/ammo_casing/caseless/bolt

/obj/projectile/bullet/reusable/bolt/poison/fog/Initialize()
	. = ..()
	create_reagents(50, NO_REACT)

/obj/projectile/bullet/reusable/bolt/poison/fog/on_hit(atom/target, blocked = FALSE)
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		if(blocked != 100) // not completely blocked
			if(M.can_inject(null, FALSE, def_zone, piercing)) // Pass the hit zone to see if it can inject by whether it hit the head or the body.
				..()
				reagents.reaction(M, INJECT)
				reagents.trans_to(M, reagents.total_volume)
				return BULLET_ACT_HIT
			else
				blocked = 100
				target.visible_message("<span class='danger'>\The [src] was deflected!</span>", \
									   "<span class='danger'>My armor protected me against \the [src]!</span>")

	..(target, blocked)
	DISABLE_BITFIELD(reagents.flags, NO_REACT)
	reagents.handle_reactions()
	return BULLET_ACT_HIT

/obj/projectile/bullet/reusable/bolt/poison/fog/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/fogblight, 5)




/obj/item/gun/ballistic/revolver/grenadelauncher/bow/hankyu
	name = "hankyu bow"
	desc = "A smaller version of the asymmetrical bow named Yumi. It must be shot overhead, and it is perfect for horseback use."
	icon = 'modular/stonekeep/kaizoku/icons/weapons/bows.dmi'
	icon_state = "hankyubow"
	item_state = "hankyubow"
	base_icon = "hankyubow"

/obj/item/gun/ballistic/revolver/grenadelauncher/bow/long/yumi
	name = "yumi bow"
	desc = "The asymmetrical and elegant piece of Kyudo warfare, hard-hitting and powerful, bringing fear to orcish hordes and demons on a whim."
	icon = 'modular/stonekeep/kaizoku/icons/weapons/bows.dmi'
	icon_state = "yumibow"
	item_state = "yumibow"
	base_icon = "yumibow"


/obj/item/weapon/sickle/kama	// iron sword worse integrity
	possible_item_intents = list(/datum/intent/axe/cut,/datum/intent/axe/chop,MACE_STRIKE,/datum/intent/flailthresh)
	name = "kama"
	desc = "Originally created for the harvesting of rice, the kama has also found popularity as a commoner's weapon thanks to its axe-like design. On occasion, one is combined with a length of chain to make a kusari gama."
	icon_state = "kama"
	icon = 'modular/stonekeep/kaizoku/icons/weapons/32.dmi'
	associated_skill = /datum/skill/combat/axesmaces
	force = DAMAGE_SWORD-1
	force_wielded = DAMAGE_SWORD_WIELD-1
	max_blade_int = 100
	max_integrity = INTEGRITY_STANDARD
	blade_dulling = DULLING_BASHCHOP
	wdefense = GOOD_PARRY


