/damagetype/ranged/bullet/gyrojet/
	name = "Gyrojet Impact"

	//The base attack damage of the weapon. It's a flat value, unaffected by any skills or attributes.
	attack_damage_base = list(
		BLUNT = 10,
		PIERCE = 5,
		BOMB = 40,
	)

	//How much armor to penetrate. It basically removes the percentage of the armor using these values.
	attack_damage_penetration = list(
		BLADE = 10,
		PIERCE = 10,
		BOMB = 25,
	)

	falloff = 0