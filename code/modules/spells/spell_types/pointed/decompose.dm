// TODO touch spell?
/datum/action/cooldown/spell/decompose
	name = "Decompose"
	desc = "Instantly rots the target, if humanoid creates a deadite."
	button_icon_state = "orison"
	sound = 'sound/magic/whiteflame.ogg'

	cast_range = 1
	point_cost = 3
	associated_skill = /datum/skill/magic/blood
	attunements = list(
		/datum/attunement/death = 0.3,
		/datum/attunement/blood = 0.2,
	)
	invocation = "Return to rot."
	invocation_type = INVOCATION_WHISPER

	charge_time = 5 SECONDS
	charge_drain = 1
	cooldown_time = 30 SECONDS
	spell_cost = 50

/datum/action/cooldown/spell/decompose/is_valid_target(atom/cast_on)
	return isitem(cast_on) || isliving(target)

/datum/action/cooldown/spell/decompose/cast(atom/cast_on)
	. = ..()
	if(isitem(cast_on))
		if(istype(cast_on, /obj/item/reagent_containers/food/snacks))
			var/obj/item/reagent_containers/food/snacks/food = cast_on
			food.rotprocess = 0
		return
	// DATUMISE ROT PLEASE
	if(isanimal(cast_on))
		var/mob/living/simple_animal/SA = cast_on
		var/datum/component/rot/rot = SA.GetComponent(/datum/component/rot/simple)
		if(rot?.amount < 9.9 MINUTES)
			rot.amount = 9.9 MINUTES
		return
	if(ishuman(cast_on))
		var/mob/living/carbon/human/H = cast_on
		var/datum/antagonist/zombie/ZD = H.zombie_check()
		if(!ZD)
			return
		ZD.wake_zombie(TRUE)
