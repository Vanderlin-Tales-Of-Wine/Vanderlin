/datum/artificer_recipe
	var/name
	var/list/additional_items = list()
	var/appro_skill = /datum/skill/craft/engineering
	var/required_item
	var/created_item
	/// Craft Difficulty here only matters for exp calculation and locking recipes based on skill level
	var/craftdiff = 0
	var/obj/item/needed_item
	/// If tha current item has been hammered all the times it needs to
	var/hammered = FALSE
	/// How many times does this need to be hammered?
	var/hammers_per_item = 0
	var/progress
	/// I_type is like "sub category"
	var/i_type

	var/datum/parent

// Small design rules for Artificer!
// If you make any crafteable by the Artificer trough here make sure it interacts with Artificer Contraptions!

/datum/artificer_recipe/proc/advance(obj/item/I, mob/user)
	if(progress == 100)
		return
	if(hammers_per_item == 0)
		hammered = TRUE
		user.visible_message(span_warning("[user] hammers the contraption."))
		if(additional_items.len)
			needed_item = pick(additional_items)
			additional_items -= needed_item
		if(needed_item)
			to_chat(user, span_info("Now it's time to add \a [initial(needed_item.name)]."))
			return
	if(!needed_item && hammered)
		progress = 100
		return
	if(!hammered && hammers_per_item)
		switch(user.mind.get_skill_level(appro_skill))
			if(SKILL_LEVEL_NONE to SKILL_LEVEL_NOVICE)
				hammers_per_item = max(0, hammers_per_item -= 0.5)
			if(SKILL_LEVEL_APPRENTICE to SKILL_LEVEL_JOURNEYMAN)
				hammers_per_item = max(0, hammers_per_item -= 1)
			if(SKILL_LEVEL_EXPERT to SKILL_LEVEL_MASTER)
				hammers_per_item = max(0, hammers_per_item -= 2)
			if(SKILL_LEVEL_LEGENDARY to INFINITY)
				hammers_per_item = max(0, hammers_per_item -= 3)
		user.visible_message(span_warning("[user] hammers the contraption."))
		return

/datum/artificer_recipe/proc/item_added(mob/user)
	user.visible_message(span_info("[user] adds [initial(needed_item.name)]."))
	if(istype(needed_item, /obj/item/natural/wood/plank))
		playsound(user, 'sound/misc/wood_saw.ogg', 100, TRUE)
	needed_item = null
	hammers_per_item = initial(hammers_per_item)
	hammered = FALSE

// --------- GENERAL -----------

/datum/artificer_recipe
	appro_skill = /datum/skill/craft/engineering

/datum/artificer_recipe/wood //This looks a bit silly but due to how these datums work is necessary for other things to inherit from it
	name = "Wooden Cog"
	required_item = /obj/item/natural/wood/plank
	created_item = /obj/item/cart_upgrade/level_1
	additional_items = list(/obj/item/natural/wood/plank = 1)
	hammers_per_item = 5
	craftdiff = 1
	i_type = "General"

/datum/artificer_recipe/wood/upgrade2
	name = "Advanced Wooden Cog (+1 Essence of Lumber)"
	created_item = /obj/item/cart_upgrade/level_2
	additional_items = list(/obj/item/natural/wood/plank = 1, /obj/item/grown/log/tree/small/essence = 1)
	hammers_per_item = 10
	craftdiff = 2

/datum/artificer_recipe/bronze
	name = "Bronze Cog"
	required_item = /obj/item/ingot/bronze
	created_item = /obj/item/roguegear
	hammers_per_item = 10
	craftdiff = 1
	i_type = "General"

/datum/artificer_recipe/bronze/locks
	name = "Lock"
	created_item = /obj/item/customlock
	hammers_per_item = 5
	craftdiff = 1

/datum/artificer_recipe/bronze/keys
	name = "Keys 2x"
	created_item = list(/obj/item/key_custom_blank, /obj/item/key_custom_blank)
	hammers_per_item = 5
	craftdiff = 1

// --------- TOOLS -----------

/datum/artificer_recipe/bronze/tools
	name = "Bronze Lamptern"
	created_item = /obj/item/flashlight/flare/torch/lantern/bronzelamptern
	hammers_per_item = 9
	craftdiff = 3
	i_type = "Tools"

// --------- Contraptions -----------

/datum/artificer_recipe/contraptions
	i_type = "Contraptions"

/datum/artificer_recipe/contraptions/metalizer
	name = "Wood Metalizer (+1 Wooden Upgrade Cog)"
	required_item = /obj/item/ingot/bronze
	additional_items = list(/obj/item/cart_upgrade/level_1 = 1)
	created_item = /obj/item/contraption/wood_metalizer
	hammers_per_item = 12
	craftdiff = 4

/datum/artificer_recipe/contraptions/smelter
	name = "Portable Smelter (+1 Coal)"
	required_item = /obj/item/ingot/bronze
	additional_items = list(/obj/item/rogueore/coal = 1)
	created_item = /obj/item/contraption/smelter
	hammers_per_item = 10
	craftdiff = 3

// --------- Ammo -----------

/datum/artificer_recipe/iron/ammo/lead_bullet
	name = "Lead Bullet"
	hammers_per_item = 2
	created_item = /obj/item/ammo_casing/caseless/rogue/bullet
	required_item = /obj/item/ingot/iron
	i_type = "Ammo"
	craftdiff = 2

/datum/artificer_recipe/iron/ammo/bolts
	name = "Crossbow bolt"
	required_item = /obj/item/ingot/iron
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/ammo_casing/caseless/rogue/bolt
	hammers_per_item = 2
	i_type = "Ammo"
	craftdiff = 1
// --------- PROSTHETICS -----------

/datum/artificer_recipe/wood/prosthetics
	name = "Left Wooden Arm (+1 Wooden Cog)"
	created_item = /obj/item/bodypart/l_arm/prosthetic/wood
	additional_items = list(/obj/item/natural/wood/plank = 2, /obj/item/cart_upgrade/level_1 = 1)
	i_type = "Prosthetics"
	hammers_per_item = 4
	craftdiff = 2

/datum/artificer_recipe/wood/prosthetics/arm_right
	name = "Right Wooden Arm (+1 Wooden Cog)"
	created_item = /obj/item/bodypart/r_arm/prosthetic/wood

/datum/artificer_recipe/wood/prosthetics/leg_left
	name = "Left Wooden Leg (+1 Wooden Cog)"
	created_item = /obj/item/bodypart/l_leg/prosthetic/wood

/datum/artificer_recipe/wood/prosthetics/leg_right
	name = "Right Wooden Leg (+1 Wooden Cog)"
	created_item = /obj/item/bodypart/r_leg/prosthetic/wood

// --------- BRONZE -----------

/datum/artificer_recipe/bronze/prosthetic
	name = "Bronze Left Arm (+1 Cog)"
	created_item = /obj/item/bodypart/l_arm/prosthetic/bronze
	hammers_per_item = 15
	craftdiff = 4
	additional_items = list(/obj/item/roguegear = 1)
	i_type = "Prosthetics"

/datum/artificer_recipe/bronze/prosthetic/arm_right
	name = "Bronze Right Arm (+1 Cog)"
	created_item = /obj/item/bodypart/r_arm/prosthetic/bronze

// --------- GOLD -----------

/datum/artificer_recipe/gold/prosthetic // Guh this need a gold subtype oh well maybe some day there will be a golden cock! COG I MEAN GOD OMG
	name = "Gold Left Arm (+2 Cog)"
	required_item = /obj/item/ingot/gold
	created_item = /obj/item/bodypart/l_arm/prosthetic/gold
	additional_items = list(/obj/item/roguegear = 2)
	hammers_per_item = 20
	craftdiff = 5
	i_type = "Prosthetics"

/datum/artificer_recipe/gold/prosthetic/arm_right
	name = "Gold Right Arm (+2 Cog)"
	created_item = /obj/item/bodypart/r_arm/prosthetic/gold

/datum/artificer_recipe/gold/prosthetic/leg_left
	name = "Gold Left Leg (+2 Cog)"
	created_item = /obj/item/bodypart/l_leg/prosthetic/gold

/datum/artificer_recipe/gold/prosthetic/leg_right
	name = "Gold Right Leg (+2 Cog)"
	created_item = /obj/item/bodypart/r_leg/prosthetic/gold

// --------- STEEL -----------

/datum/artificer_recipe/steel/prosthetic
	name = "Steel Left Arm (+1 Steel, +1 Cog)"
	created_item = /obj/item/bodypart/l_arm/prosthetic/steel
	required_item = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel = 1, /obj/item/roguegear = 1)
	hammers_per_item = 15
	craftdiff = 4
	i_type = "Prosthetics"

/datum/artificer_recipe/steel/prosthetic/arm_right
	name = "Steel Right Arm (+1 Steel, +1 Cog)"
	created_item = /obj/item/bodypart/r_arm/prosthetic/steel

/datum/artificer_recipe/steel/prosthetic/leg_left
	name = "Steel Left Leg (+1 Steel, +1 Cog)"
	created_item = /obj/item/bodypart/l_leg/prosthetic/steel

/datum/artificer_recipe/steel/prosthetic/leg_right
	name = "Steel Right Leg (+1 Steel, +1 Cog)"
	created_item = /obj/item/bodypart/r_leg/prosthetic/steel

// --------- IRON -----------

/datum/artificer_recipe/iron/prosthetic //These are the inexpensive alternatives
	name = "Iron Left Arm (+1 Cog)"
	created_item = /obj/item/bodypart/l_arm/prosthetic/iron
	required_item = /obj/item/ingot/iron
	additional_items = list(/obj/item/natural/wood/plank = 1, /obj/item/roguegear = 1)
	hammers_per_item = 4
	craftdiff = 2
	i_type = "Prosthetics"

/datum/artificer_recipe/iron/prosthetic/arm_right
	name = "Iron Right Arm (+1 Cog)"
	created_item = /obj/item/bodypart/r_arm/prosthetic/iron

/datum/artificer_recipe/iron/prosthetic/leg_left
	name = "Iron Left Leg (+1 Cog)"
	created_item = /obj/item/bodypart/l_leg/prosthetic/iron

/datum/artificer_recipe/iron/prosthetic/leg_right
	name = "Iron Right Leg (+1 Cog)"
	created_item = /obj/item/bodypart/r_leg/prosthetic/iron

// --------- Psycross -----------

/datum/artificer_recipe/silver/psycross
	name = "silver Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/roguetown/psycross/silver
	hammers_per_item = 5
	craftdiff = 2

/datum/artificer_recipe/gold/psycross
	name = "golden Psycross"
	required_item = /obj/item/ingot/gold
	created_item = /obj/item/clothing/neck/roguetown/psycross/g
	hammers_per_item = 7
	craftdiff = 3

/datum/artificer_recipe/wood/psycross/noc
	name = "Noc Psycross"
	required_item = /obj/item/natural/wood/plank
	created_item = /obj/item/clothing/neck/roguetown/psycross/noc
	hammers_per_item = 5
	craftdiff = 1

/datum/artificer_recipe/silver/psycross/astrata
	name = "Astrata Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/roguetown/psycross/silver/astrata
	hammers_per_item = 5
	craftdiff = 2

/datum/artificer_recipe/silver/psycross/dendor
	name = "Dendor Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/roguetown/psycross/silver/dendor
	hammers_per_item = 5
	craftdiff = 2

/datum/artificer_recipe/silver/psycross/abyssor
	name = "Abyssor Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/roguetown/psycross/silver/abyssor
	hammers_per_item = 5
	craftdiff = 2

/datum/artificer_recipe/silver/psycross/necra
	name = "Necra Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/roguetown/psycross/silver/necra
	hammers_per_item = 5
	craftdiff = 2

/datum/artificer_recipe/silver/psycross/ravox
	name = "Ravox Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/roguetown/psycross/silver/ravox
	hammers_per_item = 5
	craftdiff = 2

/datum/artificer_recipe/silver/psycross/xylix
	name = "Xylix Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/roguetown/psycross/silver/xylix
	hammers_per_item = 5
	craftdiff = 2

/datum/artificer_recipe/silver/psycross/eora
	name = "Eora Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/roguetown/psycross/silver/eora
	hammers_per_item = 5
	craftdiff = 2

/datum/artificer_recipe/silver/psycross/pestra
	name = "Pestra Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/roguetown/psycross/silver/pestra
	hammers_per_item = 5
	craftdiff = 2

/datum/artificer_recipe/silver/psycross/malum
	name = "Malum silver Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/roguetown/psycross/silver/malum
	hammers_per_item = 5
	craftdiff = 2

/datum/artificer_recipe/silver/psycross/malum_steel
	name = "Malum steel Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/roguetown/psycross/silver/malum_steel
	additional_items = list(/obj/item/ingot/steel = 1)
	hammers_per_item = 7
	craftdiff = 3
