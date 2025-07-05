// There is literally an echantment system ?? why

/**
 * Component used for adding enchantment from the enchant weapon spell
 * Three types of enchantments are available:
 * 1. Searing Blade: Applies 8 burn damage through armor, per strike
 * 2. Force Blade: Increases the force of the weapon by 5.
 * 3. Durability: Increases the integrity and max integrity of the weapon by 100.
 */
/datum/component/enchanted_weapon
	/// Duration before we try to clean up
	var/duration = null
	/// How many times this can have its duration refreshed, -1 for infinite
	var/refresh_count
	/// Skill to determine if we can refresh
	var/refresh_skill
	/// Skill threshold required to refresh, 0 for none
	var/skill_threshold
	/// Enchantment type
	var/enchant_type
	/// Weakref to current user
	var/datum/weakref/current_user
	/// Timer reference, for timeleft
	var/decay_timer

/datum/component/enchanted_weapon/Initialize(
	duration = 15 MINUTES,
	refresh_count = 4,
	refresh_skill = /datum/skill/magic/arcane,
	skill_threshold = SKILL_LEVEL_JOURNEYMAN,
	enchant_type = SEARING_BLADE,
	current_user,
)
	if(!istype(parent, /obj/item/weapon))
		return COMPONENT_INCOMPATIBLE

	src.duration = duration
	src.refresh_count = refresh_count
	src.refresh_skill = refresh_skill
	src.enchant_type = enchant_type
	if(current_user)
		src.current_user = WEAKREF(current_user)

	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(on_equip))
	RegisterSignal(parent, COMSIG_ITEM_DROPPED, PROC_REF(on_drop))
	RegisterSignal(parent, COMSIG_ITEM_AFTERATTACK, PROC_REF(item_afterattack))
	RegisterSignal(parent, COMSIG_PARENT_QDELETING, PROC_REF(clean_up))

	var/obj/item/weapon/I = parent
	switch(enchant_type)
		if(FORCE_BLADE_ENCHANT)
			I.force += FORCE_BLADE_FORCE
			I.force_wielded += FORCE_BLADE_FORCE
			I.add_filter(FORCE_FILTER, 2, outline_filter(1, "#9400D3"))
		if(SEARING_BLADE_ENCHANT)
			I.add_filter(SEARING_FILTER, 2, outline_filter(1, "#64af18"))
		if(DURABILITY_ENCHANT)
			I.max_integrity += DURABILITY_INCREASE
			I.obj_integrity += DURABILITY_INCREASE
			I.add_filter(DURABILITY_FILTER, 2, outline_filter(1, "#808080"))

	decay_timer = addtimer(CALLBACK(src, PROC_REF(try_decay)), src.duration, TIMER_DELETE_ME|TIMER_STOPPABLE)

/datum/component/enchanted_weapon/Destroy()
	clean_up()
	return ..()

/datum/component/enchanted_weapon/proc/try_decay()
	var/mob/holder = current_user.resolve()
	if(QDELETED(holder))
		clean_up(TRUE)
		return
	if(!refresh_skill || !holder.has_skill(refresh_skill))
		clean_up(TRUE)
		return
	if(skill_threshold && (!holder.get_skill_level(refresh_skill) > skill_threshold))
		clean_up(TRUE)
		return

	decay_timer = addtimer(CALLBACK(src, PROC_REF(try_decay)), duration)

/datum/component/enchanted_weapon/proc/clean_up(delete = FALSE)
	current_user = null
	deltimer(decay_timer)
	var/obj/item/weapon/I = parent
	switch(enchant_type)
		if(FORCE_BLADE_ENCHANT)
			I.force -= FORCE_BLADE_FORCE
			I.force_wielded -= FORCE_BLADE_FORCE
			I.remove_filter(FORCE_FILTER)
		if(SEARING_BLADE_ENCHANT)
			I.remove_filter(SEARING_FILTER)
		if(DURABILITY_ENCHANT)
			I.max_integrity -= DURABILITY_INCREASE
			I.obj_integrity -= DURABILITY_INCREASE
			I.remove_filter(DURABILITY_FILTER)
	if(delete)
		qdel(src)

/datum/component/enchanted_weapon/proc/on_equip(datum/source, mob/user, slot)
	current_user = WEAKREF(user)

/datum/component/enchanted_weapon/proc/on_drop(datum/source, mob/user, slot)
	current_user = null

/datum/component/enchanted_weapon/proc/on_examine(datum/source, mob/user, list/examine_list)
	if(enchant_type == SEARING_BLADE_ENCHANT)
		examine_list += "This weapon is enchanted with a green flame enchantment."
	else if(enchant_type == FORCE_BLADE_ENCHANT)
		examine_list += "This weapon is enchanted with a force blade enchantment."
	else if(enchant_type == DURABILITY_ENCHANT)
		examine_list += "This weapon is enchanted with a durability enchantment."
	examine_list += "It will last for [timeleft(decay_timer) * SECONDS] more seconds."

/datum/component/enchanted_weapon/proc/item_afterattack(obj/item/source, atom/target, mob/user, proximity_flag, click_parameters)
	if(enchant_type == SEARING_BLADE_ENCHANT)
		if(isliving(target))
			var/mob/living/M = target
			M.adjustFireLoss(SEARING_BLADE_DAMAGE)
			to_chat(M, span_warning("Flames leaps from [source] and singes you!"))
			// Permanent temporary solution until I figure out how to hack a dynamic on mob sprites
			// Bypass parry & dodge btw.
