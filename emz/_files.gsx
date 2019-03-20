init() 
{
	level.pointsFile["easy"] = "settings/"+getdvar("mapname")+".pts";
	level.pointsFile["normal"] = "settings/"+getdvar("mapname")+"_normal.pts";
	level.pointsFile["hard"] = "settings/"+getdvar("mapname")+"_hard.pts";
	level.pointsFile["inter"] = "settings/"+getdvar("mapname")+"_inter.pts";

	level.mapPoints["easy"] = [];
	level.mapPoints["normal"] = [];
	level.mapPoints["hard"] = [];
	level.mapPoints["inter"] = [];

	level.pModels = [];
	thread parseSleep();
}

parseSleep() 
{
	waittillframeend;

	points = level.mapPoints;
	array = getArrayKeys(points);

	for(i = 0 ; i < array.size; i++)
	{
		diff = array[i];
		level.mapPoints[diff] = fparse(level.pointsFile[diff]);
	}
	if(isDefined(level.mapPoints["easy"][0]))
	{
		level notify("points_parsed");
		thread showPoints();
	}
	else
	{
		level notify("no_parsed_checkpoints");
		print("Failed to Initialize Checkpoints.\n");
	}
}

fparse(filename) 
{
	file = fread(filename);
	tmp = strTok(file, ";");
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

fwrite(logfile,log) 
{
	database = undefined;
	database = FS_FOpen(logfile, "write");
	FS_WriteLine(database, log);
	FS_FClose(database);
}

parsePoints(line) 
{
	pt = strTok(line, ":");
	pt[0] = strTok(pt[0], ",");
	pt[0] = (int(pt[0][0]), int(pt[0][1]), int(pt[0][2]));
	return pt;
}

showPoints()
{
	for(i = 0;i<level.pModels.size;i++) 
		level.pModels[i] delete();
	level.pModels = [];
	points = level.mapPoints;
	array = getArrayKeys(points);
	for(i = 0 ; i < array.size; i++)
	{
		for(x = 0; x < points[array[i]].size; x++)
		{
			p = parsePoints(points[array[i]][x]);
			showPoint(p[0], p[1],array[i]);
		}
	}
}

showPoint(o,a,diff) 
{	
	q = level.pModels.size;
	level.pModels[q] = spawn("script_model",(int(o[0]), int(o[1]), int(o[2])));
	level.pModels[q].angles=(0, int(a), 0);

	if(diff == "easy")
	level.pModels[q] setModel("playermodel_dnf_duke");
	if(diff == "normal")
	level.pModels[q] setModel("body_masterchief");
	if(diff == "hard")
	level.pModels[q] setModel("mc_char");
	if(diff == "inter")
	level.pModels[q] setModel("body_juggernaut");
	level.pModels[q] hide();
}

showModels()
{
	for(i = 0;i<level.pModels.size;i++) 
		level.pModels[i] ShowToPlayer( self );
}

savePointsFile(diff) 
{
	self iprintln("Saving: ",diff);
	op = "";
	points = level.mapPoints[diff];
	for(x = 0; x < points.size; x++)
		op += points[x] + ";";
	fwrite(level.pointsFile[diff], op);
}

deleteNearby(diff) 
{
	self iprintln("Delete: ",diff);
	o = self.origin;
	newPoints = [];
	points = level.mapPoints[diff];
	for(i = 0 ; i < points.size; i++)
	{
		p = parsePoints(points[i]);
		if( Distance(p[0], o) > 50 ) 
			newPoints[newPoints.size] = points[i];
	}
	level.mapPoints[diff] = newPoints;
	thread showPoints();
}

storePoint(o, a, diff) 
{
	self iprintln("Stored: ",diff);
	level.mapPoints[diff][level.mapPoints[diff].size] = int(o[0])+","+int(o[1])+","+int(o[2])+":"+int(a[1]);
	showPoint(o,int(a[1]),diff);
	self showModels();
}