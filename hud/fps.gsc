#include addons\_spectator;
#include hud\common;
mainLoop()
{
	self endon( "disconnect" );
	lastfps =  self getMaxFPS();
	self.fps = addTextHud(self, 0, -187, 1 , "center", "middle", "center","middle",2.5,0);
	self.fps.hidewheninmenu = 1;
	self.fps setValue(lastfps);
	
	
	self.cj["hud"]["info"]["line"] = newClientHudElem( self );
	self.cj["hud"]["info"]["line"].x = -2;
	self.cj["hud"]["info"]["line"].y = -175;
	self.cj["hud"]["info"]["line"].horzAlign = "center";
	self.cj["hud"]["info"]["line"].vertAlign = "middle";
	self.cj["hud"]["info"]["line"].alignX = "center";
	self.cj["hud"]["info"]["line"].alignY = "middle";
	self.cj["hud"]["info"]["line"].color =  (1, 1, 1);
	self.cj["hud"]["info"]["line"].hidewheninmenu = 1;
	self.cj["hud"]["info"]["line"] setShader( "line_horizontal", 100, 1 );
	self.cj["hud"]["info"]["line"].alpha =1;

		
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
