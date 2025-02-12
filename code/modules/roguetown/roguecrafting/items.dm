/datum/crafting_recipe/roguetown
	always_availible = TRUE
	skillcraft = /datum/skill/craft/crafting

/datum/crafting_recipe/roguetown/blowgun
	name = "blowgun"
	result = /obj/item/gun/ballistic/revolver/grenadelauncher/blowgun
	reqs = list(/obj/item/grown/log/tree/stick = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/clothsash
	name = "cloth sash"
	result = /obj/item/storage/belt/rogue/leather/cloth
	reqs = list(/obj/item/natural/cloth = 1)
	craftdiff = 0
	verbage = "tie"
	verbage_tp = "ties"

/datum/crafting_recipe/roguetown/unclothsash
	name = "untie cloth sash"
	result = /obj/item/natural/cloth
	reqs = list(/obj/item/storage/belt/rogue/leather/cloth = 1)
	craftdiff = 0
	verbage = "untie"
	verbage_tp = "unties"

/datum/crafting_recipe/roguetown/ropebelt
	name = "rope belt"
	result = /obj/item/storage/belt/rogue/leather/rope
	reqs = list(/obj/item/rope = 1)
	craftdiff = 0
	verbage = "untie"
	verbage_tp  = "unties"

/datum/crafting_recipe/roguetown/unropebelt
	name = "untie rope belt"
	result = /obj/item/rope
	reqs = list(/obj/item/storage/belt/rogue/leather/rope = 1)
	craftdiff = 0
	verbage = "untie"
	verbage_tp  = "unties"

/datum/crafting_recipe/roguetown/candle
	name = "candle (x2)"
	result = list(/obj/item/candle/yellow,
				/obj/item/candle/yellow)
	reqs = list(/obj/item/reagent_containers/food/snacks/fat = 1)

/datum/crafting_recipe/roguetown/woodclub
	name = "wood club"
	result = /obj/item/rogueweapon/mace/woodclub/crafted
	reqs = list(/obj/item/grown/log/tree/small = 1)
	craftdiff = 0

/obj/item/rogueweapon/mace/woodclub/crafted
	sellprice = 8

/datum/crafting_recipe/roguetown/woodstaff
	name = "wood staff"
	result = list(/obj/item/rogueweapon/polearm/woodstaff,
	/obj/item/rogueweapon/polearm/woodstaff,
	/obj/item/rogueweapon/polearm/woodstaff)
	reqs = list(/obj/item/grown/log/tree = 1)

/obj/item/rogueweapon/shield/wood/crafted
	sellprice = 6

/datum/crafting_recipe/roguetown/spoon
	name = "wooden spoon"
	result = list(/obj/item/kitchen/spoon,
				/obj/item/kitchen/spoon)
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/roguetown/rollingpin
	name = "wooden rollingpin"
	result = /obj/item/kitchen/rollingpin
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/roguetown/woodbucket
	name = "wooden bucket"
	result = /obj/item/reagent_containers/glass/bucket/wooden
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/roguetown/woodbowl
	name = "wooden bowls (x3)"
	result = list(/obj/item/reagent_containers/glass/bowl,
				/obj/item/reagent_containers/glass/bowl,
				/obj/item/reagent_containers/glass/bowl)
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/roguetown/woodcup
	name = "wooden cups (x3)"
	result = list(/obj/item/reagent_containers/glass/cup/wooden/crafted,
				/obj/item/reagent_containers/glass/cup/wooden/crafted,
				/obj/item/reagent_containers/glass/cup/wooden/crafted)
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/roguetown/woodtray
	name = "wooden trays (x2)"
	result = list(/obj/item/plate/tray,
				/obj/item/plate/tray)
	reqs = list(/obj/item/grown/log/tree/small = 1)

/obj/item/reagent_containers/glass/cup/wooden/crafted
	sellprice = 3

/obj/item/storage/roguebag/crafted
	sellprice = 4

/datum/crafting_recipe/roguetown/bait
	name = "bait"
	result = /obj/item/bait
	reqs = list(/obj/item/storage/roguebag = 1,
				/obj/item/reagent_containers/food/snacks/produce/wheat = 2)
	req_table = FALSE
	subtype_reqs = TRUE

/datum/crafting_recipe/roguetown/sbaita
	name = "sweetbait (apple)"
	result = /obj/item/bait/sweet
	reqs = list(/obj/item/storage/roguebag = 1,
				/obj/item/reagent_containers/food/snacks/produce/apple = 2)
	req_table = FALSE
	subtype_reqs = TRUE

/datum/crafting_recipe/roguetown/sbait
	name = "sweetbait (berry)"
	result = /obj/item/bait/sweet
	reqs = list(/obj/item/storage/roguebag = 1,
				/obj/item/reagent_containers/food/snacks/produce/jacksberry = 2)
	req_table = FALSE
	subtype_reqs = TRUE

/datum/crafting_recipe/roguetown/bloodbait
	name = "bloodbait"
	result = /obj/item/bait/bloody
	reqs = list(/obj/item/storage/roguebag = 1,
				/obj/item/reagent_containers/food/snacks/rogue/meat = 2)
	req_table = FALSE
	subtype_reqs = TRUE

/datum/crafting_recipe/roguetown/woodplatter
	name = "wood platters (x2)"
	result = list(/obj/item/kitchen/platter,
				/obj/item/kitchen/platter)
	reqs = list(/obj/item/grown/log/tree/small = 1)

/datum/crafting_recipe/roguetown/pipe
	name = "wood pipe"
	result = /obj/item/clothing/mask/cigarette/pipe/crafted
	reqs = list(/obj/item/grown/log/tree/stick = 2)
	craftdiff = 1
	tools = list(/obj/item/rogueweapon/knife)

/obj/item/clothing/mask/cigarette/pipe/crafted
	sellprice = 6

/datum/crafting_recipe/roguetown/rod
	name = "fishing rod"
	result = /obj/item/fishingrod/crafted
	reqs = list(/obj/item/grown/log/tree/small = 1,
		/obj/item/natural/fibers = 2)

/obj/item/fishingrod/crafted
	sellprice = 8

/datum/crafting_recipe/roguetown/woodspade
	name = "wood spade"
	result = /obj/item/rogueweapon/shovel/small
	reqs = list(/obj/item/grown/log/tree/small = 1,
			/obj/item/grown/log/tree/stick = 1)

/datum/crafting_recipe/roguetown/broom
	name = "broom"
	result = /obj/item/broom
	reqs = list(/obj/item/natural/fibers = 1,
			/obj/item/grown/log/tree/stick = 4)
	craftdiff = 1

/obj/item/rogueweapon/shovel/small/crafted
	sellprice = 5

/datum/crafting_recipe/roguetown/basket_wicker
	name = "basket (wicker)"
	result = /obj/structure/closet/crate/chest/wicker
	reqs = list(/obj/item/natural/fibers = 4)
	craftdiff = 1

/datum/crafting_recipe/roguetown/mantrap
	name = "mantrap"
	result = list(/obj/item/restraints/legcuffs/beartrap) // Intentionally old. Don't change.
	reqs = list(/obj/item/grown/log/tree/stake = 1,
				/obj/item/natural/fibers = 1,
				/obj/item/rope = 1)
	req_table = FALSE
	skillcraft = /datum/skill/craft/traps
	craftdiff = 1
	verbage = "put together"
	verbage_tp = "puts together"

/datum/crafting_recipe/roguetown/stonearrow
	name = "stone arrow (x2)"
	result = list(/obj/item/ammo_casing/caseless/rogue/arrow/stone,
				/obj/item/ammo_casing/caseless/rogue/arrow/stone)
	reqs = list(/obj/item/grown/log/tree/stick = 1,
				/obj/item/natural/stone = 1)

/datum/crafting_recipe/roguetown/stonearrow_five
	name = "stone arrow (x10)"
	result = list(
				/obj/item/ammo_casing/caseless/rogue/arrow/stone,
				/obj/item/ammo_casing/caseless/rogue/arrow/stone,
				/obj/item/ammo_casing/caseless/rogue/arrow/stone,
				/obj/item/ammo_casing/caseless/rogue/arrow/stone,
				/obj/item/ammo_casing/caseless/rogue/arrow/stone,
				/obj/item/ammo_casing/caseless/rogue/arrow/stone,
				/obj/item/ammo_casing/caseless/rogue/arrow/stone,
				/obj/item/ammo_casing/caseless/rogue/arrow/stone,
				/obj/item/ammo_casing/caseless/rogue/arrow/stone,
				/obj/item/ammo_casing/caseless/rogue/arrow/stone)
	reqs = list(/obj/item/grown/log/tree/stick = 5,
				/obj/item/natural/stone = 5)

/datum/crafting_recipe/roguetown/poisonarrow
	name = "poison arrow"
	result = /obj/item/ammo_casing/caseless/rogue/arrow/poison
	reqs = list(/obj/item/ammo_casing/caseless/rogue/arrow = 1,
				/obj/item/reagent_containers/food/snacks/produce/jacksberry/poison = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/poisonarrow/alt
	reqs = list(/obj/item/ammo_casing/caseless/rogue/arrow = 1,
				/datum/reagent/berrypoison = 5)

/datum/crafting_recipe/roguetown/poisonarrow/potent
	name = "poison arrow (potent)"
	result = /obj/item/ammo_casing/caseless/rogue/arrow/poison/potent
	reqs = list(/obj/item/ammo_casing/caseless/rogue/arrow = 1,
				/datum/reagent/strongpoison = 5)

/datum/crafting_recipe/roguetown/pyroarrow
	name = "pyroclastic arrow"
	result = /obj/item/ammo_casing/caseless/rogue/arrow/pyro
	reqs = list(/obj/item/ammo_casing/caseless/rogue/arrow = 1,
				/obj/item/reagent_containers/food/snacks/produce/fyritius = 1)
	craftdiff = 1
	skillcraft = /datum/skill/craft/engineering

/datum/crafting_recipe/roguetown/poisonbolt
	name = "poison bolt"
	result = /obj/item/ammo_casing/caseless/rogue/bolt/poison
	reqs = list(/obj/item/ammo_casing/caseless/rogue/bolt = 1,
				/obj/item/reagent_containers/food/snacks/produce/jacksberry/poison = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/poisonbolt/alt
	reqs = list(/obj/item/ammo_casing/caseless/rogue/bolt = 1,
				/datum/reagent/berrypoison = 5)

/datum/crafting_recipe/roguetown/poisonbolt/potent
	name = "poison bolt (potent)"
	result = /obj/item/ammo_casing/caseless/rogue/bolt/poison/potent
	reqs = list(/obj/item/ammo_casing/caseless/rogue/bolt = 1,
				/datum/reagent/strongpoison = 5)

/datum/crafting_recipe/roguetown/bomb
	name = "bomb"
	result = /obj/item/bomb/homemade
	reqs = list(/obj/item/natural/cloth = 1,
				/obj/item/reagent_containers/food/snacks/produce/fyritius = 1,
				/obj/item/reagent_containers/glass/bottle = 1)
	craftdiff = 2
	skillcraft = /datum/skill/craft/bombs
	subtype_reqs = TRUE

/datum/crafting_recipe/roguetown/pyrobolt
	name = "pyroclastic bolt"
	result = /obj/item/ammo_casing/caseless/rogue/bolt/pyro
	reqs = list(/obj/item/ammo_casing/caseless/rogue/bolt = 1,
				/obj/item/reagent_containers/food/snacks/produce/fyritius = 1)
	craftdiff = 1
	skillcraft = /datum/skill/craft/engineering

/datum/crafting_recipe/roguetown/recurve
	name = "recurve bow"
	result = list(/obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve)
	reqs = list(/obj/item/grown/log/tree/small = 1,
	/obj/item/natural/fibers = 4)
	craftdiff = 1
	skillcraft = /datum/skill/craft/carpentry

/datum/crafting_recipe/roguetown/handmadebow
	name = "wooden bow"
	result = list(/obj/item/gun/ballistic/revolver/grenadelauncher/bow)
	reqs = list(/obj/item/grown/log/tree/small = 1,
	/obj/item/natural/fibers = 6)
	craftdiff = 2
	skillcraft = /datum/skill/craft/carpentry

/datum/crafting_recipe/roguetown/longbow
	name = "longbow"
	result = list(/obj/item/gun/ballistic/revolver/grenadelauncher/bow/long)
	reqs = list(/obj/item/grown/log/tree/small = 1,
	/obj/item/natural/fibers = 8,
	/obj/item/reagent_containers/food/snacks/fat = 1)
	skillcraft = /datum/skill/craft/carpentry
	structurecraft = /obj/machinery/light/rogue/campfire
	craftdiff = 3

/datum/crafting_recipe/roguetown/flint
	name = "flint"
	result = /obj/item/flint
	reqs = list(
			/obj/item/natural/stone = 1,
			/obj/item/ingot/iron = 1)
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 0 // Something to practice engineering with.

/datum/crafting_recipe/roguetown/readingscroll
	name = "novice's guide to literature"
	result = list(/obj/item/literary)
	reqs = list(/obj/item/paper/scroll = 3)
	tools = list(/obj/item/natural/feather)
	req_table = TRUE
	skillcraft = /datum/skill/misc/reading
	craftdiff = 2
	verbage = "write"
	verbage_tp  = "writes"

/datum/crafting_recipe/roguetown/readingscroll/apprentice
	name = "apprentice's guide to literature"
	result = list(/obj/item/literary/apprentice)
	craftdiff = 3

/datum/crafting_recipe/roguetown/readingscroll/journeyman
	name = "journeyman's guide to literature"
	result = list(/obj/item/literary/journeyman)
	craftdiff = 4

/datum/crafting_recipe/roguetown/readingscroll/expert
	name = "expert's guide to literature"
	result = list(/obj/item/literary/expert)
	craftdiff = 5

/datum/crafting_recipe/roguetown/readingscroll/master
	name = "master's guide to literature"
	result = list(/obj/item/literary/master)
	craftdiff = 6

/datum/crafting_recipe/roguetown/quarterstaff
	name = "wooden quarterstaff"
	result = list(/obj/item/rogueweapon/polearm/woodstaff/quarterstaff)
	reqs = list(/obj/item/grown/log/tree = 1)
	req_table = TRUE
	tools = list(/obj/item/rogueweapon/knife)
	skillcraft = /datum/skill/craft/carpentry

/datum/crafting_recipe/roguetown/steelstaff
	name = "steel quarterstaff"
	skillcraft = /datum/skill/craft/carpentry
	reqs = list(/obj/item/rogueweapon/polearm/woodstaff/quarterstaff = 1, /obj/item/ingot/steel = 1)
	result = list(/obj/item/rogueweapon/polearm/woodstaff/quarterstaff/steel)
	craftdiff = 3

/datum/crafting_recipe/roguetown/ironstaff
	name = "iron quarterstaff"
	skillcraft = /datum/skill/craft/carpentry
	reqs = list(/obj/item/rogueweapon/polearm/woodstaff/quarterstaff = 1, /obj/item/ingot/iron = 1)
	tools = list(/obj/item/rogueweapon/hammer)
	result = list(/obj/item/rogueweapon/polearm/woodstaff/quarterstaff/iron)
	craftdiff = 2

/datum/crafting_recipe/roguetown/woodflail
	name = "wooden flail x2"
	skillcraft = /datum/skill/craft/carpentry
	reqs = list(/obj/item/rope/chain = 1,
			/obj/item/grown/log/tree/stick = 1, /obj/item/grown/log/tree/small = 1)
	tools = list(/obj/item/rogueweapon/hammer)
	req_table = TRUE
	result = list(/obj/item/rogueweapon/flail/towner, /obj/item/rogueweapon/flail/towner)
	craftdiff = 2

/datum/crafting_recipe/roguetown/militia_flail
	name = "militia flail"
	skillcraft = /datum/skill/craft/carpentry
	reqs = list(/obj/item/rogueweapon/flail/towner = 1, /obj/item/ingot/iron = 1)
	tools = list(/obj/item/rogueweapon/hammer)
	req_table = TRUE
	result = list(/obj/item/rogueweapon/flail/militia)
	craftdiff = 3

/datum/crafting_recipe/roguetown/woodengreatflail
	name = "thresher"
	skillcraft = /datum/skill/craft/carpentry
	reqs = list(/obj/item/rope = 1,
			/obj/item/grown/log/tree/stick = 1, /obj/item/grown/log/tree/small = 1)
	tools = list(/obj/item/rogueweapon/hammer)
	req_table = TRUE
	result = list(/obj/item/rogueweapon/thresher)
	craftdiff = 1

/datum/crafting_recipe/roguetown/bigflail
	name = "great militia flail"
	skillcraft = /datum/skill/craft/carpentry
	reqs = list(/obj/item/rope/chain = 1,
			/obj/item/rogueweapon/thresher = 1, /obj/item/ingot/iron = 1)
	tools = list(/obj/item/rogueweapon/hammer)
	req_table = TRUE
	result = list(/obj/item/rogueweapon/thresher/military)
	craftdiff = 3


/datum/crafting_recipe/roguetown/ironcudgel
	name = "peasant cudgels x2"
	skillcraft = /datum/skill/craft/carpentry
	reqs = list(/obj/item/grown/log/tree/small = 1, /obj/item/ingot/iron = 1)
	tools = list(/obj/item/rogueweapon/hammer)
	req_table = TRUE
	result = list(/obj/item/rogueweapon/mace/cudgel/carpenter, /obj/item/rogueweapon/mace/cudgel/carpenter)
	craftdiff = 3

/datum/crafting_recipe/roguetown/wickercloak
	name = "wickercloak"
	result = /obj/item/clothing/cloak/wickercloak
	reqs = list(/obj/item/natural/dirtclod = 1,
				/obj/item/grown/log/tree/stick = 5,
				/obj/item/natural/fibers = 3)
	craftdiff = 0

/datum/crafting_recipe/roguetown/earnecklace
	name = "ear necklace"
	result = /obj/item/clothing/neck/roguetown/menears
	reqs = list(/obj/item/organ/ears = 4,
				/obj/item/rope = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/elfearnecklace
	name = "elf ear necklace"
	result = /obj/item/clothing/neck/roguetown/elfears
	reqs = list(/obj/item/organ/ears = 4,
				/obj/item/rope = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/bogcowl
	name = "bogcowl"
	result = /obj/item/clothing/neck/roguetown/bogcowl
	reqs = list(/obj/item/natural/dirtclod = 1,
				/obj/item/grown/log/tree/stick = 3,
				/obj/item/natural/fibers = 2)
	craftdiff = 0

/datum/crafting_recipe/roguetown/skullmask
	name = "skull mask"
	result = /obj/item/clothing/mask/rogue/skullmask
	reqs = list(/obj/item/alch/bone = 3,
				/obj/item/natural/fibers = 1)
	sellprice = 10
	verbage = "crafted"
	craftdiff = 0

/datum/crafting_recipe/roguetown/antlerhood
	name = "antlerhood"
	result = /obj/item/clothing/head/roguetown/antlerhood
	reqs = list(/obj/item/natural/hide = 1,
				/obj/item/alch/bone = 2)
	sellprice = 12
	tools = list(/obj/item/needle)
	skillcraft = /datum/skill/misc/sewing
	verbage = "sews"
	craftdiff = 0
/datum/crafting_recipe/roguetown/bonespear
	name = "bone spear"
	result = /obj/item/rogueweapon/polearm/spear/bonespear
	reqs = list(/obj/item/rogueweapon/polearm/woodstaff = 1,
				/obj/item/alch/bone = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
/datum/crafting_recipe/roguetown/boneaxe
	name = "bone axe"
	result = /obj/item/rogueweapon/axe/boneaxe
	reqs = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/alch/bone = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/parchment_scroll
	name = "parchment scroll"
	result = /obj/item/paper/scroll
	reqs = list(/obj/item/paper = 3)

// Woodcutting recipe
/datum/crafting_recipe/roguetown/lumberjacking
	skillcraft = /datum/skill/labor/lumberjacking
	tools = list(/obj/item/rogueweapon/knife/hunting = 1)

/datum/crafting_recipe/roguetown/lumberjacking/cart_upgrade
	name = "upgrade cog"
	result = /obj/item/cart_upgrade/level_1
	reqs = list(/obj/item/grown/log/tree/small = 2,
				/obj/item/natural/stone = 1)
	craftdiff = 2

/datum/crafting_recipe/roguetown/lumberjacking/cart_upgrade2
	name = "advanced upgrade cog"
	result = /obj/item/cart_upgrade/level_2
	reqs = list(/obj/item/grown/log/tree/small = 4,
				/obj/item/cart_upgrade/level_1 = 1,
				/obj/item/ingot/iron = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/wood_hammer
	name = "wooden mallet"
	result = /obj/item/rogueweapon/hammer/wood
	reqs = list(/obj/item/grown/log/tree/small = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/confessional
	name = "confession"
	result = /obj/item/paper/confession
	reqs = list(/obj/item/paper = 1)
	tools = list(/obj/item/natural/feather)
	skillcraft = /datum/skill/misc/reading
	always_availible = FALSE
	craftsound = null
	craftdiff = 0

/datum/crafting_recipe/roguetown/wpsycross
	name = "handheld psycross"
	reqs = list(/obj/item/grown/log/tree/small = 1)
	result = /obj/item/clothing/neck/roguetown/psycross
	craftdiff = 0

/datum/crafting_recipe/roguetown/impsaw
	name = "improvised saw"
	result = /obj/item/rogueweapon/surgery/saw/improv
	reqs = list(/obj/item/natural/fibers = 1, /obj/item/natural/stone = 1, /obj/item/grown/log/tree/stick = 1)
	craftdiff = 1
	skillcraft = /datum/skill/craft/crafting

/datum/crafting_recipe/roguetown/impretra
	name = "improvised clamp"
	result = /obj/item/rogueweapon/surgery/hemostat/improv
	reqs = list(/obj/item/natural/fibers = 1, /obj/item/grown/log/tree/stick = 2)
	craftdiff = 1
	skillcraft = /datum/skill/craft/crafting

/datum/crafting_recipe/roguetown/imphemo
	name = "improvised retractor"
	result = /obj/item/rogueweapon/surgery/retractor/improv
	reqs = list(/obj/item/natural/fibers = 1, /obj/item/grown/log/tree/stick = 2)
	craftdiff = 1
	skillcraft = /datum/skill/craft/crafting
