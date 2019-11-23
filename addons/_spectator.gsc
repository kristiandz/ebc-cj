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

    self makeArray();
    self thread updateArray();
    self thread updateArrayOnDisconnect();
    self updateList();

    self thread checkAttack();
    self thread checkADS();
    self thread checkMelee();
    self.spectatorClient = self getSpectatedPlayerEnt();
}
makeArray()
{
    self endon("disconnect");
    self endon("joined_team");

    self.spectatedPlayers = remove_spec_from_array(level.players);
}
remove_spec_from_array( array )
{
    newArray = [];
    for( i = 0; i < array.size; i ++ )
    {
        if ( !isAlive(array[i]) )
            continue;
        newArray[ newArray.size ] = array[i];
    }
    return newArray;
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
}
updateArrayOnDisconnect()
{
    self endon("disconnect");

    for(;;)
    {
        level waittill("disconnect", player);
        for( i = 0; i < self.spectatedPlayers.size; i ++ )
        {
            if(player == self.spectatedPlayers[i])
            {
            if(i < self.spectatorClientNow)
                self.spectatorClientNow = add_and_fix(self.spectatorClientNow-1);
            break;
            }
        }

        self makeArray();
    }
}
updateList()
{
    self.spectatorClientNow = add_and_fix(self.spectatorClientNow);
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
			//thread spectatorHUDLoop();
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
		    self.spectatorClientNow = add_and_fix(self.spectatorClientNow,0);
        	self.spectatorClient = self getSpectatedPlayerEnt();
			//thread spectatorHUDLoop();
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
	if(self.spectatorClientNow > -1 && isDefined(self.spectatedPlayers[self.spectatorClientNow]))
        return self.spectatedPlayers[self.spectatorClientNow] getEntityNumber();
	else
    return -1;
}

getSpectatedPlayer()
{
    if(isDefined(self.spectatedPlayers[self.spectatorClientNow]))
        return self.spectatedPlayers[self.spectatorClientNow];

    return self;
}
add_and_fix(num,add)
{
   	num = int(num);

	if(isDefined(add) && add)
		num++;

	if(isDefined(add) && !add)
		num--;

    num = checkList(num);

    return num;
}
checkList(x)
{
    list = self.spectatedPlayers;

    if(x < 0)
        x = list.size-1;

    if(x >= list.size)
        x = 0;

    return x;
}