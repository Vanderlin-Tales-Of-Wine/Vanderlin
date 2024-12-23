/datum/repeatable_crafting_recipe/leather
	abstract_type = /datum/repeatable_crafting_recipe/leather
	requirements = list(
		/obj/item/natural/hide/cured = 1
	)
	tool_usage = list(
		/obj/item/needle = list("starts to sew", "start to sew")
	)

	starting_atom = /obj/item/needle
	attacking_atom = /obj/machinery/tanningrack
	skillcraft = /datum/skill/craft/tanning
	craftdiff = 0
	subtypes_allowed = TRUE // so you can use any subtype of fur

/datum/repeatable_crafting_recipe/leather/pouch
	name = "leather pouch"
	output = /obj/item/storage/belt/rogue/pouch
	sellprice = 6

/datum/repeatable_crafting_recipe/leather/volfhelm
	name = "volf helm"
	attacking_atom = /obj/item/natural/hide
	requirements = list(
		/obj/item/natural/hide = 3,
		/obj/item/natural/fur = 2,
	)
	output = /obj/item/clothing/head/roguetown/helmet/leather/volfhelm
	sellprice = 20

/datum/repeatable_crafting_recipe/leather/gloves
	name = "leather pouch"
	output_amount = 2
	output = /obj/item/clothing/gloves/roguetown/leather

/datum/repeatable_crafting_recipe/leather/bracers
	name = "leather bracers"
	output_amount = 2
	output = /obj/item/clothing/wrists/roguetown/bracers/leather

/datum/repeatable_crafting_recipe/leather/pants
	name = "leather pants"
	output = /obj/item/clothing/under/roguetown/trou/leather

/datum/repeatable_crafting_recipe/leather/shoes
	name = "leather shoes"
	output_amount = 2
	output = /obj/item/clothing/shoes/roguetown/simpleshoes

/datum/repeatable_crafting_recipe/leather/boots
	name = "leather boots"
	output = /obj/item/clothing/shoes/roguetown/boots/leather

/datum/repeatable_crafting_recipe/leather/sandals
	name = "sandals"
	output = /obj/item/clothing/shoes/roguetown/sandals

/datum/repeatable_crafting_recipe/leather/gladiator
	name = "gladiator sandals"
	requirements = list(
		/obj/item/natural/hide/cured = 2,
	)
	output = /obj/item/clothing/shoes/roguetown/gladiator
	sellprice = 17

/datum/repeatable_crafting_recipe/leather/hood
	name = "leather hood"
	output = /obj/item/clothing/head/roguetown/roguehood/brown

/datum/repeatable_crafting_recipe/leather/cloak
	name = "leather cloak"
	requirements = list(
		/obj/item/natural/hide/cured = 2,
	)
	output = /obj/item/clothing/cloak/raincloak/brown


/datum/repeatable_crafting_recipe/leather/cloakfur
	name = "fur cloak"
	attacking_atom = /obj/item/natural/hide
	requirements = list(
		/obj/item/natural/hide = 2,
		/obj/item/natural/fur = 1,
	)
	output = /obj/item/clothing/cloak/raincloak/furcloak

/datum/repeatable_crafting_recipe/leather/quiver
	name = "quiver"
	requirements = list(
		/obj/item/natural/hide/cured = 2,
		/obj/item/natural/fibers = 2,
	)
	output = /obj/item/quiver

/datum/repeatable_crafting_recipe/leather/tribal_cloak
	name = "tribal pelt"
	attacking_atom = /obj/item/natural/hide
	requirements = list(
		/obj/item/natural/hide = 1,
	)
	output = /obj/item/clothing/cloak/tribal

/datum/repeatable_crafting_recipe/leather/tribal_shoes
	name = "tribal shoes"
	attacking_atom = /obj/item/natural/hide
	requirements = list(
		/obj/item/natural/hide = 1,
	)
	output = /obj/item/clothing/shoes/roguetown/tribal

/datum/repeatable_crafting_recipe/leather/furlinedanklets
	name = "fur lined anklets"
	requirements = list(
		/obj/item/natural/hide/cured = 1,
		/obj/item/natural/fur = 1,
	)
	output = /obj/item/clothing/shoes/roguetown/boots/furlinedanklets

/datum/repeatable_crafting_recipe/leather/saddle
	name = "saddle"
	requirements = list(
		/obj/item/natural/hide/cured = 2,
	)
	output = /obj/item/natural/saddle
	craftdiff = 1

/datum/repeatable_crafting_recipe/leather/satchel
	name = "leather satchel"
	requirements = list(
		/obj/item/natural/hide/cured = 2,
		/obj/item/natural/fibers = 1,
	)
	output = /obj/item/storage/backpack/rogue/satchel
	craftdiff = 1

/datum/repeatable_crafting_recipe/leather/meatbag
	name = "game satchel"
	attacking_atom = /obj/item/natural/hide
	requirements = list(
		/obj/item/natural/hide = 1,
		/obj/item/natural/cloth = 1,
	)
	output = /obj/item/storage/meatbag
	craftdiff = 1

/datum/repeatable_crafting_recipe/leather/waterskin
	name = "waterskin"
	attacking_atom = /obj/item/natural/hide
	requirements = list(
		/obj/item/natural/hide = 1,
		/obj/item/natural/fibers = 2,
	)
	output = /obj/item/reagent_containers/glass/bottle/waterskin
	craftdiff = 1

/datum/repeatable_crafting_recipe/leather/heavygloves
	name = "heavy leather gloves"
	requirements = list(
		/obj/item/natural/hide/cured = 1,
		/obj/item/natural/fur = 1,
	)
	output = /obj/item/clothing/gloves/roguetown/angle
	craftdiff = 1

/datum/repeatable_crafting_recipe/leather/helmet
	name = "leather helmet"
	requirements = list(
		/obj/item/natural/hide/cured = 2,
	)
	output = /obj/item/clothing/head/roguetown/helmet/leather
	craftdiff = 1

/datum/repeatable_crafting_recipe/leather/armor
	name = "leather armor"
	requirements = list(
		/obj/item/natural/hide/cured = 2,
	)
	output = /obj/item/clothing/suit/roguetown/armor/leather
	craftdiff = 1

/datum/repeatable_crafting_recipe/leather/papakha
	name = "papakha hat"
	attacking_atom = /obj/item/natural/fur
	requirements = list(
		/obj/item/natural/fur = 1,
		/obj/item/natural/fibers = 2,
	)
	output = /obj/item/clothing/head/roguetown/papakha
	craftdiff = 1

/datum/repeatable_crafting_recipe/leather/whip
	name = "leather whip"
	attacking_atom = /obj/item/natural/hide
	requirements = list(
		/obj/item/natural/hide = 2,
	)
	output = /obj/item/rogueweapon/whip
	craftdiff = 1

/datum/repeatable_crafting_recipe/leather/furlinedboots
	name = "fur lined boots"
	requirements = list(
		/obj/item/natural/hide/cured = 2,
		/obj/item/natural/fur = 2,
	)
	output = /obj/item/clothing/shoes/roguetown/boots/furlinedboots
	craftdiff = 1


/datum/repeatable_crafting_recipe/leather/backpack
	name = "leather backpack"
	requirements = list(
		/obj/item/natural/hide/cured = 3,
		/obj/item/natural/fibers = 2,
	)
	output = /obj/item/storage/backpack/rogue/backpack
	craftdiff = 2

/datum/repeatable_crafting_recipe/leather/hidearmor
	name = "hide armor"
	attacking_atom = /obj/item/natural/hide
	requirements = list(
		/obj/item/natural/hide = 2,
		/obj/item/natural/fur = 1,
	)
	output = /obj/item/clothing/suit/roguetown/armor/leather/hide
	craftdiff = 2

/datum/repeatable_crafting_recipe/leather/coif
	name = "leather coif"
	attacking_atom = /obj/item/natural/hide
	requirements = list(
		/obj/item/natural/hide = 1,
	)
	output = /obj/item/clothing/neck/roguetown/coif
	craftdiff = 2

/datum/repeatable_crafting_recipe/leather/leatherjacket
	name = "leather jacket"
	requirements = list(
		/obj/item/natural/hide/cured = 1,
	)
	output = list(/obj/item/clothing/suit/roguetown/armor/leather/jacket)
	craftdiff = 1

/datum/repeatable_crafting_recipe/leather/brimmedhat
	name = "brimmed hat x2"
	requirements = list(
		/obj/item/natural/hide/cured = 1,
	)
	output = list(/obj/item/clothing/head/roguetown/brimmed)
	craftdiff = 1

/datum/repeatable_crafting_recipe/leather/volfmantle
	name = "volf mantle"
	attacking_atom = /obj/item/natural/fur/volf
	requirements = list(
		/obj/item/natural/fur/volf = 2,
		/obj/item/natural/head/volf = 1,
	)
	output = /obj/item/clothing/cloak/volfmantle
	craftdiff = 2

/datum/repeatable_crafting_recipe/leather/standalone
	abstract_type = /datum/repeatable_crafting_recipe/leather/standalone
	attacking_atom = /obj/item/natural/hide/cured

/datum/repeatable_crafting_recipe/leather/standalone/boots
	name = "hardened leather boots"
	output = /obj/item/clothing/shoes/roguetown/boots/leather/advanced
	requirements = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/datum/repeatable_crafting_recipe/leather/standalone/gloves
	name = "hardened leather gloves"
	output = /obj/item/clothing/gloves/roguetown/leather/advanced
	requirements = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/datum/repeatable_crafting_recipe/leather/standalone/coat
	name = "hardened leather coat"
	output = /obj/item/clothing/suit/roguetown/armor/leather/advanced
	requirements = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/datum/repeatable_crafting_recipe/leather/standalone/hood
	name = "hardened leather hooded helmet"
	output = /obj/item/clothing/head/roguetown/helmet/leather/advanced
	requirements = list(/obj/item/natural/hide/cured = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/datum/repeatable_crafting_recipe/leather/standalone/chausses
	name = "hardened leather chausses"
	output = /obj/item/clothing/under/roguetown/trou/leather/advanced
	requirements = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/// MASTERWORK

/datum/repeatable_crafting_recipe/leather/standalone/boots/masterwork
	name = "masterwork leather boots"
	output = /obj/item/clothing/shoes/roguetown/boots/leather/masterwork
	attacking_atom = /obj/item/clothing/shoes/roguetown/boots/leather
	requirements = list(/obj/item/clothing/shoes/roguetown/boots/leather = 1,
				/obj/item/natural/cured/essence = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 5

/datum/repeatable_crafting_recipe/leather/standalone/gloves/masterwork
	name = "masterwork leather gloves"
	output = /obj/item/clothing/gloves/roguetown/leather/masterwork
	attacking_atom = /obj/item/clothing/gloves/roguetown/leather
	requirements = list(/obj/item/clothing/gloves/roguetown/leather = 1,
				/obj/item/natural/cured/essence = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 5

/datum/repeatable_crafting_recipe/leather/standalone/bracers/masterwork
	name = "masterwork leather bracers"
	output = /obj/item/clothing/wrists/roguetown/bracers/leather/masterwork
	attacking_atom = /obj/item/clothing/wrists/roguetown/bracers/leather
	requirements = list(/obj/item/clothing/wrists/roguetown/bracers/leather = 1,
				/obj/item/natural/cured/essence = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 5

/datum/repeatable_crafting_recipe/leather/standalone/coat/masterwork
	name = "masterwork leather coat"
	output = /obj/item/clothing/suit/roguetown/armor/leather/masterwork
	attacking_atom = /obj/item/clothing/suit/roguetown/armor/leather
	requirements = list(/obj/item/clothing/suit/roguetown/armor/leather = 1,
				/obj/item/natural/cured/essence = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 5

/datum/repeatable_crafting_recipe/leather/standalone/helmet/masterwork
	name = "masterwork leather helmet"
	output = /obj/item/clothing/head/roguetown/helmet/leather/masterwork
	attacking_atom = /obj/item/clothing/head/roguetown/helmet/leather
	requirements = list(/obj/item/clothing/head/roguetown/helmet/leather = 1,
				/obj/item/natural/cured/essence = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 5

/datum/repeatable_crafting_recipe/leather/standalone/chausses/masterwork
	name = "masterwork leather chausses"
	output = /obj/item/clothing/under/roguetown/trou/leather/masterwork
	attacking_atom = /obj/item/clothing/under/roguetown/trou/leather
	requirements = list(/obj/item/clothing/under/roguetown/trou/leather = 1,
				/obj/item/natural/cured/essence = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 5
