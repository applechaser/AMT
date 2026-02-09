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

switch (_type) do {
	case 0: {	//random light
		[_unit, 10 + random 6 - 3, "Head", "grenade"] call ace_medical_fnc_addDamageToUnit;
		[_unit, 1.5 + random 2 - 1, "Body", "grenade"] call ace_medical_fnc_addDamageToUnit;
		[_unit, 3 + random 2 - 1, "LeftArm", "bullet"] call ace_medical_fnc_addDamageToUnit;
		[_unit, 2 + random 1 - 0.5, "LeftLeg", "falling"] call ace_medical_fnc_addDamageToUnit;
		[_unit, 4.5 + random 3 - 1.5, "RightLeg", "bullet"] call ace_medical_fnc_addDamageToUnit;
		_unit setVariable ["kat_airway_occluded", true, true];
		_unit setVariable ["ace_medical_fractures", [0,0,0,0,1,0], true];
	};
	case 1: {	//random medium
		[_unit, 10 + random 6 - 3, "Head", "grenade"] call ace_medical_fnc_addDamageToUnit;
		[_unit, 4 + random 2, "Body", "grenade"] call ace_medical_fnc_addDamageToUnit;
		[_unit, 4.5 + random 2 - 1, "LeftArm", "bullet"] call ace_medical_fnc_addDamageToUnit;
		[_unit, 4.5 + random 2 - 1, "RightArm", "shell"] call ace_medical_fnc_addDamageToUnit;
		[_unit, 4 + random 2, "LeftLeg", "falling"] call ace_medical_fnc_addDamageToUnit;
		[_unit, 4.5 + random 2.5 - 1, "RightLeg", "bullet"] call ace_medical_fnc_addDamageToUnit;
		_unit setVariable ["kat_airway_occluded", true, true];
		_unit setVariable ["kat_airway_obstruction", true, true];
		_unit setVariable ["ace_medical_fractures", [0,0,0,1,1,0], true];
	};
	case 2: {	//random heavy
		[_unit, 20 + random 10 - 5, "Head", "explosive"] call ace_medical_fnc_addDamageToUnit;
		[_unit, 10 + random 6 - 3, "Body", "grenade"] call ace_medical_fnc_addDamageToUnit;
		[_unit, 20 + random 10 - 5, "LeftArm", "bullet"] call ace_medical_fnc_addDamageToUnit;
		[_unit, 10 + random 8 - 2, "RightArm", "shell"] call ace_medical_fnc_addDamageToUnit;
		[_unit, 4 + random 2 - 1, "LeftLeg", "falling"] call ace_medical_fnc_addDamageToUnit;
		[_unit, 4 + random 2 - 1, "RightLeg", "grenade"] call ace_medical_fnc_addDamageToUnit;
		_unit setVariable ["kat_airway_occluded", true, true];
		_unit setVariable ["kat_airway_obstruction", true, true];
		_unit setVariable ["ace_medical_fractures", [0,0,1,1,1,1], true];
	};
	case 3: {
		_unit setVariable ["kat_chemical_airPoisoning", true, true];
	}
};

deleteVehicle _logic;
