/obj/item/key
	name = "old key"
	desc = "A simple key of simple uses."
	icon_state = "iron"
	icon = 'icons/roguetown/items/keys.dmi'
	w_class = WEIGHT_CLASS_TINY
	dropshrink = 0.75
	throwforce = 0
	var/lockid = null
	drop_sound = 'sound/items/gems (1).ogg'
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_MOUTH|ITEM_SLOT_NECK|ITEM_SLOT_RING

	grid_height = 64
	grid_width = 32

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
	var/idtoset = null

/obj/item/key/custom/examine()
	. += ..()
	if(src.lockid)
		. += span_info("It has been etched with [src.lockid].")
		. += span_info("It can have a name etched with a hammer.")
		return
	. += span_info("Its teeth can be set with a hammer or copied from an existing lock or key.")
	if(src.idtoset)
		. += span_info("It has been marked with [src.idtoset], but has not been finished.")

/obj/item/key/custom/attackby(obj/item/I, mob/user, params)
	if(!istype(I, /obj/item/weapon/hammer))
		return ..()
	if(src.lockid) // lockid means finalised key
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
	idtoset = "[input]"

/obj/item/key/custom/attack_right(mob/user)
	if(src.lockid)
		to_chat(user, span_warning("[src] has been finished, it cannot be adjusted again!"))
		return
	var/held = user.get_active_held_item()
	if(istype(held, /obj/item/key))
		var/obj/item/key/K = held
		if(istype(K, /obj/item/key/custom) && !K.lockid)
			var/obj/item/key/custom/CK = held
			if(!CK.idtoset)
				to_chat(user, span_warning("[held] has no teeth!"))
				return
			src.idtoset = CK.idtoset
			to_chat(user, span_notice("You trace the teeth from [held] to [src]."))
			return
		if(!K.lockid)
			to_chat(user, span_warning("[held] has no teeth!"))
			return
		src.idtoset = K.lockid
		to_chat(user, span_notice("You trace the teeth from [held] to [src]."))
		return
	if(istype(held, /obj/item/customlock))
		var/obj/item/customlock/L = held
		if(!L.lockid)
			to_chat(user, span_warning("[held] has not had its pins set!"))
			return
		src.idtoset = L.lockid
		to_chat(user, span_notice("You fine-tune [src] to the lock's internals."))
		return
	if(istype(held, /obj/item/weapon/hammer))
		if(!src.idtoset)
			to_chat(user, span_warning("[src] is not ready, its teeth are not set!"))
			return
		src.lockid = src.idtoset
		src.idtoset = null
		to_chat(user, span_notice("You finish [src]."))

/obj/item/key/lord
	name = "master key"
	desc = "The Lord's key."
	icon_state = "bosskey"
	lockid = "lord"

/obj/item/key/lord/Initialize()
	. = ..()
	if(!istype(loc, /mob/living/carbon/human/dummy))
		SSroguemachine.key = src

/obj/item/key/lord/proc/anti_stall()
	src.visible_message(span_warning("[src] flies up into the sky and into the direction of the keep!"))
	SSroguemachine.key = null //Do not harddel.
	qdel(src) //Anti-stall

/obj/item/key/lord/pre_attack(target, user, params)
	. = ..()
	if(istype(target, /obj/structure/closet))
		var/obj/structure/closet/C = target
		if(C.masterkey)
			lockid = C.lockid
	if(istype(target, /obj/structure/door))
		var/obj/structure/door/D = target
		if(D.masterkey)
			lockid = D.lockid

/obj/item/key/lord/pre_attack_right(target, user, params)
	. = ..()
	if(istype(target, /obj/structure/closet))
		var/obj/structure/closet/C = target
		if(C.masterkey)
			lockid = C.lockid
	if(istype(target, /obj/structure/door))
		var/obj/structure/door/D = target
		if(D.masterkey)
			lockid = D.lockid

/obj/item/key/lord/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	lockid = initial(lockid)

///// TOWN KEYS

// Worksmen

/obj/item/key/apothecary
	name = "apothecary's key"
	desc = "Master key of the bathhouse."
	icon_state = "rustkey"
	lockid = ACCESS_APOTHECARY

/obj/item/key/blacksmith
	name = "blacksmith key"
	desc = "The master key for the town Smithy."
	icon_state = "brownkey"
	lockid = ACCESS_SMITH

/obj/item/key/butcher
	name = "butcher key"
	desc = "There's some dried blood on this key, it's probably the butchers."
	icon_state = "rustkey"
	lockid = ACCESS_BUTCHER

/obj/item/key/tailor
	name = "tailor's key"
	icon_state = "rustkey"
	lockid = ACCESS_TAILOR

/obj/item/key/clinic
	name = "clinic key"
	desc = "The Phyisickers key, for the Clinic doors."
	icon_state = "mazekey"
	lockid = ACCESS_CLINIC

/obj/item/key/soilson
	name = "Soilson Key"
	desc = "This key is used by the Soilsons."
	icon_state = "rustkey"
	lockid = ACCESS_FARM

/obj/item/key/merchant
	name = "merchant's key"
	desc = "A key used by the Merchant's Guild."
	icon_state = "cheesekey"
	lockid = ACCESS_MERCHANT

/obj/item/key/tavern // Room keys at bottom of file
	name = "inn key"
	desc = "This key should open and close any Inn door."
	icon_state = "hornkey"
	lockid = ACCESS_INN

/obj/item/key/artificer
	name = "artificer's key"
	desc = "This bronze key should open the Artificer's guild."
	icon_state = "brownkey"
	lockid = ACCESS_ARTIFICER

/obj/item/key/miner
	name = "miner's key"
	desc = "This bronze key should open the Miner's quarters."
	icon_state = "brownkey"
	lockid = ACCESS_MINER

// Residents

/obj/item/key/matron
	name = "matron's key"
	icon_state = "rustkey"
	lockid = ACCESS_MATRON

/obj/item/key/elder
	name = "elder's key"
	icon_state = "rustkey"
	lockid = ACCESS_ELDER

/obj/item/key/veteran
	name = "veteran's key"
	icon_state = "rustkey"
	lockid = ACCESS_VETERAN

/obj/item/key/feldsher
	name = "feldsher's key"
	desc = "The key to the Feldsher's own clinic."
	icon_state = "birdkey"
	lockid = ACCESS_FELDSHER

/obj/item/key/tower
	name = "tower key"
	desc = "This key should open anything within the tower."
	icon_state = "greenkey"
	lockid = ACCESS_TOWER

/obj/item/key/bathhouse
	name = "bathhouse key"
	desc = "A key for the Bathhouse."
	icon_state = "brownkey"
	lockid = ACCESS_BATHHOUSE

// Garrison

/obj/item/key/garrison
	name = "city watch key"
	desc = "This key belongs to the City Watch."
	icon_state = "spikekey"
	lockid = ACCESS_GARRISON

/obj/item/key/forrestgarrison
	name = "forest guard key"
	desc = "This key belongs to the Forest Guard."
	icon_state = "spikekey"
	lockid = ACCESS_FOREST

/obj/item/key/captain
	name = "captain's key"
	desc = "This key belongs to the Captain of the City Watch."
	icon_state = "cheesekey"
	lockid = ACCESS_CAPTAIN

// Other

/obj/item/key/mercenary
	name = "mercenary key"
	desc = "Why, a mercenary would not kick doors down."
	icon_state = "greenkey"
	lockid = ACCESS_MERC

/obj/item/key/gaffer
	name = "Mercenary guild master's key"
	desc = "\"Humble\" would be a kinder word to use for its current state..."
	icon_state = "rustkey"
	lockid = ACCESS_GAFFER

/obj/item/key/warehouse
	name = "Warehouse key"
	desc = "This key opens the Steward's warehouse."
	icon_state = "rustkey"
	lockid = ACCESS_WAREHOUSE

////// MANOR

/obj/item/key/manor
	name = "manor key"
	desc = "This key will open most Manor doors."
	icon_state = "mazekey"
	lockid = ACCESS_MANOR

/obj/item/key/hand
	name = "hand's key"
	desc = "This regal key belongs to the Monarch's Right Hand."
	icon_state = "cheesekey"
	lockid = ACCESS_HAND

/obj/item/key/steward
	name = "steward's key"
	desc = "This key belongs to the Monarch's greedy Steward."
	icon_state = "cheesekey"
	lockid = ACCESS_STEWARD

/obj/item/key/vault
	name = "vault key"
	desc = "This key opens the mighty Vault."
	icon_state = "cheesekey"
	lockid = ACCESS_VAULT

/obj/item/key/dungeon
	name = "dungeon key"
	desc = "This key should unlock the rusty bars and doors of the dungeon."
	icon_state = "rustkey"
	lockid = ACCESS_DUNGEON

/obj/item/key/consort
	name = "consort key"
	desc = "The Consort's key."
	icon_state = "mazekey"
	lockid = ACCESS_LORD

/obj/item/key/walls
	name = "manor gatehouse key"
	desc = "This is a rusty key for the Manor gatehouse."
	icon_state = "rustkey"
	lockid = ACCESS_MANOR_GATE

/obj/item/key/archive
	name = "archive key"
	desc = "This key looks barely used."
	icon_state = "ekey"
	lockid = ACCESS_ARCHIVE

/obj/item/key/mage
	name = "magicians's key"
	desc = "This is the Court Magician's key. It watches you..."
	icon_state = "eyekey"
	lockid = ACCESS_MAGE

/obj/item/key/atarms
	name = "keep garrison key"
	desc = "A key given to the Monarch's men-at-arms."
	icon_state = "spikekey"
	lockid = ACCESS_AT_ARMS

/obj/item/key/guest
	name = "guest key"
	desc = "The key to the manor's guest room. Given to visiting nobles."
	icon_state = "greenkey"
	lockid = ACCESS_GUEST

/obj/item/key/courtphys
	name = "court physician's key"
	desc = "A key granted to the honored Court Physician."
	icon_state = "ankhkey"
	lockid = ACCESS_PHYSICIAN

////// CHURCH

/obj/item/key/church
	name = "church key"
	desc = "This bronze key should open almost all doors in the church."
	icon_state = "brownkey"
	lockid = ACCESS_CHURCH

/obj/item/key/priest
	name = "priest's key"
	desc = "The key to the Priest's chambers."
	icon_state = "cheesekey"
	lockid = ACCESS_PRIEST

/obj/item/key/graveyard
	desc = "This rusty key belongs to the Gravetenders."
	icon_state = "rustkey"
	lockid = ACCESS_GRAVE

/obj/item/key/inquisition
	name = "inquisition key"
	desc = "This is an intricate key."
	icon_state = "mazekey"
	lockid = ACCESS_RITTER

// HOUSES

/obj/item/key/houses
	name = "REPORT TO MAPPERS"

/obj/item/key/houses/house1
	name = "house I key"
	icon_state = "brownkey"
	lockid = "house1"

/obj/item/key/houses/house2
	name = "house II key"
	icon_state = "brownkey"
	lockid = "house2"

/obj/item/key/houses/house3
	name = "house III key"
	icon_state = "brownkey"
	lockid = "house3"

/obj/item/key/houses/house4
	name = "house IV key"
	icon_state = "brownkey"
	lockid = "house4"

/obj/item/key/houses/house5
	name = "house V key"
	icon_state = "brownkey"
	lockid = "house5"

/obj/item/key/houses/house6
	name = "house VI key"
	icon_state = "brownkey"
	lockid = "house6"

/obj/item/key/houses/house7
	name = "house VII key"
	icon_state = "brownkey"
	lockid = "house7"

/obj/item/key/houses/house8
	name = "house VIII key"
	icon_state = "brownkey"
	lockid = "house8"

/obj/item/key/houses/house9
	name = "house IX key"
	icon_state = "brownkey"
	lockid = "house9"

/obj/item/key/houses/waterfront1
	name = "I waterfront street key"
	icon_state = "brownkey"
	lockid = "1waterfront"

/obj/item/key/houses/waterfront2
	name = "II waterfront street key"
	icon_state = "brownkey"
	lockid = "2waterfront"

/obj/item/key/houses/waterfront3
	name = "III waterfront street key"
	icon_state = "brownkey"
	lockid = "3waterfront"

/obj/item/key/houses/waterfront4
	name = "IV waterfront street key"
	icon_state = "brownkey"
	lockid = "4waterfront"

/obj/item/key/houses/waterfront5
	name = "V waterfront street key"
	icon_state = "brownkey"
	lockid = "5waterfront"

// APARTMENTS AND PENTHOUSES

/obj/item/key/apartments
	name = "REPORT TO MAPPERS"

/obj/item/key/apartments/slums1
	name = "slums I key"
	icon_state = "brownkey"
	lockid = "slums1"

/obj/item/key/apartments/slums2
	name = "slums II key"
	icon_state = "brownkey"
	lockid = "slums2"

/obj/item/key/apartments/slums3
	name = "slums III key"
	icon_state = "brownkey"
	lockid = "slums3"

/obj/item/key/apartments/slums4
	name = "slums IV key"
	icon_state = "brownkey"
	lockid = "slums4"

/obj/item/key/apartments/slums5
	name = "slums V key"
	icon_state = "brownkey"
	lockid = "slums5"

/obj/item/key/apartments/slums6
	name = "slums VI key"
	icon_state = "brownkey"
	lockid = "slums6"

/obj/item/key/apartments/apartment1
	name = "apartment i key"
	icon_state = "brownkey"
	lockid = "apartment1"

/obj/item/key/apartments/apartment2
	name = "apartment ii key"
	icon_state = "brownkey"
	lockid = "apartment2"

/obj/item/key/apartments/apartment3
	name = "apartment iii key"
	icon_state = "brownkey"
	lockid = "apartment3"

/obj/item/key/apartments/apartment4
	name = "apartment iv key"
	icon_state = "brownkey"
	lockid = "apartment4"

/obj/item/key/apartments/apartment5
	name = "apartment v key"
	icon_state = "brownkey"
	lockid = "apartment5"

/obj/item/key/apartments/apartment6
	name = "apartment vi key"
	icon_state = "brownkey"
	lockid = "apartment6"

/obj/item/key/apartments/apartment7
	name = "apartment vii key"
	icon_state = "brownkey"
	lockid = "apartment7"

/obj/item/key/apartments/apartment8
	name = "apartment viii key"
	icon_state = "brownkey"
	lockid = "apartment8"

/obj/item/key/apartments/apartment9
	name = "apartment ix key"
	icon_state = "brownkey"
	lockid = "apartment9"

/obj/item/key/apartments/apartment10
	name = "apartment x key"
	icon_state = "brownkey"
	lockid = "apartment10"

/obj/item/key/apartments/apartment11
	name = "apartment xi key"
	icon_state = "brownkey"
	lockid = "apartment11"

/obj/item/key/apartments/apartment12
	name = "apartment xii key"
	icon_state = "brownkey"
	lockid = "apartment12"

/obj/item/key/apartments/apartment13
	name = "apartment xiii key"
	icon_state = "brownkey"
	lockid = "apartment13"

/obj/item/key/apartments/apartment14
	name = "apartment xiv key"
	icon_state = "brownkey"
	lockid = "apartment14"

/obj/item/key/apartments/apartment15
	name = "apartment xv key"
	icon_state = "brownkey"
	lockid = "apartment15"

/obj/item/key/apartments/apartment16
	name = "apartment xvi key"
	icon_state = "brownkey"
	lockid = "apartment16"

/obj/item/key/apartments/apartment17
	name = "apartment xvii key"
	icon_state = "brownkey"
	lockid = "apartment17"

/obj/item/key/apartments/apartment18
	name = "apartment xviii key"
	icon_state = "brownkey"
	lockid = "apartment18"

/obj/item/key/apartments/apartment19
	name = "apartment xix key"
	icon_state = "brownkey"
	lockid = "apartment19"

/obj/item/key/apartments/apartment20
	name = "apartment xx key"
	icon_state = "brownkey"
	lockid = "apartment20"

/obj/item/key/apartments/apartment21
	name = "apartment xxi key"
	icon_state = "brownkey"
	lockid = "apartment21"

/obj/item/key/apartments/apartment22
	name = "apartment xxii key"
	icon_state = "brownkey"
	lockid = "apartment22"

/obj/item/key/apartments/apartment23
	name = "apartment xxiii key"
	icon_state = "brownkey"
	lockid = "apartment23"

/obj/item/key/apartments/apartment24
	name = "apartment xxiv key"
	icon_state = "brownkey"
	lockid = "apartment24"

/obj/item/key/apartments/apartment25
	name = "apartment xxv key"
	icon_state = "brownkey"
	lockid = "apartment25"

/obj/item/key/apartments/penthouse1
	name = "penthouse i key"
	icon_state = "brownkey"
	lockid = "penthouse1"

/obj/item/key/apartments/penthouse2
	name = "penthouse ii key"
	icon_state = "brownkey"
	lockid = "penthouse2"

// SHOP KEYS

/obj/item/key/shops
	name = "REPORT TO MAPPERS"

/obj/item/key/shops/shop1
	name = "shop I key"
	icon_state = "rustkey"
	lockid = "shop1"

/obj/item/key/shops/shop2
	name = "shop II key"
	icon_state = "rustkey"
	lockid = "shop2"

/obj/item/key/shops/shop3
	name = "shop III key"
	icon_state = "rustkey"
	lockid = "shop3"

/obj/item/key/shops/shop4
	name = "shop IV key"
	icon_state = "rustkey"
	lockid = "shop4"

/obj/item/key/shops/shop5
	name = "shop V key"
	icon_state = "rustkey"
	lockid = "shop5"

/obj/item/key/shops/shop6
	name = "shop VI key"
	icon_state = "rustkey"
	lockid = "shop6"

/obj/item/key/shops/shop7
	name = "shop VII key"
	icon_state = "rustkey"
	lockid = "shop7"

/obj/item/key/shops/shop8
	name = "shop VIII key"
	icon_state = "rustkey"
	lockid = "shop8"

/obj/item/key/shops/shop9
	name = "shop IX key"
	icon_state = "rustkey"
	lockid = "shop9"

// INN ROOMS

/obj/item/key/roomi
	name = "room I key"
	desc = "The key to the first room."
	icon_state = "brownkey"
	lockid = "roomi"

/obj/item/key/roomii
	name = "room II key"
	desc = "The key to the second room."
	icon_state = "brownkey"
	lockid = "roomii"

/obj/item/key/roomiii
	name = "room III key"
	desc = "The key to the third room."
	icon_state = "brownkey"
	lockid = "roomiii"

/obj/item/key/roomiv
	name = "room IV key"
	desc = "The key to the fourth room."
	icon_state = "brownkey"
	lockid = "roomiv"

/obj/item/key/roomv
	name = "room V key"
	desc = "The key to the fifth room."
	icon_state = "brownkey"
	lockid = "roomv"

/obj/item/key/roomvi
	name = "room VI key"
	desc = "The key to the sixth room."
	icon_state = "brownkey"
	lockid = "roomvi"

/obj/item/key/medroomi
	name = "medium room I key"
	desc = "The key to the first medium room."
	icon_state = "brownkey"
	lockid = "medroomi"

/obj/item/key/medroomii
	name = "medium room II key"
	desc = "The key to the second medium room."
	icon_state = "brownkey"
	lockid = "medroomii"

/obj/item/key/medroomiii
	name = "medium room III key"
	desc = "The key to the third medium room."
	icon_state = "brownkey"
	lockid = "medroomiii"

/obj/item/key/medroomiv
	name = "medium room IV key"
	desc = "The key to the fourth medium room."
	icon_state = "brownkey"
	lockid = "medroomiv"

/obj/item/key/medroomv
	name = "medium room V key"
	desc = "The key to the fifth medium room."
	icon_state = "brownkey"
	lockid = "medroomv"

/obj/item/key/medroomvi
	name = "medium room VI key"
	desc = "The key to the sixth medium room."
	icon_state = "brownkey"
	lockid = "medroomvi"

/obj/item/key/luxroomi
	name = "luxury room I key"
	desc = "The key to the first luxury room."
	icon_state = "brownkey"
	lockid = "luxroomi"

/obj/item/key/luxroomii
	name = "luxury room II key"
	desc = "The key to the second luxury room."
	icon_state = "brownkey"
	lockid = "luxroomii"

/obj/item/key/luxroomiii
	name = "luxury room III key"
	desc = "The key to the third luxury room."
	icon_state = "brownkey"
	lockid = "luxroomiii"

/obj/item/key/luxroomiv
	name = "luxury room IV key"
	desc = "The key to the fourth luxury room."
	icon_state = "brownkey"
	lockid = "luxroomiv"

/obj/item/key/luxroomv
	name = "luxury room V key"
	desc = "The key to the fifth luxury room."
	icon_state = "brownkey"
	lockid = "luxroomv"

/obj/item/key/luxroomiv
	name = "luxury room VI key"
	desc = "The key to the sixth luxury room."
	icon_state = "brownkey"
	lockid = "luxroomvi"

/obj/item/key/roomhunt
	name = "room HUNT key"
	desc = "The key to the most luxurious Inn room."
	icon_state = "brownkey"
	lockid = "roomhunt"

// Special Keys

// grenchensnacker
/obj/item/key/porta
	name = "strange key"
	desc = "Was this key enchanted by a locksmith..?"
	icon_state = "eyekey"
	lockid = "porta"

/obj/item/key/vampire
	desc = "This key is awfully pink and weirdly shaped."
	icon_state = "vampkey"
	lockid = "mansionvampire"

/obj/item/key/bandit
	icon_state = "mazekey"
	lockid = "banditcamp"


