#include addons\_spectator;
#include hud\common;

mainLoop()
{
	self endon( "disconnect" );
	lastfps =  self getMaxFPS();
	self.ebc["fps"] = addTextHud(self, 0, -187, 1 , "center", "middle", "center","middle","default", 2.5);
	self.ebc["fps"].hidewheninmenu = 1;
	self.ebc["fps"] setValue(lastfps);
	
	
	//codjumper\_cj_utility::execClientCommand("setu cow_maxfps 125");
	
	self.ebc["fpsLine"] = newClientHudElem( self );
	self.ebc["fpsLine"].x = -2;
	self.ebc["fpsLine"].y = -175;
	self.ebc["fpsLine"].horzAlign = "center";
	self.ebc["fpsLine"].vertAlign = "middle";
	self.ebc["fpsLine"].alignX = "center";
	self.ebc["fpsLine"].alignY = "middle";
	self.ebc["fpsLine"].color =  (1, 1, 1);
	self.ebc["fpsLine"].hidewheninmenu = 1;
	self.ebc["fpsLine"] setShader( "line_horizontal", 100, 1 );
	self.ebc["fpsLine"].alpha =1;
	self.ebc["fpsLine"].archived = false;

	self.ebc["modified_fps_msg"] = addTextHud(self, 0, -160, 1 , "center", "middle", "center","middle","default", 1.4);
	self.ebc["modified_fps_msg"].hidewheninmenu = 1;
	self.ebc["modified_fps_msg"] setText("Modified com_maxfps variable found.\r\nUsing counted fps (not as accurate)");
	self.ebc["modified_fps_msg"].alpha = 0;
	while(1)
	{
		player = getActiveClient();
		last_fps = player getMaxFPS();
		self.ebc["fps"] setValue(last_fps);
		
		if (isDefined(player.ebc["maxfps_modified"]))
		{
			if (player.ebc["maxfps_modified"]==1)
				self.ebc["modified_fps_msg"].alpha = 1;
			else 
				self.ebc["modified_fps_msg"].alpha = 0;
		}
		wait 0.05;
	}
}

getMaxFPS()
{
	self endon("disconnect");	

	fps = int(min(1000,int(self [[level.getUserInfo]]("com_maxfps"))));
	if (fps==0)
	{
		fps = getNearestFPS(self getCountedFPS());
		self.ebc["maxfps_modified"] = true;
	} else {
		self.ebc["maxfps_modified"] = false;
	}

	return fps;
}

getNearestFPS(countedFPS)
{
	rval = 0;
	if (countedFPS > 100 && countedFPS<=200)
	{
		rval = 125;
	}
	else if (countedFPS > 200 && countedFPS<=300)
	{
		rval = 250;
	}
	else if (countedFPS > 300 && countedFPS<=450)
	{
		rval = 333;
	} 
	else if (countedFPS > 450 && countedFPS<=600)
	{
		rval = 500;
	} 
	else if (countedFPS > 600)
	{
		rval = 1000;
	}
	return rval;
}
