class CfgVehicles {
	class Module_F;

	class GVAR(baseModule) : Module_F {
		author = "Applechaser";
		category = QGVAR(AMT);
		function = "";
		functionPriority = 50;
		isGlobal = 1;
		isTriggerActivated = 0;
		scope = 1;
		scopeCurator = 2;
		side = 7;
	};

	class GVAR(moduleSpawnPatient) : GVAR(baseModule) {
		displayName = "Spawn patients";
		curatorInfoType = QGVAR(RscspawnPatient);
		curatorCanAttach = 1;
	};

	class GVAR(moduleAddInjury) : GVAR(baseModule) {
		displayName = "add injury to unit";
		curatorInfoType = QGVAR(RscaddInjury);
		curatorCanAttach = 1;
	};
};