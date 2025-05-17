/datum/book_entry/container_craft
	name = "Cooking With Pots and Pans"

/datum/book_entry/container_craft/inner_book_html(mob/user)
	return {"
		<div>
		<h2>How to cook with storage containers</h2>
		In order to cook with containers like ovens, pans, and pots first you need to open their storage.<br>
		This is done by dragging the container onto you if its on the ground or using it in your hand. <br>
		</div>
		<br>

		<div>
		<h2> How to start a recipe </h2>
		Starting a recipe is done simply by closing the storage interface after putting the items you want in,<br>
		its done this way to stop the game from starting a recipe before you have your toppings and other things ready.<br>
		<br>
		If the storage container is closed when you try to insert an item it will try to start a recipe at the time of insertion. <br>
		Cooking time is increased based on the amount of the item your cooking at once, so 10 dough is going to take <br>
		longer then 4 dough to make.
		</div>

	"}
