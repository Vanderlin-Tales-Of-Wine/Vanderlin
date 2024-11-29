#ifdef TESTING
/mob/living/carbon/key_down(_key, client/user)
	switch(_key)
		if("B")
			client.toggle_context_menu()
	return ..()
#endif
