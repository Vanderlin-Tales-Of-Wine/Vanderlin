#define PRINTER_COOLDOWN 600 // The time between printing manuscripts and binding books
#define PRINTING_TIME 250 // The time it takes to actually print something using the printing press

/obj/machinery/printingpress
	name = "printing press"
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "Ppress_Clean"
	desc = "The Archivist's wonder. Gears, ink, and wood b locks can turn the written word to the printed word."
	density = TRUE
	var/cooldown = 0
	var/printing = FALSE
	var/has_paper = FALSE
	var/obj/item/paper/loaded_paper
	var/obj/item/output_item // Variable to store the printed item

	var/static/list/manuel_name_to_path = list()

/obj/machinery/printingpress/attackby(obj/item/O, mob/user, params)
	if(printing)
		to_chat(user, span_warning("[src] is currently printing. Please wait."))
		return
	if(output_item)
		to_chat(user, span_notice("Please retrieve the printed item before inserting new items."))
		return
	if(istype(O, /obj/item/paper/manuscript))
		var/obj/item/paper/manuscript/M = O
		if(!M.written)
			to_chat(user, span_notice("This manuscript is blank. You need to write something before uploading it."))
			return
		// Prompt the user to upload the manuscript
		var/choice = input(user, "Do you want to add the manuscript to the archive?") in list("Yes", "No")
		if(choice == "Yes")
			upload_manuscript(user, M)
			// Optionally delete the manuscript after uploading
			qdel(M)
			to_chat(user, span_notice("The manuscript has been uploaded and removed from your inventory."))
		else
			to_chat(user, span_notice("You decide not to upload the manuscript."))
		return
	if(istype(O, /obj/item/paper) && !has_paper)
		has_paper = TRUE
		loaded_paper = O
		src.icon_state = "Ppress_Prepared"
		to_chat(user, span_warning("You insert the blank paper into [src]."))
		qdel(O)
	return ..()

/obj/machinery/printingpress/attack_hand(mob/user)
	if(printing)
		to_chat(user, span_warning("The [src] is currently printing. Please wait."))
		return
	if(output_item)
		// Try to put the item into the user's hands
		if(!user.put_in_hands(output_item))
			output_item.forceMove(get_turf(user))
		else
			to_chat(user, span_warning("You retrieve [output_item] from [src]."))
		output_item = null
		src.icon_state = "Ppress_Clean"
		return
	if(loaded_paper)
		// Allow the user to retrieve the blank paper
		var/obj/item/paper/P = new /obj/item/paper(get_turf(user)) // Create the item at the user's location
		if(!user.put_in_hands(P)) // Try to put the item in the user's hands
			P.forceMove(get_turf(user)) // If not, drop it at the user's location
		to_chat(user, span_warning("You retrieve the [P.name] from [src]."))
		has_paper = FALSE
		loaded_paper = null
		src.icon_state = "Ppress_Clean"
		return
	else
		// Default interaction or message
		to_chat(user, span_warning("[src] is empty."))
		return

/obj/machinery/printingpress/attack_right(mob/user)
	if(printing)
		to_chat(user, span_warning("[src] is currently printing. Please wait."))
		return
	if(output_item)
		to_chat(user, span_warning("There is a finished product in [src]. Use an empty hand to retrieve it."))
		return
	if(!has_paper)
		to_chat(user, span_warning("[src] requires a blank piece of paper to print."))
		return
	var/choice = input(user, "Choose an option for \the [src]") in list("Print The Book", "Print a Tome of Justice", "Print from the Archive", "Profession Manuel")
	switch(choice)
		if ("Print The Book")
			start_printing(user, "bibble")
		if ("Print a Tome of Justice")
			start_printing(user, "justice")
		if ("Print from the Archive")
			choose_search_parameters(user)
		if("Profession Manuel")
			if(!length(manuel_name_to_path))
				for(var/obj/item/recipe_book/book as anything in subtypesof(/obj/item/recipe_book))
					if(!initial(book.can_spawn))
						continue
					manuel_name_to_path |= initial(book.name)
					manuel_name_to_path[initial(book.name)] = book
			choice = input(user, "Choose an option for \the [src]") in manuel_name_to_path
			if(choice)
				start_printing(user, manuel_name_to_path[choice])

/obj/machinery/printingpress/proc/start_printing(mob/user, print_type, id = null)
	if(cooldown > world.time)
		to_chat(user, span_warning("[src] is still recalibrating."))
		return
	printing = TRUE
	src.icon_state = "Ppress_Printing"
	to_chat(user, span_warning("[src] starts printing..."))
	playsound(src.loc, 'sound/misc/ppress.ogg', 100, FALSE)
	// Delete the blank paper as it's consumed during printing
	if(loaded_paper)
		qdel(loaded_paper)
		loaded_paper = null
		has_paper = FALSE
	sleep(PRINTING_TIME)
	if(print_type == "bibble")
		print_bibble(user)
	else if(print_type == "justice")
		print_justice(user)
	else if(print_type == "archive")
		print_manuscript(user, id)
	else if (ispath(print_type))
		var/obj/item/recipe_book/path = print_type
		var/obj/item/recipe_book/book = new path()
		output_item = book
		visible_message("<span class='notice'>The printing press hums as it produces [book.name].</span>")

	// Printing is done
	printing = FALSE
	src.icon_state = "Ppress_Done"
	cooldown = world.time + PRINTER_COOLDOWN

/obj/machinery/printingpress/proc/upload_manuscript(mob/user, obj/item/paper/manuscript/M)
	// Perform the actual SQL INSERT query
	var/datum/DBQuery/query_upload_manuscript = SSdbcore.NewQuery({"
		INSERT INTO library (author, title, content, category, select_icon, ckey, datetime, round_id_created, approved)
		VALUES (:author, :title, :content, :category, :select_icon, :ckey, Now(), :round_id_created, :approved)
	"}, list(
		"author" = M.author,
		"title" = M.name,
		"content" = M.content,
		"category" = M.category,
		"select_icon" = M.select_icon,
		"ckey" = M.ckey,
		"round_id_created" = GLOB.round_id,
		"approved" = 0
	))

	if (query_upload_manuscript.Execute())
		user.visible_message(span_notice("[user] uploads a manuscript to the archive."), span_notice("You upload a manuscript to the archive."))
	else
		to_chat(user, span_warning("Manuscript storage failed. Please try again later."))

	qdel(query_upload_manuscript)

/obj/machinery/printingpress/proc/print_bibble(mob/user)
	// Creates a static book (Bibble)
	var/obj/item/book/rogue/bibble/B = new()
	output_item = B
	visible_message("<span class='notice'>The printing press hums as it produces [B.name].</span>")

/obj/machinery/printingpress/proc/print_justice(mob/user)
	// Creates a static book (Tome of Justice)
	var/obj/item/book/rogue/law/B = new()
	output_item = B
	visible_message("<span class='notice'>[src] hums as it produces the [B.name].</span>")

/obj/machinery/printingpress/proc/print_manuscript(mob/user, id)
	var/sqlid = text2num(id)
	if (!sqlid)
		to_chat(user, span_warning("Invalid manuscript ID."))
		return

	// Perform the actual SQL SELECT query
	var/datum/DBQuery/query_print_manuscript = SSdbcore.NewQuery({"
		SELECT author, title, content, category, ckey, select_icon
		FROM library
		WHERE id = :id AND deleted <> 1 AND approved = 1
	"}, list("id" = sqlid))

	if (query_print_manuscript.Execute() && query_print_manuscript.NextRow())
		var/author = query_print_manuscript.item[1]
		var/title = query_print_manuscript.item[2]
		var/content = query_print_manuscript.item[3]
		var/category = query_print_manuscript.item[4]
		var/ckey = query_print_manuscript.item[5]
		var/select_icon = query_print_manuscript.item[6]

		// Check if the manuscript is in the forbidden category
		if (category == "Apocrypha & Grimoires")
			to_chat(user, span_warning("This manuscript cannot be printed using [src]."))
			qdel(query_print_manuscript)
			return

		// Create a new manuscript object
		var/obj/item/paper/manuscript/M = new()
		M.name = title
		M.author = author
		M.content = content
		M.category = category
		M.ckey = ckey
		M.select_icon = select_icon
		M.written = TRUE
		M.info = content
		output_item = M
		visible_message("<span class='notice'>[src] hums as it produces a manuscript titled [title].</span>")
	else
		to_chat(user, span_warning("Could not find manuscript with ID [id]."))

	qdel(query_print_manuscript)

/obj/machinery/printingpress/proc/choose_search_parameters(mob/user)
	var/search_title = input(user, "Enter the title (optional):") as text|null
	var/search_author = input(user, "Enter the author (optional):") as text|null
	var/search_category = input(user, "Select a category (optional):") in list("Any", "Myths & Tales", "Legends & Accounts", "Thesis", "Eoratica") // Removed "Apocrypha & Grimoires"
	// Pass the selected parameters to search_manuscripts
	search_manuscripts(user, search_title, search_author, search_category)

/obj/machinery/printingpress/proc/search_manuscripts(mob/user, search_title, search_author, search_category)
	var/list/params = list()
	var/sqlquery = "SELECT id, author, title, category FROM library WHERE deleted <> 1 AND approved = 1 AND category != 'Apocrypha & Grimoires'" // Exclude forbidden category

	if (search_author && search_author != "")
		sqlquery += " AND author LIKE :author"
		params["author"] = "%" + search_author + "%"
	if (search_title && search_title != "")
		sqlquery += " AND title LIKE :title"
		params["title"] = "%" + search_title + "%"
	if (search_category && search_category != "Any")
		sqlquery += " AND category = :category"
		params["category"] = search_category

	var/datum/DBQuery/query_search_manuscripts = SSdbcore.NewQuery(sqlquery, params)

	var/dat = "<h3>Manuscript Search Results:</h3><br>"
	dat += "<table><tr><th>Author</th><th>Title</th><th>Category</th><th>Print</th></tr>"

	if (query_search_manuscripts.Execute())
		var/has_results = FALSE
		while (query_search_manuscripts.NextRow())
			has_results = TRUE
			var/id = query_search_manuscripts.item[1]
			var/author = query_search_manuscripts.item[2]
			var/title = query_search_manuscripts.item[3]
			var/category = query_search_manuscripts.item[4]
			dat += "<tr><td>[html_encode(author)]</td><td>[html_encode(title)]</td><td>[html_encode(category)]</td><td><a href='byond://?src=[REF(src)];print=1;id=[id]'>Print</a></td></tr>"
		if (!has_results)
			dat += "<tr><td colspan='4'>No results found.</td></tr>"
	else
		dat += "<tr><td colspan='4'>Error executing search query.</td></tr>"

	dat += "</table>"
	user << browse(dat, "window=search_results")

	qdel(query_search_manuscripts)

/obj/machinery/printingpress/Topic(href, href_list)
	if(printing)
		return // Ignore interactions while printing
	if("print" in href_list)
		var/id = href_list["id"]
		start_printing(usr, "archive", id)

/obj/machinery/bookbinder
	name = "book binder"
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "book_binder"
	desc = "A machine that binds loose manuscripts into finished books."
	density = TRUE
	var/busy = FALSE

/obj/machinery/bookbinder/proc/bind_book(mob/user, obj/item/paper/manuscript/M)
	if (busy)
		to_chat(user, "<span class='warning'>[src] is already pressing a book!</span>")
		return

	if (!user.transferItemToLoc(M, src))
		return

	user.visible_message(span_notice("[user] places \the [M] into \the [src] and screws the press."), span_notice("I place \the [M] into \the [src] and screw the press."))
	busy = TRUE
	sleep(rand(50, 100))
	busy = FALSE

	var/obj/item/book/rogue/B = new(src.loc)
	B.name = M.name
	B.title = M.name
	B.author = M.author
	B.pages = list("<b3><h3>Title: [B.title]<br>Author: [B.author]</b><h3>[M.info]")
	B.icon_state = "[M.select_icon]_0"
	B.base_icon_state = "[M.select_icon]"
	qdel(M)

	visible_message("<span class='notice'>[B.title] has been produced from the manuscript!</span>")

/obj/machinery/bookbinder/attackby(obj/O, mob/user, params)
	if (istype(O, /obj/item/paper/manuscript))
		bind_book(user, O)
		return TRUE
	return ..()

/obj/item/paper/manuscript
	name = "manuscript"
	desc = "A loose manuscript yet to be bound."
	var/author = "anonymous"
	var/content = ""
	var/category = "Unspecified"
	var/ckey = ""
	var/newicon = "basic_book_0"
	var/written = FALSE
	var/select_icon = "basic_book"
	var/list/book_icons = list(
		"Simple green" = "basic_book",
		"Simple black" = "book",
		"Simple red" = "book2",
		"Simple blue" = "book3",
		"Simple dark yellow" = "book4",
		"Brown with dark corners" = "book5",
		"Heavy purple with dark corners" = "book6",
		"Light purple with gold leaf" = "book7",
		"Light blue with gold leaf" = "book8",
		"Grey with gold leaf" = "knowledge")

/obj/item/paper/attack_right(mob/user)
	if(istype(user, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = user
		if(H.mind.get_skill_level(/datum/skill/misc/reading) <= 0)
			to_chat(user, "<span class='warning'>I don't know how to do this!</span>")
			return
		if(!user.is_holding(src))
			to_chat(user, "<span class='warning'>I need to hold \the [src] to turn it into a manuscript!</span>")
			return
		if(info)
			to_chat(user, "<span class='warning'>The paper already has content!</span>")
			return
		user.temporarilyRemoveItemFromInventory(src) // Remove the paper

		var/obj/item/paper/manuscript/new_manuscript = new /obj/item/paper/manuscript // Create a new manuscript object
		user.put_in_hands(new_manuscript) // Place the manuscript into the user's hands

		to_chat(user, "<span class='notice'>You have turned the paper into a blank manuscript.</span>")

/obj/item/paper/manuscript/attackby(obj/item/P, mob/living/carbon/human/user, params)
	if(istype(P, /obj/item/natural/feather) && !written)
		// Prompt user to populate manuscript fields
		var/newtitle = dd_limittext(sanitize_hear_message(input(user, "Enter the title of the manuscript:") as text|null), MAX_CHARTER_LEN)
		var/newauthor = dd_limittext(sanitize_hear_message(input(user, "Enter the author's name:") as text|null), MAX_CHARTER_LEN)
		var/newcontent = "<p>[dd_limittext(input(user, "Enter the content of the manuscript:") as text|null, MAX_BOOK_LEN)]</p>"
		var/newcategory = input(user, "Select the category of the manuscript:") in list("Apocrypha & Grimoires", "Myths & Tales", "Legends & Accounts", "Thesis", "Eoratica")
		var/newicon = book_icons[input(user, "Choose a book style", "Book Style") as anything in book_icons]

		if (newtitle && newauthor && newcontent && newcategory)
			name = newtitle
			author = newauthor
			content = newcontent
			category = newcategory
			ckey = user.ckey
			select_icon = newicon
			written = TRUE
			info = parsepencode(content)
			icon_state = "paperwrite"
			to_chat(user, "<span class='notice'>You have successfully written the manuscript.</span>")
		else
			to_chat(user, "<span class='notice'>You must fill out all fields to complete the manuscript.</span>")
		return
	else if(istype(P, /obj/item/natural/feather) && written)
		to_chat(user, "<span class='notice'>The manuscript has already been written.</span>")
		return
	return ..()
