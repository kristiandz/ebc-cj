initCommands()
{
}
  
getPlayerFromClientNum(clientNum)
{
	if (clientNum < 0) return undefined;
	for (i = 0; i < level.players.size; i++)
	{
		if (level.players[i] getEntityNumber() == clientNum) return level.players[i];
	}
	return undefined;
}


Callback_ScriptCommandPlayer(command, args)
{
	switch(command)
	{
		case "load":
		{
			args = strTok(args, " ");
			for(i = 0; i < args.size; i++){args[i] = int(args[i]);}
			if(args[0] < 0 || args[0] > 9999)
			{
				iprintLn("The position number is not valid");
			}
			else if (!isDefined(args[0]))
			{
				self iprintLn("Usage: $load <save number>");
			} 
			else 
			{
				load_position(self, args[0]);
			}			
		}
		break;
		case "save":
		{
			args = strTok(args, " ");
			for(i = 0; i < args.size; i++){args[i] = int(args[i]);}
			if(args[0] < 0 || args[0] > 9999)
			{
				iprintLn("The position number is not valid");
			}
			else if (!isDefined(args[0]))
			{
				self iprintLn("Usage: $save <save number>");
			} 
			else 
			{
				save_position(self, args[0]);
			}
		}
		break;
		case "film":
		{
			temp = self GetStat(2202);
			if(temp == 0)
			{
				self SetClientDvar("r_filmusetweaks",1);
				self iprintLn("You have enabled ^1filmtweaks");
				self SetStat(2202,1);
			}
			else if( temp == 1)
			{
				self SetClientDvar("r_filmusetweaks",0);
				self iprintLn("You have disabled ^1filmtweaks");
				self setStat(2202,0);
			}
		}
		break;
		case "fps":
		case "fov":
		{
			self openMenu("cj_graphics");
		}
		break;
	}
}

Callback_ScriptCommand(command, arguments)
{
	//iPrintLn("Rcon Command: ", command, " Arguments: ",arguments);
	switch(command) 
    {
		case "cmd": //The command is cmd which means it is coming from B3 bot -- example b3 bot for load should send to rcon, cmd load:[ClientNum] [SaveNumber]   so arguments are space delimited.
		{
			localcmd = strTok(arguments, ":")[0];
			args = strTok(strTok(arguments, ":")[1], " ");
			switch(localcmd)
			{
				case "load":
				{
					player = getPlayerFromClientNum(int(args[0]));
					if (!isDefined(player))
						break;
					load_position(player, int(args[1]));
				}
				break;
				
				case "save":
				{
					player = getPlayerFromClientNum(int(args[0]));
					if (!isDefined(player))
						break;
					save_position(player, int(args[1]));
				}
				break;
				
				case "film":
				{
					player = getPlayerFromClientNum(int(args[0]));
					if (!isDefined(player))
						break;
					temp = player GetStat(2202);
					if(temp == 0)
					{
						player SetClientDvar("r_filmusetweaks",1);
						player iprintLn("You have enabled ^1filmtweaks");
						player SetStat(2202,1);
					}
					else if( temp == 1)
					{
						player SetClientDvar("r_filmusetweaks",0);
						player iprintLn("You have disabled ^1filmtweaks");
						player setStat(2202,0);
					}
				}
				break;
				
				case "fps":
				case "fov":
				{
					player = getPlayerFromClientNum(int(args[0]));
					if (!isDefined(player))
						break;
					player openMenu("cj_graphics");
				}
				break;
			}
		}
	}
}

load_position(entity, save_num)
{
	entity.cj["custom_load"] = 1;
	entity codjumper\_cj_functions::loadPos(save_num);
}

save_position(entity, save_num)
{
	entity.cj["custom_save"] = 1;
	entity codjumper\_cj_functions::savePos(save_num);
}