#include codjumper\_cj_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

init()
{   
	level.votesize = int(1);
	codjumper\_cj_setup::setupDvars();                          // Dvars
	thread emz\_checkpoints::init();
	thread emz\ninja_serverfile::init();
	thread emz\_cj_voting::voteCancelled();
	thread emz\_cj_voting::voteForced();
    thread codjumper\_cj_admins::adminInit();               	// Pro/Demote
    thread codjumper\_cj_mappers::init();                       // Mappers stuff
	thread addons\wasd::main();								// WASD Visual
	
	addons\addon::init();
    thread RemoveTurrets();     								// Remove Turrets
    thread onPlayerConnect();   								// OnPlayerConnect
    thread rotateMessage();     								// Rotating Messages
    thread _svr_msg();              							// Send Server Message
    thread _player_msg();           							// Send Private Message
}

onPlayerConnect()
{
    for(;;) 
	{
        level waittill("connected", player);
        player codjumper\_cj_setup::setupPlayer();
        player codjumper\_cj_setup::setupLanguage();
        player thread codjumper\_cj_admins::checkAdmin();
		player thread codjumper\_menus::onMenuResponse();
		player thread emz\_cj_voting::playerList();
		//player thread emz\_cj_voting::mapBrowse();
    }
}

onPlayerSpec()
{
	self thread emz\_hud::onJoinedSpectators();
    for (;;) 
	{
        self waittill("joined_spectators");
    }
}

onPlayerSpawned() 
{
	self endon("disconnect");
    self waittill("spawned_player");
    self notify("endcommands");
    self thread _MeleeKey();
    self thread _UseKey();
    self thread weaponSetup();
    self thread removePerks();
    self thread checkSuicide();
    self thread setPlayerModel();
	self thread doWelcomeMessages();
	self thread codjumper\_graphic_menu_load::onPlayerSpawn();
	
	self thread emz\_hud::drawInfoHud();
	self thread emz\shop::spawnplayer();
	
	if(!self.cj["spawned"])
	{
		//self thread [[level.onPlayerStartedMap]]();
		self.cj["spawned"] = true;
		self.cj["save"]["org0"] = self getOrigin();
		self.cj["save"]["ang0"] = self getPlayerAngles();
		wait 0.1;
		self execClientCommand("setfromdvar temp0 com_maxfps; setu com_maxfps 125; setfromdvar com_maxfps temp0");
	}
	waittillframeend;
	self thread addons\_velocity::toggleSpeedHud();
}

_MeleeKey() 
{
    self endon("disconnect");
    self endon("killed_player");
    self endon("joined_spectators");

    for(;;)
    {
        if(self meleeButtonPressed())
        {
            catch_next = false;
            count = 0;
            for(i=0; i<0.5; i+=0.05)
            {
                if(catch_next && self meleeButtonPressed() && self isOnGround())
                {
                    self thread [[level._cj_save]](1);
                    wait 1;
                    break;
                }
                else if(catch_next && self attackButtonPressed() && self isOnGround())
                {
                    while(self attackButtonPressed() && count < 1)
                    {
                        count+=0.1;
                        wait 0.1;
                    }
                    if(count >= 1 && self isOnGround())
                        self thread [[level._cj_save]](3);
                    else if(count < 1 && self isOnGround())
                        self thread [[level._cj_save]](2);
                    wait 1;
                    break;
                }
                else if(!(self meleeButtonPressed()) && !(self attackButtonPressed()))
                    catch_next = true;
                wait 0.05;
            }
        }
        wait 0.05;
    }
}

setPlayerModel()
{
    self detachHead();
	self setModel("body_mp_sas_urban_assault");
}

detachHead() 
{
    self endon ("joined_spectators");
    count = self getattachsize();
    for (index = 0; index < count; index++) 
	{
        head = self getattachmodelname(index);
        if (startsWith(head, "head")) 
		{
            self detach(head);
            break;
        }
    }
}

startsWith(string, pattern) 
{
    if (string == pattern)
        return true;
    if (pattern.size > string.size)
        return false;
    for (index = 0; index < pattern.size; index++) 
	{
        if (string[index] != pattern[index])
            return false;
    }
    return true;
}

_UseKey()
{
    self endon("disconnect");
    self endon("killed_player");
    self endon("joined_spectators");

    for(;;)
    {
        if(self useButtonPressed())
        {
            catch_next = false;
            count = 0;

            for(i=0; i<=0.5; i+=0.05)
            {
                if(catch_next && self useButtonPressed() && !(self isMantling()))
                {
                    self thread [[level._cj_load]](1);
                    wait 1;
                    break;
                }
                else if(catch_next && self attackButtonPressed() && !(self isMantling()))
                {
                    while(self attackButtonPressed() && count < 1)
                    {
                        count+= 0.1;
                        wait 0.1;
                    }
                    if(count < 1 && self isOnGround() && !(self isMantling()))
                        self thread [[level._cj_load]](2);
                    else if(count >= 1 && self isOnGround() && !(self isMantling()))
                        self thread [[level._cj_load]](3);
                    wait 1;
                    break;
                }
                else if(!(self useButtonPressed()))
                    catch_next = true;
                wait 0.05;
            }
        }
        wait 0.05;
    }
}

checkSuicide()
{
    self endon("disconnect");
    self endon("joined_spectators");
    self endon("killed_player");
    while(1)
    {
        i = 0;
        while(!self meleeButtonPressed())
            wait 0.05;
        while(self meleeButtonPressed() && i <= 2)
        {
            wait 0.05;
            i+=0.05;
        }
        if(i >= 2)
            self suicide();
    }
}

weaponSetup()
{
	self endon("disconnect");
	
	wait 0.05;
	self takeAllWeapons();
	self detachAll();
	if(!self _isPlayer())
	{
		self setClientDvar("currentmodel", tableLookup( "mp/modelTable.csv", 0, self getStat(100), 1 ));
		self setModel(tableLookup( "mp/modelTable.csv", 0,  self getStat(100), 2 ));
		self setViewModel(tableLookup( "mp/modelTable.csv", 0,  self getStat(100), 3 ));
	}
	else if(self getStat(1169)!=0)
	{
		self setModel(level.shopmodel[self getStat(1169)][0]);
		self setClientDvar("shopmodel",level.shopmodel[self getStat(1169)][1]);
		self setViewModel("viewhands_usmc");
	}
	else
	{
		self setModel("body_mp_sas_urban_assault");
		self setViewModel("viewhands_usmc");
	}
	self clearPerks();
	self setPerk("specialty_longersprint");
	self setPerk("specialty_fastreload");
	self giveWeapon("rpg_mp");
	self giveMaxAmmo("rpg_mp");
	self setActionSlot( 4, "weapon", "rpg_mp" );
	self giveWeapon( "deserteagle_mp" );
	self setWeaponAmmoClip("deserteagle_mp", 0);
	self setWeaponAmmoStock("deserteagle_mp", 0);
	wait 0.05;
	self switchToWeapon( "deserteagle_mp" );
	if (self isAdmin())
	{
		self giveWeapon("gravitygun_mp");
		self giveWeapon("deserteaglegold_mp");
		self giveMaxAmmo( "gravitygun_mp" );	
		self giveMaxAmmo( "deserteaglegold_mp" );	
		self giveMaxAmmo( "deserteagle_mp" );
		self setWeaponAmmoClip("deserteagle_mp", 7);
		self setActionSlot( 3, "weapon", "gravitygun_mp" );
	}
	else if(self isVip())
	{
		self giveWeapon("gravitygun_mp");
		self giveMaxAmmo( "gravitygun_mp" );	
		self giveMaxAmmo( "deserteagle_mp" );
		self setActionSlot( 3, "weapon", "gravitygun_mp" );
	}
	else
		self thread gravityGun();
}

rpgCheck()
{
    self endon("disconnect");
    self endon("joined_spectators");
    self endon("killed_player");
    while(1)
    {
        while (self getCurrentWeapon() != "rpg_mp" && self getCurrentWeapon() != "rpg_sustain_mp")
            wait 1;

        if(self getAmmoCount("rpg_mp") < 2)
            self giveMaxAmmo("rpg_mp");
        if (self getAmmoCount("rpg_sustain_mp") < 2)
            self giveMaxAmmo("rpg_sustain_mp");
        wait 1;
    }
}

removePerks()
{
    self endon("disconnect");
    self endon("joined_spectators");
    self endon("killed_player");

    self clearPerks();
    self setPerk("specialty_longersprint");
    self setPerk("specialty_armorvest");
    self setPerk("specialty_fastreload");

    if(self.cj["status"] >= 1)
    {
        self setPerk("specialty_holdbreath");
        self setPerk("specialty_quieter");
    }

    //self showPerk( 0, "specialty_longersprint", -50 );
    //self showPerk( 1, "specialty_armorvest", -50 );
    //self showPerk( 2, "specialty_fastreload", -50 );
    //self thread maps\mp\gametypes\_globallogic::hidePerksAfterTime( 3.0 );
    //self thread maps\mp\gametypes\_globallogic::hidePerksOnDeath();
}

doWelcomeMessages()
{
    self endon("disconnect");
    if(isDefined(self.cj["welcome"]))
        return;
    msg = getDvar("cj_welcome");
    tokens = strTok(msg, "::");
    if(tokens.size == 1)
        self iprintlnbold("" + tokens[0]);
    else if(tokens.size > 1)
    {
        messages = [];

        for(i=0;i<tokens.size;i++)
        {
            if( isEven(i) )
                wait(int(tokens[i]));
            else
                self iprintlnbold("" + tokens[i]);
        }
    }
    self.cj["welcome"] = true;
}

rotateMessage()
{
    level endon ("game_ended");
    if(getDvar("cj_msg_rotate_1") == "")
        return;
    if(getDvar("cj_msg_delay") == "")
        setDvar("cj_msg_delay", 45);
    svrmsg = [];
    i = 1;
    for(;;)
    {
        temp = "cj_msg_rotate_" + i;
        if(getDvar(temp) != "")
            svrmsg[i-1] = getDvar(temp);
        else
            break;

        i++;
        wait 0.05;
    }
    if(svrmsg.size < 1)
        return;
    i = 0;
    delay = getDvarInt("cj_msg_delay");
    for(;;)
    {
        if(i >= svrmsg.size)
            i = 0;

        wait delay;
        iprintln(svrmsg[i]);
        i++;
    }
}

_svr_msg()
{
    level endon("game_ended");
    for(;;)
    {
        size = undefined;
        tokens = [];
        setDvar("cj_svr_msg", "");
        while(1)
        {
            if(getDvar("cj_svr_msg") != "")
                break;
            wait 0.5;
        }
        tokens = strTok(getDvar("cj_svr_msg"), "::");
        if(tokens.size < 1)
            continue;
        if(tokens.size == 1)
        {
            iprintlnbold("" + tokens[0]);
            continue;
        }
        if(tokens.size > 1)
        {
            switch(tokens[0])
            {
                case "bold":
                case "b":
                case "big":
                case "large":
                case "l":
                    size = "bold";
                    break;
                case "small":
                case "s":
                    size = "small";
                    break;
                default:
                    size = "bold";
            }
            if(size == "small")
                iprintln("" + tokens[1]);
            else
                iprintlnbold("" + tokens[1]);
            continue;
        }
        wait 0.1;
    }
}

_player_msg()
{
    level endon("game_ended");
    for(;;)
    {
        size = undefined;
        name = undefined;
        tokens = [];
        setDvar("cj_player_msg", "");
        while(1)
        {
            if(getDvar("cj_player_msg") != "")
                break;
            wait 0.5;
        }
        tokens = strTok(getDvar("cj_player_msg"), "::");
        // If there are no tokens, then there is an error.
        if(tokens.size < 1)
            continue;
        // If there is only 1 token, then there is an error.
        if(tokens.size == 1)
            continue;
        // If there is only 2 tokens, assume first is player name.
        if(tokens.size == 2)
        {
            players = getentarray("player", "classname");
            name = tokens[0];
            for(i=0;i<players.size;i++)
            {
                tempname = monotone(players[i].name);
                if(isSubStr(tempname, name))
                    players[i] iprintlnbold("" + tokens[1]);
            }
        }
        // Correct ammount of tokens.
        if(tokens.size > 2)
        {
            switch(tokens[0])
            {
                case "big":
                case "bold":
                case "b":
                case "large":
                    size = "bold";
                    break;
                case "small":
                case "s":
                    size = "small";
                    break;
                default:
                    size = "bold";
            }
            players = getentarray("player", "classname");
            name = tokens[1];
            for(i=0;i<players.size;i++)
            {
                tempname = monotone(players[i].name);
                if(isSubStr(tempname, name))
                {
                    if(size == "small")
                        players[i] iprintln("" + tokens[2]);
                    else
                        players[i] iprintlnbold("" + tokens[2]);
                }
            }
        }
        wait 0.1;
    }
}

gravityGun()
{
	self endon("disconnect");
	if(isDefined(self.cj["ggthread"]))
		return;

	self.cj["ggthread"] = true;
	while(1)
	{		
		if((self.cj["ggUsedTime"] + minToMSec(level.ggLoopTime)) <= getTime() && !self hasWeapon("gravitygun_mp"))
		{	
			self setClientDvar("gravitygun_timeleft", 0);
			self giveWeapon("gravitygun_mp");
			self setWeaponAmmoStock("gravitygun_mp",0);
			self setWeaponAmmoClip("gravitygun_mp",50);
			self setActionSlot( 3, "weapon", "gravitygun_mp" );
		}
		if( !self getWeaponAmmoClip("gravitygun_mp"))
		{
			self.cj["ggUsedTime"] = getTime();
			self takeWeapon("gravitygun_mp");
			self dvarThread();
		}
		wait 0.05;
	}
}

dvarThread()
{
	self endon("disconnect");
	for(i = minToSec(level.ggLoopTime); i >= 0; i --)
	{
		self setClientDvar("gravitygun_timeleft", i );
		wait 1;
	}
}

// Admin //
adminCommand(command, arg)
{
    if(level.players[self.cj["admin"]["playerent"]].cj["status"] < 1 && (command == "kick" || command == "ban"))
    {
        switch(command)
        {
            case "kick":
                self notify("adminclose");
                self iPrintln(level.players[self.cj["admin"]["playerent"]].name+" has been kicked");
                kick(level.players[self.cj["admin"]["playerent"]] getEntityNumber());
                break;
            case "ban":
                self notify("adminclose");
                self iPrintln(level.players[self.cj["admin"]["playerent"]].name+" has been banned");
                ban(level.players[arg] getEntityNumber());
                break;
        }
    }
    else
    {
        switch(command)
            {
                case "promote":
                    setDvar("cj_promote", arg);
                    break;
                case "demote":
                    self notify("adminclose");
                    setDvar("cj_demote", arg);
                    break;
                case "teletoplayer":
                    self setOrigin(level.players[self.cj["admin"]["playerent"]].origin);
                    break;
                case "playertele":
                    level.players[self.cj["admin"]["playerent"]] setOrigin(self.origin);
                    break;
            }
    }
}

textCommand(command, arg)
{
    if(command == "playermessage")
        setDvar("cj_player_msg", self.cj["admin"]["player"]+"::"+arg);
    else if(command == "setspeed")
        level.players[arg] SetMoveSpeedScale(getDvarInt("speed"));
    else if(command == "setname")
        level.players[arg] setClientDvar("name", getDvar("cj_rename"));
}

fullPlayerList()
{
    self endon("adminclose");
    self endon("disconnect");
    self endon("killed_player");

    self.cj["admin"]["player"] = level.players[0].name;
    self.cj["admin"]["playerent"] = level.players[0] getEntityNumber();
    self.cj["admin"]["pm"] = "send a private message";
    self.cj["admin"]["speed"] = "1";
    self.cj["admin"]["rename"] = level.players[0].name;
    self.cj["admin"]["givemenu"] = 0;
    self.cj["admin"]["weapfinal"] = "";
    self.cj["admin"]["attachfinal"] = "";
    self.cj["admin"]["maxent"] = 0;

    self setClientDvar("pm", self.cj["admin"]["pm"]);
    self setClientDvar("speed", self.cj["admin"]["speed"]);
    self setClientDvar("rename", self.cj["admin"]["rename"]);
    self setClientDvar("ui_cj_client", "^7"+level.players[0].name);
    self setClientDvar("ui_cj_client_id", self.cj["admin"]["playerent"]);
    self setClientDvar("ui_cj_client_guid", level.players[0] getGuid());
    self setClientDvar("ui_cj_give_menu", self.cj["admin"]["givemenu"]);
    self setClientDvar("ui_cj_give_weapon", self.cj["admin"]["weapfinal"]);
    self setClientDvar("ui_cj_give_attachment", self.cj["admin"]["attachfinal"]);
    self setClientDvar("ui_cj_give_valid_check", "");
    self setClientDvar("ui_cj_hintstring", "^5>>^7");

    for(;;)
    {
        for(i=0;i<level.players.size;i++)
        {
            if(level.players[i].cj["status"]==1)
            {
                self setClientDvar("ui_cj_player_list_"+level.players[i] getEntityNumber(), "^3"+level.players[i].name);
                self.cj["admin"]["list_id_"+level.players[i] getEntityNumber()] = i;
                if(level.players[i] getEntityNumber()>self.cj["admin"]["maxent"])
                    self.cj["admin"]["maxent"]=level.players[i] getEntityNumber()+1;
            }
            else if(level.players[i].cj["status"]>=2)
            {
                self setClientDvar("ui_cj_player_list_"+level.players[i] getEntityNumber(), "^1"+level.players[i].name);
                self.cj["admin"]["list_id_"+level.players[i] getEntityNumber()] = i;
                if(level.players[i] getEntityNumber()>self.cj["admin"]["maxent"])
                    self.cj["admin"]["maxent"]=level.players[i] getEntityNumber()+1;
            }
            else if(level.players[i].cj["status"]==0)
            {
                self setClientDvar("ui_cj_player_list_"+level.players[i] getEntityNumber(), "^7"+level.players[i].name);
                self.cj["admin"]["list_id_"+level.players[i] getEntityNumber()] = i;
                if(level.players[i] getEntityNumber()>self.cj["admin"]["maxent"])
                    self.cj["admin"]["maxent"]=level.players[i] getEntityNumber()+1;
            }
            else
            {
                self setClientDvar("ui_cj_player_list_"+level.players[i] getEntityNumber(), "");
                self.cj["admin"]["list_id_"+level.players[i] getEntityNumber()] = i;
            }
        }

        self setClientDvar("ui_cj_player_count", self.cj["admin"]["maxent"]);

        if(level.players[self.cj["admin"]["playerent"]].cj["status"] == 1)
            self setClientDvar("ui_cj_client", "^3"+level.players[self.cj["admin"]["playerent"]].name);
        else if(level.players[self.cj["admin"]["playerent"]].cj["status"] >= 2)
            self setClientDvar("ui_cj_client", "^1"+level.players[self.cj["admin"]["playerent"]].name);
        else
            self setClientDvar("ui_cj_client", "^7"+level.players[self.cj["admin"]["playerent"]].name);

        self.cj["admin"]["pm"] = getDvar("pm");
        self.cj["admin"]["speed"] = getDvar("speed");
        self.cj["admin"]["rename"] = getDvar("rename");

        self setClientDvar("pm", self.cj["admin"]["pm"]);
        self setClientDvar("speed", self.cj["admin"]["speed"]);
        self setClientDvar("rename", self.cj["admin"]["rename"]);

        self.cj["admin"]["player"] = level.players[self.cj["admin"]["playerent"]].name;

        self setClientDvar("ui_cj_client_id", level.players[self.cj["admin"]["playerent"]] getEntityNumber());
        self setClientDvar("ui_cj_client_guid", level.players[self.cj["admin"]["playerent"]] getGuid());
        self setClientDvar("ui_cj_give_menu", self.cj["admin"]["givemenu"]);
        self setClientDvar("ui_cj_give_weapon", self.cj["admin"]["weapfinal"]);
        self setClientDvar("ui_cj_give_attachment", self.cj["admin"]["attachfinal"]);

        if(checkIfWep(self.cj["admin"]["weapfinal"]+self.cj["admin"]["attachfinal"]+"_mp") == true)
            self setClientDvar("ui_cj_give_valid_check", "^2");
        else
            self setClientDvar("ui_cj_give_valid_check", "^1");
        wait 2;
    }
}