//................	Handsaw	............... //
/obj/item/weapon/handsaw
	force = 5
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/dagger/chop/cleaver)
	gripped_intents = null
	name = "handsaw"
	desc = "Iron tool for woodworking."
	icon_state = "handsaw"
	item_state = "handsaw"
	icon = 'modular/stonekeep/icons/crafting.dmi'
	mob_overlay_icon = 'modular/stonekeep/icons/onmob/onmob.dmi'
	lefthand_file = 'modular/stonekeep/icons/onmob/lefthand.dmi'
	righthand_file = 'modular/stonekeep/icons/onmob/righthand.dmi'
	experimental_inhand = FALSE
	experimental_onhip = FALSE
	grid_width = 32
	grid_height = 96
	sharpness = IS_SHARP
	wdefense = 0
	wlength = WLENGTH_LONG
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_HIP
	tool_behaviour = TOOL_IMPROVISED_SAW
	swingsound = list('sound/combat/wooshes/blunt/shovel_swing.ogg','sound/combat/wooshes/blunt/shovel_swing2.ogg')
	drop_sound = 'sound/foley/dropsound/shovel_drop.ogg'
	smeltresult = /obj/item/ingot/iron
	associated_skill = /datum/skill/combat/knives
	max_blade_int = 50

//................	Chisel	............... //
/obj/item/weapon/chisel
	icon = 'modular/stonekeep/icons/crafting.dmi'
/*
/obj/structure/roguerock/attackby(obj/item/W, mob/living/user, params)
	. = ..()
	if(user.used_intent.type == /datum/intent/chisel && is_type_in_typecache(item, offhand_types))
		playsound(src.loc, pick('sound/combat/hits/onrock/onrock (1).ogg', 'sound/combat/hits/onrock/onrock (2).ogg', 'sound/combat/hits/onrock/onrock (3).ogg', 'sound/combat/hits/onrock/onrock (4).ogg'), 100)
		user.visible_message("<span class='info'>[user] chisels the rock into blocks.</span>")
		if(do_after(user, 10 SECONDS))
			new /obj/item/natural/stoneblock(get_turf(src.loc))
			new /obj/item/natural/stoneblock(get_turf(src.loc))
			new /obj/item/natural/stoneblock(get_turf(src.loc))
			new /obj/item/natural/stoneblock(get_turf(src.loc))
			new /obj/effect/decal/cleanable/debris/stony(get_turf(src))
			playsound(src.loc, pick('sound/combat/hits/onrock/onrock (1).ogg', 'sound/combat/hits/onrock/onrock (2).ogg', 'sound/combat/hits/onrock/onrock (3).ogg', 'sound/combat/hits/onrock/onrock (4).ogg'), 100)
			user.mind.add_sleep_experience(/datum/skill/craft/masonry, (user.STAINT*1))
			qdel(src)
*/
//................	Stone blocks	............... //
/obj/item/natural/stoneblock
	lefthand_file = 'modular/stonekeep/icons/onmob/lefthand.dmi'
	righthand_file = 'modular/stonekeep/icons/onmob/righthand.dmi'

//................ Stone block stack	............... //
/obj/item/natural/bundle/stoneblock
	lefthand_file = 'icons/roguetown/onmob/lefthand.dmi'
	righthand_file = 'icons/roguetown/onmob/righthand.dmi'




//................	Wooden planks	............... //
/obj/item/natural/wood/plank
	name = "wooden plank"
	desc = "A flat piece of wood, useful for flooring."
	icon = 'modular/stonekeep/icons/crafting.dmi'
	lefthand_file = 'modular/stonekeep/icons/onmob/lefthand.dmi'
	righthand_file = 'modular/stonekeep/icons/onmob/righthand.dmi'
	icon_state = "plank"
	experimental_inhand = FALSE
	grid_width = 64
	grid_height = 224
	attacked_sound = 'sound/misc/woodhit.ogg'
	drop_sound = 'sound/foley/dropsound/wooden_drop.ogg'
	possible_item_intents = list(/datum/intent/use)
	force = 6
	throwforce = 0
	obj_flags = null
	resistance_flags = FLAMMABLE
	slot_flags = null
	max_integrity = 20
	firefuel = 5 MINUTES
	w_class = WEIGHT_CLASS_BULKY
	bundletype = /obj/item/natural/bundle/plank
	smeltresult = /obj/item/ash

//................	Wooden plan stack	............... //
/obj/item/natural/bundle/plank
	name = "stack of wooden planks"
	desc = "Several planks in a neat pile."
	icon_state = "plankbundle1"
	item_state = "plankbundle"
	icon = 'modular/stonekeep/icons/crafting.dmi'
	lefthand_file = 'modular/stonekeep/icons/onmob/lefthand.dmi'
	righthand_file = 'modular/stonekeep/icons/onmob/righthand.dmi'
	experimental_inhand = FALSE
	grid_width = 128
	grid_height = 224
	drop_sound = 'sound/foley/dropsound/wooden_drop.ogg'
	possible_item_intents = list(/datum/intent/use)
	force = 0
	throwforce = 0
	throw_range = 2
	firefuel = 10 MINUTES
	w_class = WEIGHT_CLASS_BULKY
	stackname = "plank"
	stacktype = /obj/item/natural/wood/plank
	maxamount = 6
	icon1 = "plankbundle2"
	icon1step = 3
	icon2 = "plankbundle3"
	icon2step = 5
	smeltresult = /obj/item/ash


//................	Glass panes	............... //
/obj/item/natural/glass
	name = "glass"
	desc = "Windowpanes for construction work."
	icon = 'modular/stonekeep/icons/crafting.dmi'
	lefthand_file = 'modular/stonekeep/icons/onmob/lefthand.dmi'
	righthand_file = 'modular/stonekeep/icons/onmob/righthand.dmi'
	experimental_inhand = FALSE
	icon_state = "glasspane"
	dropshrink = 0.8
	grid_width = 64
	grid_height = 64
	drop_sound = 'sound/foley/dropsound/glass_drop.ogg'
	possible_item_intents = list(/datum/intent/use)
	force = 0
	throwforce = 8
	throw_range = 5
	obj_flags = null
	max_integrity = 20
	w_class = WEIGHT_CLASS_BULKY
	bundletype = /obj/item/natural/bundle/glass
	sellprice = 6
/obj/item/natural/glass/throw_impact(atom/hit_atom, datum/thrownthing/thrownthing)
	if(!..()) //was it caught by a mob?
		new /obj/item/natural/glass_shard(get_turf(src))
		pixel_x = rand(-3, 3)
		pixel_y = rand(-3, 3)
		new /obj/effect/decal/cleanable/debris/glassy(get_turf(src))
		playsound(src, 'modular/stonekeep/sound/glass_shatter.ogg', 90, TRUE)
		qdel(src)


//................	Glass panes stack	............... //
/obj/item/natural/bundle/glass
	name = "stack of glass"
	desc = "A stack of fragile glass panes."
	icon = 'modular/stonekeep/icons/crafting.dmi'
	lefthand_file = 'modular/stonekeep/icons/onmob/lefthand.dmi'
	righthand_file = 'modular/stonekeep/icons/onmob/righthand.dmi'
	experimental_inhand = FALSE
	icon_state = "glasspane1"
	item_state = "glasspane"
	dropshrink = 0.8
	grid_width = 64
	grid_height = 64
	drop_sound = 'sound/foley/dropsound/glass_drop.ogg'
	possible_item_intents = list(/datum/intent/use)
	force = 15
	throwforce = 18
	throw_range = 2
	firefuel = null
	resistance_flags = null
	firemod = null
	w_class = WEIGHT_CLASS_HUGE
	stackname = "glass"
	stacktype = /obj/item/natural/glass
	maxamount = 3
	icon1 = "glasspane1"
	icon1step = 2
	icon2 = "glasspane2"
	icon2step = 3
/obj/item/natural/bundle/glass/throw_impact(atom/hit_atom, datum/thrownthing/thrownthing)
	if(!..()) //was it caught by a mob?
		new /obj/item/natural/glass_shard(get_turf(src))
		pixel_x = rand(-3, 3)
		pixel_y = rand(-3, 3)
		new /obj/item/natural/glass_shard(get_turf(src))
		new /obj/effect/decal/cleanable/debris/glassy(get_turf(src))
		playsound(src, 'modular/stonekeep/sound/glass_shatter.ogg', 95, TRUE)
		qdel(src)

//................	Glass shard	............... //
/obj/item/natural/glass_shard
	name = "shard"
	desc = "A sharp shard of glass."
	icon = 'modular/stonekeep/icons/crafting.dmi'
	lefthand_file = 'modular/stonekeep/icons/onmob/lefthand.dmi'
	righthand_file = 'modular/stonekeep/icons/onmob/righthand.dmi'
	experimental_inhand = FALSE
	icon_state = "shard1"
	item_state = "shard"
	drop_sound = 'sound/foley/dropsound/glass_drop.ogg'
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/stab)
	force = 3
	throwforce = 5
	resistance_flags = null
	w_class = WEIGHT_CLASS_TINY
	attack_verb = list("stabbed", "slashed", "sliced", "cut")
	max_integrity = 40
	smeltresult = /obj/item/natural/glass
/obj/item/natural/glass_shard/New()
	..()
	icon_state = "shard[rand(1,3)]"
/obj/item/natural/glass_shard/Crossed(mob/living/L)
	. = ..()
	playsound(loc,'modular/stonekeep/sound/glass_step.ogg', 100, FALSE)


/obj/item/natural/glass/shard
	icon = 'modular/stonekeep/icons/crafting.dmi'
	lefthand_file = 'modular/stonekeep/icons/onmob/lefthand.dmi'
	righthand_file = 'modular/stonekeep/icons/onmob/righthand.dmi'
	item_state = "shard"

