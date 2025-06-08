#define BLOWDART_DAMAGE		20
#define ARROW_DAMAGE		33
#define BOLT_DAMAGE			44
#define BULLET_DAMAGE		80
#define ARROW_PENETRATION	25
#define BOLT_PENETRATION	50
#define BULLET_PENETRATION	100

/*------\
| Bolts |
\------*/

/obj/item/ammo_casing/caseless/unembedded(mob/living/owner)
	if(!QDELETED(src) && prob(25))
		owner.visible_message(span_warning("[src] breaks as it falls out!"), vision_distance = COMBAT_MESSAGE_RANGE)
		qdel(src)
		return TRUE

//................ Crossbow Bolt ............... //
/obj/item/ammo_casing/caseless/bolt
	name = "bolt"
	desc = "A small and sturdy bolt, with simple plume and metal tip, alongside a groove to load onto a crossbow."
	projectile_type = /obj/projectile/bullet/reusable/bolt
	possible_item_intents = list(/datum/intent/dagger/thrust)
	caliber = "regbolt"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "bolt"
	dropshrink = 0.8
	max_integrity = 10
	force = DAMAGE_KNIFE-2
	embedding = list("embedded_pain_multiplier" = 3, "embedded_fall_chance" = 0)
	firing_effect_type = null

/obj/item/ammo_casing/caseless/bolt/Initialize()
	. = ..()
	AddElement(/datum/element/tipped_item, _max_reagents = 2, _dip_amount = 2, _attack_injects = FALSE)

/obj/projectile/bullet/reusable/bolt
	name = "bolt"
	desc = "A small and sturdy bolt, with simple plume and metal tip, alongside a groove to load onto a crossbow."
	damage = BOLT_DAMAGE
	damage_type = BRUTE
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "bolt_proj"
	ammo_type = /obj/item/ammo_casing/caseless/bolt
	range = 30
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 100
	armor_penetration = BOLT_PENETRATION
	woundclass = BCLASS_PIERCE
	flag =  "piercing"
	speed = 0.3
	accuracy = 85 //Crossbows have higher accuracy
	var/piercing = FALSE

/obj/projectile/bullet/reusable/bolt/Initialize()
	. = ..()
	create_reagents(50, NO_REACT)

/obj/projectile/bullet/reusable/bolt/on_hit(atom/target, blocked = FALSE)
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		if(blocked != 100) // not completely blocked
			if(M.can_inject(null, FALSE, def_zone, piercing)) // Pass the hit zone to see if it can inject by whether it hit the head or the body.
				..()
				reagents.reaction(M, INJECT)
				reagents.trans_to(M, reagents.total_volume)
				return BULLET_ACT_HIT
			else
				blocked = 100
				target.visible_message("<span class='danger'>\The [src] was deflected!</span>", \
									   "<span class='danger'>My armor protected me against \the [src]!</span>")

	..(target, blocked)
	DISABLE_BITFIELD(reagents.flags, NO_REACT)
	reagents.handle_reactions()
	return BULLET_ACT_HIT

//................ Poison Bolt (weak) ............... //
/obj/item/ammo_casing/caseless/bolt/poison
	name = "poison bolt"
	desc = "A bolt coated with a weak poison."
	icon_state = "bolt_poison"

/obj/item/ammo_casing/caseless/bolt/poison/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/berrypoison, 2)

//................ Poison Bolt (potent) ............... //
/obj/item/ammo_casing/caseless/bolt/poison/potent
	desc = "A bolt coated with a potent poison."

/obj/item/ammo_casing/caseless/bolt/poison/potent/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/strongpoison, 2)

//................ Pyro Bolt ............... //
/obj/item/ammo_casing/caseless/bolt/pyro
	name = "pyroclastic bolt"
	desc = "A bolt smeared with a flammable tincture."
	projectile_type = /obj/projectile/bullet/bolt/pyro
	icon_state = "bolt_pyroclastic"

/obj/item/ammo_casing/caseless/bolt/pyro/Initialize()
	. = ..()
	RemoveElement(/datum/element/tipped_item)
	qdel(reagents)

/obj/projectile/bullet/bolt/pyro
	name = "pyroclastic bolt"
	desc = "A bolt smeared with a flammable tincture."
	damage = BOLT_DAMAGE-20
	icon_state = "boltpyro_proj"
	range = 15
	hitsound = 'sound/blank.ogg'
	embedchance = 0
	woundclass = BCLASS_BLUNT
	armor_penetration = BOLT_PENETRATION-30
	var/explode_sound = list('sound/misc/explode/incendiary (1).ogg','sound/misc/explode/incendiary (2).ogg')

//explosion values
	var/exp_heavy = 0
	var/exp_light = 0
	var/exp_flash = 0
	var/exp_fire = 1

/obj/projectile/bullet/bolt/pyro/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/living/M = target
		M.fire_act(6)
//		M.take_overall_damage(0,10) //between this 10 burn, the 10 brute, the explosion brute, and the onfire burn, my at about 65 damage if you stop drop and roll immediately
	var/turf/T
	if(isturf(target))
		T = target
	else
		T = get_turf(target)
	explosion(T, -1, exp_heavy, exp_light, exp_flash, 0, flame_range = exp_fire, soundin = explode_sound)

/obj/item/ammo_casing/caseless/bolt/water
	name = "water bolt"
	desc = "A bolt with its tip replaced by a vial of water. Shatters on impact."
	projectile_type = /obj/projectile/bullet/bolt/water
	max_integrity = 10
	force = DAMAGE_KNIFE-2

/obj/item/ammo_casing/caseless/bolt/water/Initialize()
	. = ..()
	RemoveElement(/datum/element/tipped_item)

/obj/projectile/bullet/bolt/water
	name = "water bolt"
	desc = "A bolt with its tip replaced by a vial of water. Shatters on impact."
	damage = BOLT_DAMAGE-20
	embedchance = 0
	woundclass = BCLASS_BLUNT
	armor_penetration = BOLT_PENETRATION-40

/obj/projectile/bullet/bolt/water/Initialize()
	. = ..()
	create_reagents(15, NO_REACT)
	reagents.add_reagent(/datum/reagent/water, 15)

/obj/projectile/bullet/bolt/water/on_hit(target)
	var/target_loc = get_turf(src)
	if(iscarbon(target))
		var/mob/living/carbon/C = target
		target_loc = get_turf(C)
		var/obj/item/bodypart/BP = C.get_bodypart(def_zone)
		BP.add_embedded_object(new /obj/item/natural/glass/shard())
	else
		new /obj/effect/decal/cleanable/debris/glass(target_loc)
	playsound(target_loc, "glassbreak", 30, TRUE, -3)
	chem_splash(target_loc, 2, list(reagents))
	return ..()

/*-------\
| Arrows |
\-------*/

//................ Arrow ............... //
/obj/item/ammo_casing/caseless/arrow
	name = "arrow"
	desc = "A fletched projectile, with simple plumes and metal tip."
	projectile_type = /obj/projectile/bullet/reusable/arrow
	caliber = "arrow"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "arrow"
	force = DAMAGE_KNIFE-2
	dropshrink = 0.8
	possible_item_intents = list(/datum/intent/dagger/thrust)
	max_integrity = 20
	embedding = list("embedded_pain_multiplier" = 3, "embedded_fall_chance" = 0)
	firing_effect_type = null

/obj/item/ammo_casing/caseless/arrow/Initialize()
	. = ..()
	AddElement(/datum/element/tipped_item, _max_reagents = 2, _dip_amount = 2, _attack_injects = FALSE)

/obj/projectile/bullet/reusable/arrow
	name = "arrow"
	desc = "A fletched projectile, with simple plumes and metal tip."
	damage = ARROW_DAMAGE
	damage_type = BRUTE
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "arrow_proj"
	ammo_type = /obj/item/ammo_casing/caseless/arrow
	range = 30
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 100
	armor_penetration = ARROW_PENETRATION
	woundclass = BCLASS_PIERCE
	flag =  "piercing"
	speed = 0.4
	var/piercing = FALSE
	var/can_inject = TRUE

/obj/projectile/bullet/reusable/arrow/Initialize()
	. = ..()
	create_reagents(50, NO_REACT)

/obj/projectile/bullet/reusable/arrow/on_hit(atom/target, blocked = FALSE)
	if(can_inject && iscarbon(target))
		var/mob/living/carbon/M = target
		if(blocked != 100) // not completely blocked
			if(M.can_inject(null, FALSE, def_zone, piercing)) // Pass the hit zone to see if it can inject by whether it hit the head or the body.
				..()
				reagents.reaction(M, INJECT)
				reagents.trans_to(M, reagents.total_volume)
				return BULLET_ACT_HIT
			else
				blocked = 100
				target.visible_message(	span_danger("\The [src] was deflected!"), span_danger("My armor protected me against \the [src]!"))

	..(target, blocked)
	DISABLE_BITFIELD(reagents.flags, NO_REACT)
	reagents.handle_reactions()
	return BULLET_ACT_HIT

//................ Stone Arrow ............... //
/obj/item/ammo_casing/caseless/arrow/stone
	name = "stone arrow"
	desc = "A fletched projectile with a stone tip."
	icon_state = "stonearrow"
	projectile_type = /obj/projectile/bullet/reusable/arrow/stone //weaker projectile
	max_integrity = 5

/obj/projectile/bullet/reusable/arrow/stone
	ammo_type = /obj/item/ammo_casing/caseless/arrow/stone
	embedchance = 80
	armor_penetration = 0
	damage = ARROW_DAMAGE-2

//................ Poison Arrow ............... //
/obj/item/ammo_casing/caseless/arrow/poison
	name = "poison arrow"
	desc = "An arrow with its tip coated in a weak poison."
	icon_state = "arrow_poison"

/obj/projectile/bullet/reusable/arrow/poison/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/berrypoison, 2)

//................ Poison Arrow (potent) ............... //
/obj/item/ammo_casing/caseless/arrow/poison/potent
	desc = "An arrow with its tip coated in a potent poison."

/obj/item/ammo_casing/caseless/arrow/poison/potent/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/strongpoison, 2)

//................ Vial Arrow ............... //
/obj/item/ammo_casing/caseless/arrow/vial
	name = "vial arrow"
	desc = "An arrow with its tip replaced by a vial of something. Shatters on impact."
	icon_state = "arrow_vial"
	abstract_type = /obj/item/ammo_casing/caseless/arrow/vial
	max_integrity = 10
	possible_item_intents = list(/datum/intent/hit)
	force = DAMAGE_KNIFE-2
	var/datum/reagent/reagent

/obj/item/ammo_casing/caseless/arrow/vial/Initialize()
	. = ..()
	RemoveElement(/datum/element/tipped_item)
	update_icon()

/obj/item/ammo_casing/caseless/arrow/vial/update_overlays()
	. = ..()
	if(reagent)
		var/mutable_appearance/filling = mutable_appearance(icon, "[icon_state]_filling")
		filling.color = initial(reagent.color)
		. += filling

/obj/item/ammo_casing/caseless/arrow/vial/water
	projectile_type = /obj/projectile/bullet/reusable/arrow/vial/water
	reagent = /datum/reagent/water

/obj/projectile/bullet/reusable/arrow/vial
	name = "vial arrow"
	desc = "An arrow with its tip replaced by a vial of something. Shatters on impact."
	icon_state = "arrowvial_proj"
	abstract_type = /obj/projectile/bullet/reusable/arrow/vial
	ammo_type = null
	can_inject = FALSE
	damage = ARROW_DAMAGE-20
	embedchance = 0
	woundclass = BCLASS_BLUNT
	armor_penetration = ARROW_PENETRATION-20
	var/datum/reagent/reagent

/obj/projectile/bullet/reusable/arrow/vial/Initialize()
	. = ..()
	if(reagent)
		reagents?.add_reagent(reagent, 15)

/obj/projectile/bullet/reusable/arrow/vial/on_hit(target)
	var/target_loc = get_turf(src)
	if(iscarbon(target))
		var/mob/living/carbon/C = target
		target_loc = get_turf(C)
		var/obj/item/bodypart/BP = C.get_bodypart(def_zone)
		BP.add_embedded_object(new /obj/item/natural/glass/shard())
	else
		new /obj/effect/decal/cleanable/debris/glass(target_loc)
	playsound(target_loc, "glassbreak", 30, TRUE, -3)
	chem_splash(target_loc, 2, list(reagents))
	return ..()

/obj/projectile/bullet/reusable/arrow/vial/water
	reagent = /datum/reagent/water

//................ Water Arrow ............... //
/obj/item/ammo_casing/caseless/arrow/water
	name = "water arrow"
	desc = "An arrow with its tip replaced by a water crystal, creates a splash on impact."
	icon_state = "arrow_water"
	projectile_type = /obj/projectile/bullet/reusable/arrow/water
	max_integrity = 10
	force = DAMAGE_KNIFE-2

/obj/item/ammo_casing/caseless/arrow/water/Initialize()
	. = ..()
	RemoveElement(/datum/element/tipped_item)

/obj/projectile/bullet/reusable/arrow/water
	name = "water arrow"
	desc = "An arrow with its tip replaced by a water crystal, creates a splash on impact."
	icon_state = "arrowwater_vial"
	ammo_type = null
	can_inject = FALSE
	damage = ARROW_DAMAGE-5
	armor_penetration = ARROW_PENETRATION-10
	embedchance = 0

/obj/projectile/bullet/reusable/arrow/water/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/water, 25)

/obj/projectile/bullet/reusable/arrow/water/on_hit(target)
	var/target_loc = get_turf(src)
	if(ismob(target))
		target_loc = get_turf(target)
	chem_splash(target_loc, 3, list(reagents))
	return ..()

//................ Pyro Arrow ............... //
/obj/item/ammo_casing/caseless/arrow/pyro
	name = "pyroclastic arrow"
	desc = "An arrow with its tip smeared with a flammable tincture."
	projectile_type = /obj/projectile/bullet/reusable/arrow/pyro
	icon_state = "arrow_pyroclastic"
	max_integrity = 10
	force = DAMAGE_KNIFE-2

/obj/item/ammo_casing/caseless/arrow/pyro/Initialize()
	. = ..()
	RemoveElement(/datum/element/tipped_item)
	qdel(reagents)

/obj/projectile/bullet/reusable/arrow/pyro
	name = "pyroclastic arrow"
	desc = "An arrow with its tip smeared with a flammable tincture."
	icon_state = "arrowpyro_proj"
	ammo_type = null
	can_inject = FALSE
	damage = ARROW_DAMAGE-15
	range = 15
	hitsound = 'sound/blank.ogg'
	embedchance = 0
	woundclass = BCLASS_BLUNT
	armor_penetration = ARROW_PENETRATION-15
	var/explode_sound = list('sound/misc/explode/incendiary (1).ogg','sound/misc/explode/incendiary (2).ogg')

//explosion values
	var/exp_heavy = 0
	var/exp_light = 0
	var/exp_flash = 0
	var/exp_fire = 1

/obj/projectile/bullet/reusable/arrow/pyro/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/living/M = target
		M.fire_act(6)
//		M.take_overall_damage(0,10) //between this 10 burn, the 10 brute, the explosion brute, and the onfire burn, my at about 65 damage if you stop drop and roll immediately
	var/turf/T
	if(isturf(target))
		T = target
	else
		T = get_turf(target)
	explosion(T, -1, exp_heavy, exp_light, exp_flash, 0, flame_range = exp_fire, soundin = explode_sound)

/*--------\
| Bullets |
\--------*/

//................ Lead Ball ............... //
/obj/projectile/bullet/reusable/bullet
	name = "lead ball"
	desc = "A round lead shot, simple and spherical."
	damage = BULLET_DAMAGE
	damage_type = BRUTE
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "musketball_proj"
	ammo_type = /obj/item/ammo_casing/caseless/bullet
	range = 15
	jitter = 5
	eyeblur = 3
	hitsound = 'sound/combat/hits/hi_bolt (2).ogg'
	embedchance = 100
	woundclass = BCLASS_SHOT
	impact_effect_type = /obj/effect/temp_visual/impact_effect
	flag =  "piercing"
	armor_penetration = BULLET_PENETRATION
	speed = 0.3
	accuracy = 50 //Lower accuracy than an arrow.

/obj/projectile/bullet/fragment
	name = "smaller lead ball"
	desc = "Haha. You're not able to see this!"
	damage = 25
	damage_type = BRUTE
	woundclass = BCLASS_SHOT
	range = 30
	jitter = 5
	eyeblur = 3
	stun = 1
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "musketball_proj"
	ammo_type = /obj/item/ammo_casing/caseless/cball/grapeshot
	impact_effect_type = /obj/effect/temp_visual/impact_effect
	flag =  "piercing"
	armor_penetration = BULLET_PENETRATION
	speed = 0.5

/obj/item/ammo_casing/caseless/bullet
	name = "lead ball"
	desc = "A round lead shot, simple and spherical."
	projectile_type = /obj/projectile/bullet/reusable/bullet
	caliber = "musketball"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "musketball"
	dropshrink = 0.5
	possible_item_intents = list(/datum/intent/use)
	max_integrity = 0
	force = 3

//................ Cannon Ball ............... //
/obj/projectile/bullet/reusable/cannonball
	name = "large lead ball"
	desc = "A round lead ball. Complex and still spherical."
	damage = 300
	damage_type = BRUTE
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "musketball_proj" // No one sees it anyway. I think.
	ammo_type = /obj/item/ammo_casing/caseless/cball
	range = 999
	jitter = 5
	stun = 1
	hitsound = 'sound/combat/hits/hi_bolt (2).ogg'
	embedchance = 0
	dismemberment = 300
	spread = 0
	woundclass = BCLASS_SMASH
	impact_effect_type = /obj/effect/temp_visual/impact_effect
	flag =  "piercing"
	hitscan = FALSE
	armor_penetration = BULLET_PENETRATION
	speed = 0.8

/obj/projectile/bullet/reusable/cannonball/on_hit(atom/target,blocked = FALSE)
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.visible_message("<span class='danger'>[M] explodes into a shower of gibs!</span>")
		M.gib()
	explosion(get_turf(target), heavy_impact_range = 2, light_impact_range = 4, flame_range = 0, smoke = TRUE, soundin = pick('sound/misc/explode/bottlebomb (1).ogg','sound/misc/explode/bottlebomb (2).ogg'))
	..(target, blocked)

//................ Grapeshot ............... //
/obj/item/ammo_casing/caseless/cball
	name = "large lead ball"
	desc = "A round lead ball. Complex and still spherical."
	icon = 'icons/roguetown/weapons/ammo.dmi'
	projectile_type = /obj/projectile/bullet/reusable/cannonball
	dropshrink = 0.5
	icon_state = "cball"
	caliber = "cannoball"
	possible_item_intents = list(/datum/intent/use)
	max_integrity = 1
	randomspread = 0
	variance = 0
	force = 10

/obj/item/ammo_casing/caseless/cball/grapeshot
	name = "berryshot"
	desc = "A large pouch of smaller lead balls. Not as complex and not as spherical."
	icon_state = "grapeshot" // NEEDS SPRITE
	dropshrink = 0.5
	projectile_type = /obj/projectile/bullet/fragment

/*------\
| Darts |
\------*/

/obj/item/ammo_casing/caseless/dart
	name = "dart"
	desc = "A thorn fasioned into a primitive dart."
	projectile_type = /obj/projectile/bullet/reusable/dart
	caliber = "dart"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "dart"
	dropshrink = 0.9
	max_integrity = 10
	force = DAMAGE_KNIFE/2
	firing_effect_type = null

/obj/item/ammo_casing/caseless/dart/Initialize()
	. = ..()
	AddElement(/datum/element/tipped_item, _max_reagents = 3, _dip_amount = 3, _attack_injects = FALSE)

/obj/projectile/bullet/reusable/dart
	name = "dart"
	desc = "A thorn faschioned into a primitive dart."
	damage = BLOWDART_DAMAGE
	damage_type = BRUTE
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "dart_proj"
	ammo_type = /obj/item/ammo_casing/caseless/dart
	range = 6
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 100
	woundclass = BCLASS_STAB
	flag = "piercing"
	speed = 0.3
	accuracy = 50
	var/piercing = FALSE

/obj/projectile/bullet/reusable/dart/Initialize()
	. = ..()
	create_reagents(50, NO_REACT)

/obj/projectile/bullet/reusable/dart/on_hit(atom/target, blocked = FALSE)
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		if(blocked != 100) // not completely blocked
			if(M.can_inject(null, FALSE, def_zone, piercing)) // Pass the hit zone to see if it can inject by whether it hit the head or the body.
				..()
				reagents.reaction(M, INJECT)
				reagents.trans_to(M, reagents.total_volume)
				return BULLET_ACT_HIT
			else
				blocked = 100
				target.visible_message(	span_danger("\The [src] was deflected!"), span_danger("My armor protected me against \the [src]!"))

	..(target, blocked)
	DISABLE_BITFIELD(reagents.flags, NO_REACT)
	reagents.handle_reactions()
	return BULLET_ACT_HIT

//................ Poison Dart (weak) ............... //
/obj/item/ammo_casing/caseless/dart/poison
	name = "poison dart"
	desc = "A dart with its tip coated in a weak poison."
	icon_state = "dart_poison"

/obj/item/ammo_casing/caseless/dart/poison/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/berrypoison, 3)

#undef BLOWDART_DAMAGE
#undef ARROW_DAMAGE
#undef BOLT_DAMAGE
#undef BULLET_DAMAGE
#undef ARROW_PENETRATION
#undef BOLT_PENETRATION
#undef BULLET_PENETRATION
