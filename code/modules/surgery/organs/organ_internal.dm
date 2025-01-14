/obj/item/organ
	name = "organ"
	icon = 'icons/obj/surgery.dmi'
	var/mob/living/carbon/owner = null
	var/status = ORGAN_ORGANIC
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 0
	sellprice = 10

	grid_width = 32
	grid_height = 32

	var/zone = BODY_ZONE_CHEST
	var/slot
	// DO NOT add slots with matching names to different zones - it will break internal_organs_slot list!
	var/organ_flags = 0
	var/maxHealth = STANDARD_ORGAN_THRESHOLD
	var/damage = 0		//total damage this organ has sustained
	///Healing factor and decay factor function on % of maxhealth, and do not work by applying a static number per tick
	var/healing_factor 	= 0										//fraction of maxhealth healed per on_life(), set to 0 for generic organs
	var/decay_factor 	= 0										//same as above but when without a living owner, set to 0 for generic organs
	var/high_threshold	= STANDARD_ORGAN_THRESHOLD * 0.45		//when severe organ damage occurs
	var/low_threshold	= STANDARD_ORGAN_THRESHOLD * 0.1		//when minor organ damage occurs

	///Organ variables for determining what we alert the owner with when they pass/clear the damage thresholds
	var/prev_damage = 0
	var/low_threshold_passed
	var/high_threshold_passed
	var/now_failing
	var/now_fixed
	var/high_threshold_cleared
	var/low_threshold_cleared
	dropshrink = 0.85

	/// Whether the organ is fully internal and should not be seen by bare eyes.
	var/visible_organ = FALSE
	/// Description when the organ is visible and examined while it's attached to a bodypart.
	var/bodypart_desc = "This is an organ."
	/// Icon of the organ when it's on a bodypart.
	var/bodypart_icon
	/// Icon state of the organ when it's on a bodypart.
	var/bodypart_icon_state
	/// Layer of the overlay this organs renders for being on limbs.
	var/bodypart_layer = BODY_LAYER
	/// Instead of creating an overlay from above variables we can use a sprite accessory.
	var/accessory_type
	/// Color list string for complex overlay generation through sprite accessory.
	var/accessory_colors
	/// Whether the bodypart organ overlay is an emissive blocker
	var/bodypart_emissive_blocker = TRUE
	/// Type of organ DNA that this organ will create.
	var/organ_dna_type = /datum/organ_dna


/obj/item/organ/proc/Insert(mob/living/carbon/M, special = 0, drop_if_replaced = TRUE)
	if(!iscarbon(M) || owner == M)
		return

	var/obj/item/organ/replaced = M.getorganslot(slot)
	if(replaced)
		replaced.Remove(M, special = 1)
		if(drop_if_replaced)
			replaced.forceMove(get_turf(M))
		else
			qdel(replaced)

	owner = M
	M.internal_organs |= src
	M.internal_organs_slot[slot] = src
	moveToNullspace()
	for(var/X in actions)
		var/datum/action/A = X
		A.Grant(M)
	update_accessory_colors()
	STOP_PROCESSING(SSobj, src)

//Special is for instant replacement like autosurgeons
/obj/item/organ/proc/Remove(mob/living/carbon/M, special = FALSE, drop_if_replaced = TRUE)
	owner = null
	if(M)
		M.internal_organs -= src
		if(M.internal_organs_slot[slot] == src)
			M.internal_organs_slot.Remove(slot)
		if((organ_flags & ORGAN_VITAL) && !special && !(M.status_flags & GODMODE))
			M.death()
	for(var/X in actions)
		var/datum/action/A = X
		A.Remove(M)
	update_icon()
//	START_PROCESSING(SSobj, src)


/obj/item/organ/proc/on_find(mob/living/finder)
	return

/obj/item/organ/process()
	on_death() //Kinda hate doing it like this, but I really don't want to call process directly.

/obj/item/organ/proc/on_death()	//runs decay when outside of a person
	if(organ_flags & (ORGAN_SYNTHETIC | ORGAN_FROZEN))
		return
	applyOrganDamage(maxHealth * decay_factor)

/obj/item/organ/proc/on_life()	//repair organ damage if the organ is not failing
	if(organ_flags & ORGAN_FAILING)
		return
	///Damage decrements by a percent of its maxhealth
	var/healing_amount = -(maxHealth * healing_factor)
	///Damage decrements again by a percent of its maxhealth, up to a total of 4 extra times depending on the owner's health
	healing_amount -= owner.satiety > 0 ? 4 * healing_factor * owner.satiety / MAX_SATIETY : 0
	applyOrganDamage(healing_amount)

/obj/item/organ/examine(mob/user)
	. = ..()
	if(organ_flags & ORGAN_FAILING)
		if(status == ORGAN_ROBOTIC)
			to_chat(user, ("<span class='warning'>[src] seems to be broken!"))
			return
		to_chat(user, ("<span class='warning'>[src] has decayed for too long, and has turned a sickly color! It doesn't look like it will work anymore!"))
		return
	if(damage > high_threshold)
		to_chat(user, ("<span class='warning'>[src] is starting to look discolored."))


/obj/item/organ/proc/prepare_eat(mob/living/carbon/human/user)
	var/obj/item/reagent_containers/food/snacks/organ/S = new
	S.name = name
	S.desc = desc
	S.icon = icon
	S.icon_state = icon_state
	S.w_class = w_class

	return S

/obj/item/reagent_containers/food/snacks/organ
	name = "appendix"
	icon_state = "appendix"
	icon = 'icons/obj/surgery.dmi'
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/organpoison = 1)
	grind_results = list(/datum/reagent/organpoison = 3)
	foodtype = RAW | MEAT | GROSS
	eat_effect = /datum/status_effect/debuff/uncookedfood

/obj/item/reagent_containers/food/snacks/organ/On_Consume(mob/living/eater)
	if(HAS_TRAIT(eater, TRAIT_ORGAN_EATER))
		eat_effect = /datum/status_effect/buff/foodbuff
	. = ..()
	eat_effect = initial(eat_effect)

/obj/item/organ/Initialize()
	. = ..()
	if(accessory_type)
		set_accessory_type(accessory_type)
	START_PROCESSING(SSobj, src)

/obj/item/organ/Destroy()
	if(owner)
		// The special flag is important, because otherwise mobs can die
		// while undergoing transformation into different mobs.
		Remove(owner, special=TRUE)
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/organ/attack(mob/living/carbon/M, mob/user)
	if(M == user && ishuman(user))
		var/mob/living/carbon/human/H = user
		if(status == ORGAN_ORGANIC)
			var/obj/item/reagent_containers/food/snacks/S = prepare_eat(H)
			if(S)
				qdel(src)
				if(H.put_in_active_hand(S))
					S.attack(H, H)
	else
		..()

/obj/item/organ/item_action_slot_check(slot,mob/user)
	return //so we don't grant the organ's action to mobs who pick up the organ.

///Adjusts an organ's damage by the amount "d", up to a maximum amount, which is by default max damage
/obj/item/organ/proc/applyOrganDamage(d, maximum = maxHealth)	//use for damaging effects
	if(!d) //Micro-optimization.
		return
	if(maximum < damage)
		return
	damage = CLAMP(damage + d, 0, maximum)
//	var/mess = check_damage_thresholds(owner)
	prev_damage = damage
//	if(mess && owner)
//		to_chat(owner, mess)

///SETS an organ's damage to the amount "d", and in doing so clears or sets the failing flag, good for when you have an effect that should fix an organ if broken
/obj/item/organ/proc/setOrganDamage(d)	//use mostly for admin heals
	applyOrganDamage(d - damage)

/** check_damage_thresholds
 * input: M (a mob, the owner of the organ we call the proc on)
 * output: returns a message should get displayed.
 * description: By checking our current damage against our previous damage, we can decide whether we've passed an organ threshold.
 *				 If we have, send the corresponding threshold message to the owner, if such a message exists.
 */
/obj/item/organ/proc/check_damage_thresholds(mob/M)
	if(damage == prev_damage)
		return
	var/delta = damage - prev_damage
	if(delta > 0)
		if(damage >= maxHealth)
			organ_flags |= ORGAN_FAILING
			if((organ_flags & ORGAN_VITAL) && M && (M.stat < DEAD) && !(M.status_flags & GODMODE))
				M.death()
			return now_failing
		if(damage > high_threshold && prev_damage <= high_threshold)
			return high_threshold_passed
		if(damage > low_threshold && prev_damage <= low_threshold)
			return low_threshold_passed
	else
		organ_flags &= ~ORGAN_FAILING
		if(prev_damage > low_threshold && damage <= low_threshold)
			return low_threshold_cleared
		if(prev_damage > high_threshold && damage <= high_threshold)
			return high_threshold_cleared
		if(prev_damage == maxHealth)
			return now_fixed

/// Gets organ description for when its attached to a bodypart.
/obj/item/organ/proc/get_bodypart_desc()
	return bodypart_desc

/// Whether the organ is visible and should appear on a bodypart.
/obj/item/organ/proc/is_visible()
	/// It's an internal organ, always hidden.
	if(!visible_organ)
		return FALSE
	/// Doesn't have an owner so it couldn't be covered by anything.
	if(!owner)
		return TRUE
	if(!is_visible_on_owner())
		return FALSE
	return TRUE

/obj/item/organ/proc/is_visible_on_owner()
	return TRUE

/// Gets the organ overlay.
/obj/item/organ/proc/get_bodypart_overlay(obj/item/bodypart/bodypart)
	if(!bodypart_icon && !accessory_type)
		return

	if(accessory_type)
		var/datum/sprite_accessory/accessory = SPRITE_ACCESSORY(accessory_type)
		var/list/appearances = accessory.get_appearance(src, bodypart, accessory_colors)
		if(!appearances)
			return
		for(var/standing in appearances)
			bodypart_icon(standing)
			bodypart_overlays(standing)
		return appearances
	else
		var/mutable_appearance/organ_overlay = mutable_appearance(bodypart_icon, bodypart_icon_state, layer = -bodypart_layer)
		organ_overlay.color = color
		bodypart_icon(organ_overlay)

		/*
		if(bodypart_emissive_blocker)
			organ_overlay.overlays += emissive_blocker(bodypart_icon, bodypart_icon_state)
		*/

		bodypart_overlays(organ_overlay)
		return organ_overlay

/// Proc to customize the base icon of the organ.
/obj/item/organ/proc/bodypart_icon(mutable_appearance/standing)
	return

/// This proc can add overlays to the organ image that is to be attached to a bodypart.
/obj/item/organ/proc/bodypart_overlays(mutable_appearance/standing)
	return

/obj/item/organ/proc/get_availability(datum/species/owner_species)
	return TRUE

/// Sets an accessory type and optionally colors too.
/obj/item/organ/proc/set_accessory_type(new_accessory_type, colors)
	accessory_type = new_accessory_type
	if(!isnull(colors))
		accessory_colors = colors
	var/datum/sprite_accessory/accessory = SPRITE_ACCESSORY(accessory_type)
	accessory_colors = accessory.validate_color_keys_for_owner(owner, colors)
	update_accessory_colors()

/obj/item/organ/proc/build_colors_for_accessory(list/source_key_list)
	if(!accessory_type)
		return
	if(!source_key_list)
		if(!owner)
			return
		source_key_list = color_key_source_list_from_carbon(owner)
	var/datum/sprite_accessory/accessory = SPRITE_ACCESSORY(accessory_type)
	accessory_colors = accessory.get_default_colors(source_key_list)
	accessory_colors = accessory.validate_color_keys_for_owner(owner, accessory_colors)
	update_accessory_colors()

/// Creates, imprints and returns an organ DNA datum.
/obj/item/organ/proc/create_organ_dna()
	var/datum/organ_dna/organ_dna = new organ_dna_type()
	imprint_organ_dna(organ_dna)
	return organ_dna

/// Imprints an organ DNA datum.
/obj/item/organ/proc/imprint_organ_dna(datum/organ_dna/organ_dna)
	organ_dna.organ_type = type
	if(accessory_type)
		organ_dna.accessory_type = accessory_type
		organ_dna.accessory_colors = accessory_colors

/obj/item/organ/proc/update_accessory_colors()
	return

//Looking for brains?
//Try code/modules/mob/living/carbon/brain/brain_item.dm

/mob/living/proc/regenerate_organs()
	return 0

/mob/living/carbon/regenerate_organs()
	if(dna?.species)
		dna.species.regenerate_organs(src)
		return

	else
		if(!getorganslot(ORGAN_SLOT_LUNGS))
			var/obj/item/organ/lungs/L = new()
			L.Insert(src)

		if(!getorganslot(ORGAN_SLOT_HEART))
			var/obj/item/organ/heart/H = new()
			H.Insert(src)

		if(!getorganslot(ORGAN_SLOT_TONGUE))
			var/obj/item/organ/tongue/T = new()
			T.Insert(src)

		if(!getorganslot(ORGAN_SLOT_EYES))
			var/obj/item/organ/eyes/E = new()
			E.Insert(src)

		if(!getorganslot(ORGAN_SLOT_EARS))
			var/obj/item/organ/ears/ears = new()
			ears.Insert(src)
