logPos(guid, origin, angles)
{
	if (!isDefined(guid))
		guid = self GetGuid();
	if (!isDefined(origin))
		origin = self getorigin();
	if (!isDefined(angles))
		angles = self getPlayerAngles();
   // self endon("disconnect");
  //  waittillframeend;
    if( isDefined(level._database[guid]) && level._database[guid] > 0 )
    {
        closefile( level._database[guid] );
        level._database[guid] = undefined;
    }
    level._database[guid] = openfile("positionlogs/"+level.script+"/"+guid+".db","write");
    if( level._database[guid] > 0 )
    {
        FPrintLn( level._database[guid], origin+";"+angles );
        closefile( level._database[guid] );
    }
   // else self iprintln("^1Error writing in position log.\n!rp will not work.");
    
    level._database[guid] = undefined;
}


restorePos()
{
    guid = self GetGuid();
    self endon("disconnect");
    if( isDefined(level._database[guid]) && level._database[guid] > 0 )
    {
        closefile( level._database[guid] );
        level._database[guid] = undefined;
    }
    level._database[guid] = openfile("positionlogs/"+level.script+"/"+guid+".db","read");
    pos = FS_ReadLine( level._database[guid] );
    closefile( level._database[guid] );
    level._database[guid] = undefined;
    if(isDefined(pos))
    {
        origin = strtok( pos, ";" )[0];
        coords = strtok( origin, "," );

        x = strtok(coords[0],"(")[0];
        y = coords[1];
        z = strtok(coords[2],")")[0];
        
        angles = strtok( pos, ";" )[1];
        angs = strtok( angles, "," );
        x_ang = strtok(angs[0],"(")[0];
        y_ang = angs[1];
        z_ang = strtok(angs[2],")")[0];

        self setOrigin( (int(x), int(y), int(z)) );
        self setPlayerAngles( (int(x_ang), int(y_ang), int(z_ang)) ); 
    }
}