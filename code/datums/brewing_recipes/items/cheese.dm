/datum/brewing_recipe/cheese
	name = "Cheese"
	needed_reagents = list(/datum/reagent/consumable/milk/salted = 5)
	reagent_to_brew = null
	brewed_item = /obj/item/reagent_containers/food/snacks/cheese
	brew_time = 4 MINUTES
	sell_value = 0
	brewed_amount = 0
	helpful_hints = "Needs to be strained with a cloth to finish."

/datum/brewing_recipe/cheese/after_finish_attackby(mob/user, obj/item/attacked_item, atom/source)
	if(!istype(attacked_item, /obj/item/natural/cloth))
		return FALSE

	user.visible_message("<span class='info'>[user] strains fresh cheese...</span>")
	playsound(src, pick('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg'), 100, FALSE)

	if(!do_after(user, (90 - (user.mind.get_skill_level(/datum/skill/craft/cooking) * 15)), source))
		return FALSE

	return TRUE

/datum/brewing_recipe/cheese/gote
	name = "Gote Cheese"
	needed_reagents = list(/datum/reagent/consumable/milk/salted_gote = 5)
	brewed_item = /obj/item/reagent_containers/food/snacks/cheese/gote
