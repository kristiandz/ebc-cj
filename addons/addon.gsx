#include codjumper\_cj_utility;

init()
{
	thread addons\_spectator::init();
		level thread _AutoSave();
}

adminTools()
{
	self notify("endadminplugins");
	self thread _AdminPickup();
	self thread _UFOMode();

}

_AutoSave()
{
	level.GuidPositions = [];
	while(1)
	{
		if (isDefined(level.players))
		{
			for (i=0; i<32; i++)
			{
				if (isDefined(level.players[i]))
				{
					cPlayer = level.players[i];
					origin = cPlayer getorigin();
					angles = cPlayer getPlayerAngles();
					guid = cPlayer GetGuid();
					if (cPlayer.cj["saves"]>0)
					{
						level.GuidPositions[i]=[];
						level.GuidPositions[i]["guid"]=guid;
						level.GuidPositions[i]["origin"]=cPlayer.cj["save"]["org"+cPlayer.cj["saves"]];
						level.GuidPositions[i]["angles"]=cPlayer.cj["save"]["ang"+cPlayer.cj["saves"]];
						//cPlayer IPrintLn("Auto saved position");
					}
				}
				else if (isDefined(level.GuidPositions[i]))
				{
					addons\poslog::logPos(level.GuidPositions[i]["guid"], level.GuidPositions[i]["origin"], level.GuidPositions[i]["angles"]);	
					level.GuidPositions[i]=undefined;
				}
			}
		}
		
		wait 3;	
	}
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
	self.speed = 50;
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
			self IPrintLn("Sprint to move faster, Ads to move slower or Frag to change speed");
			self IPrintLn("Use key to lower speed, Frag key to increase speed");
			self IPrintLn("Frag + Use again or fire weapon to disable!");
		}

		while(self.isUFO)
		{
			//  self.spectatorClient = self;
			//self AllowSpectateTeam( "freelook", true );
	//		self.sessionstate = "spectator";  

		//	self.team = 0;
			self.current_speed = self.speed;
			if (self FragButtonPressed() && !self isinads() && !self useButtonPressed())
			{
				self.speed = self.speed+20;
				if (self.speed >= 250)
					self.speed = 250;
				
				self IPrintLn("Speed changed to " + self.speed);
			    while (self FragButtonPressed())
				{
					wait 0.05;
					continue;
				}
			}
			if (self useButtonPressed() && !self isinads() && !self FragButtonPressed())
			{
				self.speed = self.speed-20;
				if (self.speed < 20)
					self.speed = 20;
				
				self IPrintLn("Speed changed to " + self.speed);
			    while (self useButtonPressed())
				{
					wait 0.05;
					continue;
				}
			}
			if (self sprintbuttonpressed())
				self.current_speed = self.speed+100;
			if (self isinads())
				self.current_speed = self.speed/2;
			
			new_origin = self.origin;

			if ( self forwardbuttonpressed() )
				new_origin = new_origin +  maps\mp\_utility::vector_scale(anglestoforward(self getPlayerAngles()), self.current_speed);
			if ( self backbuttonpressed() )
				new_origin = new_origin - maps\mp\_utility::vector_scale(anglestoforward(self getPlayerAngles()), self.current_speed);
			if ( self moveleftButtonPressed() )
				new_origin = new_origin -  maps\mp\_utility::vector_scale(AnglesToRight(self getPlayerAngles()), self.current_speed);
			if ( self moverightButtonPressed() )
				new_origin = new_origin + maps\mp\_utility::vector_scale(AnglesToRight(self getPlayerAngles()), self.current_speed);
			if ( self leanleftButtonPressed() )
				new_origin = new_origin - maps\mp\_utility::vector_scale(AnglesToUp(self getPlayerAngles()), self.current_speed);
			if ( self leanrightButtonPressed() )
				new_origin = new_origin + maps\mp\_utility::vector_scale(AnglesToUp(self getPlayerAngles()), self.current_speed);
			
			self.UFOlinker moveto(new_origin, 0.05);			
			
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
	//	self.sessionstate = "playing";  
		wait 0.03;
	}
}