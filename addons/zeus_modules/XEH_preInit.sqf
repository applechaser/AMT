#include "script_component.hpp"
#include "XEH_PREP.hpp"


[
	QGVAR(unitClassNames),
	"EDITBOX",
	["Classnames to spawn", "Unit classNames seperated by only a comma, DOESN'T CHECK IF IT'S VALID!"],
	"AMT module settings",
	"B_Soldier_F",
	0,
	{
		private _unitsArray = _this splitString ", ";
		if(count _unitsArray == 0) then {
			_unitsArray pushBack "B_Soldier_F";
		};
		missionNamespace setVariable [QGVAR(spawnUnits), _unitsArray, false]
	},
	false
] call CBA_fnc_addSetting;

ADDON = true;