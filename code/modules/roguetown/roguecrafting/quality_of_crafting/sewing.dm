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


/datum/repeatable_crafting_recipe/sewing/tribalrags
	name = "tribal rags"
	output = /obj/item/clothing/suit/roguetown/shirt/tribalrag
	attacking_atom = /obj/item/natural/hide
	requirements = list(/obj/item/natural/hide = 1,
				/obj/item/natural/fibers = 1)
	sellprice = 6
	craftdiff = 0

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

/datum/repeatable_crafting_recipe/sewing/tunic
	name = "tunic"
	output = /obj/item/clothing/suit/roguetown/shirt/tunic
	requirements = list(/obj/item/natural/cloth = 2)

/datum/repeatable_crafting_recipe/sewing/lowcut_shirt
	name = "low cut tunic"
	requirements = list(
		/obj/item/natural/cloth = 2,
		/obj/item/natural/fibers = 1,
	)
	output = /obj/item/clothing/suit/roguetown/shirt/undershirt/lowcut

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

/datum/repeatable_crafting_recipe/sewing/stripedtunic
	name = "striped tunic"
	output = /obj/item/clothing/suit/roguetown/armor/gambeson/light/striped
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 1

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
	name = "roll of sleepcloth"
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

/datum/repeatable_crafting_recipe/sewing/tabard
	name = "tabard (crusader)"
	output = /obj/item/clothing/cloak/tabard/crusader
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

/datum/repeatable_crafting_recipe/sewing/undervestments
	name = "undervestments"
	requirements = list(
		/obj/item/natural/cloth = 3,
		/obj/item/natural/fibers = 1,
	)
	output = /obj/item/clothing/suit/roguetown/shirt/undershirt/priest
	craftdiff = 2

/datum/repeatable_crafting_recipe/sewing/wrappings
	name = "solar wrappings"
	requirements = list(
		/obj/item/natural/cloth = 2
	)
	output = /obj/item/clothing/wrists/roguetown/wrappings
	craftdiff = 2

/datum/repeatable_crafting_recipe/sewing/nocwrappings
	name = "moon wrappings"
	requirements = list(
		/obj/item/natural/cloth = 2
	)
	output = /obj/item/clothing/wrists/roguetown/nocwrappings
	craftdiff = 2

/datum/repeatable_crafting_recipe/sewing/Bluskirt
	name = "blue skirt"
	output = /obj/item/clothing/under/roguetown/skirt/blue
	requirements = list(/obj/item/natural/cloth = 2,
			/obj/item/natural/fibers = 1)
	craftdiff = 2

/datum/repeatable_crafting_recipe/sewing/Greskirt
	name = "green skirt"
	output = /obj/item/clothing/under/roguetown/skirt/green
	requirements = list(/obj/item/natural/cloth = 2,
			/obj/item/natural/fibers = 1)
	craftdiff = 2
/*.............. recipes requiring skill 3 ..............*/

/datum/repeatable_crafting_recipe/sewing/armingjacket
	name = "arming jacket"
	output = /obj/item/clothing/suit/roguetown/armor/gambeson/arming
	requirements = list(/obj/item/natural/cloth = 4,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/wizhat
	name = "wizard hat"
	output = /obj/item/clothing/head/roguetown/wizhat
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/wizardrobes
	name = "wizard hat"
	output = /obj/item/clothing/suit/roguetown/shirt/robe/wizard
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

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

/datum/repeatable_crafting_recipe/sewing/desertcape
	name = "desert cape"
	output = /obj/item/clothing/cloak/cape/crusader
	requirements = list(/obj/item/natural/cloth = 4,
				/obj/item/natural/fibers = 2)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/halfcloak
	name = "half cloak"
	requirements = list(
		/obj/item/natural/cloth = 3,
		/obj/item/natural/fibers = 1,
	)
	output = /obj/item/clothing/cloak/half
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/templar
	name = "templar surcoat"
	output = /obj/item/clothing/cloak/stabard/templar
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/astratatemplar
	name = "solar surcoat"
	output = /obj/item/clothing/cloak/stabard/templar/astrata
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/necratemplar
	name = "necran surcoat"
	output = /obj/item/clothing/cloak/stabard/templar/necra
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/dendortemplar
	name = "dendorian surcoat"
	output = /obj/item/clothing/cloak/stabard/templar/dendor
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/noctemplar
	name = "lunar surcoat"
	output = /obj/item/clothing/cloak/stabard/templar/noc
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/abyssortemplar
	name = "abyssal surcoat"
	output = /obj/item/clothing/cloak/stabard/templar/abyssor
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/malumtemplar
	name = "malumite surcoat"
	output = /obj/item/clothing/cloak/stabard/templar/malum
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/eoratemplar
	name = "eoran surcoat"
	output = /obj/item/clothing/cloak/stabard/templar/eora
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/pestratemplar
	name = "pestran surcoat"
	output = /obj/item/clothing/cloak/stabard/templar/pestra
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/dress
	name = "bar dress"
	output = /obj/item/clothing/suit/roguetown/shirt/dress
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/stockdress
	name = "stock dress"
	output = /obj/item/clothing/suit/roguetown/shirt/dress/gen
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/Bladress
	name = "black dress"
	output = /obj/item/clothing/suit/roguetown/shirt/dress/gen/black
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/Bludress
	name = "blue dress"
	output = /obj/item/clothing/suit/roguetown/shirt/dress/gen/blue
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/Purdress
	name = "purple dress"
	output = /obj/item/clothing/suit/roguetown/shirt/dress/gen/purple
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/* .............. recipes requiring skill 4 ..............*/

/datum/repeatable_crafting_recipe/sewing/fancyhat
	name = "fancy hat"
	output = /obj/item/clothing/head/roguetown/fancyhat
	requirements = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1,
				/obj/item/natural/feather = 1)
	craftdiff = 4

/datum/repeatable_crafting_recipe/sewing/courtierhat
	name = "courtier hat"
	output = /obj/item/clothing/head/roguetown/courtierhat
	requirements = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1,
				/obj/item/natural/feather = 1)
	craftdiff = 4

/datum/repeatable_crafting_recipe/sewing/bardhat
	name = "bard hat"
	output = /obj/item/clothing/head/roguetown/bardhat
	requirements = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1,
				/obj/item/natural/feather = 1)
	craftdiff = 4

/datum/repeatable_crafting_recipe/sewing/chaperonhat
	name = "chaperon hat"
	output = /obj/item/clothing/head/roguetown/chaperon/greyscale
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/datum/repeatable_crafting_recipe/sewing/jupon
	name = "jupon"
	output = /obj/item/clothing/cloak/stabard/surcoat
	requirements = list(/obj/item/natural/cloth = 4,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/*.............. recipes requiring skill 5 ..............*/

/datum/repeatable_crafting_recipe/sewing/lordcloak
	name = "lordly cloak"
	output = /obj/item/clothing/cloak/lordcloak
	attacking_atom = /obj/item/natural/hide/cured
	requirements = list(/obj/item/natural/fur = 2,
				/obj/item/natural/hide/cured = 4)
	craftdiff = 5

/*.............. recipes requiring skill 6 ..............*/

/datum/repeatable_crafting_recipe/sewing/sexydress
	name = "sexy dress of legendary sewists"
	output = /obj/item/clothing/suit/roguetown/shirt/dress/gen/sexy
	requirements = list(/obj/item/natural/cloth = 6,
				/obj/item/natural/fibers = 3)
	craftdiff = 6

/// SILKS

/datum/repeatable_crafting_recipe/sewing/weaving
	abstract_type = /datum/repeatable_crafting_recipe/sewing/weaving
	attacking_atom = /obj/machinery/loom
	starting_atom = /obj/item/natural/silk
	requirements = list(
		/obj/item/natural/silk = 1
	)
	tool_usage = list()
	craftdiff = 1

/* craftdif of 1 = NOVICE */

/datum/repeatable_crafting_recipe/sewing/weaving/shepardmask
	name = "half-mask"
	output = /obj/item/clothing/mask/rogue/shepherd
	requirements = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/silk = 1)
	craftdiff = 1

/datum/repeatable_crafting_recipe/sewing/weaving/rags
	name = "shirt (webbed)"
	output = /obj/item/clothing/suit/roguetown/shirt/undershirt/webs
	requirements = list(/obj/item/natural/silk = 1)
	craftdiff = 1

/datum/repeatable_crafting_recipe/sewing/weaving/webbing
	name = "trousers (webbed)"
	output = /obj/item/clothing/under/roguetown/webs
	requirements = list(/obj/item/natural/silk = 2)
	craftdiff = 1

/* craftdif of 2 = APPRENTICE */

/datum/repeatable_crafting_recipe/sewing/weaving/shadowgloves
	name = "gloves"
	output = /obj/item/clothing/gloves/roguetown/fingerless/shadowgloves
	requirements = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/silk = 1)
	craftdiff = 2

/* craftdif of 3 = JOURNEYMAN */

/datum/repeatable_crafting_recipe/sewing/weaving/cloak
	name = "cloak (half, silk)"
	output = /obj/item/clothing/cloak/half
	requirements = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/silk = 1)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/weaving/nochood
	name = "hood (moon/Noc)"
	output = /obj/item/clothing/head/roguetown/roguehood/nochood
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 1)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/weaving/necrahood
	name = "hood (Necra)"
	output = /obj/item/clothing/head/roguetown/padded/deathshroud
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 1)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/weaving/eoramask
	name = "mask (Eora)"
	output = /obj/item/clothing/head/roguetown/padded/operavisage
	requirements = list(/obj/item/ingot/silver = 1,
				/obj/item/natural/silk = 4)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/weaving/astratahood
	name = "hood (solar/Astrata)"
	output = /obj/item/clothing/head/roguetown/roguehood/astrata
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 1)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/weaving/shirt
	name = "shirt (formal silks)"
	output = /obj/item/clothing/suit/roguetown/shirt/undershirt/puritan
	requirements = list(/obj/item/natural/silk = 5)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/weaving/noblecoat
	name = "coat (fancy)"
	output = /obj/item/clothing/suit/roguetown/shirt/tunic/noblecoat
	requirements = list(/obj/item/natural/cloth = 3,
			/obj/item/natural/silk = 1)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/weaving/nunhood
	name = "hood (nun)"
	output = /obj/item/clothing/head/roguetown/nun
	requirements = list(/obj/item/natural/silk = 2)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/weaving/nunrobe
	name = "robes (nun)"
	output = /obj/item/clothing/suit/roguetown/shirt/robe/nun
	requirements = list(/obj/item/natural/silk = 3)
	craftdiff = 3

/* craftdif of 4 = EXPERT */

/datum/repeatable_crafting_recipe/sewing/weaving/shadowcloak
	name = "stalker cloak"
	output = /obj/item/clothing/cloak/half/shadowcloak
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 3)
	craftdiff = 4

/datum/repeatable_crafting_recipe/sewing/weaving/shadowshirt
	name = "shirt (dark)"
	output = /obj/item/clothing/suit/roguetown/shirt/shadowshirt
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 3)
	craftdiff = 4

/datum/repeatable_crafting_recipe/sewing/weaving/silkchaperone
	name = "hat (chaperone)"
	output = /obj/item/clothing/head/roguetown/chaperon/greyscale/silk
	requirements = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/silk = 2)
	craftdiff = 4

/datum/repeatable_crafting_recipe/sewing/weaving/shadowpants
	name = "pants (dark)"
	output = /obj/item/clothing/under/roguetown/trou/shadowpants
	requirements = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/silk = 3)
	craftdiff = 4

/datum/repeatable_crafting_recipe/sewing/weaving/astratarobe
	name = "robes (Astrata)"
	output = /obj/item/clothing/suit/roguetown/shirt/robe/astrata
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/silk = 1)
	craftdiff = 4

/datum/repeatable_crafting_recipe/sewing/weaving/eorarobe
	name = "robes (Eora)"
	output = /obj/item/clothing/suit/roguetown/shirt/robe/eora
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/silk = 1)
	craftdiff = 4

/datum/repeatable_crafting_recipe/sewing/weaving/dendorrobe
	name = "robes (Dendor)"
	output = /obj/item/clothing/suit/roguetown/shirt/robe/dendor
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/silk = 1)
	craftdiff = 4

/datum/repeatable_crafting_recipe/sewing/weaving/necrarobe
	name = "robes (Necra)"
	output = /obj/item/clothing/suit/roguetown/shirt/robe/necra
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/silk = 1)
	craftdiff = 4

/datum/repeatable_crafting_recipe/sewing/weaving/nocrobe
	name = "robes (Noc)"
	output = /obj/item/clothing/suit/roguetown/shirt/robe/noc
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/silk = 1)
	craftdiff = 4

/datum/repeatable_crafting_recipe/sewing/weaving/paddedgambeson
	name = "padded gambeson"
	output = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
	requirements = list(/obj/item/natural/cloth = 6,
				/obj/item/natural/fibers = 4)
	starting_atom = /obj/item/natural/cloth
	craftdiff = 4

/datum/repeatable_crafting_recipe/sewing/weaving/armordress
	name = "padded dress"
	output = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/dress
	requirements = list(/obj/item/natural/fibers = 2,
				/obj/item/natural/silk = 4,
				/obj/item/natural/hide/cured = 1)
	craftdiff = 4
	sellprice = 80

/* craftdif of 5 = MASTER */

/datum/repeatable_crafting_recipe/sewing/weaving/silkcoat
	name = "coat (silk)"
	output = /obj/item/clothing/suit/roguetown/armor/leather/jacket/silk_coat
	requirements = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/silk = 3,
				/obj/item/natural/fur = 2)
	craftdiff = 5
	sellprice = 60

/datum/repeatable_crafting_recipe/sewing/weaving/eorastraps
	name = "straps (eora)"
	output = /obj/item/clothing/suit/roguetown/shirt/robe/eora/alt
	requirements = list(/obj/item/ingot/gold = 1,
				/obj/item/natural/silk = 5,
				)
	craftdiff = 5
	sellprice = 50


/datum/repeatable_crafting_recipe/sewing/weaving/barkeep
	name = "dress (bar, silk)"
	output = /obj/item/clothing/suit/roguetown/shirt/dress
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 2)
	craftdiff = 5

/datum/repeatable_crafting_recipe/sewing/weaving/silkdress
	name = "dress (chemise, silk)"
	output = /obj/item/clothing/suit/roguetown/shirt/dress/silkdress/random
	requirements = list(/obj/item/natural/fibers = 2,
				/obj/item/natural/silk = 3)
	craftdiff = 5

/* craftdif of 6 = LEGENDARY */
// IDK how to balance these
/datum/repeatable_crafting_recipe/sewing/weaving/springgown
	name = "gown (spring)"
	output = /obj/item/clothing/suit/roguetown/shirt/dress/gown
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/silk = 4)
	craftdiff = 6
	sellprice = 85

/datum/repeatable_crafting_recipe/sewing/weaving/summergown
	name = "gown (summer)"
	output = /obj/item/clothing/suit/roguetown/shirt/dress/gown/summergown
	requirements = list(/obj/item/natural/fibers = 2,
				/obj/item/natural/cloth = 1, 
				/obj/item/natural/silk = 3)
	craftdiff = 6
	sellprice = 70

/datum/repeatable_crafting_recipe/sewing/weaving/fallgown
	name = "gown (fall, silk)"
	output = /obj/item/clothing/suit/roguetown/shirt/dress/gown/fallgown
	requirements = list(/obj/item/natural/fibers = 3,
				/obj/item/natural/silk = 2,
				/obj/item/natural/cloth = 2)
	craftdiff = 6
	sellprice = 75

/datum/repeatable_crafting_recipe/sewing/weaving/wintergown
	name = "gown (winter)"
	output = /obj/item/clothing/suit/roguetown/shirt/dress/gown/wintergown
	requirements = list(/obj/item/natural/fibers = 3,
				/obj/item/natural/silk = 2,
				/obj/item/natural/fur/cabbit = 1)
	craftdiff = 6
	sellprice = 90
