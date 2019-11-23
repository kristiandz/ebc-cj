#include common_scripts\utility;

InitializeHud()
{
	    thread waitforconnect();
}

waitforconnect()
{
	while (true)
	{
		level waittill("connected", player );
		player thread startThreads();
	}
}
 
 startThreads()
 {
		self waittill_any("joined_team", "joined_spectator");
		self thread hud\wasd::mainLoop();
		self thread hud\velocity::mainLoop();	 
		self thread hud\fps::mainLoop();	 
		self thread hud\speclist::mainLoop();	 
 }