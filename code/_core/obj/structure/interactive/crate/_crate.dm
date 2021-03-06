/obj/structure/interactive/crate
	name = "crate"
	desc = "Shove things inside."
	icon = 'icons/obj/structure/crates.dmi'
	icon_state = "crate"

	anchored = FALSE
	collision_flags = FLAG_COLLISION_WALL

	var/list/crate_contents = list()

	var/open = FALSE

	initialize_type = INITIALIZE_LATE

	bullet_block_chance = 50

	var/max_mob_size = MOB_SIZE_HUMAN

/obj/structure/interactive/crate/Exit(atom/movable/O, atom/newloc)

	. = ..()

	if(!open)
		open(null)
		return TRUE

	return .

/obj/structure/interactive/crate/Cross(var/atom/movable/O)

	if(istype(O,/obj/structure/interactive/crate))
		return FALSE

	if(open)
		return TRUE

	if(!(O.collision_flags && FLAG_COLLISION_ETHEREAL))
		return TRUE

	return ..()


/obj/structure/interactive/crate/Uncross(var/atom/movable/O)

	if(open)
		return TRUE

	return ..()

/obj/structure/interactive/crate/update_icon()
	icon_state = initial(icon_state)
	if(open)
		icon_state = "[icon_state]_open"

	return ..()

/obj/structure/interactive/crate/clicked_on_by_object(var/mob/caller,object,location,control,params)

	. = ..()

	if(!. && !(caller.attack_flags & ATTACK_GRAB))
		INTERACT_CHECK
		toggle(caller)

	return .

/obj/structure/interactive/crate/Generate()

	if(!open)
		for(var/atom/movable/M in loc.contents)
			if(M == src || M.anchored)
				continue
			M.force_move(src)
			M.pixel_x = initial(M.pixel_x)
			M.pixel_y = initial(M.pixel_y)
			crate_contents += M

	update_sprite()

	return ..()

/obj/structure/interactive/crate/proc/toggle(var/mob/caller)
	return open ? close(caller) : open(caller)

/obj/structure/interactive/crate/proc/close(var/mob/caller)

	var/atom/blocking
	for(var/atom/movable/M in loc.contents)
		if(is_living(M))
			var/mob/living/L = M
			if(!L.horizontal || L.mob_size > max_mob_size)
				blocking = L
				break

	if(blocking)
		caller.to_chat("\The [blocking.name] is preventing \the [src.name] from being closed!")
		return FALSE

	for(var/atom/movable/M in loc.contents)
		if(M == src || M.anchored)
			continue
		M.force_move(src)
		M.pixel_x = 0
		M.pixel_y = 0
		crate_contents += M

	open = FALSE

	update_sprite()

	return TRUE

/obj/structure/interactive/crate/proc/open(var/mob/caller)

	for(var/atom/movable/M in crate_contents)
		crate_contents -= M
		M.force_move(src.loc)
		//animate(M,pixel_x = initial(M.pixel_x) + rand(-16,16),pixel_y = initial(M.pixel_y) + rand(-16,16),time = 4)

	open = TRUE

	update_sprite()

	return TRUE


/obj/structure/interactive/crate/loot
	name = "abandoned supply crate"

/obj/structure/interactive/crate/loot/Generate()

	switch(rand(1,26))
		if(1 to 2)
			for(var/i=1,i<=rand(2,4),i++)
				CREATE(/obj/item/weapon/ranged/bullet/magazine/pistol/deagle,src.loc)
			for(var/i=1,i<=rand(6,12),i++)
				CREATE(/obj/item/magazine/pistol_50,src.loc)
		if(3)
			for(var/i=1,i<=rand(2,4),i++)
				CREATE(/obj/item/weapon/ranged/bullet/magazine/rifle/assault,src.loc)
			for(var/i=1,i<=rand(6,12),i++)
				CREATE(/obj/item/magazine/rifle_308,src.loc)
		if(4 to 6)
			for(var/i=1,i<=rand(2,4),i++)
				CREATE(/obj/item/weapon/ranged/bullet/magazine/shotgun/bull,src.loc)
			for(var/i=1,i<=rand(6,12),i++)
				CREATE(/obj/item/magazine/shotgun_auto,src.loc)
		if(7)
			for(var/i=1,i<=rand(2,4),i++)
				CREATE(/obj/item/weapon/ranged/bullet/revolver/commander,src.loc)
			for(var/i=1,i<=rand(6,12),i++)
				CREATE(/obj/item/magazine/clip/revolver/bullet_44,src.loc)
		if(8 to 10)
			for(var/i=1,i<=rand(2,4),i++)
				CREATE(/obj/item/storage/kit/brute/filled,src.loc)
			for(var/i=1,i<=rand(2,4),i++)
				CREATE(/obj/item/storage/kit/burn/filled,src.loc)
		if(10 to 14)
			for(var/i=1,i<=rand(4,12),i++)
				CREATE(/obj/item/magazine/carbine_223,src.loc)
		if(14 to 18)
			for(var/i=1,i<=rand(4,12),i++)
				CREATE(/obj/item/magazine/rifle_556,src.loc)
		if(18 to 22)
			for(var/i=1,i<=rand(1,3),i++)
				new /mob/living/advanced/npc/beefman(src.loc)
		if(22 to 26)
			for(var/i=1,i<=rand(1,2),i++)
				CREATE(/obj/item/defib,src.loc)
			for(var/i=1,i<=rand(2,4),i++)
				CREATE(/obj/item/storage/kit/filled,src.loc)

	return ..()