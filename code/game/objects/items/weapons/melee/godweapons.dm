//┌─────────────── INHUMEN PANTHEON WEAPONS BELOW ───────────────┐

// god weapons should have 720 durability, and can reach 0 and become unusable but do not break and can be repaired



//┌─────────────── GOREFEAST ───────────────┐//
/obj/item/weapon/polearm/halberd/bardiche/woodcutter/gorefeast
	force = DAMAGE_HEAVYAXE_WIELD
	force_wielded = 35
	name = "GoreFeast"
	desc = "It is said that with this axe alone, Graggar slew a thousand men. With you, it will slay a thousand more."
	icon = 'icons/roguetown/weapons/godweapons.dmi'
	icon_state = "gorefeast"
	max_blade_int = 200
	possible_item_intents = list(/datum/intent/axe/cut, /datum/intent/axe/chop)
	gripped_intents = list(/datum/intent/axe/cut,/datum/intent/axe/chop/great,/datum/intent/sword/strike,/datum/intent/use)
	parrysound = "sword"
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	minstr = 12
	max_integrity = 720
	wdefense = GOOD_PARRY
	sellprice = 550

/obj/item/weapon/polearm/halberd/bardiche/woodcutter/gorefeast/pickup(mob/living/M)
	. = ..()
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if (!HAS_TRAIT(H, TRAIT_ORGAN_EATER))
			to_chat(M, "<span class='danger'>The Beating Heart of the blade seems to slow down at the sight of you...disinterested.</span>")
			playsound_local(pick('sound/misc/godweapons/gorefeast1.ogg',
			'sound/misc/godweapons/gorefeast2.ogg',
			'sound/misc/godweapons/gorefeast3.ogg'), 100)
			var/message =
				pick(
				"<span class='danger'>Unworthy...</span>",
				"<span class='danger'>You are far too weak to be wielding me.</span>",
				"<span class='danger'>How did you get your hands on me ?</span>",
				"<span class='danger'>Find the nearest orc, and hand me to them.</span>",
				"<span class='danger'>You are not prepared.</span>")
		else
			to_chat(M, "<span class='danger'>GoreFeast begins to thump, ecstatically upon your touch on the boney shaft.</span>")
			playsound_local(pick('sound/misc/godweapons/gorefeast4.ogg',
			'sound/misc/godweapons/gorefeast5.ogg',
			'sound/misc/godweapons/gorefeast6.ogg'), 100)
			var/message =
				pick(
				"<span class='danger'>A worthy one!</span>",
				"<span class='danger'>Bathe me in their blood.</span>",
				"<span class='danger'>Feed on their heart Graggirite!</span>",
				"<span class='danger'>You can smell their fear can't you?</span>",
				"<span class='danger'>Unleash your fury, soak the soil in their blood.</span>",
				"<span class='danger'>Feast on their organs.</span>",
				"<span class='danger'>Cull the world of the weak!</span>",
				"<span class='danger'>Fools to challenge us, warlord.</span>",
			)

// speaks to you while attacking
// rips out heart if heart crit (must have graggar's blessing) be graggarite
// rips out heart on corpses

//┌─────────────── NEANT ───────────────┐//
/obj/item/weapon/polearm/neant
	force = 20
	force_wielded = 25
	possible_item_intents = list(/datum/intent/polearm/cut)
	gripped_intents = list(/datum/intent/polearm/cut, /datum/intent/polearm/chop, /datum/intent/flail/strike, /datum/intent/use)
	name = "Neant"
	desc = "A dark scythe with a long chain, used to cut the life essence from people, or whip them into shape. The blade is an ominous purple."
	icon_state = "neant"
	icon = 'icons/roguetown/weapons/godweapons.dmi'
	bigboy = TRUE
	gripsprite = FALSE
	wlength = WLENGTH_GREAT
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	resistance_flags = FIRE_PROOF
	max_blade_int = 200
	max_integrity = 720
	minstr = 10
	associated_skill = /datum/skill/combat/polearms
	drop_sound = 'sound/foley/dropsound/blade_drop.ogg'
	dropshrink = 0.75
	blade_dulling = DULLING_BASHCHOP
	wdefense = 2
	thrown_bclass = BCLASS_CUT
	throwforce = 25
	sellprice = 550

//removes lux from corpses
// has a ranged attack on 4th intent travels 4 tiles does mild cut damage ( must be of the cabal ) be zizoid

//┌─────────────── TURBULENTA ───────────────┐//

/obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve/turbulenta
	name = "Turbulenta"
	desc = "Rarely does she even care about combat, but when she does... Baotha was quite the markswoman."
	icon = 'icons/roguetown/weapons/godweapons.dmi'
	icon_state = "turbulenta"
	base_icon = "turbulenta"
	possible_item_intents = list(/datum/intent/shoot/bow/recurve, /datum/intent/arc/bow/recurve, /datum/intent/use)
	randomspread = 1
	spread = 1
	force = 9
	damfactor = 0.9

/datum/intent/shoot/bow/recurve/turbulenta
	chargetime = 0.75
	chargedrain = 1.5
	charging_slowdown = 2.5

/datum/intent/arc/bow/recurve/turbulenta
	chargetime = 0.75
	chargedrain = 1.5
	charging_slowdown = 2.5

// can be used a lyre
// applies spice to arrows shot ( must have baotha's blessing ) be baothan

//┌─────────────── PLEONEXIA ───────────────┐//
/obj/item/weapon/sword/long/pleonexia
	force_wielded = DAMAGE_LONGSWORD_WIELD
	possible_item_intents = list(/datum/intent/sword/cut, /datum/intent/sword/thrust, /datum/intent/sword/strike)
	gripped_intents = list(/datum/intent/use, /datum/intent/sword/thrust, /datum/intent/sword/strike, /datum/intent/sword/chop)
	icon_state = "pleonexia"
	icon = 'icons/roguetown/weapons/godweapons.dmi'
	name = "Pleonexia"
	desc = "A sword of legend. If they are true, then this blade is the blade of Matthios himself. Rumor has it, it steals space and time."
	swingsound = BLADEWOOSH_LARGE
	parrysound = "largeblade"
	pickup_sound = "brandish_blade"
	bigboy = TRUE
	wlength = WLENGTH_LONG
	gripsprite = TRUE
	pixel_y = -16
	pixel_x = -16
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_HIP
	dropshrink = 0.75
	sellprice = 60

// added as a spell
// blinks you through two tiles ( same as a leap ) ahead past windows but not walls / must have matthios' eyes ( be matthiosite)
// anyone caught in the blink gets a very short 1 second knock over
