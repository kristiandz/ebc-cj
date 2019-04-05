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
                             //______________- Dungeon - Scripted and Mapped by _DanTheMan_ -_____________\\
                             \\ If you have a question about the following code, X-Fire me at 7dantheman7 //
                              \\ Please do not use this code or any variant of it without my permission  //
                               \\¯¯¯¯¯¯¯¯¯¯¯¯¯CoDJumper.com - For all your CoDJumping needs!¯¯¯¯¯¯¯¯¯¯¯¯//
                                ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
*/

// PATCHED

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

main()
{
	maps\mp\_load::main();
	ambientPlay("ambient_dusk_sur");
	game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";

	level.nextPlaceUp = 0;

	level.knockback = getDvarInt("g_knockback");

	bounce   = getEntArray("dBounce", "targetname");
	suicide  = getEntArray("suicide", "targetname");
	teleport = getEntArray("teleport", "targetname");
	water    = getEntArray("waterTouch", "targetname");

	for(i = 0;i < suicide.size;i++)
		suicide[i] thread deathCheck();

	for(i = 0;i < bounce.size;i++)
		bounce[i] thread bounce(getEnt(bounce[i].target, "targetname"));

	for(i = 0;i < teleport.size;i++)
		teleport[i] thread teleport(getEnt(teleport[i].target, "targetname"));

	for(i = 0;i < water.size;i++)
		water[i] thread water();

	thread onConnectedPlayer();

	getEnt("finish", "targetname") thread finish();
}

deathCheck()
{
	for(;;)
	{
		self waittill("trigger", p);
		p suicide();
	}
}

bounce(target)
{
	for(;;)
	{
		self waittill("trigger", p);

		if(!isDefined(p.bouncing))
			p thread player_bounce(self, target);
	}
}

teleport(target)
{
	for(;;)
	{
		self waittill("trigger", p);

		p freezeControls(true);
		p setOrigin(target.origin);
		p setPlayerAngles(target.angles);
		wait 0.05;
		p freezeControls(false);
	}
}

player_bounce(trigger, target)
{
	self endon("disconnect");

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

	origin = (self.origin[0], target.origin[1], target.origin[2]);

	self thread adminOff();

	setDvar("g_knockback", (vel[2]*-9)-500);
	self thread emz\_globallogic::callback_playerDamage(self, level, 1000, 0, "BOUNCE", "bounce", origin, (self.origin - origin), "head", 0);
	wait 0.05;
	setDvar("g_knockback", level.knockback);

	self notify("admin_on");

	self.health    = health;
	self.maxhealth = maxHealth;

	while(self isTouching(trigger))
		wait 0.05;

	self.bouncing = undefined;
}

water()
{
	maxHeight = getEnt(self.target, "targetname").origin[2];

	for(;;)
	{
		self waittill("trigger", p);

		if(!isDefined(p.water))
			p thread waterTouch(self, maxHeight);
	}
}

waterTouch(water, maxHeight)
{
	self endon("disconnect");

	self.water = true;
	self.blurred = false;

	while(self isTouching(water))
	{
		eye = self eye()[2];

		if(maxHeight - eye > 0)
		{
			if(!self.blurred)
			{
				self setClientDvar("r_blur", 2);
				self.blurred = true;
			}
		}

		else
		{
			if(self.blurred)
			{
				self setClientDvar("r_blur", 0);
				self.blurred = false;
			}
		}

		wait 0.1;
	}

	if(self.blurred)
		self setClientDvar("r_blur", 0);

	self.water   = undefined;
	self.blurred = undefined;
}

eye()
{
	eye = self.origin + (0, 0, 60);

	if(self getStance() == "crouch")
		eye -= (0, 0, 20);

	else if(self getStance() == "prone")
		eye -= (0, 0, 49);

	return eye;
}

onConnectedPlayer()
{
	for(;;)
	{
		level waittill("connected", p);

		p thread onSpawnPlayer();
	}
}

onSpawnPlayer()
{
	self endon("disconnect");

	for(;;)
	{
		self waittill("spawned_player");

		if(!isDefined(self.connectionTime))
		{
			self.connectionTime = emz\_globallogic::getTimePassed();
			break;
		}
	}
}

finish()
{
	for(;;)
	{
		self waittill("trigger", p);

		if(!isDefined(p.finished))
		{
			p.finished = true;

			t = (emz\_globallogic::getTimePassed() - p.connectionTime)/1000;

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

			iPrintLn(p.name + "^7 finished in " + getNextPlaceUp() + " place, in " + temp + ":" + t[2] + "" + t[3]);
		}
	}
}

getNextPlaceUp()
{
	level.nextPlaceUp++;

	place = level.nextPlaceUp + "st";
	str = "";

	num1 = int(getSubStr(place, 0, 1));
	num2 = int(getSubStr(place, 1, 2));

	if(place == "1st" || (num2 == 1 && place != "11st"))
		str = "st";

	else if(num1 != 1 && (place == "2st" || num2 == 2))
		str = "nd";

	else if(num1 != 1 && (place == "3st" || num2 == 3))
		str = "rd";

	else str = "th";

	return (level.nextPlaceUp + str);
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