/**********************Mineral deposits**************************/

/turf/closed/mineral //wall piece
	name = "rock"
	desc = "Seems barren."
	icon = 'icons/turf/roguewall.dmi'
	icon_state = "rockyash"
	var/smooth_icon = 'icons/turf/walls/cwall.dmi'
	smooth = SMOOTH_TRUE | SMOOTH_MORE
	wallclimb = TRUE
	canSmoothWith = list(/turf/closed/mineral/random, /turf/closed/mineral)
	baseturfs = /turf/open/floor/naturalstone
	above_floor = /turf/open/floor/naturalstone
	opacity = 1
	density = TRUE
	var/environment_type = "asteroid"
	var/turf/open/floor/turf_type = /turf/open/floor/naturalstone
	var/obj/item/mineralType = null
	var/obj/item/natural/rock/rockType = null
	var/mob/living/lastminer //for xp gain and luck shenanigans
	var/mineralAmt = 1
	var/spread = 0 //will the seam spread?
	var/spreadChance = 0 //the percentual chance of an ore spreading to the neighbouring tiles
	var/last_act = 0
	var/scan_state = "" //Holder for the image we display when we're pinged by a mining scanner
	var/defer_change = 0
	blade_dulling = DULLING_PICK
	max_integrity = 500
	explosion_block = 20
	damage_deflection = 10
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onrock/onrock (1).ogg', 'sound/combat/hits/onrock/onrock (2).ogg', 'sound/combat/hits/onrock/onrock (3).ogg', 'sound/combat/hits/onrock/onrock (4).ogg')
	neighborlay = "dirtedge"

/turf/closed/mineral/Initialize()
	if (!canSmoothWith)
		canSmoothWith = list(/turf/closed/mineral, /turf/closed/indestructible)
//	var/matrix/M = new
//	M.Translate(-4, -4)
//	transform = M
	icon = smooth_icon
	. = ..()

/turf/closed/mineral/Destroy()
	. = ..()
	lastminer = null

/turf/closed/mineral/LateInitialize()
	. = ..()
	if (mineralType && mineralAmt && spread && spreadChance)
		for(var/dir in GLOB.cardinals)
			if(prob(spreadChance))
				var/turf/T = get_step(src, dir)
				if(istype(T, /turf/closed/mineral/random))
					Spread(T)
	var/turf/open/transparent/openspace/target = get_step_multiz(src, UP)
	if(istype(target))
		target.ChangeTurf(/turf/open/floor/naturalstone)

/turf/closed/mineral/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	if(turf_type)
		underlay_appearance.icon = initial(turf_type.icon)
		underlay_appearance.icon_state = initial(turf_type.icon_state)
		return TRUE
	return ..()


/turf/closed/mineral/attackby(obj/item/I, mob/user, params)
	if (!user.IsAdvancedToolUser())
		to_chat(user, span_warning("I don't have the dexterity to do this!"))
		return
	lastminer = user
	var/olddam = turf_integrity
	..()
	if(turf_integrity && turf_integrity > 10)
		if(turf_integrity < olddam)
			if(prob(50))
				if(user.Adjacent(src))
					var/obj/item/natural/stone/S = new(src)
					S.forceMove(get_turf(user))

/turf/closed/mineral/turf_destruction(damage_flag)
	if(!(istype(src, /turf/closed)))
		return
	if(damage_flag == "blunt")
		var/obj/item/explo_mineral = mineralType
		var/explo_mineral_amount = mineralAmt
		var/obj/item/natural/rock/explo_rock = rockType
		ScrapeAway()
		GLOB.mined_resource_loc |= get_turf(src)
		queue_smooth_neighbors(src)
		new /obj/item/natural/stone(src)
		if(prob(30))
			new /obj/item/natural/stone(src)
		if (explo_mineral && (explo_mineral_amount > 0))
			if(prob(33)) //chance to spawn ore directly
				new explo_mineral(src)
			if(explo_rock)
				if(prob(23))
					new explo_rock(src)
			SSblackbox.record_feedback("tally", "ore_mined", explo_mineral_amount, explo_mineral)
		else
			return
	else
		if(lastminer.stat_roll(STATKEY_LCK,2,10) && mineralType)
	//		to_chat(lastminer, span_notice("Bonus ducks!"))
			new mineralType(src)
		gets_drilled(lastminer, give_exp = FALSE)
		queue_smooth_neighbors(src)
	..()

/turf/closed/mineral/proc/gets_drilled(mob/living/user, triggered_by_explosion = FALSE, give_exp = TRUE)
	new /obj/item/natural/stone(src)
	if(prob(30))
		new /obj/item/natural/stone(src)
	if (mineralType && (mineralAmt > 0))
		if(prob(33)) //chance to spawn ore directly
			new mineralType(src)
		if(rockType) //always spawn at least 1 rock
			new rockType(src)
			if(prob(23))
				new rockType(src)
		SSblackbox.record_feedback("tally", "ore_mined", mineralAmt, mineralType)
	else if(user.stat_roll(STATKEY_LCK,2,10))
		var/newthing = pickweight(list(/obj/item/natural/rock/salt = 2, /obj/item/natural/rock/iron = 1, /obj/item/natural/rock/coal = 2))
//		to_chat(user, "<span class='notice'>Bonus ducks!</span>")
		new newthing(src)
	var/flags = NONE
	if(defer_change) // TODO: make the defer change var a var for any changeturf flag
		flags = CHANGETURF_DEFER_CHANGE
	ScrapeAway(null, flags)
	addtimer(CALLBACK(src, PROC_REF(AfterChange)), 1, TIMER_UNIQUE)

/turf/closed/mineral/attack_animal(mob/living/simple_animal/user)
	if((user.environment_smash & ENVIRONMENT_SMASH_WALLS) || (user.environment_smash & ENVIRONMENT_SMASH_RWALLS))
		gets_drilled(user)
	..()
/turf/closed/mineral/acid_melt()
	ScrapeAway()

/turf/closed/mineral/ex_act(severity, target, epicenter, devastation_range, heavy_impact_range, light_impact_range, flame_range)
	if(target == src)
		ScrapeAway()
		return
	var/ddist = devastation_range
	var/hdist = heavy_impact_range
	var/ldist = light_impact_range
	var/fdist = flame_range
	var/fodist = get_dist(src, epicenter)
	var/brute_loss = 0
	var/dmgmod = round(rand(0.1, 2), 0.1)

	switch (severity)
		if (EXPLODE_DEVASTATE)
			brute_loss = ((250 * ddist) - (250 * fodist) * dmgmod)

		if (EXPLODE_HEAVY)
			brute_loss = ((100 * hdist) - (100 * fodist) * dmgmod)

		if(EXPLODE_LIGHT)
			brute_loss = ((25 * ldist) - (25 * fodist) * dmgmod)

	if(fodist == 0)
		brute_loss *= 2
	take_damage(brute_loss, BRUTE, "blunt", 0)

	if(fdist && !QDELETED(src))
		var/stacks = ((fdist - fodist) * 2)
		fire_act(stacks)

	if(!density)
		..()

/turf/closed/mineral/Spread(turf/T)
	T.ChangeTurf(type)

/turf/closed/mineral/random
	name = "rock"
	desc = "Seems barren."
	icon = 'icons/turf/roguewall.dmi'
	icon_state = "minrandbad"
	smooth = SMOOTH_TRUE | SMOOTH_MORE
	smooth_icon = 'icons/turf/walls/cwall.dmi'
	wallclimb = TRUE
	canSmoothWith = list(/turf/closed/mineral/random, /turf/closed/mineral)
	turf_type = /turf/open/floor/naturalstone
	above_floor = /turf/open/floor/naturalstone
	baseturfs = list(/turf/open/floor/naturalstone)
	max_integrity = 400
	///if this isn't empty, swaps to one of them via pickweight
	var/list/mineralSpawnChanceList = list(/turf/closed/mineral/salt = 20, /turf/closed/mineral/copper = 15, ,/turf/closed/mineral/tin = 12, /turf/closed/mineral/iron = 5, /turf/closed/mineral/coal = 5)
	///the chance to swap to something useful
	var/mineralChance = 30
	var/display_icon_state = "rock"

/turf/closed/mineral/random/Initialize()

	mineralSpawnChanceList = typelist("mineralSpawnChanceList", mineralSpawnChanceList)

	if (display_icon_state)
		icon_state = display_icon_state
	. = ..()
	if (prob(mineralChance))
		var/path = pickweight(mineralSpawnChanceList)
		var/turf/T = ChangeTurf(path,null,CHANGETURF_IGNORE_AIR)

		if(T && ismineralturf(T))
			var/turf/closed/mineral/M = T
			M.mineralAmt = rand(1, 5)
			M.environment_type = src.environment_type
			M.turf_type = src.turf_type
			M.baseturfs = src.baseturfs
			src = M
			M.levelupdate()


/turf/closed/mineral/random/med
	icon_state = "minrandmed"
	mineralChance = 50
	mineralSpawnChanceList = list(/turf/closed/mineral/salt = 20, /turf/closed/mineral/iron = 25, /turf/closed/mineral/coal = 20, /turf/closed/mineral/copper = 10, ,/turf/closed/mineral/tin = 10, /turf/closed/mineral/silver = 1)//, /turf/closed/mineral/gemeralds = 1)

/turf/closed/mineral/random/high
	icon_state = "minrandhigh"
	mineralChance = 70
	mineralSpawnChanceList = list(/turf/closed/mineral/gold = 15 , /turf/closed/mineral/iron = 25, /turf/closed/mineral/silver = 15)//, /turf/closed/mineral/gemeralds = 10)

/turf/closed/mineral/random/low_nonval
	icon_state = "cticbad"
	mineralChance = 30
	mineralSpawnChanceList = list(/turf/closed/mineral/copper = 15,/turf/closed/mineral/tin = 15, /turf/closed/mineral/iron = 25, /turf/closed/mineral/coal = 20)

/turf/closed/mineral/random/med_nonval
	icon_state = "cticmed"
	mineralChance = 50
	mineralSpawnChanceList = list(/turf/closed/mineral/copper = 15,/turf/closed/mineral/tin = 15, /turf/closed/mineral/iron = 25, /turf/closed/mineral/coal = 20)

/turf/closed/mineral/random/high_nonval
	icon_state = "cticgood"
	mineralChance = 70
	mineralSpawnChanceList = list(/turf/closed/mineral/copper = 15,/turf/closed/mineral/tin = 15, /turf/closed/mineral/iron = 25, /turf/closed/mineral/coal = 20)

/turf/closed/mineral/random/low_valuable
	icon_state = "gsgbad"
	mineralChance = 30
	mineralSpawnChanceList = list(/turf/closed/mineral/gold = 40 , /turf/closed/mineral/gemeralds = 20, /turf/closed/mineral/silver = 40)

/turf/closed/mineral/random/med_valuable
	icon_state = "gsgmed"
	mineralChance = 50
	mineralSpawnChanceList = list(/turf/closed/mineral/gold = 40 , /turf/closed/mineral/gemeralds = 20, /turf/closed/mineral/silver = 40)

/turf/closed/mineral/random/high_valuable
	icon_state = "gsggood"
	mineralChance = 70
	mineralSpawnChanceList = list(/turf/closed/mineral/gold = 40 , /turf/closed/mineral/gemeralds = 20, /turf/closed/mineral/silver = 40)



/turf/closed/mineral/copper
	icon_state = "coppbad"
	mineralType = /obj/item/ore/copper
	rockType = /obj/item/natural/rock/copper
	spreadChance = 4
	spread = 3

/turf/closed/mineral/tin
	icon_state = "tinbad"
	mineralType = /obj/item/ore/tin
	rockType = /obj/item/natural/rock/tin
	spreadChance = 15
	spread = 5

/turf/closed/mineral/silver
	icon_state = "silverbad"
	mineralType = /obj/item/ore/silver
	rockType = /obj/item/natural/rock/silver
	spreadChance = 2
	spread = 2

/turf/closed/mineral/gold
	icon_state = "goldbad"
	mineralType = /obj/item/ore/gold
	rockType = /obj/item/natural/rock/gold
	spreadChance = 2
	spread = 2

/turf/closed/mineral/salt
	icon_state = "saltbad"
	mineralType = /obj/item/reagent_containers/powder/salt
	rockType = /obj/item/natural/rock/salt
	spreadChance = 12
	spread = 3

/turf/closed/mineral/iron
	icon_state = "ironbad"
	mineralType = /obj/item/ore/iron
	rockType = /obj/item/natural/rock/iron
	spreadChance = 5
	spread = 3

/turf/closed/mineral/coal
	icon_state = "coalbad"
	mineralType = /obj/item/ore/coal
	rockType = /obj/item/natural/rock/coal
	spreadChance = 3
	spread = 4

/turf/closed/mineral/gemeralds
	icon_state = "gembad"
	mineralType = /obj/item/gem
	rockType = /obj/item/natural/rock/gemerald
	spreadChance = 3
	spread = 2

/turf/closed/mineral/bedrock
	name = "rock"
	desc = "Seems barren, and nigh indestructable."
	icon_state = "rockyashbed"
//	smooth_icon = 'icons/turf/walls/hardrock.dmi'
	max_integrity = 10000000
	damage_deflection = 99999999
	above_floor = /turf/closed/mineral/bedrock

/turf/closed/mineral/bedrock/attackby(obj/item/I, mob/user, params)
	to_chat(user, span_warning("This is far to sturdy to be destroyed!"))
	return FALSE

/turf/closed/mineral/bedrock/TerraformTurf(path, new_baseturf, flags, defer_change = FALSE, ignore_air = FALSE)
	return

/turf/closed/mineral/bedrock/acid_act(acidpwr, acid_volume, acid_id)
	return 0

/turf/closed/mineral/bedrock/Melt()
	to_be_destroyed = FALSE
	return src
