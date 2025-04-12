//intended to be used for anything that is applied to the skin directly, think of it like one-use bandages/cloths
//the effects are instatenous, naturally for having such miraclous restorative properties, there should be downsides

/obj/item/natural/paste
	name = "paste"
	desc = "Paste. Ointment. Whatever. You shouldn't be seeing this"
	possible_item_intents = list(/datum/intent/use)
	force = 0
	throwforce = 0
	resistance_flags = FLAMMABLE
	body_parts_covered = null
	max_integrity = 10
	w_class = WEIGHT_CLASS_TINY
	var/brute_heal = 0	//this is how much brute damage the paste should heal
	var/burn_heal = 0	//this is how much burn damage the paste should heal
	var/blood_heal = 0	//this is how much blood the paste should restore
	var/toxicity = 0	//this is how much tox damage the paste should apply, in negatives
	var/painful = FALSE	//if true, applying the paste will cause the target to scream in pain and be stunned for a moment

// code copied from cloth bandaging, but changed obviously
/obj/item/natural/paste/attack(mob/living/M, mob/user)
	testing("attack")
	apply(M, user)

/obj/item/natural/paste/proc/apply(mob/living/M, mob/user)//was tempted to name this "smear" instead of "apply" I admit
	if(!M.can_inject(user, TRUE))
		return
	if(!ishuman(M))
		return
	var/mob/living/carbon/human/H = M
	var/obj/item/bodypart/affecting = H.get_bodypart(check_zone(user.zone_selected))
	if(!affecting)
		return
	var/used_time = 60
	if(H.mind)
		used_time -= (H.mind.get_skill_level(/datum/skill/misc/medicine) * 10)
	playsound(loc, 'sound/items/soaping.ogg', 100, FALSE)
	if(!do_after(user, used_time, M))
		return
	playsound(loc, 'sound/items/soaping.ogg', 100, FALSE)

	user.dropItemToGround(src)
	H.update_damage_overlays()

	M.blood_volume = min(M.blood_volume+blood_heal, BLOOD_VOLUME_MAXIMUM)//restores blood
	M.adjustToxLoss(toxicity)//applies tox damage
	affecting.heal_damage(brute_heal, burn_heal)//heals damage
	if(painful)
		M.emote("painscream")
		M.Stun(80)

	if(M == user)
		user.visible_message("<span class='notice'>[user] smears paste onto [user.p_their()] [affecting].</span>", "<span class='notice'>I smear paste onto my [affecting].</span>")
	else
		user.visible_message("<span class='notice'>[user] smears paste onto [M]'s [affecting].</span>", "<span class='notice'>I smear paste onto [M]'s [affecting].</span>")


/obj/item/natural/paste/mandrake
	name = "mandrake paste"
	desc = "Paste made from mandrake and manabloom, known for its restorative properties, especially for burns."
	burn_heal = 20
	blood_heal = 10
	toxicity = -5
	painful = TRUE
