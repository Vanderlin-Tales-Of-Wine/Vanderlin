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
	var/obj/item/output_item // Variable to store the prFliinted item

	var/static/list/manuel_name_to_path = list()

/obj/machinery/printingpress/attackby(obj/item/O, mob/user, params)
	if(printing)
		to_chat(user, span_warning("[src] is currently printing. Please wait."))
		return
	if(output_item)
		to_chat(user, span_notice("Please retrieve the printed 5item before inserting new items."))
		return
	if(istype(O, /obj/item/canvas))
		var/obj/item/canvas/M = O
		if(!M.author || !M.title)
			to_chat(user, span_notice("This canvas isn't signed."))
			return
		// Prompt the user to upload the manuscript
		var/choice = input(user, "Do you want to add the painting to the archive?") in list("Yes", "No")
		if(choice == "Yes")
			upload_painting(user, M)
			to_chat(user, span_notice("The painting has been uploaded."))
		else
			to_chat(user, span_notice("You decide not to upload the painting."))
		return

	if(istype(O, /obj/item/manuscript))
		var/obj/item/manuscript/M = O
		if(!M.written)
			to_chat(user, span_notice("This manuscript is blank. You need to write something before uploading it."))
			return
		// Prompt the user to upload the manuscript
		var/choice = input(user, "Do you want to add the manuscript to the archive?") in list("Yes", "No")
		if(choice == "Yes")
			upload_manuscript(user, M)
			// // Optionally delete the manuscript after uploading
			// qdel(M)
			to_chat(user, span_notice("The manuscript has been uploaded."))
		else
			to_chat(user, span_notice("You decide not to upload the manuscript."))
		return
	if(istype(O, /obj/item/paper) && !has_paper)
		var/obj/item/paper/paper = O
		if(paper.info)
			to_chat(user, span_warning("The paper needs to be blank to be put into [src]."))
			return
		has_paper = TRUE
		loaded_paper = O
		src.icon_state = "Ppress_Prepared"
		to_chat(user, span_warning("You insert the blank paper into [src]."))
		qdel(O)
	return ..()

/obj/machinery/printingpress/attack_hand(mob/user)
	if(printing)
		to_chat(user, span_warning("[src] is currently printing. Please wait."))
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
		to_chat(user, span_warning("You retrieve [P.name] from [src]."))
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
	var/choice = input(user, "Choose an option for \the [src]") as null|anything in list("Print The Book", "Print a Tome of Justice", "Print from the Archive", "Profession Manuel")
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

/obj/machinery/printingpress/proc/upload_manuscript(mob/user, obj/item/manuscript/M)
	SSlibrarian.playerbook2file(M.compiled_pages, M.name, M.author, M.ckey, M.select_icon)
	SSlibrarian.update_books()

/obj/machinery/printingpress/proc/upload_painting(mob/user, obj/item/canvas/M)
	M.upload_painting()

/obj/machinery/printingpress/proc/print_bibble(mob/user)
	// Creates a static book (Bibble)
	var/obj/item/book/rogue/bibble/B = new()
	output_item = B
	visible_message("<span class='notice'>The printing press hums as it produces [B.name].</span>")

/obj/machinery/printingpress/proc/print_justice(mob/user)
	// Creates a static book (Tome of Justice)
	var/obj/item/book/rogue/law/B = new()
	output_item = B
	visible_message("<span class='notice'>[src] hums as it produces [B.name].</span>")

/obj/machinery/printingpress/proc/print_manuscript(mob/user, id)
	output_item = new /obj/item/book/rogue/playerbook(src, null, null, null, id)

/obj/machinery/printingpress/proc/choose_search_parameters(mob/user)
	var/search_title = input(user, "Enter the title (optional):") as text|null
	var/search_author = input(user, "Enter the author (optional):") as text|null
	var/search_category = input(user, "Select a category (optional):") in list("Any", "Myths & Tales", "Legends & Accounts", "Thesis", "Eoratica") // Removed "Apocrypha & Grimoires"
	// Pass the selected parameters to search_manuscripts
	search_manuscripts(user, search_title, search_author, search_category)

/obj/machinery/printingpress/proc/search_manuscripts(mob/user, search_title, search_author, search_category)
	var/list/books = list()

	books |= SSlibrarian.get_books(search_title, search_author, search_category)
	var/dat = "<h3>Manuscript Search Results:</h3><br>"
	dat += "<table><tr><th>Author</th><th>Title</th><th>Category</th><th>Print</th></tr>"
	var/list/decoded_books = SSlibrarian.pull_player_book_titles()
	var/index = 0
	for(var/list/book in books)
		index++
		dat += "<tr><td>[book["author"]]</td><td>[book["book_title"]]</td><td>[book["category"]]</td><td><a href='byond://?src=[REF(src)];print=1;id=[decoded_books[index]]'>Print</a></td></tr>"
	if (!length(books))
		dat += "<tr><td colspan='4'>No results found.</td></tr>"

	dat += "</table>"
	user << browse(dat, "window=search_results")


/obj/machinery/printingpress/Topic(href, href_list)
	if(printing)
		return // Ignore interactions while printing
	if("print" in href_list)
		var/id = url_encode(href_list["id"])
		start_printing(usr, "archive", id)

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

		var/obj/item/manuscript/new_manuscript = new /obj/item/manuscript // Create a new manuscript object
		user.put_in_hands(new_manuscript) // Place the manuscript into the user's hands

		to_chat(user, "<span class='notice'>You have turned the paper into a blank manuscript.</span>")
