

/obj/structure/roguemachine/mail
	name = "HERMES"
	desc = "The left side has a slot for incoming letters, the right for sending them." // left hand to get incoming mail, right to send
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "mail"
	density = FALSE
	blade_dulling = DULLING_BASH
	pixel_y = 32
	var/coin_loaded = FALSE
	var/ournum
	var/mailtag
	var/obfuscated = FALSE

/obj/structure/roguemachine/mail/attack_hand(mob/user)
	if(SSroguemachine.hermailermaster && ishuman(user))
		var/obj/item/roguemachine/mastermail/M = SSroguemachine.hermailermaster
		var/mob/living/carbon/human/H = user
		var/addl_mail = FALSE
		for(var/obj/item/I in M.contents)
			if(I.mailedto == H.real_name)
				if(!addl_mail)
					I.forceMove(src.loc)
					user.put_in_hands(I)
					addl_mail = TRUE
				else
					say("You have additional mail available.")
					break
		if(!addl_mail && user.mind.assigned_role == "Inquisitor") // If the user did not get any mail and is an Inquisitor, open the shop.
			show_inquisitor_shop(user)
			return

/obj/structure/roguemachine/mail/attack_right(mob/user)
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	if(!coin_loaded)
		to_chat(user, "<span class='warning'>The machine doesn't respond. It needs a coin.</span>")
		return
	var/send2place = input(user, "Where to? (Person or #number)", "VANDERLIN", null)
	if(!send2place)
		return
	var/sentfrom = input(user, "Who is this letter from?", "VANDERLIN", null)
	if(!sentfrom)
		sentfrom = "Anonymous"
	var/t = stripped_multiline_input("Write Your Letter", "VANDERLIN", no_trim=TRUE)
	if(t)
		if(length(t) > 2000)
			to_chat(user, "<span class='warning'>Too long. Try again.</span>")
			return
	if(!coin_loaded)
		return
	if(!Adjacent(user))
		return
	var/obj/item/paper/P = new
	P.info += t
	P.mailer = sentfrom
	P.mailedto = send2place
	P.update_icon()
	if(findtext(send2place, "#"))
		var/box2find = text2num(copytext(send2place, findtext(send2place, "#")+1))
		var/found = FALSE
		for(var/obj/structure/roguemachine/mail/X in SSroguemachine.hermailers)
			if(X.ournum == box2find)
				found = TRUE
				P.mailer = sentfrom
				P.mailedto = send2place
				P.update_icon()
				P.forceMove(X.loc)
				X.say("New mail!")
				playsound(X, 'sound/misc/mail.ogg', 100, FALSE, -1)
				break
		if(found)
			visible_message("<span class='warning'>[user] sends something.</span>")
			playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)
			SStreasury.give_money_treasury(coin_loaded, "Mail Income")
			coin_loaded = FALSE
			update_icon()
			return
		else
			to_chat(user, "<span class='warning'>Failed to send it. Bad number?</span>")
	else
		if(!send2place)
			return
		if(SSroguemachine.hermailermaster)
			var/obj/item/roguemachine/mastermail/X = SSroguemachine.hermailermaster
			P.mailer = sentfrom
			P.mailedto = send2place
			P.update_icon()
			P.forceMove(X.loc)
			var/datum/component/storage/STR = X.GetComponent(/datum/component/storage)
			STR.handle_item_insertion(P, prevent_warning=TRUE)
			X.new_mail=TRUE
			X.update_icon()
			send_ooc_note("New letter from <b>[sentfrom].</b>", name = send2place)
		else
			to_chat(user, "<span class='warning'>The master of mails has perished?</span>")
			return
		visible_message("<span class='warning'>[user] sends something.</span>")
		playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)
		SStreasury.give_money_treasury(coin_loaded, "Mail")
		coin_loaded = FALSE
		update_icon()

/obj/structure/roguemachine/mail/attackby(obj/item/P, mob/user, params)
	if(istype(P, /obj/item/merctoken))
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			if(H.mind.assigned_role == "Merchant")
				to_chat(H, "<span class='warning'>This is of no use to me - I may give this to a mercenary so they may send it themselves.</span>")
				return
			if(H.mind.assigned_role == "Mercenary")
				if(H.tokenclaimed == TRUE)
					to_chat(H, "<span class='warning'>I have already received my commendation. There's always next month to look forward to.</span>")
					return
				var/obj/item/merctoken/C = P
				if(C.signed == 1)
					qdel(C)
					visible_message("<span class='warning'>[H] sends something.</span>")
					playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)
					sleep(20)
					playsound(loc, 'sound/misc/mercsuccess.ogg', 100, FALSE, -1)
					playsound(src.loc, 'sound/misc/hiss.ogg', 100, FALSE, -1)
					H.visible_message("<span class='warning'>A trinket comes tumbling down from the machine. Proof of your distinction.</span>")
					H.adjust_triumphs(3)
					H.tokenclaimed = TRUE
					switch(H.merctype)
						if(0)
							new /obj/item/clothing/neck/roguetown/shalal(src.loc)
						if(1)
							new /obj/item/clothing/neck/roguetown/mercmedal/zybatine(src.loc)
						if(2)
							new /obj/item/clothing/neck/roguetown/mercmedal/grenzelhoft(src.loc)
						if(3)
							new /obj/item/clothing/neck/roguetown/mercmedal/underdweller(src.loc)
						if(4)
							new /obj/item/clothing/neck/roguetown/mercmedal/blackoak(src.loc)
						if(5)
							new /obj/item/clothing/neck/roguetown/mercmedal/steppesman(src.loc)
						if(6)
							new /obj/item/clothing/neck/roguetown/mercmedal/boltslinger(src.loc)
						if(7)
							new /obj/item/clothing/neck/roguetown/mercmedal/anthrax(src.loc)
				if(C.signed == 0)
					to_chat(H, "<span class='warning'>I cannot send an unsigned token.</span>")
					return
			else
				to_chat(H, "<span class='warning'>I can't make use of this - I do not belong to the Guild.</span>")
				return

	if(istype(P, /obj/item/paper/confession))
		if(user.mind.assigned_role == "Inquisitor" || user.mind.assigned_role == "Adept") // Only Inquisitors and Adepts can sumbit confessions.
			process_confession(user, P)
			return
	if(istype(P, /obj/item/paper))
		if(P.w_class >= WEIGHT_CLASS_BULKY)
			return
		if(alert(user, "Send Mail?",,"YES","NO") == "YES")
			var/send2place = input(user, "Where to? (Person or #number)", "VANDERLIN", null)
			var/sentfrom = input(user, "Who is this from?", "VANDERLIN", null)
			if(!sentfrom)
				sentfrom = "Anonymous"
			if(findtext(send2place, "#"))
				var/box2find = text2num(copytext(send2place, findtext(send2place, "#")+1))
				testing("box2find [box2find]")
				var/found = FALSE
				for(var/obj/structure/roguemachine/mail/X in SSroguemachine.hermailers)
					if(X.ournum == box2find)
						found = TRUE
						P.mailer = sentfrom
						P.mailedto = send2place
						P.update_icon()
						P.forceMove(X.loc)
						X.say("New mail!")
						playsound(X, 'sound/misc/mail.ogg', 100, FALSE, -1)
						playsound(src.loc, 'sound/misc/hiss.ogg', 100, FALSE, -1)
						break
				if(found)
					visible_message("<span class='warning'>[user] sends something.</span>")
					playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)
					return
				else
					to_chat(user, "<span class='warning'>Cannot send it. Bad number?</span>")
			else
				if(!send2place)
					return
				var/findmaster
				if(SSroguemachine.hermailermaster)
					var/obj/item/roguemachine/mastermail/X = SSroguemachine.hermailermaster
					findmaster = TRUE
					P.mailer = sentfrom
					P.mailedto = send2place
					P.update_icon()
					P.forceMove(X.loc)
					var/datum/component/storage/STR = X.GetComponent(/datum/component/storage)
					STR.handle_item_insertion(P, prevent_warning=TRUE)
					X.new_mail=TRUE
					X.update_icon()
					playsound(src.loc, 'sound/misc/hiss.ogg', 100, FALSE, -1)
				if(!findmaster)
					to_chat(user, "<span class='warning'>The master of mails has perished?</span>")
				else
					visible_message("<span class='warning'>[user] sends something.</span>")
					playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)
					send_ooc_note("<span class='boldnotice'>New letter from <b>[sentfrom].</b></span>", name = send2place)
					return
	if(istype(P, /obj/item/roguecoin))
		if(coin_loaded)
			return
		var/obj/item/roguecoin/C = P
		if(C.quantity > 1)
			return
		coin_loaded = C.get_real_price()
		qdel(C)
		playsound(src, 'sound/misc/coininsert.ogg', 100, FALSE, -1)
		update_icon()
		return
	..()

/obj/structure/roguemachine/mail/Initialize()
	. = ..()
	SSroguemachine.hermailers += src
	ournum = SSroguemachine.hermailers.len
	name = "[name] #[ournum]"
	update_icon()

/obj/structure/roguemachine/mail/Destroy()
	set_light(0)
	SSroguemachine.hermailers -= src
	return ..()

/obj/structure/roguemachine/mail/r
	pixel_y = 0
	pixel_x = 32

/obj/structure/roguemachine/mail/l
	pixel_y = 0
	pixel_x = -32

/obj/structure/roguemachine/mail/update_icon()
	cut_overlays()
	if(coin_loaded)
		add_overlay(mutable_appearance(icon, "mail-f"))
		set_light(1, 1, 1, l_color =  "#ff0d0d")
	else
		add_overlay(mutable_appearance(icon, "mail-s"))
		set_light(1, 1, 1, l_color =  "#1b7bf1")

/obj/structure/roguemachine/mail/examine(mob/user)
	. = ..()
	. += "<a href='byond://?src=[REF(src)];directory=1'>Directory:</a> [mailtag]"

/obj/structure/roguemachine/mail/Topic(href, href_list)
	..()

	if(!usr)
		return

	if(href_list["directory"])
		view_directory(usr)

/obj/structure/roguemachine/mail/proc/view_directory(mob/user)
	var/dat
	for(var/obj/structure/roguemachine/mail/X in SSroguemachine.hermailers)
		if(X.obfuscated)
			continue
		if(X.mailtag)
			dat += "#[X.ournum] [X.mailtag]<br>"
		else
			dat += "#[X.ournum] [capitalize(get_area_name(X))]<br>"

	var/datum/browser/popup = new(user, "hermes_directory", "<center>HERMES DIRECTORY</center>", 387, 420)
	popup.set_content(dat)
	popup.open(FALSE)

/obj/item/roguemachine/mastermail
	name = "MASTER OF MAILS"
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "mailspecial"
	pixel_y = 32
	max_integrity = 0
	density = FALSE
	blade_dulling = DULLING_BASH
	anchored = TRUE
	w_class = WEIGHT_CLASS_GIGANTIC
	var/new_mail

/obj/item/roguemachine/mastermail/update_icon()
	cut_overlays()
	if(new_mail)
		icon_state = "mailspecial-get"
	else
		icon_state = "mailspecial"
	set_light(1, 1, 1, l_color = "#ff0d0d")

/obj/item/roguemachine/mastermail/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/storage/concrete/roguetown/mailmaster)

/obj/item/roguemachine/mastermail/attack_hand(mob/user)
	var/datum/component/storage/CP = GetComponent(/datum/component/storage)
	if(CP)
		if(new_mail)
			new_mail = FALSE
			update_icon()
		CP.rmb_show(user)
		return TRUE

/obj/item/roguemachine/mastermail/Initialize()
	. = ..()
	SSroguemachine.hermailermaster = src
	update_icon()

/obj/item/roguemachine/mastermail/attackby(obj/item/P, mob/user, params)
	if(istype(P, /obj/item/paper))
		var/obj/item/paper/PA = P
		if(!PA.mailer && !PA.mailedto && PA.cached_mailer && PA.cached_mailedto)
			PA.mailer = PA.cached_mailer
			PA.mailedto = PA.cached_mailedto
			PA.cached_mailer = null
			PA.cached_mailedto = null
			PA.update_icon()
			to_chat(user, "<span class='warning'>I carefully re-seal the letter and place it back in the machine, no one will know.</span>")
		P.forceMove(loc)
		var/datum/component/storage/STR = GetComponent(/datum/component/storage)
		STR.handle_item_insertion(P, prevent_warning=TRUE)
	..()

/obj/item/roguemachine/mastermail/Destroy()
	set_light(0)
	SSroguemachine.hermailers -= src
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		var/list/things = STR.contents()
		for(var/obj/item/I in things)
			STR.remove_from_storage(I, get_turf(src))
	return ..()

/obj/structure/roguemachine/mail/proc/process_confession(mob/living/carbon/human/user, P)
	var/obj/item/paper/confession/C = P
	if(C.signed)
		if(C.signed == user.real_name) // If the Inquisitor is the one who signed the confession, they can't use it.
			return
		if(GLOB.confessors)
			var/no
			if(", [C.signed]" in GLOB.confessors)
				no = TRUE
			if("[C.signed]" in GLOB.confessors)
				no = TRUE
			if(!no)
				if(GLOB.confessors.len)
					GLOB.confessors += ", [C.signed] - a [C.antag]"
				else
					GLOB.confessors += "[C.signed] - a [C.antag]"
		qdel(C)
		visible_message("<span class='warning'>[user] sends something.</span>")
		playsound(loc, 'sound/magic/forgotten_bell.ogg', 80, FALSE, -1)
		playsound(loc, 'sound/misc/disposalflush.ogg', 100, FALSE, -1)
		for(var/mob/living/carbon/human/I in world) // Find all the living Inquisitors and Adepts and give them a triumph for the confession.
			if(I.mind && (I.mind.assigned_role == "Inquisitor" || I.mind.assigned_role == "Adept") && !(I.stat == DEAD))
				if(I.mind.assigned_role == "Inquisitor")
					I.confession_points += 5 // Increase the Inquisitor's confession count.
					to_chat(I, "<span class='warning'>-I have gained more favors.</span>")
				to_chat(I, "<span class='warning'>A sense of grim satisfaction fills your heart. One confession down, a million remain.</span>")
				I.adjust_triumphs(1)

/obj/structure/roguemachine/mail/proc/show_inquisitor_shop(mob/living/carbon/human/user)
	testing("Src is [src]")
	testing("User is [user]")
	var/list/options = list()

	// Ensure the user is an Inquisitor
	if(!user.mind || user.mind.assigned_role != "Inquisitor")
		testing("User is not an Inquisitor: [user.mind.assigned_role]")
		to_chat(user, "<span class='warning'>You do not have access to the confession system.</span>")
		return
	testing("User is an Inquisitor")

	// Ensure purchase_history is initialized
	if(!user.purchase_history)
		user.purchase_history = list()
		testing("Initialized purchase_history for user")

	// Define the available items, their costs, and max purchases
	var/list/items = list(
		// Weapons
		"Puffer Pistol- 4 Lead Balls- Powder Flask  (10)" = list(
			list(type = /obj/item/gun/ballistic/revolver/grenadelauncher/pistol, count = 1),
			list(type = /obj/item/storage/belt/rogue/pouch/bullets, count = 1),
			list(type = /obj/item/reagent_containers/glass/bottle/rogue/aflask, count = 1),
			cost = 8,
			max_purchases = 1
		),
		"Four Spare Lead Balls (5)" = list(
			list(type = /obj/item/ammo_casing/caseless/rogue/bullet, count = 4),
			cost = 5,
			max_purchases = 1
		),
		"Spare Powder Flask (2)" = list(
			list(type = /obj/item/reagent_containers/glass/bottle/rogue/aflask, count = 1),
			cost = 2,
			max_purchases = 1
		),
		"Battle Bomb (3)" = list(
			list(type = /obj/item/bomb, count = 1),
			cost = 3,
			max_purchases = 2
		),
		"Silver Dagger (5)" = list(
			list(type = /obj/item/rogueweapon/knife/dagger/silver, count = 1),
			cost = 5,
			max_purchases = 2
		),
		"Spiked Mace (2)" = list(
			list(type = /obj/item/rogueweapon/mace/spiked, count = 1),
			cost = 2,
			max_purchases = 3
		),
		// Tools
		"Surgery Bag (3)" = list(
			list(type = /obj/item/storage/backpack/rogue/satchel/surgbag, count = 1),
			cost = 3,
			max_purchases = 1
		),
		"Three Lockpicks On A Ring (2)" = list(
			list(type = /obj/item/lockpickring/mundane, count = 1),
			cost = 2,
			max_purchases = 5
		),
		"Head Sack (1)" = list(
			list(type = /obj/item/clothing/head/roguetown/sack, count = 1),
			cost = 1,
			max_purchases = 5
		),
		"Bag of Silver Coins (3)" = list(
			list(type = /obj/item/storage/belt/rogue/pouch/coins/rich, count = 1),
			cost = 3,
			max_purchases = 3
		),
		"Vial Of Strong Poison (5)" = list(
			list(type = /obj/item/reagent_containers/glass/bottle/vial/strongpoison, count = 1),
			cost = 5,
			max_purchases = 1
		),
		"Vial Of Antidote (2)" = list(
			list(type = /obj/item/reagent_containers/glass/bottle/vial/antidote, count = 1),
			cost = 2,
			max_purchases = 1
		),
		// Clothing
		"Silver Psycross (2)" = list(
			list(type = /obj/item/clothing/neck/roguetown/psycross/silver, count = 1),
			cost = 2,
			max_purchases = 4
		),
		"Valorian Cloak (2)" = list(
			list(type = /obj/item/clothing/cloak/cape/inquisitor, count = 1),
			cost = 2,
			max_purchases = 1
		),
		"Plate Vambraces (2)" = list(
			list(type = /obj/item/clothing/wrists/roguetown/bracers, count = 1),
			cost = 2,
			max_purchases = 4
		),
		"Chain Gauntlets (3)" = list(
			list(type = /obj/item/clothing/gloves/roguetown/chain, count = 2),
			cost = 3,
			max_purchases = 4
		),
	)
	testing("Items defined: [items]")

	// Populate the options for the shop interface
	for(var/name in items)
		var/item_data = items[name]
		var/item_cost = item_data["cost"]
		var/max_purchases = item_data["max_purchases"]
		var/purchase_count = user.purchase_history[name] || 0

		testing("Processing item: [name], cost: [item_cost], max_purchases: [max_purchases], purchase_count: [purchase_count]")

		// If the item has been purchased the maximum number of times, disable it
		if(purchase_count >= max_purchases)
			options[name] = "[name] - SOLD OUT"
			testing("[name] is SOLD OUT")
		else
			options[name] = "[name] - [item_cost] confession(s)"
			testing("[name] available for purchase at [item_cost] confessions")

	// Ask the user to select an item
	var/selection = input(user, "Select an item to request", "I have [user.confession_points] favors left...") as null | anything in options
	testing("User selected: [selection]")
	if(!selection)
		return

	// Retrieve the selected item details
	var/item_data = items[selection]
	var/item_cost = item_data["cost"]
	var/max_purchases = item_data["max_purchases"]
	var/purchase_count = user.purchase_history[selection] || 0

	testing("Selected item: [selection], cost: [item_cost], purchase_count: [purchase_count], max_purchases: [max_purchases]")

	// Check if we are still next to the mailer.
	if(!Adjacent(user))
		return

	// Check if the item is sold out
	if(purchase_count >= max_purchases)
		testing("[selection] is SOLD OUT after selection")
		to_chat(user, "<span class='warning'>This item is sold out.</span>")
		return

	// Get the current confession points from the user
	var/current_points = user.confession_points || 0
	testing("User confession points: [current_points]")
	if(current_points < item_cost)
		testing("User does not have enough confession points: [current_points] < [item_cost]")
		to_chat(user, "<span class='warning'>You do not have enough favors.</span>")
		return

	// Deduct the points and give the items
	user.confession_points -= item_cost
	testing("Deducted [item_cost] confession points, remaining: [user.confession_points]")
	user.purchase_history[selection] = purchase_count + 1
	testing("Updated purchase history for [selection]: [user.purchase_history[selection]]")

	// Loop through the sub-list to generate multiple items
	for(var/item in item_data)
		if(islist(item)) // Ensure this is an item list and not the cost/max_purchase entry
			var/item_type = item["type"]
			var/item_count = item["count"]
			if(item_type && item_count) // Ensure the item list has both type and count defined
				for(var/i = 1 to item_count)
					testing("Creating item: [item_type] x[item_count]")
					var/obj/item/I = new item_type(get_turf(user)) // Create the item at the user's location
					if(!user.put_in_hands(I)) // Try to put the item in the user's hands
						testing("Failed to place item in hands, dropping at user's location")
						I.forceMove(get_turf(user)) // If not, drop it at the user's location

	visible_message("<span class='warning'>The mailbox spits out its contents.</span>")
	say("HERE IS THE REQUESTED ITEM. WE HOPE IT SERVES YOU WELL.",language = /datum/language/oldpsydonic)
	playsound(src, 'sound/misc/machinelong.ogg', 100, FALSE, -1)
	testing("Finished processing user selection and item dispensing")
	return
