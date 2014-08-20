/obj/item/weapon/gun/energy/smartgun
	icon_state = "taser"
	name = "smart gun"
	desc = "A high-tech handgun with a safety mechanism that reads from compatible security systems."
	fire_sound = 'sound/weapons/Taser.ogg'
	charge_cost = 100
	projectile_type = "/obj/item/projectile/beam/stun"
	cell_type = "/obj/item/weapon/cell/crap"
	var/safety = 1
	var/emagged = 0

	attack_hand(mob/user as mob)
		if(..())
			//Check fingerprints/DNA
			//Check if it needs power
			talk("Smart gun online.",user)
			var/remaining_shots
			//if(src.power_supply)
			remaining_shots = src.power_supply.charge/src.charge_cost
			if(remaining_shots)
				//talk("You have [remaining_shots] shots remaining. Use them wisely.", user)
				talk("You have [src.power_supply.charge/src.charge_cost] shots remaining. Use them wisely.", user)
			//Play suitable soundbyte here?


	//Causes the gun to talk through a headset, or through a built-in speaker, if no headset is unavailable
	proc/talk(message,mob/user as mob)
		var/mob/living/carbon/human/H
		var/obj/item/device/radio/headset/R

		if(istype(user,/mob/living/carbon/human))
			H = user

		if(H && H.l_ear && istype(H.l_ear,/obj/item/device/radio/headset))
			R = H.l_ear
		else if(H && H.r_ear && istype(H.r_ear,/obj/item/device/radio/headset))
			R = H.r_ear
		if(!R || !R.listening)
			var/list/listening = viewers(user)
			for(var/mob/M in mob_list)
				if (!M.client)
					continue //skip monkeys and disconnecteds
				if (istype(M, /mob/new_player))
					continue
				if(M.stat == 2 &&  M.client.prefs.toggles & CHAT_GHOSTEARS)
					listening |= M
			for(var/mob/M in listening)
				M << "<b>[src.name] \icon[src]</b> announces, \"[message]\"</span>"
				return
		user << "<span class='radio'><b>Your [R.name] \icon[R]</b> chimes, \"[message]\"</span>"

	Fire(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, params, reflex = 0)
		if(safety)
			user << "<span class='warning'>The gun's lights pulse as the trigger refuses to pull.</span>"
			//If good sprites, add animation here?
			playsound(user, 'sound/weapons/empty.ogg', 50, 1)
			talk("No engagable targets detected! Please holster your weapon.",user)
			return
		..()