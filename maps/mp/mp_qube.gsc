#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

main()
{
	maps\mp\_load::main();
	game["allies"] = "sas";
	game["axis"] = "russian";
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["allies_soldiertype"] = "woodland";
	game["axis_soldiertype"] = "woodland";
	speed = getEntArray("speed", "targetname");
	for(i = 0;i < speed.size;i++) thread speed(speed[i]);
	thread teleporter();
	thread ball();
	thread ring();
	thread ring1();
	thread stair();
	thread yellow();
	thread hard1();
	thread hard2();
	thread hard3();
	thread hard4();
	thread hard5();
	thread hard6();
	thread easy1();
	thread easy2();
	thread easy3();
	thread easy4();
	thread easy5();
	thread easy6();
	thread inter1();
	thread inter2();
	thread inter3();
	thread inter4();
	thread inter5();
	thread inter6();
	thread secret();
	thread easysecret();
	thread eztp();
	thread set1();
	thread set2();
	thread set3();
	thread set4();
	thread msgeasy();
	thread msginter();
	thread msghard();
	thread ezfin();
	thread intfin();
	thread ezfin1();
	thread intfin1();
	thread qubebumba();
}
teleporter()
{
	entTransporter = getentarray("enter","targetname");
	if(isDefined(entTransporter))
	{
		for(lp=0;lp<entTransporter.size;lp++)
		entTransporter[lp] thread Transporter();
	}
}


Transporter()
{
	while(true)
	{
		self waittill("trigger",other);
		entTarget = getent(self.target, "targetname");
		wait(0.10);
		other setOrigin(entTarget.origin);
		other setPlayerAngles(entTarget.angles);
		wait(0.10);
	}
}
speed( trigger )
{
	if( !isDefined( trigger ) ) return;
	while(1)
	{
		trigger waittill( "trigger", player );
		if( isDefined( player.speed ) ) continue;
		player thread PushPlayer( trigger );
	}
}
PushPlayer( trigger )
{
	self endon("disconnect");
	self.speed = true;
	if(distance(trigger.origin, self.origin) > 400)
	{
		self freezeControls(true);
		wait 0.1;
		self freezeControls(false);
	}
	else
	{
		target = getEnt(trigger.target, "targetname");
		speed = int(strTok(trigger.script_noteworthy, ",")[0]);
		self.health = 1000000;
		self.maxhealth = 1000000;
		setDvar("g_knockback", (speed*9)-3000);
		self finishPlayerDamage(self, self, (speed*9)-3000, 0, "MOD_FALLING", "deserteaglegold_mp", trigger.origin, (trigger.origin - target.origin), "head", 0);
		wait 0.05;
		setDvar("g_knockback", level.knockback);
		trigger playSound(strTok(trigger.script_noteworthy, ",")[1]);
		self.health = 100;
		self.maxhealth = 100;
	}
	while(self isTouching(trigger)) wait 0.05;
	self.speed = undefined;
}
ball()
{
	ball = getent("ball","targetname");
	while(1)
	{
		ball moveX(-632,1);
		wait 1;
		ball moveY(320,1);
		wait 1;
		ball moveX(-384,1);
		wait 1;
		ball moveY(-624,1);
		wait 1;
		ball moveX(-416,1);
		wait 1;
		ball moveY(-464,1);
		wait 1;
		ball moveX(-400,1);
		wait 1;
		ball moveY(672,1);
		wait 1;
		ball moveX(448,1);
		wait 1;
		ball moveY(416,1);
		wait 1;
		ball moveX(-736,1);
		wait 1;
		ball moveY(-592,1);
		wait 1;
		ball moveX(-416,1);
		wait 1;
		ball moveY(592,1);
		wait 1;
		ball movex(-240,1);
		wait 1;
		ball moveY(-784,1);
		wait 1;
		ball movex(640,1);
		wait 1;
		ball moveY(-576,1);
		wait 1;
		ball movex(-464,1);
		wait 1;
		ball movey(-480,1);
		wait 1;
		ball movey(480,1);
		wait 1;
		ball movex(464,1);
		wait 1;
		ball moveY(576,1);
		wait 1;
		ball movex(-640,1);
		wait 1;
		ball moveY(784,1);
		wait 1;
		ball movex(240,1);
		wait 1;
		ball moveY(-592,1);
		wait 1;
		ball moveX(416,1);
		wait 1;
		ball moveY(592,1);
		wait 1;
		ball moveX(736,1);
		wait 1;
		ball moveY(-416,1);
		wait 1;
		ball moveX(-448,1);
		wait 1;
		ball moveY(-672,1);
		wait 1;
		ball moveX(400,1);
		wait 1;
		ball moveY(464,1);
		wait 1;
		ball moveX(416,1);
		wait 1;
		ball moveY(624,1);
		wait 1;
		ball moveX(384,1);
		wait 1;
		ball moveY(-320,1);
		wait 1;
		ball moveX(632,1);
		wait 1;
	}
}
ring()
{
	ring = getent("ring","targetname");
	while(1)
	{
		ring moveX(502,3,1,1);
		ring waittill("movedone");
		wait 1;
		ring moveX(-502,3,1,1);
		ring waittill("movedone");
		wait 1;
	}
}
ring1()
{
	ring = getent("ring1","targetname");
	while(1)
	{
		ring moveX(-502,3,1,1);
		ring waittill("movedone");
		wait 1;
		ring moveX(502,3,1,1);
		ring waittill("movedone");
		wait 1;
	}
}
stair()
{
	trig = getent("stairtrig","targetname");
	stair = getent("stair","targetname");
	stair1 = getent("stair1","targetname");
	stair2 = getent("stair2","targetname");
	stair3 = getent("stair3","targetname");
	stair4 = getent("stair4","targetname");
	stair5 = getent("stair5","targetname");
	stair6 = getent("stair6","targetname");
	stair7 = getent("stair7","targetname");
	stair8 = getent("stair8","targetname");
	stair9 = getent("stair9","targetname");
	stair10 = getent("stair10","targetname");
	stair11 = getent("stair11","targetname");
	stair12 = getent("stair12","targetname");
	
	while(1)
	{
		trig waittill("trigger",user);
		stair moveZ(8,2);
		stair1 moveZ(16,2);
		stair2 moveZ(24,2);
		stair3 moveZ(32,2);
		stair4 moveZ(40,2);
		stair5 moveZ(48,2);
		stair6 moveZ(56,2);
		stair7 moveZ(64,2);
		stair8 moveZ(72,2);
		stair9 moveZ(80,2);
		stair10 moveZ(88,2);
		stair11 moveZ(96,2);
		stair12 moveZ(104,2);
		wait 5;
		stair12 moveZ(-104,2);
		stair11 moveZ(-96,2);
		stair10 moveZ(-88,2);
		stair9 moveZ(-80,2);
		stair8 moveZ(-72,2);
		stair7 moveZ(-64,2);
		stair6 moveZ(-56,2);
		stair5 moveZ(-48,2);
		stair4 moveZ(-40,2);
		stair3 moveZ(-32,2);
		stair2 moveZ(-24,2);
		stair1 moveZ(-16,2);
		stair moveZ(-8,2);
		wait 3;
	}
}
yellow()
{
	trig = getent("yellowtrig","targetname");
	yellow = getent("yellow","targetname");
	yellow1 = getent("yellow1","targetname");
	yellow2 = getent("yellow2","targetname");
	while(1)
	{
		trig waittill("trigger",user);
		yellow2 moveZ(192,1);
		wait 0.5;
		yellow1 moveZ(128,1);
		wait 0.5;
		yellow moveZ(64,1);
		wait 10;
		yellow2 moveZ(-192,1);
		wait 0.5;
		yellow1 moveZ(-128,1);
		wait 0.5;
		yellow moveZ(-64,1);
	}
}
door()
{
	door = getent("doortrig3","targetname");
	left = getent("left","targetname");
	leftmid = getent("leftmid","targetname");
	right = getent("right","targetname");
	rightmid = getent("rightmid","targetname");
	while(1)
	{
		door waittill("trigger",user);
		left moveX(-128,2);
		leftmid moveX(-64,2);
		right moveX(64,2);
		rightmid moveX(128,2);
		wait 3;
		left moveX(128,2);
		leftmid moveX(64,2);
		right moveX(-64,2);
		rightmid moveX(-128,2);
		wait 2;
	}
}
msgHard()
{
	trigger = getent ("msghard", "targetname");
	while (1)
	{
		trigger waittill ("trigger", player );
		if(!isDefined(player.finishedHard))
		{
			iprintlnbold (player.name +" ^1Has finished hard!");
			player.finishedhard = 1;
		}
	}
}
msgeasy()
{
	trigger = getent ("msgeasy", "targetname");
	while (1)
	{
		trigger waittill ("trigger", player );
		if(!isDefined(player.finishedeasy))
		{
			iprintlnbold (player.name +" ^3Has finished easy!");
			player.finishedeasy = 1;
		}
	}
}
msginter()
{
	trigger = getent ("msginter", "targetname");
	while (1)
	{
		trigger waittill ("trigger", player );
		if(!isDefined(player.finishedinter))
		{
			iprintlnbold (player.name +" ^4Has finished inter!");
			player.finishedinter = 1;
		}
	}
}
hard1()
{
	trig = getent("hard1","targetname");
	while(1)
	{
		trig waittill("trigger",user);
		user iprintlnbold("^1Map made by Calum!");
		wait 5;
	}
}
hard2()
{
	trig = getent("hard2","targetname");
	while(1)
	{
		trig waittill("trigger",user);
		user iprintlnbold("^1Thanks to Xenon, pcbouncer and Bone for script and mapping help!");
		wait 5;
	}
}
hard3()
{
	trig = getent("hard3","targetname");
	while(1)
	{
		trig waittill("trigger",user);
		user iprintlnbold("^1Thanks to all the people who tested the map!");
		wait 5;
	}
}
hard4()
{
	trig = getent("hard4","targetname");
	while(1)
	{
		trig waittill("trigger",user);
		user iprintlnbold("^1Bumba made no effort!");
		wait 5;
	}
}
hard5()
{
	trig = getent("hard5","targetname");
	while(1)
	{
		trig waittill("trigger",user);
		user iprintlnbold("^1Calum is ^4Scottish!");
		wait 5;
	}
}
hard6()
{
	trig = getent("hard6","targetname");
	while(1)
	{
		trig waittill("trigger",user);
		user iprintlnbold("^1Jack is a farmer!");
		wait 5;
	}
}
easy1()
{
	trig = getent("easy1","targetname");
	while(1)
	{
		trig waittill("trigger",user);
		user iprintlnbold("^3Map made by Calum!");
		wait 5;
	}
}
easy2()
{
	trig = getent("easy2","targetname");
	while(1)
	{
		trig waittill("trigger",user);
		user iprintlnbold("^3Thanks to Xenon, pcbouncer and Bone for script and mapping help!");
		wait 5;
	}
}
easy3()
{
	trig = getent("easy3","targetname");
	while(1)
	{
		trig waittill("trigger",user);
		user iprintlnbold("^3Thanks to all the people who tested the map!");
		wait 5;
	}
}
easy4()
{
	trig = getent("easy4","targetname");
	while(1)
	{
		trig waittill("trigger",user);
		user iprintlnbold("^3Bumba made no effort!");
		wait 5;
	}
}
easy5()
{
	trig = getent("easy5","targetname");
	while(1)
	{
		trig waittill("trigger",user);
		user iprintlnbold("^3Calum is ^4Scottish!");
		wait 5;
	}
}
easy6()
{
	trig = getent("easy6","targetname");
	while(1)
	{
		trig waittill("trigger",user);
		user iprintlnbold("^3Jack is a farmer!");
		wait 5;
	}
}
inter1()
{
	trig = getent("inter1","targetname");
	while(1)
	{
		trig waittill("trigger",user);
		user iprintlnbold("^4Map made by Calum!");
		wait 5;
	}
}
inter2()
{
	trig = getent("inter2","targetname");
	while(1)
	{
		trig waittill("trigger",user);
		user iprintlnbold("^4Thanks to Xenon, pcbouncer and Bone for script and mapping help!");
		wait 5;
	}
}
inter3()
{
	trig = getent("inter3","targetname");
	while(1)
	{
		trig waittill("trigger",user);
		user iprintlnbold("^4Thanks to all the people who tested the map!");
		wait 5;
	}
}
inter4()
{
	trig = getent("inter4","targetname");
	while(1)
	{
		trig waittill("trigger",user);
		user iprintlnbold("^4Bumba made no effort!");
		wait 5;
	}
}
inter5()
{
	trig = getent("inter5","targetname");
	while(1)
	{
		trig waittill("trigger",user);
		user iprintlnbold("^4Calum is ^4Scottish!");
		wait 5;
	}
}
inter6()
{
	trig = getent("inter6","targetname");
	while(1)
	{
		trig waittill("trigger",user);
		user iprintlnbold("^4Jack is a farmer!");
		wait 5;
	}
}
secret()
{
	trig = getent("secret","targetname");
	while(1)
	{
		trig waittill("trigger",user);
		iprintlnbold("^1"+ user.name + "^7 has found the secret");
		user giveWeapon("m40a3_mp");
		user switchtoweapon( "m40a3_mp" );
		wait 1;
	}
}
easysecret()
{
	trig = getent("easysecret","targetname");
	while(1)
	{
		trig waittill("trigger",user);
		iprintlnbold("^1"+ user.name + "^7 has found the secret");
		user giveWeapon("m40a3_mp");
		user switchtoweapon( "m40a3_mp" );
		wait 1;
	}
}
easyspawn()
{
	trig = getent("easyspawn","targetname");
	while(1)
	{
		trig waittill("trigger",user);
		user iprintlnbold ("^3All possible 125");
		wait 1;
	}
}
set1()
{
	trig = getent("1set","targetname");
	origin = getent("1settp","targetname");
	while(1)
	{
		trig waittill("trigger",user);
		user iprintlnbold ("^1Well done! Now try 350");
		wait 1;
		user SetOrigin( origin.origin );
		wait 1;
	}
}
set2()
{
	trig = getent("2set","targetname");
	origin = getent("2settp","targetname");
	while(1)
	{
		trig waittill("trigger",user);
		user iprintlnbold ("^1Well done! Now try 360");
		wait 1;
		user SetOrigin( origin.origin );
		wait 1;
	}
}
set3()
{
	trig = getent("3set","targetname");
	origin = getent("3settp","targetname");
	while(1)
	{
		trig waittill("trigger",user);
		user iprintlnbold ("^1Well done! Now try 370");
		wait 1;
		user SetOrigin( origin.origin );
		wait 1;
	}
}
set4()
{
	trig = getent("4set","targetname");
	origin = getent("3settp","targetname");
	while(1)
	{
		trig waittill("trigger",user);
		wait 1;
		user SetOrigin( origin.origin );
		wait 1;
	}
}
eztp()
{
	trig=getent("eztp","targetname");
	origin=getent("eztpo","targetname");
	while(1)
	{
		trig waittill("tigger",user);
		user setorigin(origin.origin);
		user iprintlnbold ("^3All possible 125");
		wait .5;
	}
}
ezfin()
{
	trig = getent("ezfin","targetname");
	origin = getent("spawn","targetname");
	while(1)
	{
		trig waittill("trigger",user);
		user SetOrigin( origin.origin );
		wait 1;
	}
}
intfin()
{
	trig = getent("intfin","targetname");
	origin = getent("spawn1","targetname");
	while(1)
	{
		trig waittill("trigger",user);
		user SetOrigin( origin.origin );
		wait 1;
	}
}
ezfin1()
{
	trig = getent("ezfin1","targetname");
	origin = getent("spawn2","targetname");
	while(1)
	{
		trig waittill("trigger",user);
		user SetOrigin( origin.origin );
		wait 1;
	}
}
intfin1()
{
	trig = getent("intfin1","targetname");
	origin = getent("spawn3","targetname");
	while(1)
	{
		trig waittill("trigger",user);
		user SetOrigin( origin.origin );
		wait 1;
	}
}
calum()
{
  _fan = getentarray("hard","targetname");

   for(i=0; i < _fan.size; i++)
    _fan[i] thread calum1();
}

calum1()
{
	while(true)
	{
		self rotateYaw(360,3);
		wait (0.9);
	}
}

bumba()
{
  _fan = getentarray("inter","targetname");

   for(i=0; i < _fan.size; i++)
    _fan[i] thread bumba1();
}

bumba1()
{
	while(true)
	{
		self rotateYaw(360,3);
		wait (0.9);
	}
}

easy()
{
  _fan = getentarray("easy","targetname");

   for(i=0; i < _fan.size; i++)
    _fan[i] thread _easy1();
}

_easy1()
{
	while(true)
	{
		self rotateYaw(360,3);
		wait (0.9);
	}
}
qubebumba()
{
	door   = getEntArray("door1", "targetname");
	trigger = getEntArray("door1trig", "targetname");
	for(i = 0;i < door.size;i++)
		thread door1(door[i],trigger[i]);
}


door1(door, trigger)
{
	while(true)
	{
		trigger waittill ("trigger", user );
		door moveY(128, 2, 1, 1);
		door waittill("movedone");
		door moveY(-128, 2, 1, 1);
		door waittill("movedone");
	}
}
