InitializeHud()
{
	level thread waitforconnect();
}

waitforconnect()
{
	self endon("disconnect");	
	while (true)
	{
		level waittill("connected", player );
		player startThreads();
	}
}
 
startThreads()
{
		self waittill("spawned_player");
		self thread hud\wasd::mainLoop();
		//self thread hud\velocity::mainLoop();	 
		self thread hud\fps::mainLoop();	 
		self thread hud\speclist::mainLoop();	 
}
 
