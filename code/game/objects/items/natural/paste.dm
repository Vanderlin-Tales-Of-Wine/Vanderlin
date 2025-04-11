//intended to be used for anything that is applied to the skin directly, think of it like one-use bandages/cloths

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
	var/used_time = 70
	if(H.mind)
		used_time -= (H.mind.get_skill_level(/datum/skill/misc/medicine) * 10)
	playsound(loc, 'sound/items/soaping.ogg', 100, FALSE)
	if(!do_after(user, used_time, M))
		return
	playsound(loc, 'sound/items/soaping.ogg', 100, FALSE)

	user.dropItemToGround(src)
	H.update_damage_overlays()

	if(M == user)
		user.visible_message("<span class='notice'>[user] smears paste onto [user.p_their()] [affecting].</span>", "<span class='notice'>I smear paste onto my [affecting].</span>")
	else
		user.visible_message("<span class='notice'>[user] smears paste onto [M]'s [affecting].</span>", "<span class='notice'>I smear paste onto [M]'s [affecting].</span>")
