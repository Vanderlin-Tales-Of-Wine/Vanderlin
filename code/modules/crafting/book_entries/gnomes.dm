/datum/book_entry/gnome_homunculus
	name = "Working With Gnome Homunculi"

/datum/book_entry/gnome_homunculus/inner_book_html(mob/user)
	return {"
		<div>
		<h2>Introduction to Gnome Homunculi</h2>
		Gnome homunculi are small magical constructs that can be commanded to perform various automated tasks.<br>
		These vile creatures are particularly useful for transportation, alchemy, and agricultural work.<br>
		To give commands to a gnome, you can either speak to them using key phrases or use the command radial menu.<br>
		They also respond to the hum of a Gnome Bell.<br>
		</div>
		<br>
		<div>
		<h2>Basic Commands</h2>
		<b>Follow:</b> Makes the gnome follow you around. Say "follow" or "come here".<br>
		<b>Idle:</b> Makes the gnome stop what it's doing and wait. Say "stop" or "idle".<br>
		<b>Set Waypoint A/B:</b> Point at a location and the gnome will remember it as waypoint A or B.<br>
		These waypoints are essential for transportation and storage tasks.<br>
		</div>
		<br>
		<div>
		<h2>Item Transportation</h2>
		Gnomes can automatically move items between two waypoints you've set.<br>
		<b>Set Filter:</b> Point at an item type you want the gnome to prioritize moving. Say "filter" or "only move".<br>
		<b>Clear Filter:</b> Removes item restrictions. Say "clear filter" or "move all".<br>
		<b>Move Items:</b> Starts automatic transportation between waypoint A and B. Say "move" or "transport".<br>
		Note: You must set both waypoints A and B before starting item transportation.<br>
		</div>
		<br>
		<div>
		<h2>Alchemy Automation</h2>
		Gnomes can automate the entire alchemy process from ingredient gathering to bottle filling.<br>
		<b>Select Recipe:</b> Choose which alchemy recipe the gnome should focus on. Say "recipe" or "alchemy".<br>
		<b>Start Alchemy:</b> Point at a cauldron to begin automated brewing. Say "start alchemy" or "begin brewing".<br>
		Requirements: The gnome needs access to a cauldron, well, and essence machinery within range.<br>
		</div>
		<br>
		<div>
		<h2>Essence Processing</h2>
		<b>Use Splitter:</b> Point at an essence splitter. The gnome will grab items from waypoint A and process them.<br>
		Say "split" or "process" to activate this mode.<br>
		<b>Stop Splitter:</b> Ends the splitter automation process.<br>
		Make sure waypoint A is set near your item source before using this command.<br>
		</div>
		<br>
		<div>
		<h2>Agricultural Work</h2>
		<b>Tend Crops:</b> The gnome will automatically water, harvest, and replant crops in the area.<br>
		Say "tend", "farm", or "crops" to activate this mode.<br>
		The gnome will look for nearby water sources and seed storage automatically.<br>
		</div>
		<br>
		<div>
		<h2>Tips for Effective Use</h2>
		- Always set waypoints before starting transportation tasks<br>
		- Use filters to make gnomes focus on specific item types<br>
		- Ensure required infrastructure (wells, storage, etc.) is nearby before starting automation<br>
		- Multiple gnomes can work together - set different filters for each one<br>
		- Gnomes will prioritize their current task, so stop one mode before starting another<br>
		</div>
	"}
