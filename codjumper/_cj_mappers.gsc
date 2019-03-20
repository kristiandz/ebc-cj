init()
{
	level.cjNoSaveZones = getEntArray("no_save_zone", "targetname");
	thread autoSaveZones();
	thread autoLoadZones();
}

CheckSaveZones()
{
	if(!isDefined(level.cjNoSaveZones) || level.cjNoSaveZones.size < 1)
		return false;

	for(i=0;i<level.cjNoSaveZones.size;i++)
	{
		if(self istouching(level.cjNoSaveZones[i]))
			return true;
	}
	return false;
}

autoSaveZones()
{
	level.cjAutoSaveZones = getEntArray("auto_save_zone", "targetname");
	if(!isDefined(level.cjAutoSaveZones) || level.cjAutoSaveZones.size < 1)
		return;

	for(i=0;i<level.cjAutoSaveZones.size;i++)
		level.cjAutoSaveZones[i] thread autoSaveZoneThink();
}

autoSaveZoneThink()
{
	zone = self.script_index;
	if(!isDefined(zone))
		zone = 0;

	if(isDefined(self.target))
		loc = getEnt(self.target, "targetname");
	else
		loc = undefined;

	while(true)
	{
		self waittill("trigger", player);
		if(!isDefined(player.cj["save"]["org"+zone]))
		{
			if(!isDefined(loc))
			{
				player [[level._cj_save]](zone);
			}
			else
			{
				player.cj["save"]["org"+zone] = loc.origin;
				player.cj["save"]["ang"+zone] = loc.angles;
			}
		}
	}
}

autoLoadZones()
{
	level.cjAutoLoadZones = getEntArray("auto_load_zone", "targetname");
	if(!isDefined(level.cjAutoLoadZones) || level.cjAutoLoadZones.size < 1)
		return;

	for(i=0;i<level.cjAutoLoadZones.size;i++)
		level.cjAutoLoadZones[i] thread autoLoadZoneThink();
}

autoLoadZoneThink()
{
	zone = self.script_index;

	if(!isDefined(zone))
		zone = 0;

	while(true)
	{
		self waittill("trigger", player);
		player [[level._cj_load]](zone);
		wait 0.15;
	}
}