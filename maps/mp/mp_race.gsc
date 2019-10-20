//Map by 3xP' Noob 
//My Steam id is "ross_"
//Scripts by Sheep Wizard, Viruz, Mirko, Noob, with help from IzNoGod and Sux Lolz
//Stealing scripts is for nubs
//Massive thanks to all the testers and those who helped me <3
//read the readme.txt in the iwd for more info!

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

main()
{
	maps\mp\_load::main();
	maps\mp\_teleport::main();
	
	game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";
	
	trigwords("map", "^5Map by 3xP' Noob");
	trigwords("thankstest", "^5Thanks to all testers who gave feedback and made this map possible, you know who you are! \n ^5Big thanks to ^2Funk^5, ^2Leejey ^5and  ^2Gheetah ^5for constant testing!");
	trigwords("thanks3xp", "^5Thanks to all members of the ^63xP' Clan ^5for support and bug finding! \n ^2mp_bouncebuilder ^5is the fucking best");
	trigwords("thankshelp", "^7Massive thanks to: \n  ^3Sheep Wizard^5 (speedrun script creator), \n ^3BUSH1DO^5, ^3ZeeZ^5, ^3Viruz^5, ^3Mirko^5, ^3IzNoGod^5, ^5and ^3Skazy \n ^5for scripting, debugging, and  mapping help!");
	trigwords("congrats", "^3Congratulations, you have finished the map! \n ^5Now go and beat the best times! \n ^2Leaderboard is at spawn!");
	trigwords("roofland", "^5oooh look at mr.pro landing on the roof!");
	trigwords("gg", "gg wp");
	trigwords("bhoppro", "^5Damn, bunnyhop pro!");
	
	thread onPlayerConnect();
	
	//Removing the guids because we are hosing a 1.8 server, and these are not viable anymore
	//and all these member/vip/creator checks are wasting preformance.
	
	thread door_slider();
	thread keydoor();
	thread rotate();
	thread secret();
    thread fov80();  
    thread fov90();
    thread fov96();
	thread nogun();
	thread give_deagle();
	thread give_beretta();
	thread give_rpg();
	thread asshole();
	thread wow();
	thread admindeagle();
	thread gravgun();
	
	thread easyStart();
    thread easyEnd();
    thread interStart();
    thread interEnd();
    thread interplusStart();
    thread interplusEnd();
    thread hardStart();
    thread hardEnd();
    thread funStart();
    thread funEnd();
    thread bhopStart();
    thread bhopEnd();
	
	thread cj_menu();
    thread vars();
	precacheMenu("cj_leaderboard");
	precacheMenu("cj_leaderboard_easy");

	//Shadow Model
    precacheShader("mtl_shadow_eyes");
    precacheShader("mtl_shadow_fur");
    precacheShader("mtl_shadow_shoes");
    precacheShader("mtl_shadow_clothes");
    precacheShader("mtl_shadow_body");
    precacheModel("shadow");

    //Sonic Model
    precacheShader("mtl_sonic");
    precacheShader("mtl_sidney");
    precacheShader("mtl_corpo");
    precacheModel("sonic");

    //Ratchet Model
    precacheShader("mtl_ratchet_body1");
    precacheShader("mtl_ratchet_body2");
    precacheShader("mtl_ratchet_eye");
    precacheShader("mtl_ratchet_head");
    precacheShader("mtl_ratchet_mouth");
    precacheShader("mtl_clank_body");
    precacheShader("mtl_clank_eyes");
    precacheShader("mtl_clank_hands");
    precacheModel("ratchet");
	
	//Joker Model
    precacheShader("mtl_plr_baa_joker_body");
    precacheShader("mtl_plr_baa_joker_hair");
    precacheShader("mtl_plr_baa_joker_head");
    precacheModel("playermodel_baa_joker");
	
	//Captain America Model
	precacheShader("mtl_captainamerica_eye1");
    precacheShader("mtl_captainamerica_eye2");
    precacheShader("mtl_captainamerica_eye3");
    precacheShader("mtl_captainamerica_face");
    precacheShader("mtl_captainamerica_helmet");
    precacheShader("mtl_captainamerica_legs");
    precacheShader("mtl_captainamerica_mouth");
    precacheShader("mtl_captainamerica_torso");
	precacheShader("mtl_captainamerica_shield_front");
    precacheShader("mtl_captainamerica_shield_back");
    precacheShader("mtl_captainamerica_viewhands");
    precacheModel("captainamerica");
	
	//Deadpool
    precacheShader("mtl_deadpool_guns");
    precacheShader("mtl_deadpool_body");
    precacheShader("mtl_deadpool_eyes");
	precacheShader("mtl_deadpool_misc");
    precacheShader("mtl_deadpool_swords");
    precacheModel("deadpool");
	
		
	//duke
    precacheShader("mtl_plr_dnf_duke_body");
    precacheShader("mtl_plr_dnf_duke_glasses");
    precacheShader("mtl_plr_dnf_duke_glasses_lens");
	precacheShader("mtl_plr_dnf_duke_hand");
    precacheShader("mtl_plr_dnf_duke_head");
    precacheModel("playermodel_dnf_duke");
	
	thread tsonic();
	thread tshadow();
	thread tcaptainamerica();
	thread tratchet();
	thread tjoker();
	thread tdeadpool();
	thread zomg();
	thread key1();
	thread key2();
	thread key3();
	thread key4();
	thread key5();
	thread all5();
	thread keyroom();
}
	
onPlayerConnect() 
{
    level endon("game_ended");
    while (1) 
	{
        level waittill("connecting", player);
        player.key1 = 0;
		player.key2 = 0;
		player.key3 = 0;
		player.key4 = 0;
		player.key5 = 0;
	}
}

key1()
{
	for(;;)
	{
	trig = getEnt("key1", "targetname");
	trig waittill ("trigger", player);
	player.key1 = 1;
	if ( player.key1 + player.key2 + player.key3 + player.key4 + player.key5 == 1)
	{player iprintln ("^7You have found ^21 ^7of ^25 ^7keys!");}
	else if ( player.key1 + player.key2 + player.key3 + player.key4 + player.key5 == 2)
	{player iprintln ("^7You have found ^22 ^7of ^25 ^7keys!");}
	else if ( player.key1 + player.key2 + player.key3 + player.key4 + player.key5 == 3)
	{player iprintln ("^7You have found ^23 ^7of ^25 ^7keys!");}
		else if ( player.key1 + player.key2 + player.key3 + player.key4 + player.key5 == 4)
	{player iprintln ("^7You have found ^24 ^7of ^25 ^7keys!");}
		else if ( player.key1 + player.key2 + player.key3 + player.key4 + player.key5 == 5)
	iprintln (player.name + " has found all 5 keys!");wait 5;
	}
}

key2()
{
	for(;;)
	{
	trig = getEnt("key2", "targetname");
	trig waittill ("trigger", player);
	player.key2 = 1;
	if ( player.key1 + player.key2 + player.key3 + player.key4 + player.key5 == 1)
	{player iprintln ("^7You have found ^21 ^7of ^25 ^7keys!");}
	else if ( player.key1 + player.key2 + player.key3 + player.key4 + player.key5 == 2)
	{player iprintln ("^7You have found ^22 ^7of ^25 ^7keys!");}
	else if ( player.key1 + player.key2 + player.key3 + player.key4 + player.key5 == 3)
	{player iprintln ("^7You have found ^23 ^7of ^25 ^7keys!");}
		else if ( player.key1 + player.key2 + player.key3 + player.key4 + player.key5 == 4)
	{player iprintln ("^7You have found ^24 ^7of ^25 ^7keys!");}
		else if ( player.key1 + player.key2 + player.key3 + player.key4 + player.key5 == 5)
	iprintln (player.name + " has found all 5 keys!");wait 5;
	}
}

key3()
{
	for(;;)
	{
	trig = getEnt("key3", "targetname");
	trig waittill ("trigger", player);
	player.key3 = 1;
	if ( player.key1 + player.key2 + player.key3 + player.key4 + player.key5 == 1)
	{player iprintln ("^7You have found ^21 ^7of ^25 ^7keys!");}
	else if ( player.key1 + player.key2 + player.key3 + player.key4 + player.key5 == 2)
	{player iprintln ("^7You have found ^22 ^7of ^25 ^7keys!");}
	else if ( player.key1 + player.key2 + player.key3 + player.key4 + player.key5 == 3)
	{player iprintln ("^7You have found ^23 ^7of ^25 ^7keys!");}
		else if ( player.key1 + player.key2 + player.key3 + player.key4 + player.key5 == 4)
	{player iprintln ("^7You have found ^24 ^7of ^25 ^7keys!");}
		else if ( player.key1 + player.key2 + player.key3 + player.key4 + player.key5 == 5)
	iprintln (player.name + " has found all 5 keys!");wait 5;
	}
}
	
key4()
{
	for(;;)
	{
	trig = getEnt("key4", "targetname");
	trig waittill ("trigger", player);
	player.key4 = 1;
		if ( player.key1 + player.key2 + player.key3 + player.key4 + player.key5 == 1)
	{player iprintln ("^7You have found ^21 ^7of ^25 ^7keys!");}
	else if ( player.key1 + player.key2 + player.key3 + player.key4 + player.key5 == 2)
	{player iprintln ("^7You have found ^22 ^7of ^25 ^7keys!");}
	else if ( player.key1 + player.key2 + player.key3 + player.key4 + player.key5 == 3)
	{player iprintln ("^7You have found ^23 ^7of ^25 ^7keys!");}
		else if ( player.key1 + player.key2 + player.key3 + player.key4 + player.key5 == 4)
	{player iprintln ("^7You have found ^24 ^7of ^25 ^7keys!");}
		else if ( player.key1 + player.key2 + player.key3 + player.key4 + player.key5 == 5)
	iprintln (player.name + " has found all 5 keys!");wait 5;
	}
}

key5()
{
	for(;;)
	{
	trig = getEnt("key5", "targetname");
	trig waittill ("trigger", player);
	player.key5 = 1;
	if ( player.key1 + player.key2 + player.key3 + player.key4 + player.key5 == 1)
	{player iprintln ("^7You have found ^21 ^7of ^25 ^7keys!");}
	else if ( player.key1 + player.key2 + player.key3 + player.key4 + player.key5 == 2)
	{player iprintln ("^7You have found ^22 ^7of ^25 ^7keys!");}
	else if ( player.key1 + player.key2 + player.key3 + player.key4 + player.key5 == 3)
	{player iprintln ("^7You have found ^23 ^7of ^25 ^7keys!");}
		else if ( player.key1 + player.key2 + player.key3 + player.key4 + player.key5 == 4)
	{player iprintln ("^7You have found ^24 ^7of ^25 ^7keys!");}
		else if ( player.key1 + player.key2 + player.key3 + player.key4 + player.key5 == 5)
	iprintln (player.name + " has found all 5 keys!");wait 5;
	}
}

all5()
{
	for(;;)
	{
	trig = getEnt("all5", "targetname");
	trig waittill ("trigger", player);
	player.key1 = 1;
	player.key2 = 1;
	player.key3 = 1;
	player.key4 = 1;
	player.key5 = 1;
	}
}

keyroom()
{
	trig = getEnt ("keyroom", "targetname");
	for(;;)
	{
	trig waittill ("trigger", player);
		if( player.key1 + player.key2 + player.key3 + player.key4 + player.key5 == 5)
		{
		continue;}
	else{
		player iprintlnbold ("^5To enter this room you must first find the ^25 ^5hidden keys!");
		player thread killthem();
	}
	}
}

setPlayerModel(model)
{ 
	self detachHead();
	self SetModel(model);
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

tsonic()
{
	trigger = getent("tsonic", "targetname");
    while(1)
    {
        trigger waittill("trigger", player);
        wait .1;
		player setplayermodel("sonic");
		player iprintln("^4Sonic");
		wait 1;
    }
}

tshadow()
{
	trigger = getent("tshadow", "targetname");
    while(1)
    {
        trigger waittill("trigger", player);
        wait .1;
		player setplayermodel("shadow");
		player iprintln("^0Shadow");
		wait 1;
    }
}
tcaptainamerica()
{
	trigger = getent("tcaptainamerica", "targetname");
    while(1)
    {
        trigger waittill("trigger", player);
        wait .1;
		player setplayermodel("captainamerica");
		player iprintln("^1Captain America");
		wait 1;
    }
}
tratchet()
{
	trigger = getent("tratchet", "targetname");
    while(1)
    {
        trigger waittill("trigger", player);
        wait .1;
		player setplayermodel("ratchet");
		player iprintln("^2Ratchet");
		wait 1;
    }
}
tjoker()
{
	trigger = getent("tjoker", "targetname");
    while(1)
    {
        trigger waittill("trigger", player);
        wait .1;
		player setplayermodel("playermodel_baa_joker");
		player iprintln("^8Joker");
		wait 1;
    }
}
tdeadpool()
{
	trigger = getent("tdeadpool", "targetname");
    while(1)
    {
        trigger waittill("trigger", player);
        wait .1;
		player setplayermodel("deadpool");
		player iprintln("^1Deadpool ^7model set!");
		wait 1;
    }
}
nogun()
{
	 trigger = getent("nogun", "targetname");
    while(1)
    {
        trigger waittill("trigger", player);
        wait .1;
		player takeallweapons();
		player iprintln("^5All guns including rpg removed");
		wait 1;
    }
}

give_deagle()
	{
	trigger = getent ("deagle","targetname");
	while(1)
	{
		trigger waittill ("trigger",user);
		user iprintln("^5Desert Eagle taken");
		user giveWeapon( "deserteagle_mp");
		user giveMaxammo("deserteagle_mp");
		user switchToWeapon("deserteagle_mp");
		wait 1;
	}
}

give_rpg()
	{
	trigger = getent ("giverpg","targetname");
	while(1)
	{
		trigger waittill ("trigger",user);
		user giveWeapon("rpg_mp");
		wait 1;
	}
}

give_beretta()
	{
	trigger = getent ("beretta","targetname");
	while(1)
	{
		trigger waittill ("trigger",user);
		user iprintln("^5Beretta taken");
		user giveWeapon("beretta_mp");
		user giveMaxammo("beretta_mp");
		user switchToWeapon("beretta_mp");
		wait 1;
	}
}

trigwords(trigname, message)
{
	trigs = getentarray(trigname, "targetname");
	for(i = 0; i < trigs.size; i++)
		trigs[i] thread showwords(message);
}

showwords(message)
{
	while(true)
	{
		self waittill("trigger", player);
		player iprintlnbold(message);
		wait 5;
	}
}

door_slider() 
{ 
	door = getent( "door", "targetname" ); 
	trig = getent( "doortrig", "targetname" ); 
	while(true) 
	{ 
		trig waittill ( "trigger" ); 
		door movez ( 170, 2, 0, 0.6 ); 
		door waittill ( "movedone" ); 
		wait 15;
		door movez( -170, 2, 0, 0.6 ); 
		door waittill ( "movedone" ); 
	} 
}

rotate()
	{
	brush = getEnt("rotate", "targetname");
	while(1) {
	wait 0.01;                                            
	brush rotateyaw (360, 10); 
	}
}

secret()
{
    trig = getEnt("secret", "targetname"); 
	{
            trig waittill("trigger", player);
             { iprintln("^2" + player.name + "^5 got to the secret first!"); }
             trig delete();  
	}
}

killthem()
{
	self suicide();
	self iprintlnbold("^1Access Denied motherfucker!");
}

keydoor() 
{ 
	keydoor = getent( "keydoor", "targetname" ); 
	trig = getent( "keydoortrig", "targetname" ); 
	for(;;){
	trig waittill ("trigger", player); 
	if ( player.key1 + player.key2 + player.key3 == 0)
	{player iprintln ("^7You need to find ^25 ^7keys to open the door!"); wait 2;}
	else if ( player.key1 + player.key2 + player.key3 + player.key4 + player.key5 == 1)
	{player iprintln ("^7You need to find ^24 ^7more keys to open the door!");}
	else if ( player.key1 + player.key2 + player.key3 + player.key4 + player.key5 == 2)
	{player iprintln ("^7You need to find ^23 ^7more key to open the door!");}
	else if ( player.key1 + player.key2 + player.key3 + player.key4 + player.key5 == 3)
	{player iprintln ("^7You need to find ^22 ^7more key to open the door!");}
	else if ( player.key1 + player.key2 + player.key3 + player.key4 + player.key5 == 4)
	{player iprintln ("^7You need to find ^21 ^7more key to open the door!");}
	else if ( player.key1 + player.key2 + player.key3 + player.key4 + player.key5 == 5)
	{player iprintln ("^5Welcome, ^7" + player.name);
	keydoor movez ( -180, 2, 0, 0.6 ); 
	keydoor waittill ( "movedone" ); 
	wait 2;
	keydoor movez( 180, 2, 0, 0.6 ); 
	keydoor waittill ( "movedone" ); 
	}
}	
}
asshole()
{
	asshole = getent("asshole","targetname");
	 for(;;) {
    asshole waittill("trigger", user);
	iprintln("^3" + user.name +"^7 is better than you!");
	user takeallweapons();
	wait 5;
	iprintln("^53xP' Noob ^7> " + user.name);
	wait 10;
	}
}
wow()
{
	wow = getent("wow","targetname");
	 for(;;) {
    wow waittill("trigger", user);
	iprintln("^5 " +user.name + "^7 is pr0!");
	user giveWeapon( "deserteaglegold_mp");
	user switchToWeapon("deserteaglegold_mp");
	user setplayermodel("playermodel_dnf_duke");
	user iprintln("^1Duke Nukem' ^7model set!");
	wait 10;
	iprintln("3xP' Noob ^7> ^5" + user.name);
	}
}
zomg()
{
	zomg = getent("zomg","targetname");
	for(;;) {
    zomg waittill("trigger", user);
	user iprintlnbold("^7Omg Noob is so fucking pro, I love him! ^2(c) you");
	user giveweapon("colt45_mp");
    user giveweapon("brick_blaster_mp");
	user switchtoweapon("brick_blaster_mp");
	wait 1;
	user iprintln("^2Here have some weapons xo");
	wait 2;
	}
}
admindeagle()
{
	trigger = getent ("admindeagle","targetname");
	while(1)
	{
		trigger waittill ("trigger",user);
		user iprintln("^2Admin Desert Eagle ^5taken");
		user giveweapon("deserteaglegold_mp");
		user givemaxammo("deserteaglegold_mp");
		user switchtoweapon("deserteaglegold_mp");
		wait 1;
	}
}
gravgun()
{
	trigger = getent ("gravgun","targetname");
	while(1)
	{
		trigger waittill ("trigger",user);
		user iprintln("^2Gravity Gun ^5taken");
		user giveweapon("usp_mp");
		user givemaxammo("usp_mp");
		user switchtoweapon("usp_mp");
		wait 1;
	}
}
fov80()
 {
        trig = getEnt("fov80", "targetname");
        if(!isDefined(trig))
                return;
        for(;;)
        {
            trig waittill("trigger", player);
            {
                player SetClientDvar( "cg_fovscale", "1" );
                player iprintlnbold("^2FOV set to 80");
            }
            wait 1;
        }
}
fov96()
 {
        trig = getEnt("fov96", "targetname");
        if(!isDefined(trig))
                return;
        for(;;) {
                trig waittill("trigger", player);
                {
                         player SetClientDvar( "cg_fovscale", "1.2" );
                        player iprintlnbold("^2FOV set to 96");
                }
                wait 1;
        }
}
fov90()
 {
        trig = getEnt("fov90", "targetname");
        if(!isDefined(trig))
                return;
        for(;;) {
                trig waittill("trigger", player);
                {
                         player SetClientDvar( "cg_fovscale", "1.125" );
                        player iprintlnbold("^2 FOV set to 90");
                }
                wait 1;
        }
}
vars()
{
    level.easy_lb = [];
    level.inter_lb = [];
    level.interplus_lb = [];
    level.hard_lb = [];
    level.fun_lb = [];
    level.bhop_lb = [];
    //set variables for leaderboard
    for(i=0; i<6; i++)
    {
        level.easy_lb[i]["time"] = 999999999;
        level.easy_lb[i]["player"] = "^1No time set";
        level.easy_lb[i]["guid"] = "z";
        level.inter_lb[i]["time"] = 999999999;
        level.inter_lb[i]["player"] = "^1No time set";
        level.inter_lb[i]["guid"] = "z";
        level.interplus_lb[i]["time"] = 999999999;
        level.interplus_lb[i]["player"] = "^1No time set";
        level.interplus_lb[i]["guid"] = "z";
        level.hard_lb[i]["time"] = 999999999;
        level.hard_lb[i]["player"] = "^1No time set";
        level.hard_lb[i]["guid"] = "z";
        level.fun_lb[i]["time"] = 999999999;
        level.fun_lb[i]["player"] = "^1No time set";
        level.fun_lb[i]["guid"] = "z";
        level.bhop_lb[i]["time"] = 999999999;
        level.bhop_lb[i]["player"] = "^1No time set";
        level.bhop_lb[i]["guid"] = "z";
    }
    wait 1;
    mapname = getDvar("mapname");
    //if dvar is set load old scores
    if(getDvar("scores_" + mapname) != "")
    {
        iPrintLnBold("Loading leaderboard times");
        Print(getDvar("scores_" + mapname));
        oldscores = getDvar("scores_" + mapname);
        token = strTok(oldscores, "\n");
        tokencount = 0;
        //places scores from dvar into variables
        for(x=0; x<6;x++)
        {
            placement = strTok(token[tokencount], "\\");
            if(placement[0] != "9999999999" && isDefined(placement[0]))
                level.easy_lb[x]["time"] = int(placement[0]);
            if(placement[1] != "^1No time set" && isDefined(placement[1]))
                level.easy_lb[x]["player"] = placement[1];
            if(placement[2] != "z" && isDefined(placement[2]))
                level.easy_lb[x]["guid"] = placement[2];
            tokencount++;
            placement = strTok(token[tokencount], "\\");
            if(placement[0] != "9999999999" && isDefined(placement[0]))
                level.inter_lb[x]["time"] = int(placement[0]);
            if(placement[1] != "^1No time set" && isDefined(placement[1]))
                level.inter_lb[x]["player"] = placement[1];
            if(placement[2] != "z" && isDefined(placement[2]))
                level.inter_lb[x]["guid"] = placement[2];
            tokencount++;
            placement = strTok(token[tokencount], "\\");
            if(placement[0] != "9999999999" && isDefined(placement[0]))
                level.interplus_lb[x]["time"] = int(placement[0]);
            if(placement[1] != "^1No time set" && isDefined(placement[1]))
                level.interplus_lb[x]["player"] = placement[1];
            if(placement[2] != "z" && isDefined(placement[2]))
                level.interplus_lb[x]["guid"] = placement[2];
            tokencount++;
            placement = strTok(token[tokencount], "\\");
            if(placement[0] != "9999999999" && isDefined(placement[0]))
                level.hard_lb[x]["time"] = int(placement[0]);
            if(placement[1] != "^1No time set" && isDefined(placement[1]))
                level.hard_lb[x]["player"] = placement[1];
            if(placement[2] != "z" && isDefined(placement[2]))
                level.hard_lb[x]["guid"] = placement[2];
            tokencount++;
            placement = strTok(token[tokencount], "\\");
            if(placement[0] != "9999999999" && isDefined(placement[0]))
                level.fun_lb[x]["time"] = int(placement[0]);
            if(placement[1] != "^1No time set" && isDefined(placement[1]))
                level.fun_lb[x]["player"] = placement[1];
            if(placement[2] != "z" && isDefined(placement[2]))
                level.fun_lb[x]["guid"] = placement[2];
            tokencount++;
            placement = strTok(token[tokencount], "\\");
            if(placement[0] != "9999999999" && isDefined(placement[0]))
                level.bhop_lb[x]["time"] = int(placement[0]);
            if(placement[1] != "^1No time set" && isDefined(placement[1]))
                level.bhop_lb[x]["player"] = placement[1];
            if(placement[2] != "z" && isDefined(placement[2]))
                level.bhop_lb[x]["guid"] = placement[2];
            tokencount++;
        }
    }
    else
    {
        Print("no scores dvar");
    }
}
leaderboard(number, playername, way, guid, jumper)
{
    if(number == 999999999)//shouldnt take 277 hour to complete map but whatever
        number--;
    if((way == "easy" && number <= 220000) || (way == "inter" && number <= 210000) ||  (way == "interplus" && number <= 220000) || (way == "hard" && number <= 300000) || (way == "fun" && number <= 200000) || (way == "bhop" && number <= 200000))
        return;
    if(way == "easy")
    {  
             //if new top record is set
        if(number < level.easy_lb[5]["time"])
        {
            iPrintLn(playername + " has the record for easy");
            jumper setPlayermodel("ratchet");
			jumper iPrintLnBold("^3You got a new record! \n ^2Ratchet ^5model equipped!");
			jumper iPrintLn("^5Going to spec or suicide will remove skin!");
        }	
        for(i=5; i>-1; i--)
        {
            //If players new time is slower then their old time
            if(level.easy_lb[i]["guid"] == guid && level.easy_lb[i]["time"] < number )
                return;
            //If a quicker time is set
            if(level.easy_lb[i]["time"] > number)
            {
                //Move all old times down
                for(x=0; x<i; x++)
                {
                    level.easy_lb[x]["time"] = level.easy_lb[x+1]["time"];
                    level.easy_lb[x]["player"] = level.easy_lb[x+1]["player"];
                    level.easy_lb[x]["guid"] = level.easy_lb[x+1]["guid"];
                }
                //insert new time
                level.easy_lb[i]["time"] = number;
                level.easy_lb[i]["player"] = playername;
                level.easy_lb[i]["guid"] = guid;
 
                for(z=0; z<i; z++)
                {
                    //Check that player doesnt have an old time in leaderboard
                    if(level.easy_lb[z]["guid"] == guid && level.easy_lb[z]["time"] != number)
                    {
                        //If they do move all times below up to remove it
                        for(p=z; p>0; p--)
                        {
                            level.easy_lb[p]["time"] = level.easy_lb[p-1]["time"];
                            level.easy_lb[p]["player"] = level.easy_lb[p-1]["player"];
                            level.easy_lb[p]["guid"] = level.easy_lb[p-1]["guid"];
                        }
                        saveScores();
                        return;
                    }
                }
                //save scores to dvar
                saveScores();
                return;
            }
        }
    }
    //else if
    if(way == "inter")
    {
		  //if new top record is set
        if(number < level.inter_lb[5]["time"])
            iPrintLn(playername + " ^3has the record for Inter!");
			jumper setPlayermodel("deadpool");
			jumper iPrintLnBold("^3You got a new record! \n ^1Deadpool ^5model equipped!");
			jumper iPrintLn("^5Going to spec or suicide will remove skin!");
        for(i=5; i>-1; i--)
        {
            if(level.inter_lb[i]["guid"] == guid && level.inter_lb[i]["time"] < number )
                return;
            if(level.inter_lb[i]["time"] > number)
            {
                for(x=0; x<i; x++)
                {
                    level.inter_lb[x]["time"] = level.inter_lb[x+1]["time"];
                    level.inter_lb[x]["player"] = level.inter_lb[x+1]["player"];
                    level.inter_lb[x]["guid"] = level.inter_lb[x+1]["guid"];
                }
                level.inter_lb[i]["time"] = number;
                level.inter_lb[i]["player"] = playername;
                level.inter_lb[i]["guid"] = guid;
 
                for(z=0; z<i; z++)
                {
                    if(level.inter_lb[z]["guid"] == guid && level.inter_lb[z]["time"] != number)
                    {
 
                        for(p=z; p>0; p--)
                        {
                            level.inter_lb[p]["time"] = level.inter_lb[p-1]["time"];
                            level.inter_lb[p]["player"] = level.inter_lb[p-1]["player"];
                            level.inter_lb[p]["guid"] = level.inter_lb[p-1]["guid"];
                        }
                        saveScores();
                        return;
 
                    }
                }
                saveScores();
                return;
            }
        }
    }
    if(way == "interplus")
    {
		  //if new top record is set
        if(number < level.interplus_lb[5]["time"])
            iPrintLn(playername + " ^3has the record for Inter+!");
			jumper setPlayermodel("captainamerica");
			jumper iPrintLnBold("^3You got a new record! \n ^1Captain America^5 model equipped!");
			jumper iPrintLn("Going to spec or suicide will remove skin!");
			
       for(i=5; i>-1; i--)
        {
            if(level.interplus_lb[i]["guid"] == guid && level.interplus_lb[i]["time"] < number )
                return;
 
            if(level.interplus_lb[i]["time"] > number)
            {
               
                for(x=0; x<i; x++)
                {
                    level.interplus_lb[x]["time"] = level.interplus_lb[x+1]["time"];
                    level.interplus_lb[x]["player"] = level.interplus_lb[x+1]["player"];
                    level.interplus_lb[x]["guid"] = level.interplus_lb[x+1]["guid"];
                }
                level.interplus_lb[i]["time"] = number;
                level.interplus_lb[i]["player"] = playername;
                level.interplus_lb[i]["guid"] = guid;
 
                for(z=0; z<i; z++)
                {
                    if(level.interplus_lb[z]["guid"] == guid && level.interplus_lb[z]["time"] != number)
                    {
 
                        for(p=z; p>0; p--)
                        {
                            level.interplus_lb[p]["time"] = level.interplus_lb[p-1]["time"];
                            level.interplus_lb[p]["player"] = level.interplus_lb[p-1]["player"];
                            level.interplus_lb[p]["guid"] = level.interplus_lb[p-1]["guid"];
                        }
                        saveScores();
                        return;
 
                    }
                }
 
                saveScores();
                return;
            }
        }
    }
    if(way == "hard")
    {
		  //if new top record is set
        if(number < level.hard_lb[5]["time"])
            iPrintLn(playername + " ^3has the record for Hard!");
			jumper setPlayermodel("sonic");
			jumper iPrintLnBold("^3You got a new record! \n ^4Sonic ^5model equipped!");
			jumper iPrintLn("Going to spec or suicide will remove skin!");
        for(i=5; i>-1; i--)
        {
            if(level.hard_lb[i]["guid"] == guid && level.hard_lb[i]["time"] < number )
                return;
 
            if(level.hard_lb[i]["time"] > number)
            {
               
                for(x=0; x<i; x++)
                {
                    level.hard_lb[x]["time"] = level.hard_lb[x+1]["time"];
                    level.hard_lb[x]["player"] = level.hard_lb[x+1]["player"];
                    level.hard_lb[x]["guid"] = level.hard_lb[x+1]["guid"];
                }
                level.hard_lb[i]["time"] = number;
                level.hard_lb[i]["player"] = playername;
                level.hard_lb[i]["guid"] = guid;
 
                for(z=0; z<i; z++)
                {
                    if(level.hard_lb[z]["guid"] == guid && level.hard_lb[z]["time"] != number)
                    {
 
                        for(p=z; p>0; p--)
                        {
                            level.hard_lb[p]["time"] = level.hard_lb[p-1]["time"];
                            level.hard_lb[p]["player"] = level.hard_lb[p-1]["player"];
                            level.hard_lb[p]["guid"] = level.hard_lb[p-1]["guid"];
                        }
                        saveScores();
                        return;
 
                    }
                }
 
                saveScores();
                return;
            }
        }
    }
    if(way == "fun")
    {
		  //if new top record is set
        if(number < level.fun_lb[5]["time"])
            iPrintLn(playername + " ^3has the record for Fun!");
			jumper setPlayermodel("shadow");
			jumper iPrintLnBold("^3You got a new record! \n ^0Shadow ^5model equipped!");
			jumper iPrintLn("Going to spec or suicide will remove skin!");
        for(i=5; i>-1; i--)
        {
            if(level.fun_lb[i]["guid"] == guid && level.fun_lb[i]["time"] < number )
                return;
 
            if(level.fun_lb[i]["time"] > number)
            {
               
                for(x=0; x<i; x++)
                {
                    level.fun_lb[x]["time"] = level.fun_lb[x+1]["time"];
                    level.fun_lb[x]["player"] = level.fun_lb[x+1]["player"];
                    level.fun_lb[x]["guid"] = level.fun_lb[x+1]["guid"];
                }
                level.fun_lb[i]["time"] = number;
                level.fun_lb[i]["player"] = playername;
                level.fun_lb[i]["guid"] = guid;
 
                for(z=0; z<i; z++)
                {
                    if(level.fun_lb[z]["guid"] == guid && level.fun_lb[z]["time"] != number)
                    {
 
                        for(p=z; p>0; p--)
                        {
                            level.fun_lb[p]["time"] = level.fun_lb[p-1]["time"];
                            level.fun_lb[p]["player"] = level.fun_lb[p-1]["player"];
                            level.fun_lb[p]["guid"] = level.fun_lb[p-1]["guid"];
                        }
                        saveScores();
                        return;
 
                    }
                }
 
                saveScores();
                return;
            }
        }
    }
    if(way == "bhop")
    {
		  //if new top record is set
        if(number < level.bhop_lb[5]["time"])
            iPrintLn(playername + " ^3has the record for Bhop!");
			jumper setPlayermodel("playermodel_baa_joker");
			jumper iPrintLnBold("^3You got a new record! \n ^9Joker ^5model equipped!");
			jumper iPrintLn("Going to spec or suicide will remove skin!");
        for(i=5; i>-1; i--)
        {
            if(level.bhop_lb[i]["guid"] == guid && level.bhop_lb[i]["time"] < number )
                return;
 
            if(level.bhop_lb[i]["time"] > number)
            {
               
                for(x=0; x<i; x++)
                {
                    level.bhop_lb[x]["time"] = level.bhop_lb[x+1]["time"];
                    level.bhop_lb[x]["player"] = level.bhop_lb[x+1]["player"];
                    level.bhop_lb[x]["guid"] = level.bhop_lb[x+1]["guid"];
                }
                level.bhop_lb[i]["time"] = number;
                level.bhop_lb[i]["player"] = playername;
                level.bhop_lb[i]["guid"] = guid;
 
                for(z=0; z<i; z++)
                {
                    if(level.bhop_lb[z]["guid"] == guid && level.bhop_lb[z]["time"] != number)
                    {
 
                        for(p=z; p>0; p--)
                        {
                            level.bhop_lb[p]["time"] = level.bhop_lb[p-1]["time"];
                            level.bhop_lb[p]["player"] = level.bhop_lb[p-1]["player"];
                            level.bhop_lb[p]["guid"] = level.bhop_lb[p-1]["guid"];
                        }
                        saveScores();
                        return;
 
                    }
                }
 
                saveScores();
                return;
            }
        }
    }
}
 
//update map dvar
addToDvar(dvar, var)
{
    setDvar(dvar, getDvar(dvar) + var);
}
 
//saves scores to dvar
//to reset scores set dvar 'scores_'mapname to " "
//rcon set scores_mp_race " "
saveScores()
{
    score = "";
    mapname = getDvar("mapname");
    setDvar("scores_" + mapname, "" );
 
    for(i=0; i<6; i++)
    {
        score = level.easy_lb[i]["time"] + "\\";
        score = score + level.easy_lb[i]["player"] + "\\";
        score = score + level.easy_lb[i]["guid"] + "\n";
        score = score + level.inter_lb[i]["time"] + "\\";
        score = score + level.inter_lb[i]["player"] + "\\";
        score = score + level.inter_lb[i]["guid"] + "\n";
        score = score + level.interplus_lb[i]["time"] + "\\";
        score = score + level.interplus_lb[i]["player"] + "\\";
        score = score + level.interplus_lb[i]["guid"] + "\n";
        score = score + level.hard_lb[i]["time"] + "\\";
        score = score + level.hard_lb[i]["player"] + "\\";
        score = score + level.hard_lb[i]["guid"] + "\n";
        score = score + level.fun_lb[i]["time"] + "\\";
        score = score + level.fun_lb[i]["player"] + "\\";
        score = score + level.fun_lb[i]["guid"] + "\n";
        score = score + level.bhop_lb[i]["time"] + "\\";
        score = score + level.bhop_lb[i]["player"] + "\\";
        score = score + level.bhop_lb[i]["guid"] + "\n";
        addToDvar("scores_" + mapname, score);  
    }
    wait 0.1;
 
}
//convert time to readable time
realtime(number)
{
    if(number == 999999999)
    {
        playertime = "???";
        return playertime;
    }
 
    seconds = int(number / 1000);
    hours = int(seconds/3600);
    seconds = seconds % 3600;
    minutes = int(seconds/60);
    seconds = seconds % 60;
 
    if(seconds <= 9)
        seconds = "0" + seconds;
    if(minutes <= 9)
        minutes = "0" + minutes;
    if(hours <= 9)
        hours = "0" + hours;
 
     playertime =  "" + hours + ":" + minutes + ":" + seconds;
 
    return playertime;
}
//open leaderboard menu
cj_menu()
{
    trig = getEnt("leaderboard_trig", "targetname");
    while(1)
    {
        trig waittill("trigger", player);
       
        player thread openleaderboardMenu();
        wait 0.05;
    }
}
 
//set player dvars for leaderboard menu
openleaderboardMenu()
{
    //stop multiple loops for 1 player
    self notify("restart_menuthread");
    self endon("restart_menuthread");
    self endon("disconnect");
   
    //menus opsn on easy
    self openMenu("cj_leaderboard_easy");
    self setClientDvars( "cj_leaderboard_1_n", level.easy_lb[5]["player"],
                         "cj_leaderboard_1_t", realtime(level.easy_lb[5]["time"]),
                         "cj_leaderboard_2_n", level.easy_lb[4]["player"],
                         "cj_leaderboard_2_t", realtime(level.easy_lb[4]["time"]),
                         "cj_leaderboard_3_n", level.easy_lb[3]["player"],
                         "cj_leaderboard_3_t", realtime(level.easy_lb[3]["time"]),
                         "cj_leaderboard_4_n", level.easy_lb[2]["player"],
                         "cj_leaderboard_4_t", realtime(level.easy_lb[2]["time"]),
                         "cj_leaderboard_5_n", level.easy_lb[1]["player"],
                         "cj_leaderboard_5_t", realtime(level.easy_lb[1]["time"]),
                         "cj_leaderboard_6_n", level.easy_lb[0]["player"],
                         "cj_leaderboard_6_t", realtime(level.easy_lb[0]["time"]));
 
                         
    while(1)
    {
        self waittill("menuresponse", menu, response);
        if(response == "easy_scores" && menu == "cj_leaderboard_easy")
        {
             self setClientDvars( "cj_leaderboard_1_n", level.easy_lb[5]["player"],
                         "cj_leaderboard_1_t", realtime(level.easy_lb[5]["time"]),
                         "cj_leaderboard_2_n", level.easy_lb[4]["player"],
                         "cj_leaderboard_2_t", realtime(level.easy_lb[4]["time"]),
                         "cj_leaderboard_3_n", level.easy_lb[3]["player"],
                         "cj_leaderboard_3_t", realtime(level.easy_lb[3]["time"]),
                         "cj_leaderboard_4_n", level.easy_lb[2]["player"],
                         "cj_leaderboard_4_t", realtime(level.easy_lb[2]["time"]),
                         "cj_leaderboard_5_n", level.easy_lb[1]["player"],
                         "cj_leaderboard_5_t", realtime(level.easy_lb[1]["time"]),
                         "cj_leaderboard_6_n", level.easy_lb[0]["player"],
                         "cj_leaderboard_6_t", realtime(level.easy_lb[0]["time"]));
        }
        if(response == "inter_scores" && menu == "cj_leaderboard_easy")
        {
 
             self setClientDvars( "cj_leaderboard_1_n", level.inter_lb[5]["player"],
                         "cj_leaderboard_1_t", realtime(level.inter_lb[5]["time"]),
                         "cj_leaderboard_2_n", level.inter_lb[4]["player"],
                         "cj_leaderboard_2_t", realtime(level.inter_lb[4]["time"]),
                         "cj_leaderboard_3_n", level.inter_lb[3]["player"],
                         "cj_leaderboard_3_t", realtime(level.inter_lb[3]["time"]),
                         "cj_leaderboard_4_n", level.inter_lb[2]["player"],
                         "cj_leaderboard_4_t", realtime(level.inter_lb[2]["time"]),
                         "cj_leaderboard_5_n", level.inter_lb[1]["player"],
                         "cj_leaderboard_5_t", realtime(level.inter_lb[1]["time"]),
                         "cj_leaderboard_6_n", level.inter_lb[0]["player"],
                         "cj_leaderboard_6_t", realtime(level.inter_lb[0]["time"]));
        }  
        if(response == "interplus_scores" && menu == "cj_leaderboard_easy")
        {
 
            self setClientDvars( "cj_leaderboard_1_n", level.interplus_lb[5]["player"],
                         "cj_leaderboard_1_t", realtime(level.interplus_lb[5]["time"]),
                         "cj_leaderboard_2_n", level.interplus_lb[4]["player"],
                         "cj_leaderboard_2_t", realtime(level.interplus_lb[4]["time"]),
                         "cj_leaderboard_3_n", level.interplus_lb[3]["player"],
                         "cj_leaderboard_3_t", realtime(level.interplus_lb[3]["time"]),
                         "cj_leaderboard_4_n", level.interplus_lb[2]["player"],
                         "cj_leaderboard_4_t", realtime(level.interplus_lb[2]["time"]),
                         "cj_leaderboard_5_n", level.interplus_lb[1]["player"],
                         "cj_leaderboard_5_t", realtime(level.interplus_lb[1]["time"]),
                         "cj_leaderboard_6_n", level.interplus_lb[0]["player"],
                         "cj_leaderboard_6_t", realtime(level.interplus_lb[0]["time"]));
        }
        if(response == "hard_scores" && menu == "cj_leaderboard_easy")
        {
            self setClientDvars( "cj_leaderboard_1_n", level.hard_lb[5]["player"],
                         "cj_leaderboard_1_t", realtime(level.hard_lb[5]["time"]),
                         "cj_leaderboard_2_n", level.hard_lb[4]["player"],
                         "cj_leaderboard_2_t", realtime(level.hard_lb[4]["time"]),
                         "cj_leaderboard_3_n", level.hard_lb[3]["player"],
                         "cj_leaderboard_3_t", realtime(level.hard_lb[3]["time"]),
                         "cj_leaderboard_4_n", level.hard_lb[2]["player"],
                         "cj_leaderboard_4_t", realtime(level.hard_lb[2]["time"]),
                         "cj_leaderboard_5_n", level.hard_lb[1]["player"],
                         "cj_leaderboard_5_t", realtime(level.hard_lb[1]["time"]),
                         "cj_leaderboard_6_n", level.hard_lb[0]["player"],
                         "cj_leaderboard_6_t", realtime(level.hard_lb[0]["time"]));
        }
        if(response == "fun_scores" && menu == "cj_leaderboard_easy")
        {
            self setClientDvars( "cj_leaderboard_1_n", level.fun_lb[5]["player"],
                         "cj_leaderboard_1_t", realtime(level.fun_lb[5]["time"]),
                         "cj_leaderboard_2_n", level.fun_lb[4]["player"],
                         "cj_leaderboard_2_t", realtime(level.fun_lb[4]["time"]),
                         "cj_leaderboard_3_n", level.fun_lb[3]["player"],
                         "cj_leaderboard_3_t", realtime(level.fun_lb[3]["time"]),
                         "cj_leaderboard_4_n", level.fun_lb[2]["player"],
                         "cj_leaderboard_4_t", realtime(level.fun_lb[2]["time"]),
                         "cj_leaderboard_5_n", level.fun_lb[1]["player"],
                         "cj_leaderboard_5_t", realtime(level.fun_lb[1]["time"]),
                         "cj_leaderboard_6_n", level.fun_lb[0]["player"],
                         "cj_leaderboard_6_t", realtime(level.fun_lb[0]["time"]));
        }
        if(response == "bhop_scores" && menu == "cj_leaderboard_easy")
        {
            self setClientDvars( "cj_leaderboard_1_n", level.bhop_lb[5]["player"],
                         "cj_leaderboard_1_t", realtime(level.bhop_lb[5]["time"]),
                         "cj_leaderboard_2_n", level.bhop_lb[4]["player"],
                         "cj_leaderboard_2_t", realtime(level.bhop_lb[4]["time"]),
                         "cj_leaderboard_3_n", level.bhop_lb[3]["player"],
                         "cj_leaderboard_3_t", realtime(level.bhop_lb[3]["time"]),
                         "cj_leaderboard_4_n", level.bhop_lb[2]["player"],
                         "cj_leaderboard_4_t", realtime(level.bhop_lb[2]["time"]),
                         "cj_leaderboard_5_n", level.bhop_lb[1]["player"],
                         "cj_leaderboard_5_t", realtime(level.bhop_lb[1]["time"]),
                         "cj_leaderboard_6_n", level.bhop_lb[0]["player"],
                         "cj_leaderboard_6_t", realtime(level.bhop_lb[0]["time"]));
        }
        wait 0.05;
    }
}
checkpointreset()
{
    self.easychk1 = undefined;
    self.easychk2 = undefined;
    self.easychk3 = undefined;
    self.interchk1 = undefined;
    self.interchk2 = undefined;
    self.interchk3 = undefined;
    self.interpluschk1 = undefined;
    self.interpluschk2 = undefined;
    self.interpluschk3 = undefined;
    self.hardchk1 = undefined;
    self.hardchk2 = undefined;
    self.hardchk3 = undefined;
    self.funchk1 = undefined;
    self.funchk2 = undefined;
    self.funchk3 = undefined;
    self.bhopchk1 = undefined;
    self.bhopchk2 = undefined;
    self.bhopchk3 = undefined;
 
    self.easyEnd = undefined;
    self.startTimeEasy = undefined;
    self.interEnd = undefined;
    self.startTimeInter = undefined;
    self.interplusEnd = undefined;
    self.startTimeInterplus = undefined;
    self.hardEnd = undefined;
    self.startTimeHard = undefined;
    self.funEnd = undefined;
    self.startTimeFun = undefined;
    self.bhopEnd = undefined;
    self.startTimeBhop = undefined;  
}  
//EASY TIMER
easyStart()
{
    level endon("game_ended");
   
    trigger = getent("easybegin", "targetname");
 
    while(1)
    {
        trigger waittill("trigger", player);
       
        if(player.sessionstate == "playing")
        {
            player checkpointreset();
            player.startTimeEasy = getTime();
            player.easyend = undefined;
            player thread easychk();
        }                      
    }
}
easyEnd()
{
    level endon("game_ended");
   
    trigger = getent("easyend", "targetname");
    while(1)
    {
        trigger waittill("trigger", player);
       
        if(player.sessionstate != "playing" || isDefined(player.easyend) || !isDefined(player.startTimeEasy))
            continue;
   
        else
        {
            if(isDefined(player.easychk1) && isDefined(player.easychk2) && isDefined(player.easychk3))
            {
                number = getTime() - player.startTimeEasy;
                guid = getSubStr(player getGuid(), 11, 19);
                leaderboard(number, player.name, "easy", guid, player);
                iPrintLnBold(player.name + " ^5finished Easy in ^3" + realtime(number));
                player.easyEnd = true;
                player.startTimeEasy = undefined;
                player notify("easy_stop");
                player thread checkpointreset();
            }    
        }
       
    }
}
easychk()
{
    self notify("easy_stop");
    self endon("easy_stop");
    self endon("disconnect");
    trig1 = getEnt("easy_chk_1", "targetname");
    trig2 = getEnt("easy_chk_2", "targetname");
    trig3 = getEnt("easy_chk_3", "targetname");
 
    while(1)
    {
        if(!isDefined(self.easychk1) && self isTouching(trig1))
            self.easychk1 = true;
        if(!isDefined(self.easychk2) && self isTouching(trig2))
           self.easychk2 = true;
        if(!isDefined(self.easychk3) && self isTouching(trig3))
            self.easychk3 = true;
        wait 0.05;
    }
 
}
//INTER TIMER
interStart()
{
    level endon("game_ended");
   
    trigger = getent("interbegin", "targetname");
 
    while(1)
    {
        trigger waittill("trigger", player);
       
        if(player.sessionstate == "playing")
        {
            player checkpointreset();
            player.startTimeInter = getTime();
            player.interend = undefined;
            player thread interchk();
        }
                           
    }
}
interEnd()
{
    level endon("game_ended");
   
    trigger = getent("interend", "targetname");
    while(1)
    {
        trigger waittill("trigger", player);
       
        if(player.sessionstate != "playing" || isDefined(player.interend) || !isDefined(player.startTimeInter))
            continue;
   
        else
        {
            if(isDefined(player.interchk1) && isDefined(player.interchk2) && isDefined(player.interchk3))
            {
                number = getTime() - player.startTimeInter;
                guid = getSubStr(player getGuid(), 11, 19);
                leaderboard(number, player.name, "inter", guid, player);
                iPrintLnBold(player.name + " ^5finished Inter in ^3" + realtime(number));
                player.interEnd = true;
                player.startTimeInter = undefined;
                player notify("inter_stop");
                player thread checkpointreset();
            }    
        }
       
    }
}
interchk()
{
    self notify("inter_stop");
    self endon("inter_stop");
    self endon("disconnect");
    trig1 = getEnt("inter_chk_1", "targetname");
    trig2 = getEnt("inter_chk_2", "targetname");
    trig3 = getEnt("inter_chk_3", "targetname");
 
    while(1)
    {
        if(!isDefined(self.interchk1) && self isTouching(trig1))
            self.interchk1 = true;
        if(!isDefined(self.interchk2) && self isTouching(trig2))
           self.interchk2 = true;
        if(!isDefined(self.interchk3) && self isTouching(trig3))
            self.interchk3 = true;
        wait 0.05;
    }
}
//INTERPLUS TIMER
interplusStart()
{
    level endon("game_ended");
   
    trigger = getent("interplusbegin", "targetname");
 
    while(1)
    {
        trigger waittill("trigger", player);
       
        if(player.sessionstate == "playing")
        {
            player checkpointreset();
            player.startTimeInterplus = getTime();
            player.interplusend = undefined;
            player thread interpluschk();
        }
                               
    }
}
interplusEnd()
{
    level endon("game_ended");
   
    trigger = getent("interplusend", "targetname");
    while(1)
    {
        trigger waittill("trigger", player);
       
        if(player.sessionstate != "playing" || isDefined(player.interplusend) || !isDefined(player.startTimeInterplus))
            continue;
   
        else
        {
            if(isDefined(player.interpluschk1) && isDefined(player.interpluschk2) && isDefined(player.interpluschk3))
            {
                number = getTime() - player.startTimeInterplus;
                guid = getSubStr(player getGuid(), 11, 19);
                leaderboard(number, player.name, "interplus", guid, player);
                iPrintLnBold(player.name + " ^5finished Inter+ in ^3" + realtime(number));
                player.interplusEnd = true;
                player.startTimeInterplus = undefined;
                player notify("interplus_stop");
                player thread checkpointreset();
            }    
        }
       
    }
}
interpluschk()
{
    self notify("interplus_stop");
    self endon("interplus_stop");
    self endon("disconnect");
    trig1 = getEnt("interplus_chk_1", "targetname");
    trig2 = getEnt("interplus_chk_2", "targetname");
    trig3 = getEnt("interplus_chk_3", "targetname");
 
    while(1)
    {
        if(!isDefined(self.interpluschk1) && self isTouching(trig1))
            self.interpluschk1 = true;
        if(!isDefined(self.interpluschk2) && self isTouching(trig2))
           self.interpluschk2 = true;
        if(!isDefined(self.interpluschk3) && self isTouching(trig3))
            self.interpluschk3 = true;
        wait 0.05;
    }
}
//HARD TIMER
hardStart()
{
    level endon("game_ended");
   
    trigger = getent("hardbegin", "targetname");
 
    while(1)
    {
        trigger waittill("trigger", player);
       
        if(player.sessionstate == "playing")
        {
            player checkpointreset();
            player.startTimeHard = getTime();
            player.hardend = undefined;
            player thread hardchk();
        }
                       
    }
}
hardEnd()
{
    level endon("game_ended");
   
    trigger = getent("hardend", "targetname");
    while(1)
    {
        trigger waittill("trigger", player);
       
        if(player.sessionstate != "playing" || isDefined(player.hardend) || !isDefined(player.startTimehard))
            continue;
   
        else
        {
            if(isDefined(player.hardchk1) && isDefined(player.hardchk2) && isDefined(player.hardchk3))
            {
                number = getTime() - player.startTimeHard;
                guid = getSubStr(player getGuid(), 11, 19);
                leaderboard(number, player.name, "hard", guid, player);
                iPrintLnBold(player.name + " ^5finished Hard in ^3" + realtime(number));
                player.hardEnd = true;
                player.startTimeHard = undefined;
                player notify("hard_stop");
                player thread checkpointreset();
            }    
        }
       
    }
}
hardchk()
{
    self notify("hard_stop");
    self endon("hard_stop");
    self endon("disconnect");
    trig1 = getEnt("hard_chk_1", "targetname");
    trig2 = getEnt("hard_chk_2", "targetname");
    trig3 = getEnt("hard_chk_3", "targetname");
 
    while(1)
    {
        if(!isDefined(self.hardchk1) && self isTouching(trig1))
            self.hardchk1 = true;
        if(!isDefined(self.hardchk2) && self isTouching(trig2))
           self.hardchk2 = true;
        if(!isDefined(self.hardchk3) && self isTouching(trig3))
            self.hardchk3 = true;
        wait 0.05;
    }
}
//FUN TIMER
funStart()
{
    level endon("game_ended");
   
    trigger = getent("funbegin", "targetname");
 
    while(1)
    {
        trigger waittill("trigger", player);
       
        if(player.sessionstate == "playing")
        {
            player checkpointreset();
            player.startTimeFun = getTime();
            player.funend = undefined;
            player thread funchk();
        }
                       
    }
}
funEnd()
{
    level endon("game_ended");
   
    trigger = getent("funend", "targetname");
    while(1)
    {
        trigger waittill("trigger", player);
        if(player.sessionstate != "playing" || isDefined(player.funend) || !isDefined(player.startTimefun))
            continue;
        else
        {
            if(isDefined(player.funchk1) && isDefined(player.funchk2) && isDefined(player.funchk3))
            {
                number = getTime() - player.startTimeFun;
                guid = getSubStr(player getGuid(), 11, 19);
                leaderboard(number, player.name, "fun", guid, player);
                iPrintLnBold(player.name + " ^5finished Fun in ^3" + realtime(number));
                player.funEnd = true;
                player.startTimeFun = undefined;
                player notify("fun_stop");
                player thread checkpointreset();
            }    
        }
       
    }
}
funchk()
{
    self notify("fun_stop");
    self endon("fun_stop");
    self endon("disconnect");
    trig1 = getEnt("fun_chk_1", "targetname");
    trig2 = getEnt("fun_chk_2", "targetname");
    trig3 = getEnt("fun_chk_3", "targetname");
 
    while(1)
    {
        if(!isDefined(self.funchk1) && self isTouching(trig1))
            self.funchk1 = true;
        if(!isDefined(self.funchk2) && self isTouching(trig2))
           self.funchk2 = true;
        if(!isDefined(self.funchk3) && self isTouching(trig3))
            self.funchk3 = true;
        wait 0.05;
    }
}
//BHOP TIMER
bhopStart()
{
    level endon("game_ended");
   
    trigger = getent("bhopbegin", "targetname");
 
    while(1)
    {
        trigger waittill("trigger", player);
       
        if(player.sessionstate == "playing")
        {
            player checkpointreset();
            player.startTimeBhop = getTime();
            player.easybhop = undefined;
            player thread bhopchk();
        }
                       
    }
}
bhopEnd()
{
    level endon("game_ended");
   
    trigger = getent("bhopend", "targetname");
    while(1)
    {
        trigger waittill("trigger", player);
       
        if(player.sessionstate != "playing" || isDefined(player.bhopend) || !isDefined(player.startTimeBhop))
            continue;
   
        else
        {
            if(isDefined(player.bhopchk1) && isDefined(player.bhopchk2) && isDefined(player.bhopchk3))
            {
                number = getTime() - player.startTimeBhop;
                guid = getSubStr(player getGuid(), 11, 19);
                leaderboard(number, player.name, "bhop", guid, player);
                iPrintLnBold(player.name + " ^5finished Bhop in ^3" + realtime(number));
                player.bhopEnd = true;
                player.startTimeBhop = undefined;
                player notify("bhop_stop");
                player thread checkpointreset();
            }    
        }
       
    }
}
bhopchk()
{
    self notify("bhop_stop");
    self endon("bhop_stop");
    self endon("disconnect");
    trig1 = getEnt("bhop_chk_1", "targetname");
    trig2 = getEnt("bhop_chk_2", "targetname");
    trig3 = getEnt("bhop_chk_3", "targetname");
 
    while(1)
    {
        if(!isDefined(self.bhopchk1) && self isTouching(trig1))
            self.bhopchk1 = true;
        if(!isDefined(self.bhopchk2) && self isTouching(trig2))
           self.bhopchk2 = true;
        if(!isDefined(self.bhopchk3) && self isTouching(trig3))
            self.bhopchk3 = true;
        wait 0.05;
    }
}