/obj/item/weapon/gun/energy/smartgun
	icon_state = "oldenergystun100"
	name = "smart gun
	desc = "A high-tech handgun with a safety mechanism that reads from compatible security systems."
	fire_sound = 'sound/weapons/Taser.ogg'
	cell_type = "/obj/item/weapon/cell/crap"
	var/safety = 1
	var/headset

	attack_hand(mob/user as mob)
		if(..())
			//Establish link with headset
			if(user.l_ear && istype(user.l_ear,/obj/item/device/radio/headset) && user.l_ear.listening)
				headset = user.l_ear
				talk("Smart gun online.",user)
				//Play suitable soundbyte here?
			else if(user.r_ear && istype(user.r_ear,/obj/item/device/radio/headset) && user.r_ear.listening)
				headset = user.r_ear
				message("
			else if(user.l_ear && istype(user.l_ear,/obj/item/device/radio/headset))

			//Check fingerprints if no gloves on

	//Causes the gun to talk through a headset, or through a built-in speaker, if no headset is unavailable
	proc/talk(message,mob/user as mob)
		if(headset && (user.l_ear == headset || user.r_ear == headset) && headset.listening)
			user << "<span class='radio'>Your [headset.name] chimes, \"[message]\"</span>"
		else if(headset && (user.l_ear == headset || user.r_ear == headset))
		//Wearing a headset but it's speaker is off
			//Check to see if you have  different headset on
				//If that one's speaker is off, warn about speakers (next line)
			//Warn speakers are off
		//Speaker the message

	Fire(atom/target as mob|obj|turf|area, mob/living/user as mob|obj, params, reflex = 0)
		if(safety)
			user << "<span class='warning'>The gun's lights pulse as the trigger refuses to pull.</span>"
			//If good sprites, add animation here?
			playsound(user, 'sound/weapons/empty.ogg', 50, 1)
			//Handle gun warning its safety is still on here, either through speaker or headset
			return
		..()