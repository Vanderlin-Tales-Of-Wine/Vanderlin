/datum/anvil_recipe
	var/name
	var/list/additional_items = list() // List of the object(s) we need to complete this recipe.
	var/material_quality = 0 // Quality of the bar(s) used. Accumulated per added ingot.
	var/num_of_materials = 1 // Total number of materials used. Quality divided among them.
	var/skill_quality = 0 // Accumulated per hit based on calculations, will decide final result.
	var/appro_skill = /datum/skill/craft/blacksmithing // The skill that will be taken into account when crafting.
	var/req_bar // The material of the ingot we need to craft.
	var/created_item // The item created when the recipe is fulfilled. Takes an object path as argument, NEVER USE A LIST.
	var/createmultiple = FALSE // Boolean. Do we create more than one result when crafted?
	var/createditem_num = 0 // How many EXTRA units this recipe will create. At 1, this creates 2 copies.
	var/craftdiff = 0 // Difficulty of craft. Affects final item quality and chance to advance steps.
	var/needed_item // What item(s) we need to add to proceed to the next step. Draws from the list on var/additional_items.
	var/needed_item_text // Name of the object we need to slap on the anvil to proceed to the next step.
	var/progress = 0 // 0 to 100%, percentage of completion on this step of crafting (or overall if no extra items required)
	var/i_type // Category of crafted item. Will determine how it shows on the crafting menu window.
	var/recipe_name // This is what will be shown when you
	var/bar_health = 100 // Current material bar health, reduced by failures. At 0 HP it is deleted.
	var/numberofhits = 0 // Increased every time you hit the bar, the more you have to hit the bar the less quality of the product.
	var/numberofbreakthroughs = 0 // How many good hits we got on the metal, advances recipes 50% faster, reduces number of hits total, and restores bar_health
	var/datum/parent // The ingot we're currently working on.

/datum/anvil_recipe/New(datum/P, ...)
	parent = P
	. = ..()

/datum/anvil_recipe/proc/advance(mob/user, breakthrough = FALSE)
	var/moveup = 1
	var/proab = 0 // Probability to not spoil the bar
	var/skill_level	= user.mind.get_skill_level(appro_skill)
	if(progress == 100)
		to_chat(user, "<span class='info'>It's ready.</span>")
		user.visible_message("<span class='warning'>[user] strikes the bar!</span>")
		return FALSE
	if(needed_item)
		to_chat(user, "<span class='info'>Now it's time to add a [needed_item_text].</span>")
		user.visible_message("<span class='warning'>[user] strikes the bar!</span>")
		return FALSE
	// Calculate probability of fucking up, based on smith's skill level
	if(!skill_level)
		proab = 25
	else if(skill_level < 4)
		proab = 33 * skill_level
	else // No good smith start with skill levels lower than 3
		proab = 100
	proab -= craftdiff // Crafting difficulty substracts from your chance to advance
	// Roll the dice to see if the hit actually causes to accumulate progress
	if(prob(proab))
		moveup += round((skill_level * 6) * (breakthrough == 1 ? 1.5 : 1))
		moveup -= craftdiff
		progress = min(progress + moveup, 100)
		numberofhits++
	else
		moveup = 0
		numberofhits++ // Increase regardless of success

	// This step is finished, check if more items are needed and restart the process
	if(progress == 100 && additional_items.len)
		needed_item = pick(additional_items)
		var/obj/item/I = new needed_item()
		needed_item_text = I.name
		qdel(I)
		additional_items -= needed_item
		progress = 0

	if(!moveup)
		if(!prob(proab)) // Roll again, this time negatively, for consequences.
			user.visible_message("<span class='warning'>[user] ruins the bar!</span>")
			skill_quality -= 1 // The more you fuck up, the less quality the end result will be.
			bar_health -= craftdiff // Difficulty of the recipe adds to how critical the failure is
			if(parent)
				var/obj/item/P = parent
				switch(skill_level)
					if(0)
						bar_health -= 25 // 4 strikes and you're out, buddy.
					if(1 to 3)
						bar_health -= floor(20 / skill_level)
					if(4)
						bar_health -= 5
					if(5 to 6)
						var/mob/living/L = user
						if(L.stat_roll(STATKEY_LCK,4,10,TRUE)) // Unlucky, not unskilled.
							bar_health -= craftdiff
				if(bar_health <= 0)
					user.visible_message("<span class='danger'>[user] destroys the bar!</span>")
					qdel(P)
			return FALSE
		else
			user.visible_message("<span class='warning'>[user] fumbles the bar!</span>")
			return FALSE

	else
		if(user.mind && isliving(user))
			var/mob/living/L = user
			var/amt2raise = L.STAINT // It would be impossible to level up otherwise
			var/boon = user.mind.get_learning_boon(appro_skill)
			if(amt2raise > 0)
				if(!HAS_TRAIT(user, TRAIT_MALUMFIRE))
					skill_quality += (rand(skill_level*6, skill_level*15) * moveup) // Lesser quality for self-learned non-professional smiths by trade
					if(skill_level < 3) // Non-blacksmith jobs can't level past 3. Ever.
						user.mind.add_sleep_experience(appro_skill, floor(amt2raise * boon), FALSE)
				else
					skill_quality += (rand(skill_level*8, skill_level*17) * moveup)
					if(skill_level < 3)
						amt2raise /= 2 // Let's not get out of hand it's for lower levels with high chances of failure
						user.mind.add_sleep_experience(appro_skill, amt2raise * boon, FALSE)
					else // Sanity, no expert blacksmith has lower skill than 3, for if admins manually add the trait or blacksmith vampire thralls
						user.mind.add_sleep_experience(appro_skill, amt2raise, FALSE)

		if(breakthrough)
			user.visible_message("<span class='deadsay'>[user] deftly strikes the bar!</span>")
			if(bar_health < 100)
				bar_health += 20 // Correcting the mistakes, ironing the kinks. Low chance, so rewarding.
		else
			user.visible_message("<span class='info'>[user] strikes the bar!</span>")
		return TRUE

/datum/anvil_recipe/proc/item_added(mob/user)
	needed_item = null
	user.visible_message("<span class='info'>[user] adds a [needed_item_text].</span>")
	needed_item_text = null

/datum/anvil_recipe/proc/handle_creation(obj/item/I)
	numberofhits = ceil(numberofhits / num_of_materials) // Divide the hits equally among the number of bars required, rounded up.
	if(numberofbreakthroughs) // Hitting the bar the perfect way should be rewarding quality-wise
		numberofhits -= numberofbreakthroughs
	material_quality = floor(material_quality/num_of_materials)-2
	skill_quality = floor((skill_quality/num_of_materials)/1500)+material_quality
	// Finally, the more hits the thing required, the less quality it will be, to prevent low level smiths from dishing good stuff
	skill_quality -= floor(numberofhits * 0.25)
	var/modifier // Multiplier which will determine quality of final product depending on final skill_quality calculation
	switch(skill_quality)
		if(BLACKSMITH_LEVEL_MIN to BLACKSMITH_LEVEL_SPOIL)
			I.name = "ruined [I.name]"
			modifier = 0.3
		if(BLACKSMITH_LEVEL_AWFUL)
			I.name = "awful [I.name]"
			modifier = 0.5
		if(BLACKSMITH_LEVEL_CRUDE)
			I.name = "crude [I.name]"
			modifier = 0.8
		if(BLACKSMITH_LEVEL_ROUGH)
			I.name = "rough [I.name]"
			modifier = 0.9
		if(BLACKSMITH_LEVEL_COMPETENT)
			modifier = 1
		if(BLACKSMITH_LEVEL_FINE)
			I.name = "fine [I.name]"
			modifier = 1.1
		if(BLACKSMITH_LEVEL_FLAWLESS)
			I.name = "flawless [I.name]"
			modifier = 1.2
		if(BLACKSMITH_LEVEL_LEGENDARY to BLACKSMITH_LEVEL_MAX)
			I.name = "masterwork [I.name]"
			modifier = 1.3

	if(!modifier) // Sanity.
		return
	// Finally, modify the smithed item's stats based on modifier multiplier
	I.max_integrity  *= modifier
	I.obj_integrity *= modifier
	I.sellprice *= modifier
	// Make lockpicks better at their job
	if(istype(I, /obj/item/lockpick))
		var/obj/item/lockpick/L = I
		L.picklvl = modifier
	// Apply inherent weapon modifiers
	if(istype(I, /obj/item/rogueweapon))
		var/obj/item/rogueweapon/W = I
		W.force *= modifier
		W.throwforce *= modifier
		W.blade_int *= modifier
		W.max_blade_int *= modifier
		W.armor_penetration *= modifier
		W.wdefense *= modifier
		// Make (ONLY) axes (and the Pick-axe) better at woodcutting too
		if(istype(I, /obj/item/rogueweapon/axe/iron) || istype(I, /obj/item/rogueweapon/pick/paxe))
			var/obj/item/rogueweapon/A = I
			A.axe_cut += (A.force * modifier) * 0.5 // Multiply the axe's damage by the modifier, and add half of this as axe_cut
		// If it's a pick, make it better at its job
		if(istype(I, /obj/item/rogueweapon/pick))
			var/obj/item/rogueweapon/pick/P = I
			P.pickmult *= modifier
	// Apply inherent armor modifiers
	if(istype(I, /obj/item/clothing))
		var/obj/item/clothing/C = I
		C.damage_deflection *= modifier
		C.integrity_failure /= modifier
		C.armor = C.armor.multiplymodifyAllRatings(modifier)
		C.equip_delay_self *= modifier
	// If it's a crossbow, up its damage multiplier
	if(istype(I,/obj/item/gun/ballistic/revolver/grenadelauncher))
		var/obj/item/gun/ballistic/revolver/grenadelauncher/R = I
		R.damfactor = modifier
	// Modify beartrap's damage.
	if(istype(I, /obj/item/restraints/legcuffs/beartrap))
		var/obj/item/restraints/legcuffs/beartrap/B
		B.trap_damage *= modifier
