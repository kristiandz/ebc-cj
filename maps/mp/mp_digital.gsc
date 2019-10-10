////////////////////////////////////
////////// Setup stuff/////////////
//////////////////////////////////
main()
{
	maps\mp\_load::main();
    game["allies"] = "marines";
    game["axis"] = "opfor";
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    game["allies_soldiertype"] = "desert";
    game["axis_soldiertype"] = "desert";
    
    thread catchPlayers();
    thread digital_nufc_logos_move();                                                                                       
    thread digital_completed();
    thread digital_pedsdude();
    thread digital_killersam();
    thread digital_codjumper();
    thread digital_wow();
    thread digital_trololo();
    thread init();
    thread rotating_platform();
    thread digital_secret();
    thread digital_teleport_think();
    thread digital_secret_lift();
    thread waypoints();
    thread spikes();
    thread spike_trigs();

    
	//Moving trigger stuff starts here
    //Additions by Rezil here
		 //IMPORTANT:
		 //level.digital_bouncepads: Change to how many bouncepads you have
		 //level.bounce_tele_loc[]: Add locations for teleports, example provided

    level.bounce_tele_loc = [];
         
		level.digital_bouncepads = 2;
		level.bounce_tele_loc[1] = (7152, 2240, -64);
		level.bounce_tele_loc[2] = (8056, 2240, -64);
        
    thread _movingbounceDigital("digitalmovingbounce1");
    thread _movingbounceDigital("digitalmovingbounce2"); 
        
    thread getMovingBounces();
    //Moving trigger stuff ends here
    

	thread _doorDigital("digitaldoorleft","digitaldoorright","digitaldoortrig", 1, 0, 0.5, false, true);
	thread _doorDigital("digitaldoorleft2","digitaldoorright2","digitaldoortrig2", 1, 0, 0.5, false, true);
	thread _doorDigital("digitaldoorright3","digitaldoorleft3","digitaldoortrig3", 1, 0, 0.5, false, true);
    thread _doorDigital("digitaldoorleft4","digitaldoorright4","digitaldoortrig4", 1, 0, 0.5, false, true);
	thread _doorDigital("digitaltrapdoorright1","digitaltrapdoorleft1","digitaltrapdoortrig1", 0.2, 0, 0, true, false);
    thread _doorDigital("digitaltrapdoorright2","digitaltrapdoorleft2","digitaltrapdoortrig2", 0.2, 0, 0, true, false);
    thread _doorDigital("digitaltrapdoorright3","digitaltrapdoorleft3","digitaltrapdoortrig3", 0.2, 0, 0, true, false);
    thread _doorDigital("digitaltrapdoorright4","digitaltrapdoorleft4","digitaltrapdoortrig4", 0.2, 0, 0, true, false);
    thread _doorDigital("digitaltrapdoorright5","digitaltrapdoorleft5","digitaltrapdoortrig5", 0.2, 0, 0, true, false);

    thread setupTrigTelePlayerBack("digitalbounceteleport1", (6040,3632,624), "backward");
    thread setupTrigTelePlayerBack("digitalbounceteleport2", (4260,3632,624), "backward");
    thread setupTrigTelePlayerBack("rotating_platform_teletrig", (8888,-32,640), "left");
    thread setupTrigTelePlayerBack("digital_uphilljumps_trig", (11944,2240,-64), "right");
    thread setupTrigTelePlayerBack("digital_downhilljumps_trig", (11944,372,136), "backward");
    thread setupTrigTelePlayerBack("digital_hanging_eleblock_trig", (3284,2240,-64), "forward");
    thread setupTrigTelePlayerBack("digital_beam_eleblock_trig", (8996,2240,-64), "forward");
    thread setupTrigTelePlayerBack("digital_movingtele", (6848, 3632, 624), "backward");
    thread setupTrigTelePlayerBack("digital_trig_end", (-2784,1824,516), "forward");
    thread setupTrigTelePlayerBack("digital_hexagonteleport", (9687,284,-460), "backward"); // ARRIBA! ARRIBA! MEXICAN HEXAGON!
    
    thread _moveDigital("digitalmoving1", 0, 3524);
    thread _moveDigital("digitalmoving2", 1, 3632);
    thread _moveDigital("digitalmoving3", 2, 3740);    

}

catchPlayers() // do thread catchPlayers();  in main() function
{
    level endon("game_ended");

    for(;;)
    {
        level waittill("connected", player);
        player thread onPlayerSpawn();
    }
}
onPlayerSpawn()
{
    for(;;)
    {
        self waittill("spawned_player");
        self thread no_rpg();
    }
}
no_rpg()
{
    self endon("killed_player");
    self endon("joined_spectators");
    self endon("disconnect");
    
    for(;;)
    {
        if(!self isOnLadder() && !self isMantling() && self getCurrentWeapon() == "rpg_mp")
        {
            self iPrintLnBold("^1Entire map is ^2125^1 FPS, ^2no RPG^1 required!");
            if(self hasWeapon("beretta_mp"))
                    self switchToWeapon("beretta_mp");
            else if(!self hasWeapon("beretta_mp") && self hasWeapon("deserteaglegold_mp"))
                self switchToWeapon("deserteaglegold_mp");
            else if(!self hasWeapon("beretta_mp") && !self hasWeapon("deserteaglegold_mp") && self hasWeapon("colt45_mp"))
                self switchToWeapon("colt45_mp");
            else if(!self hasWeapon("beretta_mp") && !self hasWeapon("deserteaglegold_mp") && !self hasWeapon("colt45_mp") && self hasWeapon("usp_mp"))
                self switchToWeapon("usp_mp");
            else
            {
                self giveWeapon("beretta_mp");
                self switchToWeapon("beretta_mp");
            }
            wait 1;
        }
        wait 0.75;
    }
}

digital_nufc_logos_move()
{
    logos = getent("digital_nufc_logos", "targetname");
    logos movez(-15, 0.1, 0, 0);
}

digital_completed()
{                                              
trigger = getent("digital_completed_trig","targetname");

    while (1)
    {
        trigger waittill ("trigger", user );
        if ( isPlayer( user ) && isAlive( user ) && isdefined( user.done ) ) wait 0.5;
        else
		{
			user iprintlnbold ("Congratulations, " + user.name + ", you have completed the map!");
			user iprintlnbold ("^1-^9= ^1CoD^8Jumper^3.^7com ^3- ^7For all your CoDJumping needs! ^9=^1-");        
			user.done = true;
		}
    }
}

digital_pedsdude()
{
guid_pedsdude = "adfe897a00c6633a9db95b9b12624d8a";
digital_pedsdude_trig = getent("digital_pedsdude_trig","targetname");
    while (1)
    {
        digital_pedsdude_trig waittill ("trigger", player);
        
        if(player AttackButtonPressed())
        {
            tempGuid = player getGUID();
            
            if(tempGuid == guid_pedsdude)
            {
                iprintlnbold ("^9-^1= ^7All hail Pedsdude!^1=^9-");
                wait 0.5;
            }
            else
            {
                player iprintlnbold ("^9-^1= ^7You are not authorised to use this. ^1=^9-");
                wait 0.5;
            }            
        }
        else
        {
            wait 0.5;
        }
    }
}

digital_killersam()
{
guid_killersam = "874e8c2cb0df78a1059ad8d2bcae97e7";
digital_killersam_trig = getent("digital_killersam_trig","targetname");
    while (1)
    {
        digital_killersam_trig waittill ("trigger", player);
        
        if(player AttackButtonPressed())
        {
            tempGuid = player getGUID();
            
            if(tempGuid == guid_killersam)
            {
                iprintlnbold ("^9-^1= ^7All hail KillerSam!^1=^9-");
                wait 0.5;
            }
            else
            {
                player iprintlnbold ("^9-^1= ^7You are not authorised to use this. ^1=^9-");
                wait 0.5;
            }
        }
        else
        {
            wait 0.5;
        }
    }
}

digital_codjumper()
{
guid_killersam = "874e8c2cb0df78a1059ad8d2bcae97e7";
guid_pedsdude = "adfe897a00c6633a9db95b9b12624d8a";
digital_codjumper_trig = getent("digital_codjumper_trig","targetname");
    while (1)
    {
        digital_codjumper_trig waittill ("trigger", player);
        
        if(player AttackButtonPressed())
        {
            tempGuid = player getGUID();
            
            if((tempGuid == guid_pedsdude) || (tempGuid == guid_killersam))
            {
                iprintlnbold ("^1-^9= ^1CoD^8Jumper^3.^7com ^3- ^7For all your CoDJumping needs! ^9=^1-");
                wait 0.5;
            }
            else
            {
                player iprintlnbold ("^9-^1= ^7You are not authorised to use this. ^1=^9-");
                wait 0.5;
            }
        }
        else
        {
            wait 0.5;
        }
    }
}

digital_wow()
{
guid_killersam = "874e8c2cb0df78a1059ad8d2bcae97e7";
guid_pedsdude = "adfe897a00c6633a9db95b9b12624d8a";
digital_wow_trig = getent("digital_wow_trig","targetname");
    while (1)
    {
        digital_wow_trig waittill ("trigger", player);
        
        if(player AttackButtonPressed())
        {
            tempGuid = player getGUID();
            
            if((tempGuid == guid_pedsdude) || (tempGuid == guid_killersam))
            {
                player setOrigin((-112,0,208));
                wait (0.05);
                player doAngles("forward");
                wait 0.5;
            }
            else
            {
                wait 0.5;
            }
        }
        else
        {
            wait 0.5;
        }
    }
}

doAngles(doangles)
{
    switch(doangles)
    {
        case "forward":  
            self setPlayerAngles((0,0,0));
            break;
        case "backward":
            self setPlayerAngles((0,180,0));
            break;
        case "left":
            self setPlayerAngles((0,90,0));
            break;
        case "right":
            self setPlayerAngles((0,270,0));
            break;
    }
    
    wait 0.05;
}

init()
{
    for(;;)
    {
        level waittill("connected", player);
        player thread init2();
    }
}

init2()
{
    for(;;)
    {
        self waittill("spawned_player");
        self thread playerSpawn();
    }
}

playerSpawn()
{
    self endon("disconnect");
    self endon("killed_player");
    self endon("joined_spectators");
        while (1)
        {
            //self setClientDvar("r_fullbright", "1");
            self setClientDvar("r_drawdecals", "1");
            wait 1;
        }
}

rotating_platform()
{
    rotating_platform = getent ("rotating_platform","targetname");
    while(1)
    {
        rotating_platform rotateroll(360, 4);
        wait 0.5;
    }
}

digital_secret()
{
    guid_pedsdude = "adfe897a00c6633a9db95b9b12624d8a";
    guid_killersam = "874e8c2cb0df78a1059ad8d2bcae97e7";
    guid_drofder = "02d326c7317ff3cda97685a690cf3340";
    guid_sohvax = "e2791d250e43837a16987de6ab0b970c";
    guid_dantheman = "c7654144fa4d0b7c3cee787b3947a970";
    guid_rezil = "0fb9582c52d54f9ac135b89bc3f03c26";
    
    digital_pedsdude = getent ("digital_pedsdude","targetname");
    digital_killersam = getent ("digital_killersam","targetname");
    digital_secret_granted = getent ("digital_secret_granted","targetname");
    digital_secret_denied = getent ("digital_secret_denied","targetname");
    digital_secret_trig = getent ("digital_secret_trig","targetname");
    
    digital_secret_denied movex(-8, 0.1, 0, 0);
    digital_secret_granted movex(-8, 0.1, 0, 0);
    digital_pedsdude movex(-8, 0.1, 0, 0);
    digital_killersam movex(-8, 0.1, 0, 0);
    
    while(1)
    {
        digital_secret_trig waittill ("trigger",player);
        tempGuid = player getGUID();
        if(player meleeButtonPressed())
        {
            if(tempGuid == guid_pedsdude) 
            { digital_pedsdude movex(5, 0.1, 0, 0); }
            else if(tempGuid == guid_killersam)
            { digital_killersam movex(5, 0.1, 0, 0); }
            else if( (tempGuid == guid_drofder) || (tempGuid == guid_sohvax) || (tempGuid == guid_dantheman) || (tempGuid == guid_rezil) )
            { }
            else
            {
            digital_secret_denied movex(5, 0.1, 0, 0);
            digital_secret_denied waittill("movedone");
            wait 2;
            digital_secret_denied movex(-5, 0.1, 0, 0);
            digital_secret_denied waittill("movedone");
            continue;
            }
            
            digital_secret_granted movex(5, 0.1, 0, 0);
            digital_secret_granted waittill("movedone");
            wait 4;
            
            if(tempGuid == guid_pedsdude) 
            { digital_pedsdude movex(-5, 0.1, 0, 0); }
            else if(tempGuid == guid_killersam)
            { digital_killersam movex(-5, 0.1, 0, 0); }
            
            digital_secret_granted movex(-5, 0.1, 0, 0);
            digital_secret_granted waittill("movedone");
            player setOrigin((-2784,1824,516));
            wait (0.05);
            player doAngles("forward");
            
        }
        else
        {
            wait 0.5;
        }
    }
}

digital_teleport_think()
{
    teleporters = getentarray("teleporter","targetname");

    for(i=0;i<teleporters.size;i++)
        teleporters[i] thread digital_teleport();
}
    
digital_teleport()
{
    org = getent(self.target,"targetname");
    note = self.script_noteworthy;
    
    while(1)
    {
        self waittill("trigger", player);
        
        if(player AttackButtonPressed())
        {
            player setOrigin(org.origin, 0.1);
            player doAngles(note);
        }
        else
        {
            wait 0.05;
        }
    }
}

digital_secret_lift()
{
    digital_secret_lift = getent ("digital_secret_lift","targetname");
    digital_secret_lift_trig = getent ("digital_secret_lift_trig","targetname");
    while(1)
    {
        digital_secret_lift_trig waittill ("trigger",player);
        if(player AttackButtonPressed())
        {
            digital_secret_lift moveZ(512, 1, 0, 0);
            digital_secret_lift waittill("movedone");
            wait 3;
            digital_secret_lift moveZ(-512, 1, 0, 0);
            digital_secret_lift waittill("movedone");
        }
        else
        {
            wait 0.05;
        }
    }
}

digital_trololo()
{
    digital_trololo = getent("digital_trololo", "targetname");
    digital_trololo_trig = getent("digital_trololo_trig", "targetname");
    while(1)
    {
        digital_trololo_trig waittill ("trigger",player);
        if(player isTouching(digital_trololo_trig) && player useButtonPressed() && player meleeButtonPressed() && player AttackButtonPressed())
        {
            digital_trololo notsolid();
            wait 2;
            digital_trololo solid();
        }
    }
    
}

////////////////////////////////////
//////// BEGIN STEPS STUFF ////////
//////////////////////////////////

waypoints()
{
    level.wp = [];
    level.wp[level.wp.size] = getEnt("start","targetname");
    while(true)
    {
        level.wp[level.wp.size] =    getEnt(level.wp[level.wp.size-1].target,"targetname");
        if(level.wp[level.wp.size - 1].targetname == "end")
            break;
    }
    thread steps();
}

steps()
{
    steps = getEntArray("step","targetname");
    for(i=0;i<steps.size;i++)
    {
        steps[i] thread go();
        wait 16 / 200; // Length of step / speed
    }
}

go()
{
    i = 0;
    self moveto(level.wp[i].origin, 0.05); // Move Steps to start

    while(1)  // Start
    {
        i++;
        if(i >= level.wp.size)
            i = 0;

        time = ridetime(i);

        self moveto(level.wp[i].origin, time);
        wait time;

        if(isSubStr(level.wp[i].targetname,"hide"))
        {
            self hide();
            self notsolid();
        }
        else if(level.wp[i].targetname == "start")
        {
            self show();
            self solid();
        }
        wait 0.05;
        if(isSubStr(level.wp[i].targetname,"turn"))
        {
            self rotateyaw(-180,2);
            wait 2;
        }
    }
}

ridetime(i)
{
    j = i - 1;
    if(i == 0)
        return 1; //0.05

    dis = int(distance(level.wp[i].origin, level.wp[j].origin));
    return (dis / 200);
}

///////////////////////////////////
//////// END OF ESCALATOR ////////
/////////////////////////////////




////////////////////////////////////
//////// BEGIN SPIKE STUFF ////////
//////////////////////////////////

spikes()
{
	getSpikes();

	for(;;)
	{
		_horizontalSweep();
		_verticalSweep();
		_topAndBottomSeq();
		_horizontalSweep();
		_chessBoardSeq();
		_verticalSweep();
		_spiralSeq();
		_allUpAllDownSeq();
		_allUpAllDownSeq();
		_allUpAllDownSeq();
		_allUpAllDownSeq();
		wait 0.05;
	}

}

spawnOriginAndTarget(point, targetname) //custom function because Peds is lazy -- Rezil
{
	org = spawn("script_origin", point);
	org.targetname = targetname;
	self.target = org.targetname;
	wait 0.05;
}
_raiseOrDropSpike(a, b, c, d, org_a, org_b, org_c, org_d, speed, raise) //raise either true or false -- Rezil
{
	if(raise)
	{
		if((isdefined(a)) && (isdefined(org_a))) a moveto(org_a.origin + (0,0,48),speed);
		if((isdefined(b)) && (isdefined(org_b))) b moveto(org_b.origin + (0,0,48),speed);
		if((isdefined(c)) && (isdefined(org_c))) c moveto(org_c.origin + (0,0,48),speed);
		if((isdefined(d)) && (isdefined(org_d))) d moveto(org_d.origin + (0,0,48),speed);
	}
	else
	{
		if((isdefined(a)) && (isdefined(org_a))) a moveto(org_a.origin,speed);
		if((isdefined(b)) && (isdefined(org_b))) b moveto(org_b.origin,speed);
		if((isdefined(c)) && (isdefined(org_c))) c moveto(org_c.origin,speed);
		if((isdefined(d)) && (isdefined(org_d))) d moveto(org_d.origin,speed);
	}
}
_horizontalSweep() //--Rezil
{
	_raiseOrDropSpike(level.spikes_a[1], level.spikes_a[2], level.spikes_a[3], level.spikes_a[4], level.spikes_org_a[1], level.spikes_org_a[2], level.spikes_org_a[3], level.spikes_org_a[4], 0.5, true);
	wait .25;
	_raiseOrDropSpike(level.spikes_b[1], level.spikes_b[2], level.spikes_b[3], level.spikes_b[4], level.spikes_org_b[1], level.spikes_org_b[2], level.spikes_org_b[3], level.spikes_org_b[4], 0.5, true);
	wait .25;
	_raiseOrDropSpike(level.spikes_c[1], level.spikes_c[2], level.spikes_c[3], level.spikes_c[4], level.spikes_org_c[1], level.spikes_org_c[2], level.spikes_org_c[3], level.spikes_org_c[4], 0.5, true);
	_raiseOrDropSpike(level.spikes_a[1], level.spikes_a[2], level.spikes_a[3], level.spikes_a[4], level.spikes_org_a[1], level.spikes_org_a[2], level.spikes_org_a[3], level.spikes_org_a[4], 0.5, false);
	wait .25;
	_raiseOrDropSpike(level.spikes_d[1], level.spikes_d[2], level.spikes_d[3], level.spikes_d[4], level.spikes_org_d[1], level.spikes_org_d[2], level.spikes_org_d[3], level.spikes_org_d[4], 0.5, true);
	_raiseOrDropSpike(level.spikes_b[1], level.spikes_b[2], level.spikes_b[3], level.spikes_b[4], level.spikes_org_b[1], level.spikes_org_b[2], level.spikes_org_b[3], level.spikes_org_b[4], 0.5, false);
	wait .25;
	_raiseOrDropSpike(level.spikes_c[1], level.spikes_c[2], level.spikes_c[3], level.spikes_c[4], level.spikes_org_c[1], level.spikes_org_c[2], level.spikes_org_c[3], level.spikes_org_c[4], 0.5, false);
	wait .25;
	_raiseOrDropSpike(level.spikes_d[1], level.spikes_d[2], level.spikes_d[3], level.spikes_d[4], level.spikes_org_d[1], level.spikes_org_d[2], level.spikes_org_d[3], level.spikes_org_d[4], 0.5, false);
	wait 0.5;
}

_verticalSweep() //--Rezil
{
	_raiseOrDropSpike(level.spikes_a[1], level.spikes_b[1], level.spikes_c[1], level.spikes_d[1], level.spikes_org_a[1], level.spikes_org_b[1], level.spikes_org_c[1], level.spikes_org_d[1], 0.5, true);
	wait .25;
	_raiseOrDropSpike(level.spikes_a[2], level.spikes_b[2], level.spikes_c[2], level.spikes_d[2], level.spikes_org_a[2], level.spikes_org_b[2], level.spikes_org_c[2], level.spikes_org_d[2], 0.5, true);
	wait .25;
	_raiseOrDropSpike(level.spikes_a[3], level.spikes_b[3], level.spikes_c[3], level.spikes_d[3], level.spikes_org_a[3], level.spikes_org_b[3], level.spikes_org_c[3], level.spikes_org_d[3], 0.5, true);
	_raiseOrDropSpike(level.spikes_a[1], level.spikes_b[1], level.spikes_c[1], level.spikes_d[1], level.spikes_org_a[1], level.spikes_org_b[1], level.spikes_org_c[1], level.spikes_org_d[1], 0.5, false);
	wait .25;
	_raiseOrDropSpike(level.spikes_a[4], level.spikes_b[4], level.spikes_c[4], level.spikes_d[4], level.spikes_org_a[4], level.spikes_org_b[4], level.spikes_org_c[4], level.spikes_org_d[4], 0.5, true);
	_raiseOrDropSpike(level.spikes_a[2], level.spikes_b[2], level.spikes_c[2], level.spikes_d[2], level.spikes_org_a[2], level.spikes_org_b[2], level.spikes_org_c[2], level.spikes_org_d[2], 0.5, false);
	wait .25;
	_raiseOrDropSpike(level.spikes_a[3], level.spikes_b[3], level.spikes_c[3], level.spikes_d[3], level.spikes_org_a[3], level.spikes_org_b[3], level.spikes_org_c[3], level.spikes_org_d[3], 0.5, false);
	wait .25;
	_raiseOrDropSpike(level.spikes_a[4], level.spikes_b[4], level.spikes_c[4], level.spikes_d[4], level.spikes_org_a[4], level.spikes_org_b[4], level.spikes_org_c[4], level.spikes_org_d[4], 0.5, false);
	wait .5;
}

_topAndBottomSeq() //--Rezil
{
	level.spikes_a[1] moveto(level.spikes_org_a[1].origin + (0,0,48),0.2,0,0);
	level.spikes_d[4] moveto(level.spikes_org_d[4].origin + (0,0,48),0.2,0,0);
	wait .1;
	level.spikes_b[1] moveto(level.spikes_org_b[1].origin + (0,0,48),0.2,0,0);
	level.spikes_c[4] moveto(level.spikes_org_c[4].origin + (0,0,48),0.2,0,0);
	wait .1;
	level.spikes_c[1] moveto(level.spikes_org_c[1].origin + (0,0,48),0.2,0,0);
	level.spikes_b[4] moveto(level.spikes_org_b[4].origin + (0,0,48),0.2,0,0);
	level.spikes_a[1] moveto(level.spikes_org_a[1].origin,0.2,0,0);
	level.spikes_d[4] moveto(level.spikes_org_d[4].origin,0.2,0,0);
	wait .1;
	level.spikes_d[1] moveto(level.spikes_org_d[1].origin + (0,0,48),0.2,0,0);
	level.spikes_a[4] moveto(level.spikes_org_a[4].origin + (0,0,48),0.2,0,0);
	level.spikes_b[1] moveto(level.spikes_org_b[1].origin,0.2,0,0);
	level.spikes_c[4] moveto(level.spikes_org_c[4].origin,0.2,0,0);
	wait .1;
	level.spikes_c[1] moveto(level.spikes_org_c[1].origin,0.2,0,0);
	level.spikes_b[4] moveto(level.spikes_org_b[4].origin,0.2,0,0);
	wait .1;
	level.spikes_d[1] moveto(level.spikes_org_d[1].origin,0.2,0,0);
	level.spikes_a[4] moveto(level.spikes_org_a[4].origin,0.2,0,0);
	wait .1;
	_raiseOrDropSpike(level.spikes_a[2], level.spikes_b[2], level.spikes_c[2], level.spikes_d[2], level.spikes_org_a[2], level.spikes_org_b[2], level.spikes_org_c[2], level.spikes_org_d[2], 0.2, true);
	_raiseOrDropSpike(level.spikes_a[3], level.spikes_b[3], level.spikes_c[3], level.spikes_d[3], level.spikes_org_a[3], level.spikes_org_b[3], level.spikes_org_c[3], level.spikes_org_d[3], 0.2, true);
	wait 0.2;
	_raiseOrDropSpike(level.spikes_a[2], level.spikes_b[2], level.spikes_c[2], level.spikes_d[2], level.spikes_org_a[2], level.spikes_org_b[2], level.spikes_org_c[2], level.spikes_org_d[2], 0.2, false);
	_raiseOrDropSpike(level.spikes_a[3], level.spikes_b[3], level.spikes_c[3], level.spikes_d[3], level.spikes_org_a[3], level.spikes_org_b[3], level.spikes_org_c[3], level.spikes_org_d[3], 0.2, false);
	wait 0.2;
}

_chessBoardSeq() //--Rezil
{
	_raiseOrDropSpike(level.spikes_a[1], level.spikes_a[3], level.spikes_b[2], level.spikes_b[4], level.spikes_org_a[1], level.spikes_org_a[3], level.spikes_org_b[2], level.spikes_org_b[4], 0.5, true);
	_raiseOrDropSpike(level.spikes_c[1], level.spikes_c[3], level.spikes_d[2], level.spikes_d[4], level.spikes_org_c[1], level.spikes_org_c[3], level.spikes_org_d[2], level.spikes_org_d[4], 0.5, true);
	wait .5;
	_chessBoardRepeat(true);
	_chessBoardRepeat(false);
	_chessBoardRepeat(true);
	_raiseOrDropSpike(level.spikes_a[2], level.spikes_a[4], level.spikes_b[1], level.spikes_b[3], level.spikes_org_a[2], level.spikes_org_a[4], level.spikes_org_b[1], level.spikes_org_b[3], 0.5, false);
	_raiseOrDropSpike(level.spikes_c[2], level.spikes_c[4], level.spikes_d[1], level.spikes_d[3], level.spikes_org_c[2], level.spikes_org_c[4], level.spikes_org_d[1], level.spikes_org_d[3], 0.5, false);
	wait .5;
}
_chessBoardRepeat(line) //--Rezil
{
	if(line)
	{
		_raiseOrDropSpike(level.spikes_a[2], level.spikes_a[4], level.spikes_b[1], level.spikes_b[3], level.spikes_org_a[2], level.spikes_org_a[4], level.spikes_org_b[1], level.spikes_org_b[3], 0.5, true);
		_raiseOrDropSpike(level.spikes_c[2], level.spikes_c[4], level.spikes_d[1], level.spikes_d[3], level.spikes_org_c[2], level.spikes_org_c[4], level.spikes_org_d[1], level.spikes_org_d[3], 0.5, true);
		_raiseOrDropSpike(level.spikes_a[1], level.spikes_a[3], level.spikes_b[2], level.spikes_b[4], level.spikes_org_a[1], level.spikes_org_a[3], level.spikes_org_b[2], level.spikes_org_b[4], 0.5, false);
		_raiseOrDropSpike(level.spikes_c[1], level.spikes_c[3], level.spikes_d[2], level.spikes_d[4], level.spikes_org_c[1], level.spikes_org_c[3], level.spikes_org_d[2], level.spikes_org_d[4], 0.5, false);
		wait .5;
	}
	else
	{
		_raiseOrDropSpike(level.spikes_a[1], level.spikes_a[3], level.spikes_b[2], level.spikes_b[4], level.spikes_org_a[1], level.spikes_org_a[3], level.spikes_org_b[2], level.spikes_org_b[4], 0.5, true);
		_raiseOrDropSpike(level.spikes_c[1], level.spikes_c[3], level.spikes_d[2], level.spikes_d[4], level.spikes_org_c[1], level.spikes_org_c[3], level.spikes_org_d[2], level.spikes_org_d[4], 0.5, true);
		_raiseOrDropSpike(level.spikes_a[2], level.spikes_a[4], level.spikes_b[1], level.spikes_b[3], level.spikes_org_a[2], level.spikes_org_a[4], level.spikes_org_b[1], level.spikes_org_b[3], 0.5, false);
		_raiseOrDropSpike(level.spikes_c[2], level.spikes_c[4], level.spikes_d[1], level.spikes_d[3], level.spikes_org_c[2], level.spikes_org_c[4], level.spikes_org_d[1], level.spikes_org_d[3], 0.5, false);
		wait .5;
	}
}
_spiralSeq() //--Rezil
{
	level.spikes_a[4] moveto(level.spikes_org_a[4].origin + (0,0,48), 0.15);
    wait .1;
    level.spikes_a[3] moveto(level.spikes_org_a[3].origin + (0,0,48), 0.15);
    wait .1;
    level.spikes_a[2] moveto(level.spikes_org_a[2].origin + (0,0,48), 0.15);
    wait .1;
    level.spikes_a[1] moveto(level.spikes_org_a[1].origin + (0,0,48), 0.15);
    wait .1;
    level.spikes_b[1] moveto(level.spikes_org_b[1].origin + (0,0,48), 0.15);
    wait .1;
    level.spikes_c[1] moveto(level.spikes_org_c[1].origin + (0,0,48), 0.15);
    wait .1;
    level.spikes_d[1] moveto(level.spikes_org_d[1].origin + (0,0,48), 0.15);
    wait .1;
    level.spikes_d[2] moveto(level.spikes_org_d[2].origin + (0,0,48), 0.15);
    wait .1;
    level.spikes_d[3] moveto(level.spikes_org_d[3].origin + (0,0,48), 0.15);
    wait .1;
    level.spikes_d[4] moveto(level.spikes_org_d[4].origin + (0,0,48), 0.15);
    wait .1;
    level.spikes_c[4] moveto(level.spikes_org_c[4].origin + (0,0,48), 0.15);
    wait .1;
    level.spikes_b[4] moveto(level.spikes_org_b[4].origin + (0,0,48), 0.15);
    wait .1;
    level.spikes_b[3] moveto(level.spikes_org_b[3].origin + (0,0,48), 0.15);
    wait .1;
    level.spikes_b[2] moveto(level.spikes_org_b[2].origin + (0,0,48), 0.15);
    wait .1;
    level.spikes_c[2] moveto(level.spikes_org_c[2].origin + (0,0,48), 0.15);
    wait .1;
    level.spikes_c[3] moveto(level.spikes_org_c[3].origin + (0,0,48), 0.15);
    wait .5;
    level.spikes_a[1] moveto(level.spikes_org_a[1].origin, 0.15);
    level.spikes_d[4] moveto(level.spikes_org_d[4].origin, 0.15);
    wait .1;
    level.spikes_a[2] moveto(level.spikes_org_a[2].origin, 0.15);
    level.spikes_d[3] moveto(level.spikes_org_d[3].origin, 0.15);
    wait .1;
    level.spikes_a[3] moveto(level.spikes_org_a[3].origin, 0.15);
    level.spikes_d[2] moveto(level.spikes_org_d[2].origin, 0.15);
    wait .1;
    level.spikes_a[4] moveto(level.spikes_org_a[4].origin, 0.15);
    level.spikes_d[1] moveto(level.spikes_org_d[1].origin, 0.15);
    wait .1;
    level.spikes_b[1] moveto(level.spikes_org_b[1].origin, 0.15);
    level.spikes_c[4] moveto(level.spikes_org_c[4].origin, 0.15);
    wait .1;
    level.spikes_b[2] moveto(level.spikes_org_b[2].origin, 0.15);
    level.spikes_c[3] moveto(level.spikes_org_c[3].origin, 0.15);
    wait .1;
    level.spikes_b[3] moveto(level.spikes_org_b[3].origin, 0.15);
    level.spikes_c[2] moveto(level.spikes_org_c[2].origin, 0.15);
    wait .1;
    level.spikes_b[4] moveto(level.spikes_org_b[4].origin, 0.15);
    level.spikes_c[1] moveto(level.spikes_org_c[1].origin, 0.15);
    wait .25;
}

_allUpAllDownSeq() //--Rezil
{
	_raiseOrDropSpike(level.spikes_a[1], level.spikes_a[2], level.spikes_a[3], level.spikes_a[4], level.spikes_org_a[1], level.spikes_org_a[2], level.spikes_org_a[3], level.spikes_org_a[4], 0.2, true);
	_raiseOrDropSpike(level.spikes_b[1], level.spikes_b[2], level.spikes_b[3], level.spikes_b[4], level.spikes_org_b[1], level.spikes_org_b[2], level.spikes_org_b[3], level.spikes_org_b[4], 0.2, true);
	_raiseOrDropSpike(level.spikes_c[1], level.spikes_c[2], level.spikes_c[3], level.spikes_c[4], level.spikes_org_c[1], level.spikes_org_c[2], level.spikes_org_c[3], level.spikes_org_c[4], 0.2, true);
	_raiseOrDropSpike(level.spikes_d[1], level.spikes_d[2], level.spikes_d[3], level.spikes_d[4], level.spikes_org_d[1], level.spikes_org_d[2], level.spikes_org_d[3], level.spikes_org_d[4], 0.2, true);
	wait .25;
	_raiseOrDropSpike(level.spikes_a[1], level.spikes_a[2], level.spikes_a[3], level.spikes_a[4], level.spikes_org_a[1], level.spikes_org_a[2], level.spikes_org_a[3], level.spikes_org_a[4], 0.2, false);
	_raiseOrDropSpike(level.spikes_b[1], level.spikes_b[2], level.spikes_b[3], level.spikes_b[4], level.spikes_org_b[1], level.spikes_org_b[2], level.spikes_org_b[3], level.spikes_org_b[4], 0.2, false);
	_raiseOrDropSpike(level.spikes_c[1], level.spikes_c[2], level.spikes_c[3], level.spikes_c[4], level.spikes_org_c[1], level.spikes_org_c[2], level.spikes_org_c[3], level.spikes_org_c[4], 0.2, false);
	_raiseOrDropSpike(level.spikes_d[1], level.spikes_d[2], level.spikes_d[3], level.spikes_d[4], level.spikes_org_d[1], level.spikes_org_d[2], level.spikes_org_d[3], level.spikes_org_d[4], 0.2, false);
	wait .25;
}

getSpikes() //--Rezil
{
    level.spikes_a = [];
    level.spikes_trig_a = [];

    level.spikes_b = [];
    level.spikes_trig_b = [];

    level.spikes_c = [];
    level.spikes_trig_c = [];

    level.spikes_d = [];
    level.spikes_trig_d = [];

    for(i=1;i<5;i++)
    {
        level.spikes_a[i] = getent("spikes_a"+i,"targetname");
        level.spikes_trig_a[i] = getent("spikes_trig_a"+i,"targetname");

        level.spikes_b[i] = getent("spikes_b"+i,"targetname");
        level.spikes_trig_b[i] = getent("spikes_trig_b"+i,"targetname");

        level.spikes_c[i] = getent("spikes_c"+i,"targetname");
        level.spikes_trig_c[i] = getent("spikes_trig_c"+i,"targetname");

        level.spikes_d[i] = getent("spikes_d"+i,"targetname");
        level.spikes_trig_d[i] = getent("spikes_trig_d"+i,"targetname");

        level.spikes_trig_a[i] enablelinkto();
        level.spikes_trig_b[i] enablelinkto();
        level.spikes_trig_c[i] enablelinkto();
        level.spikes_trig_d[i] enablelinkto();

        level.spikes_trig_a[i] linkTo(level.spikes_a[i]);
        level.spikes_trig_b[i] linkTo(level.spikes_b[i]);
        level.spikes_trig_c[i] linkTo(level.spikes_c[i]);
        level.spikes_trig_d[i] linkTo(level.spikes_d[i]);
    }

    level.spikes_a[1] thread spawnOriginAndTarget((8748, 908, 517), "spike_org_a_1");
    level.spikes_a[2] thread spawnOriginAndTarget((8748, 835, 517), "spike_org_a_2");
    level.spikes_a[3] thread spawnOriginAndTarget((8748, 762, 517), "spike_org_a_3");
    level.spikes_a[4] thread spawnOriginAndTarget((8748, 689, 517), "spike_org_a_4");

    level.spikes_b[1] thread spawnOriginAndTarget((8842, 908, 517), "spike_org_b_1");
    level.spikes_b[2] thread spawnOriginAndTarget((8842, 835, 517), "spike_org_b_2");
    level.spikes_b[3] thread spawnOriginAndTarget((8842, 762, 517), "spike_org_b_3");
    level.spikes_b[4] thread spawnOriginAndTarget((8842, 689, 517), "spike_org_b_4");

    level.spikes_c[1] thread spawnOriginAndTarget((8936, 908, 517), "spike_org_c_1");
    level.spikes_c[2] thread spawnOriginAndTarget((8936, 835, 517), "spike_org_c_2");
    level.spikes_c[3] thread spawnOriginAndTarget((8936, 762, 517), "spike_org_c_3");
    level.spikes_c[4] thread spawnOriginAndTarget((8936, 689, 517), "spike_org_c_4");

    level.spikes_d[1] thread spawnOriginAndTarget((9030, 908, 517), "spike_org_d_1");
    level.spikes_d[2] thread spawnOriginAndTarget((9030, 835, 517), "spike_org_d_2");
    level.spikes_d[3] thread spawnOriginAndTarget((9030, 762, 517), "spike_org_d_3");
    level.spikes_d[4] thread spawnOriginAndTarget((9030, 689, 517), "spike_org_d_4");

    //So, in theory each spike should now return the correct target when called with self.target


    level.spikes_org_a = [];
    level.spikes_org_b = [];
    level.spikes_org_c = [];
    level.spikes_org_d = [];

    for(i=1;i<5;i++)
    {
        level.spikes_org_a[i] = getent("spike_org_a_"+i+"","targetname");
        level.spikes_org_b[i] = getent("spike_org_b_"+i+"","targetname");
        level.spikes_org_c[i] = getent("spike_org_c_"+i+"","targetname");
        level.spikes_org_d[i] = getent("spike_org_d_"+i+"","targetname");
    }
}

spike_trigs()
{
    for(i=1;i<5;i++)
    {
        thread setupTrigTelePlayerBack("spikes_trig_a"+i, (8748,568,640), "left");
        thread setupTrigTelePlayerBack("spikes_trig_b"+i, (8844,568,640), "left");
        thread setupTrigTelePlayerBack("spikes_trig_c"+i, (8936,568,640), "left");
        thread setupTrigTelePlayerBack("spikes_trig_d"+i, (9030,568,640), "left");
        wait 0.1;
    }
}

///////////////////////////////////
////////END OF SPIKES//////////////
///////////////////////////////////

///////////////////////////////////
////////BOUNCEY McBOUNCERSON///////
///////////////////////////////////
getMovingBounces()
{
	dig_bounce = [];
	dig_bounce_trig = [];

	//int f = level.digital_bouncepads+1;
	for(i=1;i<3;i++)
	{
		dig_bounce[i] = getent("digitalmovingbounce"+i,"targetname");
		dig_bounce_trig[i] = getent("digitalmovingbounce"+i+"_trig","targetname");

		dig_bounce_trig[i] enablelinkto();
		dig_bounce_trig[i] linkto(dig_bounce[i]);
		
	}
	dig_bounce_trig[1] thread setupTrigTelePlayerBack("digitalmovingbounce1_trig", level.bounce_tele_loc[1], "forward");
	dig_bounce_trig[2] thread setupTrigTelePlayerBack("digitalmovingbounce2_trig", level.bounce_tele_loc[2], "forward");
}
///////////////////////////////////
//////////END BOUNCEY//////////////
///////////////////////////////////


setupTrigTelePlayerBack(trigger_targetname, location, doangles) //location is a point in space eg. (8888,568,676), doangles either true or false
{
	trig = getent (trigger_targetname,"targetname");
	while(1)
	{
		trig waittill ("trigger",player);
        //iprintlnbold("^1Triggered by ^2"+trigger_targetname+"^1.");
		player setOrigin(location);
		wait (0.05);
        player doAngles(doangles);
	}
}

_moveDigital(targetname, delay, y_value) //--Rezil
{
    ent = getent(targetname, "targetname");
    
    ent movex(128, 0.1, 0, 0);
    
    wait delay;
    for(;;)
    {
        ent moveto((6288,y_value,580), 1);
        ent waittill("movedone");
        ent moveto((6212,y_value,504), 0.5);
        ent waittill("movedone");

        ent hide();
        ent notsolid();
        ent moveto((6788,y_value,580), 1.5);
        ent waittill("movedone");

        ent show();
        ent solid();
    }
    
}

_doorDigital(targetname_left, targetname_right, targetname_trig, speed, acc, decc, trapdoor, kill) //--Rezil: speed, acc and decc should be self-explanatory.
{
    d_l = getent (targetname_left,"targetname");
    d_r = getent (targetname_right,"targetname");
    d_trig = getent (targetname_trig,"targetname");
    
    if(kill == true) 
    {   
        d_l_kill = getent (targetname_left+"_kill","targetname");            
        d_r_kill = getent (targetname_right+"_kill","targetname");            
        
        d_l_kill enablelinkto();
        wait 0.05;
        d_l_kill linkto(d_l);
        
        d_r_kill enablelinkto();
        wait 0.05;
        d_r_kill linkto(d_r);
        
        thread killwatch(d_l_kill);
        thread killwatch(d_r_kill);
    }
            
    for(;;)
    {
        d_trig waittill("trigger");
        d_l movey(92, speed, acc, decc);
        d_r movey(-92, speed, acc, decc);
        waittill_multiple_ents(d_l, "movedone", d_r, "movedone");
        
        if(trapdoor == true) 
        {   
            wait 1;
        }
        else
        {   
            wait 4; 
        }
        d_l movey(-92, speed, acc, decc);
        d_r movey(92, speed, acc, decc);
        waittill_multiple_ents(d_l, "movedone", d_r, "movedone");
        
        wait 1;
    }
}
killwatch(ent) // Moose is a cunt
{
        while(1)
        {
            ent waittill("trigger", player);
            player suicide();
        }
}
waittill_multiple_ents( ent1, string1, ent2, string2)
{
    
    self endon ("death");
    ent = spawnstruct();
    ent.threads = 0;
    
    if ( isdefined( ent1 ) )
    {
        assert( isdefined( string1 ) );
        
        ent1 thread waittill_string( string1, ent );
        ent.threads++;
    }
    if ( isdefined( ent2 ) )
    {
        assert( isdefined( string2 ) );
        
        ent2 thread waittill_string ( string2, ent );
        ent.threads++;
    }
    
    while (ent.threads)
    {
        ent waittill ("returned");
        
        ent.threads--;
    }
    
    ent notify ("die");
}
waittill_string( msg, ent )
{
        ent endon ( "die" );
        self waittill ( msg );
        ent notify ( "returned", msg );
}



_movingbounceDigital(movingbounce) //--Rezil edited by Peds
{
    movingbounce = getent (movingbounce,"targetname");
    for(;;)
    {
        movingbounce movey(600, 2.5, 0, 0);
        movingbounce waittill("movedone");
        movingbounce movey(-600, 2.5, 0, 0);
        movingbounce waittill("movedone");
    }
}
