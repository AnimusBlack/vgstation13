./sound/turntable/test
	file = 'TestLoop1.ogg'
	falloff = 2
	repeat = 1

/mob/var/music = 0

/obj/machinery/party/turntable
	name = "Jukebox"
	desc = "A jukebox is a partially automated music-playing device, usually a coin-operated machine, that will play a patron's selection from self-contained media."
	icon = 'ss13_dark_alpha7_old.dmi'
	icon_state = "Jukeboxalt"
	var/playing = 0
	anchored = 1
	density = 1
	var/list/songs = list ("Jawa Bar"='Cantina.ogg',
		"Lonely Assistant Blues"='AGrainOfSandInSandwich.ogg',
		"Chinatown"='chinatown.ogg',
		"Wade In The Water"='WadeInTheWater.ogg',
		"Blue Theme"='BlueTheme.ogg',
		"Beyond The Sea"='BeyondTheSea.ogg',
		"The Assassination of Jesse James"='TheAssassinationOfJesseJames.ogg',
		"Everyone Has Their Vices"='EveryoneHasTheirVices.ogg',
		"The Way You Look Tonight"='TheWayYouLookTonight.ogg',
		"They Were All Dead"='TheyWereAllDead.ogg',
		"Onizukas Blues"='OnizukasBlues.ogg',
		"Ragtime Piano"='TheEntertainer.ogg',
		"It Had To Be You"='ItHadToBeYou.ogg',
		"Janitorial Blues"='KyouWaYuuhiYarou.ogg',
		"Lujon"='Lujon.ogg',
		"Another Day's Work"='AnotherDaysWork.ogg',
		"Razor Walker"='RazorWalker.ogg',
		"Mute Beat"='MuteBeat.ogg',
		"Groovy Times"='GroovyTime.ogg',
		"Under My Skin"='IveGotYouUnderMySkin.ogg',
		"That`s All"='ThatsAll.ogg',
		"The Folks On The Hill"='TheFolksWhoLiveOnTheHill.ogg')


/obj/machinery/party/mixer
	name = "mixer"
	desc = "A mixing board for mixing music"
	icon = 'ss13_dark_alpha7_old.dmi'
	icon_state = "mixer"
	density = 0
	anchored = 1


<<<<<<< HEAD
/obj/machinery/party/turntable/New()
=======
	var/list/playlist
	var/current_song  = 0 // 0, or whatever song is currently playing.
	var/next_song     = 0 // 0, or a song someone has purchased.  Played after current song completes.
	var/selected_song = 0 // 0 or the song someone has selected for purchase
	var/autoplay      = 0 // Start playing after spawn?
	var/last_reload   = 0 // Reload cooldown.
	var/last_song     = 0 // ID of previous song (used in shuffle to prevent double-plays)

	var/screen = JUKEBOX_SCREEN_MAIN

	var/credits_held   = 0 // Cash currently held
	var/credits_needed = 0 // Credits needed to complete purchase.
	var/change_cost    = 10 // Current cost to change songs.
	var/list/change_access  = list() // Access required to change songs
	var/datum/money_account/linked_account
	var/department // Department that gets the money

	var/state_base = "jukebox2"

	machine_flags = WRENCHMOVE | FIXED2WORK | EMAGGABLE

/obj/machinery/media/jukebox/New(loc)
	..(loc)
	if(department)
		linked_account = department_accounts[department]
	else
		linked_account = station_account

/obj/machinery/media/jukebox/attack_ai(var/mob/user)
	attack_hand(user)

/obj/machinery/media/jukebox/attack_paw()
	return

/obj/machinery/media/jukebox/power_change()
>>>>>>> 22e12f737f6244af397a4e9c0c10fbaa9b5eab11
	..()
	sleep(2)
	new /sound/turntable/test(src)
	return

/obj/machinery/party/turntable/attack_paw(user as mob)
	return src.attack_hand(user)

/obj/machinery/party/turntable/attack_hand(mob/living/user as mob)
	if (..())
		return
	usr.set_machine(src)
	src.add_fingerprint(usr)

	var/t = "<body background=turntable.png ><br><br><br><br><br><br><br><br><br><br><br><br><div align='center'>"
	t += "<A href='?src=\ref[src];off=1'><font color='maroon'>T</font><font color='geen'>urn</font> <font color='red'>Off</font></A>"
	t += "<table border='0' height='25' width='300'><tr>"

	for (var/i = 1, i<=(songs.len), i++)
		var/check = i%2
		t += "<td><A href='?src=\ref[src];on=[i]'><font color='maroon'>[copytext(songs[i],1,2)]</font><font color='purple'>[copytext(songs[i],2)]</font></A></td>"
		if(!check) t += "</tr><tr>"

	t += "</tr></table></div></body>"
	user << browse(t, "window=turntable;size=500x636;can_resize=0")
	onclose(user, "urntable")
	return

<<<<<<< HEAD
/obj/machinery/party/turntable/Topic(href, href_list)
	..()
	if( href_list["on"])
		if(src.playing == 0)
			//world << "Should be working..."
			var/sound/S
			S = sound(songs[songs[text2num(href_list["on"])]])
			S.repeat = 1
			S.channel = 10
			S.falloff = 2
			S.wait = 1
			S.environment = 0

			var/area/A = src.loc.loc:master

			for(var/area/RA in A.related)
				for(var/obj/machinery/party/lasermachine/L in RA)
					L.turnon()
			playing = 1
			while(playing == 1)
				for(var/mob/M in world)
					var/area/location = get_area(M)
					if((location in A.related) && M.music == 0)
						//world << "Found the song..."
						M << S
						M.music = 1
					else if(!(location in A.related) && M.music == 1)
						var/sound/Soff = sound(null)
						Soff.channel = 10
						M << Soff
						M.music = 0
				sleep(10)
=======
/obj/machinery/media/jukebox/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/device/multitool))
		update_multitool_menu(user)
		return 1
	..()
	if(istype(W,/obj/item/weapon/card/id))
		if(!selected_song || screen!=JUKEBOX_SCREEN_PAYMENT)
			visible_message("\blue The machine buzzes.","\red You hear a buzz.")
			return
		var/obj/item/weapon/card/id/I = W
		if(!linked_account)
			visible_message("\red The machine buzzes, and flashes \"NO LINKED ACCOUNT\" on the screen.","You hear a buzz.")
			return
		var/datum/money_account/acct = get_card_account(I)
		if(!acct)
			visible_message("\red The machine buzzes, and flashes \"NO ACCOUNT\" on the screen.","You hear a buzz.")
			return
		if(credits_needed > acct.money)
			visible_message("\red The machine buzzes, and flashes \"NOT ENOUGH FUNDS\" on the screen.","You hear a buzz.")
			return
		visible_message("\blue The machine beeps happily.","You hear a beep.")
		acct.charge(credits_needed,linked_account,"Song selection at [areaMaster.name]'s [name].")
		credits_needed = 0

		successful_purchase()

		attack_hand(user)
	else if(istype(W,/obj/item/weapon/spacecash))
		if(!selected_song || screen!=JUKEBOX_SCREEN_PAYMENT)
			visible_message("\blue The machine buzzes.","\red You hear a buzz.")
			return
		if(!linked_account)
			visible_message("\red The machine buzzes, and flashes \"NO LINKED ACCOUNT\" on the screen.","You hear a buzz.")
>>>>>>> 22e12f737f6244af397a4e9c0c10fbaa9b5eab11
			return

	if( href_list["off"] )
		if(src.playing == 1)
			var/sound/S = sound(null)
			S.channel = 10
			S.wait = 1
			for(var/mob/M in world)
				M << S
				M.music = 0
			playing = 0
			var/area/A = src.loc.loc:master
			for(var/area/RA in A.related)
				for(var/obj/machinery/party/lasermachine/L in RA)
					L.turnoff()


/obj/machinery/party/lasermachine
	name = "laser machine"
	desc = "A laser machine that shoots lasers."
	icon = 'ss13_dark_alpha7_old.dmi'
	icon_state = "lasermachine"
	anchored = 1
	var/mirrored = 0

<<<<<<< HEAD
/obj/effects/laser
	name = "laser"
	desc = "A laser..."
	icon = 'ss13_dark_alpha7_old.dmi'
	icon_state = "laserred1"
	anchored = 1
	layer = 4
=======
/obj/machinery/media/jukebox/emag(mob/user)
	current_song = 0
	if(!emagged)
		playlist_id = "emagged"
		last_reload=world.time
		playlist=null
		loop_mode = JUKEMODE_SHUFFLE
		emagged = 1
		playing = 1
		user.visible_message("\red [user.name] slides something into the [src.name]'s card-reader.","\red You short out the [src.name].")
		update_icon()
		update_music()
		return 1
	return

/obj/machinery/media/jukebox/wrenchAnchor(mob/user)
	if(..())
		playing = emagged
		update_music()
		update_icon()

/obj/machinery/media/jukebox/proc/successful_purchase()
		next_song = selected_song
		selected_song = 0
		screen = JUKEBOX_SCREEN_MAIN
>>>>>>> 22e12f737f6244af397a4e9c0c10fbaa9b5eab11

/obj/item/lasermachine/New()
	..()

/obj/machinery/party/lasermachine/proc/turnon()
	var/wall = 0
	var/cycle = 1
	var/area/A = get_area(src)
	var/X = 1
	var/Y = 0
	if(mirrored == 0)
		while(wall == 0)
			if(cycle == 1)
				var/obj/effects/laser/F = new/obj/effects/laser(src)
				F.x = src.x+X
				F.y = src.y+Y
				F.z = src.z
				F.icon_state = "laserred1"
				var/area/AA = get_area(F)
				var/turf/T = get_turf(F)
				if(T.density == 1 || AA.name != A.name)
					del(F)
					return
				cycle++
				if(cycle > 3)
					cycle = 1
				X++
			if(cycle == 2)
				var/obj/effects/laser/F = new/obj/effects/laser(src)
				F.x = src.x+X
				F.y = src.y+Y
				F.z = src.z
				F.icon_state = "laserred2"
				var/area/AA = get_area(F)
				var/turf/T = get_turf(F)
				if(T.density == 1 || AA.name != A.name)
					del(F)
					return
				cycle++
				if(cycle > 3)
					cycle = 1
				Y++
			if(cycle == 3)
				var/obj/effects/laser/F = new/obj/effects/laser(src)
				F.x = src.x+X
				F.y = src.y+Y
				F.z = src.z
				F.icon_state = "laserred3"
				var/area/AA = get_area(F)
				var/turf/T = get_turf(F)
				if(T.density == 1 || AA.name != A.name)
					del(F)
					return
				cycle++
				if(cycle > 3)
					cycle = 1
				X++
	if(mirrored == 1)
		while(wall == 0)
			if(cycle == 1)
				var/obj/effects/laser/F = new/obj/effects/laser(src)
				F.x = src.x+X
				F.y = src.y-Y
				F.z = src.z
				F.icon_state = "laserred1m"
				var/area/AA = get_area(F)
				var/turf/T = get_turf(F)
				if(T.density == 1 || AA.name != A.name)
					del(F)
					return
				cycle++
				if(cycle > 3)
					cycle = 1
				Y++
			if(cycle == 2)
				var/obj/effects/laser/F = new/obj/effects/laser(src)
				F.x = src.x+X
				F.y = src.y-Y
				F.z = src.z
				F.icon_state = "laserred2m"
				var/area/AA = get_area(F)
				var/turf/T = get_turf(F)
				if(T.density == 1 || AA.name != A.name)
					del(F)
					return
				cycle++
				if(cycle > 3)
					cycle = 1
				X++
			if(cycle == 3)
				var/obj/effects/laser/F = new/obj/effects/laser(src)
				F.x = src.x+X
				F.y = src.y-Y
				F.z = src.z
				F.icon_state = "laserred3m"
				var/area/AA = get_area(F)
				var/turf/T = get_turf(F)
				if(T.density == 1 || AA.name != A.name)
					del(F)
					return
				cycle++
				if(cycle > 3)
					cycle = 1
				X++

<<<<<<< HEAD
=======
				change_cost = max(0,text2num(href_list["set_change_cost"]))
				linked_account = new_linked_account
				if("lock" in href_list && href_list["lock"] != "")
					change_access = list(text2num(href_list["lock"]))
				else
					change_access = list()

				screen=POS_SCREEN_SETTINGS

	if (href_list["playlist"])
		if(!check_reload())
			usr << "\red You must wait 60 seconds between playlist reloads."
			return
		playlist_id=href_list["playlist"]
		last_reload=world.time
		playlist=null
		current_song = 0
		next_song = 0
		selected_song = 0
		update_music()
		update_icon()

	if (href_list["song"])
		selected_song=Clamp(text2num(href_list["song"]),1,playlist.len)
		if(!change_cost)
			next_song = selected_song
			selected_song = 0
			if(!current_song)
				update_music()
				update_icon()
		else
			usr << "\red Swipe card or insert $[num2septext(change_cost)] to set this song."
			screen = JUKEBOX_SCREEN_PAYMENT
			credits_needed=change_cost

	if (href_list["cancelbuy"])
		selected_song=0
		screen = JUKEBOX_SCREEN_MAIN

	if (href_list["mode"])
		loop_mode = (loop_mode % JUKEMODE_COUNT) + 1

	return attack_hand(usr)

/obj/machinery/media/jukebox/process()
	if(!playlist)
		var/url="[config.media_base_url]/index.php?playlist=[playlist_id]"
		testing("[src] - Updating playlist from [url]...")

		//  Media Server 2 requires a secret key in order to tell the jukebox
		// where the music files are. It's set in config with MEDIA_SECRET_KEY
		// and MUST be the same as the media server's.
		//
		//  Do NOT log this, it's like a password.
		if(config.media_secret_key!="")
			url += "&key=[config.media_secret_key]"

		var/response = world.Export(url)
		playlist=list()
		if(response)
			var/json = file2text(response["CONTENT"])
			if("/>" in json)
				visible_message("<span class='warning'>\icon[src] \The [src] buzzes, unable to update its playlist.</span>","<em>You hear a buzz.</em>")
				stat &= BROKEN
				update_icon()
				return
			var/json_reader/reader = new()
			reader.tokens = reader.ScanJson(json)
			reader.i = 1
			var/songdata = reader.read_value()
			for(var/list/record in songdata)
				playlist += new /datum/song_info(record)
			if(playlist.len==0)
				visible_message("<span class='warning'>\icon[src] \The [src] buzzes, unable to update its playlist.</span>","<em>You hear a buzz.</em>")
				stat &= BROKEN
				update_icon()
				return
			visible_message("<span class='notice'>\icon[src] \The [src] beeps, and the menu on its front fills with [playlist.len] items.</span>","<em>You hear a beep.</em>")
			if(autoplay)
				playing=1
				autoplay=0
		else
			testing("[src] failed to update playlist: Response null.")
			stat &= BROKEN
			update_icon()
			return
	if(playing)
		var/datum/song_info/song
		if(current_song)
			song = playlist[current_song]
		if(!current_song || (song && world.time >= media_start_time + song.length))
			current_song=1
			if(next_song)
				current_song = next_song
				next_song = 0
			else
				switch(loop_mode)
					if(JUKEMODE_SHUFFLE)
						while(1)
							current_song=rand(1,playlist.len)
							if(current_song!=last_song || playlist.len<4)
								break
					if(JUKEMODE_REPEAT_SONG)
						current_song=current_song
					if(JUKEMODE_PLAY_ONCE)
						playing=0
						update_icon()
						return
			update_music()

/obj/machinery/media/jukebox/update_music()
	if(current_song && playing)
		var/datum/song_info/song = playlist[current_song]
		media_url = song.url
		last_song = current_song
		media_start_time = world.time
		visible_message("<span class='notice'>\icon[src] \The [src] begins to play [song.display()].</span>","<em>You hear music.</em>")
		//visible_message("<span class='notice'>\icon[src] \The [src] warbles: [song.length/10]s @ [song.url]</notice>")
	else
		media_url=""
		media_start_time = 0
	..()

/obj/machinery/media/jukebox/proc/stop_playing()
	//current_song=0
	playing=0
	update_music()
	return

/obj/machinery/media/jukebox/bar
	department = "Civilian"
	req_access = list(access_bar)

	playlist_id="bar"
	// Must be defined on your server.
	playlists=list(
		"bar"  = "Bar Mix",
		"jazz" = "Jazz",
		"rock" = "Rock"
	)

// Relaxing elevator music~
/obj/machinery/media/jukebox/dj

	playlist_id="muzak"
	autoplay = 1
	change_cost = 0

	id_tag="DJ Satellite" // For autolink

	// Must be defined on your server.
	playlists=list(
		"bar"  = "Bar Mix",
		"jazz" = "Jazz",
		"rock" = "Rock",
		"muzak" = "Muzak"
	)
>>>>>>> 22e12f737f6244af397a4e9c0c10fbaa9b5eab11

/obj/machinery/party/lasermachine/proc/turnoff()
	var/area/A = src.loc.loc
	for(var/area/RA in A.related)
		for(var/obj/effects/laser/F in RA)
			del(F)


/obj/machinery/party/gramophone
	name = "Gramophone"
	desc = "Old-time styley."
	icon = 'icons/obj/musician.dmi'
	icon_state = "gramophone"
	var/playing = 0
	anchored = 1
	density = 1

/obj/machinery/party/gramophone/attack_paw(user as mob)
	return src.attack_hand(user)

/obj/machinery/party/gramophone/attack_hand(mob/living/user as mob)

	if (src.playing == 0)

		var/sound/S
		S = sound(pick('Taintedlove.ogg','Soviet.ogg'))
		S.repeat = 1
		S.channel = 10
		S.falloff = 2
		S.wait = 1
		S.environment = 0
		var/area/A = src.loc.loc:master

		for(var/area/RA in A.related)
			playing = 1
			while(playing == 1)
				for(var/mob/M in world)
					if((M.loc.loc in A.related) && M.music == 0)
						M << S
						M.music = 1
					else if(!(M.loc.loc in A.related) && M.music == 1)
						var/sound/Soff = sound(null)
						Soff.channel = 10
						M << Soff
						M.music = 0
				sleep(10)
			return

	else
		(src.playing) = 0
		var/sound/S = sound(null)
		S.channel = 10
		S.wait = 1
		for(var/mob/M in world)
			M << S
			M.music = 0
		playing = 0
		var/area/A = src.loc.loc:master
		for(var/area/RA in A.related)
