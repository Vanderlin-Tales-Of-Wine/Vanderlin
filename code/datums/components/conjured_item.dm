#define DEFAULT_DURATION 15 MINUTES
/* Component for adding a generic magical outline to a component, make it disappear if not held / worn
by Arcane user after a duration
*/

/datum/component/conjured_item
	var/endtime = null // How long till the conjured item disappear (Don't use duration it is messed up)
	var/allow_refresh = TRUE // If TRUE, the item will refresh its duration when held by a X user
	var/refresh_skill = /datum/skill/magic/arcane // The skill that will be used to refresh the item
	var/outline_color = "#6495ED"
	var/overridden_duration = null
	var/mob/living/current_user = null // The current user of the item

/datum/component/conjured_item/Initialize(duration_override, allow_refresh_override, refresh_skill_override, outline_color_override, mob/living/owner_override)
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

	if(duration_override)
		endtime = world.time += duration_override
		overridden_duration = duration_override
	else
		endtime = world.time += DEFAULT_DURATION
	if(allow_refresh_override)
		allow_refresh = allow_refresh_override
	if(refresh_skill_override)
		refresh_skill = refresh_skill_override
	if(outline_color_override)
		outline_color = outline_color_override
	if(owner_override)
		current_user = owner_override

	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(on_equip))
	RegisterSignal(parent, COMSIG_ITEM_DROPPED, PROC_REF(on_unequip))

	var/obj/item/I = parent
	I.filters += filter(type = "drop_shadow", x=0, y=0, size=1, offset = 2, color = outline_color)
	I.smeltresult = null
	I.salvage_result = null
	I.fiber_salvage = FALSE

	START_PROCESSING(SSdcs, src)

/datum/component/conjured_item/process()
	if(endtime <= world.time)
		if(isliving(current_user) && refresh_skill)
			if(!current_user.mind)
				return
			var/has_right_skill = current_user?.get_skill_level(refresh_skill)
			if(has_right_skill)
				if(overridden_duration)
					endtime += overridden_duration
				else
					endtime += DEFAULT_DURATION
				return
		qdel(parent)
		return

/datum/component/conjured_item/proc/on_equip(datum/source, mob/user, slot)
	if(isliving(user))
		current_user = user

/datum/component/conjured_item/proc/on_unequip(datum/source, mob/user, slot)
	current_user = null

/datum/component/conjured_item/proc/on_examine(datum/source, mob/user, list/examine_list)
	examine_list += "This item crackles with faint arcane energy. It seems to be conjured."
	var/remaining_minutes = round((endtime - world.time) / 600)
	examine_list += "It will last for [remaining_minutes] more minutes."

#undef DEFAULT_DURATION
