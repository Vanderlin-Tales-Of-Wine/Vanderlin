//////////////////////
//# ABYSSOR'S RAGE #//
//////////////////////
/obj/effect/proc_holder/spell/invoked/projectile/swordfish
	name = "Abyssor's Rage"
	overlay_state = "curse2"
	releasedrain = 50
	chargetime = 20
	range = 10
	projectile_type = /obj/projectile/magic/swordfish
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = /datum/looping_sound/invokegen
	req_items = list(/obj/item/clothing/neck/roguetown/psycross/silver/abyssor)
	sound = 'sound/magic/whiteflame.ogg'
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	miracle = TRUE
	charge_max = 2.5 MINUTES
	devotion_cost = 50

/obj/item/reagent_containers/food/snacks/fish/swordfish
	name = "Swordfish"
	desc = "But one enactor of Abyssor's wrath."
	icon = 'icons/roguetown/misc/fish.dmi'
	icon_state = "swordfish"
	force = DAMAGE_DAGGER * 0.5
	dropshrink = 0.8
	possible_item_intents = list(/datum/intent/dagger/thrust)

/obj/projectile/magic/swordfish
	name = "Swordfish"
	desc = "But one enactor of Abyssor's wrath."
	damage = DAMAGE_DAGGER * 0.8
	nodamage = FALSE
	damage_type = BRUTE
	icon = 'icons/roguetown/misc/fish.dmi'
	icon_state = "swordfish_proj"
	range = 10
	dropped = /obj/item/reagent_containers/food/snacks/fish/swordfish
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 25
	armor_penetration = 10
	woundclass = BCLASS_STAB
	flag =  "piercing"
	speed = 0.4

/obj/projectile/magic/swordfish/on_hit(atom/target, blocked)
	. = ..()
	if(ismob(target))
		var/mob/hit = target
		if(hit.anti_magic_check())
			hit.visible_message("<span class='warning'>[src] vanishes on contact with [target]!</span>")
			return BULLET_ACT_BLOCK
	handle_drop()


/obj/projectile/magic/swordfish/handle_drop()
	var/turf/T = get_turf(src)
	dropped = new dropped(T)

/obj/projectile/magic/swordfish/on_range()
	handle_drop()
	..()
