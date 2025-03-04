/proc/browser_input_text(mob/user, message = "", title = "VANDERLIN", default, max_length = INFINITY, multiline = FALSE, encode = TRUE, timeout = 0)
	if(!user)
		user = usr
	if(!istype(user))
		if(isclient(user))
			var/client/client = user
			user = client.mob
		else
			return null

	if(isnull(user.client))
		return null

	var/datum/browser/modal/input_text/input = new(user, message, title, default, max_length, multiline, encode, timeout)
	input.open()
	input.wait()
	if(input)
		. = input.choice
		qdel(input)

/datum/browser/modal/input_text
	/// If TRUE, this input will encode its choice upon being set.
	var/encode

/datum/browser/modal/input_text/New(mob/user, message, title, default, max_length, multiline, encode, timeout)
	if(!user)
		closed = TRUE
		return

	src.encode = encode

	// JavaScript to make the textarea submit on enter instead of making a newline
	set_head_content({"
	<script type="text/javascript">
		addEventListener("DOMContentLoaded", function(){
			document.getElementById("entry").addEventListener('keydown', function(event){
				if(event.which === 13 && !event.shiftKey){
					const submitButton = document.querySelector("#submitButton");
					submitButton.click();
				}
			})
		});
	</script>
	"})

	var/window_height = multiline ? 300 : 175

	..(user, ckey("[user]-[message]-[title]-[world.time]-[rand(1,10000)]"), title, 350, window_height, src, TRUE, timeout)

	set_content({"
	<form style="display: flex; flex-direction: column; height: 100%;" action="byond://">
		<input type="hidden" name="src" value="[REF(src)]">

		<center><b>[message]</b></center>
		<br/>

		<textarea
			id="entry"
			style="
				overflow-y: auto;
				[multiline ? "flex-grow: [TRUE]" : "height: 1rem"];"
			name="choice"
			maxlength="[max_length]"
			placeholder="WE AWAIT YOUR COMMAND..."
			autofocus></textarea>

		<br/>
		<div style="display: flex; margin-top: auto; justify-content: space-between; text-align: center;">
			<button id="submitButton" type="submit" name="submit" value="[TRUE]">[CHOICE_CONFIRM]</button>
			<button type="submit" name="cancel" value="[TRUE]" formnovalidate>[CHOICE_CANCEL]</button>
		</div>
	</form>
	"})

/datum/browser/modal/input_text/Topic(href, list/href_list)
	. = ..()
	if(href_list["submit"])
		set_choice(href_list["choice"])

	closed = TRUE
	close()

/datum/browser/modal/input_text/set_choice(choice)
	var/processed_choice = encode ? html_encode(choice) : choice
	src.choice = trim(processed_choice)
