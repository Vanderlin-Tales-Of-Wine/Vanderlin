/datum/asset/simple/vv
	assets = list(
		"view_variables.css" = 'html/admin/view_variables.css'
	)

/datum/asset/simple/namespaced/common
	assets = list("padlock.png"	= 'html/padlock.png')
	parents = list("common.css" = 'html/browser/common.css')

/datum/asset/simple/stonekeep_class_menu_slop_layout
	assets = list(
		"try4.png" = 'icons/roguetown/misc/try4.png',
		"try4_border.png" = 'icons/roguetown/misc/try4_border.png',
		"slop_menustyle2.css" = 'html/browser/slop_menustyle2.css',
		"gragstar.gif" = 'icons/roguetown/misc/gragstar.gif'
	)

/datum/asset/simple/stonekeep_triumph_buy_menu_slop_layout
	assets = list(
		"try5.png" = 'icons/roguetown/misc/try5.png',
		"try5_border.png" = 'icons/roguetown/misc/try5_border.png',
		"slop_menustyle3.css" = 'html/browser/slop_menustyle3.css'
	)

/datum/asset/simple/stonekeep_drifter_queue_menu_slop_layout
	assets = list(
		"slop_menustyle4.css" = 'html/browser/slop_menustyle4.css',
	)

/datum/asset/simple/namespaced/roguefonts
	legacy = TRUE
	assets = list(
		"pterra.ttf" = 'interface/fonts/pterra.ttf',
		"chiseld.ttf" = 'interface/fonts/chiseld.ttf',
		"blackmoor.ttf" = 'interface/fonts/blackmoor.ttf',
		"handwrite.ttf" = 'interface/fonts/handwrite.ttf',
		"book1.ttf" = 'interface/fonts/book1.ttf',
		"book2.ttf" = 'interface/fonts/book1.ttf',
		"book3.ttf" = 'interface/fonts/book1.ttf',
		"book4.ttf" = 'interface/fonts/book1.ttf',
		"dwarf.ttf" = 'interface/fonts/languages/dwarf.ttf',
		"elf.ttf" = 'interface/fonts/languages/elf.ttf',
		"oldpsydonic.ttf" = 'interface/fonts/languages/oldpsydonic.ttf',
		"zybantine.ttf" = 'interface/fonts/languages/zybantine.ttf',
		"hell.ttf" = 'interface/fonts/languages/hell.ttf',
		"orc.ttf" = 'interface/fonts/languages/orc.ttf',
		"sand.ttf" = 'interface/fonts/languages/sand.ttf',
		"undead.ttf" = 'interface/fonts/languages/undead.ttf'
	)

//this exists purely to avoid meta by pre-loading all language icons.
/datum/asset/language/register()
	for(var/path in typesof(/datum/language))
		set waitfor = FALSE
		var/datum/language/L = new path ()
		L.get_icon()

/datum/asset/spritesheet/simple/achievements
	name ="achievements"

/datum/asset/simple/permissions
	assets = list(
		"search.js" = 'html/admin/search.js',
		"panels.css" = 'html/admin/panels.css'
	)


/datum/asset/group/permissions
	children = list(
		/datum/asset/simple/permissions,
		/datum/asset/simple/namespaced/common
	)

/datum/asset/simple/notes

/datum/asset/spritesheet/goonchat
	name = "Goonchat"

/datum/asset/group/tgui


/datum/asset/group/statpanel
	children = list(
		/datum/asset/simple/statpanel_images,
		/datum/asset/simple/jquery,
		/datum/asset/simple/namespaced/js_content
	)

/datum/asset/simple/namespaced/js_content
	legacy = TRUE
	assets = list(
		"prototype.js" = 'code/modules/stat_panel/html/js/prototype.js',
		"scriptaculous.js" = 'code/modules/stat_panel/html/js/scriptaculous.js',
		"effects.js" = 'code/modules/stat_panel/html/js/effects.js',
		"controls.js" = 'code/modules/stat_panel/html/js/controls.js',
		"slider.js" = 'code/modules/stat_panel/html/js/slider.js',
		"livepipe.js" = 'code/modules/stat_panel/html/js/livepipe.js',
		"scrollbar.js" = 'code/modules/stat_panel/html/js/scrollbar.js',
	)
	parents = list()

/datum/asset/simple/statpanel_images
	legacy = TRUE
	assets = list(
		"arcanos.png" = 'code/modules/stat_panel/html/images/arcanos.png',
		"button_chrome.png" = 'code/modules/stat_panel/html/images/button_chrome.png',
		"button_note.png" = 'code/modules/stat_panel/html/images/button_note.png',
		"button_options.png" = 'code/modules/stat_panel/html/images/button_options.png',
		"button_pig.png" = 'code/modules/stat_panel/html/images/button_pig.png',
		"cond.ttf" = 'code/modules/stat_panel/html/images/cond.ttf',
		"craft.png" = 'code/modules/stat_panel/html/images/craft.png',
		"cross.png" = 'code/modules/stat_panel/html/images/cross.png',
		"crown.png" = 'code/modules/stat_panel/html/images/crown.png',
		"dead.png" = 'code/modules/stat_panel/html/images/dead.png',
		"emotes.png" = 'code/modules/stat_panel/html/images/emotes.png',
		"fangs.png" = 'code/modules/stat_panel/html/images/fangs.png',
		"gpc.png" = 'code/modules/stat_panel/html/images/gpc.png',
		"heart.png" = 'code/modules/stat_panel/html/images/heart.png',
		"Panel.png" = 'code/modules/stat_panel/html/images/Panel.png',
		"plot.png" = 'code/modules/stat_panel/html/images/plot.png',
		"pointer.cur" = 'code/modules/stat_panel/html/images/pointer.cur',
		"stats.png" = 'code/modules/stat_panel/html/images/stats.png',
		"stats1.png" = 'code/modules/stat_panel/html/images/stats1.png',
		"thanati.png" = 'code/modules/stat_panel/html/images/thanati.png',
		"verbs.png" = 'code/modules/stat_panel/html/images/verbs.png',
		"villain.png" = 'code/modules/stat_panel/html/images/villain.png',
		"uibutton.ogg" = 'code/modules/stat_panel/html/images/uibutton.ogg',
	)

/datum/asset/group/goonchat
	children = list(
		/datum/asset/simple/jquery,
		/datum/asset/simple/purify,
		/datum/asset/simple/namespaced/goonchat,
		/datum/asset/spritesheet/goonchat,
		/datum/asset/simple/goonchat_images,
		/datum/asset/simple/namespaced/js_content,
		/datum/asset/simple/namespaced/fontawesome,
		/datum/asset/simple/namespaced/roguefonts
	)

/datum/asset/simple/goonchat_images
	legacy = TRUE
	assets = list(
		"chatbg.png"            			= 'code/modules/goonchat/browserassets/images/chatbg.png',
		"chatscrollbar-bg.png"				= 'code/modules/goonchat/browserassets/images/chatscrollbar-bg.png',
		"chatscrollbar-scrolldown.png"		= 'code/modules/goonchat/browserassets/images/chatscrollbar-scrolldown.png',
		"chatscrollbar-scrollup.png"		= 'code/modules/goonchat/browserassets/images/chatscrollbar-scrollup.png',
		"chatscroller-b.png"				= 'code/modules/goonchat/browserassets/images/chatscroller-b.png',
		"chatscroller-m.png"				= 'code/modules/goonchat/browserassets/images/chatscroller-m.png',
		"chatscroller-t.png"				= 'code/modules/goonchat/browserassets/images/chatscroller-t.png',
		"chatshadow.png"					= 'code/modules/goonchat/browserassets/images/chatshadow.png',
		"helpbg.png"						= 'code/modules/goonchat/browserassets/images/helpbg.png'
	)



/datum/asset/simple/purify
	legacy = TRUE
	assets = list(
		"purify.min.js"            = 'code/modules/goonchat/browserassets/js/purify.min.js',
	)

/datum/asset/simple/jquery
	legacy = TRUE
	assets = list(
		"jquery.min.js"            = 'code/modules/goonchat/browserassets/js/jquery.min.js',
	)

/datum/asset/simple/namespaced/goonchat
	legacy = TRUE
	assets = list(
		"json2.min.js"             = 'code/modules/goonchat/browserassets/js/json2.min.js',
		"errorHandler.js"             = 'code/modules/goonchat/browserassets/js/errorHandler.js',
		"browserOutput.js"         = 'code/modules/goonchat/browserassets/js/browserOutput.js',
		"scrollbar_chat.js"             = 'code/modules/goonchat/browserassets/js/scrollbar_chat.js',
		"browserOutput.css"	       = 'code/modules/goonchat/browserassets/css/browserOutput.css'
	)
	parents = list()

/datum/asset/simple/namespaced/fontawesome
	legacy = TRUE
	assets = list(
		"fa-regular-400.eot"  = 'html/font-awesome/webfonts/fa-regular-400.eot',
		"fa-regular-400.woff" = 'html/font-awesome/webfonts/fa-regular-400.woff',
		"fa-solid-900.eot"    = 'html/font-awesome/webfonts/fa-solid-900.eot',
		"fa-solid-900.woff"   = 'html/font-awesome/webfonts/fa-solid-900.woff',
		"font-awesome.css"    = 'html/font-awesome/css/all.min.css',
		//"v4shim.css"          = 'html/font-awesome/css/v4-shims.min.css'
	)
	parents = list("font-awesome.css" = 'html/font-awesome/css/all.min.css')
