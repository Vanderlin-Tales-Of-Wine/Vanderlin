/obj/structure/steam_recharger
	name = "steam injector"
	desc = "Fills objects with steam."

	icon = 'icons/obj/structures/rotation_devices/steam_recharger.dmi'
	icon_state = "rechargetable"

	accepts_water_input = TRUE
	var/obj/item/placed_atom

/obj/structure/steam_recharger/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/structure/steam_recharger/examine(mob/user)
	. = ..()
	if(placed_atom)
		. += span_notice("Contains")
		. += placed_atom.examine()

/obj/structure/steam_recharger/valid_water_connection(direction, obj/structure/water_pipe/pipe)
	if(!input)
		input = pipe
		return TRUE
	return FALSE

/obj/structure/steam_recharger/process()
	if(!placed_atom)
		return
	if(!input)
		return

	if(!ispath(input.carrying_reagent, /datum/reagent/steam))
		return

	var/taking_pressure = min(100, input.water_pressure)
	var/obj/structure/water_pipe/picked_provider = pick(input.providers)
	picked_provider?.taking_from?.use_water_pressure(taking_pressure)
	if(!SEND_SIGNAL(placed_atom, COMSIG_ATOM_STEAM_INCREASE, taking_pressure))
		src.visible_message(span_notice("[placed_atom] is fully charged."))
		remove_placed()

/obj/structure/steam_recharger/return_rotation_chat(atom/movable/screen/movable/mouseover/mouseover)
	mouseover.maptext_height = 128

	if(!input || !ispath(input.carrying_reagent, /datum/reagent/steam))
		return {"<span style='font-size:8pt;font-family:"Pterra";color:#808000;text-shadow:0 0 1px #fff, 0 0 2px #fff, 0 0 30px #e60073, 0 0 40px #e60073, 0 0 50px #e60073, 0 0 60px #e60073, 0 0 70px #e60073;' class='center maptext '>
			NO STEAM INPUT"}

	return {"<span style='font-size:8pt;font-family:"Pterra";color:#808000;text-shadow:0 0 1px #fff, 0 0 2px #fff, 0 0 30px #e60073, 0 0 40px #e60073, 0 0 50px #e60073, 0 0 60px #e60073, 0 0 70px #e60073;' class='center maptext '>
			Input Pressure:[input ? input.water_pressure : "0"] "}

/obj/structure/steam_recharger/proc/remove_placed(mob/user)
	placed_atom?.forceMove(get_turf(src))
	if(user && placed_atom)
		user.put_in_hand(placed_atom)
	placed_atom = null
	update_overlays()

/obj/structure/steam_recharger/proc/add_placed(mob/user, obj/item/placer)
	if(placed_atom)
		return
	placed_atom = placer
	placer.forceMove(src)
	update_overlays()
	user.visible_message(span_notice("[user] places [placer] on [src]."), span_notice("You place [placer] on [src]."))

/obj/structure/steam_recharger/update_overlays()
	. = ..()
	cut_overlays()

	if(!placed_atom)
		return
	var/mutable_appearance/MA = mutable_appearance()
	MA.appearance = placed_atom.appearance

	overlays += MA

/obj/structure/steam_recharger/attack_hand(mob/user)
	. = ..()
	if(!placed_atom)
		return
	user.visible_message(span_danger("[user] starts to lift [placed_atom] from [src]!"), span_notice("You start to remove [placed_atom] from [src]!"))
	if(!do_after(user, 1.6 SECONDS, src))
		return
	remove_placed(user)

/obj/structure/steam_recharger/attackby(obj/item/I, mob/living/user)
	. = ..()
	if(placed_atom)
		return
	user.visible_message(span_danger("[user] starts to place [I] onto [src]!"), span_notice("You start to place [I] onto [src]!"))
	if(!do_after(user, 1.6 SECONDS, src))
		return
	add_placed(user, I)
