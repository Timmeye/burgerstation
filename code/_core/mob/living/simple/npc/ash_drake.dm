/mob/living/simple/npc/ash_drake
	name = "ash drake"
	id = "ash_drake"
	icon = 'icons/mob/living/simple/lavaland/ashdrake.dmi'
	icon_state = "living"
	damage_type = /damagetype/unarmed/claw/
	class = /class/ash_drake

	pixel_w = -16

	ai = /ai/boss/ash_drake/

	stun_angle = 0

	health_base = 2000

	var/boss_state = 0
	//0 = walking
	//1 = flying
	//2 = landing

	attack_range = 2

	force_spawn = TRUE
	boss = TRUE

	armor_base = list(
		BLADE = 50,
		BLUNT = 25,
		PIERCE = 25,
		LASER = 100,
		MAGIC = 0,
		HEAT = INFINITY,
		COLD = 0,
		BOMB = 50,
		BIO = 75,
		RAD = 75,
		HOLY = 0,
		DARK = INFINITY,
		FATIGUE = INFINITY
	)

	damage_received_multiplier = 0.5

	butcher_contents = list(
		/obj/item/clothing/overwear/armor/drake_armor,
		/obj/item/soapstone/red
	)

	status_immune = list(
		STUN = TRUE,
		SLEEP = STAGGER,
		PARALYZE = STAGGER,
		FATIGUE = STAGGER,
		STAGGER = FALSE,
		CONFUSED = FALSE,
		CRIT = FALSE,
		REST = FALSE,
		ADRENALINE = FALSE,
		DISARM = FALSE,
		DRUGGY = FALSE
	)

	mob_size = MOB_SIZE_BOSS

	enable_medical_hud = FALSE
	enable_security_hud = FALSE


/*
/mob/living/simple/npc/ash_drake/get_miss_chance(var/atom/attacker,var/atom/weapon,var/atom/target)

	if(boss_state)
		return 1000

	return ..()
*/

/mob/living/simple/npc/ash_drake/proc/fly()

	if(boss_state)
		return

	if(prob(50))
		fire_rain()

	new/obj/effect/temp/ash_drake/swoop_up(src.loc)

	boss_state = 1
	update_collisions(FLAG_COLLISION_NONE,FLAG_COLLISION_BULLET_NONE)
	icon_state = "shadow"
	update_sprite()

/mob/living/simple/npc/ash_drake/proc/land()

	if(boss_state != 1)
		return

	spawn()
		new/obj/effect/temp/ash_drake/swoop_down(src.loc)
		boss_state = 2
		sleep(SECONDS_TO_DECISECONDS(1))
		boss_state = 0
		icon_state = "living"
		update_collisions(initial(collision_flags),initial(collision_bullet_flags))
		update_sprite()

		for(var/turf/T in range(2,src))
			new/obj/effect/temp/impact/combat/smash(T)

		for(var/mob/living/L in range(2,src))
			if(L == src)
				continue

			var/is_center = get_dist(src,L) == 0

			step(L,get_dir(src,L))
			L.add_status_effect(STAGGER,10 + is_center*30,10 + is_center*30,source = src)

		fire_cross()


/mob/living/simple/npc/ash_drake/proc/fire_cross()

	var/turf/T = get_turf(src)
	var/starting_x = T.x
	var/starting_y = T.y
	var/starting_z = T.z

	spawn()
		for(var/i=1,i<=10,i++)
			var/turf/desired_turf1 = locate(starting_x+i,starting_y,starting_z)
			var/turf/desired_turf2 = locate(starting_x-i,starting_y,starting_z)
			var/turf/desired_turf3 = locate(starting_x,starting_y+i,starting_z)
			var/turf/desired_turf4 = locate(starting_x,starting_y-i,starting_z)
			new/obj/effect/temp/hazard/fire/(desired_turf1)
			new/obj/effect/temp/hazard/fire/(desired_turf2)
			new/obj/effect/temp/hazard/fire/(desired_turf3)
			new/obj/effect/temp/hazard/fire/(desired_turf4)
			sleep(1)


/mob/living/simple/npc/ash_drake/proc/fire_rain()

	if(!health)
		return FALSE

	var/list/turf/simulated/floor/valid_floors = list()

	for(var/turf/simulated/floor/T in range(4,src))
		valid_floors += T

	var/amount_multiplier = FLOOR(10 + (1 - (health.health_current/health.health_max))*20, 1)

	for(var/i=1,i<=amount_multiplier,i++)
		var/turf/T = pick(valid_floors)
		new/obj/effect/temp/ash_drake/target/(T)
		new/obj/effect/temp/hazard/falling_fireball(T,desired_owner = src)

	return TRUE

/mob/living/simple/npc/ash_drake/get_movement_delay()
	if(boss_state)
		return DECISECONDS_TO_TICKS(2)

	return ..()

/mob/living/simple/npc/ash_drake/proc/shoot_fireball(var/atom/desired_target)
	shoot_projectile(src,desired_target,null,null,/obj/projectile/magic/fireball/,/damagetype/ranged/magic/fireball/ash_drake,16,16,0,20,1,"#FFFFFF",0,0)




/mob/living/simple/npc/ash_drake/post_death()
	..()
	icon_state = "dead"
	update_sprite()







