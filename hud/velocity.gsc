#include hud\common;
mainLoop() 
{
    self endon("disconnect");
    
	self.ebc["current_speed"] = 0;
    self.ebc["max_speed"] = 0;
    self.ebc["speed"] = true;
    self.ebc["speedHUD"] = newClientHudElem(self);
    self.ebc["speedHUD"].horzAlign = "center";
    self.ebc["speedHUD"].vertAlign = "middle";
    self.ebc["speedHUD"].alignX = "center";
    self.ebc["speedHUD"].alignY = "bottom";
    self.ebc["speedHUD"].font = "objective";
    self.ebc["speedHUD"].hideWhenInMenu = true;
    self.ebc["speedHUD"].color = (1, 1, 1);
    self.ebc["speedHUD"].fontScale = 1.4;
    self.ebc["speedHUD"].label = &"SPEED ";
    self.ebc["speedHUD"] setValue(self.ebc["current_speed"]);
    self.ebc["speedHUD"].alpha = 1;
    self.ebc["speedHUD"].x = -43;
    self.ebc["speedHUD"].y = 220;
    
    self.ebc["speedMHUD"] = newClientHudElem(self);
    self.ebc["speedMHUD"].horzAlign = "center";
    self.ebc["speedMHUD"].vertAlign = "middle";
    self.ebc["speedMHUD"].alignX = "center";
    self.ebc["speedMHUD"].alignY = "bottom";
    self.ebc["speedMHUD"].font = "objective";
    self.ebc["speedMHUD"].hideWhenInMenu = true;
    self.ebc["speedMHUD"].color = (1, 1, 1);
    self.ebc["speedMHUD"].fontScale = 1.4;
    self.ebc["speedMHUD"].label = &"MAX ";
    self.ebc["speedMHUD"] setValue(self.ebc["max_speed"]);
    self.ebc["speedMHUD"].alpha = 1;
    self.ebc["speedMHUD"].x = 43;
    self.ebc["speedMHUD"].y = 220;
	
	
	
	self.cj["hud"]["info"]["line2"] = newClientHudElem( self );
	self.cj["hud"]["info"]["line2"].x = -6;
	self.cj["hud"]["info"]["line2"].y = 222;
	self.cj["hud"]["info"]["line2"].horzAlign = "center";
	self.cj["hud"]["info"]["line2"].vertAlign = "middle";
	self.cj["hud"]["info"]["line2"].alignX = "center";
	self.cj["hud"]["info"]["line2"].alignY = "middle";
	self.cj["hud"]["info"]["line2"].color =  (1, 1, 1);
	self.cj["hud"]["info"]["line2"].hidewheninmenu = 1;
	self.cj["hud"]["info"]["line2"] setShader( "line_horizontal", 135, 2 );
	self.cj["hud"]["info"]["line2"].alpha =1;
		
		
	player = self;
    for(;;) 
	{
		player = getActiveClient();

        speed = calculateSpeed(player getVelocity());
        
        if(speed > 50000)
            speed = 50000;
        
        if(speed > self.ebc["max_speed"]) 
		{
			self.ebc["max_speed"] = speed;
            self.ebc["speedMHUD"] setValue(speed);
        }
		
        self.ebc["current_speed"] = speed;
        self.ebc["speedHUD"] setValue(speed);
        if(speed > 350 && speed < 700) 
            self.ebc["speedHUD"].color = (0, 1, 0);
        else if(speed > 700 && speed < 1200) 
            self.ebc["speedHUD"].color = (1, 0.4, 0);
        else if(speed > 1200)
            self.ebc["speedHUD"].color = (1, 0, 0);
		else 
			self.ebc["speedHUD"].color = ( 1, 1, 1);
        wait .05;
    }
}
 
calculateSpeed(velocity) 
{
    speed = Int(length((velocity[0], velocity[1], 0)));
    return speed;
}
