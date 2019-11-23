#include addons\_spectator;

 getActiveClient()
 {
	 	if (self.sessionstate == "spectator" && isDefined(self.spectatedPlayers))
		{
			self.isSpectating = true;
			player = self getSpectatedPlayer();
		} else {
			player = self;
			self.isSpectating = false;
		}
		return player;
 }

addTextHud( who, x, y, alpha, alignX, alignY, horiz, vert, font, fontScale) 
{
	if( isPlayer( who ) )
		hud = newClientHudElem( who );
	else
		hud = newHudElem();
	hud.elemType = "font";
	hud.font = font;
	hud.x = x;
	hud.y = y;
	hud.alpha = alpha;
	hud.height = int(level.fontHeight * fontScale);
	
	//hud.sort = sort;
	hud.alignX = alignX;
	hud.alignY = alignY;
	if(isdefined(vert))
		hud.vertAlign = vert;
	if(isdefined(horiz))
		hud.horzAlign = horiz;
	if(fontScale != 0)
		hud.fontScale = fontScale;
	hud.foreground = 1;
	hud.archived = 0;
	return hud;
}

