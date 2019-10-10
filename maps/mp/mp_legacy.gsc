main()
{
	maps\mp\_load::main();
	rotate();
	teleports();
	no_rpg();
	
	ambientPlay("ambient_backlot_ext");
	
	game["allies"] = "sas";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "woodland";
	game["axis_soldiertype"] = "woodland";
	
	setdvar( "r_specularcolorscale", "1" );
	
	setdvar("r_glowbloomintensity0",".25");
	setdvar("r_glowbloomintensity1",".25");
	setdvar("r_glowskybleedintensity0",".3");
	setdvar("compassmaxrange","1800"); 
 
     thread finish("end");
     thread finish("end2");
     thread give_m16();
     thread give_ak47();
     thread give_deagle();
     thread give_m40a3();
     thread jumper();
     thread call_bounce();
}
teleports()
{
    entTransporter = getentarray( "enter", "targetname" );
    if(isdefined(entTransporter))
        for( i = 0; i < entTransporter.size; i++ )
            entTransporter[i] thread transporter();

    entTransporter = [];
    for(i = 1; i < 25; i++)
    {
        entTransporter[i-1] = getentarray( "enter" + i, "targetname" );

        if(isdefined(entTransporter[i-1]))
            for( x = 0; x < entTransporter[i-1].size; x++ )
                entTransporter[i-1][x] thread transporter();
    }
}
 
transporter()
{
    for(;;)
    {
        self waittill( "trigger", player );
        entTarget = getEnt( self.target, "targetname" );
        wait 0.1;
        player setOrigin( entTarget.origin );
        player setplayerangles( entTarget.angles );
        wait 0.1;
    }
}
no_rpg(user)
{
    trigger = getEnt("no_rpg", "targetname");

   if(!isDefined(user))
   {
      for(;;)
      {
         trigger waittill("trigger", user);

         if(isDefined(user.no_rpg))
            continue;

         thread no_rpg(user);
      }
   }

   user endon("disconnect");

   user.no_rpg = true;
      
   for(;user isTouching(trigger);)
   {
      if(!user isOnLadder() && !user isMantling() && weaponType(user getCurrentWeapon()) == "projectile")
      {
         if(user hasWeapon("beretta_mp"))
            user switchToWeapon("beretta_mp");
         else if(!user hasWeapon("beretta_mp") && user hasWeapon("deserteaglegold_mp"))
            user switchToWeapon("deserteaglegold_mp");
         else if(!user hasWeapon("beretta_mp") && !user hasWeapon("deserteaglegold_mp") && user hasWeapon("colt45_mp"))
            user switchToWeapon("colt45_mp");
         else if(!user hasWeapon("beretta_mp") && !user hasWeapon("deserteaglegold_mp") && !user hasWeapon("colt45_mp") && user hasWeapon("usp_mp"))
            user switchToWeapon("usp_mp");
         else
         {
            user giveWeapon("beretta_mp");
            user switchToWeapon("beretta_mp");
         }

         wait 1;
      }

      wait 0.75;
   }

   user.no_rpg = undefined;
}
rotate()
{
    _fan = [];
    for(x = 1; x < 12; x++)
    {
        _fan[x-1] = getentarray("rot"+x,"targetname");
        
        if(isdefined(_fan[x-1]))
            for(i = 0; i < _fan[x-1].size; i++)
                _fan[x-1][i] thread doRotate();
    }
}

doRotate()
{
    while(true)
    {
        self rotateYaw(360,3);
        wait 3;
    }
}

call_bounce()
{
    bounce   = getEntArray("bounce", "targetname");
    for(i = 0;i < bounce.size;i++)
        bounce[i] thread bounce();
}


finish(targetname)
{
    trigger = getent(targetname,"targetname");

    while(1)

    {
        trigger waittill("trigger", player);
        player endon("disconnect");

        if ( isPlayer( player ) && isAlive( player ) && isdefined( player.finish ) )
            wait 0.5;
        else 
        {
            player.blackscreen = newclienthudelem(player);
            player.blackscreen setshader("black",640,480);
            player.blackscreen.horzAlign = "fullscreen"; 
            player.blackscreen.vertAlign = "fullscreen";

            player.credits = newclienthudelem(player);
            player.credits.sort = 99999;
            player.credits.x = 325; 
            player.credits.y = 615;                       
            player.credits.alignX = "center";
            player.credits.horzAlign = "fullscreen";
            player.credits.alignY = "bottom";
            player.credits.font = "default";
            player.credits.fontScale = 1.5;   
            player.credits.label = &"^1Congratulations &&1";
            player.credits setplayernamestring(player);
            player.credits FadeOverTime( 5 );  
            player.credits.alpha = 1;
            player.credits moveovertime(8);
            player.credits.x = 325; 
            player.credits.y = 90;   

            player.credits1 = newclienthudelem(player);
            player.credits1.sort = 99998;
            player.credits1.x = 325; 
            player.credits1.y = 650; 
            player.credits1.alignX = "center";
            player.credits1.horzAlign = "fullscreen";
            player.credits1.alignY = "bottom";
            player.credits1.font = "default";
            player.credits1.fontScale = 1.5;
            player.credits1.label = &"You have completed the Way !";
            player.credits1 FadeOverTime( 5 );  
            player.credits1.alpha = 1;
            player.credits1 moveovertime(8);
            player.credits1.x = 325; 
            player.credits1.y = 125;

            player.credits2 = newclienthudelem(player);
            player.credits2.sort = 99997;
            player.credits2.x = 325; 
            player.credits2.y = 720; 
            player.credits2.alignX = "center";
            player.credits2.horzAlign = "fullscreen";
            player.credits2.alignY = "bottom";
            player.credits2.font = "default";
            player.credits2.fontScale = 1.5;
            player.credits2.label = &"Map by ^6Nicki<3";     
            player.credits2 FadeOverTime( 5 );  
            player.credits2.alpha = 1;
            player.credits2 moveovertime(8);
            player.credits2.x = 325; 
            player.credits2.y = 195;

            player.credits3 = newclienthudelem(player);
            player.credits3.sort = 99996;
            player.credits3.x = 325; 
            player.credits3.y = 790; 
            player.credits3.alignX = "center";
            player.credits3.horzAlign = "fullscreen";
            player.credits3.alignY = "bottom";
            player.credits3.font = "default";
            player.credits3.fontScale = 1.5;
            player.credits3.label = &"Thanks to Tommy for script";
            player.credits3 FadeOverTime( 5 );  
            player.credits3.alpha = 1;
            player.credits3 moveovertime(8);
            player.credits3.x = 325; 
            player.credits3.y = 265;

            player.credits4 = newclienthudelem(player);
            player.credits4.sort = 99996;
            player.credits4.x = 325; 
            player.credits4.y = 825; 
            player.credits4.alignX = "center";
            player.credits4.horzAlign = "fullscreen";
            player.credits4.alignY = "bottom";
            player.credits4.font = "default";
            player.credits4.fontScale = 1.5;
            player.credits4.label = &"Special thanks to ^3Tayzer ^7for test";
            player.credits4 FadeOverTime( 5 );  
            player.credits4.alpha = 1;
            player.credits4 moveovertime(8);
            player.credits4.x = 325; 
            player.credits4.y = 300;

            player.credits5 = newclienthudelem(player);
            player.credits5.sort = 99996;
            player.credits5.x = 325; 
            player.credits5.y = 950; 
            player.credits5.alignX = "center";
            player.credits5.horzAlign = "fullscreen";
            player.credits5.alignY = "bottom";
            player.credits5.font = "default";
            player.credits5.fontScale = 1.5;
            player.credits5.label = &"  ";
            player.credits5 FadeOverTime( 5 );  
            player.credits5.alpha = 1;
            player.credits5 moveovertime(8);
            player.credits5.x = 325; 
            player.credits5.y = 210;

            player.credits6 = newclienthudelem(player);
            player.credits6.sort = 99996;
            player.credits6.x = 325; 
            player.credits6.y = 930; 
            player.credits6.alignX = "center";
            player.credits6.horzAlign = "fullscreen";
            player.credits6.alignY = "bottom";
            player.credits6.font = "default";
            player.credits6.fontScale = 1.5;
            player.credits6.label = &"~~~~~~~~~~~°Oo_^6THE END^7_oO°~~~~~~~~~~~";
            player.credits6 FadeOverTime( 5 );  
            player.credits6.alpha = 1;
            player.credits6 moveovertime(8);
            player.credits6.x = 325; 
            player.credits6.y = 370;

            wait 10;

            player.credits destroy();
            player.credits1 destroy();
            player.credits2 destroy();
            player.credits3 destroy();
            player.credits4 destroy();
            player.credits5 destroy(); 

            wait 3;
            
            player.credits6 fadeOverTime(1);
            player.credits6.alpha = 0;
            wait 1;
            player.credits6 destroy();
            wait 1 ;

            player.blackscreen fadeOverTime(1);
            player.blackscreen.alpha = 0;
            wait 1;
            player.blackscreen destroy();

           
            player.finish= true;
            player iprintlnbold ("^1Congratulations, ^9" + player.name + ", you have completed the ^2Map!"); 
        }
    }
}

give_m16()
{
    trigger = getent ("give_m16_trig","targetname");
    while(1)
    {
        trigger waittill ("trigger",user);
        user iprintlnbold("You Have Taken [^1M16^7]");
        user giveWeapon( "m16_reflex_mp");
        user giveMaxammo("m16_reflex_mp");
        wait 0.1;
        user switchToWeapon("m16_reflex_mp");
        wait 0.1;
    }
}

give_ak47()
{
    trigger = getent ("give_ak47_trig","targetname");
    while(1)
    {
        trigger waittill ("trigger",user);
        user iprintlnbold("You Have Taken [^4Ak47^7]");
        user giveWeapon( "ak47_silencer_mp");
        user giveMaxammo("ak47_silencer_mp");
        wait 0.1;
        user switchToWeapon("ak47_silencer_mp");
        wait 0.1;
    }
}


give_deagle()
{
    trigger = getent ("give_deagle_trig","targetname");
    while(1)
        {
        trigger waittill ("trigger",user);
        user iprintlnbold("You Have Taken [^4Deagle^7]");
        user giveWeapon( "deserteaglegold_mp");
        user giveMaxammo("deserteaglegold_mp");
        wait 0.1;
        user switchToWeapon("deserteaglegold_mp");
        wait 0.1;
    }
}

give_m40a3()
{
    trigger = getent ("give_m40a3_trig","targetname");
    while(1)
    {
        trigger waittill ("trigger",user);
        user iprintlnbold("You Have Taken [^4M40a3^7]");
        user giveWeapon( "m40a3_mp");
        user giveMaxammo("m40a3_mp");
        wait 0.1;
        user switchToWeapon("m40a3_mp");
        wait 0.1;
    }
}

jumper()
{
	jumpx = getent ("jump","targetname");
	glow = getent ("glow","targetname");
	air1 = getent ("air1","targetname");
	air2 = getent ("air2","targetname");
	air3 = getent ("air3","targetname");
	air4 = getent ("air4","targetname");

	level._effect[ "beacon_glow" ] = loadfx( "misc/ui_pickup_available" );
	maps\mp\_fx::loopfx("beacon_glow", (glow.origin), 3, (glow.origin) + (0, 0, 90));

	time = 1;
	for(;;)
	{
		jumpx waittill ("trigger",user);
		if (user istouching(jumpx))
		{
			air = spawn ("script_model",(0,0,0));
			air.origin = user.origin;
			air.angles = user.angles;
			user linkto (air);
			air moveto (air1.origin, time);
			wait 1;
			air moveto (air2.origin, time);
			wait .5;
			air moveto (air3.origin, time);
			wait .5;
			air moveto (air4.origin, time);
			wait 1;
			user unlink();
			wait 1;
		}
	}
}

bounce()
{
    for(;;)
    {
        self waittill("trigger", p);

        if(!isDefined(p.bouncing))
            p thread player_bounce(self);
    }
}

player_bounce(trigger)
{
    self.bouncing = true;

    vel = self getVelocity();

    temp0 = (((vel[0] < 350 && vel[0] > 0) || (vel[0] > -350 && vel[0] < 0)));
    temp1 = (((vel[1] < 350 && vel[1] > 0) || (vel[1] > -350 && vel[1] < 0)));

    if((!temp0 && !temp1) || vel[2] > -350)
    {
        wait 1;

        self.bouncing = undefined;
        return;
    }

    health    = self.health;
    maxHealth = self.maxHealth;
    self.health    = 1000000;
    self.maxhealth = 1000000;

    setDvar("g_knockback", (vel[2]*-9)-500);
    self finishPlayerDamage(self, self, 1000, 0, "MOD_UNKNOWN", "bounce", self.origin, (0,0,1) , "none", 0);

    wait 0.05;
    setDvar("g_knockback", level.knockback);

    self.health    = health;
    self.maxhealth = maxHealth;

    while(self isTouching(trigger))
        wait 0.05;

    self.bouncing = undefined;
}

