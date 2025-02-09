//Ported from Azure Peak made by Ephemeralis

#define CHURN_FILTER "churn_glow"

// T1: Avert End (channel on an adjacent target to slowly spend devotion to grant them NODEATH and ticks of oxyloss healing)

/obj/effect/proc_holder/spell/invoked/avert
	name = "Borrowed Time"
	desc = "Shield someone from the Undermaiden's gaze, preventing them from slipping into death for as long as your faith and fatigue may muster."
	req_items = list(/obj/item/clothing/neck/roguetown/psycross/silver/necra)
	associated_skill = /datum/skill/magic/holy
	miracle = TRUE
	devotion_cost = 10
	var/list/near_death_lines = list(
		"A haze begins to envelop me, but then suddenly recedes, as if warded back by some great light...",
		"A terrible weight bears down upon me, as if the wyrld itself were crushing me with its heft...",
		"The sound of a placid river drifts into hearing, followed by the ominous toll of a ferryman's bell...",
		"Some vast, immeasurably distant figure looms beyond my perception - I feel it, more than I see. It waits. It watches.",
	)

/obj/effect/proc_holder/spell/invoked/avert/cast(list/targets, mob/living/carbon/human/user)
	. = ..()
	var/atom/target = targets[1]
	if (!isliving(target))
		revert_cast()
		return FALSE

	var/mob/living/living_target = target
	if (!user.Adjacent(target))
		to_chat(user, span_warning("I must be beside [living_target] to avert Her gaze from [living_target.p_them()]!"))
		revert_cast()
		return FALSE

	// add the no-death trait to them....
	user.visible_message(span_notice("Whispering motes gently bead from [user]'s fingers as [user.p_they()] place a hand near [living_target], scriptures of the Undermaiden spilling from their lips..."), span_notice("I stand beside [living_target] and utter the hallowed words of Aeon's Intercession, staying Her grasp for just a little while longer..."))
	to_chat(user, span_small("I must remain still and at [living_target]'s side..."))
	to_chat(living_target, span_warning("An odd sensation blossoms in my chest, cold and unknown..."))

	ADD_TRAIT(living_target, TRAIT_NODEATH, "avert_spell")

	var/our_holy_skill = user.mind?.get_skill_level(associated_skill)
	var/tickspeed = 3 SECONDS + (5 * our_holy_skill)

	while(do_after(user, tickspeed, living_target))
		user.adjust_energy(-2.5)

		living_target.adjustOxyLoss(-10)
		living_target.blood_volume = max((BLOOD_VOLUME_SURVIVE * 1.5), living_target.blood_volume)

		if (living_target.health <= 5)
			if (prob(5))
				to_chat(living_target, span_small(pick(near_death_lines)))

		if (user.cleric?.check_devotion(src))
			user.cleric?.update_devotion(-10)
		else
			to_chat(user, span_warning("My devotion runs dry - the Intercession fades from my lips!"))
			break

	REMOVE_TRAIT(living_target, TRAIT_NODEATH, "avert_spell")

	user.visible_message(span_danger("[user]'s concentration breaks, the motes receding from [living_target] and into [user.p_their()] hand once more."), span_danger("My concentration breaks, and the Intercession falls silent."))

/obj/effect/proc_holder/spell/targeted/abrogation
	name = "Abrogation"
	range = 8
	overlay_state = "necra"
	releasedrain = 30
	chargedloop = /datum/looping_sound/invokeholy
	chargetime = 50
	chargedrain = 0.5
	charge_max = 30 SECONDS
	max_targets = 0
	cast_without_targets = TRUE
	req_items = list(/obj/item/clothing/neck/roguetown/psycross)
	sound = 'sound/magic/churn.ogg'
	associated_skill = /datum/skill/magic/holy
	invocation = "The Undermaiden rejects your presence!"
	invocation_type = "shout" //can be none, whisper, emote and shout
	miracle = TRUE
	devotion_cost = 20

/obj/effect/proc_holder/spell/targeted/abrogation/cast(list/targets, mob/living/user = usr)
	. = ..()
	var/debuff_power = 1
	if (user && user.mind)
		debuff_power = clamp((user.mind.get_skill_level(/datum/skill/magic/holy) / 2), 1, 3)

	var/too_powerful = FALSE
	var/list/things_to_churn = list()
	for (var/mob/living/L in targets)
		var/is_vampire = FALSE
		var/is_zombie = FALSE
		if(L.stat == DEAD)
			continue
		if (L.mind)
			var/datum/antagonist/vampirelord/lesser/V = L.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser)
			if (V && !V.disguised)
				is_vampire = TRUE
			if (L.mind.has_antag_datum(/datum/antagonist/zombie))
				is_zombie = TRUE
			if (L.mind.special_role == "Vampire Lord")
				too_powerful = L
				user.visible_message(span_warning("[user] suddenly pales before an unseen presence, and gasps!"), span_warning("The sound of rushing blood fills my ears and mind, drowning out my abrogation!"))
				break
		if (L.mob_biotypes & MOB_UNDEAD || is_vampire || is_zombie)
			things_to_churn += L

	if (!too_powerful)
		if (LAZYLEN(things_to_churn))
			user.visible_message(span_warning("A frigid blue glower suddenly erupts in [user]'s eyes as a whispered prayer summons forth a winding veil of ghostly mists!"), span_notice("I perform the sacred rite of Abrogation, bringing forth Her servants to harry and weaken the unliving!"))
			for(var/mob/living/thing in things_to_churn)
				thing.apply_status_effect(/datum/status_effect/churned, user, debuff_power)
		else
			to_chat(user, span_notice("The rite of Abrogation passes from my lips in silence, having found nothing to assail."))
			return
	else
		user.Stun(25)
		user.throw_at(get_ranged_target_turf(user, get_dir(user,too_powerful), 7), 7, 1, too_powerful, spin = FALSE)
		user.visible_message(span_warning("[user] ceases their prayer, suddenly choking upon a gout of blood in their throat!"), span_boldwarning("My vision swims in red!"))

/atom/movable/screen/alert/status_effect/churned
	name = "Churning Essence"
	desc = "The magicks that bind me into being are being disrupted! I should get away from the source as soon as I can!"
	icon_state = "stressvb"

/datum/status_effect/churned
	id = "necra_churned"
	alert_type = /atom/movable/screen/alert/status_effect/churned
	duration = 30 SECONDS
	examine_text = "<b>SUBJECTPRONOUN is wreathed in a wild frenzy of ghostly motes!</b>"
	effectedstats = list("strength" = -2, "constitution" = -2, "endurance" = -2, "speed" = -2)
	status_type = STATUS_EFFECT_REFRESH
	var/datum/weakref/debuffer
	var/outline_colour = "#33cabc"
	var/base_tick = 0.2
	var/intensity = 1
	var/range = 10

/datum/status_effect/churned/on_creation(mob/living/new_owner, mob/living/caster, potency)
	intensity = potency
	if (caster)
		debuffer = WEAKREF(caster)
	return ..()

/datum/status_effect/churned/on_apply()
	var/filter = owner.get_filter(CHURN_FILTER)
	to_chat(owner, span_warning("Wisps leap from the cloying mists to surround me, their chill disrupting my body! FLEE!"))
	if (!filter)
		owner.add_filter(CHURN_FILTER, 2, list("type" = "outline", "color" = outline_colour, "alpha" = 200, "size" = 1))
	return TRUE

/datum/status_effect/churned/refresh()
	. = ..()
	intensity += 1
	to_chat(owner, span_boldwarning("The mists intensify, the glowing wisps steadily disrupting my body..."))

/datum/status_effect/churned/process()
	. = ..()
	if (!owner)
		return
	if (prob(66))
		owner.adjustFireLoss(base_tick * intensity)
	if (prob(10))
		to_chat(owner, span_warning("A frenzy of ghostly motes assail my form!"))
		owner.emote("scream")

	var/mob/living/our_debuffer = debuffer.resolve()
	if (get_dist(our_debuffer, owner) > range)
		to_chat(owner, span_notice("I've escaped the cloying mists!"))
		qdel(src)

/datum/status_effect/churned/on_remove()
	owner.remove_filter(CHURN_FILTER)

#undef CHURN_FILTER
