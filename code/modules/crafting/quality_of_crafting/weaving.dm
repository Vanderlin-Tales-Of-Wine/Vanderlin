
/// SILKS

/datum/repeatable_crafting_recipe/sewing/weaving
	abstract_type = /datum/repeatable_crafting_recipe/sewing/weaving
	attacked_atom = /obj/machinery/loom
	requirements = list(
		/obj/item/natural/silk = 1
	)
	craftdiff = 1

/* craftdif of 1 = NOVICE */

/datum/repeatable_crafting_recipe/sewing/weaving/shepardmask
	name = "half-mask"
	output = /obj/item/clothing/face/shepherd
	requirements = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/silk = 1)
	craftdiff = 1

/datum/repeatable_crafting_recipe/sewing/weaving/rags
	name = "shirt (webbed)"
	output = /obj/item/clothing/shirt/undershirt/webs
	requirements = list(/obj/item/natural/silk = 1)
	craftdiff = 1

/datum/repeatable_crafting_recipe/sewing/weaving/webbing
	name = "trousers (webbed)"
	output = /obj/item/clothing/pants/webs
	requirements = list(/obj/item/natural/silk = 2)
	craftdiff = 1

/* craftdif of 2 = APPRENTICE */

/datum/repeatable_crafting_recipe/sewing/weaving/shadowgloves
	name = "gloves"
	output = /obj/item/clothing/gloves/fingerless/shadowgloves
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
	output = /obj/item/clothing/head/roguehood/nochood
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 1)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/weaving/necrahood
	name = "hood (Necra)"
	output = /obj/item/clothing/head/padded/deathshroud
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 1)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/weaving/eoramask
	name = "mask (Eora)"
	output = /obj/item/clothing/head/padded/operavisage
	requirements = list(/obj/item/ingot/silver = 1,
				/obj/item/natural/silk = 4)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/weaving/astratahood
	name = "hood (solar/Astrata)"
	output = /obj/item/clothing/head/roguehood/astrata
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 1)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/weaving/shirt
	name = "shirt (formal silks)"
	output = /obj/item/clothing/shirt/undershirt/puritan
	requirements = list(/obj/item/natural/silk = 5)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/weaving/noblecoat
	name = "coat (fancy)"
	output = /obj/item/clothing/shirt/tunic/noblecoat
	requirements = list(/obj/item/natural/cloth = 3,
			/obj/item/natural/silk = 1)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/weaving/nunhood
	name = "hood (nun)"
	output = /obj/item/clothing/head/nun
	requirements = list(/obj/item/natural/silk = 2)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/weaving/nunrobe
	name = "robes (nun)"
	output = /obj/item/clothing/shirt/robe/nun
	requirements = list(/obj/item/natural/silk = 3)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/weaving/puritancape

	name = "puritan cape"
	output = /obj/item/clothing/cloak/cape/puritan
	requirements = list(/obj/item/natural/silk = 4)
	craftdiff = 3
	sellprice = 35

/* craftdif of 4 = EXPERT */

/datum/repeatable_crafting_recipe/sewing/weaving/shadowcloak
	name = "stalker cloak"
	output = /obj/item/clothing/cloak/half/shadowcloak
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 3)
	craftdiff = 4

/datum/repeatable_crafting_recipe/sewing/weaving/shadowshirt
	name = "shirt (dark)"
	output = /obj/item/clothing/shirt/shadowshirt
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 3)
	craftdiff = 4

/datum/repeatable_crafting_recipe/sewing/weaving/silkchaperone
	name = "hat (chaperone)"
	output = /obj/item/clothing/head/chaperon/greyscale/silk
	requirements = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/silk = 2)
	craftdiff = 4

/datum/repeatable_crafting_recipe/sewing/weaving/shadowpants
	name = "pants (dark)"
	output = /obj/item/clothing/pants/trou/shadowpants
	requirements = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/silk = 3)
	craftdiff = 4

/datum/repeatable_crafting_recipe/sewing/weaving/astratarobe
	name = "robes (Astrata)"
	output = /obj/item/clothing/shirt/robe/astrata
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/silk = 1)
	craftdiff = 4

/datum/repeatable_crafting_recipe/sewing/weaving/eorarobe
	name = "robes (Eora)"
	output = /obj/item/clothing/shirt/robe/eora
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/silk = 1)
	craftdiff = 4

/datum/repeatable_crafting_recipe/sewing/weaving/dendorrobe
	name = "robes (Dendor)"
	output = /obj/item/clothing/shirt/robe/dendor
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/silk = 1)
	craftdiff = 4

/datum/repeatable_crafting_recipe/sewing/weaving/necrarobe
	name = "robes (Necra)"
	output = /obj/item/clothing/shirt/robe/necra
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/silk = 1)
	craftdiff = 4

/datum/repeatable_crafting_recipe/sewing/weaving/nocrobe
	name = "robes (Noc)"
	output = /obj/item/clothing/shirt/robe/noc
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/silk = 1)
	craftdiff = 4

/datum/repeatable_crafting_recipe/sewing/weaving/paddedgambeson
	name = "padded gambeson"
	output = /obj/item/clothing/armor/gambeson/heavy
	requirements = list(/obj/item/natural/cloth = 6,
				/obj/item/natural/fibers = 4)
	craftdiff = 4

/datum/repeatable_crafting_recipe/sewing/weaving/armordress
	name = "padded dress"
	output = /obj/item/clothing/armor/gambeson/heavy/dress
	requirements = list(/obj/item/natural/fibers = 2,
				/obj/item/natural/silk = 4,
				/obj/item/natural/hide/cured = 1)
	craftdiff = 4
	sellprice = 80

/* craftdif of 5 = MASTER */

/datum/repeatable_crafting_recipe/sewing/weaving/silkcoat
	name = "coat (silk)"
	output = /obj/item/clothing/armor/leather/jacket/silk_coat
	requirements = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/silk = 3,
				/obj/item/natural/fur = 2)
	craftdiff = 5
	sellprice = 60

/datum/repeatable_crafting_recipe/sewing/weaving/eorastraps
	name = "straps (eora)"
	output = /obj/item/clothing/shirt/robe/eora/alt
	requirements = list(/obj/item/ingot/gold = 1,
				/obj/item/natural/silk = 5,
				)
	craftdiff = 5
	sellprice = 50


/datum/repeatable_crafting_recipe/sewing/weaving/barkeep
	name = "dress (bar, silk)"
	output = /obj/item/clothing/shirt/dress
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 2)
	craftdiff = 5

/datum/repeatable_crafting_recipe/sewing/weaving/silkdress
	name = "dress (chemise, silk)"
	output = /obj/item/clothing/shirt/dress/silkdress/random
	requirements = list(/obj/item/natural/fibers = 2,
				/obj/item/natural/silk = 3)
	craftdiff = 5

/* craftdif of 6 = LEGENDARY */
// IDK how to balance these
/datum/repeatable_crafting_recipe/sewing/weaving/springgown
	name = "gown (spring)"
	output = /obj/item/clothing/shirt/dress/gown
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/silk = 4)
	craftdiff = 6
	sellprice = 85

/datum/repeatable_crafting_recipe/sewing/weaving/summergown
	name = "gown (summer)"
	output = /obj/item/clothing/shirt/dress/gown/summergown
	requirements = list(/obj/item/natural/fibers = 2,
				/obj/item/natural/cloth = 1,
				/obj/item/natural/silk = 3)
	craftdiff = 6
	sellprice = 70

/datum/repeatable_crafting_recipe/sewing/weaving/fallgown
	name = "gown (fall, silk)"
	output = /obj/item/clothing/shirt/dress/gown/fallgown
	requirements = list(/obj/item/natural/fibers = 3,
				/obj/item/natural/silk = 2,
				/obj/item/natural/cloth = 2)
	craftdiff = 6
	sellprice = 75

/datum/repeatable_crafting_recipe/sewing/weaving/wintergown
	name = "gown (winter)"
	output = /obj/item/clothing/shirt/dress/gown/wintergown
	requirements = list(/obj/item/natural/fibers = 3,
				/obj/item/natural/silk = 2,
				/obj/item/natural/fur/cabbit = 1)
	craftdiff = 6
	sellprice = 90
