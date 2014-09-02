////////////////////////////////////OBJECTS////////////////////////////////////////

/obj/item/weapon/paper/elegrad_longroad
	name = "paper- 'A note.'"
	info = "Я иду уже достаточно долго.. Подозреваю, что снайпер на одной из этих драных крыш, не должен медлить, не должен.."

/obj/item/weapon/paper/elegrad_longroad/shaft
	name = "paper- 'A note.'"
	info = "Алмазы.. ха-ха! МНОГО! МНОГО ЧЕРТВОВЫХ АЛМАЗОВ, но Я СЛОМАЛ СЕБЕ ЧЕРТОВЫ НОГИ, УПАВ В ЭТУ ЕБАНУЮ ШАХТУ ЕБАНОГО ЛИФТА! Бог, помоги мне, помоги мне ВЫБРАТЬСЯ ОТСЮДА, НЕ НУЖНО МНЕ ЭТО ГРЕБАНОЕ БОГАТСТВО, Я.. Я просто хочу домой.. К жене, сыну.. Пожалуйста.."

/obj/item/weapon/paper/elegrad_longroad/rooftop
	name = "paper- 'A note.'"
	info = "День шестой. Калибровка врат идет медленно или не идет вовсе, и еды всё меньше. Я устала, задолбалась ждать, глаза побаливают от прицела винтовки. Нужна смена обстановки, сложу 'Альму' и перелезу на крышу где-нибудь на юге."

/obj/item/clothing/mask/eneck
	desc = "Something is wrong with their access system, huh?."
	name = "Strange necklace"
	icon_state = "breathdown"
	item_state = "breathdown2"
	flags = FPRINT | TABLEPASS
	w_class = 2
	var/activated = 0
	equipped(var/mob/user, var/slot)
		if (slot == slot_wear_mask)
			canremove = 0
			user << "\red That was a bad idea.."
			activated = 0
			process(user)
		..()

	process(var/mob/affected)
		var/turf/T = get_turf(affected)
		playsound(T, 'sound/machines/twobeep.ogg',30,0,1)
		if(!activated && istype(T.loc, /area/Elegrad/complex))
			activated = 1
		if(!istype(T.loc, /area/Elegrad/complex) && activated)
			var/mob/living/carbon/human/M = affected
			var/datum/organ/external/E = M.get_organ("head")
			M.color = "#AAAAAA"
			playsound(T, 'sound/weapons/bladeslice.ogg',80,0)
			E.droplimb(1)
			return
		spawn(50) .()

////////////////////////////////////DECORATES///////////////////////////////////////

/turf/unsimulated/floor/decorate
	name = "floor"
	icon = 'icons/Elegrad/Elegrad.dmi'
	icon_state = "0,5"

/turf/unsimulated/floor/decorate/alt
	name = "floor"
	icon = 'icons/Elegrad/Elegrad_alt.dmi'
	icon_state = "0,5"

/turf/unsimulated/floor/decorate_road
	name = "floor"
	icon = 'icons/Elegrad/Elegrad_roads.dmi'
	icon_state = "0,0"

/obj/structure/elegrad_sky
	desc = "A sky."
	name = "sky"
	icon = 'icons/Elegrad/elegrad_sky.dmi'
	icon_state = "sky"
	density = 0
	anchored = 1.0
	layer = 2.1
	color = "#999999"

/obj/machinery/door/poddoor/elegrad_doors
	name = "Blastdoor"
	desc = "Why it no open!!!"
	icon = 'icons/obj/doors/rapid_pdoor.dmi'
	icon_state = "pdoor0"
	explosion_resistance = 100
	density = 0
	opacity = 0

	id_tag = "elevator"

	prefix = "r_"
	animation_delay = 18
	animation_delay_2 = 5

/obj/machinery/elevator_control
	name = "elevator_control"
	desc = "It controls doors, remotely."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "doorctrl0"
	desc = "A remote control-switch for a door."
	var/activated = 0

/obj/machinery/elevator_control/attack_hand(mob/user as mob)
	if(!activated)
		activated = 1
		var/area/start_location = locate(/area/Elegrad/elevator_in)
		var/area/end_location = locate(/area/Elegrad/elevator_out)
		for(var/obj/machinery/door/poddoor/elegrad_doors/E in world)
			E.close()
			E.opacity = 1

		sleep(50)
		playsound(get_turf(src), 'sound/effects/elevator_fall.ogg',100,0)
		start_location.move_contents_to(end_location)
		start_location = locate(/area/Elegrad/elevator_end)
		for(var/mob/M in end_location)
			shake_camera(M, 10, 2)
			M.make_dizzy(120)
			M.Weaken(5)
			M << "\red <b>THE ELEVATOR IS FALLING!!</b>"
		sleep(110)
		for(var/mob/living/carbon/human/M in end_location)
			shake_camera(M, 10, 2)
			M.Weaken(20)
			var/organ_name = pick("r_leg","l_leg")
			var/datum/organ/external/E = M.get_organ(organ_name)
			E.take_damage(75, 0, 0)
			E.fracture()
		end_location.move_contents_to(start_location)
//////////////////////////////////////AREAS/////////////////////////////////////////

/area/Elegrad/indoors
	name = "Elegrad"
	icon_state = "yellow"
	requires_power = 0

/area/Elegrad/complex
	name = "Complex"
	icon_state = "yellow"
	requires_power = 0

/area/Elegrad/rooftop_edge
	name = "rooftop"
	icon_state = "yellow"
	requires_power = 0

/area/Elegrad/elevator_in
	name = "elevator"
	icon_state = "yellow"
	requires_power = 0

/area/Elegrad/elevator_out
	name = "elevator"
	icon_state = "yellow"
	requires_power = 0

/area/Elegrad/elevator_end
	name = "elevator"
	icon_state = "yellow"
	requires_power = 0


/area/Elegrad/city
	name = "Elegrad"
	icon_state = "yellow"
	requires_power = 0
	luminosity = 0
	lighting_use_dynamic = 1

	New()
		..()
		process()

	proc/process()

		for(var/mob/living/carbon/human/H in src)
			if(H.client && prob(2))
				if(prob(50))
					var/organ_name = pick("l_arm","r_arm","r_leg","l_leg","chest","groin","head")
					var/datum/organ/external/E = H.get_organ(organ_name)
					E.take_damage(pick(20,30,40), 5, 0)
					H.visible_message("\red <b>Sniper shoots [H.name] in the [E.display_name]!</b>")
				else
					H.visible_message("\red <b>Sniper has missed!</b>")

				for(var/mob/living/carbon/human/M in src)
					M << sound('sound/effects/snipershot.ogg')
		spawn(60) .()

/area/Elegrad/rooftop
	name = "rooftop"
	icon_state = "bridge"
	requires_power = 0
	var/sound/mysound = null

	New()
		..()
		var/sound/S = new/sound()
		mysound = S
		S.file = 'sound/ambience/wind_rooftop.ogg'
		S.repeat = 1
		S.wait = 0
		S.channel = 257
		S.volume = 100
		S.priority = 255
		S.status = SOUND_UPDATE

	Entered(atom/movable/Obj,atom/OldLoc)
		if(ismob(Obj))
			if(Obj:client)
				mysound.status = SOUND_UPDATE
				Obj << mysound
		return

	Exited(atom/movable/Obj)
		if(ismob(Obj))
			if(Obj:client)
				mysound.status = SOUND_PAUSED | SOUND_UPDATE
				Obj << mysound


//////////////////////////////TRIGGERS///////////////////////////////////////////
/obj/effect/step_trigger/indoor
	var/teleport_x = 0	// teleportation coordinates (if one is null, then no teleport!)
	var/teleport_y = 0
	var/teleport_z = 0
	var/teleport_z_offset = 1

	Trigger(var/atom/movable/A)
		A.x = teleport_x
		A.y = teleport_y
		A.z = src.z + teleport_z_offset

/obj/effect/step_trigger/roof_fall
	var/teleport_x = 0	// teleportation coordinates (if one is null, then no teleport!)
	var/teleport_y = 0
	var/teleport_z = 0
	var/teleport_z_offset = 1
	var/message = "from rooftop"
	var/damage = 40

	Trigger(var/atom/movable/A)
		var/activated = 0
		if(teleport_x && teleport_y && !activated)
			activated = 1	// avoiding a cycle
			playsound(get_turf(src), 'sound/weapons/tablehit1.ogg', 50, 1)
			var/mob/M = A
			if(istype(M, /mob/living/carbon/human))
				var/mob/living/carbon/human/mob = A
				mob.emote("me",1,"falling [message]!")
				mob.weakened += rand(25)
				var/organ_name = pick("l_arm","r_arm","r_leg","l_leg")
				var/datum/organ/external/E = mob.get_organ(organ_name)
				E.take_damage(damage, 0, 0)
				E.fracture()
			A.x = teleport_x
			A.y = teleport_y
			A.z = src.z + teleport_z_offset


/obj/effect/step_trigger/shield
	name = "Shield"
	desc = "An energy shield."
	icon = 'icons/effects/effects.dmi'
	icon_state = "shieldwall"
	dir = 8
	invisibility = 0

	Trigger(var/atom/movable/A)
		if(!istype(A,/mob/living))
			return
		var/mob/living/M = A

		if(istype(M,/mob/living/silicon) || !istype(M,/mob/living/carbon) || !istype(M.wear_mask, /obj/item/clothing/mask/eneck))
			playsound(get_turf(M), 'sound/effects/sparks1.ogg',100,0)
			M.weakened += rand(5)
		else
			M.y++
			return

		M.y--

/obj/effect/step_trigger/shield_end
	name = "Shield"
	desc = "An energy shield."
	icon = 'icons/effects/effects.dmi'
	icon_state = "shieldwall"
	dir = 8
	invisibility = 0

	Trigger(var/atom/movable/A)
		if(!istype(A,/mob/living))
			return
		var/mob/living/M = A

		if(!istype(M,/mob/living/carbon) || !istype(M.wear_mask, /obj/item/clothing/mask/eneck))
			playsound(get_turf(M), 'sound/effects/sparks1.ogg',100,0)
			M.weakened += rand(5)
		else
			M.y++
			var/obj/item/clothing/mask/D = M.wear_mask
			M.u_equip(D)
			M.update_inv_wear_mask(0)
			del(D)
			return

		if(M.y > src.y)
			M.y++
		else
			M.y--
///////////////////////////////MOBS///////////////////////////////////////////////

/mob/living/simple_animal/anim_bear
	name = "animatronic bear"
	desc = "You aren't gonna say you have a bad feeling about this, are you?"
	icon_state = "anim_bear"
	icon_living = "anim_bear"
	icon_dead = "empty"
	gender = MALE
	speak = list("SKREEEEEEEEEEE")
	speak_emote = list("skreeeks")
	emote_hear = list("skreeeeks!")
	emote_see = list("cacklings!")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 10
	health = 800
	maxHealth = 800

	species = /mob/living/simple_animal/anim_bear
	childtype = /mob/living/simple_animal/anim_bear
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat
	response_help  = "pets"
	response_disarm = "gently pushes aside"
	response_harm   = "kicks"
	min_oxy = 16      // Require atleast 16kPA oxygen
	minbodytemp = 223 // Below -50 Degrees Celcius
	maxbodytemp = 323 // Above 50 Degrees Celcius
	var/turns_since_scan = 0
	var/mob/living/carbon/human/movement_target=null

/mob/living/simple_animal/anim_bear/Life()
	if((src.loc) && isturf(src.loc))
		if(!stat && !resting && !buckled)
			for(var/mob/living/carbon/human/M in view(1,src))
				emote(pick("\red splats the [M]!","\red gibs the [M]","cracks the [M]"))
				M.damageoverlay.icon = 'icons/Elegrad/animatronic.dmi'
				M.damageoverlay.icon_state = "bear"
				movement_target = null
				sleep(3)
				playsound(get_turf(src), 'sound/scp/animatronic.ogg', 100,0)
				sleep(14)
				M.gib()
				break

	..()

	make_babies()


	if(!stat && !resting && !buckled)
		turns_since_scan++
		if(turns_since_scan > 5)
			walk_to(src,0)
			turns_since_scan = 0
			if((movement_target) && !(isturf(movement_target.loc)))
				movement_target = null
				stop_automated_movement = 0
			if( !movement_target || !(movement_target.loc in oview(src, 7)) )
				movement_target = null
				stop_automated_movement = 0
				for(var/mob/living/carbon/human/snack in oview(src,7))
					if(isturf(snack.loc) && prob(40))
						movement_target = snack
						break
			if(movement_target)
				stop_automated_movement = 1
				walk_to(src,movement_target,0,3)





