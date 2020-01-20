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
	self.ebc["speedHUD"].archived = false;
    
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
	 self.ebc["speedMHUD"].archived = false;
	
	self.ebc["speedLine"] = newClientHudElem( self );
	self.ebc["speedLine"].x = -6;
	self.ebc["speedLine"].y = 222;
	self.ebc["speedLine"].horzAlign = "center";
	self.ebc["speedLine"].vertAlign = "middle";
	self.ebc["speedLine"].alignX = "center";
	self.ebc["speedLine"].alignY = "middle";
	self.ebc["speedLine"].color =  (1, 1, 1);
	self.ebc["speedLine"].hidewheninmenu = 1;
	self.ebc["speedLine"] setShader( "line_horizontal", 135, 2 );
	self.ebc["speedLine"].alpha =1;
	self.ebc["speedLine"].archived = false;
		
	player = self;
   while(1)
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