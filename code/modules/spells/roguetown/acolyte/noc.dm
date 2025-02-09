/obj/effect/proc_holder/spell/invoked/blindness
	name = "Blindness"
	overlay_state = "blindness"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/magic/churn.ogg'
	req_items = list(/obj/item/clothing/neck/roguetown/psycross/noc)
	invocation = "Noc blinds thee of thy sins!"
	invocation_type = "shout" //can be none, whisper, emote and shout
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 2 MINUTES
	devotion_cost = 30

/obj/effect/proc_holder/spell/invoked/blindness/cast(list/targets, mob/user = usr)
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target.anti_magic_check(TRUE, TRUE))
			return FALSE
		target.visible_message("<span class='warning'>[user] points at [target]'s eyes!</span>","<span class='warning'>My eyes are covered in darkness!</span>")
		target.blind_eyes(3)
		return ..()
	return FALSE

/obj/effect/proc_holder/spell/invoked/invisibility
	name = "Invisibility"
	overlay_state = "invisibility"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	charge_max = 2 MINUTES
	range = 3
	warnie = "sydwarning"
	movement_interrupt = FALSE
	req_items = list(/obj/item/clothing/neck/roguetown/psycross/noc)
	invocation_type = "none"
	sound = 'sound/misc/area.ogg'
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	miracle = TRUE
	devotion_cost = 60

/obj/effect/proc_holder/spell/invoked/invisibility/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target.anti_magic_check(TRUE, TRUE))
			return FALSE
		target.apply_status_effect(/datum/status_effect/invisibility, 30 SECONDS)
		return ..()
	return FALSE

/obj/effect/proc_holder/spell/invoked/darkvision
	name = "Darkvision"
	desc = "Be granted truesight, the better to behold the truth of the world with."
	clothes_req = list(/obj/item/clothing/neck/roguetown/psycross/noc)
	invocation = "Noc, bestow upon me your vision."
	invocation_type = "Whisper" //can be none, whisper, emote and shout
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 15 MINUTES
	devotion_cost = 40

/obj/effect/proc_holder/spell/self/darkvision/cast(list/targets, mob/living/user)
	playsound(get_turf(user), 'sound/magic/charged.ogg', 100, TRUE)
	if(do_after(user, 4 SECONDS))
		to_chat(user, span_notice("Your prayer is answered, the darkness lowers its veil."))
		playsound(get_turf(user), 'sound/magic/magic_nulled.ogg', 60, TRUE, -1)
		user.apply_status_effect(/datum/status_effect/buff/darkvision)
		return ..()
	return FALSE

/obj/effect/proc_holder/spell/invoked/projectile/moondagger
	name = "Moonlit Dagger"
	desc = "Fire off a piercing moonlit-dagger, smiting unholy creechers!"
	overlay_state = "moondagger"
	clothes_req = list(/obj/item/clothing/neck/roguetown/psycross/noc)
	invocation = "Begone foul beasts!"
	invocation_type = "shout" //can be none, whisper, emote and shout
	associated_skill = /datum/skill/magic/holy
	charge_max = 40 SECONDS
	devotion_cost = 40
	projectile_type = /obj/projectile/magic/moondagger

/obj/projectile/magic/moondagger
	name = "moondagger"
	icon_state = "moondagger"
	nodamage = FALSE
	damage_type = BRUTE
	damage = DAMAGE_DAGGER * 1.5
	range = 7
	hitsound = 'sound/blank.ogg'

/obj/projectile/magic/moondagger/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		var/datum/antagonist/werewolf/W = H.mind?.has_antag_datum(/datum/antagonist/werewolf/)
		var/datum/antagonist/vampirelord/lesser/V = H.mind?.has_antag_datum(/datum/antagonist/vampirelord/lesser)
		var/datum/antagonist/vampirelord/V_lord = H.mind?.has_antag_datum(/datum/antagonist/vampirelord/)
		if(V)
			if(V.disguised)
				H.visible_message("<font color='white'>\The [src] weakens [H]'s curse temporarily!</font>", span_userdanger("I'm hit by my BANE!"))
				H.apply_status_effect(/datum/status_effect/debuff/silver_curse)
			else
				H.visible_message("<font color='white'>\The [src] weakens [H]'s curse temporarily!</font>", span_userdanger("I'm hit by my BANE!"))
				H.apply_status_effect(/datum/status_effect/debuff/silver_curse)
		if(V_lord)
			if(V_lord.vamplevel < 4 && !V)
				H.visible_message("<font color='white'>\The [src] weakens [H]'s curse temporarily!</font>", span_userdanger("I'm hit by my BANE!"))
				H.apply_status_effect(/datum/status_effect/debuff/silver_curse)
			if(V_lord.vamplevel == 4 && !V)
				H.visible_message("<font color='red'> The silver weapon fails to affect [H]!</font>", span_userdanger("This feeble metal can't hurt me, I AM ANCIENT!"))
		if(W && W.transformed == TRUE)
			H.visible_message("<font color='white'>\The [src] weakens [H]'s curse temporarily!</font>")
			to_chat(H, span_userdanger("I'm hit by my BANE!"))
			H.apply_status_effect(/datum/status_effect/debuff/silver_curse)

