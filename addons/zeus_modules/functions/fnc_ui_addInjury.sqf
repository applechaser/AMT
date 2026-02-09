#include "..\script_component.hpp"

params ["_control"];


private _display = ctrlParent _control;
private _ctrlButtonOK = _display displayCtrl 1;
private _logic = missionNamespace getVariable ["BIS_fnc_initCuratorAttributes_target", objNull];

_control ctrlRemoveAllEventHandlers "SetFocus";

private _unit = attachedTo _logic;



private _fnc_error = {
    params["_errorMsg"];
    _display closeDisplay 0;
    deleteVehicle _logic;
    [objNull, _errorMsg] call BIS_fnc_showCuratorFeedbackMessage;
};

//check if module is attached to infantry
if (isNull _unit) then {
    ["place on a unit!"] call _fnc_error;
};
if !(_unit isKindOf "CAManBase") then {
    ["unit must be infantry! "] call _fnc_error;
};


//Close the menu
private _fnc_onUnload = {
    private _logic = missionNamespace getVariable ["BIS_fnc_initCuratorAttributes_target", objNull];
    if (isNull _logic) exitWith {};

    deleteVehicle _logic;
};

//add injuries if confirm is pressed
private _fnc_OnConfirm = {
	params [["_ctrlButtonOK", contrulNull, [controlNull]]];

    private _display = ctrlParent _ctrlButtonOK;
    if (isNull _display) exitWith {};

    private _logic = missionNamespace getVariable ["BIS_fnc_initCuratorAttributes_target", objNull];
    if (isNull _logic) exitWith {};

	//get ui inputs
    private _type = lbCurSel (_display displayCtrl 3941);

	[_logic, _type] call FUNC(addInjury);
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
