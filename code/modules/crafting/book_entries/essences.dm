/datum/book_entry/essence_crafting
	name = "The Art of Thaumaturgical Essence Combination"

/datum/book_entry/essence_crafting/inner_book_html(mob/user)
	return {"
		<div>
		<h2>Understanding Thaumaturgical Essences</h2>
		Essences are the fundamental building blocks of thaumaturgy. Each essence carries unique properties<br>
		and can be combined with others to create more complex and powerful compounds.<br>
		</div>
		<br>
		<div>
		<h2>Basic Essences (Tier 0)</h2>
		These are the foundation of all thaumaturgical work:<br>
		<br>
		<b>Air Essence</b> - <i>Smells of fresh breeze</i><br>
		<b>Water Essence</b> - <i>Smells of clear streams</i><br>
		<b>Fire Essence</b> - <i>Smells of smoke and ash</i><br>
		<b>Earth Essence</b> - <i>Smells of rich soil</i><br>
		<b>Order Essence</b> - <i>Smells of purity</i><br>
		<b>Chaos Essence</b> - <i>Smells of uncertainty</i><br>
		</div>
		<br>
		<div>
		<h2>First Compound Essences (Tier 1)</h2>
		Created by combining basic essences in specific ratios:<br>
		<br>
		<b>Frost Essence</b> - <i>Smells of winter air</i><br>
		<b>Light Essence</b> - <i>Smells of dawn</i><br>
		<b>Motion Essence</b> - <i>Smells of rushing wind</i><br>
		<b>Cycle Essence</b> - <i>Smells of changing seasons</i><br>
		<b>Energia Essence</b> - <i>Smells of crackling energy</i><br>
		<b>Void Essence</b> - <i>Smells of the abyss</i><br>
		<b>Poison Essence</b> - <i>Smells of death</i><br>
		<b>Life Essence</b> - <i>Smells of blooming flowers</i><br>
		<b>Crystal Essence</b> - <i>Smells of gem dust</i><br>
		</div>
		<br>
		<div>
		<h2>Second Compound Essences (Tier 2)</h2>
		The most complex essences, requiring mastery to create:<br>
		<br>
		<b>Magic Essence</b> - <i>Smells of raw magic</i><br>
		</div>
		<br>
		<div>
		<h2>Thaumaturgical Equipment</h2>
		[icon2html(new /obj/machinery/essence/splitter, user)]<br> <b>Essence Splitter:</b> Used to extract essences from raw materials.<br>
		Add items to the splitter to break them down into their component essences.<br>
		<br>
		[icon2html(new /obj/machinery/essence/combiner, user)]<br> <b>Essence Combiner:</b> Used to combine basic essences into compound essences.<br>
		Load the required essences and the combiner will merge them into more complex forms.<br>
		<br>
		[icon2html(new /obj/machinery/essence/reservoir, user)]<br> <b>Essence Reservoir:</b>Used to store large quantities of essences.<br>
		</div>
		<br>
		<div>
		<h2>Using Thaumaturgical Equipment</h2>
		[icon2html(new /obj/item/essence_connector, user)]<br> Connect other thaumaturgical devices using a thaumic connector for easier essence management.<br>
		<br>
		<b>Extracting Essences:</b> Place raw materials into the essence splitter and activate it.<br>
		The splitter will break down items into their fundamental thaumaturgical essences.<br>
		<br>
		<b>Combining Essences:</b> Load the required essence vials into the combiner in the correct amounts.<br>
		Once all required essences are loaded, activate the combiner to create compound essences.<br>
		<br>
		<b>Storing Essences:</b> Use the reservoir to store large quantities of essences for later use.<br>
		The reservoir can be connected to other equipment for automated essence transfer.<br>
		<br>
		<b>Important:</b> Ensure you have the proper skill level before attempting advanced combinations.<br>
		Tier 1 combinations require Novice skill, while Tier 2 requires Apprentice level or higher.<br>
		</div>
	"}
