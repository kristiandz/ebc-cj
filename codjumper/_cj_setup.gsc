#include codjumper\_cj_utility;
#include maps\mp\gametypes\_hud_util;

setupDvars()
{
	mapname = getDvar("mapname");
	setDvar("newmap", "New map loaded: " + mapname);
	setDvar("pm", "Insert your message here.");
	setDvar("speed", 1);
	setMapDvar("cj_" + mapname + "_nosave","cj_nosave");//
	setMapDvar("cj_" + mapname + "_disablerpg","cj_disablerpg"); //  ˘˘
	setDvarWrapper("cj_welcome", "5::Welcome to ^1Explicit Bouncers^7 CodJumper Server::2::^1Save Position^7 - DoubleTap ^1[Melee]^7::1::^1Load Position^7 - DoubleTap ^1[Use]^7::1::^1Suicide^7 - Hold ^1[Melee]^7 for 3 seconds");
	
	level._cj_nosave = getDvarInt("cj_nosave"); //
	level.timeLimit = getDvarFloat("cj_timelimit"); //
	level.ggLoopTime = 15;  // 
	level.knockback = getDvar("g_knockback");  // 
	
	if(getDvar("cj_rename") == "")
		setDvar("cj_rename", "UnnamedPlayer");

	if(getDvar("cj_default_disablerpg") == "")
		setDvar("cj_default_disablerpg", getDvarInt("cj_disablerpg"));
	if(getDvar("cj_default_deleteents") == "")
		setDvar("cj_default_deleteents", getDvarInt("cj_deleteents"));
	if(getDvar("cj_default_timelimit") == "")
		setDvar("cj_default_timelimit", getDvarFloat("cj_timelimit"));

	// Map specific 'no-save'
	if(getDvarInt("cj_" + mapname + "_nosave") == 1)
		setDvar("cj_nosave", 1);
	else
		setDvar("cj_nosave", 0);

	/* 0 = Saving On | 1 = Saving Off */
	if(getDvar("cj_nosave") == "")
		setDvar("cj_nosave", 0);
	level._cj_nosave = getDvarInt("cj_nosave");

	/* 0 = No Damage | 1 = All Damage * | 2 = Damage Self */
	if(getDvar("cj_allowdamage") == "")
		setDvar("cj_allowdamage", 0);

	/* 1 = Show Damage | 0 = Damage hidden */
	if(getDvar("cj_showdamage") == "")
		setDvar("cj_showdamage", 1);

	/* 1 = Show Damage | 0 = Hide Damage */
	if(getDvar("cj_showdamage_trigger") == "")
		setDvar("cj_showdamage_trigger", 1);

	/* 0 = Disable Frags | 1 = Enable Frags */
	if(getDvar("cj_enablenades") == "")
		setDvar("cj_enablenades", 0);

	// Map specific RPG
	if(getDvar("cj_" + mapname + "_disablerpg") != "")
		setDvar("cj_disablerpg", getDvarInt("cj_" + mapname + "_disablerpg"));
	else if(getDvar("cj_" + mapname + "_disablerpg") == "")
		setDvar("cj_disablerpg", getDvarInt("cj_default_disablerpg"));
	if(getDvar("cj_disablerpg") == "")
		setDvar("cj_disablerpg", 0);

	// Map Specific ENTs
	if(getDvar("cj_" + mapname + "_deleteents") != "")
		setDvar("cj_deleteents", getDvarInt("cj_" + mapname + "_deleteents"));
	else if(getDvar("cj_" + mapname + "_deleteents") == "")
		setDvar("cj_deleteents", getDvarInt("cj_default_deleteents"));
	if(getDvar("cj_deleteents") == "")
		setDvar("cj_deleteents", 0);

	// Auto Admin GUID promote
	if(getDvar("cj_adminguids") == "")
		setDvar("cj_adminguids", "-1");

	// Auto Admin On/Off
	if(getDvar("cj_autoadmin") == "")
		setDvar("cj_autoadmin", 0);

	// Errors
	if(getDvar("cj_errors") == "")
		setDvar("cj_errors", "");

	// Vote Duration/Lockout/Ratio/Start
	if(getDvar("cj_voteduration") == "")
		setDvar("cj_voteduration", 30);
	level.cjvoteduration = getDvarInt("cj_voteduration");

	if(getDvar("cj_votelockout") == "")
		setDvar("cj_votelockout", 15);
	level.cjvotelockout = getDvarInt("cj_votelockout") + level.cjvoteduration;

	if(getDvar("cj_voteratio") == "")
		setDvar("cj_voteratio", 0.80);
	level.cjvotewinratio = getDvarFloat("cj_voteratio");

	if(getDvar("cj_votedelay") == "")
		setDvar("cj_votedelay", 180);
	level.cjvotedelay = getDvarFloat("cj_votedelay");

	// Map specific time
	if(getDvar("cj_" + mapname + "_timelimit") != "")
		setDvar("cj_timelimit", getDvarFloat("cj_" + mapname + "_timelimit"));
	// If non-map specific, set to default
	else if(getDvar("cj_" + mapname + "_timelimit") == "")
		setDvar("cj_timelimit", getDvarFloat("cj_default_timelimit"));

	// If default was empty, check scr value
	if(getDvar("cj_timelimit") == "" && getDvar("scr_cj_timelimit") != "")
		setDvar("cj_timelimit", getDvarFloat("scr_cj_timelimit"));
	// If all values empty
	//else if(getDvar("cj_timelimit") == "")
		setDvar("cj_timelimit", 50);
	// Set scr value for future use
	setDvar("scr_cj_timelimit", getDvarInt("cj_timelimit"));

	//setDvar("scr_cj_timelimit", 0);

	// Undefined Promote Dvars
	setDvar("cj_promote", "");
	setDvar("cj_soviet_promote", "");
	setDvar("cj_demote", "");

	// Default Weapon Loadouts
	if(getDvar("cj_weapons") == "")
		setDvar("cj_weapons", "usp;;deserteagle::usp;;deserteaglegold::usp;;deserteaglegold");

	// CJ Freerun (C4)
	if(getDvar("cj_freerun") == "")
		setDvar("cj_freerun", 1);

	// Stop stock dvar
	setDvar("scr_cj_scorelimit", 0);

	// Default Vote values
	level.cjVoteInProgress = 0;
	level.cjVoteYes = 0;
	level.cjVoteNo = 0;
	level.cjVoteType = "";
	level.cjVoteCalled = "";
	level.cjVoteAgainst = "";
	level.cjVoteArg = undefined;

	// New Variables
	level._cj_punishLevel = 1; /* 1 = Punish Non-Ranks * 2 = Punish VIP * 3 = Punish Admins * 4 = Punish Soviet?! */

	setDvar( "g_ScoresColor_Spectator", "" );
	setDvar( "g_ScoresColor_Free", "" );
	setDvar( "g_teamColor_MyTeam", "1 1 1 1" );
	setDvar( "g_teamColor_EnemyTeam", "1 1 1 1" );
	setDvar( "g_teamIcon_Allies", "" );
	setDvar( "g_teamIcon_Axis", "" );
	setDvar( "g_teamName_Allies", "Jumpers" );
	setDvar( "g_teamName_Axis", "" );
	setDvar( "g_TeamColor_Allies", "1 1 1" );
	setDvar( "g_ScoresColor_Allies", "0 0 0" );
	setDvar( "g_TeamColor_Axis", "1 1 1" );
	setDvar( "g_ScoresColor_Axis", "0 0 0" );
	
	setDvar("scr_teambalance", 0 );
	setDvar("scr_player_sprinttime", 12.8 );
	setDvar("jump_slowdownenable", 0 );
	setDvar("loc_warnings", 0 );
	setDvar("bg_bobMax", 0 );
	setDvar("g_deadChat", 1 );
	setDvar("scr_oldschool", 0 );
	setDvar("player_sustainAmmo", 0 );
	setDvar("player_throwBackInnerRadius", 0 );
	setDvar("player_throwBackOuterRadius", 0 );
	setDvar("bg_fallDamageMaxHeight", 9999 );
	setDvar("bg_fallDamageMinHeight", 9998 );
	
	forceDvar("sv_disableClientConsole", "0" );
	forceDvar("sv_fps", "20" );
	forceDvar("sv_pure", "1" );
	forceDvar("sv_maxrate", "25000" );
	forceDvar("g_gravity", "800" );
	forceDvar("g_speed", "190" );
	forceDvar("g_knockback", "1000" );
	forceDvar("g_playercollisionejectspeed", "25" );
	forceDvar("g_dropforwardspeed", "10" );
	forceDvar("g_drophorzspeedrand", "100" );
	forceDvar("g_dropupspeedbase", "10" );
	forceDvar("g_dropupspeedrand", "5" );
	forceDvar("g_useholdtime", "0" );
	// Test
	if(getdvar("scr_mapsize") == "")
		setdvar("scr_mapsize", "64");
	else if(getdvarFloat("scr_mapsize") >= 64)
		setdvar("scr_mapsize", "64");
	else if(getdvarFloat("scr_mapsize") >= 32)
		setdvar("scr_mapsize", "32");
	else if(getdvarFloat("scr_mapsize") >= 16)
		setdvar("scr_mapsize", "16");
	else
		setdvar("scr_mapsize", "8");
	level.mapsize = getdvarFloat("scr_mapsize");

	constrainMapSize(level.mapsize);
}

constrainMapSize(mapsize)
{
	entities = getentarray();
	for(i = 0; i < entities.size; i++)
	{
		entity = entities[i];
		
		if(int(mapsize) == 8)
		{
			if(isdefined(entity.script_mapsize_08) && entity.script_mapsize_08 != "1")
				entity delete();
		}
		else if(int(mapsize) == 16)
		{
			if(isdefined(entity.script_mapsize_16) && entity.script_mapsize_16 != "1")
				entity delete();
		}
		else if(int(mapsize) == 32)
		{
			if(isdefined(entity.script_mapsize_32) && entity.script_mapsize_32 != "1")
				entity delete();
		}
		else if(int(mapsize) == 64)
		{
			if(isdefined(entity.script_mapsize_64) && entity.script_mapsize_64 != "1")
				entity delete();
		}
	}
}

forceDvar(dvar, value) 
{
	if( getDvar( dvar ) != value ) setDvar( dvar, value );
}

setupLanguage()
{
	self.cj["local"]["NOPOS"] 		= &"CJ_NOPOS";
	self.cj["local"]["POSLOAD"] 	= &"CJ_POSLOAD";
	self.cj["local"]["SAVED"] 		= &"CJ_SAVED";
	self.cj["local"]["PROMOTED"] 	= &"CJ_PROMOTED";
	self.cj["local"]["DEMOTED"]		= &"CJ_DEMOTED";
	self.cj["local"]["NOSAVE"] 		= &"CJ_NOSAVE";
	self.cj["local"]["NOSAVEZONE"] 	= &"CJ_NOSAVEZONE";
	self.cj["local"]["PREVPOS"] 	= &"CJ_PREVPOS";
	self.cj["local"]["NOPREVPOS"] 	= &"CJ_NOPREVPOS";
}

setupPlayer()
{
	self endon("disconnect");
	self.cj = [];
	self.cj["save"] = [];
	self.cj["hud"] = [];

	self.ebc = [];
	self.ebc["speed"] = false;
	
	if(!isDefined(self.cj["status"]))
		self.cj["status"] = 0;
	
	// SEM
	self.cj["loads"] = 0;
	self.cj["saves"] = 0;
	self.cj["jumps"] = 0;
	self.cj["maxfps"] = self getMaxFPS();
	self.cj["spawned"] = 0;
	self.cj["lastCheckPointTime"] = getTime();
	self.cj["checkpoint"] = 0;
	self.cj["progress"] = 0;	
	self.cj["lastvotetime"] = getTime();
	self.cj["connectTime"] = getTime();
	// Cheats (UFO,TP,TPTO,TPHERE,RP)
	self.cj["cheats"] = 1;	// Voting
	self.cj["vote"] = [];
	self.cj["vote"]["novoting"] = false;
	self.cj["vote"]["delayed"] = true;
	self.cj["vote"]["voted"] = false;
	// Times
	self.cj["time"] = [];
	self.cj["time"]["played"] = 0;
	self.cj["time"]["count"] = 0;
	// Admin Menu
	self.cj["admin"] = [];
	// Punishment - Freeze
	self.cj["admin"]["frozen"] = 0;
	// Trigger Damage
	self.cj["trigWait"] = 0;
	// cjscripts defaults
	self.cj["rpgswitch"] = 0;
	self.cj["rpgsustain"] = 0;
	self.client_respawns = 0;
	self.cj["ggUsedTime"] = 0;
	self initHudStuff();

	if(!isDefined(self.cj["positionLog"]))
		self.cj["positionLog"] = [];
	
	//self setClientDvars("fx_marks", 1, "player_sprintTime", 12.8, "player_sprintRechargePause", 0, "cg_everyoneHearsEveryone", 1, "aim_automelee_range", 0, "r_filmUseTweaks", 1 );
	self setClientDvar("cg_drawtime", 1);
	self setClientDvar("cg_drawIprintlnbold", 1);
	self setClientDvar("cg_drawMinimap", 1 );
}

initHudStuff()
{
	self.hud_damagefeedback = newClientHudElem( self );
	self.hud_damagefeedback.horzAlign = "center";
	self.hud_damagefeedback.vertAlign = "middle";
	self.hud_damagefeedback.x = -12;
	self.hud_damagefeedback.y = -12;
	self.hud_damagefeedback.alpha = 0;
	self.hud_damagefeedback.archived = true;
	self.hud_damagefeedback setShader("damage_feedback", 24, 48);
}