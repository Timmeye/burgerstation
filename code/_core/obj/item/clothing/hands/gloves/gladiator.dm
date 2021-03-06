/obj/item/clothing/hands/gloves/colored/gladiator
	name = "right gladiator gauntlet"
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"
	desc = "Fight with these."
	desc_extended = "A generic gladiator glove. Hope that you have a matching pair."
	icon = 'icons/obj/items/clothing/gloves/gladiator.dmi'
	color = "#FFFFFF"

	item_slot = SLOT_HAND_RIGHT
	protected_limbs = list(BODY_HAND_RIGHT)

	defense_rating = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 10,
		MAGIC = -10
	)

	size = SIZE_1
	weight = WEIGHT_0

	value = 20

/obj/item/clothing/hands/gloves/colored/gladiator/left
	name = "left gladiator gauntlet"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND_LEFT
	protected_limbs = list(BODY_HAND_LEFT)


/obj/item/clothing/hands/gloves/colored/gladiator/gold
	color = COLOR_GOLD


/obj/item/clothing/hands/gloves/colored/gladiator/gold/left
	name = "left gladiator gauntlet"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_HAND_LEFT
	protected_limbs = list(BODY_HAND_LEFT)

	color = COLOR_GOLD