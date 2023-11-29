extends Node

enum WeaponTypes { BASE, BIOTICS, PROPULSION, OPTICS, ROBOTICS, SUPPRESSION }

func enum_to_string(item):
	return Global.WeaponTypes.keys()[item]
