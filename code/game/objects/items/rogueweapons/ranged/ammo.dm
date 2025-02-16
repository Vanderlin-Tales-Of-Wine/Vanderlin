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

//................ Crossbow Bolt ............... //
/obj/item/ammo_casing/caseless/rogue/bolt
	name = "bolt"
	desc = "A small and sturdy bolt, with simple plume and metal tip, alongside a groove to load onto a crossbow."
	projectile_type = /obj/projectile/bullet/reusable/bolt
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/dagger/thrust)
	caliber = "regbolt"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "bolt"
	dropshrink = 0.8
	max_integrity = 10
	force = 10
	embedding = list("embedded_pain_multiplier" = 3, "embedded_fall_chance" = 0)
	firing_effect_type = null

/obj/projectile/bullet/reusable/bolt
	name = "bolt"
	desc = "A small and sturdy bolt, with simple plume and metal tip, alongside a groove to load onto a crossbow."
	damage = BOLT_DAMAGE
	damage_type = BRUTE
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "bolt_proj"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/bolt
	range = 30
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 100
	armor_penetration = BOLT_PENETRATION
	woundclass = BCLASS_STAB
	flag =  "piercing"
	speed = 0.3
	accuracy = 85 //Crossbows have higher accuracy

//................ Poison Bolt ............... //
/obj/item/ammo_casing/caseless/rogue/bolt/poison
	name = "poison bolt"
	desc = "A bolt dipped with a weak poison."
	icon_state = "bolt_poison"
	projectile_type = /obj/projectile/bullet/reusable/bolt/poison/weak

/obj/projectile/bullet/reusable/bolt/poison
	name = "poison bolt"
	icon_state = "boltpoison_proj"
	damage = BOLT_DAMAGE-10
	range = 15
	var/piercing = FALSE

/obj/projectile/bullet/reusable/bolt/poison/Initialize()
	. = ..()
	create_reagents(50, NO_REACT)

/obj/projectile/bullet/reusable/bolt/poison/on_hit(atom/target, blocked = FALSE)
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
/obj/projectile/bullet/reusable/bolt/poison/weak
	desc = "A bolt dipped with a weak poison."

/obj/projectile/bullet/reusable/bolt/poison/weak/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/berrypoison, 2)

//................ Poison Bolt (potent) ............... //
/obj/item/ammo_casing/caseless/rogue/bolt/poison/potent
	desc = "A bolt dipped with a potent poison."
	projectile_type = /obj/projectile/bullet/reusable/bolt/poison/potent

/obj/projectile/bullet/reusable/bolt/poison/potent
	desc = "A bolt dipped with a potent poison."

/obj/projectile/bullet/reusable/bolt/poison/potent/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/strongpoison, 2)

//................ Pyro Bolt ............... //
/obj/item/ammo_casing/caseless/rogue/bolt/pyro
	name = "pyroclastic bolt"
	desc = "A bolt smeared with a flammable tincture."
	projectile_type = /obj/projectile/bullet/bolt/pyro
	possible_item_intents = list(/datum/intent/mace/strike)
	icon_state = "bolt_pyroclastic"

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
		M.adjust_fire_stacks(6)
//		M.take_overall_damage(0,10) //between this 10 burn, the 10 brute, the explosion brute, and the onfire burn, my at about 65 damage if you stop drop and roll immediately
	var/turf/T
	if(isturf(target))
		T = target
	else
		T = get_turf(target)
	explosion(T, -1, exp_heavy, exp_light, exp_flash, 0, flame_range = exp_fire, soundin = explode_sound)



/*-------\
| Arrows |
\-------*/

//................ Arrow ............... //
/obj/item/ammo_casing/caseless/rogue/arrow
	name = "arrow"
	desc = "A fletched projectile, with simple plumes and metal tip."
	projectile_type = /obj/projectile/bullet/reusable/arrow
	caliber = "arrow"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "arrow"
	force = 20
	dropshrink = 0.8
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/dagger/thrust)
	max_integrity = 20
	embedding = list("embedded_pain_multiplier" = 3, "embedded_fall_chance" = 0)
	firing_effect_type = null

/obj/projectile/bullet/reusable/arrow
	name = "arrow"
	desc = "A fletched projectile, with simple plumes and metal tip."
	damage = ARROW_DAMAGE
	damage_type = BRUTE
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "arrow_proj"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/arrow
	range = 30
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 100
	armor_penetration = ARROW_PENETRATION
	woundclass = BCLASS_STAB
	flag =  "piercing"
	speed = 0.4

//................ Stone Arrow ............... //
/obj/item/ammo_casing/caseless/rogue/arrow/stone
	name = "stone arrow"
	desc = "A fletched projectile with a stone tip."
	icon_state = "stonearrow"
	projectile_type = /obj/projectile/bullet/reusable/arrow/stone //weaker projectile
	max_integrity = 5

/obj/projectile/bullet/reusable/arrow/stone
	ammo_type = /obj/item/ammo_casing/caseless/rogue/arrow/stone
	embedchance = 80
	armor_penetration = 0
	damage = ARROW_DAMAGE-2


//................ Poison Arrow ............... //
/obj/item/ammo_casing/caseless/rogue/arrow/poison
	name = "poison arrow"
	desc = "An arrow with its tip drenched in a weak poison."
	projectile_type = /obj/projectile/bullet/reusable/arrow/poison/weak
	icon_state = "arrow_poison"

/obj/projectile/bullet/reusable/arrow/poison
	name = "poison arrow"
	desc = "An arrow with its tip drenched in a powerful poison."
	icon_state = "arrowpoison_proj"
	damage = ARROW_DAMAGE-10
	range = 15
	var/piercing = FALSE

/obj/projectile/bullet/reusable/arrow/poison/Initialize()
	. = ..()
	create_reagents(50, NO_REACT)

/obj/projectile/bullet/reusable/arrow/poison/on_hit(atom/target, blocked = FALSE)
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

//................ Poison Arrow (weak) ............... //
/obj/projectile/bullet/reusable/arrow/poison/weak
	desc = "An arrow with its tip drenched in a weak poison."

/obj/projectile/bullet/reusable/arrow/poison/weak/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/berrypoison, 2)

//................ Poison Arrow (potent) ............... //
/obj/item/ammo_casing/caseless/rogue/arrow/poison/potent
	desc = "An arrow with it's tip drenched in a potent poison."
	projectile_type = /obj/projectile/bullet/reusable/arrow/poison/potent

/obj/item/ammo_casing/caseless/rogue/arrow/poison/potent
	desc = "An arrow with it's tip drenched in a powerful poison."

/obj/projectile/bullet/reusable/arrow/poison/potent/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/strongpoison, 2)

//................ Pyro Arrow ............... //
/obj/item/ammo_casing/caseless/rogue/arrow/pyro
	name = "pyroclastic arrow"
	desc = "An arrow with its tip drenched in a flammable tincture."
	projectile_type = /obj/projectile/bullet/arrow/pyro
	possible_item_intents = list(/datum/intent/mace/strike)
	icon_state = "arrow_pyroclastic"
	max_integrity = 10
	force = 10

/obj/projectile/bullet/arrow/pyro
	name = "pyroclastic arrow"
	desc = "An arrow with its tip drenched in a flammable tincture."
	icon_state = "arrowpyro_proj"
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

/obj/projectile/bullet/arrow/pyro/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/living/M = target
		M.adjust_fire_stacks(6)
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
	ammo_type = /obj/item/ammo_casing/caseless/rogue/bullet
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
	ammo_type = /obj/item/ammo_casing/caseless/rogue/cball/grapeshot
	impact_effect_type = /obj/effect/temp_visual/impact_effect
	flag =  "piercing"
	armor_penetration = BULLET_PENETRATION
	speed = 0.5

/obj/item/ammo_casing/caseless/rogue/bullet
	name = "lead ball"
	desc = "A round lead shot, simple and spherical."
	projectile_type = /obj/projectile/bullet/reusable/bullet
	caliber = "musketball"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "musketball"
	dropshrink = 0.5
	possible_item_intents = list(/datum/intent/use)
	max_integrity = 0
	force = 20

//................ Cannon Ball ............... //
/obj/projectile/bullet/reusable/cannonball
	name = "large lead ball"
	desc = "A round lead ball. Complex and still spherical."
	damage = 300
	damage_type = BRUTE
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "musketball_proj" // No one sees it anyway. I think.
	ammo_type = /obj/item/ammo_casing/caseless/rogue/cball
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
/obj/item/ammo_casing/caseless/rogue/cball
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
	force = 20

/obj/item/ammo_casing/caseless/rogue/cball/grapeshot
	name = "berryshot"
	desc = "A large pouch of smaller lead balls. Not as complex and not as spherical."
	icon_state = "grapeshot" // NEEDS SPRITE
	dropshrink = 0.5
	projectile_type = /obj/projectile/bullet/fragment



/*------\
| Darts |
\------*/


/*------\
| Darts |
\------*/

/obj/item/ammo_casing/caseless/rogue/dart
	name = "dart"
	desc = "A thorn fasioned into a primitive dart."
	projectile_type = /obj/projectile/bullet/reusable/dart
	caliber = "dart"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "dart"
	dropshrink = 0.9
	max_integrity = 10
	force = 10
	firing_effect_type = null

/obj/projectile/bullet/reusable/dart
	name = "dart"
	desc = "A thorn faschioned into a primitive dart."
	damage = BLOWDART_DAMAGE
	damage_type = BRUTE
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "dart_proj"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/dart
	range = 6
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 100
	woundclass = BCLASS_STAB
	flag = "piercing"
	speed = 0.3
	accuracy = 50

//................ Poison Dart ............... //
/obj/item/ammo_casing/caseless/rogue/dart/poison
	name = "poison dart"
	desc = "A dart with its tip drenched in a weak poison."
	projectile_type = /obj/projectile/bullet/reusable/dart/poison
	icon_state = "dart_poison"

/obj/projectile/bullet/reusable/dart/poison
	name = "poison dart"
	desc = "A dart with its tip drenched in a weak poison."
	var/piercing = FALSE

/obj/projectile/bullet/reusable/dart/poison/Initialize()
	. = ..()
	create_reagents(50, NO_REACT)
	reagents.add_reagent(/datum/reagent/berrypoison, 3)

/obj/projectile/bullet/reusable/dart/poison/on_hit(atom/target, blocked = FALSE)
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

#undef BLOWDART_DAMAGE
#undef ARROW_DAMAGE
#undef BOLT_DAMAGE
#undef BULLET_DAMAGE
#undef ARROW_PENETRATION
#undef BOLT_PENETRATION
#undef BULLET_PENETRATION
