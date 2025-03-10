/// The default command report announcement sound.
#define DEFAULT_ANNOUNCEMENT_SOUND "default_announcement"

/// Verb to change the global command name.
/client/proc/cmd_change_command_name()
	set category = "Special Verbs"
	set name = "Change Command Name"

	if(!check_rights(R_ADMIN))
		return

	var/input = input(usr, "Please input a new name for priority announcements.", "What?", "") as text|null
	if(!input)
		return
	change_command_name(input)
	message_admins("[key_name_admin(src)] has changed the priority announcement name to [input]")
	log_admin("[key_name(src)] has changed the priority announcement name to: [input]")

/// Verb to open the create command report window and send command reports.
/client/proc/cmd_admin_create_centcom_report()
	set category = "Special Verbs"
	set name = "Create Command Report"

	if(!check_rights(R_ADMIN))
		return

	SSblackbox.record_feedback("tally", "admin_verb", 1, "Create Command Report") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	new /datum/command_report_menu(usr)

/// Datum for holding the TGUI window for command reports.
/datum/command_report_menu
	/// The mob using the UI.
	var/mob/ui_user
	/// The browser datum that holds the UI.
	var/datum/browser/noclose/ui
	/// The name of central command that will accompany our report
	var/command_name
	/// The actual contents of the report we're going to send.
	var/command_report_content
	/// If the message will be HTML encoded or not
	var/encode_report = TRUE
	/// The sound that's going to accompany our message.
	var/played_sound = DEFAULT_ANNOUNCEMENT_SOUND

/datum/command_report_menu/New(mob/user)
	ui_user = user
	ui = new(ui_user, "command_report", "<center>SPEAK FROM THE HEAVENS</center>", 400, 450, src)
	ui.set_head_content({"
		<style>
			body {
				text-align: center;
				align-children: center;
				justify-children: center;
			}

			input\[type="text"\]{
				width: 60%;
				text-align: center;
			}

			textarea {
				width: 80%;
				resize: none;
			}

			select {
				display: box;
			}
		</style>
	"})

	build_ui(user)

/datum/command_report_menu/Destroy(force, ...)
	ui.close()
	qdel(ui)
	return ..()

/datum/command_report_menu/proc/build_ui(mob/user)
	var/content = \
	{"<form action="byond://">
		<input type="hidden" name="src" value=[REF(src)]>

		<div>
			<h2>Announcement Name</h2>
			<input type="text" name="title" value="[command_name || "The Gods Decree"]" required/>
		</div>

		<div>
			<h2>Announcement Text</h2>
			<textarea name="body" rows=[8] required>[command_report_content]</textarea>
		</div>

		<div>
			<h2>Announcement Sound</h2>
			<select name="sound">
				<option value="['sound/misc/alert.ogg']">Decree</option>
				<option value="['sound/misc/bell.ogg']" selected>Bell</option>
				<option value="['sound/misc/lawdeclaration.ogg']">Law Declaration</option>
				<option value="['sound/misc/evilevent.ogg']">Bad Omen</option>
			</select>
		</div>

		<br>

		<div>
			<input type="checkbox" name="encode" value=[TRUE] [NULLABLE(encode_report) && "checked"]/>
			<label>Encode body</label>
		</div>

		<div>
			<input type="submit" value="Send Announcement"/>
		</div>
	</form>"}

	ui.set_content(content)
	ui.open()

/datum/command_report_menu/Topic(href, list/href_list)
	. = ..()
	if(ui_user != usr)
		return

	if(href_list["close"])
		qdel(src)
		return

	if(!check_rights(R_ADMIN|R_FUN))
		return

	command_name = href_list["title"]
	command_report_content = href_list["body"]
	encode_report = text2num(href_list["encode"]) || FALSE
	played_sound = fexists(href_list["sound"]) && file(href_list["sound"])

	send_announcement()
	build_ui(usr)


/**
 * The actual proc that sends the priority announcement and reports
 *
 * Uses the variables set by the user on our datum as the arguments for the report.
 **/
/datum/command_report_menu/proc/send_announcement()
	priority_announce(command_report_content, command_name, played_sound, encode_title = encode_report, encode_text = encode_report)

	log_admin("[key_name(ui_user)] has created a command report: \"[command_report_content]\", sent from \"[command_name]\" with the sound \"[played_sound]\".")
	message_admins("[key_name_admin(ui_user)] has created a command report, sent from \"[command_name]\" with the sound \"[played_sound]\"")

	command_report_content = initial(command_report_content)

#undef DEFAULT_ANNOUNCEMENT_SOUND

#undef NULLABLE
