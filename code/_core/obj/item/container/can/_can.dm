/obj/item/container/beaker/can
	name = "soda can"
	desc = "ERROR."
	desc_extended = "Holds reagents."
	crafting_id = "soda_can"

	icon = 'icons/obj/items/container/cup/cans_new.dmi'
	icon_state = ""

	reagents = /reagent_container/beaker/bottle/

	allow_reagent_transfer_to = FALSE //Needs to be open, first.
	allow_reagent_transfer_from = FALSE

	var/open = FALSE

	overide_icon = TRUE

	value = 1

/obj/item/container/beaker/can/click_self(var/mob/caller,location,control,params)

	if(open)
		return ..()

	caller.to_chat("You open \the [src.name].")
	open = TRUE
	allow_reagent_transfer_to = TRUE
	allow_reagent_transfer_from = TRUE

	return TRUE

/obj/item/container/beaker/can/Generate()

	var/best_reagent = null
	var/best_reagent_amount = 0

	for(var/reagent_type in reagents.stored_reagents)
		var/reagent_amount = reagents.stored_reagents[reagent_type]
		if(!best_reagent || reagent_amount > best_reagent_amount)
			best_reagent = reagent_type
			best_reagent_amount = best_reagent_amount

	var/reagent/R = REAGENT(best_reagent)
	name = R.name
	desc = R.desc
	icon_state = R.can_icon_state
	desc_extended = "An alluminum can that is said to contain delicious beverage. This one contains [R.name]."

	return ..()

/obj/item/container/beaker/can/cola/Generate()
	reagents.add_reagent(/reagent/nutrition/soda/cola,reagents.volume_max)
	return ..()

/obj/item/container/beaker/can/grape_soda/Generate()
	reagents.add_reagent(/reagent/nutrition/soda/grape,reagents.volume_max)
	return ..()

/obj/item/container/beaker/can/orange_soda/Generate()
	reagents.add_reagent(/reagent/nutrition/soda/orange,reagents.volume_max)
	return ..()

/obj/item/container/beaker/can/iced_tea/Generate()
	reagents.add_reagent(/reagent/nutrition/soda/iced_tea,reagents.volume_max)
	return ..()

/obj/item/container/beaker/can/grey_bull/
	reagents = /reagent_container/beaker/

/obj/item/container/beaker/can/grey_bull/Generate()
	reagents.add_reagent(/reagent/nutrition/soda/grey_bull,reagents.volume_max)
	return ..()

/obj/item/container/beaker/can/mountain_wind/Generate()
	reagents.add_reagent(/reagent/nutrition/soda/mountain_wind,reagents.volume_max)
	return ..()

/obj/item/container/beaker/can/dr_gibb/Generate()
	reagents.add_reagent(/reagent/nutrition/soda/dr_gibb,reagents.volume_max)
	return ..()

/obj/item/container/beaker/can/space_up/Generate()
	reagents.add_reagent(/reagent/nutrition/soda/space_up,reagents.volume_max)
	return ..()
