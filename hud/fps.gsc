#include addons\_spectator;
#include hud\common;

mainLoop()
{
	self endon( "disconnect" );
	last_fps =  self getMaxFPS();
	self.ebc["fps"] = addTextHud(self, 0, -187, 1 , "center", "middle", "center","middle","default", 2.5);
	self.ebc["fps"].hidewheninmenu = 1;
	self.ebc["fps"] setValue(last_fps);
	
	
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
	self.ebc["modified_fps_msg"] setText("Modified com_maxfps variable found!");
	self.ebc["modified_fps_msg"].alpha = 0;

	self.ebc["modified_fps_display_time"] = 5000;
	
	self.lastPlayer = self;
	self.messageStart  = gettime();
	while(1)
	{
		player = getActiveClient();
		last_fps = player getMaxFPS();
		self.ebc["fps"] setValue(last_fps);
		self.cj["maxfps"] = last_fps; //Deaths are updated from this variable (FPS in stats window)
		if (self.lastPlayer!=player) 
			self.messageStart  = gettime();

		if (isDefined(player.ebc["maxfps_modified"]))
		{
			if (player.ebc["maxfps_modified"]==1 && gettime()-self.messageStart<self.ebc["modified_fps_display_time"])
				self.ebc["modified_fps_msg"].alpha = 1;
			else
				self.ebc["modified_fps_msg"].alpha = 0;
		}
		self.lastPlayer = player;
		wait 0.05;
	}
}

getMaxFPS()
{
	self endon("disconnect");	

	fps = int(min(1000,int(self [[level.getUserInfo]]("com_maxfps"))));
	if (fps==0)
	{
		fps = 222;
		self.ebc["maxfps_modified"] = true;
	} else {
		self.ebc["maxfps_modified"] = false;
	}

	return fps;
}
