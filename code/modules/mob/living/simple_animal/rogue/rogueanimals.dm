#define TROLL_HEALTH 500
#define BOGTROLL_HEALTH 350
#define MOLE_HEALTH 200
#define BOGBUG_HEALTH 160
#define SPIDER_HEALTH 120
#define VOLF_HEALTH 110
#define SHADE_HEALTH 75
#define ROUS_HEALTH 35

#define FEMALE_MOOBEAST_HEALTH 100
#define MALE_MOOBEAST_HEALTH 150
#define FEMALE_GOTE_HEALTH 80
#define MALE_GOTE_HEALTH 120
#define CALF_HEALTH 20
#define CHICKEN_HEALTH 15

//these mobs run away when attacked
/mob/living/simple_animal/hostile/retaliate/rogue
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"

	gender = MALE
	faction = list("rogueanimal")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	speak_chance = 1

	turns_per_move = 5
	move_to_delay = 8	// basically speed when player controlled. Lower is faster, a lot faster.
	see_in_dark = 6
	robust_searching = TRUE

	botched_butcher_results = list(/obj/item/alch/bone = 1) // 50% chance to get if skill 0 in butchery
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat = 1)
	perfect_butcher_results = list(/obj/item/natural/hide = 1) // level 5 butchery bonus

	health = 40
	maxHealth = 40
	food_type = list(/obj/item/reagent_containers/food/snacks/produce)
	pooptype = null

	d_intent = INTENT_DODGE
	minbodytemp = 180
	lose_patience_timeout = 150
	vision_range = 5
	aggro_vision_range = 18
	attack_sound = PUNCHWOOSH
	harm_intent_damage = 5
	attack_same = FALSE
	environment_smash = ENVIRONMENT_SMASH_NONE
	blood_volume = BLOOD_VOLUME_NORMAL

	stop_automated_movement_when_pulled = FALSE
	tame_chance = 0
	retreat_distance = 10
	minimum_distance = 10
	candodge = TRUE
	dodge_sound = 'sound/combat/dodge.ogg'
	dodge_prob = 0
	search_objects = TRUE
	can_saddle = FALSE

	//Should turn this into a flag thing but i dont want to touch too many things
	var/body_eater = FALSE
	//If the creature is doing something they should STOP MOVING.
	var/can_act = TRUE
	//Trolls eat more than wolves
	var/deaggroprob = 10
	var/eat_forever


/mob/living/simple_animal/hostile/retaliate/rogue/onbite(mob/living/carbon/human/user)
	visible_message(span_danger("[user] bites [src]!"))
	playsound(src, "smallslash", 100, TRUE, -1)
	var/bite_power = 3

	if(HAS_TRAIT(user, TRAIT_STRONGBITE))
		bite_power += ( user.STASTR )

	apply_damage((bite_power), BRUTE)
	..()

/mob/living/simple_animal/hostile/retaliate/rogue/Move()
	//If you cant act and dont have a player stop moving.
	if(!can_act && !client)
		return FALSE
	..()

/mob/living/simple_animal/hostile/retaliate/rogue/apply_damage(damage = 0,damagetype = BRUTE, def_zone = null, blocked = FALSE, forced = FALSE)
	..()
	if(damagetype == BRUTE)
		if(damage > 5 && prob(damage * 3))
			emote("pain")
		if(damage > 10)
			Immobilize(clamp(damage/2, 1, 30))
			shake_camera(src, 1, 1)
		if(damage < 10)
			flash_fullscreen("redflash1")
		else if(damage < 20)
			flash_fullscreen("redflash2")
		else if(damage >= 20)
			flash_fullscreen("redflash3")
	if(damagetype == BURN)
		if(damage > 10 && prob(damage))
			emote("pain")
			shake_camera(src, 1, 1)
		if(damage < 10)
			flash_fullscreen("redflash1")
		else if(damage < 20)
			flash_fullscreen("redflash2")
		else if(damage >= 20)
			flash_fullscreen("redflash3")

/mob/living/simple_animal/hostile/retaliate/rogue/death(gibbed)
	emote("death")
	..()

/mob/living/simple_animal/hostile/retaliate/rogue/handle_automated_movement()
	set waitfor = FALSE
	if(ai_controller)
		return ..()
	if(!stop_automated_movement && wander && !doing)
		if(ssaddle && has_buckled_mobs())
			return FALSE
		if(find_food())
			return
		else
			..()

/mob/living/simple_animal/hostile/retaliate/rogue/proc/find_food()
	if(food > 50 && !eat_forever)
		return
	var/list/around = view(1, src)
	var/list/foundfood = list()
	if(stat)
		return
	for(var/obj/item/F in around)
		if(is_type_in_list(F, food_type))
			foundfood += F
			if(src.Adjacent(F))
				face_atom(F)
				playsound(src,'sound/misc/eat.ogg', rand(30,60), TRUE)
				qdel(F)
				food = max(food + 30, 100)
				return TRUE

	for(var/obj/item/F in foundfood)
		if(is_type_in_list(F, food_type))
			var/turf/T = get_turf(F)
			Goto(T,move_to_delay,0)
			return TRUE
	return FALSE

/mob/living/simple_animal/hostile/retaliate/rogue/proc/eat_bodies()
	var/mob/living/L
//	var/list/around = view(aggro_vision_range, src)
	var/list/around = hearers(1, src)
	var/list/foundfood = list()
	if(stat)
		return
	for(var/mob/living/eattarg in around)
		if(!(eattarg in enemies)) //Makes a tamed rous not eat people on the floor unless instigated.
			return
		if(eattarg.stat != CONSCIOUS)
			foundfood += eattarg
			L = eattarg
			if(src.Adjacent(L))
				if(iscarbon(L))
					var/mob/living/carbon/C = L
					if(attack_sound)
						playsound(src, pick(attack_sound), 100, TRUE, -1)
					face_atom(C)
					src.visible_message(span_danger("[src] starts to rip apart [C]!"))
					if(do_after(src, 10 SECONDS, L))
						var/obj/item/bodypart/limb
						var/list/limb_list = list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
						for(var/zone in limb_list)
							limb = C.get_bodypart(zone)
							if(limb)
								limb.dismember()
								return TRUE
						limb = C.get_bodypart(BODY_ZONE_HEAD)
						if(limb)
							limb.dismember()
							return TRUE
						limb = C.get_bodypart(BODY_ZONE_CHEST)
						if(limb)
							if(!limb.dismember())
								C.gib()
							return TRUE
				else
					if(attack_sound)
						playsound(src, pick(attack_sound), 100, TRUE, -1)
					src.visible_message(span_danger("[src] starts to rip apart [L]!"))
					if(do_after(src, 10 SECONDS, L))
						L.gib()
						return TRUE
	for(var/mob/living/eattarg in foundfood)
		var/turf/T = get_turf(eattarg)
		Goto(T,move_to_delay,0)
		return TRUE
	return FALSE

//What can we attack?
/mob/living/simple_animal/hostile/retaliate/rogue/CanAttack(atom/the_target)
	//If is foodtype and food is less than 50 or you eat forever.
	if(is_type_in_list(the_target, food_type) && (food < food_max || eat_forever))
		//To prevent limb eaters from eating inorganic limbs
		if(PickyEater(the_target))
			return TRUE
	//Return root code
	. = ..()
	//Am i a body eater?
	if(body_eater)
		if(isliving(the_target))
			var/mob/living/stuff = the_target
			if(stuff.stat != CONSCIOUS && !faction_check_mob(stuff))
				return TRUE

//Im coding this because im curious if your server will work better with it -IP
/mob/living/simple_animal/hostile/retaliate/rogue/PickTarget(list/Targets)
	/*
	* Here let me explain how this works
	* We are going to skim through the
	* Targets list and seperate it into
	* two groups, food and living.
	* If there is any items in the living
	* list then the AI will use the root code
	* to select the nearest of those targets.
	* If that list is empty we instead scan
	* the food list. This prioritizes living
	* targets over food.
	* <3 IP
	*/
	var/list/foodtargets = list()
	var/list/enemytargets = list()
	for(var/atom/A in Targets)
		if(isliving(A))
			//Dead creatures are to be considered food.
			var/mob/living/L = A
			if(L.stat != CONSCIOUS)
				foodtargets += L
			else
				enemytargets += A
		else
			foodtargets += A
	if(LAZYLEN(enemytargets))
		return ..(enemytargets)
	return ..(foodtargets)

//What happens when we attack something
/mob/living/simple_animal/hostile/retaliate/rogue/AttackingTarget()
	//If you cant act and dont have a player stop moving.
	if(!can_act && !client)
		return FALSE
	//If the unique attack returns true then we dont attack normally
	if(UniqueAttack())
		return FALSE

	return ..()

/mob/living/simple_animal/hostile/retaliate/rogue/proc/UniqueAttack()
	if(body_eater && !tame)
		if(isliving(target))
			var/mob/living/body = target
			if(body.stat != CONSCIOUS)
				can_act = FALSE
				/*
				* Dodge is divided by 10 so
				* hits while eating are easier.
				*/
				dodge_prob /= 10
				DismemberBody(body)
				dodge_prob *= 10
				can_act = TRUE
				return TRUE

	//Now this is eating!
	if(is_type_in_list(target, food_type))
		playsound(src,'sound/misc/eat.ogg', rand(30,60), TRUE)
		qdel(target)
		food = max(food + 30, food_max + 50)
		return TRUE

/mob/living/simple_animal/hostile/retaliate/rogue/proc/DismemberBody(mob/living/L)
	//Lets keep track of this to see if we start getting wounded while eating.
	testing("[src]_eating_[L]")
	//I dont know why but the do_after for health needs this to be defined like this.
	var/list/check_health = list("health" = src.health)

	if(L.stat != CONSCIOUS)
		src.visible_message(span_danger("[src] starts to rip apart [L]!"))
		if(attack_sound)
			playsound(src, pick(attack_sound), 100, TRUE, -1)
		//If their health is decreased at all during the 10 seconds the dismemberment will fail and they will lose target.
		if(do_after(user = src, delay = 10 SECONDS, target = L, extra_checks = CALLBACK(src, TYPE_PROC_REF(/mob, break_do_after_checks), check_health, FALSE)))
			//If its carbon remove a limb, if its some animal just gib it.
			if(iscarbon(L))
				var/mob/living/carbon/C = L
				var/obj/item/bodypart/limb
				var/list/limb_list = list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
				for(var/zone in limb_list)
					limb = C.get_bodypart(zone)
					if(limb)
						limb.dismember()
						return TRUE
				limb = C.get_bodypart(BODY_ZONE_HEAD)
				if(limb)
					limb.dismember()
					return TRUE
				limb = C.get_bodypart(BODY_ZONE_CHEST)
				if(limb)
					if(!limb.dismember())
						C.gib()
					return TRUE
			else
				L.gib()
				return TRUE
		LoseTarget()

/mob/living/simple_animal/hostile/retaliate/rogue/Initialize()
	. = ..()
	if(tame)
		tamed(owner)
	ADD_TRAIT(src, TRAIT_SIMPLE_WOUNDS, TRAIT_GENERIC)

/mob/living/simple_animal/hostile/retaliate/rogue/GiveTarget(new_target)
	..()
	/*
	* I considered making a true/false proc for
	* this since for some structures it may be
	* better for cowardly creatures to run.
	*/
	if(isitem(new_target) || isstructure(new_target))
		retreat_distance = 0
		minimum_distance = 1

/mob/living/simple_animal/hostile/retaliate/rogue/LoseTarget()
	..()
	retreat_distance = initial(retreat_distance)
	minimum_distance = initial(minimum_distance)

/mob/living/simple_animal/hostile/retaliate/rogue/tamed(mob/user)
	del_on_deaggro = 0
	aggressive = 0
	if(enemies.len)
		if(prob(23))
			enemies = list()
			src.visible_message(span_info("[src] calms down."))
			LoseTarget()
		else
			return
	..()


/mob/living/simple_animal/hostile/retaliate/rogue/Life()
	. = ..()
	if(.)
		if(enemies.len)
			if(prob(5))
				emote("cidle")
			if(prob(deaggroprob))
				if(mob_timers["aggro_time"])
					if(world.time > mob_timers["aggro_time"] + 30 SECONDS)
						enemies = list()
						src.visible_message(span_info("[src] calms down."))
						LoseTarget()
				else
					mob_timers["aggro_time"] = world.time
		else
			if(prob(8))
				emote("idle")
			if(adult_growth)
				growth_prog += 0.5
				if(growth_prog >= 100)
					if(isturf(loc))
						var/mob/living/simple_animal/A = new adult_growth(loc)
						if(tame)
							A.tame = TRUE
						qdel(src)
						return
			else
				if(childtype)
					make_babies()


/mob/living/simple_animal/hostile/retaliate/rogue/Retaliate()
//	if(!enemies.len && message)
//		src.visible_message("<span class='warning'>[src] panics!</span>")
//	if(flee)
//		retreat_distance = 10
//		minimum_distance = 10
	mob_timers["aggro_time"] = world.time
	..()


//Prevents certain items from being targeted as food.
/mob/living/simple_animal/hostile/retaliate/rogue/proc/PickyEater(atom/thing_to_eat)
	//Yes we eats this.
	. = TRUE
	if(istype(thing_to_eat, /obj/item/bodypart))
		var/obj/item/bodypart/B = thing_to_eat
		//Oh yuck ew dont eat that.
		if(B.status != BODYPART_ORGANIC)
			return FALSE

/mob/living/simple_animal/hostile/retaliate/rogue/proc/return_action()
	stop_automated_movement = FALSE
	walk(src,0)

/mob/living/simple_animal/hostile/retaliate/rogue/shood(mob/user)
	if(tame)
		Retaliate()

/mob/living/simple_animal/hostile/retaliate/rogue/onkick(mob/M)
	..()
	Retaliate()
	GiveTarget(M)

/mob/living/simple_animal/hostile/retaliate/rogue/beckoned(mob/user)
	if(tame && !stop_automated_movement)
		stop_automated_movement = TRUE
		Goto(user,move_to_delay)
		addtimer(CALLBACK(src, PROC_REF(return_action)), 3 SECONDS)

/mob/living/simple_animal/hostile/retaliate/rogue/food_tempted(obj/item/O, mob/user)
	testing("tempted")
	if(is_type_in_list(O, food_type) && !stop_automated_movement)
		testing("infoodtype")
		stop_automated_movement = TRUE
		Goto(user,move_to_delay)
		addtimer(CALLBACK(src, PROC_REF(return_action)), 3 SECONDS)


//................. UDDER (GOTE).......................//
/obj/item/gudder

/obj/item/gudder/Initialize()
	create_reagents(100)
	reagents.add_reagent(/datum/reagent/consumable/milk/gote, rand(0,20))
	. = ..()

/obj/item/gudder/proc/generateMilk()
	reagents.add_reagent(/datum/reagent/consumable/milk/gote, 1)

/obj/item/gudder/proc/milkAnimal(obj/O, mob/living/user = usr)
	var/obj/item/reagent_containers/glass/G = O
	if(G.reagents.total_volume >= G.volume)
		to_chat(user, span_warning("[O] is full."))
		return
	if(!reagents.has_reagent(/datum/reagent/consumable/milk/gote, 5))
		to_chat(user, span_warning("The udder is dry. Wait a bit longer..."))
		user.changeNext_move(10)
		return
	if(do_after(user, 1 SECONDS, src))
		reagents.trans_to(O, rand(5,10))
		user.visible_message(span_notice("[user] milks [src] using \the [O]"))
		playsound(O, pick('sound/vo/mobs/cow/milking (1).ogg', 'sound/vo/mobs/cow/milking (2).ogg'), 100, TRUE, -1)
		user.Immobilize(1 SECONDS)
		user.changeNext_move(1 SECONDS)


/mob/living/simple_animal/hostile/retaliate/rogue/UnarmedAttack(atom/A)
	. = ..()
	if(!is_type_in_list(A, food_type))
		return

	if(!src.CanReach(A))
		return

	face_atom(A)
	playsound(src,'sound/misc/eat.ogg', rand(30,60), TRUE)
	qdel(A)
	food = max(food + 30, 100)
