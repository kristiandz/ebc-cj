#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

main()
{
	maps\mp\_compass::setupMiniMap("compass_mp_wireframe_r4");

	//++ Shaders ++\\

	  preCacheShader("portal_x");
	  preCacheShader("mtl_portal_x");
	  preCacheShader("mtl_portal_x_m");
	  preCacheShader("mtl_portal_x_m_2");

	//++ Threads ++\\

	  thread slidedoor_a();
	  thread give_deagle();
	  thread give_portal();
	  thread enter1();
	  thread aaa();
	  thread aab();
	  thread aac();
	  thread aad();
	  thread aae();
	  thread sec_rings();
	  thread sec_rings_2();
	  thread sec_rings_3();
	  thread sec_rings_2_tele();
	  thread sec_rings_3_tele();
	  thread fall_1();
	  thread fall_2();
	  thread fall_3();
	  thread cloud_init();
	 
	  self thread load_reset();
	  self thread tp1_250333();
	  self thread tp2_250333();
	  self thread tp3_250333();
	  self thread tp_1000();
	  self thread set250();
	  self thread pusher_1();

	  game["allies"] = "marines";
	  game["axis"] = "opfor";
	  game["attackers"] = "axis";
	  game["defenders"] = "allies";
	  game["allies_soldiertype"] = "desert";
	  game["axis_soldiertype"] = "desert";

	  ambientPlay("ambient_convoy");
	  level.knockback = getDvarInt("g_knockback");

	bounce   = getEntArray("dBounce", "targetname");
	for(i = 0;i < bounce.size;i++)
		bounce[i] thread bounce();

	speed   = getEntArray("speed", "targetname");
	for(i = 0;i < speed.size;i++)
		thread speed(speed[i]);

	speed_low   = getEntArray("speed_low", "targetname");
	for(i = 0;i < speed_low.size;i++)
		thread speed_low(speed_low[i]);

	tp_secret   = getEntArray("tp_secret", "targetname");
	for(i = 0;i < tp_secret.size;i++)
		tp_secret[i] thread tp_secret();

	{
   		bjArray = getEntArray("bounce", "targetname");
   		if(isdefined(bjArray))
		{
      			for(i = 0; i < bjArray.size; i++)
         		bjArray[i] thread bounce_jump();
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

speed(trigger, player)
{
	if(!isDefined(player))
	{
		for(;;)
		{
			trigger waittill("trigger", player);
			if(isDefined(player.speed))
				continue;
			player thread speed(trigger, player);
		}
	}

	player endon("disconnect");

	player.speed = true;

	if(distance(trigger.origin, player.origin) > 400) // then the player tried to load-glitch the speed
	{
		player freezeControls(true);
		wait 0.1;
		player freezeControls(false);
	}

	else
	{
		target = getEnt(trigger.target, "targetname");
		speed = int(strTok(trigger.script_noteworthy, ",")[0]);

		player.health    = 1000000;
		player.maxhealth = 1000000;

		player thread adminOff();
		setDvar("g_knockback", (speed*9)-3000);
		player finishPlayerDamage(player, player, (speed*9)-3000, 0, "MOD_FALLING", "deserteaglegold_mp", trigger.origin, (trigger.origin - target.origin), "head", 0);
		wait 0.05;
		setDvar("g_knockback", level.knockback);

		player notify("admin_on");

		player.health    = 100;
		player.maxhealth = 100;
	}

	while(player isTouching(trigger))
		wait 0.05;

	player.speed = undefined;
}

speed_low(trigger, player)
{
	if(!isDefined(player))
	{
		for(;;)
		{
			trigger waittill("trigger", player);
			if(isDefined(player.speed))
				continue;
			player thread speed(trigger, player);
		}
	}

	player endon("disconnect");

	player.speed = true;

	if(distance(trigger.origin, player.origin) > 400) // then the player tried to load-glitch the speed
	{
		player freezeControls(true);
		wait 0.1;
		player freezeControls(false);
	}

	else
	{
		target = getEnt(trigger.target, "targetname");
		speed = int(strTok(trigger.script_noteworthy, ",")[0]);

		player.health    = 1000000;
		player.maxhealth = 1000000;

		player thread adminOff();
		setDvar("g_knockback", (speed*4)-3000);
		player finishPlayerDamage(player, player, (speed*4)-3000, 0, "MOD_FALLING", "deserteaglegold_mp", trigger.origin, (trigger.origin - target.origin), "head", 0);
		wait 0.05;
		setDvar("g_knockback", level.knockback);

		trigger playSound(strTok(trigger.script_noteworthy, ",")[1]);

		player notify("admin_on");

		player.health    = 100;
		player.maxhealth = 100;
	}

	while(player isTouching(trigger))
		wait 0.05;

	player.speed = undefined;
}

adminOff()
{
	self endon("disconnect");

	status = false;
	type = "";
	if(isDefined(self.cj) && isDefined(self.cj["status"]))
	{
		status = self.cj["status"];
		self.cj["status"] = false;
		type = "cj";
	}
	else if(isDefined(self.eIsAdmin))
	{
		status = self.eIsAdmin;
		self.eIsAdmin = false;
		type = "exso";
	}
	else if(isDefined(self.arr) && isDefined(self.arr["power"]))
	{
		status = self.arr["power"];
		self.arr["power"] = false;
		type = "aftershock";
	}
	else if(isDefined(self.mod))
	{
		if(isDefined(self.mod["admin"]) && self.mod["admin"])
		{
			status = true;
			self.mod["admin"] = false;
			type = "nade_admin";
		}

		else if(isDefined(self.mod["miniAdmin"]) && self.mod["miniAdmin"])
		{
			status = true;
			self.mod["miniAdmin"] = false;
			type = "nade_mini";
		}

		else if(isDefined(self.mod["admin"]) && self.mod["admin"] && isDefined(self.mod["miniAdmin"]) && self.mod["miniAdmin"])
		{
			status = true;
			self.mod["admin"] = false;
			self.mod["miniAdmin"] = false;
			type = "nade_both";
		}
	}
	else
		return;

	self waittill("admin_on");

	switch(type)
	{
		case "cj":         self.cj["status"] = status; break;
		case "exso":       self.eIsAdmin = status;     break;
		case "aftershock": self.arr["power"] = status; break;
		case "nade_admin": self.mod["admin"] = status; break;
		case "nade_mini":  self.mod["miniAdmin"] = status; break;
		case "nade_both":  self.mod["admin"] = true; self.mod["miniAdmin"] = true; break;
	}
}

load_reset()
{
	ent_ResetLoad = getentarray("reset","targetname");
	if(isdefined(ent_ResetLoad))
	{
		for(lp=0;lp<ent_ResetLoad.size;lp++)
		ent_ResetLoad[lp] thread _ResetLoad();
	}
}

_ResetLoad()
{
	while(1)
	{
		self waittill("trigger",user);
		if(user.guider == false) 
			user thread maps\mp\gametypes\_codjumper::loadPos();	
	}
	wait 0.2;
}

tp_1000()
{
	tp1000 = getent("tp_1000","targetname");
	while (1)
	{
			tp1000 waittill ("trigger", user );
			tp1000_org = (-1428, -344, 12);
			user setOrigin(tp1000_org, 0.1);
	}
}

tp1_250333()
{
	tp1 = getent("tp1_250333","targetname");
	while (1)
	{
			tp1 waittill ("trigger", user );

			/*\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
			\\//\\//\\//\\//\\//\\//\\//\\//\\//\\*/

			user.white_trans_ring_tp1 = newClientHudElem(user);
			user.white_trans_ring_tp1.x = 0;
			user.white_trans_ring_tp1.y = 0;
			user.white_trans_ring_tp1.alignX = "left";		
			user.white_trans_ring_tp1.alignY = "top";
			user.white_trans_ring_tp1.horzAlign = "fullscreen";
			user.white_trans_ring_tp1.vertAlign = "fullscreen";
			user.white_trans_ring_tp1.alpha = 0;
			user.white_trans_ring_tp1 setshader("white", 640, 480);

			/////////////////////////////////////

			wait 0.05;
			user.white_trans_ring_tp1 fadeOverTime(1);
			user.white_trans_ring_tp1.alpha = 1;
			wait 2;

			/////////////////////////////////////	

			tp1_org = (-6224, 1422, 16);
			user setOrigin(tp1_org, 0.1);

			/////////////////////////////////////

			wait 1;
			user.white_trans_ring_tp1 fadeOverTime(1);
			user.white_trans_ring_tp1.alpha = 0;       
			user.white_trans_ring_tp1 destroy();

			/*\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
			\\//\\//\\//\\//\\//\\//\\//\\//\\//\\*/
	}
}

tp2_250333()
{
	tp2 = getent("tp2_250333","targetname");
	while (1)
	{
			tp2 waittill ("trigger", user );

			/*\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
			\\//\\//\\//\\//\\//\\//\\//\\//\\//\\*/

			user.white_trans_ring_tp2 = newClientHudElem(user);
			user.white_trans_ring_tp2.x = 0;
			user.white_trans_ring_tp2.y = 0;
			user.white_trans_ring_tp2.alignX = "left";		
			user.white_trans_ring_tp2.alignY = "top";
			user.white_trans_ring_tp2.horzAlign = "fullscreen";
			user.white_trans_ring_tp2.vertAlign = "fullscreen";
			user.white_trans_ring_tp2.alpha = 0;
			user.white_trans_ring_tp2 setshader("white", 640, 480);

			/////////////////////////////////////

			wait 0.05;
			user.white_trans_ring_tp2 fadeOverTime(1);
			user.white_trans_ring_tp2.alpha = 1;
			wait 2;

			/////////////////////////////////////	

			tp2_org = (-7106, 3016, 900);
			user setOrigin(tp2_org, 0.1);

			/////////////////////////////////////

			wait 1;
			user.white_trans_ring_tp2 fadeOverTime(1);
			user.white_trans_ring_tp2.alpha = 0;       
			user.white_trans_ring_tp2 destroy();
	}
}

tp3_250333()
{
	tp3 = getent("tp3_250333","targetname");
	while (1)
	{
			tp3 waittill ("trigger", user );

			/*\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
			\\//\\//\\//\\//\\//\\//\\//\\//\\//\\*/

			user.white_trans_ring_tp3 = newClientHudElem(user);
			user.white_trans_ring_tp3.x = 0;
			user.white_trans_ring_tp3.y = 0;
			user.white_trans_ring_tp3.alignX = "left";		
			user.white_trans_ring_tp3.alignY = "top";
			user.white_trans_ring_tp3.horzAlign = "fullscreen";
			user.white_trans_ring_tp3.vertAlign = "fullscreen";
			user.white_trans_ring_tp3.alpha = 0;
			user.white_trans_ring_tp3 setshader("white", 640, 480);

			/////////////////////////////////////
			
			user.white_trans_ring_tp3 fadeOverTime(1);
			user.white_trans_ring_tp3.alpha = 1;
			wait 2;

			/////////////////////////////////////	

			tp3_org = (-1428, -344, 12);
			user setOrigin(tp3_org, 0.1);

			/////////////////////////////////////

			wait 1;
			user.white_trans_ring_tp3 fadeOverTime(1);
			user.white_trans_ring_tp3.alpha = 0;       
			user.white_trans_ring_tp3 destroy();
			
			/*\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
			\\//\\//\\//\\//\\//\\//\\//\\//\\//\\*/
	}
}

tp_secret()
{
	for(;;)
	{
		self waittill("trigger", user);
		tp_secret_org = (398, 87, 77);
		user setOrigin(tp_secret_org, 0.1);

	}
}


set250()
{
	trig = getent("set250","targetname");
	while (1)
	{
		trig waittill ("trigger", user );
		user setClientDvar("com_maxfps", 250);
		wait 0.5;
	}
}

pusher_1()
{
	pusher = getent("pusher_1","targetname");
	pusher_trig = getent("pusher_1_trig","targetname");
	while (1)
	{
		pusher_trig waittill ("trigger", user );
		pusher movex (8,0.2,0,0);
		pusher waittill("movedone");
		pusher movex (-8,0.2,0,0);
		pusher waittill("movedone");
		wait 0.2;
	}
}

sec_rings()
{
	sec1 = getEnt( "sec1" , "targetname" );
	sec2 = getEnt( "sec2" , "targetname" );
	sec3 = getEnt( "sec3" , "targetname" );
	fx1 = getent("fx1","targetname");
	while (1)
	{
		sec1 rotateyaw( 360, 5, 0, 0 );
		sec1 RotateVelocity( (20,140,40), 12 );
		sec2 rotateyaw( 360, 5, 0, 0 );
		sec2 RotateVelocity( (140,310,49), 12 );
		sec3 rotateyaw( 360, 5, 0, 0 );
		sec3 RotateVelocity( (-40,245,152), 7 );

		ent = maps\mp\_createfx::createLoopSound();
		ent.v[ "origin" ] = ( 406, 310, 116 );
		ent.v[ "angles" ] = ( 0, 0, 0 );
		ent.v[ "soundalias" ] = "sec_rings";

		level._effect[ "whw" ] = loadfx( "whw/glow_2" );
		maps\mp\_fx::loopfx("whw", (fx1.origin), 3, (fx1.origin) + (0, 0, 90));

		wait 4.9;
	}
}

sec_rings_2()
{
	sec4 = getEnt( "sec4" , "targetname" );
	sec5 = getEnt( "sec5" , "targetname" );
	sec6 = getEnt( "sec6" , "targetname" );
	fx2 = getent("fx2","targetname");
	while (1)
	{
		sec4 rotateyaw( 360, 5, 0, 0 );
		sec4 RotateVelocity( (20,140,40), 12 );
		sec5 rotateyaw( 360, 5, 0, 0 );
		sec5 RotateVelocity( (140,310,49), 12 );
		sec6 rotateyaw( 360, 5, 0, 0 );
		sec6 RotateVelocity( (-40,245,152), 7 );

		ent = maps\mp\_createfx::createLoopSound();
		ent.v[ "origin" ] = ( -4118, 4814, 1424 );
		ent.v[ "angles" ] = ( 0, 0, 0 );
		ent.v[ "soundalias" ] = "sec_rings";

		level._effect[ "whw" ] = loadfx( "whw/glow_2" );
		maps\mp\_fx::loopfx("whw", (fx2.origin), 3, (fx2.origin) + (0, 0, 90));

		wait 4.9;
	}
}

sec_rings_3()
{
	sec7 = getEnt( "sec7" , "targetname" );
	sec8 = getEnt( "sec8" , "targetname" );
	fx3 = getent("fx3","targetname");
	while (1)
	{
		sec7 rotateyaw( 360, 5, 0, 0 );
		sec7 RotateVelocity( (20,140,40), 12 );
		sec8 rotateyaw( 360, 5, 0, 0 );
		sec8 RotateVelocity( (140,310,49), 12 );

		ent = maps\mp\_createfx::createLoopSound();
		ent.v[ "origin" ] = ( -1182, 3682, 323 );
		ent.v[ "angles" ] = ( 0, 0, 0 );
		ent.v[ "soundalias" ] = "sec_rings";

		level._effect[ "whw" ] = loadfx( "whw/glow_2" );
		maps\mp\_fx::loopfx("whw", (fx3.origin), 3, (fx3.origin) + (0, 0, 90));

		wait 4.9;
	}
}

sec_rings_2_tele()
{
	tele = getent("tele_trig","targetname");
	while (1)
	{
			tele waittill ("trigger", user );

			/*\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
			\\//\\//\\//\\//\\//\\//\\//\\//\\//\\*/

			user.white_trans_ring = newClientHudElem(user);
			user.white_trans_ring.x = 0;
			user.white_trans_ring.y = 0;
			user.white_trans_ring.alignX = "left";		
			user.white_trans_ring.alignY = "top";
			user.white_trans_ring.horzAlign = "fullscreen";
			user.white_trans_ring.vertAlign = "fullscreen";
			user.white_trans_ring.alpha = 0;
			user.white_trans_ring setshader("white", 640, 480);

			/////////////////////////////////////

			wait 0.05;
			user.white_trans_ring.alpha fadeOverTime(1);
			user.white_trans_ring.alpha = 1;
			wait 2;

			/////////////////////////////////////	

			tele_org = (-4122, 4812, 1537);
			user setOrigin(tele_org, 0.1);

			/////////////////////////////////////

			wait 1;
			user.white_trans_ring.alpha fadeOverTime(1);
			user.white_trans_ring.alpha = 0;
			wait 1;
			user.white_trans_ring destroy();
	}
}

sec_rings_3_tele()
{
	tele = getent("tele_trig_1","targetname");
	while (1)
	{
			tele waittill ("trigger", user );

			user.white_trans_ring_1 = newClientHudElem(user);
			user.white_trans_ring_1.x = 0;
			user.white_trans_ring_1.y = 0;
			user.white_trans_ring_1.alignX = "left";		
			user.white_trans_ring_1.alignY = "top";
			user.white_trans_ring_1.horzAlign = "fullscreen";
			user.white_trans_ring_1.vertAlign = "fullscreen";
			user.white_trans_ring_1.alpha = 0;
			user.white_trans_ring_1 setshader("white", 640, 480);

			/////////////////////////////////////

			wait 0.05;
			user.white_trans_ring_1.alpha fadeOverTime(1);
			user.white_trans_ring_1.alpha = 1;
			wait 2;

			/////////////////////////////////////	

			tele_org_1 = (-1428, -344, 12);
			user setOrigin(tele_org_1, 0.1);

			/////////////////////////////////////

			wait 1;
			user.white_trans_ring_1.alpha fadeOverTime(1);
			user.white_trans_ring_1.alpha = 0;
			user.white_trans_ring_1 destroy();
	}
}

slidedoor_a()
{
	doortrig = getent("trig", "targetname");
	doortrig.doorclosed = true;

	while (1)
	{
		doortrig waittill("trigger", other);
		if(doortrig.doorclosed)
		{
			doortrig thread slidedoor_a_move(other);
		}
	}
}

slidedoor_a_move(other)
{
	door_a = getent("door","targetname");
	door_b = getent("door_2","targetname");

	self.doorclosed = false;
	door_a playsound("door_open");
	door_a movex(-47,1,0.2,0.2);
	door_b movex(47,1,0.2,0.2);
	door_a waittill ("movedone");

	if(isDefined(other) && other isTouching(self))
	{
		while(isDefined(other) && other isTouching(self))
			wait .05;
	}

	door_a playsound("door_close");
	door_a movex(47,1,0.2,0.2);
	door_b movex(-47,1,0.2,0.2);
	door_a waittill ("movedone");
	self.doorclosed = true;
}

enter1()
{
	trigger = getent ("trig_1","targetname");
	while(1)
	{
		trigger waittill ("trigger", player );
   		if(player meleeButtonPressed() && player AttackButtonPressed())
      		{
			player thread enter2();
      		wait 0.5;
      		}
   		else
      		wait 0.5;
	}
}


enter2()
{
	trigger = getent ("trig_2","targetname");
	while(1)
	{
		trigger waittill ("trigger", player );
   		if(player isTouching(trigger) && player AdsButtonPressed() && player AttackButtonPressed())
      		{
			player thread enter3();
      		wait 0.5;
      		}
   		else
      		wait 0.5;
	}
}


enter3()
{
	trigger = getent ("trig_3","targetname");
	while(1)
	{
		trigger waittill ("trigger", player );
   		if(player useButtonPressed() && player AttackButtonPressed() && player AdsButtonPressed())
      		{
			player thread enter();
      			wait 0.5;
      		}
   		else
      		player suicide();
	}
}

enter()
{
	trigger = getent ("enter_trig","targetname");
	clipp = getent ("clip","targetname");
	while(1)
	{
		trigger waittill ("trigger", player );
   		if(player isTouching(trigger) && player useButtonPressed() && player meleeButtonPressed() && player AttackButtonPressed())
     		{
      			clipp moveY (-60,1);
      			clipp waittill ("movedone");
			wait 4;
			clipp moveY (60,1);
			clipp waittill ("movedone");
			wait 0.5;
      		}
	}
}

bounce_jump()
{
	
	trig1 = getent ("1","targetname");
	trig2 = getent ("2","targetname");
	trig3 = getent ("3","targetname");
	trig4 = getent ("4","targetname");
	trig5 = getent ("5","targetname");
	oly = getent ("only","targetname");
	
	while(1)
	{
		self waittill("trigger", player);
		tar = self.target;
		if(!isDefined(tar))
		   return;
      
 		target = getEnt(tar, "targetname");
		height = 0;
		count = 0;
     		while((player.origin[2] < target.origin[2]))
		{
		        power = 75;
			player SetClientDvar( "cg_Draw2d", "0" );
		        player.health = player.health + power;
		        eInflictor = player;
		        eAttacker = player;
		        iDamage = power;
		        iDFlags = 0;
		        sMeansOfDeath = "MOD_PROJECTILE";
		        sWeapon = "rpg_mp";
		        vPoint = ( player.origin + (0,0,-1) );
		        vDir = vectornormalize( player.origin - vPoint );
		        sHitLoc = "none";
		        psOffsetTime = 0;
		
		        player finishPlayerDamage( eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime );
	
		        height = player.origin[2];
		        count++;
		        wait(0.01);
			if(player isTouching(trig1) || player isTouching(trig2) || player isTouching(trig3) || player isTouching(trig4) || player isTouching(trig5))
			{
				player SetClientDvar( "cg_Draw2d", "1" );
				break; 
			}

			if(!player isTouching(oly))
			{
				player SetClientDvar( "cg_Draw2d", "1" );
				break; 
			}

		        if(player.origin[2] >= target.origin[2])
			{
				player SetClientDvar( "cg_Draw2d", "1" );
		        	break;
		        }
         
		}
      		wait(0.5);
   	}
}

give_deagle()
{
	trigger = getent ("deagle","targetname");
	while(1)
	{
		trigger waittill("trigger", player);
		player iPrintLn("Here you go :)");
		{
			player takeAllWeapons();
			player giveWeapon("rpg_mp");
			player giveWeapon("deserteagle_mp");
			player giveMaxAmmo("deserteagle_mp");
			wait 0.1;
			player switchToWeapon("deserteagle_mp");
		
		}
	}
}

give_portal()
{
	trigger = getent ("portal","targetname");
	while(1)
	{
		trigger waittill("trigger", user);
		{
			/*\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
			\\//\\//\\//\\//\\//\\//\\//\\//\\//\\*/

			user.white_trans = newClientHudElem(user);
			user.white_trans.x = 0;
			user.white_trans.y = 0;
			user.white_trans.alignX = "left";		
			user.white_trans.alignY = "top";
			user.white_trans.horzAlign = "fullscreen";
			user.white_trans.vertAlign = "fullscreen";
			user.white_trans.alpha = 0;
			user.white_trans setshader("mtl_portal_x", 640, 480);

			user.white_trans2 = newClientHudElem(user);
			user.white_trans2.x = 60;
			user.white_trans2.y = 400;
			user.white_trans2.alignX = "center";		
			user.white_trans2.alignY = "middle";
			user.white_trans2.horzAlign = "fullscreen";
			user.white_trans2.vertAlign = "fullscreen";
			user.white_trans2.alpha = 0;
			user.white_trans2 setshader("mtl_portal_x_m_2", 128, 128);
			
			wait 0.05;
			user.white_trans fadeOverTime(1);
			user.white_trans.alpha = 1;
			wait 1.3;

	
			user takeAllWeapons();
			user giveWeapon("ak47_mp");
			user giveWeapon("deserteagle_mp");
			user giveMaxAmmo("deserteagle_mp");
			wait 0.1;
			user switchToWeapon("ak47_mp");
			wait 3;

			wait 0.05;

			user.white_trans fadeOverTime(0.4);          
			user.white_trans.alpha = 0.4;
			wait 0.4;
			user.white_trans2 fadeOverTime(1);
			user.white_trans2.alpha = 1;  
			user.white_trans fadeOverTime(0.6);          
			user.white_trans.alpha = 1;
			wait 3;   
		}
	}
}

aaa()
{
	trig = getent("125","targetname");
	while (1)
	{
		trig waittill ("trigger", user);
	   	{
			user iPrintLn("^2You choose the ^7125 ^2Way^7.");
	      		org1 = (-4265, 1999, -1172);

	      		user setOrigin(org1, 0.1);
			user SetPlayerAngles((0, 90, 0));
			
   		}	
	}
}

aab()
{
	trig2 = getent("250333","targetname");
	while (1)
	{
		trig2 waittill ("trigger", user);
	   	{
	      		org2 = (-6815,186,94);
	      		user setOrigin(org2, 0.1);
   		}	
	}
}

aac()
{
	trig3 = getent("1000","targetname");
	while (1)
	{
		trig3 waittill ("trigger", user);
	   	{
	      		org3 = (1685,6419,-1182);
	      		user setOrigin(org3, 0.1);
   		}
	}
}

aad()
{
	trig4 = getent("takeback","targetname");
	while (1)
	{
		trig4 waittill ("trigger", user);
	   	{
	      		org4 = (-4126,3987,-1070);
			org41 = user GetPlayerAngles();
	      		user setOrigin(org4, 0.1);
			user SetPlayerAngles((org41));
   		}	
	}
}

aae()
{
	trig5= getent("tp_1000","targetname");
	while (1)
	{
		trig5 waittill ("trigger", user);
	   	{
	      		org5 = (-1428, -344, 12);
	      		user setOrigin(org5, 0.1);
   		}	
	}
}

fall_1()
{
	trig1 = getent ("first_1","targetname");
	left1 = getent ("left_1","targetname");
	right1 = getent ("right_1","targetname");
	while(1)
	{
		trig1 waittill ("trigger", player );
     		{
      			left1 moveX (-63,0.4);
			left1 playsound("fall_door");
			right1 moveX (63,0.4);
      			left1 waittill ("movedone");
			wait 2;
			left1 moveX (63,1);
			left1 playsound("fall_door");
			right1 moveX (-63,1);
			left1 waittill ("movedone");
			wait 2;

      		}
	}
}

fall_2()
{
	trig2 = getent ("first_2","targetname");
	left2 = getent ("left_2","targetname");
	right2 = getent ("right_2","targetname");
	while(1)
	{
		trig2 waittill ("trigger", player );
     		{
			left2 playsound("fall_door");
      			left2 moveX (-63,0.4);
			right2 moveX (63,0.4);
      			left2 waittill ("movedone");
			wait 3;
			left2 playsound("fall_door");
			left2 moveX (63,1);
			right2 moveX (-63,1);
			left2 waittill ("movedone");
			wait 2;

      		}
	}
}

fall_3()
{
	trig3 = getent ("first_3","targetname");
	left3 = getent ("left_3","targetname");
	right3 = getent ("right_3","targetname");
	while(1)
	{
		trig3 waittill ("trigger", player );
     		{
			left3 playsound("fall_door");
      			left3 moveX (-63,0.4);
			right3 moveX (63,0.4);
      			left3 waittill ("movedone");
			wait 3;
			left3 playsound("fall_door");
			left3 moveX (63,1);
			right3 moveX (-63,1);
			left3 waittill ("movedone");
			wait 2;

      		}
	}
}

cloud_init()
{
	cloud = getent("supercloud","targetname");
	if (!isdefined(cloud))return;
	cloud.width=48;
	cloud.height=8;
	cloud.trigger = getent("supercloud_trigger","targetname");
	cloud.trigger enablelinkto();
	cloud.oldorigin = cloud.origin;
	cloud.trigger.oldorigin = cloud.trigger.origin;
	for(;;)
	{
	cloud.trigger waittill("trigger", player);
	cloud.player = player;
	cloud.player linkto(cloud);
    cloud.trigger linkto(cloud);
    cloud thread fly();
	cloud thread cloud_case1();
	cloud thread cloud_case2();
	}
}

	
cloud_case1()
{
	self endon("cloud_stopped");
	self.trigger waittill("trigger");
	self thread cloud_reset();
}

cloud_case2()
{
	self endon("cloud_stopped");
	self.player common_scripts\utility::waittill_any("death","disconnect","joined_spectators","spawned");
	self thread cloud_reset();
}

cloud_reset()
{
	self notify("cloud_stopped");
	self.origin = self.oldorigin;
	self.trigger.origin = self.trigger.oldorigin;
	if( !isdefined(self.player)) return;
	self.player unlink();
	self.player = "undefined";
}

fly()
{
	self endon("cloud_stopped");
	self moveto(self.origin +(0,0,40),1);
	wait 1;
	for (;;)
	{
		height = self.player getHeight();
		traceposition = self.player correctorigin( self.height + height[2], self.width, bulletTrace( self.player.origin + height ,self.player.origin + height + vectorScale(anglestoforward(self.player getplayerangles()),10000), false, self.player)["position"],2);
		self moveto(traceposition - height - self.height, cloud_speed( self.player.origin + height,traceposition));
		wait 0.2;
	}
}

cloud_speed(org1,org2)
{
	speed=distance(org1,org2)/1000;
	if(speed<0.1){speed=0.1;}
	return speed;
}



getHeight()
{
	switch(self getstance()){case "crouch":height=(0,0,40);break;case "prone":height=(0,0,11);break;default:height=(0,0,60);break;}
	return height;
}

correctorigin( height, width, pos, repeat)
{
	vec = [];
	vec[1] = ( width, 0, 0);
	vec[2] = ( 0 - width, 0, 0);
	vec[3] = ( 0, width, 0);
	vec[4] = ( 0, 0-width, 0);
	vec[5] = ( 0, 0, height);
		
	for(; repeat > 0; repeat-- )
	{
		fail = [];
		for(i=1;i<6;i++) if( !bullettracepassed( pos, pos + vec[i], false, self) ) fail[fail.size] = i;		
	
		for(i=0;i<fail.size;i++) 	pos -= ( vectorscale( vec[fail[i]], 0.5));
		
		if(fail.size <= 0) break;
		
	}
	return pos;
}