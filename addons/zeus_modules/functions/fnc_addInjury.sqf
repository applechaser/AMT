#include "..\script_component.hpp"
/*
	Author: applechaser

	Description:
		adds injuries to unit, ai or player

	Parameter(s):
		0: 	_logic	-	_logic
		1: 	int 	-	injury type





	Returns:
		nothing

	Examples:
		<example>
*/

params ["_logic", "_type"];

private _unit = attachedTo _logic;

private _fnc_randomizeInjuries = {
	params ["_unit", "_severity"];

	private _fractureCount = 0;
	switch (_severity) do {
		case 0: {_fractureCount = 1 + floor random 2};
		case 1: {_fractureCount = 1 + floor random 3};
		default {_fractureCount = 2 + floor random 3};
	};

	private _limbs = [2, 3, 4, 5];
	private _aceFractures = [0, 0, 0, 0, 0, 0];
	private _katFractures = [0, 0, 0, 0, 0, 0];
	for "i" from 1 to _fractureCount do {
		private _part = _limbs deleteAt (floor (random (count _limbs)));
		_aceFractures set [_part, 1];
		_katFractures set [_part, [1, 1 + floor random 2, 2] select _severity];
	};

	private _occludedChance = [0.35, 0.7, 0.9] select _severity;
	private _obstructionChance = [0.15, 0.4, 0.65] select _severity;
	private _occluded = random 1 < _occludedChance;
	private _obstructed = _occluded && {random 1 < _obstructionChance};

	_unit setVariable ["ace_medical_fractures", _aceFractures, true];
	_unit setVariable ["kat_surgery_fractures", _katFractures, true];
	_unit setVariable ["kat_airway_occluded", _occluded, true];
	_unit setVariable ["kat_airway_obstruction", _obstructed, true];
};

switch (_type) do {
	case 0: {	//random light
		[_unit, 10 + random 6 - 3, "Head", "grenade"] call ace_medical_fnc_addDamageToUnit;
		[_unit, 1.5 + random 2 - 1, "Body", "grenade"] call ace_medical_fnc_addDamageToUnit;
		[_unit, 3 + random 2 - 1, "LeftArm", "bullet"] call ace_medical_fnc_addDamageToUnit;
		[_unit, 2 + random 1 - 0.5, "LeftLeg", "falling"] call ace_medical_fnc_addDamageToUnit;
		[_unit, 4.5 + random 3 - 1.5, "RightLeg", "bullet"] call ace_medical_fnc_addDamageToUnit;
		[_unit, 0] call _fnc_randomizeInjuries;
	};
	case 1: {	//random medium
		[_unit, 10 + random 6 - 3, "Head", "grenade"] call ace_medical_fnc_addDamageToUnit;
		[_unit, 4 + random 2, "Body", "grenade"] call ace_medical_fnc_addDamageToUnit;
		[_unit, 4.5 + random 2 - 1, "LeftArm", "bullet"] call ace_medical_fnc_addDamageToUnit;
		[_unit, 4.5 + random 2 - 1, "RightArm", "shell"] call ace_medical_fnc_addDamageToUnit;
		[_unit, 4 + random 2, "LeftLeg", "falling"] call ace_medical_fnc_addDamageToUnit;
		[_unit, 4.5 + random 2.5 - 1, "RightLeg", "bullet"] call ace_medical_fnc_addDamageToUnit;
		[_unit, 1] call _fnc_randomizeInjuries;
	};
	case 2: {	//random heavy
		[_unit, 20 + random 10 - 5, "Head", "explosive"] call ace_medical_fnc_addDamageToUnit;
		[_unit, 10 + random 6 - 3, "Body", "grenade"] call ace_medical_fnc_addDamageToUnit;
		[_unit, 20 + random 10 - 5, "LeftArm", "bullet"] call ace_medical_fnc_addDamageToUnit;
		[_unit, 10 + random 8 - 2, "RightArm", "shell"] call ace_medical_fnc_addDamageToUnit;
		[_unit, 4 + random 2 - 1, "LeftLeg", "falling"] call ace_medical_fnc_addDamageToUnit;
		[_unit, 4 + random 2 - 1, "RightLeg", "grenade"] call ace_medical_fnc_addDamageToUnit;
		[_unit, 2] call _fnc_randomizeInjuries;
	};
	case 3: {
		_unit setVariable ["kat_chemical_airPoisoning", true, true];
	}
};

deleteVehicle _logic;
