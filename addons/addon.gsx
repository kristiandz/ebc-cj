#include codjumper\_cj_utility;

init()
{
	thread addons\_spectator::init();
}

adminTools()
{
	self notify("endadminplugins");
	self thread _AdminPickup();
	self thread _UFOMode();
}

_AdminPickup()
{
	self endon("disconnect");
	self endon("endadminplugins");
	
	while(1)
	{
		while(!self secondaryOffhandButtonPressed())
			wait 0.05;
			
		start = self getEye();
		end = start + maps\mp\_utility::vector_scale(anglestoforward(self getPlayerAngles()), 999999);
		trace = bulletTrace(start, end, true, self);
		dist = distance(start, trace["position"]);
		ent = trace["entity"];
		if(isDefined(ent) && ent.classname == "player")
		{
			if(isPlayer(ent)) ent IPrintLn("You've been picked up by " + self.name + "!");
			self IPrintLn("You've picked up " + ent.name + "!");
			linker = spawn("script_origin", trace["position"]);
			ent linkTo(linker);
			
			while(self secondaryOffhandButtonPressed())
				wait 0.05;
				
			while(!self secondaryOffhandButtonPressed() && isDefined(ent))
			{
				start = self getEye();
				end = start + maps\mp\_utility::vector_scale(anglestoforward(self getPlayerAngles()), dist);
				trace = bulletTrace(start, end, false, ent);
				dist = distance(start, trace["position"]);
				if(self fragButtonPressed() && !self adsButtonPressed()) dist -= 15;
				else if(self fragButtonPressed() && self adsButtonPressed()) dist += 15;
				end = start + maps\mp\_utility::vector_Scale(anglestoforward(self getPlayerAngles()), dist);
				trace = bulletTrace(start, end, false, ent);
				linker.origin = trace["position"];
				wait 0.05;
			}
			
			if(isDefined(ent))
			{
				ent unlink();
				if(isPlayer(ent)) ent IPrintLn("You've been dropped by " + self.name + "!");
				self IPrintLn("You've dropped " + ent.name + "!");
			}
			linker delete();
		}
		while(self secondaryOffhandButtonPressed())
			wait 0.05;
	}
}
_UFOMode()
{
	self endon("disconnect");
	self endon("endadminplugins");
	self.isUFO = false;
	self.nocliplinker = "";
	self.endUFO = false;
	while(1)
	{
		if (self FragButtonPressed() && self useButtonPressed()  && self.cj["team"] != "spectator" && !self.isUFO)
		{
			while (self FragButtonPressed() || self useButtonPressed())
				wait 0.05;
			self.isUFO = true;
			self.UFOlinker = spawn( "script_model", self.origin );
			self linkto( self.UFOlinker );			
			self IPrintLn("UFO mode enabled!");
			self IPrintLn("Sprint to move faster, ADS for slower, ADS and Press grenade to teleport to crosshairs!");
			self IPrintLn("Frag + Use again to disable, or fire weapon to disable!");
		}

		while(self.isUFO)
		{
			self.speed = 100;
			
			if (self sprintbuttonpressed())
				self.speed = 200;
			else if (self isinads())
				self.speed = 50;
			else 
				self.speed = 100;
			
			if (self forwardbuttonpressed())
				self.UFOlinker moveto(self.origin +  maps\mp\_utility::vector_scale(anglestoforward(self getPlayerAngles()), self.speed), 0.05);
			if ( self backbuttonpressed() )
				self.UFOlinker moveto(self.origin -  maps\mp\_utility::vector_scale(anglestoforward(self getPlayerAngles()), self.speed), 0.05);
			
			if (self isinads() && self FragButtonPressed())
			{
					start = self getEye();
					end = start + maps\mp\_utility::vector_scale(anglestoforward(self getPlayerAngles()), 999999);
					trace = bulletTrace(start, end, true, self);
					dist = distance(start, trace["position"]);
					end_pos = trace["position"];
					self.UFOlinker moveto((end_pos[0], end_pos[1], end_pos[2]+30), 0.05);	
			}
			
			if (self attackbuttonpressed())
				self.endUFO = true;
			
			if ((self FragButtonPressed() && self useButtonPressed()) || self.endUFO)
			{
				while (self FragButtonPressed() || self useButtonPressed())
					wait 0.05;			
				if(isdefined(self.UFOlinker)) self.UFOlinker delete();
					self unlink();
					self.isUFO = false;
					self IPrintLn("UFO mode disabled!");
					self.endUFO = false;
			}
			wait 0.05;
		}
		wait 0.03;
	}
}