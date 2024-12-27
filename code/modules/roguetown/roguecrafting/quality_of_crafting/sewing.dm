/datum/repeatable_crafting_recipe/sewing
	abstract_type = /datum/repeatable_crafting_recipe/sewing
	requirements = list(
		/obj/item/natural/cloth = 1
	)
	tool_usage = list(
		/obj/item/needle = list("starts to sew", "start to sew")
	)

	starting_atom = /obj/item/needle
	attacking_atom = /obj/item/natural/cloth
	skillcraft = /datum/skill/misc/sewing
	craftdiff = 0
	subtypes_allowed = TRUE // so you can use any subtype of fur

/datum/repeatable_crafting_recipe/sewing/rags
	name = "rags"
	requirements = list(
		/obj/item/natural/cloth = 2,
	)
	output = /obj/item/clothing/suit/roguetown/shirt/rags

/datum/repeatable_crafting_recipe/sewing/winding_sheet
	name = "winding sheet"
	requirements = list(
		/obj/item/natural/cloth = 2,
	)
	output = /obj/item/burial_shroud
	craftdiff = 1

/datum/repeatable_crafting_recipe/sewing/loincloth
	name = "loincloth"
	requirements = list(
		/obj/item/natural/cloth = 1,
	)
	output = /obj/item/clothing/under/roguetown/loincloth

/datum/repeatable_crafting_recipe/sewing/halfcloak
	name = "cloth half cloak"
	requirements = list(
		/obj/item/natural/cloth = 1,
		/obj/item/natural/fibers = 1,
	)
	output = /obj/item/clothing/cloak/half

/datum/repeatable_crafting_recipe/sewing/apron
	name = "cloth apron"
	requirements = list(
		/obj/item/natural/cloth = 1,
		/obj/item/natural/fibers = 1,
	)
	output = /obj/item/clothing/cloak/apron

/datum/repeatable_crafting_recipe/sewing/clothgloves
	name = "cloth gloves"
	requirements = list(
		/obj/item/natural/cloth = 1,
		/obj/item/natural/fibers = 1,
	)
	output = /obj/item/clothing/gloves/roguetown/fingerless

/datum/repeatable_crafting_recipe/sewing/shortshirt
	name = "cloth short shirt"
	requirements = list(
		/obj/item/natural/cloth = 1,
		/obj/item/natural/fibers = 1,
	)
	output = /obj/item/clothing/suit/roguetown/shirt/shortshirt/uncolored

/datum/repeatable_crafting_recipe/sewing/clothshirt
	name = "cloth shirt"
	requirements = list(
		/obj/item/natural/cloth = 2,
		/obj/item/natural/fibers = 1,
	)
	output = /obj/item/clothing/suit/roguetown/shirt/undershirt/uncolored


/datum/repeatable_crafting_recipe/sewing/stripedtunic
	name = "striped tunic"
	output = /obj/item/clothing/suit/roguetown/armor/gambeson/light/striped
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)

/datum/repeatable_crafting_recipe/sewing/clothtights
	name = "cloth tights"
	output = /obj/item/clothing/under/roguetown/tights/uncolored
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)

/datum/repeatable_crafting_recipe/sewing/headband
	name = "headband"
	output = /obj/item/clothing/head/roguetown/headband
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)

/datum/repeatable_crafting_recipe/sewing/strawhat
	name = "crude straw hat"
	output = /obj/item/clothing/head/roguetown/strawhat
	requirements = list(/obj/item/natural/fibers = 3)

/datum/repeatable_crafting_recipe/sewing/knitcap
	name = "knit cap"
	output = /obj/item/clothing/head/roguetown/knitcap
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)

/datum/repeatable_crafting_recipe/sewing/cmask
	name = "cloth mask"
	output = /obj/item/clothing/mask/rogue/shepherd/clothmask
	requirements = list(/obj/item/natural/fibers = 1, /obj/item/natural/cloth = 1)

/datum/repeatable_crafting_recipe/sewing/linedanklet
	name = "cloth anklet"
	output = /obj/item/clothing/shoes/roguetown/boots/clothlinedanklets
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 2)

/datum/repeatable_crafting_recipe/sewing/zigbox
	name = "zigbox"
	output = /obj/item/storage/fancy/cigarettes/zig/empty
	requirements = list(/obj/item/paper = 1,
				/obj/item/natural/fibers = 1)


/*.............. recipes requiring skill 1 ..............*/

/datum/repeatable_crafting_recipe/sewing/Reyepatch
	name = "right eye patch"
	output = /obj/item/clothing/mask/rogue/eyepatch
	requirements = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 1

/datum/repeatable_crafting_recipe/sewing/Leyepatch
	name = "left eye patch"
	output = /obj/item/clothing/mask/rogue/eyepatch/left
	requirements = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 1

/datum/repeatable_crafting_recipe/sewing/fisherhat
	name = "straw fisher hat"
	output = /obj/item/clothing/head/roguetown/fisherhat
	requirements = list(/obj/item/natural/fibers = 3)
	craftdiff = 1

/datum/repeatable_crafting_recipe/sewing/sack
	name = "sack hood"
	output = /obj/item/clothing/head/roguetown/menacing
	requirements = list(/obj/item/natural/cloth = 3)
	craftdiff = 1

/datum/repeatable_crafting_recipe/sewing/pcoif
	name = "cloth coif"
	output = /obj/item/clothing/neck/roguetown/coif/cloth
	requirements = list(/obj/item/natural/fibers = 1, /obj/item/natural/cloth = 2)
	craftdiff = 1

/datum/repeatable_crafting_recipe/sewing/jupon
	name = "jupon"
	output = /obj/item/clothing/cloak/stabard/surcoat
	requirements = list(/obj/item/natural/cloth = 4,
				/obj/item/natural/fibers = 1)
	craftdiff = 1

/datum/repeatable_crafting_recipe/sewing/clothtrou
	name = "cloth trousers"
	output = /obj/item/clothing/under/roguetown/trou
	requirements = list(/obj/item/natural/cloth = 4,
				/obj/item/natural/fibers = 1)
	craftdiff = 1

/datum/repeatable_crafting_recipe/sewing/lgambeson
	name = "light gambeson"
	output = /obj/item/clothing/suit/roguetown/armor/gambeson/light
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 1

/datum/repeatable_crafting_recipe/sewing/sleepingbag
	name = "sleepcloth"
	output = /obj/item/sleepingbag
	requirements =  list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 1

/datum/repeatable_crafting_recipe/sewing/armingcap
	name = "arming cap"
	output = /obj/item/clothing/head/roguetown/armingcap
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 1


/datum/repeatable_crafting_recipe/sewing/gambeson
	name = "gambeson"
	output = /obj/item/clothing/suit/roguetown/armor/gambeson
	requirements = list(/obj/item/natural/cloth = 4,
				/obj/item/natural/fibers = 1)
	craftdiff = 2

/datum/repeatable_crafting_recipe/sewing/tabard
	name = "tabard"
	output = /obj/item/clothing/cloak/tabard
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 2

/datum/repeatable_crafting_recipe/sewing/stabard
	name = "surcoat"
	output = /obj/item/clothing/cloak/stabard
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 2

/datum/repeatable_crafting_recipe/sewing/bedsheet
	name = "bedsheet"
	output = /obj/item/bedsheet/rogue/cloth
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 2

/datum/repeatable_crafting_recipe/sewing/bedsheetpelt
	name = "leather bedsheet"
	output = /obj/item/bedsheet/rogue/pelt
	attacking_atom = /obj/item/natural/hide/cured
	requirements = list(/obj/item/natural/hide/cured = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 2

/datum/repeatable_crafting_recipe/sewing/Bladress
	name = "black dress"
	output = /obj/item/clothing/suit/roguetown/shirt/dress/gen/black
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 2

/datum/repeatable_crafting_recipe/sewing/Bludress
	name = "blue dress"
	output = /obj/item/clothing/suit/roguetown/shirt/dress/gen/blue
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 2

/datum/repeatable_crafting_recipe/sewing/Purdress
	name = "purple dress"
	output = /obj/item/clothing/suit/roguetown/shirt/dress/gen/purple
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 2


/*.............. recipes requiring skill 3 ..............*/

/datum/repeatable_crafting_recipe/sewing/robe
	name = "robes"
	output = /obj/item/clothing/suit/roguetown/shirt/robe/plain
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/cape
	name = "cape"
	output = /obj/item/clothing/cloak/cape
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/sewing/jester
	name = "jester jacket"
	output = /obj/item/clothing/suit/roguetown/shirt/jester
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/* .............. recipes requiring skill 4 ..............*/

/datum/repeatable_crafting_recipe/sewing/fancyhat
	name = "fancy hat"
	output = /obj/item/clothing/head/roguetown/fancyhat
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/datum/repeatable_crafting_recipe/sewing/fancyhat
	name = "fancy hat"
	output = /obj/item/clothing/head/roguetown/fancyhat
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/datum/repeatable_crafting_recipe/sewing/bardhat
	name = "bard hat"
	output = /obj/item/clothing/head/roguetown/bardhat
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/sewing/merchant_jacket
	name = "merchant jacket"
	output = /obj/item/clothing/suit/roguetown/shirt/robe/merchant
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/sewing/feldsher
	name = "feldsher jacket"
	output = list(/obj/item/clothing/suit/roguetown/shirt/robe/feld)
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 4


/*.............. recipes requiring skill 5 ..............*/

/datum/repeatable_crafting_recipe/sewing/lordcloak
	name = "lordly cloak"
	output = /obj/item/clothing/cloak/lordcloak
	attacking_atom = /obj/item/natural/hide/cured
	requirements = list(/obj/item/natural/fur = 2,
				/obj/item/natural/hide/cured = 4)
	craftdiff = 4

/datum/repeatable_crafting_recipe/sewing/tribalrags
	name = "tribal rags"
	output = /obj/item/clothing/suit/roguetown/shirt/tribalrag
	attacking_atom = /obj/item/natural/hide
	requirements = list(/obj/item/natural/hide = 1,
				/obj/item/natural/fibers = 1)
	sellprice = 6
	craftdiff = 0

/// SILKS

/* craftdif of 1 = NOVICE */

/datum/repeatable_crafting_recipe/sewing/shepardmask
	name = "half-mask (cloth, silk; LOOM, NOVICE)"
	output = /obj/item/clothing/mask/rogue/shepherd
	requirements = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/silk = 1)
	craftdiff = 1

/datum/repeatable_crafting_recipe/sewing/rags
	name = "shirt (webbed) - (silk; LOOM, NOVICE)"
	output = /obj/item/clothing/suit/roguetown/shirt/undershirt/webs
	requirements = list(/obj/item/natural/silk = 1)
	craftdiff = 1

/datum/repeatable_crafting_recipe/sewing/webbing
	name = "trousers (webbed) - (2 silks; LOOM, NOVICE)"
	output = /obj/item/clothing/under/roguetown/webs
	requirements = list(/obj/item/natural/silk = 2)
	craftdiff = 1

/* craftdif of 2 = APPRENTICE */

/* craftdif of 3 = JOURNEYMAN */

/datum/repeatable_crafting_recipe/sewing/cloak
	name = "cloak (half, silk) - (cloth, silk; LOOM, JOURNEYMAN)"
	output = /obj/item/clothing/cloak/half
	requirements = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/silk = 1)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/nochood
	name = "hood (moon/Noc) - (2 cloths, silk; LOOM, JOURNEYMAN)"
	output = /obj/item/clothing/head/roguetown/roguehood/nochood
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 1)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/necrahood
	name = "hood (Necra) - (2 cloths, silk; LOOM, JOURNEYMAN)"
	output = /obj/item/clothing/head/roguetown/padded/deathshroud
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 1)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/astratahood
	name = "hood (solar/Astrata) - (2 cloths, silk; LOOM, JOURNEYMAN)"
	output = /obj/item/clothing/head/roguetown/roguehood/astrata
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 1)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/shirt
	name = "shirt (formal silks) - (5 silks; LOOM, JOURNEYMAN)"
	output = /obj/item/clothing/suit/roguetown/shirt/undershirt/puritan
	requirements = list(/obj/item/natural/silk = 5)
	craftdiff = 3


/datum/crafting_recipe/roguetown/sewing/silk_coat
	name = "silk coat - (2 cloth, 2 silk , 1 hide; LOOM, EXPERT)"
	output = /obj/item/clothing/suit/roguetown/armor/leather/jacket/silk_coat
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 2,
				/obj/item/natural/hide = 1)
	craftdiff = 3

/* craftdif of 4 = EXPERT */

/datum/repeatable_crafting_recipe/sewing/astratarobe
	name = "robes (Astrata) - (3 cloths, silk; LOOM, EXPERT)"
	output = /obj/item/clothing/suit/roguetown/shirt/robe/astrata
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/silk = 1)
	craftdiff = 4

/datum/repeatable_crafting_recipe/sewing/dendorrobe
	name = "robes (Dendor) - (3 cloths, silk; LOOM, EXPERT)"
	output = /obj/item/clothing/suit/roguetown/shirt/robe/dendor
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/silk = 1)
	craftdiff = 4

/datum/repeatable_crafting_recipe/sewing/necrarobe
	name = "robes (Necra) - (3 cloths, silk; LOOM, EXPERT)"
	output = /obj/item/clothing/suit/roguetown/shirt/robe/necra
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/silk = 1)
	craftdiff = 4

/datum/repeatable_crafting_recipe/sewing/nocrobe
	name = "robes (Noc) - (3 cloths, silk; LOOM, EXPERT)"
	output = /obj/item/clothing/suit/roguetown/shirt/robe/noc
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/silk = 1)
	craftdiff = 4

/datum/crafting_recipe/roguetown/sewing/archivist
	name = "archivist robe (3 cloths, 2 silk, 1 fiber; LOOM, EXPERT)"
	output = /obj/item/clothing/suit/roguetown/shirt/robe/archivist
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1,
				/obj/item/natural/silk = 2)
	craftdiff = 4

/* craftdif of 5 = MASTER */

/datum/repeatable_crafting_recipe/sewing/silkcoat
	name = "coat (silk) - (cloth, 2 furs, 3 silks; LOOM, MASTER)"
	output = /obj/item/clothing/suit/roguetown/armor/leather/jacket/silk_coat
	requirements = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/silk = 3,
				/obj/item/natural/fur = 2)
	craftdiff = 5
	sellprice = 60

/datum/repeatable_crafting_recipe/sewing/barkeep
	name = "dress (bar, silk) - (2 cloths, 2 silks; LOOM, MASTER)"
	output = /obj/item/clothing/suit/roguetown/shirt/dress
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 2)
	craftdiff = 5

/datum/repeatable_crafting_recipe/sewing/silkdress
	name = "dress (chemise, silk) - (2 fibers, 3 silks; LOOM, MASTER)"
	output = /obj/item/clothing/suit/roguetown/shirt/dress/silkdress/random
	requirements = list(/obj/item/natural/fibers = 2,
				/obj/item/natural/silk = 3)
	craftdiff = 5
