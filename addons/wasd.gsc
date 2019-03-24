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
    while(true)
    {
        level waittill("connecting", player);
        player thread onconnect();
    }
}
 
onconnect()
{		
    forward = createnewkey(0, 125, "forward_pressed", 20, 20);
    back = createnewkey(0, 147, "back_pressed", 20, 20);
    left = createnewkey(-22, 147, "left_pressed", 20, 20);
    right = createnewkey(22, 147, "right_pressed", 20, 20);
    jump = createnewkey(0, 169, "jump_pressed", 80, 20);
	
    while(isdefined(self))
    {
        if(isdefined(self.sessionstate) && self.sessionstate == "playing" && self GetStat(1225) == 1 )
        {
            //forward.alpha = 0.2 + 0.8 * (self forwardbuttonpressed());
            //back.alpha = 0.2 + 0.8 * (self backbuttonpressed());
            //left.alpha = 0.2 + 0.8 * (self moveleftbuttonpressed());
            //right.alpha = 0.2 + 0.8 * (self moverightbuttonpressed());
            //jump.alpha = 0.2 + 0.8 * (self jumpbuttonpressed());
        }
        else
        {
            forward.alpha = 0;
            back.alpha = 0;
            left.alpha = 0;
            right.alpha = 0;
            jump.alpha = 0;
        }
        wait 0.05;
    }
}
 
createnewkey(x, y, shader, shaderx, shadery)
{
    hud = newclienthudelem(self);
    hud.horzalign = "center";
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