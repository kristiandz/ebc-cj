main()
{
	level.modelcost[0]=1000;
	level.modelcost[1]=2000;
	level.modelcost[2]=3500;
	level.modelcost[3]=5000;
	level.modelcost[4]=6000;

	level.shopmodel[1][0]="body_complete_mp_price_woodland";
	level.shopmodel[1][1]="Captain Price";
	level.shopmodel[2][0]="body_makarov";
	level.shopmodel[2][1]="Makarov";
	level.shopmodel[3][0]="body_shepherd";
	level.shopmodel[3][1]="Shepherd";
	level.shopmodel[4][0]="playermodel_dnf_duke";
	level.shopmodel[4][1]="Duke Nukem";
	level.shopmodel[5][0]="playermodel_fifty_cent";
	level.shopmodel[5][1]="50 Cent";
}

spawnPlayer()
{
    self endon( "disconnect" );
    self endon( "spawned_player" );
    self endon( "joined_spectators" );
	self endon( "death" );

	self.oldorigin = self.origin;
	self.oldangles = self.angles;

	for(;;)
	{
		if(self.oldorigin!=self.origin && self.oldangles!=self.angles)
		{
			self.pers["points"]++;
			self setClientDvar("points",self.pers["points"]);
			self setStat(2561,self.pers["points"]);
		}
		self thread check();
		self.oldangles=self.angles; 
		self.oldorigin=self.origin;
		wait 5;
	}
}
connect()
{
	self.pers["points"] = int(self getStat(2561));
	self setClientDvars("showpoints",1,
	"shop0","Captain Price - 1000$",
	"shop1","Makarov - 2000$",
	"shop2","Shepherd - 3500$",
	"shop3","Duke Nukem - 5000$",
	"shop4","50 Cent - 6000$");
}
check()
{
	for(i=0;i<5;i++)
	{
		if(self getStat(110+i)==1 && self getStat(1169)==(i+1)) 
			self setClientDvar("shop"+i+"action","^1Activated");
		else if(self getStat(110+i)==1 && self getStat(1169)!=(i+1)) 
			self setClientDvar("shop"+i+"action","^2Activate");
		else if(self.pers["points"]>=level.modelcost[i]) 
			self setClientDvar("shop"+i+"action","Buy");
		else 
			self setClientDvar("shop"+i+"action","Buy");
	} 
}