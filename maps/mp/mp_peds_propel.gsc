main()
{
	maps\mp\_load::main();
	ambientPlay("amb_airplane0v1_lr");
	game["allies"] = "sas";
	game["axis"] = "spetsnaz";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";
	thread endofmap();
	thread move1();
	thread move2();
	thread rotate1();
	thread tele();
	thread move1b();
	thread move2b();
	thread rotate1b();
	thread teleb();
	thread blueblood();
	thread enter1();
	thread journey1();
	thread journey2();
	thread entranceclip();
	thread immigration1();
	thread immigration2();
	thread bouncerfist();
	thread bouncerfoot();
	thread theshutters();
	thread thedoorshutter();
	thread thejailceiling();
	thread thekilling();
	thread thekilling2();
	thread thekilling3();
	thread thekilling4();
	thread thekilling5();
	thread thekilling6();
	thread thekilling7();
	thread thekilling8();
	thread thekilling9();
	thread thekilling10();
	thread advertss1();
	thread advertss2();
	thread advertss3();
	thread advertss4();
	thread stairhatch();
	thread theprisoner1();
	thread theprisoner2();
	thread theprisoner3();
	thread theprisoner4();
	thread thebackentrance1();
	thread thebackentrance2();
	thread thebackentrance3();
	thread theteleport1();
	thread theteleport2();
	thread theteleport3();
	thread theteleport4();
	thread theteleport5();
	thread theteleport6();
	thread theteleport7();
	thread theteleport8();
	thread thewowteleport1();
	thread thewowteleport2();
	thread thewowteleport3();
	thread thewowteleport4();
	thread bunkerkiller1();
	thread bunkerkiller2();
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
			user iprintlnbold ("Congratulations, " + user.name + ", you have completed the map!");
			user iprintlnbold ("^1-^9= ^1CoD^8Jumper^3.^7com ^3- ^7For all your CoDJumping needs! ^9=^1-");
			user.done = true;
		}
	}
}
enter1()
{
	trigger = getent ("enter_newcastle_trig","targetname");
	while(1)
	{
		trigger waittill ("trigger", player );
		if(player isTouching(trigger) && player useButtonPressed())
		{
			player thread enter2();
			wait 0.5;
		}
		else
		{
			wait 0.5;
		}
	}
}
enter2()
{
	trigger = getent ("enter_urine_trig","targetname");
	while(1)
	{
		trigger waittill ("trigger", player );
		if(player isTouching(trigger) && player meleeButtonPressed())
		{
			player thread enter3();
			wait 0.5;
		}
		else
		{
			wait 0.5;
		}
	}
}
enter3()
{
	trigger = getent ("enter_wakefield_trig","targetname");
	while(1)
	{
		trigger waittill ("trigger", player );
		if(player isTouching(trigger) && player AttackButtonPressed())
		{
			player thread enter4();
			wait 0.5;
		}
		else
		{
			wait 0.5;
		}
	}
}
enter4()
{
	trigger = getent ("enter_edinburgh_trig","targetname");
	while(1)
	{
		trigger waittill ("trigger", player );
		if(player isTouching(trigger))
		{
			player thread enter();
			wait 0.5;
		}
		else
		{
			wait 0.5;
		}
	}
}
enter()
{
	trigger = getent ("enter_main_trig","targetname");
	enter_main = getent ("enter_main","targetname");
	while(1)
	{
		trigger waittill ("trigger", player );
		if(player isTouching(trigger) && player useButtonPressed() && player meleeButtonPressed() && player AttackButtonPressed())
		{
			enter_main moveY (-32,1);
			enter_main waittill ("movedone");
			wait(1);
			enter_main moveY (32,1);
			enter_main waittill ("movedone");
			wait 0.5;
		}
		else
		{
			wait 0.5;
		}
	}
}
move1()
{
	frame = getent ("frame","targetname");
	swinger = getent ("swinger","targetname");
	swingertrig = getent ("swingertrig","targetname");
	swingertrig enablelinkto();
	swingertrig linkTo( swinger );
	while(1)
	{
		swinger movex (-2400, 10, 0, 0.5);
		swinger waittill ("movedone");
		swinger movex (2400, 10, 0, 0.5);
		swinger waittill ("movedone");
	}
}
move2()
{
	frame = getent ("frame","targetname");
	swinger = getent ("swinger","targetname");
	swingertrig = getent ("swingertrig","targetname");
	swingertrig linkTo( swinger );
	while(1)
	{
		frame movex (-2400, 10, 0, 0.5);
		frame waittill ("movedone");
		frame movex (2400, 10, 0, 0.5);
		frame waittill ("movedone");
	}
}
rotate1()
{
	frame = getent ("frame","targetname");
	swinger = getent ("swinger","targetname");
	swingertrig = getent ("swingertrig","targetname");
	swingertrig linkTo( swinger );
	while(1)
	{
		swinger rotateroll(70, 0.5);
		swinger waittill ("rotatedone");
		swinger rotateroll(-140, 1);
		swinger waittill ("rotatedone");
		swinger rotateroll(70, 0.5);
		swinger waittill ("rotatedone");
	}
}
tele()
{
	swingertrig = getent("swingertrig","targetname");
	while(1)
	{
		swingertrig waittill ("trigger",user);
		org = (2200,-1440,-40);
		wait 0.1;
		user setOrigin(org, 0.1);
	}
}
move1b()
{
	frame2 = getent ("frame2","targetname");
	swinger2 = getent ("swinger2","targetname");
	swinger2trig = getent ("swinger2trig","targetname");
	swinger2trig enablelinkto();
	swinger2trig linkTo( swinger2 );
	while(1)
	{
		swinger2 movex (2400, 10, 0, 0.5);
		swinger2 waittill ("movedone");
		swinger2 movex (-2400, 10, 0, 0.5);
		swinger2 waittill ("movedone");
	}
}
move2b()
{
	frame2 = getent ("frame2","targetname");
	swinger2 = getent ("swinger2","targetname");
	swinger2trig = getent ("swinger2trig","targetname");
	swinger2trig linkTo( swinger2 );
	while(1)
	{
		frame2 movex (2400, 10, 0, 0.5);
		frame2 waittill ("movedone");
		frame2 movex (-2400, 10, 0, 0.5);
		frame2 waittill ("movedone");
	}
}
rotate1b()
{
	frame2 = getent ("frame2","targetname");
	swinger2 = getent ("swinger2","targetname");
	swinger2trig = getent ("swinger2trig","targetname");
	swinger2trig linkTo( swinger2 );
	while(1)
	{
		swinger2 rotateroll(-70, 0.5);
		swinger2 waittill ("rotatedone");
		swinger2 rotateroll(140, 1);
		swinger2 waittill ("rotatedone");
		swinger2 rotateroll(-70, 0.5);
		swinger2 waittill ("rotatedone");
	}
}
teleb()
{
	swinger2trig = getent("swinger2trig","targetname");
	while(1)
	{
		swinger2trig waittill ("trigger",user);
		org = (2200,-1440,-40);
		wait 0.1;
		user setOrigin(org, 0.1);
	}
}
journey1()
{
	monoxide = getent("monoxide","targetname");
	while (1)
	{
		monoxide waittill ("trigger", user );
		if ( isPlayer( user ))
		{
			user.injected = true;
			wait 1;
		}
	}
}
journey2()
{
	bouncer = getent("bouncer","targetname");
	while (1)
	{
		bouncer waittill ("trigger", user );
		if ( isPlayer( user ) && isdefined( user.injected ) )
			user suicide();
	}
}
blueblood()
{
	specialteleporttrig = getent("specialteleporttrig","targetname");
	while (1)
	{
		specialteleporttrig waittill ("trigger", user );
		if(user.cj["status"] > 1)
			user setOrigin((1880,64,-368), 0.1);
		else
			wait 3;
	}
}
immigration1()
{
	dragon = getent("dragon","targetname");
	while (1)
	{
		dragon waittill ("trigger", user );
		if ( isPlayer( user ))
		{
			user.injected2 = true;
			wait 1;
		}
	}
}
immigration2()
{
	customs = getent("customs","targetname");
	while (1)
	{
		customs waittill ("trigger", user );
		if ( isPlayer( user ) && isdefined( user.injected2 ) )
			user suicide();
	}
}
theshutters()
{
	a1 = getent("1a","targetname");
	b1 = getent("1b","targetname");
	c1 = getent("1c","targetname");
	d1 = getent("1d","targetname");
	e1 = getent("1e","targetname");
	f1 = getent("1f","targetname");
	shutters = getent("shutters","targetname");
	a1 movez (288, 0.5, 0, 0.5);
	a1 waittill ("movedone");
	b1 movez (288, 0.5, 0, 0.5);
	b1 waittill ("movedone");
	c1 movez (288, 0.5, 0, 0.5);
	c1 waittill ("movedone");
	d1 movez (288, 0.5, 0, 0.5);
	d1 waittill ("movedone");
	e1 movez (288, 0.5, 0, 0.5);
	e1 waittill ("movedone");
	f1 movez (288, 0.5, 0, 0.5);
	f1 waittill ("movedone");
	while (1)
	{
		shutters waittill ("trigger", user );
		user iprintlnbold ("^1**^7Shutters are deploying!^1**");
		wait 1;
		a1 movez (185, 1, 0, 0.5);
		a1 waittill ("movedone");
		b1 movez (185, 1, 0, 0.5);
		b1 waittill ("movedone");
		c1 movez (185, 1, 0, 0.5);
		c1 waittill ("movedone");
		d1 movez (185, 1, 0, 0.5);
		d1 waittill ("movedone");
		e1 movez (185, 1, 0, 0.5);
		e1 waittill ("movedone");
		f1 movez (185, 1, 0, 0.5);
		f1 waittill ("movedone");
		wait 2;
		shutters waittill ("trigger", user );
		user iprintlnbold ("^1**^7Shutters are being removed!^1**");
		wait 1;
		f1 movez (-185, 1, 0, 0.5);
		f1 waittill ("movedone");
		e1 movez (-185, 1, 0, 0.5);
		e1 waittill ("movedone");
		d1 movez (-185, 1, 0, 0.5);
		d1 waittill ("movedone");
		c1 movez (-185, 1, 0, 0.5);
		c1 waittill ("movedone");
		b1 movez (-185, 1, 0, 0.5);
		b1 waittill ("movedone");
		a1 movez (-185, 1, 0, 0.5);
		a1 waittill ("movedone");
		wait 2;
	}
}
thedoorshutter()
{
	doorblock = getent("doorblock","targetname");
	doorshutters = getent("doorshutters","targetname");
	doorblock movez (561, 0.5, 0, 0.5);
	doorblock waittill ("movedone");
	doorblock movez (-81, 0.5, 0, 0.5);
	doorblock waittill ("movedone");
	while (1)
	{
		doorshutters waittill ("trigger", user );
		user iprintlnbold ("^1**^7Door shutter deploying!^1**");
		doorblock movez (81, 1, 0, 0.5);
		doorblock waittill ("movedone");
		wait 2;
		doorshutters waittill ("trigger", user );
		user iprintlnbold ("^1**^7Door shutter is being removed!^1**");
		doorblock movez (-81, 1, 0, 0.5);
		doorblock waittill ("movedone");
		wait 2;
	}
}
thejailceiling()
{
	floor1 = getent("floor1","targetname");
	floor2 = getent("floor2","targetname");
	ceilingcontrol = getent("ceilingcontrol","targetname");
	floor1 show();
	floor2 hide();
	while (1)
	{
		ceilingcontrol waittill ("trigger", user );
		user iprintlnbold ("^1**^7Floor opening!^1**");
		wait 1;
		floor1 hide();
		floor2 show();
		wait 2;
		ceilingcontrol waittill ("trigger", user );
		user iprintlnbold ("^1**^7Floor closing!^1**");
		wait 1;
		floor1 show();
		floor2 hide();
		wait 2;
	}
}
thekilling()
{
	switch_status1 = 0;
	killjail = getent("killjail","targetname");
	deathjail = getent("deathjail","targetname");
	deathjail thread maps\mp\_utility::triggerOff();
	while(1)
	{
		killjail waittill ("trigger",user);
		if(switch_status1 == 0)
		{
			deathjail thread maps\mp\_utility::triggerOn();
			user iprintlnbold ("^1**^7Gas turned on inside jail!^1**");
			switch_status1 = 1;
			wait 2;
		}
		else if(switch_status1 == 1)
		{
			deathjail thread maps\mp\_utility::triggerOff();
			user iprintlnbold ("^1**^7Removing gas from jail!^1**");
			switch_status1 = 0;
			wait 2;
		}
	}
}
thekilling2()
{
	deathjail = getent("deathjail","targetname");
	while (1)
	{
		deathjail waittill ("trigger", deathy );
		deathy suicide();
		wait 1;
	}
}
bouncerfist()
{
	bouncerfist = getent("bouncerfist","targetname");
	while (1)
	{
		bouncerfist waittill ("trigger", deathy2 );
		deathy2 suicide();
	}
}
bouncerfoot()
{
	bouncerfoot = getent("bouncerfoot","targetname");
	while (1)
	{
		bouncerfoot waittill ("trigger", deathy3 );
		deathy3 suicide();
	}
}
advertss1()
{
	advertswitch1 = getent("advertswitch1","targetname");
	while (1)
	{
		advertswitch1 waittill ("trigger", user );
		iprintlnbold ("^1-^9= ^1CoD^8Jumper^3.^7com ^3- ^7For all your CoDJumping needs! ^9=^1-");
		wait 2;
	}
}
advertss2()
{
	advertswitch2 = getent("advertswitch2","targetname");
	while (1)
	{
		advertswitch2 waittill ("trigger", user );
		iprintlnbold ("^9-^1= ^7Join the CoDJumper.com Xfire clan! xfire.com/clans/cjclan2 ^1=^9-");
		wait 2;
	}
}
advertss3()
{
	advertswitch3 = getent("advertswitch3","targetname");
	while (1)
	{
		advertswitch3 waittill ("trigger", user );
		iprintlnbold ("^9-^1= ^7All hail Pedsdude!^1=^9-");
		wait 2;
	}
}
advertss4()
{
	advertswitch4 = getent("advertswitch4","targetname");
	while (1)
	{
		advertswitch4 waittill ("trigger", user );
		iprintlnbold ("^9-^1= ^7All hail KillerSam!^1=^9-");
		wait 2;
	}
}
stairhatch()
{
	staircontrol = getent("staircontrol","targetname");
	staircover = getent("staircover","targetname");
	staircover show();
	staircover solid();
	while (1)
	{
		staircontrol waittill ("trigger", user);
		user iprintlnbold ("^1**^7Stairs are now uncovered!^1**");
		staircover hide();
		staircover notsolid();
		wait 2;
		staircontrol waittill ("trigger", user);
		user iprintlnbold ("^1**^7Stairs are now covered!^1**");
		staircover show();
		staircover solid();
		wait 2;
	}
}
thekilling3()
{
	killentrance = getent("entrancekill","targetname");
	deathentrance = getent("deathentrance","targetname");
	switch_status1 = 0;
	deathentrance thread maps\mp\_utility::triggerOff();
	while(1)
	{
		killentrance waittill ("trigger",user);
		if(switch_status1 == 0)
		{
			deathentrance thread maps\mp\_utility::triggerOn();
			user iprintlnbold ("^1**^7Gas turned on for entrance!^1**");
			switch_status1 = 1;
			wait 2;
		}
		else if(switch_status1 == 1)
		{
			deathentrance thread maps\mp\_utility::triggerOff();
			user iprintlnbold ("^1**^7Removing gas from entrance!^1**");
			switch_status1 = 0;
			wait 2;
		}
	}
}
thekilling4()
{
	deathentrance= getent("deathentrance","targetname");
	while (1)
	{
		deathentrance waittill ("trigger", deathy4 );
		deathy4 suicide();
		wait 1;
	}
}
thekilling5()
{
	surroundery= getent("surroundery","targetname");
	while (1)
	{
		surroundery waittill ("trigger", personzz );
		personzz suicide();
		wait 0.1;
	}
}
thekilling6()
{
	surrounder2= getent("surrounder2","targetname");
	while (1)
	{
		surrounder2 waittill ("trigger", personzz );
		personzz suicide();
		wait 0.1;
	}
}
thekilling7()
{
	surrounder3= getent("surrounder3","targetname");
	while (1)
	{
		surrounder3 waittill ("trigger", personzz );
		personzz suicide();
		wait 0.1;
	}
}
thekilling8()
{
	surrounder4= getent("surrounder4","targetname");
	while (1)
	{
		surrounder4 waittill ("trigger", personzz );
		personzz suicide();
		wait 0.1;
	}
}
thekilling9()
{
	surrounder5= getent("surrounder5","targetname");
	while (1)
	{
		surrounder5 waittill ("trigger", personzz );
		personzz suicide();
		wait 0.1;
	}
}
thekilling10()
{
	surrounderz= getent("surrounderz","targetname");
	while (1)
	{
		surrounderz waittill ("trigger", personzz );
		personzz suicide();
		wait 0.1;
	}
}
entranceclip()
{
	entrancecliptrig = getent("entrancecliptrig","targetname");
	entranceclip = getent("entranceclip","targetname");
	entranceclip show();
	entranceclip solid();
	while (1)
	{
		entrancecliptrig waittill ("trigger", user);
		user iprintlnbold ("^1**^7Entrance clip removed!^1**");
		entranceclip hide();
		entranceclip notsolid();
		wait 2;
		entrancecliptrig waittill ("trigger", user);
		user iprintlnbold ("^1**^7Entrance clip restored!^1**");
		entranceclip show();
		entranceclip solid();
		wait 2;
	}
}
theprisoner1()
{
	mapteleswitch = getent("mapteleswitch","targetname");
	maptele = getent("maptele","targetname");
	maptele thread maps\mp\_utility::triggerOff();
	while(1)
	{
		mapteleswitch waittill ("trigger",user);
		maptele thread maps\mp\_utility::triggerOn();
		user iprintlnbold ("^1**^7Teleporting players from main map to jail!^1**");
		wait 1;
		maptele thread maps\mp\_utility::triggerOff();
	}
}
theprisoner2()
{
	maptele = getent("maptele","targetname");
	while (1)
	{
		maptele waittill ("trigger", prisoner1 );
		org3 = (2112,-704,-528);
		prisoner1 setOrigin(org3, 0.1);
		wait 1;
	}
}
theprisoner3()
{
	entranceteleswitch = getent("entranceteleswitch","targetname");
	entrancetele = getent("entrancetele","targetname");
	entrancetele thread maps\mp\_utility::triggerOff();
	while(1)
	{
		entranceteleswitch waittill ("trigger",user);
		entrancetele thread maps\mp\_utility::triggerOn();
		user iprintlnbold ("^1**^7Teleporting players from entrance to jail!^1**");
		wait 1;
		entrancetele thread maps\mp\_utility::triggerOff();
	}
}
theprisoner4()
{
	entrancetele = getent("entrancetele","targetname");
	while (1)
	{
		entrancetele waittill ("trigger", prisoner2 );
		org4 = (2112,-704,-528);
		prisoner2 setOrigin(org4, 0.1);
		wait 1;
	}
}
thebackentrance1()
{
	backentrance1 = getent("backentrance1","targetname");
	backentrance1trig = getent("backentrance1trig","targetname");
	backentrance1 movez (656, 1, 0, 0.5);
	backentrance1 waittill ("movedone");
	while (1)
	{
		backentrance1trig waittill ("trigger", user );
		user iprintlnbold ("^1**^7Entrance 1 opening!^1**");
		wait 1;
		backentrance1 movez (-80, 1, 0, 0);
		backentrance1 waittill ("movedone");
		wait 1;
		backentrance1 movez (80, 1, 0, 0);
		backentrance1 waittill ("movedone");
	}
}
thebackentrance2()
{
	backentrance2 = getent("backentrance2","targetname");
	backentrance2trig = getent("backentrance2trig","targetname");
	backentrance2 movez (656, 1, 0, 0.5);
	backentrance2 waittill ("movedone");
	while (1)
	{
		backentrance2trig waittill ("trigger", user );
		user iprintlnbold ("^1**^7Entrance 2 opening!^1**");
		wait 1;
		backentrance2 movez (-80, 1, 0, 0);
		backentrance2 waittill ("movedone");
		wait 1;
		backentrance2 movez (80, 1, 0, 0);
		backentrance2 waittill ("movedone");
	}
}
thebackentrance3()
{
	backentrance3 = getent("backentrance3","targetname");
	backentrance3trig = getent("backentrance3trig","targetname");
	backentrance3 movez (656, 1, 0, 0.5);
	backentrance3 waittill ("movedone");
	while (1)
	{
		backentrance3trig waittill ("trigger", user );
		user iprintlnbold ("^1**^7Entrance 3 opening!^1**");
		wait 1;
		backentrance3 movez (-80, 1, 0, 0);
		backentrance3 waittill ("movedone");
		wait 1;
		backentrance3 movez (80, 1, 0, 0);
		backentrance3 waittill ("movedone");
	}
}
theteleport1()
{
	teleport1 = getent("teleport1","targetname");
	while(1)
	{
		teleport1 waittill ("trigger",user);
		org = (2264,64,0);
		wait 0.1;
		user setOrigin(org, 0.1);
	}
}
theteleport2()
{
	teleport2 = getent("teleport2","targetname");
	while(1)
	{
		teleport2 waittill ("trigger",user);
		org = (5072,64,0);
		wait 0.1;
		user setOrigin(org, 0.1);
	}
}
theteleport3()
{
	teleport3 = getent("teleport3","targetname");
	while(1)
	{
		teleport3 waittill ("trigger",user);
		org = (7552,1600,236);
		wait 0.1;
		user setOrigin(org, 0.1);
	}
}
theteleport4()
{
	teleport4 = getent("teleport4","targetname");
	while(1)
	{
		teleport4 waittill ("trigger",user);
		org = (3040,1576,536);
		wait 0.1;
		user setOrigin(org, 0.1);
	}
}
theteleport5()
{
	teleport5 = getent("teleport5","targetname");
	while(1)
	{
		teleport5 waittill ("trigger",user);
		org = (1904,1352,536);
		wait 0.1;
		user setOrigin(org, 0.1);
	}
}
theteleport6()
{
	teleport6 = getent("teleport6","targetname");
	while(1)
	{
		teleport6 waittill ("trigger",user);
		org = (1920,-1000,-32);
		wait 0.1;
		user setOrigin(org, 0.1);
	}
}
theteleport7()
{
	teleport7 = getent("teleport7","targetname");
	while(1)
	{
		teleport7 waittill ("trigger",user);
		org = (5576,-1440,296);
		wait 0.1;
		user setOrigin(org, 0.1);
	}
}
theteleport8()
{
	teleport8 = getent("teleport8","targetname");
	while(1)
	{
		teleport8 waittill ("trigger",user);
		org = (7552,-1024,304);
		wait 0.1;
		user setOrigin(org, 0.1);
	}
}
thewowteleport1()
{
	wowteleport1 = getent("wowteleport1","targetname");
	while(1)
	{
		wowteleport1 waittill ("trigger",user);
		org = (1632,272,608);
		wait 0.1;
		user setOrigin(org, 0.1);
	}
}
thewowteleport2()
{
	wowteleport2 = getent("wowteleport2","targetname");
	while(1)
	{
		wowteleport2 waittill ("trigger",user);
		org = (1632,-144,608);
		wait 0.1;
		user setOrigin(org, 0.1);
	}
}
thewowteleport3()
{
	wowteleport3 = getent("wowteleport3","targetname");
	while(1)
	{
		wowteleport3 waittill ("trigger",user);
		org = (2176,272,608);
		wait 0.1;
		user setOrigin(org, 0.1);
	}
}
thewowteleport4()
{
	wowteleport4 = getent("wowteleport4","targetname");
	while(1)
	{
		wowteleport4 waittill ("trigger",user);
		org = (2176,-144,608);
		wait 0.1;
		user setOrigin(org, 0.1);
	}
}
bunkerkiller1()
{
	switch_status99 = 0;
	killbunkerswitch = getent("killbunkerswitch","targetname");
	killbunker = getent("killbunker","targetname");
	while (1)
	{
		killbunkerswitch waittill ("trigger", user );
		if(user.cj["status"] > 1)
		{
			if (switch_status99 == 0)
			{
				killbunker thread maps\mp\_utility::triggerOn();
				user iprintlnbold ("^1**^7Gas turned on for Bunker!^1**");
				switch_status99 = 1;
				wait 2;
			}
			else if (switch_status99 == 1)
			{
				killbunker thread maps\mp\_utility::triggerOff();
				user iprintlnbold ("^1**^7Removing gas from Bunker!^1**");
				switch_status99 = 0;
				wait 2;
			}
		}
		else
		{
			wait 3;
		}
	}
}
bunkerkiller2()
{
	killbunker = getent("killbunker","targetname");
	while (1)
	{
		killbunker waittill ("trigger", dead );
		if(dead.cj["status"] > 1)
			wait 2;
		else
		{
			dead suicide();
			wait 1;
		}
	}
}