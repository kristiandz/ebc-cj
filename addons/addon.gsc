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
	
	while(1)
	{
		while(!self FragButtonPressed() || !self useButtonPressed() || self.cj["team"] == "spectator")
			wait 0.05;
			
		if( self.sessionState == "spectator" )
			self.sessionState = "playing";
		else
			self.sessionState = "spectator";

		self.spectatorClient = -1;
			
		while(self FragButtonPressed() && self useButtonPressed())
			wait 0.05;
	}
}