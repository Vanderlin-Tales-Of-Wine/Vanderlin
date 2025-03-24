
/obj/item/key
	name = "old key"
	desc = "A simple key of simple uses."
	icon_state = "iron"
	icon = 'icons/roguetown/items/keys.dmi'
	w_class = WEIGHT_CLASS_TINY
	dropshrink = 0.75
	throwforce = 0
	drop_sound = 'sound/items/gems (1).ogg'
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_MOUTH|ITEM_SLOT_NECK|ITEM_SLOT_RING
	grid_height = 64
	grid_width = 32
	/// If the key is usable in a lock
	var/usable = TRUE

/obj/item/key/get_access()
	if(!src.usable)
		return null
	return ..()

/obj/item/lockpick
	name = "lockpick"
	desc = "A small, sharp piece of metal to aid opening locks in the absence of a key."
	icon_state = "lockpick"
	icon = 'icons/roguetown/items/keys.dmi'
	w_class = WEIGHT_CLASS_TINY
	dropshrink = 0.75
	throwforce = 0
	max_integrity = 10
	picklvl = 1
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_MOUTH|ITEM_SLOT_NECK
	destroy_sound = 'sound/items/pickbreak.ogg'
	grid_width = 32
	grid_height = 64

//custom key
/obj/item/key/custom
	name = "custom key"
	desc = "A custom key designed by a blacksmith."
	icon_state = "brownkey"
	usable = FALSE // Usable once finished to make this less of a hack

/obj/item/key/custom/examine()
	. += ..()
	if(src.usable)
		. += span_info("It has been etched with [src.access2string()].")
		. += span_info("It can have a name etched with a hammer.")
		return
	. += span_info("Its teeth can be set with a hammer or copied from an existing lock or key.")
	if(src.get_access())
		. += span_info("It has been marked with [src.access2string()], but has not been finished.")

/obj/item/key/custom/attackby(obj/item/I, mob/user, params)
	if(!istype(I, /obj/item/weapon/hammer))
		return ..()
	if(src.usable)
		var/input = (input(user, "What would you name this key?", "", "") as text)
		if(!input)
			return
		name = input + " key"
		to_chat(user, span_notice("You rename the key to [name]."))
		return
	var/input = input(user, "What would you like to set the key ID to?", "", 0) as num
	input = abs(input)
	if(!input)
		return
	to_chat(user, span_notice("You set the key ID to [input]."))
	src.lockids = list("[input]")

/obj/item/key/custom/attack_right(mob/user)
	if(src.usable)
		to_chat(user, span_warning("[src] has been finished, it cannot be adjusted again!"))
		return
	var/held = user.get_active_held_item()
	if(istype(held, /obj/item/weapon/hammer))
		if(!src.get_access())
			to_chat(user, span_warning("[src] is not ready, its teeth are not set!"))
			return
		src.usable = TRUE
		to_chat(user, span_notice("You finish [src]."))
		return
	if(!src.copy_access(held))
		to_chat(user, span_warning("I cannot forge a key from [held]!"))
		return
	to_chat(user, span_notice("I forge the key based on the workings of [held]."))

/obj/item/key/lord
	name = "master key"
	desc = "The Lord's key."
	icon_state = "bosskey"
	lockids = list(ACCESS_LORD)

/obj/item/key/lord/Initialize()
	. = ..()
	if(!istype(loc, /mob/living/carbon/human/dummy))
		SSroguemachine.key = src

/obj/item/key/lord/proc/anti_stall()
	src.visible_message(span_warning("[src] crumbles to dust, the ashes spiriting away in the direction of the Keep."))
	SSroguemachine.key = null //Do not harddel.
	qdel(src) //Anti-stall

/obj/item/key/manor
	name = "manor key"
	desc = "This key will open any manor doors."
	icon_state = "mazekey"
	lockids = list("manor")

/obj/item/key/guest
	name = "guest key"
	desc = "The key to the manor's guest room. Given to visiting nobles."
	icon_state = "greenkey"
	lockids = list("guest")

/obj/item/key/butler // intended for chests, crates, cellar doors, NOT kitchen access
	name = "servants key"
	desc = "The key to the pantrys and cellars of the manor."
	icon_state = "mazekey"
	lockids = list("butler")

/obj/item/key/bandit // use the old key name for various old keys for dungeons etc, less dumb than bandit keys having a label on it saying bandit key
	icon_state = "mazekey"
	lockids = list("banditcamp")

/obj/item/key/consort
	name = "consort key"
	desc = "The Consort's key."
	icon_state = "mazekey"
	lockids = list("lord")

/obj/item/key/garrison
	name = "town watch key"
	desc = "This key belongs to the Garrison."
	icon_state = "spikekey"
	lockids = list("garrison")

/obj/item/key/forrestgarrison
	name = "forrest garrison key"
	desc = "This key belongs to the Forrest Garrison."
	icon_state = "spikekey"
	lockids = list("forrestgarrison")

/obj/item/key/dungeon
	name = "dungeon key"
	desc = "This key should unlock the rusty bars and doors of the dungeon."
	icon_state = "rustkey"
	lockids = list("dungeon")

/obj/item/key/soilson
	name = "Soilson Key"
	desc = "This key is used by the soilsons."
	icon_state = "rustkey"
	lockids = list("soilson")

/obj/item/key/warehouse
	name = "Warehouse Key"
	desc = "This key opens the Steward's warehouse."
	icon_state = "rustkey"
	lockids = list("warehouse")

/obj/item/key/vault
	name = "vault key"
	desc = "This key opens the mighty Vault."
	icon_state = "cheesekey"
	lockids = list("vault")

/obj/item/key/captain
	name = "captain's key"
	desc = "This key belongs to the Captain of the Guard."
	icon_state = "cheesekey"
	lockids = list("sheriff")

/obj/item/key/merchant
	name = "merchant's key"
	desc = "A key used by the Merchant's Guild."
	icon_state = "cheesekey"
	lockids = list("merchant")

/obj/item/key/shop
	name = "shop key"
	desc = "This key opens and closes a shop door."
	icon_state = "ekey"
	lockids = list("shop")

/obj/item/key/tavern
	name = "tavern key"
	desc = "This key should open and close any Inn door."
	icon_state = "hornkey"
	lockids = list("tavern")

/obj/item/key/roomi
	name = "room I key"
	desc = "The key to the first room."
	icon_state = "brownkey"
	lockids = list("roomi")

/obj/item/key/roomii
	name = "room II key"
	desc = "The key to the second room."
	icon_state = "brownkey"
	lockids = list("roomii")

/obj/item/key/roomiii
	name = "room III key"
	desc = "The key to the third room."
	icon_state = "brownkey"
	lockids = list("roomiii")

/obj/item/key/roomiv
	name = "room IV key"
	desc = "The key to the fourth room."
	icon_state = "brownkey"
	lockids = list("roomiv")

/obj/item/key/roomv
	name = "room V key"
	desc = "The key to the fifth room."
	icon_state = "brownkey"
	lockids = list("roomv")

/obj/item/key/roomvi
	name = "room VI key"
	desc = "The key to the sixth room."
	icon_state = "brownkey"
	lockids = list("roomvi")

/obj/item/key/medroomi
	name = "medium room I key"
	desc = "The key to the first medium room."
	icon_state = "brownkey"
	lockids = list("medroomi")

/obj/item/key/medroomii
	name = "medium room II key"
	desc = "The key to the second medium room."
	icon_state = "brownkey"
	lockids = list("medroomii")

/obj/item/key/medroomiii
	name = "medium room III key"
	desc = "The key to the third medium room."
	icon_state = "brownkey"
	lockids = list("medroomiii")

/obj/item/key/medroomiv
	name = "medium room IV key"
	desc = "The key to the fourth medium room."
	icon_state = "brownkey"
	lockids = list("medroomiv")

/obj/item/key/medroomv
	name = "medium room V key"
	desc = "The key to the fifth medium room."
	icon_state = "brownkey"
	lockids = list("medroomv")

/obj/item/key/medroomvi
	name = "medium room VI key"
	desc = "The key to the sixth medium room."
	icon_state = "brownkey"
	lockids = list("medroomvi")

/obj/item/key/luxroomi
	name = "luxury room I key"
	desc = "The key to the first luxury room."
	icon_state = "brownkey"
	lockids = list("luxroomi")

/obj/item/key/luxroomii
	name = "luxury room II key"
	desc = "The key to the second luxury room."
	icon_state = "brownkey"
	lockids = list("luxroomii")

/obj/item/key/luxroomiii
	name = "luxury room III key"
	desc = "The key to the third luxury room."
	icon_state = "brownkey"
	lockids = list("luxroomiii")

/obj/item/key/luxroomiv
	name = "luxury room IV key"
	desc = "The key to the fourth luxury room."
	icon_state = "brownkey"
	lockids = list("luxroomiv")

/obj/item/key/luxroomv
	name = "luxury room V key"
	desc = "The key to the fifth luxury room."
	icon_state = "brownkey"
	lockids = list("luxroomv")

/obj/item/key/luxroomiv
	name = "luxury room VI key"
	desc = "The key to the sixth luxury room."
	icon_state = "brownkey"
	lockids = list("luxroomvi")

/obj/item/key/roomhunt
	name = "room HUNT key"
	desc = "The key to the most luxurious Inn room."
	icon_state = "brownkey"
	lockids = list("roomhunt")

//vampire mansion//
/obj/item/key/vampire
	desc = "This key is awfully pink and weirdly shaped."
	icon_state = "vampkey"
	lockids = list("mansionvampire")


/obj/item/key/blacksmith
	name = "blacksmith key"
	desc = "This key opens a blacksmith's workshop."
	icon_state = "brownkey"
	lockids = list("blacksmith")

/obj/item/key/butcher
	name = "butcher key"
	desc = "There's some dried blood on this key, it's probably the butchers."
	icon_state = "rustkey"
	lockids = list("butcher")

/obj/item/key/walls
	desc = "This is a rusty key for the walls."
	icon_state = "rustkey"
	lockids = list("walls")

/obj/item/key/church
	name = "church key"
	desc = "This bronze key should open almost all doors in the church."
	icon_state = "brownkey"
	lockids = list("priest")

/obj/item/key/priest
	name = "priest's key"
	desc = "This is the master key of the church."
	icon_state = "cheesekey"
	lockids = list("hpriest")

/obj/item/key/tower
	name = "tower key"
	desc = "This key should open anything within the tower."
	icon_state = "greenkey"
	lockids = list("tower")

/obj/item/key/mage
	name = "magicians's key"
	desc = "This is the Court Magician's key. It watches you..."
	icon_state = "eyekey"
	lockids = list("mage")

/obj/item/key/graveyard
	desc = "This rusty key belongs to the Gravetenders."
	icon_state = "rustkey"
	lockids = list("graveyard")

/obj/item/key/artificer
	name = "artificer's key"
	desc = "This bronze key should open the Artificer's guild."
	icon_state = "brownkey"
	lockids = list("artificer")

/obj/item/key/niteman
	name = "apothecary's key"
	desc = "The master key of the bath house."
	icon_state = "greenkey"
	lockids = list("nightman")

/obj/item/key/nitemaiden
	name = "bathhouse key"
	desc = "This brownish key opens a few doors within the pleasure house."
	icon_state = "brownkey"
	lockids = list("nightmaiden")

/obj/item/key/mercenary
	name = "mercenary key"
	desc = "Why, a mercenary would not kick doors down."
	icon_state = "greenkey"
	lockids = list("mercenary")

/obj/item/key/inquisition
	name = "inquisition key"
	desc = "This is an intricate key."
	icon_state = "mazekey"
	lockids = list("puritan")

/obj/item/key/confession
	name = "confessional key"
	desc = "This key opens the doors of the confessional."
	icon_state = "brownkey"
	lockids = list("confession")

/obj/item/key/hand
	name = "hand's key"
	desc = "This regal key belongs to the King's Right Hand."
	icon_state = "cheesekey"
	lockids = list("hand")

/obj/item/key/steward
	name = "steward's key"
	desc = "This key belongs to the King's greedy Steward."
	icon_state = "cheesekey"
	lockids = list("steward")

/obj/item/key/archive
	name = "archive key"
	desc = "This key looks barely used."
	icon_state = "ekey"
	lockids = list("archive")

/obj/item/key/doctor
	name = "doctor's key"
	desc = "This key is used by the Physickers."
	icon_state = "birdkey"
	lockids = list("doctor")

//grenchensnacker
/obj/item/key/porta
	name = "strange key"
	desc = "Was this key enchanted by a locksmith..?"
	icon_state = "eyekey"
	lockids = list("porta")

// Dakkatown Keys
/obj/item/key/monastery
	name = "monastery key"
	icon_state = "greenkey"
	lockids = list("monastery")

/obj/item/key/houses
	name = ""
	icon_state = ""
	lockids = list("")

/obj/item/key/houses/house1
	name = "house I key"
	icon_state = "brownkey"
	lockids = list("house1")

/obj/item/key/houses/house2
	name = "house II key"
	icon_state = "brownkey"
	lockids = list("house2")

/obj/item/key/houses/house3
	name = "house III key"
	icon_state = "brownkey"
	lockids = list("house3")

/obj/item/key/houses/house4
	name = "house IV key"
	icon_state = "brownkey"
	lockids = list("house4")

/obj/item/key/houses/house5
	name = "house V key"
	icon_state = "brownkey"
	lockids = list("house5")

/obj/item/key/houses/house6
	name = "house VI key"
	icon_state = "brownkey"
	lockids = list("house6")

/obj/item/key/houses/house7
	name = "house VII key"
	icon_state = "brownkey"
	lockids = list("house7")

/obj/item/key/houses/house8 //Not currently in use on Dun_Manor
	name = "house VIII key"
	icon_state = "brownkey"
	lockids = list("house8")

/obj/item/key/houses/house9
	name = "house IX key"
	icon_state = "brownkey"
	lockids = list("house9")

/obj/item/key/houses/waterfront1
	name = "I waterfront street key"
	icon_state = "brownkey"
	lockids = list("1waterfront")

/obj/item/key/houses/waterfront2
	name = "II waterfront street key"
	icon_state = "brownkey"
	lockids = list("2waterfront")

/obj/item/key/houses/waterfront3
	name = "III waterfront street key"
	icon_state = "brownkey"
	lockids = list("3waterfront")

/obj/item/key/houses/waterfront4
	name = "IV waterfront street key"
	icon_state = "brownkey"
	lockids = list("4waterfront")

/obj/item/key/houses/waterfront5
	name = "V waterfront street key"
	icon_state = "brownkey"
	lockids = list("5waterfront")

/obj/item/key/apartments
	name = ""
	icon_state = ""
	lockids = list("")

/obj/item/key/apartments/slums1
	name = "slums I key"
	icon_state = "brownkey"
	lockids = list("slums1")

/obj/item/key/apartments/slums2
	name = "slums II key"
	icon_state = "brownkey"
	lockids = list("slums2")

/obj/item/key/apartments/slums3
	name = "slums III key"
	icon_state = "brownkey"
	lockids = list("slums3")

/obj/item/key/apartments/slums4
	name = "slums IV key"
	icon_state = "brownkey"
	lockids = list("slums4")

/obj/item/key/apartments/slums5
	name = "slums V key"
	icon_state = "brownkey"
	lockids = list("slums5")

/obj/item/key/apartments/slums6
	name = "slums VI key"
	icon_state = "brownkey"
	lockids = list("slums6")

/obj/item/key/apartments/apartment1
	name = "apartment i key"
	icon_state = "brownkey"
	lockids = list("apartment1")

/obj/item/key/apartments/apartment2
	name = "apartment ii key"
	icon_state = "brownkey"
	lockids = list("apartment2")

/obj/item/key/apartments/apartment3
	name = "apartment iii key"
	icon_state = "brownkey"
	lockids = list("apartment3")

/obj/item/key/apartments/apartment4
	name = "apartment iv key"
	icon_state = "brownkey"
	lockids = list("apartment4")

/obj/item/key/apartments/apartment5
	name = "apartment v key"
	icon_state = "brownkey"
	lockids = list("apartment5")

/obj/item/key/apartments/apartment6
	name = "apartment vi key"
	icon_state = "brownkey"
	lockids = list("apartment6")

/obj/item/key/apartments/apartment7
	name = "apartment vii key"
	icon_state = "brownkey"
	lockids = list("apartment7")

/obj/item/key/apartments/apartment8
	name = "apartment viii key"
	icon_state = "brownkey"
	lockids = list("apartment8")

/obj/item/key/apartments/apartment9
	name = "apartment ix key"
	icon_state = "brownkey"
	lockids = list("apartment9")

/obj/item/key/apartments/apartment10
	name = "apartment x key"
	icon_state = "brownkey"
	lockids = list("apartment10")

/obj/item/key/apartments/apartment11
	name = "apartment xi key"
	icon_state = "brownkey"
	lockids = list("apartment11")

/obj/item/key/apartments/apartment12
	name = "apartment xii key"
	icon_state = "brownkey"
	lockids = list("apartment12")

/obj/item/key/apartments/apartment13
	name = "apartment xiii key"
	icon_state = "brownkey"
	lockids = list("apartment13")

/obj/item/key/apartments/apartment14
	name = "apartment xiv key"
	icon_state = "brownkey"
	lockids = list("apartment14")

/obj/item/key/apartments/apartment15
	name = "apartment xv key"
	icon_state = "brownkey"
	lockids = list("apartment15")

/obj/item/key/apartments/apartment16
	name = "apartment xvi key"
	icon_state = "brownkey"
	lockids = list("apartment16")

/obj/item/key/apartments/apartment17
	name = "apartment xvii key"
	icon_state = "brownkey"
	lockids = list("apartment17")

/obj/item/key/apartments/apartment18
	name = "apartment xviii key"
	icon_state = "brownkey"
	lockids = list("apartment18")

/obj/item/key/apartments/apartment19
	name = "apartment xix key"
	icon_state = "brownkey"
	lockids = list("apartment19")

/obj/item/key/apartments/apartment20
	name = "apartment xx key"
	icon_state = "brownkey"
	lockids = list("apartment20")

/obj/item/key/apartments/apartment21
	name = "apartment xxi key"
	icon_state = "brownkey"
	lockids = list("apartment21")

/obj/item/key/apartments/apartment22
	name = "apartment xxii key"
	icon_state = "brownkey"
	lockids = list("apartment22")

/obj/item/key/apartments/apartment23
	name = "apartment xxiii key"
	icon_state = "brownkey"
	lockids = list("apartment23")

/obj/item/key/apartments/apartment24
	name = "apartment xxiv key"
	icon_state = "brownkey"
	lockids = list("apartment24")

/obj/item/key/apartments/apartment25
	name = "apartment xxv key"
	icon_state = "brownkey"
	lockids = list("apartment25")

/obj/item/key/apartments/penthouse1
	name = "penthouse i key"
	icon_state = "brownkey"
	lockids = list("penthouse1")

/obj/item/key/apartments/penthouse2
	name = "penthouse ii key"
	icon_state = "brownkey"
	lockids = list("penthouse2")

/obj/item/key/shops
	name = ""
	icon_state = ""
	lockids = list("")

/obj/item/key/shops/shop1
	name = "shop I key"
	icon_state = "rustkey"
	lockids = list("shop1")

/obj/item/key/shops/shopwarehouse1
	name = "shop I warehouse key"
	icon_state = "rustkey"
	lockids = list("shop1ware")

/obj/item/key/shops/shop2
	name = "shop II key"
	icon_state = "rustkey"
	lockids = list("shop2")

/obj/item/key/shops/shopwarehouse2
	name = "shop II warehouse key"
	icon_state = "rustkey"
	lockids = list("shop2ware")

/obj/item/key/shops/shop3
	name = "shop III key"
	icon_state = "rustkey"
	lockids = list("shop3")

/obj/item/key/shops/shopwarehouse3
	name = "shop III warehouse key"
	icon_state = "rustkey"
	lockids = list("shop3ware")

/obj/item/key/shops/shop4
	name = "shop IV key"
	icon_state = "rustkey"
	lockids = list("shop4")

/obj/item/key/shops/shopwarehouse4
	name = "shop IV warehouse key"
	icon_state = "rustkey"
	lockids = list("shop4ware")

/obj/item/key/shops/shop5
	name = "shop V key"
	icon_state = "rustkey"
	lockids = list("shop5")

/obj/item/key/shops/shopwarehouse5
	name = "shop V warehouse key"
	icon_state = "rustkey"
	lockids = list("shop5ware")

/obj/item/key/shops/shop6
	name = "shop VI key"
	icon_state = "rustkey"
	lockids = list("shop6")

/obj/item/key/shops/shopwarehouse6
	name = "shop VI warehouse key"
	icon_state = "rustkey"
	lockids = list("shop6ware")

/obj/item/key/shops/shop7
	name = "shop VII key"
	icon_state = "rustkey"
	lockids = list("shop7")

/obj/item/key/shops/shopwarehouse7
	name = "shop VII warehouse key"
	icon_state = "rustkey"
	lockids = list("shop7ware")

/obj/item/key/shops/shop8
	name = "shop VIII key"
	icon_state = "rustkey"
	lockids = list("shop8")

/obj/item/key/shops/shopwarehouse8
	name = "shop VIII warehouse key"
	icon_state = "rustkey"
	lockids = list("shop8ware")

/obj/item/key/shops/shop9
	name = "shop IX key"
	icon_state = "rustkey"
	lockids = list("shop9")

/obj/item/key/shops/shopwarehouse9
	name = "shop IX warehouse key"
	icon_state = "rustkey"
	lockids = list("shop9ware")

/obj/item/key/theatre
	name = "theatre key"
	icon_state = "mazekey"
	lockids = list("theatre")

/obj/item/key/butcher
	name = "butcher's key"
	icon_state = "rustkey"
	lockids = list("butcher")

/obj/item/key/elder
	name = "elder's key"
	icon_state = "rustkey"
	lockids = list("elder")

/obj/item/key/veteran
	name = "veteran's key"
	icon_state = "rustkey"
	lockids = list("veteran")

/obj/item/key/apothecary
	name = "apothecary's key"
	icon_state = "rustkey"
	lockids = list("nightman")

/obj/item/key/weaponsmith
	name = "weaponsmith's key"
	icon_state = "rustkey"
	lockids = list("weaponsmith")

/obj/item/key/armorsmith
	name = "armorsmith's key"
	icon_state = "rustkey"
	lockids = list("armorsmith")

/obj/item/key/tailor
	name = "tailor's key"
	icon_state = "rustkey"
	lockids = list("tailor")

/obj/item/key/matron
	name = "matron key"
	icon_state = "rustkey"
	lockids = list("orphanage")

/obj/item/key/clinic
	name = "clinic key"
	icon_state = "mazekey"
	lockids = list("clinic")

