#include addons\_spectator;
#include hud\common;
mainLoop()
{
	self endon( "disconnect" );
	lastfps =  self getMaxFPS();
	self.fps = addTextHud(self, 0, -187, 1 , "center", "middle", "center","middle","default", 2.5);
	self.fps.hidewheninmenu = 1;
	self.fps setValue(lastfps);
	
	
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

		
	while(1)
	{
		player = getActiveClient();
		last_fps = player getMaxFPS();
		self.fps setValue(last_fps);
		wait 0.05;
	}
}

getMaxFPS()
{
	self endon("disconnect");	
	return int(min(1000,int(self [[level.getUserInfo]]("com_maxfps"))));
}
