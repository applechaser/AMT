#include "..\script_component.hpp"

params ["_control"];

private _display = ctrlParent _control;
private _ctrlButtonOK = _display displayCtrl 1;
private _logic = missionNamespace getVariable ["BIS_fnc_initCuratorAttributes_target", objNull];

_control ctrlRemoveAllEventHandlers "SetFocus";


//Update tooltip if slider moves
private _fnc_sliderMove = {
    params ["_slider"];
    private _idc = ctrlIDC _slider;
	_slider ctrlSetTooltip format ["%1", parseNumber((sliderPosition _slider) toFixed 2)];
};

//Amount Slider control
private _slider = _display displayCtrl 3815;
_slider sliderSetRange [1,10];
_slider sliderSetSpeed [1,1,1];
_slider sliderSetPosition 1;
_slider ctrlAddEventHandler ["SliderPosChanged", _fnc_sliderMove];
[_slider] call _fnc_sliderMove;

//Spawn radius slider control
private _sliderRadius = _display displayCtrl 3816;
_sliderRadius sliderSetRange [1,100];
_sliderRadius sliderSetSpeed [1,1,1];
_sliderRadius sliderSetPosition 10;
_sliderRadius ctrlAddEventHandler ["SliderPosChanged", _fnc_sliderMove];
[_sliderRadius] call _fnc_sliderMove;



//Close the menu
private _fnc_onUnload = {
    private _logic = missionNamespace getVariable ["BIS_fnc_initCuratorAttributes_target", objNull];
    if (isNull _logic) exitWith {};

    deleteVehicle _logic;
};

//Spawn patients if confirm is pressed
private _fnc_OnConfirm = {
    params [["_ctrlButtonOK", controlNull, [controlNull]]];

    private _display = ctrlParent _ctrlButtonOK;
    if (isNull _display) exitWith {};

    private _logic = missionNamespace getVariable ["BIS_fnc_initCuratorAttributes_target", objNull];
    if (isNull _logic) exitWith {};

	//get ui inputs
    private _amount = sliderPosition (_display displayCtrl 3815);
    private _type = lbCurSel (_display displayCtrl 3814);
    private _radius = sliderPosition(_display displayCtrl 3816);
    private _fill = false; //cbChecked(_display displayCtrl 3817);

   [_logic, _amount, _type, _radius, _fill] call FUNC(spawnPatientModule);
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];