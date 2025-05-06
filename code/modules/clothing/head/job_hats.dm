/obj/item/clothing/head/fisherhat
	name = "straw hat"
	desc = "Wenches shall lust for thee. Fishe will fear thee. \
			Humen will cast their gaze aside. As thou walk, \
			no creecher shall dare make a sound on thy presence. \
			Thou wilt be alone on these barren lands."
	icon_state = "fisherhat"

/obj/item/clothing/head/stewardtophat
	name = "top hat"
	icon_state = "stewardtophat"
	icon = 'icons/roguetown/clothing/special/steward.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"

/obj/item/clothing/head/strawhat
	name = "crude straw hat"
	desc = "Welcome to the grain fields, thou plowerer of the fertile."
	icon_state = "strawhat"
	salvage_result = /obj/item/natural/fibers

/obj/item/clothing/head/articap
	desc = "A sporting cap with a small gear adornment. Popular fashion amongst Heartfelt engineers."
	icon_state = "articap"

/obj/item/clothing/head/cookhat
	name = "cook hat"
	desc = "A white top hat typically worn by distinguished kitchen workers."
	icon_state = "chef"
	item_state = "chef"
	flags_inv = HIDEEARS

/obj/item/clothing/head/nun
	name = "nun's habit"
	desc = "Habits worn by nuns of the pantheon's faith."
	icon_state = "nun"
	allowed_race = list("human", "tiefling", "elf", "dwarf", "aasimar")

/obj/item/clothing/head/fancyhat
	name = "fancy hat"
	icon_state = "fancyhat"
	sellprice = VALUE_FINE_CLOTHING

/obj/item/clothing/head/courtierhat
	name = "fancy hat"
	icon_state = "courtier"
	flags_inv = HIDEEARS
	sellprice = VALUE_FINE_CLOTHING

/obj/item/clothing/head/bardhat
	name = "plumed hat"
	desc = "A simple leather hat with a fancy plume on top. A corny attempt at appearing regal \
			despite one's status. Typically worn by travelling minstrels of all kinds."
	icon_state = "bardhat"

/obj/item/clothing/head/jester
	name = "jester's hat"
	desc = "Just remember that the last laugh is on you."
	icon_state = "jester"

/obj/item/clothing/head/cookhat/chef // only unique thing is the name
	name = "chef's hat"

/obj/item/clothing/head/tophat
	name = "teller's hat"
	icon_state = "tophat"
	color = CLOTHING_SOOT_BLACK

/obj/item/clothing/head/wizhat
	name = "wizard hat"
	desc = "Used to distinguish dangerous wizards from senile old men."
	icon_state = "wizardhat"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/64x64/head.dmi'
	dynamic_hair_suffix = "+generic"
	worn_x_dimension = 64
	worn_y_dimension = 64
	bloody_icon = 'icons/effects/blood64x64.dmi'
	bloody_icon_state = "helmetblood_big"

	prevent_crits =  MINOR_CRITICALS

/obj/item/clothing/head/wizhat/Initialize()
	. = ..()
	AddComponent(/datum/component/storage/concrete/grid/kobold_storage)

/obj/item/clothing/head/wizhat/witch
	name = "witch hat"
	desc = ""
	icon_state = "witchhat"
	detail_tag = "_detail"
	detail_color = CLOTHING_SOOT_BLACK

/obj/item/clothing/head/wizhat/gen
	icon_state = "wizardhatgen"

/obj/item/clothing/head/leather/inqhat
	name = "inquisitorial hat"
	desc = "A wide-brimmed leather hat, adorned with a crimson-dyed feather. Death has come to your little town."
	icon_state = "inqhat"
	item_state = "inqhat"
	sewrepair = TRUE

/obj/item/clothing/head/physhat
	name = "court physician's hat"
	desc = "A head covering for the distinguished physician."
	icon_state = "physicianhat"
