#include maps\mp\gametypes\_hud_util;
#include hud\common;
 mainLoop()
{		
	
	self endon("disconnect");
	
	//1 = specate only
	//2 = always
	//3 = disabled
	x = 200;
	 y = 125;
	 
	self.forward = createnewkey(x, y, "forward_pressed", 20, 20);
	self.back = createnewkey(x, y+22, "back_pressed", 20, 20);
	self.left = createnewkey(x-22, y+22, "left_pressed", 20, 20);
	self.right = createnewkey(x+22, y+22, "right_pressed", 20, 20);
	self.jump = createnewkey(x, y+44, "jump_pressed", 80, 20);
	self.wasdSetting = 1225;
	self.drawKeys = false;
	self.isSpectating = false;
	player = self;
    while(true)
    {					
		self.stat = self GetStat(self.wasdSetting);
		player = getActiveClient();

		if (self.stat == 1 && self.isSpectating) //spectate only
				self.drawKeys = true;		
		else if (self.stat == 2)  //always draw
				self.drawKeys = true;
		else if (self.stat == 3)  //disabled
				self.drawKeys = false;
		else 
				self.drawKeys = false;
			
		if (self.drawKeys)			
		{
			self.forward.alpha = 0.2 + 0.8 * (player forwardButtonPressed());
			self.back.alpha = 0.2 + 0.8 * (player backButtonPressed());
			self.left.alpha = 0.2 + 0.8 * (player moveLeftButtonPressed());
			self.right.alpha = 0.2 + 0.8 * (player moveRightButtonPressed());
			self.jump.alpha = 0.2 + 0.8 * (player jumpButtonPressed());
		} 
		else 
		{
			self.forward.alpha = 0;
			self.back.alpha = 0;
			self.left.alpha = 0;
			self.right.alpha = 0;
			self.jump.alpha = 0;
		}
		self.drawKeys = false;
		wait 0.05;
	}
	
}
 
createnewkey(x, y, shader, shaderx, shadery)
{
	hud = createIcon(shader, shaderx, shadery);
    hud.horzalign = "left";
    hud.vertalign = "middle";
    hud.alignx = "center";
    hud.aligny = "middle";
    hud.alpha = 0;
	hud.x = x;
	hud.y = y;
    hud.archived = false;
    return hud;
}