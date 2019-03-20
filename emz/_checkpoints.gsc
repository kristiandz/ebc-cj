#include codjumper\_cj_utility;

init() 
{
	level endon("no_parsed_checkpoints");
	level.checkPoints["easy"] = [];
	level.checkPoints["normal"] = [];
	level.checkPoints["hard"] = [];
	level.checkPoints["inter"] = [];
	level.mapHasCheckPoints = false;
	print("Initializing Checkpoints.\n");
	level waittill("points_parsed");
	thread initialized();
}

initialized()
{
	createArray();
//	devtest();
	level.mapHasCheckPoints = true;
	thread onPlayerConnect();
	print("Checkpoints Initialized.\n");
}

devTest()
{
	level.checkPoints["easy"][0] = spawnStruct();
	level.checkPoints["easy"][0].origin = (0,0,200);
	level.checkPoints["easy"][1] = spawnStruct();
	level.checkPoints["easy"][1].origin = (200,500,200);
	level.checkPoints["easy"][2] = spawnStruct();
	level.checkPoints["easy"][2].origin = (500,200,200);
	level.checkPoints["easy"][3] = spawnStruct();
	level.checkPoints["easy"][3].origin = (500,400,200);
}

createArray()
{
	points = level.mapPoints;
	array = getArrayKeys(points);

	for(x = 0 ; x < array.size; x++)
	{
		diff = array[x];
		point = points[diff];
		for(i = 0; i < point.size; i++)
		{
			level.checkPoints[diff][i] = spawnStruct();
			string = strTok(point[i],":");
			origin = strTok(string[0],",");	
			level.checkPoints[diff][i].origin = ( int(origin[0]),int(origin[1]),int(origin[2]) );
			level.checkPoints[diff][i].angles = ( 0 , int(string[1]) , 0 );
		}
	}
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill("connected", player);
		player.objPointNames = [];
		player.ObjPoints = [];
		player.ObjPointSize = 8;
		player.ObjPoint_alpha_default = .5;
		player.ObjPointScale = 1.0;
		player thread onPlayerSpawned();
	}
}

onPlayerSpawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");

		if(!isDefined(self.objPointHud))
		{
			self.objPointHud = self emz\_objpoints::createObjPoint("checkpoint", level.checkPoints["easy"][0].origin);
			self.ctrigger = spawn( "trigger_radius", level.checkPoints["easy"][0].origin, 0, 50, 20 );
			self.ctrigger.owner = self;
			self.ctrigger thread waitForTrigger();
		}
		self thread createTrigger(self.cj["checkpoint"]);
	}
}

createTrigger(nextPoint)
{
	self endon("disconnect");
	self notify("createTrigger");
	if(!isDefined(level.checkPoints["easy"][nextPoint]))	
	{
		self thread emz\_objpoints::deleteObjPointByName("checkpoint");
		self.ctrigger notify("delete");
		self.ctrigger delete();
		self thread onLastCheckPointReached();
		return;
	}
	self.ctrigger.origin = level.checkPoints["easy"][nextPoint].origin;
	self thread emz\_objpoints::setOriginByName( "checkpoint", self.ctrigger.origin );
}

waitForTrigger()
{
	self endon("delete");
	for(;;)
	{
		self waittill("trigger", player);

		if(player == self.owner && isDefined(self.owner))
		{	
			player thread showNextCheckPoint();
			player thread onCheckPointReached();
		}
		wait 0.05;
	}
}

showNextCheckPoint()
{
	self.cj["checkpoint"]++;
	self thread createTrigger(self.cj["checkpoint"]);
}

onCheckPointReached()
{
	if(!isDefined(self.cj["mapStartTime"]))
		self.cj["mapStartTime"] = getTime();

	time = getTime() - self.cj["lastCheckPointTime"];
	self iPrintLn("Check Point Time: " + secondsToTime(mSecToSec(time), "minsec" ));
	self thread [[level._cj_save]](1);	
	self.cj["lastCheckPointTime"] = getTime();
}

onLastCheckPointReached()
{
	time = getTime() - self.cj["mapStartTime"];
	self iPrintLnBold("Map Finished In: " + secondsToTime(mSecToSec(time), "hourminsec") + "!");
}