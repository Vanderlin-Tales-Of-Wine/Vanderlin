
/obj/item/clothing/pants/trou
	name = "work trousers"
	desc = "Padded pants for hardy workers."
	gender = PLURAL
	icon_state = "trou"
	item_state = "trou"
	sewrepair = TRUE
	blocksound = SOFTHIT
	blade_dulling = DULLING_BASHCHOP
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL

	armor = ARMOR_PADDED_BAD
	prevent_crits = MINOR_CRITICALS
	salvage_amount = 1
	salvage_result = /obj/item/natural/hide/cured
	item_weight = 3

/obj/item/clothing/pants/trou/leather
	name = "leather trousers"
	desc = "Standard leather pants for hardy workers."
	icon_state = "leathertrou"
	armor = ARMOR_LEATHER
	max_integrity = INTEGRITY_POOR

/obj/item/clothing/pants/trou/leather/guard/Initialize()
	. = ..()
	color = pick(CLOTHING_PLUM_PURPLE, CLOTHING_BLOOD_RED)
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/pants/trou/leather/guard/Destroy()
	GLOB.lordcolor -= src
	return ..()

/obj/item/clothing/pants/trou/leather/advanced
	name = "hardened leather chausses"
	desc = "Sturdy, durable, flexible. The finest leather to protect your nether regions."
	max_integrity = 200
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST)
	armor = list("blunt" = 70, "slash" = 60, "stab" = 30, "piercing" = 20,"fire" = 0, "acid" = 0)

/obj/item/clothing/pants/trou/leather/masterwork
	name = "masterwork leather chausses"
	desc = "These chausses are a craftsmanship marvel. Made with the finest leather. Strong, nimible, reliable."
	max_integrity = 250
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST, BCLASS_CHOP)
	armor = list("blunt" = 100, "slash" = 70, "stab" = 40, "piercing" = 20, "fire" = 0, "acid" = 0)

/obj/item/clothing/pants/trou/leather/masterwork/Initialize()
	. = ..()
	filters += filter(type="drop_shadow", x=0, y=0, size=0.5, offset=1, color=rgb(218, 165, 32))

/obj/item/clothing/pants/trou/leather/mourning
	name = "mourning trousers"
	desc = "Dark trousers worn by morticians while performing burial rites."
	icon_state = "leathertrou"
	color = "#151615"

/obj/item/clothing/pants/trou/shadowpants
	name = "silk tights"
	desc = "Form-fitting legwear. Almost too form-fitting."
	mob_overlay_icon = 'icons/roguetown/clothing/newclothes/onmob/onmobsilkpants.dmi'
	sleeved = 'icons/roguetown/clothing/newclothes/onmob/sleeves_pants.dmi'
	icon_state = "shadowpants"
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	salvage_amount = 1
	salvage_result = /obj/item/natural/silk

/obj/item/clothing/pants/trou/apothecary
	name = "apothecary trousers"
	desc = "Heavily padded trousers. They're stained by countless herbs."
	icon_state = "apothpants"
	item_state = "apothpants"

/obj/item/clothing/pants/trou/artipants
	name = "artificer trousers"
	desc = "Thick leather trousers to protect from sparks or stray gear projectiles. Judging by the wear, its had plenty of use."
	icon_state = "artipants"
	item_state = "artipants"

/obj/item/clothing/pants/trou/leathertights
	name = "leather tights"
	desc = "Classy leather tights, form-fitting but tasteful."
	icon_state = "leathertights"
	item_state = "leathertights"

/obj/item/clothing/pants/trou/beltpants
	name = "belt-buckled trousers"
	desc = "Dark leather trousers adorned with far too many buckles to be pragmatic."
	icon_state = "beltpants"
	item_state = "beltpants"
