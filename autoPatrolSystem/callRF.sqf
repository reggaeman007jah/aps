
// CALL RF ---------------------------------------------------------------------------------------------------
//
// Will replenish lost troops as per trigger rules
//
// Currently fixed number, but may look to into maybe AT if OPFOR have vehicles
//
// -----------------------------------------------------------------------------------------------------------

// refernce data 
_rfDestination = (_this select 0);
_rfSpawn = (_this select 1);
/*
_rfSpawn = _rfDestination getPos [300,180];//300m south of key fighting point
this works but lets see if I can pass the dynamic start point into this script also
*/

// player info
systemChat "Reinforcements are inbound";

// spawn loop
for "_i" from 1 to 5 do // trooper
{
	bluGroup = createGroup west;
	_pos = [_rfSpawn, 0, 40] call BIS_fnc_findSafePos;
	_unit = bluGroup createUnit ["b_soldier_m_f", _pos, [], 0.1, "none"]; 

	// loadout purge
	removeAllWeapons _unit;
	removeAllItems _unit;
	removeAllAssignedItems _unit;
	removeUniform _unit;
	removeVest _unit;
	removeBackpack _unit;
	removeHeadgear _unit;
	removeGoggles _unit;

	// containers
	_unit forceAddUniform "U_B_CombatUniform_mcam_vest";
	_unit addItemToUniform "FirstAidKit";
	_unit addItemToUniform "Chemlight_green";
	for "_i" from 1 to 2 do {_unit addItemToUniform "SMA_30Rnd_556x45_M855A1";};
	_unit addVest "V_TacVest_oli";
	for "_i" from 1 to 12 do {_unit addItemToVest "SMA_30Rnd_556x45_M855A1";};
	_unit addBackpack "B_AssaultPack_mcamo_Ammo";
	for "_i" from 1 to 8 do {_unit addItemToBackpack "FirstAidKit";};
	_unit addItemToBackpack "100Rnd_65x39_caseless_mag";
	_unit addItemToBackpack "NLAW_F";
	for "_i" from 1 to 2 do {_unit addItemToBackpack "HandGrenade";};
	for "_i" from 1 to 2 do {_unit addItemToBackpack "MiniGrenade";};
	for "_i" from 1 to 8 do {_unit addItemToBackpack "1Rnd_HE_Grenade_shell";};
	_unit addItemToBackpack "3Rnd_HE_Grenade_shell";
	_unit addItemToBackpack "10Rnd_338_Mag";
	_unit addItemToBackpack "16Rnd_9x21_Mag";
	for "_i" from 1 to 4 do {_unit addItemToBackpack "1Rnd_SmokeYellow_Grenade_shell";};
	for "_i" from 1 to 5 do {_unit addItemToBackpack "rhs_mag_rgo";};
	_unit addHeadgear "H_HelmetB_grass";
	_unit addGoggles "G_Bandanna_sport";

	// weapons
	_unit addWeapon "SMA_MK18TAN_GL";
	_unit addPrimaryWeaponItem "acc_pointer_IR";
	_unit addPrimaryWeaponItem "optic_Arco_blk_F";
	_unit addWeapon "hgun_P07_F";
	_unit addWeapon "Binocular";

	// items
	_unit linkItem "ItemMap";
	_unit linkItem "ItemCompass";
	_unit linkItem "ItemWatch";
	_unit linkItem "ItemRadio";
	_unit linkItem "ItemGPS";
	_unit linkItem "O_NVGoggles_ghex_F";


	_unit setFace "GreekHead_A3_09";

	// orders
	_randomDir = selectRandom [270, 310, 00, 50, 90];
	_randomDist = selectRandom [20, 22, 24, 26, 28, 30];
	_endPoint1 = _rfDestination getPos [_randomDist,_randomDir];
	_unit doMove _endPoint1;

	// behaviour
	_unit setUnitPos "AUTO";
	_unit setBehaviour "AWARE";

	// Debug and loop mgmt
	// systemchat "debug - rf trooper created";
	sleep 1;
};
