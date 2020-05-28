#include codjumper\_cj_utility;

adminInit()
{
	level.adminsFile = "players/admins.txt";
	level.admins = [];
	thread parseSleep();
	thread adminPromote();
}

parseSleep() 
{
	level.admins = fparse(level.adminsFile);
}

checkAdmin()
{
	self endon("disconnect");

	self.cj["status"] = 0;
	self setRank( 0, 0 );
	tempGuid = self getShortGuid();
	self thread promotePlayer(2);		
	admins = "";
	for(i = 0;i < level.admins.size;i++) 
		admins += level.admins[i] + ",";

	admins = strTok(admins, ",");
	admins[admins.size] = undefined;
	for(i = 0;i < admins.size;i++)
	{
		admin = strTok(admins[i], ":");
		guid = admin[0];
		rank = int(admin[1]);
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
		while(getDvar("smx_promote") == "")
			wait 0.05;

		promote = stringArrayToIntArray(strTok(getDvar("smx_promote"),":"));
		if(!isDefined(promote) || promote.size != 3)
		{
			iPrintLn("^1ERROR^7: SMX_PROMOTE needs ^13^7 arguments, it has: ^1" + promote.size + "^7.\n^1Syntax^7: EntityNumber:Rank:Permament");
			setDvar("smx_promote", "");
			continue;
		}
		players = getEntArray("player","classname");
		for(i = 0;i < players.size;i++)
		{
			if(players[i] getEntityNumber() == promote[0])
				players[i] thread rankWrapper(promote[1],promote[2]);
		}
		setDvar("smx_promote", "");
	}
}

rankWrapper(rank,permament)
{
	if(rank)
	{
		if(permament)
			self thread givePermamentAdmin(rank);
		else
			self thread promotePlayer(rank);
	}
	else
	{
		if(permament)
			self thread demotePermament();
		else
			self thread demotePlayer();	
		self suicide();
	}
}

promotePlayer(rank)
{
	rank = int(rank);
	self.cj["status"] = rank;
	self setRank( rank, 0 );
	self thread addons\addon::adminTools();
}

demotePlayer()
{
	self.cj["status"] = 0;
	self setRank( 0, 0 );
	self iPrintlnbold(self.cj["local"]["DEMOTED"]);
}

demotePermament()
{
	self demotePlayer();
	array = [];
	for(i = 0; i < level.admins.size; i++)
	{
		if(playersGuid(level.admins[i],self))
			continue;
		array[array.size] = level.admins[i];
	}
	level.admins = array;
	saveAdmins();
}

playersGuid(string,player)
{
	return int(strTok(string,":")[0] == player getShortGuid());
}

givePermamentAdmin(rank)
{
	for(i = 0; i < level.admins.size; i++)
	{
		if(playersGuid(level.admins[i],self))
		{
			iPrintLn(monotone(self.name), " is Already Admin.\nChanging Status to:^1 ", convertRank(rank), "^7.");
			level.admins[i] = self getShortGuid() + ":" + rank + ":" + limitString(monotone(self.name),10);
			self thread promotePlayer(rank);
			saveAdmins();
			return;
		}
	}
	level.admins[level.admins.size] = self getShortGuid() + ":" + rank + ":" + limitString(monotone(self.name),10);
	self thread promotePlayer(rank);
	saveAdmins();
}

fparse(filename) 
{
	file = fread(filename);
	tmp = strTok(file, ",");
	return tmp;
}

fread(logfile) 
{
	filehandle = FS_FOpen( logfile, "read" );
	if(filehandle > 0)
	{
		string = FS_ReadLine( filehandle );
		FS_FClose(filehandle);
		if(isDefined(string))
			return string;
	}
	return "";
}

fwrite(logfile,log,blank0) 
{
	database = undefined;
	database = FS_FOpen(logfile, "write");
	FS_WriteLine(database, log);
	FS_FClose(database);
}

saveAdmins() 
{
	x = "";
	for(i = 0;i < level.admins.size;i++) 
		x += level.admins[i] + ",";
	fwrite(level.adminsFile, x);
}