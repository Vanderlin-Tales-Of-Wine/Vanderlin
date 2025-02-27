/obj/item/clothing/shoes/nobleboot
	name = "noble boots"
	//dropshrink = 0.75
	color = "#d5c2aa"
	desc = "Fine dark leather boots. Offers light protection against melee attacks."
	gender = PLURAL
	icon_state = "nobleboots"
	item_state = "nobleboots"
	armor = list("blunt" = 20, "slash" = 20, "stab" = 20,  "piercing" = 15, "fire" = 0, "acid" = 0)
	sellprice = 10

/obj/item/clothing/shoes/nobleboot/thighboots
	name = "thigh boots"
	icon_state = "thighboot"
	icon = 'icons/roguetown/clothing/special/hand.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/hand.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/hand.dmi'

/obj/item/clothing/shoes/shortboots
	name = "shortboots"
	color = "#d5c2aa"
	desc = "A shorter format of boots worn by about anyone."
	gender = PLURAL
	icon_state = "shortboots"
	item_state = "shortboots"
	armor = list("blunt" = 10, "slash" = 10, "stab" = 10,  "piercing" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/shoes/ridingboots
	name = "riding boots"
	color = "#d5c2aa"
	desc = "Boots designed for riding a mount."
	armor = list("blunt" = 20, "slash" = 20, "stab" = 20,  "piercing" = 10, "fire" = 0, "acid" = 0)
	gender = PLURAL
	icon_state = "ridingboots"
	item_state = "ridingboots"
	sellprice = 10

/obj/item/clothing/shoes/apothboots
	name = "apothecary boots"
	desc = "Boots designed for the toil of tincture gathering and mixing."
	gender = PLURAL
	icon_state = "apothboots"
	item_state = "apothboots"
	armor = list("blunt" = 15, "slash" = 15, "stab" = 15,  "piercing" = 5, "fire" = 0, "acid" = 0)
	sellprice = 10

/obj/item/clothing/shoes/simpleshoes
	name = "shoes"
	desc = "Simple shoes worn by about anyone."
	gender = PLURAL
	icon_state = "simpleshoe"
	item_state = "simpleshoe"
	resistance_flags = null
	color = CLOTHING_OLD_LEATHER
	salvage_amount = 1
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/shoes/simpleshoes/white
	color = null


/obj/item/clothing/shoes/simpleshoes/buckle
	name = "shoes"
	icon_state = "buckleshoes"
	color = null

/obj/item/clothing/shoes/simpleshoes/lord
	name = "shoes"
	desc = "Shoes typically worn by the King himself."
	gender = PLURAL
	icon_state = "simpleshoe"
	item_state = "simpleshoe"
	resistance_flags = null
	color = CLOTHING_ASH_GREY
	sellprice = 20

/obj/item/clothing/shoes/gladiator
	name = "caligae"
	desc = "Open design sandals made from sturdy leather. Can be typically seen worn by gladiators."
	gender = PLURAL
	icon_state = "gladiator"
	item_state = "gladiator"

/obj/item/clothing/shoes/sandals
	name = "sandals"
	desc = "Standard sandals."
	gender = PLURAL
	icon_state = "sandals"
	item_state = "sandals"

/obj/item/clothing/shoes/hoplite
	name = "ancient sandals"
	desc = "Worn sandals lined with bronze, ready to march ever onwards."
	icon_state = "aasimarfeet"
	item_state = "aasimarfeet"
	sellprice = 20

/obj/item/clothing/shoes/shalal
	name = "babouche"
	desc = "Leather slippers of zybantean origin."
	gender = PLURAL
	icon_state = "shalal"
	item_state = "shalal"
	sellprice = 15

/obj/item/clothing/shoes/tribal
	name = "tribal shoes"
	desc = "Haphazardly-made slippers of creecher leather worn by primitives, or those who don't care about fashion and just want to protect their feet."
	icon_state = "tribalshoes"
	item_state = "tribalshoes"
	sellprice = 3

/obj/item/clothing/shoes/jester
	name = "funny shoes"
	desc = "Shoes typically worn by a Jester."
	icon_state = "jestershoes"
	resistance_flags = null
	sellprice = 10

/obj/item/clothing/shoes/grenzelhoft
	name = "grenzelhoft boots"
	icon_state = "grenzelboots"
	item_state = "grenzelboots"
	sleeved = 'icons/roguetown/clothing/onmob/helpers/stonekeep_merc.dmi'
	armor = list("blunt" = 25, "slash" = 25, "stab" = 25,  "piercing" = 15, "fire" = 0, "acid" = 0)
	sellprice = 20
