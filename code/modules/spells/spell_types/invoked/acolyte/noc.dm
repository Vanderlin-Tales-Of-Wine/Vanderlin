/obj/effect/proc_holder/spell/invoked/blindness/miracle
	name = "Blindness"
	overlay_state = "blindness"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/magic/churn.ogg'
	req_items = list(/obj/item/clothing/neck/psycross/noc)
	invocation = "Noc blinds thee of thy sins!"
	invocation_type = "shout" //can be none, whisper, emote and shout
	antimagic_allowed = TRUE
	recharge_time = 2 MINUTES
	associated_skill = /datum/skill/magic/holy
	miracle = TRUE
	devotion_cost = 30

/obj/effect/proc_holder/spell/invoked/invisibility
	name = "Invisibility"
	overlay_state = "invisibility"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	recharge_time = 2 MINUTES
	range = 3
	warnie = "sydwarning"
	movement_interrupt = FALSE
	req_items = list(/obj/item/clothing/neck/psycross/noc)
	invocation_type = "none"
	sound = 'sound/misc/area.ogg'
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	miracle = TRUE
	healing_miracle = TRUE
	devotion_cost = 60

/obj/effect/proc_holder/spell/invoked/invisibility/cast(list/targets, mob/living/user)
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target.anti_magic_check(TRUE, TRUE))
			return FALSE
		target.apply_status_effect(/datum/status_effect/invisibility, 30 SECONDS)
		return ..()
	return FALSE

/obj/effect/proc_holder/spell/invoked/projectile/moondagger
	name = "Moonlit Dagger"
	desc = "Fire off a piercing moonlit-dagger, smiting unholy creechers!"
	overlay_state = "moondagger"
	req_items = list(/obj/item/clothing/neck/psycross/noc)
	invocation = "Begone foul beasts!"
	invocation_type = "shout" //can be none, whisper, emote and shout
	associated_skill = /datum/skill/magic/holy
	recharge_time = 40 SECONDS
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

/obj/projectile/magic/moondagger/on_hit(mob/living/carbon/human/target, blocked = FALSE)
	. = ..()
	if(!ishuman(target))
		return

	var/datum/antagonist/werewolf/wolf_datum = target.mind?.has_antag_datum(/datum/antagonist/werewolf/)
	var/datum/antagonist/vampire/sucker_datum = target.mind?.has_antag_datum(/datum/antagonist/vampire/)
	if(istype(sucker_datum, /datum/antagonist/vampire/lord))
		var/datum/antagonist/vampire/lord/sucker_lord = sucker_datum //I am very mature
		if(sucker_lord.ascended >= 4)
			target.visible_message(span_danger("\The [src] fails to affect [target]!"), span_userdanger("Feeble metal cannot hurt me, I AM THE ANCIENT!"))
			return

	if(wolf_datum?.transformed || sucker_datum)
		target.visible_message(span_danger("\The [src] weakens [target]'s curse temporarily!"), span_userdanger("I'm hit by my BANE!"))
		target.apply_status_effect(/datum/status_effect/debuff/silver_curse)

