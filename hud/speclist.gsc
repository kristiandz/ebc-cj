#include hud\common;
mainLoop()
{
	self endon( "disconnect" );
	self.specList = addTextHud(self, 0, -187, 1 , "right", "middle", "right","middle",1.5,0);
	self.specList.hidewheninmenu = 1;
	self.specList.label = &"Spectators&&1";
	player = self;
	while(1)
	{
		player = getActiveClient();
		self.spectator_count = 0;
		self.specStr = "";
		for (i = 0; i < level.players.size; i++)
			{
				tmp_spectator = level.players[i];
				if (isDefined(tmp_spectator)) {
					if (tmp_spectator.spectatorClient == player getEntityNumber())
					{
						self.specStr = self.specStr + "\r\n" + tmp_spectator.name;//level.players[i].name;
						self.spectator_count = self.spectator_count+1;
					}
				}
			}
			self.specList SetText(self.specStr);
			if (self.spectator_count==0)
				self.specList.alpha=0;
			else
				self.specList.alpha=1;
	wait 0.5;
	}
}