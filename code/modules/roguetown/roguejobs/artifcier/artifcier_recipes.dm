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
	var/created_amount = 1
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
			additional_items[needed_item] -= 1
			if(additional_items[needed_item] <= 0)
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

/datum/artificer_recipe/general
	i_type = "General"

/datum/artificer_recipe/general/woodcog //This looks a bit silly but due to how these datums work is necessary for other things to inherit from it
	name = "Wooden Cog"
	required_item = /obj/item/natural/wood/plank
	created_item = /obj/item/roguegear/wood/basic
	hammers_per_item = 5
	craftdiff = 1

/datum/artificer_recipe/general/woodcogupgrade2
	name = "Reliable Wooden Cog (+1 Essence of Lumber)"
	required_item = /obj/item/natural/wood/plank
	created_item = /obj/item/roguegear/wood/reliable
	additional_items = list(/obj/item/grown/log/tree/small/essence = 1)
	hammers_per_item = 5
	craftdiff = 2

/datum/artificer_recipe/general/unstable
	name = "Unstable Wooden Cog (+1 Essence of Wilderness)"
	required_item = /obj/item/natural/wood/plank
	created_item = /obj/item/roguegear/wood/unstable
	additional_items = list(/obj/item/natural/cured/essence = 1)
	hammers_per_item = 10
	craftdiff = 3

/datum/artificer_recipe/general/cog
	name = "3x Cogs"
	required_item = /obj/item/ingot/bronze
	created_item = /obj/item/roguegear/metal/bronze
	hammers_per_item = 10
	craftdiff = 1
	created_amount = 3

/datum/artificer_recipe/general/locks
	name = "5x Custom Locks"
	required_item = /obj/item/ingot/bronze
	created_item = /obj/item/customlock
	hammers_per_item = 5
	craftdiff = 1
	created_amount = 5

/datum/artificer_recipe/general/keys
	name = "5x Blank Custom Keys"
	required_item = /obj/item/ingot/bronze
	created_item = /obj/item/key_custom_blank
	hammers_per_item = 5
	craftdiff = 1
	created_amount = 5

/datum/artificer_recipe/general/bronze_cast
	name = "Bronze Casting"
	required_item = /obj/item/ingot/copper
	additional_items = list(/obj/item/ingot/tin = 1)
	created_item = /obj/item/ingot/bronze
	hammers_per_item = 3
	created_amount = 2
	craftdiff = 0

// --------- TOOLS -----------

/datum/artificer_recipe/tools
	i_type = "Tools"

/datum/artificer_recipe/tools/lamptern
	name = "Bronze Lamptern"
	required_item = /obj/item/ingot/bronze
	created_item = /obj/item/flashlight/flare/torch/lantern/bronzelamptern
	hammers_per_item = 9
	craftdiff = 2

// --------- WEAPON -----------

/datum/artificer_recipe/weapons
	i_type = "Weapons"

/datum/artificer_recipe/weapons/crossbow
	name = "Crossbow (+1 Steel) (+1 Fiber)"
	required_item = /obj/item/natural/wood/plank
	created_item = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	additional_items = list(/obj/item/ingot/steel, /obj/item/natural/fibers)
	hammers_per_item = 7
	craftdiff = 4

// --------- Contraptions -----------

/datum/artificer_recipe/contraptions
	i_type = "Contraptions"

/datum/artificer_recipe/contraptions/metalizer
	name = "Wood Metalizer (+1 Wooden Cog)"
	required_item = /obj/item/ingot/bronze
	additional_items = list(/obj/item/roguegear/wood = 1)
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

/datum/artificer_recipe/contraptions/shears
	name = "Amputation Shears (+2 Bronze)"
	required_item = /obj/item/ingot/bronze
	additional_items = list(/obj/item/ingot/bronze = 2)
	created_item = /obj/item/contraption/shears
	hammers_per_item = 7
	craftdiff = 4

/datum/artificer_recipe/contraptions/linker
	name = "Engineering Linker (+1 Gold)"
	required_item = /obj/item/ingot/bronze
	additional_items = list(/obj/item/ingot/gold = 1)
	created_item = /obj/item/contraption/linker
	hammers_per_item = 10
	craftdiff = 3

/datum/artificer_recipe/contraptions/waterpurifier
	name = "Self-Purifying Waterskin (+1 Waterskin)"
	required_item = /obj/item/ingot/bronze
	created_item = /obj/item/reagent_containers/glass/bottle/waterskin/purifier
	additional_items = list(/obj/item/reagent_containers/glass/bottle/waterskin)
	hammers_per_item = 8
	craftdiff = 3

// --------- Ammo -----------

/datum/artificer_recipe/ammo
	i_type = "Ammo"

/datum/artificer_recipe/ammo/lead_bullet
	name = "Lead Bullets 2x"
	hammers_per_item = 2
	created_item = /obj/item/ammo_casing/caseless/rogue/bullet
	required_item = /obj/item/ingot/iron
	craftdiff = 2
	created_amount = 2

/datum/artificer_recipe/ammo/bolts
	name = "Crossbow Bolts 5x (+1 Iron)"
	required_item = /obj/item/natural/wood/plank
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/ammo_casing/caseless/rogue/bolt
	hammers_per_item = 6
	craftdiff = 2
	created_amount = 5

/datum/artificer_recipe/ammo/arrows
	name = "Arrows 5x (+1 Iron)"
	required_item = /obj/item/natural/wood/plank
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/ammo_casing/caseless/rogue/arrow
	hammers_per_item = 6
	craftdiff = 2
	created_amount = 5

// --------- WOODEN PROSTHETICS -----------

/datum/artificer_recipe/prosthetics
	i_type = "Prosthetics"

/datum/artificer_recipe/prosthetics/wood
	name = "Left Wooden Arm (+1 Plank)"
	required_item = /obj/item/natural/wood/plank
	created_item = /obj/item/bodypart/l_arm/prosthetic/wood
	additional_items = list(/obj/item/natural/wood/plank = 1)
	hammers_per_item = 4
	craftdiff = 2

/datum/artificer_recipe/prosthetics/wood/arm_right
	name = "Right Wooden Arm (+1 Plank)"
	created_item = /obj/item/bodypart/r_arm/prosthetic/wood

/datum/artificer_recipe/prosthetics/wood/leg_left
	name = "Left Wooden Leg (+1 Plank)"
	created_item = /obj/item/bodypart/l_leg/prosthetic/wood

/datum/artificer_recipe/prosthetics/wood/leg_right
	name = "Right Wooden Leg (+1 Plank)"
	created_item = /obj/item/bodypart/r_leg/prosthetic/wood

// --------- BRONZE PROSTHETICS -----------

/datum/artificer_recipe/prosthetics/bronze
	name = "Bronze Left Arm (+2 Cogs)"
	required_item = /obj/item/ingot/bronze
	created_item = /obj/item/bodypart/l_arm/prosthetic/bronze
	hammers_per_item = 10
	craftdiff = 4
	additional_items = list(/obj/item/roguegear/metal = 2)

/datum/artificer_recipe/prosthetics/bronze/arm_right
	name = "Bronze Right Arm (+2 Cogs)"
	created_item = /obj/item/bodypart/r_arm/prosthetic/bronze

// --------- GOLD PROSTHETICS -----------

/datum/artificer_recipe/prosthetics/gold // Guh this need a gold subtype oh well maybe some day there will be a golden cock! COG I MEAN GOD OMG
	name = "Gold Left Arm (+1 Cog)"
	required_item = /obj/item/ingot/gold
	created_item = /obj/item/bodypart/l_arm/prosthetic/gold
	additional_items = list(/obj/item/roguegear/metal = 1)
	hammers_per_item = 20
	craftdiff = 5

/datum/artificer_recipe/prosthetics/gold/arm_right
	name = "Gold Right Arm (+1 Cog)"
	created_item = /obj/item/bodypart/r_arm/prosthetic/gold

/datum/artificer_recipe/prosthetics/gold/leg_left
	name = "Gold Left Leg (+1 Cog)"
	created_item = /obj/item/bodypart/l_leg/prosthetic/gold

/datum/artificer_recipe/prosthetics/gold/leg_right
	name = "Gold Right Leg (+1 Cog)"
	created_item = /obj/item/bodypart/r_leg/prosthetic/gold

// --------- STEEL PROSTHETICS -----------

/datum/artificer_recipe/prosthetics/steel
	name = "Steel Left Arm (+1 Steel, +1 Cog)"
	created_item = /obj/item/bodypart/l_arm/prosthetic/steel
	required_item = /obj/item/ingot/steel
	additional_items = list(/obj/item/ingot/steel = 1, /obj/item/roguegear/metal = 1)
	hammers_per_item = 15
	craftdiff = 4

/datum/artificer_recipe/prosthetics/steel/arm_right
	name = "Steel Right Arm (+1 Steel, +1 Cog)"
	created_item = /obj/item/bodypart/r_arm/prosthetic/steel

/datum/artificer_recipe/prosthetics/steel/leg_left
	name = "Steel Left Leg (+1 Steel, +1 Cog)"
	created_item = /obj/item/bodypart/l_leg/prosthetic/steel

/datum/artificer_recipe/prosthetics/steel/leg_right
	name = "Steel Right Leg (+1 Steel, +1 Cog)"
	created_item = /obj/item/bodypart/r_leg/prosthetic/steel

// --------- IRON PROSTHETICS -----------

/datum/artificer_recipe/prosthetics/iron //These are the inexpensive alternatives
	name = "Iron Left Arm (+1 Cog)"
	created_item = /obj/item/bodypart/l_arm/prosthetic/iron
	required_item = /obj/item/ingot/iron
	additional_items = list(/obj/item/roguegear/metal = 1)
	hammers_per_item = 4
	craftdiff = 2

/datum/artificer_recipe/prosthetics/iron/arm_right
	name = "Iron Right Arm (+1 Cog)"
	created_item = /obj/item/bodypart/r_arm/prosthetic/iron

/datum/artificer_recipe/prosthetics/iron/leg_left
	name = "Iron Left Leg (+1 Cog)"
	created_item = /obj/item/bodypart/l_leg/prosthetic/iron

/datum/artificer_recipe/prosthetics/iron/leg_right
	name = "Iron Right Leg (+1 Cog)"
	created_item = /obj/item/bodypart/r_leg/prosthetic/iron

// --------- Psycross -----------

/datum/artificer_recipe/psycross
	i_type = "Psycross"

/datum/artificer_recipe/psycross/silver
	name = "silver Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/roguetown/psycross/silver
	hammers_per_item = 5
	craftdiff = 2

/datum/artificer_recipe/psycross/gold
	name = "golden Psycross"
	required_item = /obj/item/ingot/gold
	created_item = /obj/item/clothing/neck/roguetown/psycross/g
	hammers_per_item = 7
	craftdiff = 3

/datum/artificer_recipe/psycross/noc
	name = "Noc Psycross"
	required_item = /obj/item/natural/wood/plank
	created_item = /obj/item/clothing/neck/roguetown/psycross/noc
	hammers_per_item = 5
	craftdiff = 1

/datum/artificer_recipe/psycross/astrata
	name = "Astrata Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/roguetown/psycross/silver/astrata
	hammers_per_item = 5
	craftdiff = 2

/datum/artificer_recipe/psycross/dendor
	name = "Dendor Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/roguetown/psycross/silver/dendor
	hammers_per_item = 5
	craftdiff = 2

/datum/artificer_recipe/psycross/abyssor
	name = "Abyssor Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/roguetown/psycross/silver/abyssor
	hammers_per_item = 5
	craftdiff = 2

/datum/artificer_recipe/psycross/necra
	name = "Necra Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/roguetown/psycross/silver/necra
	hammers_per_item = 5
	craftdiff = 2

/datum/artificer_recipe/psycross/ravox
	name = "Ravox Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/roguetown/psycross/silver/ravox
	hammers_per_item = 5
	craftdiff = 2

/datum/artificer_recipe/psycross/xylix
	name = "Xylix Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/roguetown/psycross/silver/xylix
	hammers_per_item = 5
	craftdiff = 2

/datum/artificer_recipe/psycross/eora
	name = "Eora Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/roguetown/psycross/silver/eora
	hammers_per_item = 5
	craftdiff = 2

/datum/artificer_recipe/psycross/pestra
	name = "Pestra Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/roguetown/psycross/silver/pestra
	hammers_per_item = 5
	craftdiff = 2

/datum/artificer_recipe/psycross/malum/silver
	name = "Malum silver Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/roguetown/psycross/silver/malum
	hammers_per_item = 5
	craftdiff = 2

/datum/artificer_recipe/psycross/malum_steel/steel
	name = "Malum steel Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/roguetown/psycross/silver/malum_steel
	additional_items = list(/obj/item/ingot/steel = 1)
	hammers_per_item = 7
	craftdiff = 3
