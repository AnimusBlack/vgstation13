/obj/item/clothing/head/helmet/space/ert
	name = "emergency response team helmet"
	desc = "A helmet worn by members of the NanoTrasen Emergency Response Team. Armoured, space ready and fire resistant."
	icon_state = "ert_commander"
	item_state = "helm-command"
	armor = list(melee = 50, bullet = 50, laser = 30,energy = 15, bomb = 30, bio = 100, rad = 60)
	siemens_coefficient = 0.6
	max_heat_protection_temperature = FIRE_HELMET_MAX_HEAT_PROTECITON_TEMPERATURE
	var/obj/machinery/camera/camera

/obj/item/clothing/head/helmet/space/ert/attack_self(mob/user)
	if(camera)
		..(user)
	else
		camera = new /obj/machinery/camera(src)
		camera.network = list("ERT")
		cameranet.removeCamera(camera)
		camera.c_tag = user.name
		user << "\blue User scanned as [camera.c_tag]. Camera activated."

/obj/item/clothing/head/helmet/space/ert/examine()
	..()
	if(get_dist(usr,src) <= 1)
		usr << "This helmet has a built-in camera. It's [camera ? "" : "in"]active."

/obj/item/clothing/head/helmet/space/bodyguard
	name = "bodyguard team helmet"
	desc = "A helmet worn by members of the NanoTrasen Bodyguard Team. Armoured, space ready and fire resistant."
	icon_state = "ert_commander"
	item_state = "helm-command"
	armor = list(melee = 50, bullet = 50, laser = 30,energy = 15, bomb = 30, bio = 100, rad = 60)
	siemens_coefficient = 0.6
	max_heat_protection_temperature = FIRE_HELMET_MAX_HEAT_PROTECITON_TEMPERATURE
	var/obj/machinery/camera/camera

/obj/item/clothing/head/helmet/space/bodyguard/attack_self(mob/user)
	if(camera)
		..(user)
	else
		camera = new /obj/machinery/camera(src)
		camera.network = list("Inspection")
		cameranet.removeCamera(camera)
		camera.c_tag = user.name
		user << "\blue User scanned as [camera.c_tag]. Camera activated."

/obj/item/clothing/head/helmet/space/bodyguard/examine()
	..()
	if(get_dist(usr,src) <= 1)
		usr << "This helmet has a built-in camera. It's [camera ? "" : "in"]active."

/obj/item/clothing/suit/space/ert
	name = "emergency response team suit"
	desc = "A suit worn by members of the NanoTrasen Emergency Response Team. Armoured, space ready and fire resistant."
	icon_state = "ert_commander"
	item_state = "suit-command"
	w_class = 3
	allowed = list(/obj/item/weapon/gun,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/melee/baton,/obj/item/weapon/melee/energy/sword,/obj/item/weapon/handcuffs,/obj/item/weapon/tank/emergency_oxygen,/obj/item/weapon/tank/emergency_nitrogen)
	slowdown = 1
	armor = list(melee = 60, bullet = 50, laser = 30,energy = 15, bomb = 30, bio = 100, rad = 60)
	allowed = list(/obj/item/device/flashlight, /obj/item/weapon/tank, /obj/item/device/t_scanner, /obj/item/weapon/rcd, /obj/item/weapon/crowbar, \
	/obj/item/weapon/screwdriver, /obj/item/weapon/weldingtool, /obj/item/weapon/wirecutters, /obj/item/weapon/wrench, /obj/item/device/multitool, \
	/obj/item/device/radio, /obj/item/device/analyzer, /obj/item/weapon/gun/energy/laser, /obj/item/weapon/gun/energy/pulse_rifle, \
	/obj/item/weapon/gun/energy/taser, /obj/item/weapon/melee/baton, /obj/item/weapon/gun/energy/gun)
	siemens_coefficient = 0.6
	max_heat_protection_temperature = FIRESUIT_MAX_HEAT_PROTECITON_TEMPERATURE

//Commander
/obj/item/clothing/head/helmet/space/ert/commander
	name = "emergency response team commander helmet"
	desc = "A helmet worn by the commander of a NanoTrasen Emergency Response Team. Armoured, space ready and fire resistant."
	icon_state = "ert_commander"
	item_state = "helm-command"

/obj/item/clothing/suit/space/ert/commander
	name = "emergency response team commander suit"
	desc = "A suit worn by the commander of a NanoTrasen Emergency Response Team. Armoured, space ready and fire resistant."
	icon_state = "ert_commander"
	item_state = "suit-command"

//Security
/obj/item/clothing/head/helmet/space/ert/security
	name = "emergency response team security helmet"
	desc = "A helmet worn by the security members of a NanoTrasen Emergency Response Team. Armoured, space ready and fire resistant."
	icon_state = "ert_security"
	item_state = "syndicate-helm-black-red"

/obj/item/clothing/suit/space/ert/security
	name = "emergency response team security suit"
	desc = "A suit worn by the security members of a NanoTrasen Emergency Response Team. Armoured, space ready and fire resistant."
	icon_state = "ert_security"
	item_state = "syndicate-black-red"

//Engineer
/obj/item/clothing/head/helmet/space/ert/engineer
	name = "emergency response team engineer helmet"
	desc = "A helmet worn by the engineering members of a NanoTrasen Emergency Response Team. Armoured, space ready and fire resistant."
	icon_state = "ert_engineer"

/obj/item/clothing/suit/space/ert/engineer
	name = "emergency response team engineer suit"
	desc = "A suit worn by the engineering members of a NanoTrasen Emergency Response Team. Armoured, space ready and fire resistant."
	icon_state = "ert_engineer"

//Medical
/obj/item/clothing/head/helmet/space/ert/medical
	name = "emergency response team medical helmet"
	desc = "A helmet worn by the medical members of a NanoTrasen Emergency Response Team. Armoured, space ready and fire resistant."
	icon_state = "ert_medical"

/obj/item/clothing/suit/space/ert/medical
	name = "emergency response team medical suit"
	desc = "A suit worn by the medical members of a NanoTrasen Emergency Response Team. Armoured, space ready and fire resistant."
	icon_state = "ert_medical"

/obj/item/clothing/suit/space/bodyguard
	name = "bodyguard team suit"
	desc = "A suit worn by members of the NanoTrasen Bodyguard Team. Armoured, space ready and fire resistant."
	icon_state = "ert_commander"
	item_state = "suit-command"
	w_class = 3
	allowed = list(/obj/item/weapon/gun,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/melee/baton,/obj/item/weapon/melee/energy/sword,/obj/item/weapon/handcuffs,/obj/item/weapon/tank/emergency_oxygen,/obj/item/weapon/tank/emergency_nitrogen)
	slowdown = 1
	armor = list(melee = 60, bullet = 50, laser = 30,energy = 30, bomb = 30, bio = 100, rad = 60)
	allowed = list(/obj/item/device/flashlight, /obj/item/weapon/tank, /obj/item/device/t_scanner, /obj/item/weapon/rcd, /obj/item/weapon/crowbar, \
	/obj/item/weapon/screwdriver, /obj/item/weapon/weldingtool, /obj/item/weapon/wirecutters, /obj/item/weapon/wrench, /obj/item/device/multitool, \
	/obj/item/device/radio, /obj/item/device/analyzer, /obj/item/weapon/gun/energy/laser, /obj/item/weapon/gun/energy/pulse_rifle, \
	/obj/item/weapon/gun/energy/taser, /obj/item/weapon/melee/baton, /obj/item/weapon/gun/energy/gun)
	max_heat_protection_temperature = FIRESUIT_MAX_HEAT_PROTECITON_TEMPERATURE

/obj/item/weapon/melee/gibstick
	name = "Centcomm Manipulation Device"
	desc = "Product of weird technology from deepest CentComm labs."
	icon = 'library.dmi'
	icon_state = "scanner"
	var/mode
	New()
		message_admins("ADMIN: Manipulation Device has been spawned")
	attack_self (mob/user)
		mode ++
		if(mode == 4)
			mode = 0
		switch(mode)
			if(0)
				usr << "You turn off manipulation device"
			if(1)
				usr << "You turn gib mode"
			if(2)
				usr << "You turn stun mode"
			if(3)
				usr << "You turn heal mode"

	attack(var/mob/living/M as mob, mob/living/user as mob)
		switch(mode)
			if(0)
				..()
				for(var/mob/O in viewers(M))
					if (O.client)	O.show_message("\red <B>[user] has turned off CentComm Manipulation Device!</B>", 1, "\red You hear something clicked", 2)
			if(1)
				M.gib()
				for(var/mob/O in viewers(M))
					if (O.client)	O.show_message("\red <B>[M] has been destroyed with the CentComm Manipulation Device by [user]!</B>", 1, "\red You hear someone gibs", 2)
			if(2)
				M.Stun(25)
				M.Weaken(25)
				for(var/mob/O in viewers(M))
					if (O.client)	O.show_message("\red <B>[M] has been stunned with the CentComm Manipulation Device by [user]!</B>", 1, "\red You hear someone fall", 2)
			if(3)
				M.revive()
				for(var/mob/O in viewers(M))
					if (O.client)	O.show_message("\red <B>[M] has been healed with the CentComm Manipulation Device by [user]!</B>", 1, "\red You hear someone heals", 2)
		return

/obj/item/weapon/reagent_containers/food/drinks/ambrosia
	name = "Ambrosia Bottle"
	desc = "Contains the liquid essence of gods."
	icon = 'drinks.dmi'
	icon_state = "holyflask"
	New()
		..()
		reagents.add_reagent("adminordrazine", 30)
		src.pixel_x = rand(-10.0, 10)
		src.pixel_y = rand(-10.0, 10)

/obj/item/weapon/storage/belt/utility/fvll/New()
	..()
	new /obj/item/weapon/screwdriver(src)
	new /obj/item/weapon/wrench(src)
	new /obj/item/weapon/weldingtool(src)
	new /obj/item/weapon/crowbar(src)
	new /obj/item/weapon/wirecutters(src)
	new /obj/item/weapon/gun/energy/pulse_rifle/M1911(src)

/obj/item/weapon/storage/belt/security/fvll/New()
	..()
	new /obj/item/weapon/melee/baton(src)
	new /obj/item/weapon/gun/energy/pulse_rifle/M1911(src)
	new /obj/item/weapon/grenade/flashbang(src)
	new /obj/item/weapon/handcuffs(src)
	new /obj/item/weapon/handcuffs(src)
	new /obj/item/weapon/handcuffs(src)

/obj/item/weapon/storage/backpack/holding/inspector/New()
	..()
	new /obj/item/weapon/melee/classic_baton(src)
	new /obj/item/weapon/grenade/flashbang/clusterbang(src)
	new /obj/item/weapon/reagent_containers/food/drinks/ambrosia(src)
	new /obj/item/weapon/gun/projectile/mateba(src)
	new /obj/item/weapon/melee/energy/axe(src)
	new /obj/item/weapon/cloaking_device(src)
	new /obj/item/weapon/storage/firstaid/adv(src)

/obj/item/weapon/storage/backpack/holding/agent1/New()
	..()
	new /obj/item/weapon/rcd(src)
	new /obj/item/weapon/rcd_ammo(src)
	new /obj/item/weapon/rcd_ammo(src)
	new /obj/item/weapon/rcd_ammo(src)
	new /obj/item/weapon/grenade/chem_grenade/metalfoam(src)
	new /obj/item/weapon/syndie/c4explosive/heavy(src)
	new /obj/item/weapon/syndie/c4detonator(src)

/obj/item/weapon/storage/backpack/holding/agent2/New()
	..()
	new /obj/item/weapon/reagent_containers/food/drinks/ambrosia(src)
	new /obj/item/weapon/storage/firstaid/fire(src)
	new /obj/item/weapon/storage/firstaid/toxin(src)
	new /obj/item/weapon/storage/firstaid/adv(src)
	new /obj/item/weapon/storage/box/emps(src)
	new /obj/item/weapon/storage/box/smokebombs(src)
	new /obj/item/weapon/storage/box/handcuffs(src)
