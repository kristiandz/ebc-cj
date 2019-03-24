#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include codjumper\_cj_utility;

init()
{
	//emz\_files::init();
	codjumper\_precache::precache();
	level.script = toLower( getDvar( "mapname" ) );
	level.gametype = toLower( getDvar( "g_gametype" ) );
	level.teamSpawnPoints["allies"] = [];
	level.fontHeight = 12;
	level.teamBased = true;
	thread maps\mp\gametypes\_hud_message::init();
	thread maps\mp\gametypes\_quickmessages::init();
	thread deleteUselessMapStuff();
}

deleteUselessMapStuff()
{
	deletePlacedEntity("misc_turret");
	deletePlacedEntity("misc_mg42");
	arrayForDelete = getentarray( "oldschool_pickup", "targetname" );
	for ( i = 0; i < arrayForDelete.size; i++ )
	{
		if ( isdefined( arrayForDelete[i].target ) )
			getent( arrayForDelete[i].target, "targetname" ) delete();
		arrayForDelete[i] delete();
	}
	wait 0.05;
	AmbientStop( 0 );
}

SetupCallbacks()
{
	level.menuPlayer = ::menuPlayer;
	level.spawnPlayer = ::spawnPlayer;
	level.menuSpectator = ::menuSpectator;
	//level.onPlayerStartedMap = ::onPlayerStartedMap;
	//level.onMapFinished = ::onMapFinished;
}
////////////
onPlayerStartedMap()
{
	self.cj["mapStartTime"] = getTime();
}
onMapFinished() 
{
	level.finishers[level.finishers.size] = self;
	iPrintLn(self.name + " finished the map in: " + self getMapFinishTime());
}
getMapFinishTime()
{
	if(entityInArray(level.finishers,self))
		return secondsToTime(mSecToSec(getTime() - self.cj["mapStartTime"]));

	return false;
} //////////

Callback_PlayerConnect()
{
	if( isDefined( self ) )
		level notify( "connecting", self );
	self waittill( "begin" );
	waittillframeend;
	level notify( "connected", self );
	self setSpectatePermission();
	self.spectatorClient = -1;
	self.sessionteam = "allies";
	iPrintLn(&"MP_CONNECTED",self.name);
	waittillframeend;
	self thread codjumper\_voting_system::initVoteClient();
	self thread codjumper\_cod_jumper_utility::setupDefaults();
	self thread emz\shop::connect();
	logPrint("J;" + self getGuid() + ";" + self getEntityNumber() + ";" + self.name + "\n");
	level.players[level.players.size] = self;
	level endon( "game_ended" );
	[[level.menuPlayer]]();
}

menuPlayer()
{
	self endon( "disconnect" );
	self endon( "joined_spectators" );
	self closeMenu();
	self closeInGameMenu();
	self setClientDvar( "ui_hud_spectator", 0 );
	if(isAlive(self))
		self suicide();
	self notify("joined_team");
	level notify("joined_team", self );
	self.statusicon = "";
	self setclientdvars( "g_scriptMainMenu", "team_marinesopfor" );
	self thread	[[level.spawnPlayer]]();
}

spawnPlayer()
{
	self endon( "disconnect" );
	self endon( "joined_spectators" );
	self notify( "spawned" );
	self notify("refresh_huds"); //
	self.sessionstate = "playing";
	self.cj["team"] = "player";
	//self.pers["team"] = "player"; //
	self.sessionteam = "allies";
	self.maxhealth = 100;
	self.health = 100;
	spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random( maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints( "allies" ) );
	self spawn( spawnPoint.origin, spawnPoint.angles );
	waittillframeend;
	self thread codjumper\_codjumper::onPlayerSpawned();
	self notify("overloopprotect");
	self thread slideshow();
	self notify( "spawned_player" );
	waittillframeend;
}

menuSpectator()
{
	self endon("disconnect");
	self endon("spawned_player");
	self notify("refresh_huds");
	self closeMenu();
	self closeInGameMenu();
	self setClientDvar( "ui_hud_spectator", 1 );
	angles = self getPlayerAngles();
	position = self getOrigin() + (0,0,72); //
	if(isAlive(self))
		self suicide();
	self notify("spawned");
	self notify("joined_spectator");
	level notify("joined_spectator", self );
	self.sessionstate = "spectator";
	self.cj["team"] = "spectator";
	self.pers["team"] = "spectator";
	self.sessionteam = "spectator";
	self spawn( position, angles );
	waittillframeend;
	self thread codjumper\_codjumper::onPlayerSpec();
	self notify( "joined_spectators" );
	waittillframeend;
}

Callback_StartGameType()
{
	game["gamestarted"] = true;
	registerTimeLimitDvar("cj", 10, 1, 1440);
	level.players = [];
	[[level.onStartGameType]]();
	level.startTime = getTime();
	level thread updateGameTypeDvars();
	level thread timeLimitClock();
	thread maps\mp\gametypes\_rank::init();
	thread createParentHUD();
	thread codjumper\_voting_system::initVote();
	thread codjumper\_cod_jumper_utility::init();
	thread emz\shop::main(); //
	thread emz\_holographic::init();
}

setSpectatePermission()
{
	self allowSpectateTeam( "allies", true);
	self allowSpectateTeam( "axis", true );
	self allowSpectateTeam( "none", true );
	self allowSpectateTeam( "freelook", true );
}

Callback_PlayerDisconnect()
{
	self notify("disconnect");
	level notify("disconnect", self);
	logPrint("Q;" + self getGuid() + ";" + self getEntityNumber() + ";" + self.name + "\n");
	for (i = 0; i < level.players.size; i++)
	{
		if (level.players[i] == self)
		{
			while (i < level.players.size - 1)
			{
				level.players[i] = level.players[i + 1];
				i++;
			}
			level.players[i] = undefined;
			break;
		}
	}
}

Callback_PlayerDamage( eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime )
{
	if ( sMeansOfDeath == "MOD_MELEE" || sMeansOfDeath == "MOD_FALLING"|| sMeansOfDeath == "MOD_PROJECTILE" || sMeansOfDeath == "MOD_PROJECTILE_SPLASH" || sMeansOfDeath == "MOD_IMPACT" )
		return;
	if(isDefined(eAttacker) && isPlayer(eAttacker) && !eAttacker isAdmin()  )
		iDamage = 0;
	self finishPlayerDamage( eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime );
	if(isDefined(eAttacker) && isPlayer(eAttacker))
	{
		eAttacker playlocalsound( "MP_hit_alert" );
		eAttacker.hud_damagefeedback.alpha = 1;
		wait 0.5;
		eAttacker.hud_damagefeedback fadeovertime( 0.1 );
		eAttacker.hud_damagefeedback.alpha = 0;
	}
}

Callback_PlayerKilled(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration)
{
	self endon("disconnect");
	eAttacker endon("disconnect");
	self endon( "spawned" );
	if ( self.sessionState == "spectator" )
		return;
	self notify( "killed_player" );
	if (isHeadShot(sHitLoc, sMeansOfDeath))
		sMeansOfDeath = "MOD_HEAD_SHOT";
	obituary(self, eAttacker, sWeapon, sMeansOfDeath);
	waittillframeend;
	self thread	[[level.spawnPlayer]]();
}

isHeadShot(sHitLoc, sMeansOfDeath)
{
	return (sHitLoc == "head" || sHitLoc == "helmet") && sMeansOfDeath != "MOD_MELEE" && sMeansOfDeath != "MOD_IMPACT";
}

endGameWrapper()
{
	if(!isDefined(level.endgamewrapper))
	{
		level.endgamewrapper = true;
		thread emz\_cj_voting::cjVoteCalled("vote_extend10", undefined, undefined, 30);
		level waittill("vote_completed", passed);
		if(!passed)
		{
			wait 3;
			endgame();
		}
		else thread updateGameTypeDvars();
		level.endgamewrapper = false;
	}
}

endGame()
{
	level notify ( "game_ended" );
	wait 0.05;
	exitLevel( false );
}

checkTimeLimit()
{
	if (!isDefined(level.startTime))
		return;
	timeLeft = getTimeRemaining();
	setGameEndTime(getTime() + int(timeLeft));
	if (timeLeft > 0)
		return;
	thread endGameWrapper();
}

getTimeRemaining()
{
	return level.timeLimit * 60000 - getTimePassed();
}

getTimePassed()
{
	if (!isDefined(level.startTime))
		return 0;
	return (gettime() - level.startTime);
}

getValueInRange(value, minValue, maxValue) 
{
    if (value > maxValue)
        return maxValue;
    else if (value < minValue)
        return minValue;
    else
        return value;
}

registerTimeLimitDvar(dvarString, defaultValue, minValue, maxValue) 
{
    dvarString = ("scr_" + dvarString + "_timelimit");
    if (getDvar(dvarString) == "")
        setDvar(dvarString, defaultValue);
    if (getDvarFloat(dvarString) > maxValue)
        setDvar(dvarString, maxValue);
    else if (getDvarFloat(dvarString) < minValue)
        setDvar(dvarString, minValue);
    level.timeLimitDvar = dvarString;
    level.timelimitMin = minValue;
    level.timelimitMax = maxValue;
    level.timelimit = getDvarFloat(level.timeLimitDvar);
    setDvar("ui_timelimit", level.timelimit);
}

timeLimitClock() 
{
    level endon("game_ended");
    wait .05;
    clockObject = spawn("script_origin", (0, 0, 0));
    while (true) 
	{
        if (level.timeLimit) 
		{
            timeLeft = getTimeRemaining() / 1000;
            timeLeftInt = int(timeLeft + 0.5);
            if (timeLeftInt >= 30 && timeLeftInt <= 60)
                level notify("match_ending_soon");
            if (timeLeftInt <= 10 || (timeLeftInt <= 30 && timeLeftInt % 2 == 0)) {
                level notify("match_ending_very_soon");
                if (timeLeftInt == 0)
                    break;
                clockObject playSound("ui_mp_timer_countdown");
            }
            if (timeLeft - floor(timeLeft) >= .05)
                wait timeLeft - floor(timeLeft);
        }
        wait(1.0);
    }
}

updateGameTypeDvars()
{
	level endon ( "game_ended" );
	while (true)
	{
		timeLimit = getValueInRange( getDvarFloat( level.timeLimitDvar ), level.timeLimitMin, level.timeLimitMax );
		if ( timeLimit != level.timeLimit )
		{
			level.timeLimit = timeLimit;
			setDvar( "ui_timelimit", level.timeLimit );
			level notify ( "update_timelimit" );
		}
		thread checkTimeLimit();
		if ( isdefined( level.startTime ) )
		{
			if ( getTimeRemaining() < 3000 )
			{
				wait .1;
				continue;
			}
		}
		wait 1;
	}
	/*
	level notify("ugtd_exit");
	level endon("ugtd_exit");
	*/
}

slideshow()
{
	self endon("disconnect");
	self endon("overloopprotect");
	for(;;)
	{
		self setStat( 1121, 1 );
		x=0;
		while( int(x) <= 9 )
		{
			x++;
			self SetStat(1120, int(x) );
			wait 0.1;
		}
		wait 6;
		
		self setStat( 1121, 2 );
		x=0;
		while( int(x) <= 9 )
		{
			x++;
			self SetStat(1120, int(x) );
			wait 0.1;
		}
		wait 6;
		
		self setStat( 1121, 3 );
		x=0;
		while( int(x) <= 9 )
		{
			x++;
			self SetStat(1120, int(x) );
			wait 0.1;
		}
		wait 6;
	}
}

createParentHUD()
{
	level.uiParent = spawnstruct();
	level.uiParent.horzAlign = "left";
	level.uiParent.vertAlign = "top";
	level.uiParent.alignX = "left";
	level.uiParent.alignY = "top";
	level.uiParent.x = 0;
	level.uiParent.y = 0;
	level.uiParent.width = 0;
	level.uiParent.height = 0;
	level.uiParent.children = [];
}