/proc/accuracy_check(zone, mob/living/user, mob/living/target, associated_skill, datum/intent/used_intent, obj/item/I)
	if(!zone)
		return
	if(user == target)
		return zone
	if(zone == BODY_ZONE_CHEST)
		return zone
	if(target.grabbedby == user)
		if(user.grab_state >= GRAB_AGGRESSIVE)
			return zone
	if(target.lying)
		return zone
	if( (target.dir == turn(get_dir(target,user), 180)))
		return zone

	var/chance2hit = 0

	if(check_zone(zone) == zone)
		chance2hit += 10

	if(user.mind)
		chance2hit += (user.mind.get_skill_level(associated_skill) * 5)

	if(used_intent)
		if(used_intent.blade_class == BCLASS_STAB)
			chance2hit += 20
		if(used_intent.blade_class == BCLASS_CUT)
			chance2hit += 12

	if(I)
		if(I.wlength == WLENGTH_SHORT)
			chance2hit += 10

	if(user.STAPER > 10)
		chance2hit += ((user.STAPER-10)*3)

	if(user.STAPER < 10)
		chance2hit -= ((10-user.STAPER)*3)

	if(istype(user.rmb_intent, /datum/rmb_intent/aimed))
		chance2hit += 20
	if(istype(user.rmb_intent, /datum/rmb_intent/swift))
		chance2hit -= 40

	chance2hit = CLAMP(chance2hit, 5, 99)

	if(prob(chance2hit))
		return zone
	else
		if(prob(chance2hit+5))
			if(check_zone(zone) == zone)
				return zone
			else
				if(user.client?.prefs.showrolls)
					to_chat(user, "<span class='warning'>Accuracy fail! [chance2hit]%</span>")
				return check_zone(zone)
		else
			if(user.client?.prefs.showrolls)
				to_chat(user, "<span class='warning'>Ultra accuracy fail! [chance2hit]%</span>")
			return BODY_ZONE_CHEST

/mob/proc/get_generic_parry_drain()
	return 30

/mob/living/proc/checkmiss(mob/living/user)
	if(user == src)
		return FALSE
	if(stat)
		return FALSE
	if(lying)
		return FALSE
	if(user.stat_roll(STATKEY_LCK,4,10,TRUE))
		var/list/usedp = list("Critical miss!", "Damn! Critical miss!", "No! Critical miss!", "It can't be! Critical miss!", "Betrayed by lady luck! Critical miss!", "Bad luck! Critical miss!", "Curse creation! Critical miss!", "What?! Critical miss!")
		to_chat(user, "<span class='boldwarning'>[pick(usedp)]</span>")
		flash_fullscreen("blackflash2")
		user.aftermiss()
		return TRUE


/mob/living/proc/checkdefense(datum/intent/intenty, mob/living/user)
	testing("begin defense")
	if(!cmode)
		return FALSE
	if(stat)
		return FALSE
	if(!canparry && !candodge) //mob can do neither of these
		return FALSE
	if(!cmode)
		return FALSE
	if(user == src)
		return FALSE
	if(!(mobility_flags & MOBILITY_MOVE))
		return FALSE

	if(client && used_intent)
		if(client.charging && used_intent.tranged && !used_intent.tshield)
			return FALSE

	var/prob2defend = user.defprob
	var/mob/living/H = src
	var/mob/living/U = user
	if(H && U)
		prob2defend = 0

	if(!can_see_cone(user))
		if(d_intent == INTENT_PARRY)
			return FALSE
		else
			prob2defend = max(prob2defend-15,0)

//	if(!cmode) // not currently used, see cmode check above
//		prob2defend = max(prob2defend-15,0)

	if(m_intent == MOVE_INTENT_RUN)
		prob2defend = max(prob2defend-15,0)

	switch(d_intent)
		if(INTENT_PARRY)
			if(HAS_TRAIT(src, TRAIT_CHUNKYFINGERS))
				return FALSE
			if(pulledby == user && pulledby.grab_state >= GRAB_AGGRESSIVE)
				return FALSE
			if(pulling == user && grab_state >= GRAB_AGGRESSIVE)
				return FALSE
			if(world.time < last_parry + setparrytime)
				if(!istype(rmb_intent, /datum/rmb_intent/riposte))
					return FALSE
			if(has_status_effect(/datum/status_effect/debuff/feinted))
				return FALSE
			if(has_status_effect(/datum/status_effect/debuff/riposted))
				return FALSE
			last_parry = world.time
			if(intenty && !intenty.canparry)
				return FALSE
			var/drained = user.defdrain
			var/weapon_parry = FALSE
			var/offhand_defense = 0
			var/mainhand_defense = 0
			var/highest_defense = 0
			var/obj/item/mainhand = get_active_held_item()
			var/obj/item/offhand = get_inactive_held_item()
			var/obj/item/used_weapon = mainhand
			var/force_shield = FALSE // If our offhand weapon is a shield type, turn this on to force us to block with it.

			if(mainhand)
				if(mainhand.can_parry)
					mainhand_defense += (H.mind ? (H.mind.get_skill_level(mainhand.associated_skill) * 20) : 20)
					mainhand_defense += (mainhand.wdefense * 10)
			if(offhand)
				if(offhand.can_parry)
					offhand_defense += (H.mind ? (H.mind.get_skill_level(offhand.associated_skill) * 20) : 20)
					offhand_defense += (offhand.wdefense * 10)
					if(istype(offhand, /obj/item/rogueweapon/shield))
						force_shield = TRUE
			if(!force_shield)
				if(mainhand_defense >= offhand_defense)
					highest_defense += mainhand_defense
				else
					used_weapon = offhand // If our offhand wins the defense thug-of-war, use it
					highest_defense += offhand_defense
			else
				used_weapon = offhand // Forced to parry with offhand since we have a shield there.
				highest_defense += offhand_defense

			var/defender_skill = 0
			var/attacker_skill = 0

			if(highest_defense <= (H.mind ? (H.mind.get_skill_level(/datum/skill/combat/unarmed) * 20) : 20))
				defender_skill = H.mind?.get_skill_level(/datum/skill/combat/unarmed)
				prob2defend += (defender_skill * 20)
				weapon_parry = FALSE
			else
				defender_skill = H.mind?.get_skill_level(used_weapon.associated_skill)
				prob2defend += highest_defense
				weapon_parry = TRUE

			if(U.mind)
				if(intenty.masteritem)
					attacker_skill = U.mind.get_skill_level(intenty.masteritem.associated_skill)
					prob2defend -= (attacker_skill * 20)
					if((intenty.masteritem.wbalance > 0) && (user.STASPD > src.STASPD)) //enemy weapon is quick, so get a bonus based on spddiff
						prob2defend -= ( intenty.masteritem.wbalance * ((user.STASPD - src.STASPD) * 10) )
				else
					attacker_skill = U.mind.get_skill_level(/datum/skill/combat/unarmed)
					prob2defend -= (attacker_skill * 20)

			if(HAS_TRAIT(H, TRAIT_GUIDANCE))
				prob2defend += 10
			if(HAS_TRAIT(U, TRAIT_GUIDANCE))
				prob2defend -= 10

			if(!(mobility_flags & MOBILITY_STAND))	// checks if laying down and applies 20% defense malus if so
				prob2defend *= 0.8
			prob2defend = clamp(prob2defend, 5, 95)
			if(src.client?.prefs.showrolls)
				to_chat(src, "<span class='info'>Roll to parry... [prob2defend]%</span>")

			if(prob(prob2defend))
				if(intenty.masteritem)
					if(intenty.masteritem.wbalance < 0 && user.STASTR > src.STASTR) //enemy weapon is heavy, so get a bonus scaling on strdiff
						drained = drained + ( intenty.masteritem.wbalance * ((user.STASTR - src.STASTR) * -5) )
			else
				to_chat(src, "<span class='warning'>The enemy defeated my parry!</span>")
				return FALSE

			drained = max(drained, 5)

			if(weapon_parry == TRUE)
				if(do_parry(used_weapon, drained, user)) //show message
					// defender skill gain
					if((mobility_flags & MOBILITY_STAND) && attacker_skill && (defender_skill < attacker_skill - SKILL_LEVEL_NOVICE))
						// No duping exp gains by attacking with a shield on active hand
						if(used_weapon == offhand && istype(used_weapon, /obj/item/rogueweapon/shield))
							// Most shield users aren't bright, let's not make it near impossible to learn
							var/boon = H.mind?.get_learning_boon(/obj/item/rogueweapon/shield)
							H.mind?.adjust_experience(/datum/skill/combat/shields, max(round(H.STAINT * boon), 0), FALSE)
						else
							H.mind?.adjust_experience(used_weapon.associated_skill, max(round(H.STAINT/2), 0), FALSE)

					var/obj/item/AB = intenty.masteritem

					//attacker skill gain

					if((U.mobility_flags & MOBILITY_STAND) && defender_skill && (attacker_skill < defender_skill - SKILL_LEVEL_NOVICE))
						if(AB)
							U.mind?.adjust_experience(AB.associated_skill, max(round(U.STAINT/2), 0), FALSE)
						else
							U.mind?.adjust_experience(/datum/skill/combat/unarmed, max(round(U.STAINT/2), 0), FALSE)

					var/obj/effect/temp_visual/dir_setting/block/blk = new(get_turf(src), get_dir(H, U))
					blk.icon_state = "p[U.used_intent.animname]"
					if(prob(66) && AB)
						if((used_weapon.flags_1 & CONDUCT_1) && (AB.flags_1 & CONDUCT_1))
							flash_fullscreen("whiteflash")
							user.flash_fullscreen("whiteflash")
							var/datum/effect_system/spark_spread/S = new()
							S.set_up(n = 1, loca = get_turf(src))
							S.start()
						else
							flash_fullscreen("blackflash2")
					else
						flash_fullscreen("blackflash2")

					var/dam2take = round((get_complex_damage(AB,user,used_weapon.blade_dulling)/2),1)
					if(dam2take)
						used_weapon.take_damage(max(dam2take,1), BRUTE, used_weapon.damage_type)
					return TRUE
				else
					return FALSE

			if(weapon_parry == FALSE)
				if(do_unarmed_parry(drained, user))
					if((mobility_flags & MOBILITY_STAND) && attacker_skill && (defender_skill < attacker_skill - SKILL_LEVEL_NOVICE))
						H.mind?.adjust_experience(/datum/skill/combat/unarmed, max(round(STAINT/2), 0), FALSE)
					flash_fullscreen("blackflash2")
					return TRUE
				else
					testing("failparry")
					return FALSE
		if(INTENT_DODGE)
			if(pulledby && pulledby.grab_state >= GRAB_AGGRESSIVE)
				return FALSE
			if(pulling == user)
				return FALSE
			if(world.time < last_dodge + dodgetime)
				if(!istype(rmb_intent, /datum/rmb_intent/riposte))
					return FALSE
			if(has_status_effect(/datum/status_effect/debuff/riposted))
				return FALSE
			last_dodge = world.time
			if(src.loc == user.loc)
				return FALSE
			if(intenty)
				if(!intenty.candodge)
					return FALSE
			if(candodge)
				var/list/dirry = list()
				var/dx = x - user.x
				var/dy = y - user.y
				if(abs(dx) < abs(dy))
					if(dy > 0)
						dirry += NORTH
						dirry += WEST
						dirry += EAST
					else
						dirry += SOUTH
						dirry += WEST
						dirry += EAST
				else
					if(dx > 0)
						dirry += EAST
						dirry += SOUTH
						dirry += NORTH
					else
						dirry += WEST
						dirry += NORTH
						dirry += SOUTH
				var/turf/turfy
				for(var/x in shuffle(dirry.Copy()))
					turfy = get_step(src,x)
					if(turfy)
						if(turfy.density)
							continue
						for(var/atom/movable/AM in turfy)
							if(AM.density)
								continue
						break
				if(pulledby)
					return FALSE
				if(!turfy)
					to_chat(src, "<span class='boldwarning'>There's nowhere to dodge to!</span>")
					return FALSE
				else
					if(do_dodge(user, turfy))
						flash_fullscreen("blackflash2")
						user.aftermiss()
						return TRUE
					else
						return FALSE
			else
				return FALSE

/mob/proc/do_parry(obj/item/W, parrydrain as num, mob/living/user)
	if(ishuman(src))
		var/mob/living/carbon/human/H = src
		if(H.adjust_stamina(parrydrain))
			if(W)
				playsound(get_turf(src), pick(W.parrysound), 100, FALSE)
			if(istype(rmb_intent, /datum/rmb_intent/riposte))
				src.visible_message("<span class='boldwarning'><b>[src]</b> ripostes [user] with [W]!</span>")
			else if(istype(W, /obj/item/rogueweapon/shield))
				src.visible_message("<span class='boldwarning'><b>[src]</b> blocks [user] with [W]!</span>")
				var/shieldur
				shieldur = round(((W.obj_integrity / W.max_integrity) * 100), 1)
				if(shieldur <= 30)
					src.visible_message("<span class='boldwarning'><b>\The [W] is about to break!</b></span>")
			else
				src.visible_message("<span class='boldwarning'><b>[src]</b> parries [user] with [W]!</span>")
			return TRUE
		else
			to_chat(src, "<span class='warning'>I'm too tired to parry!</span>")
			return FALSE //crush through
	else
		if(W)
			playsound(get_turf(src), pick(W.parrysound), 100, FALSE)
		return TRUE

/mob/proc/do_unarmed_parry(parrydrain as num, mob/living/user)
	if(ishuman(src))
		var/mob/living/carbon/human/H = src
		if(H.adjust_stamina(parrydrain))
			playsound(get_turf(src), pick(parry_sound), 100, FALSE)
			src.visible_message("<span class='warning'><b>[src]</b> parries [user] with their hands!</span>")
			return TRUE
		else
			to_chat(src, "<span class='boldwarning'>I'm too tired to parry!</span>")
			return FALSE
	else
		playsound(get_turf(src), pick(parry_sound), 100, FALSE)
		return TRUE


/mob/proc/do_dodge(mob/user, turf/turfy)
	if(dodgecd)
		return FALSE

	var/mob/living/D = src
	var/mob/living/A = user
	var/mob/living/carbon/human/DH
	var/mob/living/carbon/human/AH
	var/obj/item/I
	var/obj/item/DI = D.get_active_held_item()
	var/drained = 10
	var/dodge_speed = floor(D.STASPD / 2)

	if(ishuman(src))
		DH = src
	if(ishuman(user))
		AH = user
		I = AH.used_intent.masteritem

	var/dodge_score = D.defprob
	if(D.stamina >= D.maximum_stamina)
		return FALSE
	if(!(D.mobility_flags & MOBILITY_STAND))							//Can't dodge when knocked down
		return FALSE
	if(D)
		if(D?.check_dodge_skill())
			dodge_score += (D.STASPD * 12)
		else
			dodge_score += ((D.STASPD * 10))
	if(A)
		dodge_score -= A.STASPD * 7
	if(I)
		if(AH?.mind)
			dodge_score -= (AH.mind.get_skill_level(I.associated_skill) * 10) //this means at legendary -60 dodge rating
	if(I)
		if(I.wbalance > 0)													//Enemy weapon is quick, so they get a bonus based on spddiff
			dodge_score -= ((A.STASPD - D.STASPD) * 5)

	dodge_score += (D.rmb_intent?.def_bonus)								//Dodge bonus from Poise

	if(HAS_TRAIT(D, TRAIT_GUIDANCE))
		dodge_score += 10
	if(HAS_TRAIT(A, TRAIT_GUIDANCE))
		dodge_score -= 10

				//// ADD WEAPON INTENT MODIFIERS HERE ////
	if(istype(DI, /obj/item/rogueweapon))
		switch(DI.wlength)
			if(WLENGTH_NORMAL)
				dodge_score -= 5
				drained += 2
			if(WLENGTH_LONG)
				dodge_score -= 10
				drained += 5
			if(WLENGTH_GREAT)
				dodge_score -= 15
				dodge_speed = floor(dodge_speed * 0.8)
				drained += 8
		dodge_score += (DI.wdodgebonus)
	dodge_score += (D.used_intent.idodgebonus)							//Some weapon intents help with dodging
	if(istype(DH))
		if(!DH?.check_armor_skill() || DH?.legcuffed)
			DH.Knockdown(1)
			return FALSE
		if(I)															//Attacker attacked us with a weapon
			if(!I.associated_skill)										//Attacker's weapon doesn't have a skill because its improvised, so penalty to attack
				dodge_score += 10
			else
				if(DH.mind)
					dodge_score += (DH.mind.get_skill_level(I.associated_skill) * 10)

		else //the enemy attacked us unarmed or is nonhuman
			if(AH)
				if(AH.used_intent.unarmed)
					if(AH.mind)
						dodge_score -= (AH.mind.get_skill_level(/datum/skill/combat/unarmed) * 10)
					if(DH.mind)
						dodge_score += (DH.mind.get_skill_level(/datum/skill/combat/unarmed) * 10)

		switch(DH.worn_armor_class)
			if(AC_LIGHT)
				dodge_speed -= 10
				drained += 5
			if(AC_MEDIUM)
				dodge_score *= 0.5
				dodge_speed = floor(dodge_speed * 0.5)
				drained += 10
			if(AC_HEAVY)
				dodge_score *= 0.2
				dodge_speed = floor(dodge_speed * 0.25)
				drained += 20

		dodge_score = clamp(dodge_score, 0, 95)
		var/dodgeroll = rand(1, 100)

		if(D.client?.prefs.showrolls)
			to_chat(src, span_info("Roll under [dodge_score] to dodge... [dodgeroll]"))
		if(dodgeroll > dodge_score)
			return FALSE
		if(!DH.adjust_stamina(max(drained, 5)))
			to_chat(src, span_warning("I'm too tired to dodge!"))
			return FALSE
	else																//Defender is non human
		dodge_score = clamp(dodge_score, 0, 95)
		var/dodgeroll = rand(1, 100)

		if(D.client?.prefs.showrolls)
			to_chat(src, span_info("Roll under [dodge_score] to dodge... [dodgeroll]"))
		if(dodgeroll > dodge_score)
			return FALSE
	dodgecd = TRUE
	dodge_speed = (11 - dodge_speed)
	playsound(src, 'sound/combat/dodge.ogg', 100, FALSE)
	throw_at(turfy, 1, dodge_speed, src, FALSE)
	if(drained > 0)
		src.visible_message(span_warning("<b>[src]</b> dodges [user]'s attack!"))
	else
		src.visible_message(span_warning("<b>[src]</b> easily dodges [user]'s attack!"))
	dodgecd = FALSE
//		if(H)
//			if(H.IsOffBalanced())
//				H.Knockdown(1)
//				to_chat(H, "<span class='danger'>I tried to dodge off-balance!</span>")
//		playsound(src, 'sound/combat/dodge.ogg', 100, FALSE)
//		if(isturf(loc))
//			var/turf/T = loc
//			if(T.landsound)
//				playsound(T, T.landsound, 100, FALSE)
	return TRUE
//	else
		//return FALSE

/mob/proc/food_tempted(/obj/item/W, mob/user)
	return

/mob/proc/taunted(mob/user)
	for(var/mob/living/simple_animal/hostile/retaliate/A in view(7,src))
		if(A.owner == user)
			A.emote("aggro")
			A.Retaliate()
			A.GiveTarget(src)
	return

/mob/proc/shood(mob/user)
	return

/mob/proc/beckoned(mob/user)
	return

/mob/proc/get_punch_dmg()
	return


/mob/proc/add_family_hud(antag_hud_type, antag_hud_name)
	var/datum/atom_hud/antag/hud = GLOB.huds[antag_hud_type]
	hud.join_hud(src)
	set_antag_hud(src, antag_hud_name)


/mob/proc/remove_family_hud(antag_hud_type)
	var/datum/atom_hud/antag/hud = GLOB.huds[antag_hud_type]
	hud.leave_hud(src)
	set_antag_hud(src, null)
