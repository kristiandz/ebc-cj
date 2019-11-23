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
				if (!isDefined(args[0]))
				{
					self iprintLn("Usage: $load <save number>");
				} else {
					load_position(self, int(args[0]));
				}
				break;
			}
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
			}
		}
	}
}

load_position(entity, save_num)
{
	entity.cj["custom_load"] = 1;
	entity codjumper\_cj_functions::loadPos(save_num);
}