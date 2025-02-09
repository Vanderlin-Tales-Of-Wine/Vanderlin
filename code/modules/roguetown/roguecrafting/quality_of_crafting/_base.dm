/datum/repeatable_crafting_recipe
	abstract_type = /datum/repeatable_crafting_recipe

	var/name = "Generic Recipe"
	var/atom/output
	var/output_amount = 1
	var/list/requirements = list()
	var/list/reagent_requirements = list()
	///this is a list of tool usage in their order which executes after requirements and reagents are fufilled these are assoc lists going path = list(text, sound)
	var/list/tool_usage = list()

	///our sellprice
	var/sellprice = 0

	///this is the things we check for in our offhand ie herb pouch or something to repeat the craft
	var/list/offhand_repeat_check = list(/obj/item/storage/backpack/rogue)
	///if this is set we also check the floor on the ground
	var/check_around_owner = TRUE
	///this is the atom we need to start the process
	var/atom/starting_atom
	///this is the thing we need to hit to start
	var/atom/attacking_atom

	///our crafting difficulty
	var/craftdiff = 1
	///our skilltype
	var/datum/skill/skillcraft = /datum/skill/craft/crafting

	///the amount of time the atom in question spends doing this recipe
	var/craft_time = 1 SECONDS
	///do we put in hand?
	var/put_items_in_hand = TRUE
	///the time it takes to move an item from ground to hand
	var/ground_use_time = 0.2 SECONDS
	///the time it takes to move an item from storage to hand
	var/storage_use_time = 0.4 SECONDS
	///the time it takes to use reagents on the craft
	var/reagent_use_time = 0.8 SECONDS
	///how long we use a tool on the craft for
	var/tool_use_time = 1.2 SECONDS
	///our crafting message
	var/crafting_message
	///if we need to be on a table
	var/required_table = FALSE
	///intent we require
	var/datum/intent/required_intent
	///do we also use the attacking_atom in the recipe?
	var/uses_attacking_atom = FALSE
	///do we also count subtypes?
	var/subtypes_allowed = FALSE
	///list of types we pass before deletion to the child
	var/list/pass_types_in_end = list()

/datum/repeatable_crafting_recipe/proc/check_start(obj/item/attacked_item, obj/item/attacking_item, mob/user)
	if(!istype(attacked_item, attacking_atom) && !istype(attacked_item, /obj/item/natural/bundle))
		return FALSE

	if(istype(attacked_item, /obj/item/natural/bundle))
		var/bundle_path = attacked_item:stacktype
		if(!ispath(bundle_path, attacking_atom))
			return FALSE


	if(required_intent && user.used_intent != required_intent)
		return FALSE

	var/obj/structure/table/table = locate(/obj/structure/table) in get_turf(attacking_atom)
	if(required_table && !table)
		return FALSE

	var/list/copied_requirements = requirements.Copy()
	var/list/copied_reagent_requirements = reagent_requirements.Copy()
	var/list/copied_tool_usage = tool_usage.Copy()
	var/list/usable_contents = list()

	for(var/obj/item/I in user.held_items)
		if(istype(I, /obj/item/natural/bundle))
			var/bundle_path = I:stacktype
			usable_contents |= bundle_path
			usable_contents[bundle_path] += I:amount
		else
			usable_contents |= I.type
			usable_contents[I.type]++

	var/obj/item/inactive_hand = user.get_inactive_held_item()
	if(is_type_in_list(inactive_hand, offhand_repeat_check))
		for(var/obj/item in inactive_hand.contents)
			if(istype(item, /obj/item/natural/bundle))
				var/bundle_path = item:stacktype
				usable_contents |= bundle_path
				usable_contents[bundle_path] += item:amount
			else
				usable_contents |= item.type
				usable_contents[item.type] ++

	if(check_around_owner)
		for(var/turf/listed_turf in range(1, user))
			for(var/obj/item in listed_turf.contents)
				if(istype(item, /obj/item/natural/bundle))
					var/bundle_path = item:stacktype
					usable_contents |= bundle_path
					usable_contents[bundle_path] += item:amount
				else
					usable_contents |= item.type
					usable_contents[item.type]++

	var/list/total_list = usable_contents
	for(var/path as anything in total_list)
		for(var/required_path as anything in requirements)
			if(!ispath(path, required_path))
				continue
			if(!subtypes_allowed && (path in subtypesof(required_path)))
				return FALSE
			if(total_list[path] < requirements[required_path])
				return FALSE
			copied_requirements -= required_path

	for(var/path as anything in total_list)
		for(var/required_path as anything in tool_usage)
			if(!ispath(path, required_path))
				continue
			copied_tool_usage -= required_path

	if(length(reagent_requirements))
		var/list/reagent_values = list()
		for(var/obj/item/reagent_containers/container in user.held_items)
			for(var/datum/reagent/reagent as anything in container.reagents.reagent_list)
				reagent_values |= reagent.type
				reagent_values[reagent.type] += reagent.volume

		if(check_around_owner)
			for(var/turf/listed_turf in range(1, user))
				for(var/obj/item/reagent_containers/container in listed_turf.contents)
					for(var/datum/reagent/reagent as anything in container.reagents.reagent_list)
						reagent_values |= reagent.type
						reagent_values[reagent.type] += reagent.volume

		for(var/path in reagent_values)
			for(var/required_path as anything in reagent_requirements)
				if(!ispath(path, required_path))
					continue
				if(reagent_values[path] < reagent_requirements[required_path])
					return FALSE
				copied_reagent_requirements -= required_path

	if(length(copied_requirements)|| length(copied_reagent_requirements) || length(copied_tool_usage))
		return FALSE

	return TRUE

/datum/repeatable_crafting_recipe/proc/check_max_repeats(obj/item/attacked_item, obj/item/attacking_item, mob/user)
	var/list/usable_contents = list()
	if(uses_attacking_atom)
		usable_contents |= attacked_item.type
		usable_contents[attacked_item.type]++

	for(var/obj/item/I in user.held_items)
		if(istype(I, /obj/item/natural/bundle))
			var/bundle_path = I:stacktype
			usable_contents |= bundle_path
			usable_contents[bundle_path] += I:amount
		else
			usable_contents |= I.type
			usable_contents[I.type]++

	var/obj/item/inactive_hand = user.get_inactive_held_item()
	if(is_type_in_list(inactive_hand, offhand_repeat_check))
		for(var/obj/item in inactive_hand.contents)
			if(istype(item, /obj/item/natural/bundle))
				var/bundle_path = item:stacktype
				usable_contents |= bundle_path
				usable_contents[bundle_path] += item:amount
			else
				usable_contents |= item.type
				usable_contents[item.type] ++

	if(check_around_owner)
		for(var/turf/listed_turf in range(1, user))
			for(var/obj/item in listed_turf.contents)
				if(istype(item, /obj/item/natural/bundle))
					var/bundle_path = item:stacktype
					usable_contents |= bundle_path
					usable_contents[bundle_path] += item:amount
				else
					usable_contents |= item.type
					usable_contents[item.type]++

	var/max_crafts = 10000
	var/list/total_list = usable_contents
	for(var/path as anything in total_list)
		for(var/required_path as anything in requirements)
			if(!ispath(path, required_path))
				continue
			var/holder_max_crafts = FLOOR(total_list[path] / requirements[required_path], 1)
			if(holder_max_crafts < max_crafts)
				max_crafts = holder_max_crafts

	if(length(reagent_requirements))
		var/list/reagent_values = list()
		for(var/obj/item/reagent_containers/container in user.held_items)
			for(var/datum/reagent/reagent as anything in container.reagents.reagent_list)
				reagent_values |= reagent.type
				reagent_values[reagent.type] += reagent.volume

		if(check_around_owner)
			for(var/turf/listed_turf in range(1, user))
				for(var/obj/item/reagent_containers/container in listed_turf.contents)
					for(var/datum/reagent/reagent as anything in container.reagents.reagent_list)
						reagent_values |= reagent.type
						reagent_values[reagent.type] += reagent.volume

		for(var/path in reagent_values)
			for(var/required_path as anything in reagent_requirements)
				if(!ispath(path, required_path))
					continue
				var/holder_max_crafts = FLOOR(reagent_values[path] / reagent_requirements[required_path], 1)
				if(holder_max_crafts < max_crafts)
					max_crafts = holder_max_crafts


	return max_crafts

/datum/repeatable_crafting_recipe/proc/start_recipe(obj/item/attacked_item, obj/item/attacking_item, mob/user)
	var/max_crafts = check_max_repeats(attacked_item, attacking_item, user)
	var/actual_crafts = 1
	if(max_crafts > 1)
		actual_crafts = input(user, "How many [name] do you want to craft?", "Repeat Option", max_crafts) as null|num
	if(!actual_crafts)
		return
	actual_crafts = CLAMP(actual_crafts, 1, max_crafts)

	if(!istype(attacked_item, attacking_atom) && !istype(attacked_item, /obj/item/natural/bundle))
		return FALSE

	if(istype(attacked_item, /obj/item/natural/bundle))
		var/bundle_path = attacked_item:stacktype
		if(!ispath(bundle_path, attacking_atom))
			return FALSE

	var/list/usable_contents = list()
	var/list/storage_contents = list()

	if(uses_attacking_atom && !QDELETED(attacked_item))
		usable_contents |= attacked_item

	for(var/obj/item/I in user.held_items)
		usable_contents |= I

	var/obj/item/inactive_hand = user.get_inactive_held_item()
	if(is_type_in_list(inactive_hand, offhand_repeat_check))
		for(var/obj/item in inactive_hand.contents)
			storage_contents |= item

	if(check_around_owner)
		for(var/turf/listed_turf in range(1, user))
			for(var/obj/item in listed_turf.contents)
				usable_contents |= item

	while(actual_crafts)
		actual_crafts--
		for(var/obj/item/I in user.held_items)
			usable_contents |= I
		inactive_hand = user.get_inactive_held_item()
		if(is_type_in_list(inactive_hand, offhand_repeat_check))
			for(var/obj/item in inactive_hand.contents)
				storage_contents |= item

		if(check_around_owner)
			for(var/turf/listed_turf in range(1, user))
				for(var/obj/item in listed_turf.contents)
					usable_contents |= item
		var/list/copied_requirements = requirements.Copy()
		var/list/copied_reagent_requirements = reagent_requirements.Copy()
		var/list/copied_tool_usage = tool_usage.Copy()
		var/list/to_delete = list()

		var/obj/item/active_item = user.get_active_held_item()


		if(put_items_in_hand)
			if(!is_type_in_list(active_item, requirements))
				for(var/obj/structure/table/table in range(1, user))
					user.transferItemToLoc(active_item, get_turf(table), TRUE)
					active_item = null
					break
				if(active_item)
					user.transferItemToLoc(active_item, get_turf(user), TRUE)
					active_item = null

			if(isnull(active_item))
				for(var/obj/item/item in usable_contents)
					if(!length(copied_requirements))
						break
					if(!is_type_in_list(item, copied_requirements) && !istype(item, /obj/item/natural/bundle))
						continue
					if(istype(item, /obj/item/natural/bundle))
						var/obj/item/natural/bundle/bundle = item
						var/early_continue = TRUE
						var/bundle_path = bundle.stacktype
						var/early_break = FALSE
						for(var/path in copied_requirements)
							if(QDELETED(item))
								break
							if(!ispath(bundle_path, path))
								continue
							bundle.amount--
							var/obj/item/sub_item = new bundle_path(get_turf(item))
							usable_contents += sub_item
							if(bundle.amount == 0)
								usable_contents -= item
								qdel(item)
							user.visible_message(span_small("[user] starts picking up [sub_item]."), span_small("I start picking up [sub_item]."))
							if(do_after(user, ground_use_time, item))
								if(put_items_in_hand)
									user.put_in_active_hand(sub_item)
								for(var/requirement in copied_requirements)
									if(!istype(sub_item, requirement))
										continue
									copied_requirements[requirement]--
									active_item = sub_item
									early_break = TRUE
									early_continue = FALSE
									break

						if(early_break)
							break
						if(early_continue)
							continue

					user.visible_message(span_small("[user] starts picking up [item]."), span_small("I start picking up [item]."))
					if(do_after(user, ground_use_time, item))
						user.put_in_active_hand(item)
						active_item = item
					break

			if(isnull(active_item))
				for(var/obj/item/item in storage_contents)
					if(!length(copied_requirements))
						break
					if(!is_type_in_list(item, copied_requirements) && !istype(item, /obj/item/natural/bundle))
						continue
					if(istype(item, /obj/item/natural/bundle))
						var/early_continue = TRUE
						var/bundle_path = item:stacktype
						var/early_break = FALSE
						for(var/path in copied_requirements)
							if(QDELETED(item))
								break
							if(!ispath(bundle_path, path))
								continue
							item:amount--
							var/obj/item/sub_item = new bundle_path(get_turf(item))
							usable_contents += sub_item
							if(item:amount == 0)
								usable_contents -= item
								qdel(item)
							to_chat(user, "You start grabbing [item] from your bag.")
							if(do_after(user, storage_use_time, item))
								if(put_items_in_hand)
									user.put_in_active_hand(sub_item)
								for(var/requirement in copied_requirements)
									if(!istype(sub_item, requirement))
										continue
									copied_requirements[requirement]--
									active_item = sub_item
									early_break = TRUE
									early_continue = FALSE
									break

						if(early_break)
							break
						if(early_continue)
							continue

					to_chat(user, "You start grabbing [item] from your bag.")
					if(do_after(user, storage_use_time, item))
						user.put_in_active_hand(item)
						active_item = item
					break

			if(!is_type_in_list(active_item, copied_requirements))
				move_items_back(to_delete, user)
				return

			for(var/requirement in copied_requirements)
				if(!istype(active_item, requirement))
					continue
				copied_requirements[requirement]--
				if(copied_requirements[requirement] <= 0)
					copied_requirements -= requirement
				usable_contents -= active_item
				to_delete += active_item
				active_item.forceMove(locate(1,1,1)) ///the fucking void of items

		for(var/obj/item/item in usable_contents)
			if(!length(copied_requirements))
				break
			if(!is_type_in_list(item, copied_requirements) && !istype(item, /obj/item/natural/bundle))
				continue
			if(istype(item, /obj/item/natural/bundle))
				var/continue_early = TRUE
				var/bundle_path = item:stacktype
				for(var/path in copied_requirements)
					if(QDELETED(item))
						break
					if(!ispath(bundle_path, path))
						continue
					for(var/i = 1 to item:amount)
						item:amount--
						var/obj/item/sub_item = new bundle_path(get_turf(item))
						if(item:amount == 0)
							usable_contents -= item
							qdel(item)
						user.visible_message(span_small("[user] starts picking up [sub_item]."), span_small("I start picking up [sub_item]."))
						if(do_after(user, ground_use_time, item))
							if(put_items_in_hand)
								user.put_in_active_hand(item)
							for(var/requirement in copied_requirements)
								if(!istype(sub_item, requirement))
									continue
								copied_requirements[requirement]--
								to_delete += sub_item
								sub_item.forceMove(locate(1,1,1)) ///the fucking void of items
								if(copied_requirements[requirement] <= 0)
									copied_requirements -= requirement
									continue_early = FALSE
									break
				if(continue_early)
					continue


			user.visible_message(span_small("[user] starts picking up [item]."), span_small("I start picking up [item]."))
			if(do_after(user, ground_use_time, item))
				if(put_items_in_hand)
					user.put_in_active_hand(item)
				for(var/requirement in copied_requirements)
					if(!istype(item, requirement))
						continue
					copied_requirements[requirement]--
					if(copied_requirements[requirement] <= 0)
						copied_requirements -= requirement
					usable_contents -= item
					to_delete += item
					item.forceMove(locate(1,1,1)) ///the fucking void of items
			else
				break

		for(var/obj/item/item in storage_contents)
			if(!length(copied_requirements))
				break
			if(!is_type_in_list(item, copied_requirements))
				continue
			to_chat(user, "You start grabbing [item] from your bag.")
			if(do_after(user, storage_use_time, item))
				if(put_items_in_hand)
					user.put_in_active_hand(item)
				for(var/requirement in copied_requirements)
					if(!istype(item, requirement))
						continue
					copied_requirements[requirement]--
					if(copied_requirements[requirement] <= 0)
						copied_requirements -= requirement
					storage_contents -= item
					to_delete += item
					item.forceMove(locate(1,1,1)) ///the fucking void of items
			else
				break

		if(length(copied_reagent_requirements))
			var/obj/item/inactive_held = user.get_inactive_held_item()
			for(var/obj/item/reagent_containers/container in storage_contents)
				for(var/required_path as anything in copied_reagent_requirements)
					var/reagent_value = container.reagents.get_reagent_amount(required_path)
					if(!reagent_value)
						continue
					user.visible_message(span_small("[user] starts to incorporate some liquid into [name]."), span_small("You start to pour some liquid into [name]."))
					if(put_items_in_hand)
						if(!do_after(user, storage_use_time, container))
							continue
						user.put_in_active_hand(container)
					if(istype(container, /obj/item/reagent_containers/glass/bottle))
						var/obj/item/reagent_containers/glass/bottle/bottle = container
						if(bottle.closed)
							bottle.rmb_self(user)
					if(!do_after(user, reagent_use_time, container))
						continue
					playsound(get_turf(user), pick(container.poursounds), 100, TRUE)
					if(reagent_value < copied_reagent_requirements[required_path]) //reagents are lost regardless as you kinda already poured them in no unpouring.
						container.reagents.remove_reagent(required_path, reagent_value)
						copied_reagent_requirements[required_path] -= reagent_value
					else
						container.reagents.remove_reagent(required_path, copied_reagent_requirements[required_path])
						copied_reagent_requirements -= required_path
					if(put_items_in_hand)
						SEND_SIGNAL(inactive_held, COMSIG_TRY_STORAGE_INSERT, container, null, TRUE, TRUE)

			for(var/obj/item/reagent_containers/container in usable_contents)
				for(var/required_path as anything in copied_reagent_requirements)
					var/reagent_value = container.reagents.get_reagent_amount(required_path)
					if(!reagent_value)
						continue
					var/turf/container_loc = get_turf(container)
					var/stored_pixel_x = container.pixel_x
					var/stored_pixel_y = container.pixel_y
					user.visible_message(span_small("[user] starts to incorporate some liquid into [name]."), span_small("You start to pour some liquid into [name]."))
					if(put_items_in_hand)
						if(!do_after(user, ground_use_time, container))
							continue
						user.put_in_active_hand(container)
					if(istype(container, /obj/item/reagent_containers/glass/bottle))
						var/obj/item/reagent_containers/glass/bottle/bottle = container
						if(bottle.closed)
							bottle.rmb_self(user)
					if(!do_after(user, reagent_use_time, container))
						continue
					playsound(get_turf(user), pick(container.poursounds), 100, TRUE)
					if(reagent_value < copied_reagent_requirements[required_path]) //reagents are lost regardless as you kinda already poured them in no unpouring.
						container.reagents.remove_reagent(required_path, reagent_value)
						copied_reagent_requirements[required_path] -= reagent_value
					else
						container.reagents.remove_reagent(required_path, copied_reagent_requirements[required_path])
						copied_reagent_requirements -= required_path
					if(put_items_in_hand)
						user.transferItemToLoc(container, container_loc, TRUE)
						container.pixel_x = stored_pixel_x
						container.pixel_y = stored_pixel_y


		if(length(copied_tool_usage))
			var/obj/item/inactive_held = user.get_inactive_held_item()
			for(var/tool_path in copied_tool_usage)
				for(var/obj/item/potential_tool in storage_contents)
					if(!istype(potential_tool, tool_path))
						continue
					var/list/tool_path_extra = copied_tool_usage[tool_path]
					if(put_items_in_hand)
						if(!do_after(user, storage_use_time, potential_tool))
							continue
						user.put_in_active_hand(potential_tool)
					user.visible_message(span_small("[user] [tool_path_extra[1]]."), span_small("You [tool_path_extra[2]]."))
					if(length(tool_path_extra) >= 2)
						playsound(get_turf(user), tool_path_extra[3], 100, FALSE)
					if(!do_after(user, tool_use_time, potential_tool))
						continue
					copied_tool_usage -= tool_path
					if(put_items_in_hand)
						SEND_SIGNAL(inactive_held, COMSIG_TRY_STORAGE_INSERT, potential_tool, null, TRUE, TRUE)
					break

			for(var/tool_path in copied_tool_usage)
				for(var/obj/item/potential_tool in usable_contents)
					if(!istype(potential_tool, tool_path))
						continue
					var/list/tool_path_extra = copied_tool_usage[tool_path]
					var/turf/container_loc = get_turf(potential_tool)
					var/stored_pixel_x = potential_tool.pixel_x
					var/stored_pixel_y = potential_tool.pixel_y
					if(put_items_in_hand)
						if(!do_after(user, storage_use_time, potential_tool))
							continue
						user.put_in_active_hand(potential_tool)
					user.visible_message(span_small("[user] [tool_path_extra[1]]."), span_small("You [tool_path_extra[2]]."))
					if(length(tool_path_extra) >= 3)
						playsound(get_turf(user), tool_path_extra[3], 100, FALSE)
					if(!do_after(user, tool_use_time, potential_tool))
						continue
					copied_tool_usage -= tool_path
					if(put_items_in_hand)
						user.transferItemToLoc(potential_tool, container_loc, TRUE)
						potential_tool.pixel_x = stored_pixel_x
						potential_tool.pixel_y = stored_pixel_y
					break


		if(!length(copied_requirements) && !length(copied_reagent_requirements) && !length(copied_tool_usage))
			if(crafting_message)
				user.visible_message(span_small("[user] [crafting_message]."), span_small("I [crafting_message]."))
			if(do_after(user, craft_time, attacked_item))
				var/prob2craft = 25
				var/prob2fail = 1
				if(craftdiff)
					prob2craft -= (25 * craftdiff)
				if(skillcraft)
					if(user.mind)
						prob2craft += (user.mind.get_skill_level(skillcraft) * 25)
				else
					prob2craft = 100
				if(isliving(user))
					var/mob/living/L = user
					if(L.STALUC > 10)
						prob2fail = 0
					if(L.STALUC < 10)
						prob2fail += (10-L.STALUC)
					if(L.STAINT > 10)
						prob2craft += ((10-L.STAINT)*-1)*2
				if(prob2craft < 1)
					to_chat(user, "<span class='danger'>I lack the skills for this...</span>")
					move_items_back(to_delete, user)
					return
				else
					prob2craft = CLAMP(prob2craft, 5, 99)
					if(prob(prob2fail)) //critical fail
						to_chat(user, "<span class='danger'>MISTAKE! I've completely fumbled the crafting of \the [name]!</span>")
						move_items_back(to_delete, user)
						return
					if(!prob(prob2craft))
						if(user.client?.prefs.showrolls)
							to_chat(user, "<span class='danger'>I've failed to craft \the [name]. (Success chance: [prob2craft]%)</span>")
							move_items_back(to_delete, user)
							actual_crafts++
							continue
						to_chat(user, "<span class='danger'>I've failed to craft \the [name].</span>")
						move_items_back(to_delete, user)
						actual_crafts++
						continue

				if(put_items_in_hand)
					active_item = null

				var/list/outputs = list()
				for(var/spawn_count = 1 to output_amount)
					var/obj/item/new_item = new output(get_turf(user))

					new_item.sellprice = sellprice
					new_item.randomize_price()

					if(length(pass_types_in_end))
						var/list/parts = list()
						for(var/obj/item/listed as anything in to_delete)
							if(!is_type_in_list(listed, pass_types_in_end))
								continue
							parts += listed
						new_item.CheckParts(parts)
						new_item.OnCrafted(user.dir)
						parts = null

					outputs += new_item

				for(var/obj/item/deleted in to_delete)
					to_delete -= deleted
					qdel(deleted)
				if(user.mind && skillcraft)
					if(isliving(user))
						var/mob/living/L = user
						var/amt2raise = L.STAINT * 2// its different over here
						if(craftdiff > 0) //difficult recipe
							amt2raise += (craftdiff * 10)
						if(amt2raise > 0)
							user.mind.add_sleep_experience(skillcraft, amt2raise, FALSE)
				move_products(outputs, user)

			else
				move_items_back(to_delete, user)

		else
			move_items_back(to_delete, user)
			move_products(list(), user)
	return TRUE

/datum/repeatable_crafting_recipe/proc/move_items_back(list/items, mob/user)
	for(var/obj/item/item in items)
		item.forceMove(user.drop_location())
	user.update_inv_hands() //the consequences of forcemoving

//Attempt to put tools in hand first. Then puts a random item from products in hand.
/datum/repeatable_crafting_recipe/proc/move_products(list/products, mob/user)
	var/list/copied_tool_usage = tool_usage.Copy()
	for(var/turf/listed_turf in range(1, user))
		for(var/obj/item in listed_turf.contents)
			for(var/tool in copied_tool_usage)
				if(istype(item, tool))
					copied_tool_usage -= tool
					user.put_in_hands(item)
					break
	if(length(products))
		user.put_in_hands(pick(products))

/datum/repeatable_crafting_recipe/proc/generate_html(mob/user)
	var/client/client = user
	if(!istype(client))
		client = user.client
	SSassets.transport.send_assets(client, list("try4_border.png", "try4.png", "slop_menustyle2.css"))
	user << browse_rsc('html/book.png')
	var/html = {"
		<!DOCTYPE html>
		<html lang="en">
		<meta charset='UTF-8'>
		<meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'/>
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'/>

		<style>
			@import url('https://fonts.googleapis.com/css2?family=Charm:wght@700&display=swap');
			body {
				font-family: "Charm", cursive;
				font-size: 1.2em;
				text-align: center;
				margin: 20px;
				background-color: #f4efe6;
				color: #3e2723;
				background-color: rgb(31, 20, 24);
				background:
					url('[SSassets.transport.get_asset_url("try4_border.png")]'),
					url('book.png');
				background-repeat: no-repeat;
				background-attachment: fixed;
				background-size: 100% 100%;

			}
			h1 {
				text-align: center;
				font-size: 2.5em;
				border-bottom: 2px solid #3e2723;
				padding-bottom: 10px;
				margin-bottom: 20px;
			}
			.icon {
				width: 96px;
				height: 96px;
				vertical-align: middle;
				margin-right: 10px;
			}
		</style>
		<body>
		  <div>
		    <h1>[name]</h1>
		    <div>
		      <strong>Requirements</strong>
			  <br>
		"}
	for(var/atom/path as anything in requirements)
		var/count = requirements[path]
		if(subtypes_allowed)
			html += "[icon2html(new path, user)] [count] of any [initial(path.name)]<br>"
		else
			html += "[icon2html(new path, user)] [count] [initial(path.name)]<br>"

	html += {"
		</div>
		<div>
		"}

	if(length(tool_usage))
		html += {"
		<br>
		<div>
		    <strong>Required Tools</strong>
			<br>
			  "}
		for(var/atom/path as anything in tool_usage)
			if(subtypes_allowed)
				html += "[icon2html(new path, user)] any [initial(path.name)]<br>"
			else
				html += "[icon2html(new path, user)] [initial(path.name)]<br>"
		html += {"
			</div>
		<div>
		"}

	if(length(reagent_requirements))
		html += {"
		<br>
		<div>
		    <strong>Required Liquids</strong>
			<br>
			  "}
		for(var/atom/path as anything in reagent_requirements)
			var/count = reagent_requirements[path]
			html += "[CEILING(count / 3, 1)] oz of [initial(path.name)]<br>"
		html += {"
			</div>
		<div>
		"}

	html += "<strong class=class='scroll'>start the process with</strong> <br>[icon2html(new attacking_atom, user)] <br> [initial(attacking_atom.name)]<br>"
	if(subtypes_allowed)
		html += "<strong class=class='scroll'>using</strong> <br> [icon2html(new starting_atom, user)] <br> any [initial(starting_atom.name)] on it<br>"
	else
		html += "<strong class=class='scroll'>using</strong> <br> [icon2html(new starting_atom, user)] <br> [initial(starting_atom.name)] on it<br>"


	html += {"
		</div>
		</div>
	</body>
	</html>
	"}
	return html

/datum/repeatable_crafting_recipe/proc/show_menu(mob/user)
	user << browse(generate_html(user),"window=recipe;size=500x810")
