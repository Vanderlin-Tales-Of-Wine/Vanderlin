//VANDERLIN TODO: Make taming AI better to allow for tame commands.
/mob/living/simple_animal/hostile/retaliate/rogue/wolf/familiar
	icon = 'icons/roguetown/mob/monster/vol.dmi'
	name = "familiar"
	desc = "A spectral volf familiar created by arcane magicks."
	icon_state = "spiritw"
	icon_living = "spiritw"
	icon_dead = null
	base_intents = list(/datum/intent/simple/bite)
	faction = list("summoned")
	mob_biotypes = MOB_BEAST
	health = 120
	maxHealth = 120
	melee_damage_lower = 10
	melee_damage_upper = 20
	food_type = list(/obj/item/reagent_containers/food/snacks/rogue/meat, /obj/item/bodypart, /obj/item/organ)
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	pooptype = null
	deaggroprob = 0
	defprob = 40
	defdrain = 10
	retreat_health = 0.1
	attack_sound = list('sound/vo/mobs/vw/attack (1).ogg','sound/vo/mobs/vw/attack (2).ogg','sound/vo/mobs/vw/attack (3).ogg','sound/vo/mobs/vw/attack (4).ogg')
	dodgetime = 30
	aggressive = 1
	remains_type = null
	var/summoner = null
	var/timeleft = 30 SECONDS
	ai_controller = /datum/ai_controller/summon

/mob/living/simple_animal/hostile/retaliate/rogue/wolf/familiar/Initialize(mapload, mob/user)
	. = ..()
	if(timeleft)
		QDEL_IN(src, timeleft) //delete after it runs out, see code/modules/mob/living/simple_animal/rogue/creacher/familiar.dm for timeleft var
	summoner = user
	faction += "[REF(summoner)]" //this makes them care about the summoner

/mob/living/simple_animal/hostile/retaliate/rogue/wolf/familiar/PickTarget(list/Targets)//Step 3, pick amongst the possible, attackable targets
	if(target != null)//If we already have a target, but are told to pick again, calculate the lowest distance between all possible, and pick from the lowest distance targets
		for(var/pos_targ in Targets)
			var/atom/A = pos_targ
			var/target_dist = get_dist(targets_from, target)
			var/possible_target_distance = get_dist(targets_from, A)
			if(target_dist < possible_target_distance)
				Targets -= A
	for(var/pos_targ in Targets)//Excludes summoner from target
		if(pos_targ == src.summoner)
			Targets -= src.summoner
	if(!Targets.len)//We didnt find nothin!
		return
	var/chosen_target = pick(Targets)//Pick the remaining targets (if any) at random
	return chosen_target
