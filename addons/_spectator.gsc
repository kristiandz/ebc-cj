#include codjumper\_cj_utility;
#include common_scripts\utility;
#include codjumper\_cod_jumper_utility;

init()
{
    while(1)
    {
        level waittill("joined_spectator", player );
        player thread initNewSpectator();
    }
}

initNewSpectator()
{
    self endon("disconnect");
    self endon("joined_team");

    self.spectatedPlayers = [];
    self.spectatorClientNow = 0;

   // self makeArray();
    //self thread updateArray();
    self thread updateArrayOnDisconnect();
    self updateList();

    self thread checkAttack();
    self thread checkADS();
    self thread checkMelee();
    self.spectatorClient = self getSpectatedPlayerEnt();
}
/*makeArray()
{
    self endon("disconnect");
    self endon("joined_team");
    remove_spec_from_array(self.spectatedPlayers, level.players);
}
remove_spec_from_array( aliveArray, playerArray )
{
    for( i = 0; i < playerArray.size; i ++ )
    {
        if ( !isAlive(playerArray[i]) )
            aliveArray[i] = undefined;
        aliveArray[i] = playerArray[i];
    }
}
updateArray()
{
    self endon("disconnect");
    self endon("joined_team");

    for(;;)
    {
        level waittill_any("connected","joined_team","joined_spectator");
        self makeArray();
        self thread updateList();
    }
}*/
updateArrayOnDisconnect()
{
    self endon("disconnect");

    for(;;)
    {
        level waittill("disconnect", player);
/*        for( i = 0; i < self.spectatedPlayers.size; i ++ )
        {
            if(player == self.spectatedPlayers[i])
            {
            if(i < self.spectatorClientNow)*/
                self.spectatorClientNow = add_and_fix(self.spectatorClientNow, 0);
            //break;
            //}
        //}

        //self makeArray();
    }
}
updateList()
{
    self.spectatorClientNow = add_and_fix(self.spectatorClientNow, 1);
}

checkAttack()
{
    self endon("disconnect");
    self endon("joined_team");

    for (;; wait 0.05)
    {
        if (self attackButtonPressed())
        {
		    self.spectatorClientNow = add_and_fix(self.spectatorClientNow,1);
            self.spectatorClient = self getSpectatedPlayerEnt();
        }
        while (self attackButtonPressed())
        {
            wait 0.05;
            continue;
        }
    }
}

checkADS()
{
    self endon("disconnect");
    self endon("joined_team");

    for (;; wait 0.05)
    {
        if(self adsButtonPressed())
        {
		    self.spectatorClientNow = add_and_fix(self.spectatorClientNow, 0);
        	self.spectatorClient = self getSpectatedPlayerEnt();
        }

        while (self adsButtonPressed())
        {
            wait 0.05;
            continue;
        }
    }
}

checkMelee()
{
    self endon("disconnect");
    self endon("joined_team");

    for (;; wait 0.05)
    {
        if (self meleeButtonPressed())
            self.spectatorClient = -1;

        while (self meleeButtonPressed())
        {
            wait 0.05;
            continue;
        }
    }
}

getSpectatedPlayerEnt()
{
	if(self.spectatorClientNow > -1 && isDefined(level.Players[self.spectatorClientNow]))
        return level.Players[self.spectatorClientNow] getEntityNumber();
	else
		return -1;
}

getSpectatedPlayer()
{
	if (self.spectatorClientNow>-1 && isDefined(level.Players[self.spectatorClientNow]))
		return level.Players[self.spectatorClientNow];
	else
		return self;
}

add_and_fix(num,add)
{
	//if (add) //find next player
	//{
				
		for (i=1; i<=level.players.size+2; i++) //start with 1 because you dont count yourself
		{
			if (add)
			{
				if (num+i>level.players.size)
					num = -1; //reset to base of the array
				if (isAlive(level.players[num+i]))
					return num+i;
			} else {
				if (num-i<0)
					num = level.players.size+1; //reset to top of the array
				if (isAlive(level.players[num-i]))
					return num-i;
			}
		}
		return self.spectatorClientNow;
	/*} else { //find previous player
		num = num - 1;
		if (num<=-1)
			num = level.players.size;
		for (i=1; i<=level.players.size; i++)
		{
			if (isAlive(level.players[i]))
				return i;
		}
		return -1;
	}*/
 }
  /*
checkList(x)
{
    list = self.spectatedPlayers;

    if(x < 0)
        x = list.size-1;

    if(x >= list.size)
        x = 0;

    return x;
}*/