main()
{
	maps\mp\_load::main();
	game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";
	setdvar( "r_specularcolorscale", "9" );
	setdvar("r_glowbloomintensity0",".25");
	setdvar("r_glowbloomintensity1",".25");
	setdvar("r_glowskybleedintensity0",".3");
	setdvar("compassmaxrange","1800");
	thread endofmap();
	thread endofmap1();
	thread run_msg_2();
	thread run_msg_3();
	thread run_msg_4();
	thread run_msg_5();
	thread run_msg_6();
	thread reset();
	thread speed();
	thread speed2();
	thread speed3();
	thread endofmap2();
}
endofmap()
{
	trigger = getent("end","targetname");
	while (1)
	{
		trigger waittill ("trigger", user );
		if ( isPlayer( user ) && isAlive( user ) && isdefined( user.done ) )
		{
			wait 0.5;
		}
		else
		{
			iprintlnbold ("Congratulations, " + user.name + ", you have completed mp_to_the_moon ^5Advanced!!");
			user iprintlnbold ("Map created by ^1=.VaRtaZiaN.=");
			user.done = true;
		}
	}
}
run_msg_2()
{
	var_msg_2 = getent("message2","targetname");
	if ( isdefined(var_msg_2) )
	{
		while(true)
		{
			var_msg_2 waittill ("trigger", user);
			if(!level.msg_block)
			{
				level.msg_block = true;
				iprintlnbold ("^4 Map by: ^1=.VaRtaZiaN.=");
				iprintlnbold ("^3xfire : ^1Vartazian147");
				wait 2;
				level.msg_block = false;
			}
		}
	}
}
run_msg_3()
{
	var_msg_3 = getent("message3","targetname");
	if ( isdefined(var_msg_3) )
	{
		while(true)
		{
			var_msg_3 waittill ("trigger", user);
			if(!level.msg_block)
			{
				level.msg_block = true;
				iprintlnbold ("" + user.name + " ^7is ^3better than you");
				wait 2;
				level.msg_block = false;
			}
		}
	}
}
run_msg_4()
{
	var_msg_4 = getent("message4","targetname");
	if ( isdefined(var_msg_4) )
	{
		while(true)
		{
			var_msg_4 waittill ("trigger", user);
			if(!level.msg_block)
			{
				level.msg_block = true;
				iprintlnbold ("^1Another secret bounce? ^3U Jelly Brah!!");
				wait 2;
				level.msg_block = false;
			}
		}
	}
}
run_msg_5()
{
	var_msg_5 = getent("message5","targetname");
	if ( isdefined(var_msg_5) )
	{
		while(true)
		{
			var_msg_5 waittill ("trigger", user);
			if(!level.msg_block)
			{
				level.msg_block = true;
				iprintlnbold ("^1C^7o^1D^7J^1u^7m^1p^7e^1r.^1C^7o^1m For all your jumping needs!");
				wait 2;
				level.msg_block = false;
			}
		}
	}
}
run_msg_6()
{
	var_msg_6 = getent("message6","targetname");
	if ( isdefined(var_msg_6) )
	{
		while(true)
		{
			var_msg_6 waittill ("trigger", user);
			if(!level.msg_block)
			{
				level.msg_block = true;
				iprintlnbold ("^2Isn't this annoying? ^3Rofl Rofl Rofl ^6xD ^1@@@@@@@@^2@@@@@@@@@@@@@^3@@@@@@@@@@@@@@^4@@@@@@@@@@@@@^5@@@@@@@@@@@@^8@@@@@@@@@@@@");
				wait 2;
				level.msg_block = false;
			}
		}
	}
}
endofmap1()
{
	trigger = getent("end1","targetname");
	while (1)
	{
		trigger waittill ("trigger", user );
		if ( isPlayer( user ) && isAlive( user ) && isdefined( user.done ) )
		{
			wait 0.5;
		}
		else
		{
			user iprintlnbold ("Congratulations, " + user.name + ", you have completed Basic way of mp_to_the_moon!! Now go try Intermediate ;)");
			user iprintlnbold ("Map created by ^1=.VaRtaZiaN.=");
			user.done = true;
		}
	}
}
reset()
{
	ent_ResetLoad = getentarray("reset","targetname");
	if(isdefined(ent_ResetLoad))
	{
		for(lp=0;
		lp<ent_ResetLoad.size;
		lp++) ent_ResetLoad[lp] thread _ResetLoad();
	}
}
_ResetLoad()
{
	self endon("disconnect");
	self endon("killed_player");
	self endon("joined_spectators");
	while(true)
	{
		self waittill("trigger",other);
		wait(0.10);
		other thread maps\mp\gametypes\_codjumper::loadPos();
		wait(0.10);
	}
}
speed()
{
	trigger = getent("svt_accelerate_1","targetname");
	while(1)
	{
		trigger waittill ("trigger",player);
		player endon("disconnect");
		while(player isOnGround())
		{
			player SetMoveSpeedScale(12);
			wait(.05);
		}
		player SetMoveSpeedScale(1);
		wait(2);
	}
}
speed2()
{
	trigger = getent("svt_accelerate_2","targetname");
	while(1)
	{
		trigger waittill ("trigger",player);
		player endon("disconnect");
		while(&& player isOnGround())
		{
			player SetMoveSpeedScale(12);
			wait(.05);
		}
		player SetMoveSpeedScale(1);
		wait(2);
	}
}
speed3()
{
	trigger = getent("svt_accelerate_3","targetname");
	while(1)
	{
		trigger waittill ("trigger",player);
		player endon("disconnect");
		while(player isOnGround())
		{
			player SetMoveSpeedScale(12);
			wait(.05);
		}
		player SetMoveSpeedScale(1);
		wait(2);
	}
}
endofmap2()
{
	trigger = getent("end2","targetname");
	while (1)
	{
		trigger waittill ("trigger", user );
		if ( isPlayer( user ) && isAlive( user ) && isdefined( user.done ) )
			wait 0.5;

		else
		{
			user iprintlnbold ("Congratulations, " + user.name + ", you have completed Intermediate way of mp_to_the_moon!! Now go try Hard way ;)");
			user iprintlnbold ("Map created by ^1=.VaRtaZiaN.=");
			user.done = true;
		}
	}
}