/datum/job/captain
	title = "Captain"
	flag = CAPTAIN
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "Nanotrasen and Central Command"
	selection_color = "#ccccff"
	idtype = /obj/item/weapon/card/id/gold
	req_admin_notify = 1
	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()
	minimal_player_age = 14

	pdaslot=slot_l_store
	pdatype=/obj/item/device/pda/captain

	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_or_collect(new /obj/item/device/radio/headset/heads/captain(H), slot_ears)
		switch(H.backbag)
			if(2) H.equip_or_collect(new /obj/item/weapon/storage/backpack/captain(H), slot_back)
			if(3) H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel_cap(H), slot_back)
			if(4) H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel(H), slot_back)
		H.equip_or_collect(new H.species.survival_gear(H.back), slot_in_backpack)
		var/obj/item/clothing/under/U = new /obj/item/clothing/under/rank/captain(H)
		U.hastie = new /obj/item/clothing/tie/medal/gold/captain(U)
		H.equip_or_collect(U, slot_w_uniform)
		//H.equip_or_collect(new /obj/item/device/pda/captain(H), slot_belt)
		H.equip_or_collect(new /obj/item/clothing/shoes/brown(H), slot_shoes)
		H.equip_or_collect(new /obj/item/clothing/head/caphat(H), slot_head)
		H.equip_or_collect(new /obj/item/clothing/glasses/sunglasses(H), slot_glasses)
		if(H.backbag == 1)
			H.equip_or_collect(new /obj/item/weapon/storage/box/ids(H), slot_r_hand)
		else
			H.equip_or_collect(new /obj/item/weapon/storage/box/ids(H.back), slot_in_backpack)
		var/obj/item/weapon/implant/loyalty/L = new/obj/item/weapon/implant/loyalty(H)
		L.imp_in = H
		L.implanted = 1
		world << "<b>[H.real_name] is the captain!</b>"
		var/datum/organ/external/affected = H.get_organ("head")
		affected.implants += L
		L.part = affected
		return 1

	get_access()
		return get_all_accesses()



/datum/job/hop
	title = "Head of Personnel"
	flag = HOP
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the captain and Central Command"
	selection_color = "#ddddff"
	idtype = /obj/item/weapon/card/id/silver
	req_admin_notify = 1
	minimal_player_age = 10

	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()

	pdaslot=slot_l_store
	pdatype=/obj/item/device/pda/heads/hop

	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_or_collect(new /obj/item/device/radio/headset/heads/hop(H), slot_ears)
		switch(H.backbag)
			if(2) H.equip_or_collect(new /obj/item/weapon/storage/backpack(H), slot_back)
			if(3) H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel_norm(H), slot_back)
			if(4) H.equip_or_collect(new /obj/item/weapon/storage/backpack/satchel(H), slot_back)
		H.equip_or_collect(new H.species.survival_gear(H.back), slot_in_backpack)
		H.equip_or_collect(new /obj/item/clothing/under/rank/head_of_personnel(H), slot_w_uniform)
		H.equip_or_collect(new /obj/item/clothing/shoes/brown(H), slot_shoes)
		//H.equip_or_collect(new /obj/item/device/pda/heads/hop(H), slot_belt)
		if(H.backbag == 1)
			H.equip_or_collect(new /obj/item/weapon/storage/box/ids(H), slot_r_hand)
		else
			H.equip_or_collect(new /obj/item/weapon/storage/box/ids(H.back), slot_in_backpack)
		return 1

	get_access() // This is only for Ministation
		return get_all_accesses()

