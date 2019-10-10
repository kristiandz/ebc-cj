/*
                   _____     ______     __   __     ______   __  __     ______     __    __     ______     __   __
                  /\  __-.  /\  __ \   /\ "-.\ \   /\__  _\ /\ \_\ \   /\  ___\   /\ "-./  \   /\  __ \   /\ "-.\ \
                  \ \ \/\ \ \ \  __ \  \ \ \-.  \  \/_/\ \/ \ \  __ \  \ \  __\   \ \ \-./\ \  \ \  __ \  \ \ \-.  \
          _______  \ \____-  \ \_\ \_\  \ \_\\"\_\    \ \_\  \ \_\ \_\  \ \_____\  \ \_\ \ \_\  \ \_\ \_\  \ \_\\"\_\  _______
         /\______\  \/____/   \/_/\/_/   \/_/ \/_/     \/_/   \/_/\/_/   \/_____/   \/_/  \/_/   \/_/\/_/   \/_/ \/_/ /\______\
         \/______/                                                                                                    \/______/


 ______     ______     _____       __     __  __     __    __     ______   ______     ______           ______     ______     __    __
/\  ___\   /\  __ \   /\  __-.    /\ \   /\ \/\ \   /\ "-./  \   /\  == \ /\  ___\   /\  == \         /\  ___\   /\  __ \   /\ "-./  \
\ \ \____  \ \ \/\ \  \ \ \/\ \  _\_\ \  \ \ \_\ \  \ \ \-./\ \  \ \  _-/ \ \  __\   \ \  __<     __  \ \ \____  \ \ \/\ \  \ \ \-./\ \
 \ \_____\  \ \_____\  \ \____- /\_____\  \ \_____\  \ \_\ \ \_\  \ \_\    \ \_____\  \ \_\ \_\  /\_\  \ \_____\  \ \_____\  \ \_\ \ \_\
  \/_____/   \/_____/   \/____/ \/_____/   \/_____/   \/_/  \/_/   \/_/     \/_____/   \/_/ /_/  \/_/   \/_____/   \/_____/   \/_/  \/_/


                              _____________________________________________________________________________
                             //_______________- Sonic - Scripted and Mapped by _DanTheMan_ -______________\\
                             \\ If you have a question about the following code, X-Fire me at 7dantheman7 //
                              \\ Please do not use this code or any variant of it without my permission  //
                               \\¯¯¯¯¯¯¯¯¯¯¯¯¯CoDJumper.com - For all your CoDJumping needs!¯¯¯¯¯¯¯¯¯¯¯¯//
                                ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
*/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

main()
{
	preCacheItem("supersonic_mp");
	preCacheMenu("sonic");
	preCacheShader("mtl_sonic_icon");
	preCacheShader("mtl_sonic_cjlogo");
	preCacheShader("mtl_sonic_outcome");
	e = strTok("blue,green,pink,purple,red,silver,yellow", ",");
	for(i = 0;i < 7;i++)
	{
		preCacheShader("mtl_sonic_emerald_" + e[i]);
		preCacheShader("mtl_sonic_emerald_" + e[i] + "_dark");
	}
	preCacheShader("mtl_sonic_youpwn");
	preCacheShader("mtl_sonic_yousuck");
	level._emeraldSparkle = loadFX("sonic/emerald_sparkle");
	level._signSparkle = loadFX("sonic/sign_sparkle");

	//level.fognearplane = 10;
	//level.fogexphalfplane = 1000;
	//level.fogred = .5;
	//level.foggreen = .5;
	//level.fogblue = .5;

	//maps\createart\mp_sonic_art::main();
	maps\mp\_load::main();

	maps\mp\_compass::setupMiniMap("compass_map_mp_sonic");
	setDvar("compassmaxrange", "8000");

	game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";

	level.ranking = [];
	level.rankingModel = [];
	level.emeralds = [];
	level.knockback = getDvar("g_knockback");
	level.cred = getCredits();

	thread endGame();
	thread onConnectedPlayer();
	thread music_change();

	getEnt("theEnd", "targetname") thread sign_spin();

	// Ent Arrays
	arr = [];
	arr["ent"] = [];
	arr["func"] = [];
	arr = addFunc(arr, "speed", ::speed);
	arr = addFunc(arr, "emerald", ::emeralds);
	for(i = 0;i < arr["ent"].size;i++)
	{	
		for(n = 0;n < arr["ent"][i].size;n++)
			thread [[arr["func"][i]]](arr["ent"][i][n]);
	}

	thread system_edit();

	thread bonus_content(getEntArray("bonus_content", "targetname"), getEntArray("standard_content", "targetname"));
}

addFunc(arr, targetname, func)
{
	i = arr["ent"].size;
	arr["ent"][i] = getEntArray(targetname, "targetname");
	arr["func"][i] = func;
	return arr;
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

		trigger playSound(strTok(trigger.script_noteworthy, ",")[1]);

		player notify("admin_on");

		player.health    = 100;
		player.maxhealth = 100;
	}

	while(player isTouching(trigger))
		wait 0.05;

	player.speed = undefined;
}

emeralds(emerald)
{
	wait 2;
	if(getDvarInt("sv_cheats"))
	{
		emerald delete();
		return;
	}

	thread emerald_rotate(emerald);
	thread emerald_float(emerald);

	tok = strTok(emerald.script_noteworthy, ",");
	color = (int(tok[0])/255, int(tok[1])/255, int(tok[2])/255);

	trigger = spawn("trigger_radius", emerald.origin, 0, 32, 32);

	playLoopedFX(level._emeraldSparkle, 40, emerald.origin);

	for(;;)
	{
		trigger waittill("trigger", player);

		if(!isDefined(player.hasEmerald[tok[3]]) && !isDefined(player.noFlash))
		{
			player.hasEmerald[tok[3]] = true;
			player.fullscreenShader.color = color;
			player.fullscreenShader.alpha = 1;
			player.fullscreenShader fadeOverTime(1);
			player.fullscreenShader.alpha = 0;

			if(isDefined(player.hasEmerald["red"]) && isDefined(player.hasEmerald["yellow"]) && isDefined(player.hasEmerald["silver"]) && isDefined(player.hasEmerald["blue"]) && isDefined(player.hasEmerald["pink"]) && isDefined(player.hasEmerald["purple"]) && isDefined(player.hasEmerald["green"]))
				player.hasAllEmeralds = true;
		}
	}
}

emerald_rotate(emerald)
{
	for(;;)
	{
		emerald rotateYaw(360, 5);
		wait 4.9;
	}
}

emerald_float(emerald)
{
	start_org = emerald.origin;
	max_org = emerald.origin + (0, 0, 32);

	for(;;)
	{
		emerald moveTo(max_org, 1.5, 0.7, 0.7);
		wait 1.4;
		emerald moveTo(start_org, 1.5, 0.7, 0.7);
		wait 1.4;
	}
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

sign_spin()
{
	trigger = getEnt(self.target, "targetname");

	for(;;)
	{
		trigger waittill("trigger", player);

		if(!(!isDefined(player.finished) || (isDefined(player.finished) && (isDefined(player.tryAgain) && player.tryAgain && player.hasAllEmeralds))))
			continue;

		playFX(level._signSparkle, self.origin);
		self playSound("sonic_sign_spin");

		a = self.origin[0] > player.origin[0]; b = self.origin[1] > player.origin[1];
		sideHit = -2*((a && b) || (!a && !b)) + 1;
		for(i = 0;i < 1.75;i += 0.25)
		{
			self.angles = (0, 0, 0);
			self rotateYaw(360*sideHit, 0.25);
			wait 0.25;
		}

		player thread theEnd();
	}
}

theEnd()
{
	self endon("disconnect");

	firstTimeFinished = !isDefined(self.tryAgain);

	self.noFlash = true;

	self.finished = true;
	self.tryAgain = !(self.hasAllEmeralds);

	self.fullscreenShader.color = (0,0,0);

	self.fullscreenShader fadeOverTime(2);
	self.fullscreenShader.alpha = 1;
	wait 2;

	self.credText = [];

	t = 0;
	place = "1st place";
	if(firstTimeFinished)
	{
		t = getPlayerTime(self);
		place = self getTimePlacement(t);
		iPrintLn(self.name + " finished ^3Sonic ^7in " + place + " in " + t);
	}

	for(i = 0;i < level.cred.size;i++)
	{
		end = (level.cred[i][0] == "The End");

		name = "";
		if(!i)
			name = " " + self.name + ",";

		self.credText[level.cred[i][0]] = newClientHudElem(self);
		self.credText[level.cred[i][0]].alignX = "center";
		self.credText[level.cred[i][0]].alignY = "middle";
		self.credText[level.cred[i][0]].horzAlign = "fullscreen";
		self.credText[level.cred[i][0]].vertAlign = "fullscreen";
		self.credText[level.cred[i][0]].x = 320;
		self.credText[level.cred[i][0]].y = 500;
		self.credText[level.cred[i][0]].alpha = 1;
		self.credText[level.cred[i][0]].sort = 2;
		self.credText[level.cred[i][0]].fontscale = 1.4;
		self.credText[level.cred[i][0]].color = (1, 1, 1);
		self.credText[level.cred[i][0]].glowColor = (0.5, 1, 0.5);
		self.credText[level.cred[i][0]].glowAlpha = 1;
		self.credText[level.cred[i][0]].hideWhenInMenu = false;
		self.credText[level.cred[i][0]] setText(level.cred[i][0] + name);
		self.credText[level.cred[i][0]] setPulseFX(100, 6000000, 1000);

		time = 12;
		dest = -20;
		if(end)
		{
			time = 8.331;
			dest = 139;

			self.credShader = newClientHudElem(self);
			self.credShader.alignX = "center";
			self.credShader.alignY = "middle";
			self.credShader.horzAlign = "fullscreen";
			self.credShader.vertAlign = "fullscreen";
			self.credShader.x = 320;
			self.credShader.y = 550;
			self.credShader.alpha = 1;
			self.credShader.sort = 2;
			self.credShader.hideWhenInMenu = false;
			self.credShader setShader("mtl_sonic_cjlogo", 256, 128);
			self.credShader moveOverTime(time);
			self.credShader.y = 189;
		}

		self.credText[level.cred[i][0]] moveOverTime(time);
		self.credText[level.cred[i][0]].y = dest;
		if(!end)
			wait level.cred[i][1];

		else
			break;
	}

	wait 10;

	if(firstTimeFinished)
	{
		self.credText[level.cred[0][0]] setText("You finished ^3Sonic ^7in " + place + " in " + t);
		self.credText[level.cred[0][0]].alpha = 1;
		self.credText[level.cred[0][0]].x = 320;
		self.credText[level.cred[0][0]].y = 70;
		self.credText[level.cred[0][0]] setPulseFX(100, 6000000, 1000);
	}

	e = strTok("blue,green,pink,purple,red,silver,yellow", ",");
	self.credEmerald = [];
	for(i = 0;i < 7 && self.tryAgain;i++)
	{
		if(isDefined(self.hasEmerald[e[i]]))
		{
			self.credEmerald[i] = newClientHudElem(self);
			self.credEmerald[i].alignX = "center";
			self.credEmerald[i].alignY = "middle";
			self.credEmerald[i].horzAlign = "fullscreen";
			self.credEmerald[i].vertAlign = "fullscreen";
			self.credEmerald[i].x = 320;
			self.credEmerald[i].y = 340;
			self.credEmerald[i].alpha = 0;
			self.credEmerald[i].sort = 2;
			self.credEmerald[i].hideWhenInMenu = false;
			self.credEmerald[i] setShader("mtl_sonic_emerald_" + e[i], 256, 256);
			self.credEmerald[i] fadeOverTime(1);
			self.credEmerald[i].alpha = 1;
			continue;
		}

		self.credEmerald[i] = newClientHudElem(self);
		self.credEmerald[i].alignX = "center";
		self.credEmerald[i].alignY = "middle";
		self.credEmerald[i].horzAlign = "fullscreen";
		self.credEmerald[i].vertAlign = "fullscreen";
		self.credEmerald[i].x = 320;
		self.credEmerald[i].y = 340;
		self.credEmerald[i].alpha = 0;
		self.credEmerald[i].sort = 2;
		self.credEmerald[i].hideWhenInMenu = false;
		self.credEmerald[i] setShader("mtl_sonic_emerald_" + e[i] + "_dark", 256, 256);
		self.credEmerald[i] fadeOverTime(1);
		self.credEmerald[i].alpha = 1;
	}

	str = "suck";
	y = 256;
	x = 56;
	height = 400;
	if(!self.tryAgain)
	{
		str = "pwn";
		y = 512;
		x = 256;
		height = 350;
	}
	self.credStatus = newClientHudElem(self);
	self.credStatus.alignX = "center";
	self.credStatus.alignY = "middle";
	self.credStatus.horzAlign = "fullscreen";
	self.credStatus.vertAlign = "fullscreen";
	self.credStatus.x = 320;
	self.credStatus.y = height;
	self.credStatus.alpha = 0;
	self.credStatus.sort = 2;
	self.credStatus.hideWhenInMenu = false;
	self.credStatus setShader("mtl_sonic_you" + str, y, x);
	self.credStatus fadeOverTime(1);
	self.credStatus.alpha = 1;

	wait 6;

	if(firstTimeFinished)
	{
		self.credText[level.cred[0][0]] fadeOverTime(5);
		self.credText[level.cred[0][0]].alpha = 0;
	}
	self.credText[level.cred[7][0]] fadeOverTime(5);
	self.credText[level.cred[7][0]].alpha = 0;
	self.credShader fadeOverTime(5);
	self.credShader.alpha = 0;
	self.fullscreenShader fadeOverTime(5);
	self.fullscreenShader.alpha = 0;
	for(i = 0;i < 7 && self.tryAgain;i++)
	{
		self.credEmerald[i] fadeOverTime(5);
		self.credEmerald[i].alpha = 0;
	}
	self.credStatus fadeOverTime(5);
	self.credStatus.alpha = 0;

	wait 7;

	for(i = 0;i < self.credText.size;i++)
		self.credText[level.cred[i][0]] destroy();
	self.credShader destroy();
	for(i = 0;i < 7 && self.tryAgain;i++)
		self.credEmerald[i] destroy();
	self.credStatus destroy();

	self.noFlash = undefined;

	if(!self.tryAgain && !isDefined(self.firstTimeSuper))
		self thread super();
}

// Return credits as array
getCredits()
{
	cred = [];
	cred[0] = "Congratulations:0";
	cred[1] = "you have completed Sonic!:2";
	cred[2] = "Mapping and scripting by _DanTheMan_:0";
	cred[3] = "X-Fire me with questions at 7dantheman7:1";
	cred[4] = "Most textures & sounds (c) Sega:2";
	cred[5] = "Thanks to Cad for some ideas/graphics:0";
	cred[6] = "X-Fire him at cadster24:2";
	cred[7] = "The End";

	for(c = 0;c < cred.size;c++)
	{
		cred[c] = strTok(cred[c], ":");
		if(cred[c].size > 1 && cred[c][1] != "")
			cred[c][1] = (int(cred[c][1])+1)/2.353;

		else
			cred[c][1] = 0;
	}

	return cred;
}

onConnectedPlayer()
{
	level endon("game_ended");

	for(;;)
	{
		level waittill("connected", player);
		thread onSpawnPlayer(player);
	}
}

onSpawnPlayer(player)
{
	level endon("game_ended");
	player endon("disconnect");

	player.muted = false;
	player.startedMusic = false;
	player.startedSuperMusic = false;
	player.canPlayMusic = true;

	player.hasAllEmeralds = false;
	player.hasEmerald = [];

	player.fullscreenShader = newClientHudElem(player);
	player.fullscreenShader.alignX = "center";
	player.fullscreenShader.alignY = "middle";
	player.fullscreenShader.horzAlign = "fullscreen";
	player.fullscreenShader.vertAlign = "fullscreen";
	player.fullscreenShader.x = 320;
	player.fullscreenShader.y = 240;
	player.fullscreenShader.alpha = 0;
	player.fullscreenShader.sort = 1;
	player.fullscreenShader.color = (0,0,0);
	player.fullscreenShader.hideWhenInMenu = false;
	player.fullscreenShader setShader("white", 640, 480);

	player.muted = true;
	player.song_choice = 0;
	player.canPlayMusic = true;
	player.play_intro = false;

	//player thread play_music();
	for(;;)
	{
		player setClientDvar("r_drawDecals", true);
		player setClientDvar("ui_supersonic", false);
		player waittill("spawned_player");
		thread spawned_player(player);
	}
}

spawned_player(player)
{
	level endon("game_ended");
	player endon("death");
	player endon("killed_player");
	player endon("joined_spectators");
	player endon("disconnect");

	player.hasEnteredSuper = false;

	if(player.startedSuperMusic)
	{
		if(player.play_intro)
			player stopLocalSound("amb_sonic_" + (2 + player.song_choice) + "_intro");

		else
			player stopLocalSound("amb_sonic_" + (2 + player.song_choice));
	}
	player.startedSuperMusic = false;

	if(isDefined(player.tryAgain) && !player.tryAgain)
		player thread super();

	lastUsableOrigin = player.origin;

	n = 0;
	t = 0;
	if(isDefined(player.playtime))
	{
		n = int(player.playtime*20);
		t = player.playtime;
	}
	for(i = 0;;i++)
	{
		player setClientDvar("com_maxFPS", 125);

		if(i > 4 && player isOnGround() && player.origin[2] > 224)
		{
			i = 0;
			lastUsableOrigin = player.origin;
		}

		if(player.origin[2] <= 224 && player.origin[2] > 192 && !player.hasEnteredSuper)
			player thread freeze(lastUsableOrigin);

		if(!(isDefined(player.tryAgain) && !player.tryAgain))
		{
			player.playtime = t;
			n++;
			t = n/20;
		}

		wait 0.05;
	}
}

freeze(lastUsableOrigin)
{
	self freezeControls(true);
	self setOrigin(lastUsableOrigin);
	wait 0.05;
	self freezeControls(false);
}

play_music(old_track)
{
	self endon("new_song");
	self endon("disconnect");

	if(!self.canPlayMusic || self.muted)
		return;

	if(isDefined(old_track) && old_track != 1337)
	{
		if(self.play_intro)
			self stopLocalSound("amb_sonic_" + old_track + "_intro");

		else
			self stopLocalSound("amb_sonic_" + old_track);
	}

	if(!isDefined(self.song_choice))
		self.song_choice = 0;

	self.play_intro = true;
	self.startedMusic = true;

	music = [];
	music[0] = 14.49;
	music[1] = 38.44;
	music[2] = 13.72;
	music[3] = 36.09;

	choice = self.song_choice;
	for(;;)
	{
		if(self.play_intro)
		{
			self playLocalSound("amb_sonic_" + choice + "_intro");
			wait music[choice*2];
			self.play_intro = false;
		}

		self playLocalSound("amb_sonic_" + choice);
		wait music[1 + (choice*2)];
	}
}

music_change(button, num)
{
	if(!isDefined(button) && !isDefined(num))
	{
		thread music_change(getEnt("button0", "targetname"), 0);
		thread music_change(getEnt("button1", "targetname"), 1);
		thread music_change(getEnt("button2", "targetname"), 2);
		return;
	}

	for(;;)
	{
		button waittill("trigger", player);
		if(num == 2)
		{
			player notify("new_song");
			player notify("new_songSuper");

			int = 2*(!player.canPlayMusic);

			if(isDefined(player.song_choice))
			{
				if(player.play_intro && player.canPlayMusic)
					player stopLocalSound("amb_sonic_" + player.song_choice + "_intro");

				else
					player stopLocalSound("amb_sonic_" + (int + player.song_choice));
			}
			player.startedMusic = false;
			player.startedSuperMusic = false;
			player.muted = true;
		}
		else if((isDefined(player.song_choice) && player.song_choice != num) || player.muted)
		{
			if(!player.muted)
				old_track = player.song_choice;
			else
				old_track = 1337;
			player.muted = false;
			player.song_choice = num;
			if(!player.canPlayMusic)
			{
				player notify("new_songSuper");
				player thread super_music(old_track);
			}
			else
			{
				player notify("new_song");
				player thread play_music(old_track);
			}
		}
	}
}

system_edit()
{
	for(;!isDefined(game["gamestarted"]);)
		wait 0.05;
	wait 0.05;

	team[0] = "allies";
	team[1] = "axis";

	game["strings"]["tie"] = "No Players Finished";
	game["strings"]["round_draw"] = "No Players Finished";
	game["strings"]["enemies_eliminated"] = "No Players Finished";
	game["strings"]["score_limit_reached"] = "No Players Finished";
	game["strings"]["round_limit_reached"] = "No Players Finished";
	game["strings"]["time_limit_reached"] = "No Players Finished";
	game["strings"]["players_forfeited"] = "No Players Finished";

	level.outcomeShader = newHudElem();
	level.outcomeShader.elemType = "icon";
	level.outcomeShader.children = [];
	level.outcomeShader setParent(level.uiParent);
	level.outcomeShader.alpha = 0;
	level.outcomeShader.sort = 1;
	level.outcomeShader.hideWhenInMenu = false;
}

bonus_content(bonus_content, standard_content)
{
	wait 2;

	if(!getDvarInt("sv_cheats"))
		for(i = 0;i < standard_content.size;i++)
			standard_content[i] delete();

	else
		for(i = 0;i < bonus_content.size;i++)
			bonus_content[i] delete();
}

super()
{
	level endon("game_ended");
	self endon("death");
	self endon("killed_player");
	self endon("joined_spectators");
	self endon("disconnect");

	if(!self.hasAllEmeralds)
		return;

	if(!isDefined(self.firstTimeSuper))
	{
		self.firstTimeSuper = true;
		self iPrintLnBold("Press ^3[Smoke] ^7to toggle Super Sonic menu");
	}

	self.canOpenSuperMenu = true;
	self.hasEnteredSuper = false;
	self.superSonicMusic = false;
	self.canPlayMusic = true;

	self thread super_menu();

	catchJump = false;
	for(;;)
	{
		wait 0.05;

		if(self secondaryOffhandButtonPressed() && self.canOpenSuperMenu)
			self openMenu("sonic");

		if(!self.hasEnteredSuper)
		{
			if(self hasWeapon("supersonic_mp"))
			{
				weap = "beretta_mp";
				if(isDefined(self.cj) && isDefined(self.cj["status"]) && self.cj["status"])
					weap = "deserteaglegold_mp";
				self takeAllWeapons();
				self giveWeapon("rpg_mp");
				self giveWeapon(weap);
				self giveMaxAmmo(weap);
				self switchToWeapon(weap);
			}

			continue;
		}

		if(!self hasWeapon("supersonic_mp"))
		{
			self takeAllWeapons();
			self giveWeapon("rpg_mp");
			self giveWeapon("supersonic_mp");
			self giveMaxAmmo("supersonic_mp");
			self switchToWeapon("supersonic_mp");
		}

		if(!catchJump && !self isOnGround() && self getVelocity()[2] > 0)
		{
			self.health    = 1000000;
			self.maxhealth = 1000000;

			self thread adminOff();

			setDvar("g_knockback", 600);
			self finishPlayerDamage(self, self, 600, 0, "MOD_FALLING", "deserteaglegold_mp", self.origin, (0, 0, 32), "head", 0);
			wait 0.05;
			setDvar("g_knockback", level.knockback);

			self notify("admin_on");

			self.health    = 100;
			self.maxhealth = 100;

			catchJump = true;
		}

		else if(catchJump && self isOnGround())
			catchJUmp = false;
	}
}

super_menu()
{
	level endon("game_ended");
	self endon("death");
	self endon("killed_player");
	self endon("joined_spectators");
	self endon("disconnect");

	for(;;)
	{
		self waittill("menuresponse", menu, response);
		if(menu != "sonic")
			continue;

		switch(response)
		{
			case "enter": self.hasEnteredSuper = true;
						  self.superSonicMusic = true;
						  self.canPlayMusic = false;
						  self notify("new_song");
						  self thread super_music();
						  self setClientDvar("ui_supersonic", 1);
						  break;

			case "exit": self.hasEnteredSuper = false;
						 self.superSonicMusic = false;
						 self.canPlayMusic = true;
						 self notify("new_songSuper");
						 self thread play_music(1337);
						 self setClientDvar("ui_supersonic", 0);
						 break;

			case "respawn": self.canOpenSuperMenu = false; 
							break;
		}
	}
}

super_music(old_track)
{
	self endon("new_songSuper");
	self endon("disconnect");

	if(isDefined(old_track) && old_track != 1337)
	{
		if(self.play_intro)
			self stopLocalSound("amb_sonic_" + (2 + old_track) + "_intro");

		else
			self stopLocalSound("amb_sonic_" + (2 + old_Track));
	}

	self.startedSuperMusic = true;

	music = [];
	music[0] = 39.38;
	music[1] = 38.44;

	choice = self.song_choice;
	for(;;)
	{
		if(self.muted)
		{
			wait 0.05;
			continue;
		}

		else
		{
			if(self.startedMusic)
			{
				self notify("new_song");

				if(isDefined(self.song_choice) && self.startedMusic)
				{
					if(self.play_intro)
						self stopLocalSound("amb_sonic_" + self.song_choice + "_intro");

					else
						self stopLocalSound("amb_sonic_" + self.song_choice);
				}
				self.startedMusic = false;
			}
		}

		self playLocalSound("amb_sonic_" + (2 + choice));
		wait music[choice];
	}
}

getPlayerTime(player)
{
	t = player.playtime;

	m = t/60;
	s = 0;
	if(isSubStr(m + "", "."))
	{
		s = getSubStr(strTok(m + "", ".")[1], 0, 2);
		m = int(strTok(m + "", ".")[0]);
	}

	if(isDefined(s) && s != "")
		s = int(s)/166.66666666666666666666666666667;
	else
		s = 0;

	t = m + s;

	t = strTok(t + "", ".");
	t[3] = getSubStr(t[1], 1, 2);
	t[2] = getSubStr(t[1], 0, 1);
	t[1] = getSubStr(t[0], 1, 2);
	t[0] = getSubStr(t[0], 0, 1);
	if(!isDefined(t[3]) || t[3] == "")
		t[3] = "0";
	if(!isDefined(t[2]) || t[2] == "")
		t[2] = "0";
	if(!isDefined(t[0]) || t[0] == "")
	t[0] = "0";
		if(!isDefined(t[1]) || t[1] == "")
	{
		t[1] = t[0];
		t[0] = "0";
	}
	temp = t[0] + "" + t[1];
	if(int(temp) > 99)
	{
		t[0] = "9";
		t[1] = "9";
		t[2] = "6";
		t[3] = "0";
	}

	if(t[0] == "0")
		temp = t[1];

	return (temp + ":" + t[2] + "" + t[3]);
}

getTimePlacement(t)
{
	if(!level.ranking.size)
	{
		game["strings"]["tie"] = "Players with Best Times:";
		game["strings"]["round_draw"] = "Players with Best Times:";
		game["strings"]["enemies_eliminated"] = "Players with Best Times:";
		game["strings"]["score_limit_reached"] = "Players with Best Times:";
		game["strings"]["round_limit_reached"] = "Players with Best Times:";
		game["strings"]["time_limit_reached"] = "Players with Best Times:";
		game["strings"]["players_forfeited"] = "Players with Best Times:";
	}

	rank = 1;

	ranking = int(strTok(t, ":")[0]) + int(strTok(t, ":")[1])*0.016666666666666666666666666666667;

	if(!level.ranking.size)
	{
		level.ranking[0] = [];
		level.ranking[0]["time"] = ranking;
		level.ranking[0]["time_hud"] = t;
		level.ranking[0]["pers"] = self;
		level.ranking[0]["name"] = self.name;
	}

	else
	{
		for(i = level.ranking.size - 1;i >= 0;i--)
		{
			if(ranking < level.ranking[i]["time"])
				level.ranking[i + 1] = level.ranking[i];

			else
			{
				bestTime = false;
				level.ranking[i + 1] = [];
				level.ranking[i + 1]["time"] = ranking;
				level.ranking[i + 1]["time_hud"] = t;
				level.ranking[i + 1]["pers"] = self;
				level.ranking[i + 1]["name"] = self.name;
				rank = i + 2;
				break;
			}
		}

		if(rank == 1)
		{
			level.ranking[0] = [];
			level.ranking[0]["time"] = ranking;
			level.ranking[0]["time_hud"] = t;
			level.ranking[0]["pers"] = self;
			level.ranking[0]["name"] = self.name;
		}
	}

	return getNextRankUp(rank);
}

getNextRankUp(rank)
{
	tempRank = rank + "st";
	str = "";

	num1 = int(getSubStr(tempRank, 0, 1));
	num2 = int(getSubStr(tempRank, 1, 2));

	if(tempRank == "1st" || (num2 == 1 && tempRank != "11st"))
		str = "st";

	else if(num1 != 1 && (tempRank == "2st" || num2 == 2))
		str = "nd";

	else if(num1 != 1 && (tempRank == "3st" || num2 == 3))
		str = "rd";

	else str = "th";

	return (rank + str + " place");
}

endGame()
{
	level waittill("game_ended");
	for(i = 0;i < level.players.size;i++)
		level.players[i] thread endGameHud();

	level.outcomeShader.alpha = 1;
	level.outcomeShader.color = (1, 1, 1);
	level.outcomeShader setPoint("TOP", undefined, 0, -28);
	level.outcomeShader setShader("mtl_sonic_outcome", 560, 280);
}

endGameHud()
{
	self endon("disconnect");

	titleSize = 3.0;
	winnerSize = 2.0;
	otherSize = 1.5;
	iconSize = 30;
	spacing = 20;
	font = "objective";

	duration = 60000;

	players = [];
	for(i = 0;i < 3 && i < level.ranking.size;i++)
		players[i] = level.ranking[i];

	outcomeTitle = self createFontString( font, titleSize );
	outcomeTitle setPoint( "TOP", undefined, 0, spacing );
	outcomeTitle.sort = 2;
	if(isDefined(players[0]) && self == players[0]["pers"])
	{
		outcomeTitle setText(game["strings"]["victory"]);
		outcomeTitle.glowColor = (0.2, 0.3, 0.7);
	}
	else
	{
		outcomeTitle setText(game["strings"]["defeat"]);
		outcomeTitle.glowColor = (0.7, 0.3, 0.2);
	}
	outcomeTitle.glowAlpha = 1;
	outcomeTitle.hideWhenInMenu = false;
	outcomeTitle.archived = false;
	outcomeTitle setPulseFX( 100, duration, 1000 );
	outcomeText = self createFontString( font, 2.0);
	outcomeText setParent(outcomeTitle);
	outcomeText setPoint("TOP", "BOTTOM", 0, 0);
	outcomeText.glowColor = (0.2, 0.3, 0.7);
	outcomeText.glowAlpha = 1;
	outcomeText.hideWhenInMenu = false;
	outcomeText.archived = false;
	outcomeText.sort = 2;
	outcomeText setText(game["strings"]["time_limit_reached"]);

	title = [];
	for(i = 0;i < 3;i++)
	{
		title[i] = self createFontString(font, winnerSize*(!i) + otherSize*(!!i));
		if(!i)
			title[i] setParent(outcomeText);
		else
			title[i] setParent(title[i - 1]);
		title[i] setPoint( "TOP", "BOTTOM", 0, spacing );
		title[i].hideWhenInMenu = false;
		title[i].archived = false;
		title[i].sort = 2;

		name = "--";
		time = "";

		if(players.size - 1 >= i)
		{
			name = players[i]["name"];
			if(isDefined(players[i]["pers"]))
				name = players[i]["pers"].name;
			time = " - [^3" + players[i]["time_hud"] + "^7]";
		}

		title[i].label = &"MP_FIRSTPLACE_NAME";
		title[i].gloWColor = (0.3, 0.7, 0.2);
		title[i].glowAlpha = 1;
		if(i == 1)
		{
			title[i].label = &"MP_SECONDPLACE_NAME";
			title[i].glowColor = (0.2, 0.3, 0.7);
		}
		else if(i == 2)
		{
			title[i].label = &"MP_THIRDPLACE_NAME";
			title[i].glowColor = (0.2, 0.3, 0.7);
		}
		title[i] setText(name + time);
		title[i] setPulseFX(100, duration, 1000);
	}

	self waittill("reset_outcome");

	if(isDefined(level.outcomeShader))
		level.outcomeShader destroy();

	outcomeTitle destroy();
	outcomeText destroy();
	for(i = 0;i < title.size;i++)
		title[i] destroy();
}