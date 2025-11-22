#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		name = "AMT";
		author = "applechaser";
		units[] = {
			QGVAR(moduleSpawnPatient),
			QGVAR(moduleAddInjury),
			};
		requiredVersion = 1.0;
		requiredAddons[] = { "cba_main" };
	};
};

#include "CfgVehicles.hpp"
#include "CfgFactionClasses.hpp"
#include "CfgEventhandlers.hpp"
#include "ui\RscAttributes.hpp"