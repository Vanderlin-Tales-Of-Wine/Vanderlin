/datum/artificer_recipe
	appro_skill = /datum/skill/craft/engineering

/datum/artificer_recipe/general
	i_type = "General"
	category = "General"

/datum/artificer_recipe/general/woodcog //This looks a bit silly but due to how these datums work is necessary for other things to inherit from it
	name = "Wooden Gear"
	required_item = /obj/item/natural/wood/plank
	created_item = /obj/item/gear/wood/basic
	hammers_per_item = 5
	craftdiff = 1

/datum/artificer_recipe/general/woodcogupgrade2
	name = "Reliable Wooden Gear (+1 Essence of Lumber)"
	required_item = /obj/item/natural/wood/plank
	created_item = /obj/item/gear/wood/reliable
	additional_items = list(/obj/item/grown/log/tree/small/essence = 1)
	hammers_per_item = 5
	craftdiff = 2

/datum/artificer_recipe/general/unstable
	name = "Unstable Wooden Gear (+1 Essence of Wilderness)"
	required_item = /obj/item/natural/wood/plank
	created_item = /obj/item/gear/wood/unstable
	additional_items = list(/obj/item/natural/cured/essence = 1)
	hammers_per_item = 10
	craftdiff = 3

/datum/artificer_recipe/general/cog
	name = "3x Bronze Gears"
	required_item = /obj/item/ingot/bronze
	created_item = /obj/item/gear/metal/bronze
	hammers_per_item = 10
	craftdiff = 1
	created_amount = 3

/datum/artificer_recipe/general/cog/iron
	name = "Iron Gear"
	required_item = /obj/item/ingot/iron
	created_item = /obj/item/gear/metal/iron
	created_amount = 1

/datum/artificer_recipe/general/cog/steel
	name = "3x Steel Gears"
	required_item = /obj/item/ingot/steel
	created_item = /obj/item/gear/metal/steel

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
	created_item = /obj/item/key/custom
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

/datum/artificer_recipe/bronze/headhook
	name = "Bronze Headhook (+Fibers x2)"
	required_item = /obj/item/ingot/bronze
	created_item = /obj/item/storage/hip/headhook/bronze
	additional_items = list(/obj/item/natural/fibers = 2)
	hammers_per_item = 6
	craftdiff = 3

///datum/artificer_recipe/gold/headhook //this ones devsprite is so ass I am just going to make it inaccasible
	//name = "Royal Headhook"
	//required_item = /obj/item/ingot/gold
	//created_item = /obj/item/storage/hip/headhook/royal
	//additional_items = list(/obj/item/ingot/silver, /obj/item/natural/silk = 2)
	//hammers_per_item = 6
	//craftdiff = 4

// --------- TOOLS -----------

/datum/artificer_recipe/tools
	i_type = "Tools"
	category = "Tools"

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
	category = "Contraptions"

/datum/artificer_recipe/contraptions/metalizer
	name = "Wood Metalizer (+1 Wooden Cog)"
	required_item = /obj/item/ingot/bronze
	additional_items = list(/obj/item/gear/wood = 1)
	created_item = /obj/item/contraption/wood_metalizer
	hammers_per_item = 12
	craftdiff = 4

/datum/artificer_recipe/contraptions/smelter
	name = "Portable Smelter (+1 Coal)"
	required_item = /obj/item/ingot/bronze
	additional_items = list(/obj/item/ore/coal = 1)
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
	name = "Engineering Wrench (+1 Gold)"
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

/datum/artificer_recipe/contraptions/coolingbackpack
	name = "Cooling Backpack (+1 Backpack, +2 Cogs)"
	required_item = /obj/item/ingot/bronze
	created_item = /obj/item/storage/backpack/backpack/artibackpack
	additional_items = list(/obj/item/gear/metal = 2, /obj/item/storage/backpack/backpack)
	hammers_per_item = 4
	craftdiff = 5

// --------- Ammo -----------

/datum/artificer_recipe/ammo
	i_type = "Ammo"
	category = "Ammo"

/datum/artificer_recipe/ammo/lead_bullet
	name = "Lead Bullets 2x"
	hammers_per_item = 2
	created_item = /obj/item/ammo_casing/caseless/bullet
	required_item = /obj/item/ingot/iron
	craftdiff = 2
	created_amount = 2

/datum/artificer_recipe/ammo/bolts
	name = "Crossbow Bolts 5x (+1 Iron)"
	required_item = /obj/item/natural/wood/plank
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/ammo_casing/caseless/bolt
	hammers_per_item = 6
	craftdiff = 2
	created_amount = 5

/datum/artificer_recipe/ammo/arrows
	name = "Arrows 5x (+1 Iron)"
	required_item = /obj/item/natural/wood/plank
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/ammo_casing/caseless/arrow
	hammers_per_item = 6
	craftdiff = 2
	created_amount = 5

// --------- WOODEN PROSTHETICS -----------

/datum/artificer_recipe/prosthetics
	i_type = "Prosthetics"
	category = "Prosthetics"

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
	additional_items = list(/obj/item/gear/metal = 2)

/datum/artificer_recipe/prosthetics/bronze/arm_right
	name = "Bronze Right Arm (+2 Cogs)"
	created_item = /obj/item/bodypart/r_arm/prosthetic/bronze

// --------- GOLD PROSTHETICS -----------

/datum/artificer_recipe/prosthetics/gold // Guh this need a gold subtype oh well maybe some day there will be a golden cock! COG I MEAN GOD OMG
	name = "Gold Left Arm (+1 Cog)"
	required_item = /obj/item/ingot/gold
	created_item = /obj/item/bodypart/l_arm/prosthetic/gold
	additional_items = list(/obj/item/gear/metal = 1)
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
	additional_items = list(/obj/item/ingot/steel = 1, /obj/item/gear/metal = 1)
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
	additional_items = list(/obj/item/gear/metal = 1)
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
	category = "Psycross"

/datum/artificer_recipe/psycross/silver
	name = "silver Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/psycross/silver
	hammers_per_item = 5
	craftdiff = 2

/datum/artificer_recipe/psycross/gold
	name = "golden Psycross"
	required_item = /obj/item/ingot/gold
	created_item = /obj/item/clothing/neck/psycross/g
	hammers_per_item = 7
	craftdiff = 3

/datum/artificer_recipe/psycross/noc
	name = "Noc Psycross"
	required_item = /obj/item/natural/wood/plank
	created_item = /obj/item/clothing/neck/psycross/noc
	hammers_per_item = 5
	craftdiff = 1

/datum/artificer_recipe/psycross/astrata
	name = "Astrata Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/psycross/silver/astrata
	hammers_per_item = 5
	craftdiff = 2

/datum/artificer_recipe/psycross/dendor
	name = "Dendor Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/psycross/silver/dendor
	hammers_per_item = 5
	craftdiff = 2

/datum/artificer_recipe/psycross/abyssor
	name = "Abyssor Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/psycross/silver/abyssor
	hammers_per_item = 5
	craftdiff = 2

/datum/artificer_recipe/psycross/necra
	name = "Necra Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/psycross/silver/necra
	hammers_per_item = 5
	craftdiff = 2

/datum/artificer_recipe/psycross/ravox
	name = "Ravox Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/psycross/silver/ravox
	hammers_per_item = 5
	craftdiff = 2

/datum/artificer_recipe/psycross/xylix
	name = "Xylix Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/psycross/silver/xylix
	hammers_per_item = 5
	craftdiff = 2

/datum/artificer_recipe/psycross/eora
	name = "Eora Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/psycross/silver/eora
	hammers_per_item = 5
	craftdiff = 2

/datum/artificer_recipe/psycross/pestra
	name = "Pestra Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/psycross/silver/pestra
	hammers_per_item = 5
	craftdiff = 2

/datum/artificer_recipe/psycross/malum/silver
	name = "Malum silver Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/psycross/silver/malum
	hammers_per_item = 5
	craftdiff = 2

/datum/artificer_recipe/psycross/malum_steel/steel
	name = "Malum steel Psycross"
	required_item = /obj/item/ingot/silver
	created_item = /obj/item/clothing/neck/psycross/silver/malum_steel
	additional_items = list(/obj/item/ingot/steel = 1)
	hammers_per_item = 7
	craftdiff = 3
