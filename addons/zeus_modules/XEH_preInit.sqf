#include "script_component.hpp"
#include "XEH_PREP.hpp"

//first classname array
[
	QGVAR(unitClassNames1),
	"EDITBOX",
	["Classnames to spawn", "Unit classNames seperated by only a comma, DOESN'T CHECK IF IT'S VALID!"],
	"AMT module settings",
	"B_Soldier_F",
	0,
	{
		private _unitsArray = _this splitString ", ";
		if(_unitsArray isEqualTo []) then {
			_unitsArray pushBack "B_Soldier_F";
		};
		missionNamespace setVariable [QGVAR(spawnUnits1), _unitsArray, false]
	},
	false
] call CBA_fnc_addSetting;

//second classname array
[
	QGVAR(unitClassNames2),
	"EDITBOX",
	["Classnames to spawn", "Unit classNames seperated by only a comma, DOESN'T CHECK IF IT'S VALID!"],
	"AMT module settings",
	"C_man_1",
	0,
	{
		private _unitsArray = _this splitString ", ";
		if(_unitsArray isEqualTo []) then {
			_unitsArray pushBack "C_man_1";
		};
		missionNamespace setVariable [QGVAR(spawnUnits2), _unitsArray, false]
	},
	false
] call CBA_fnc_addSetting;

ADDON = true;
