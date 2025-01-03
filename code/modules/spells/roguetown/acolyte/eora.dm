//eora

/obj/effect/proc_holder/spell/invoked/instill_perfection
	name = "Instill Perfection"
	desc = "Grants target a super-natural beauty for a time, increasing their mood."
	overlay_state = "perfume"
	charge_max = 7.5 MINUTES
	req_items = list(/obj/item/clothing/neck/roguetown/psycross/silver/eora)
	invocation = "Eora, lend some of your devine beauty!"
	invocation_type = "shout"
	releasedrain = 30
	miracle = TRUE
	devotion_cost = 25

/obj/effect/proc_holder/spell/invoked/instill_perfection/cast(list/targets,mob/living/user = usr)
	if(!isliving(targets[1]))
		return FALSE
	var/mob/living/selected = targets[1]
	selected.apply_status_effect(/datum/status_effect/buff/divine_beauty)
	return ..()


/obj/item/clothing/head/peaceflower
	name = "eoran bud"
	desc = "A flower of gentle petals, associated with Eora or Necra. Usually adorned as a headress or laid at graves as a symbol of love or peace."
	icon = 'modular/Neu_Farming/icons/produce.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head_items.dmi'
	icon_state = "peaceflower"
	item_state = "peaceflower"
	dropshrink = 0.9
	slot_flags = ITEM_SLOT_HEAD
	body_parts_covered = NONE
	dynamic_hair_suffix = ""
	force = 0
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 1
	throw_range = 3

/obj/item/clothing/head/peaceflower/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot == SLOT_HEAD)
		ADD_TRAIT(user, TRAIT_PACIFISM, "peaceflower_[REF(src)]")

/obj/item/clothing/head/peaceflower/dropped(mob/living/carbon/human/user)
	..()
	REMOVE_TRAIT(user, TRAIT_PACIFISM, "peaceflower_[REF(src)]")

/obj/item/clothing/head/peaceflower/attack_hand(mob/user)
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if(src == C.head)
			to_chat(user, "<span class='warning'>I feel at peace. <b style='color:pink'>Why would you want anything else?</b></span>")
			return
	return ..()

//Putting this here for now until we have a better place. Ook wants this to inject drugs eventually. I guess this is decent for now.
/obj/item/clothing/head/corruptflower
	name = "baothan bud"
	desc = "A flower of gentle petals and sharp thorns, associated with Baotha. It is said that these allow their wearer to better commune with their goddess."
	icon = 'modular/Neu_Farming/icons/produce.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head_items.dmi'
	icon_state = "corruptflower"
	item_state = "corruptflower"
	dropshrink = 0.9
	slot_flags = ITEM_SLOT_HEAD
	body_parts_covered = NONE
	dynamic_hair_suffix = ""
	force = 0
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 1
	throw_range = 3

/obj/item/clothing/head/corruptflower/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot == SLOT_HEAD)
		ADD_TRAIT(user, TRAIT_CRACKHEAD, "corruptflower_[REF(src)]")
		user.add_curse(/datum/curse/baotha)
		to_chat(user, "<span class='userdanger'>FUCK YES. Party on!</b></span>")

/obj/item/clothing/head/corruptflower/dropped(mob/living/carbon/human/user)
	..()
	user.remove_curse(/datum/curse/baotha)
	if(user.patron != /datum/patron/inhumen/baotha)
		REMOVE_TRAIT(user, TRAIT_CRACKHEAD, "corruptflower_[REF(src)]")

/obj/item/clothing/head/corruptflower/attack_hand(mob/user)
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if(src == C.head)
			to_chat(user, "<span class='warning'>Curse? What curse!? I feel great! Why would I ever want sobriety?</b></span>")
			return
	return ..()

/obj/effect/proc_holder/spell/invoked/bud
	name = "Eoran Bloom"
	desc = ""
	clothes_req = FALSE
	range = 7
	overlay_state = "love"
	sound = list('sound/magic/magnet.ogg')
	req_items = list(/obj/item/clothing/neck/roguetown/psycross/silver/eora)
	releasedrain = 40
	chargetime = 60
	warnie = "spellwarning"
	no_early_release = TRUE
	charging_slowdown = 1
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/holy
	charge_max = 5 MINUTES
	miracle = TRUE
	devotion_cost = 90

/obj/effect/proc_holder/spell/invoked/bud/cast(list/targets, mob/living/user)
	var/turf/T = get_turf(targets[1])
	if(!isclosedturf(T))
		new /obj/item/clothing/head/peaceflower(T)
		return ..()
	to_chat(user, "<span class='warning'>The targeted location is blocked. The flowers of Eora refuse to grow.</span>")
	return FALSE

/obj/effect/proc_holder/spell/invoked/projectile/eoracurse
	name = "Eora's Curse"
	overlay_state = "curse2"
	releasedrain = 50
	chargetime = 30
	range = 7
	projectile_type = /obj/projectile/magic/eora
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = null
	req_items = list(/obj/item/clothing/neck/roguetown/psycross/silver/eora)
	sound = 'sound/magic/whiteflame.ogg'
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	charge_max = 10 SECONDS
	miracle = TRUE
	devotion_cost = 75


/obj/projectile/magic/eora
	name = "wine bubble"
	icon_state = "leaper"
	paralyze = 50
	damage = 0
	range = 7
	hitsound = 'sound/blank.ogg'
	nondirectional_sprite = TRUE
	impact_effect_type = /obj/effect/temp_visual/wine_projectile_impact

/obj/projectile/magic/eora/on_hit(atom/target, blocked = FALSE)
	..()
	if(iscarbon(target))
		var/mob/living/carbon/C = target
		C.visible_message("<span class='info'>A purple haze shrouds [target]!</span>", "<span class='notice'>I feel like I've been drinking incredible amounts of wine...</span>")
		C.reagents.add_reagent(/datum/reagent/berrypoison, 3)
		C.apply_status_effect(/datum/status_effect/buff/drunk)
//		C.reagents.add_reagent(/datum/reagent/moondust, 3)
//		C.reagents.add_reagent(/datum/reagent/consumable/ethanol/beer/wine, 3)
		return
//	if(isanimal(target))
//		var/mob/living/simple_animal/L = target
//		L.adjustHealth(25)

/obj/projectile/magic/eora/on_range()
	var/turf/T = get_turf(src)
	..()
	new /obj/structure/wine_bubble(T)

/obj/effect/temp_visual/wine_projectile_impact
	name = "wine bubble"
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "leaper_bubble_pop"
	layer = ABOVE_ALL_MOB_LAYER
	duration = 3

/obj/structure/wine_bubble
	name = "wine bubble"
	desc = ""
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "leaper"
	max_integrity = 10
	density = FALSE

/obj/structure/wine_bubble/Initialize()
	. = ..()
	float(on = TRUE)
	QDEL_IN(src, 100)

/obj/structure/wine_bubble/Destroy()
	new /obj/effect/temp_visual/wine_projectile_impact(get_turf(src))
	playsound(src,'sound/blank.ogg',50, TRUE, -1)
	return ..()

/obj/structure/wine_bubble/Crossed(atom/movable/AM)
	if(isliving(AM))
		var/mob/living/L = AM
		playsound(src,'sound/blank.ogg',50, TRUE, -1)
		L.Paralyze(50)
		if(iscarbon(L))
			var/mob/living/carbon/C = L
			C.reagents.add_reagent(/datum/reagent/berrypoison, 3)
			C.apply_status_effect(/datum/status_effect/buff/drunk)
			C.visible_message("<span class='info'>A purple haze shrouds [L]!</span>", "<span class='notice'>I feel incredibly drunk...</span>")
//		if(isanimal(L))
//			var/mob/living/simple_animal/A = L
//			A.adjustHealth(25)
		qdel(src)
	return ..()

