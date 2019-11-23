#include codjumper\_cj_utility;

savePos(i)
{		
	if (isDefined(self.cj["custom_save"]) && self.cj["custom_save"]==0)
	{
		if (self.cj["saves"] == 0)
			self.cj["saves"]  = 1;
		self.cj["saves"]++; //Ignore i so we don't need to modify too much and just use a local variable here.
		i=self.cj["saves"];
	} else {
		self.cj["custom_save"]=0;
	}

	if( !self isOnGround() || self isOnLadder() || self isMantling() || !isAlive( self ) )
		return;
		
	if(level._cj_nosave)
	{
		self iPrintln(self.cj["local"]["NOSAVE"], getDvar("mapname"));
		return;
	}
	if(self codjumper\_cj_mappers::CheckSaveZones())
	{
		self iPrintln(self.cj["local"]["NOSAVEZONE"]);
		return;
	}
	wait 0.05;
	self.cj["save"]["org"+i] = self getOrigin();
	self.cj["save"]["ang"+i] = self getPlayerAngles();
	temp = self GetStat(2992);
	self SetStat(2992, temp + 1);
	self iPrintLn(self.cj["local"]["SAVED"], i);
	self positionLog();
}

loadPos(i)
{
	if (i==1)  
	{
		if ((isDefined(self.cj["custom_load"]) && self.cj["custom_load"]==0) || !isDefined(self.cj["custom_load"]))
			i=self.cj["saves"];
		else
			self.cj["custom_load"]= 0;
	}		
	if(!isDefined(self.cj["save"]["org" + i]))
		self iPrintLn(self.cj["local"]["NOPOS"], i);
	else
	{
		self freezeControls( true );
		wait 0.05;
		self setOrigin(self.cj["save"]["org"+i]);
		self setPlayerAngles(self.cj["save"]["ang"+i]);
		self iPrintLn(self.cj["local"]["POSLOAD"], i);
		self.cj["loads"]++;
		temp = self GetStat(2993);
		self SetStat(2993, temp + 1);
		self.ebc["speedMHUD"] setValue(int(0));
		self.ebc["max_speed"] = int(0);
		self.cj["custom_load"]= 0;
	}
	self freezeControls( false );
	self giveMaxRPGAmmo();
}

positionLog()
{
	for(i = 20;i >= 0;i--)
		if( isDefined( self.cj["positionLog"][i] ) )
			self.cj["positionLog"][i+1] = self.cj["positionLog"][i];
			
	self.cj["positionLog"][0] = SpawnStruct();
	self.cj["positionLog"][0].origin = self getOrigin();
	self.cj["positionLog"][0].angles = self getPlayerAngles();
}

loadLoggedPosition(num)
{
	if( isDefined( self.cj["positionLog"][num] ) )
	{
		self setOrigin( self.cj["positionLog"][num].origin );
		self setPlayerAngles( self.cj["positionLog"][num].angles );
		self.cj["loads"]++;
		self giveMaxRPGAmmo();
	}
}