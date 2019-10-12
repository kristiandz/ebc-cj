/*******************************************************************************************\
   TODO:
   -Spectator only / Always / Off code. Use addons/spectator for this ?
   -Reposition and add toggle switch, move to menus ? 
\*******************************************************************************************/

main()
{
    level thread waitforconnect();
}
 
waitforconnect()
{
	self endon("disconnect");	
	level waittill("connecting", player);
	player waittill("joined_spectators"); //wait until you join spectators for the first time to worry about doing anything
	player thread initShaders(); //initialize the shaders

    while(true)
    {
		player thread monitorKeys(); //monitor keys and update alpha
		player waittill("joined_team"); //when you join a team turn the key shaders off
		player thread resetKeys(); //turn the shaders off
		player waittill("joined_spectators"); //wait until you spectate again

    }
}
 
 initShaders()
 {
	 x = 200;
	 y = 125;
	 
	self.forward = createnewkey(x, y, "forward_pressed", 20, 20);
	self.back = createnewkey(x, y+22, "back_pressed", 20, 20);
	self.left = createnewkey(x-22, y+22, "left_pressed", 20, 20);
	self.right = createnewkey(x+22, y+22, "right_pressed", 20, 20);
	self.jump = createnewkey(x, y+44, "jump_pressed", 80, 20);
 }
 
resetKeys()
{
		self.forward.alpha = 0;
		self.back.alpha = 0;
		self.left.alpha = 0;
		self.right.alpha = 0;
		self.jump.alpha = 0;
}
 monitorKeys()
{		
    self endon("disconnect");	
	self endon("joined_team");
			
    while(true)
    {
		self.forward.alpha = 0.2 + 0.8 * (self forwardButtonPressed());
		self.back.alpha = 0.2 + 0.8 * (self backButtonPressed());
		self.left.alpha = 0.2 + 0.8 * (self moveLeftButtonPressed());
		self.right.alpha = 0.2 + 0.8 * (self moveRightButtonPressed());
		self.jump.alpha = 0.2 + 0.8 * (self jumpButtonPressed());
		wait 0.05;
	}
}
 
createnewkey(x, y, shader, shaderx, shadery)
{
    hud = newclienthudelem(self);
    hud.horzalign = "left";
    hud.vertalign = "middle";
    hud.alignx = "center";
    hud.aligny = "middle";
    hud.alpha = 0;
	hud.x = x;
	hud.y = y;
    hud.archived = true;
    hud setshader(shader, shaderx, shadery);
    return hud;
}