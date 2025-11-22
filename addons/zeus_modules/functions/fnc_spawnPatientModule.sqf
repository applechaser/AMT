#include "..\script_component.hpp"
/*
	Author: applechaser

	Description:
		spawns a patient

	Parameter(s):
		0: 	_logic	-	_logic
		1:	int		-	amount of patients to spawn
		2: 	int		- 	type of casualty
		3: 	int		-	radius to spawn casualties in
		4: 	bool	-	fill vehicle if module is attached to one





	Returns:
		nothing

	Examples:
		<example>
*/

params ["_logic","_amount", "_type", "_radius", "_fill"];

//FYI:
//private _bodyparts = ["Head", "Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg"];
//private _damageTypes = ["bullet", "grenade", "explosive", "shell", "vehiclehit", "vehiclecrash", "collision", "falling", "backlast", "stab", "punch", "ropeburn", "drowning", "fire", "burn", "unkown"];


//spawn in vehicle if module is attached to one
private _vehicle = attachedTo _logic;
private _group = createGroup civilian;
if(_vehicle isKindOf "LandVehicle" || _vehicle isKindOf "Air" || _vehicle isKindOf "Ship") then {
	_group = group _vehicle;
	//check passenger seats left
	private _seats = _vehicle emptyPositions "CargoNoFFV";
	if(_fill) then {
		_amount = _seats;
	} else{
		_amount = _amount min _seats;
	};
};


//spawn the patient(s)
for "i" from 1 to _amount do {
	private _unit = _group createUnit [selectRandom (missionNamespace getVariable [QGVAR(spawnUnits), []]), position _logic, [], _radius, "CARGO"];
	_unit setVariable ["kat_vitals_simpleMedical", false, true];

	publicVariable "_unit";
	
	//set captive
	[_unit, true] call ace_captives_fnc_setHandcuffed;

	//get injuries based on casualty type
	switch (_type) do {
		case 0: {	//set light
			[_unit, 10, "Head", "grenade"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 1.5, "Body", "grenade"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 3, "LeftArm", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 2, "LeftLeg", "falling"] call ace_medical_fnc_addDamageToUnit;
			_unit setVariable ["ace_medical_fractures", [0,0,0,0,1,0], true];
			[_unit, 4.5, "RightLeg", "bullet"] call ace_medical_fnc_addDamageToUnit;
			_unit setVariable ["kat_airway_occluded", true, true];
		};
		case 1: {	//set medium
			[_unit, 10, "Head", "grenade"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 4, "Body", "grenade"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 4.5, "LeftArm", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 4.5, "RightArm", "shell"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 4, "LeftLeg", "falling"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 4.5, "RightLeg", "bullet"] call ace_medical_fnc_addDamageToUnit;
			_unit setVariable ["kat_airway_occluded", true, true];
			_unit setVariable ["kat_airway_obstruction", true, true];
			_unit setVariable ["ace_medical_fractures", [0,0,0,1,1,0], true];
		};
		case 2: {	//set heavy
			[_unit, 20, "Head", "explosive"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 10, "Body", "grenade"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 20, "LeftArm", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 10, "RightArm", "shell"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 4, "LeftLeg", "falling"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 4, "RightLeg", "grenade"] call ace_medical_fnc_addDamageToUnit;
			_unit setVariable ["kat_airway_occluded", true, true];
			_unit setVariable ["kat_airway_obstruction", true, true];
			_unit setVariable ["ace_medical_fractures", [0,0,1,1,1,1], true];
		};
		case 3: {	//dead
			//add some damage so it makes sense
			[_unit, 10, "Head", "grenade"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 4, "Body", "grenade"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 4.5, "LeftArm", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 4.5, "RightArm", "shell"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 4, "LeftLeg", "falling"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 4.5, "RightLeg", "bullet"] call ace_medical_fnc_addDamageToUnit;
			_unit setVariable ["ace_medical_fractures", [0,0,0,1,1,0], true];
			_unit setDamage 1;
		};
		case 4: {	//random light
			[_unit, 10 + random 6 - 3, "Head", "grenade"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 1.5 + random 2 - 1, "Body", "grenade"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 3 + random 2 - 1, "LeftArm", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 2 + random 1 - 0.5, "LeftLeg", "falling"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 4.5 + random 3 - 1.5, "RightLeg", "bullet"] call ace_medical_fnc_addDamageToUnit;
			_unit setVariable ["kat_airway_occluded", true, true];
			_unit setVariable ["ace_medical_fractures", [0,0,0,0,1,0], true];
		};
		case 5: {	//random medium
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
		case 6: {	//random heavy
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
	};
};
deleteVehicle _logic;