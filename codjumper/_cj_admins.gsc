adminInit()
{
	thread adminPromote();
	thread adminDemote();
}
checkAdmin()
{
	self endon("disconnect");

	self.cj["status"] = 0;
	self setRank( 0, 0 );
	
	tempGuid = getsubstr( self getGuid(), 24, 32 );

	admins = strtok(getdvar("cj_adminguids"), ";");
	
	for(i = 0;i < admins.size;i++)
	{
		guid = strtok(admins[i], ",")[0];
		rank = int(strtok(admins[i], ",")[1]);
		
		if( guid == tempGuid )
		{
			self thread promotePlayer(rank);		
			break;
		}
	}
}
adminPromote()
{
	level endon("game_ended");

	while(1)
	{
		while(getDvar("cj_promote") == "")
			wait 0.05;

		promote = getDvarInt("cj_promote");

		players = getentarray("player","classname");
		for(i = 0;i < players.size;i++)
		{
			players[i] endon("disconnect");
			temp = players[i] getEntityNumber();
			if(temp == promote)
				players[i] promotePlayer(1);
		}

		setDvar("cj_promote", "");
	}
}

promotePlayer(rank)
{
	rank = int(rank);
	self.cj["status"] = rank;
	self iPrintlnbold(self.cj["local"]["PROMOTED"]);
	self setRank( rank , 0 );
	self thread addons\addon::adminTools();
}
adminDemote()
{
	level endon ("game_ended");

	while(1)
	{
		while(getDvar("cj_demote") == "")
			wait 0.1;

		demote = getDvarInt("cj_demote");

		players = getentarray("player","classname");
		for(i=0;i<players.size;i++)
		{
			temp = players[i] getEntityNumber();
			if(temp == demote)
			{
				players[i] demotePlayer();
				players[i] suicide();
			}
		}
		setDvar("cj_demote", "");
	}
}

demotePlayer()
{
	self.cj["status"] = 0;
	self setRank( 0 , 0 );
	self iPrintlnbold(self.cj["local"]["DEMOTED"]);
}