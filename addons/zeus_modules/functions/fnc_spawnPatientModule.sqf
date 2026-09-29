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
		4: 	bool	-	array to use (0 = unit array 1, 1 = unit array 2)





	Returns:
		nothing

	Examples:
		<example>
*/

params ["_logic","_amount", "_type", "_radius", "_array"];

//FYI:
//private _bodyparts = ["Head", "Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg"];
//private _damageTypes = ["bullet", "grenade", "explosive", "shell", "vehiclehit", "vehiclecrash", "collision", "falling", "backlast", "stab", "punch", "ropeburn", "drowning", "fire", "burn", "unkown"];


private _group = createGroup civilian;

//play explosion sound because funni
playSound3D ["a3\sounds_f\weapons\explosion\expl_big_1.wss", None, false, position _logic, 2, 1, 0];

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

//spawn the patient(s)
for "i" from 1 to _amount do {
	private _unit = _group;
	//create unit from selected array
	switch (_array) do{
		case 0: {
			_unit = _group createUnit [selectRandom (missionNamespace getVariable [QGVAR(spawnUnits1), []]), position _logic, [], _radius, "CARGO"];
		};
		case 1: {
			_unit = _group createUnit [selectRandom (missionNamespace getVariable [QGVAR(spawnUnits2), []]), position _logic, [], _radius, "CARGO"];
		};
	};
	
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
			_unit setVariable ["kat_surgery_fractures", [0,0,0,0,1,0], true];
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
			_unit setVariable ["kat_surgery_fractures", [0,0,0,1,2,0], true];
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
			_unit setVariable ["kat_surgery_fractures", [0,0,1,2,2,2], true];
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
			_unit setVariable ["kat_surgery_fractures", [0,0,0,1,1,0], true];
			_unit setDamage 1;
		};
		case 4: {	//random light
			[_unit, 10 + random 6 - 3, "Head", "grenade"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 1.5 + random 2 - 1, "Body", "grenade"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 3 + random 2 - 1, "LeftArm", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 2 + random 1 - 0.5, "LeftLeg", "falling"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 4.5 + random 3 - 1.5, "RightLeg", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 0] call _fnc_randomizeInjuries;
		};
		case 5: {	//random medium
			[_unit, 10 + random 6 - 3, "Head", "grenade"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 4 + random 2, "Body", "grenade"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 4.5 + random 2 - 1, "LeftArm", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 4.5 + random 2 - 1, "RightArm", "shell"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 4 + random 2, "LeftLeg", "falling"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 4.5 + random 2.5 - 1, "RightLeg", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 1] call _fnc_randomizeInjuries;
		};
		case 6: {	//random heavy
			[_unit, 25 + random 10 - 5, "Head", "explosive"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 15 + random 6 - 3, "Body", "grenade"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 25 + random 10 - 5, "LeftArm", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 15 + random 8 - 2, "RightArm", "shell"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 10 + random 2 - 1, "LeftLeg", "falling"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 10 + random 2 - 1, "RightLeg", "grenade"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 2] call _fnc_randomizeInjuries;
		};
		case 7: {	//catastrophic
			[_unit, 800, "Head", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 800, "Head", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 800, "Head", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 800, "Head", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 400, "Body", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 400, "Body", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 400, "Body", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 400, "Body", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 800, "LeftArm", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 800, "LeftArm", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 800, "LeftArm", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 800, "LeftArm", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 400, "RightArm", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 400, "RightArm", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 400, "RightArm", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 400, "RightArm", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 1000, "LeftLeg", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 1000, "LeftLeg", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 1000, "LeftLeg", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 1000, "LeftLeg", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 500, "RightLeg", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 500, "RightLeg", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 500, "RightLeg", "bullet"] call ace_medical_fnc_addDamageToUnit;
			[_unit, 500, "RightLeg", "bullet"] call ace_medical_fnc_addDamageToUnit;
		};
	};
};
deleteVehicle _logic;
