#include common_scripts\utility;
#include maps\mp\_utility;

findBoxCenter( mins, maxs )
{
	center = ( 0, 0, 0 );
	center = maxs - mins;
	center = ( center[0]/2, center[1]/2, center[2]/2 ) + mins;
	return center;
}

expandMins( mins, point )
{
	if ( mins[0] > point[0] )
		mins = ( point[0], mins[1], mins[2] );
	if ( mins[1] > point[1] )
		mins = ( mins[0], point[1], mins[2] );
	if ( mins[2] > point[2] )
		mins = ( mins[0], mins[1], point[2] );
	return mins;
}

expandMaxs( maxs, point )
{
	if ( maxs[0] < point[0] )
		maxs = ( point[0], maxs[1], maxs[2] );
	if ( maxs[1] < point[1] )
		maxs = ( maxs[0], point[1], maxs[2] );
	if ( maxs[2] < point[2] )
		maxs = ( maxs[0], maxs[1], point[2] );
	return maxs;
}

addSpawnPoints( team, spawnPointName )
{
	oldSpawnPoints = [];
	if ( level.teamSpawnPoints[team].size )
		oldSpawnPoints = level.teamSpawnPoints[team];
	level.teamSpawnPoints[team] = getEntArray( spawnPointName, "classname" );
	if ( !level.teamSpawnPoints[team].size )
	{
		println( "^1No " + spawnPointName + " spawnpoints found in level!" );
		maps\mp\gametypes\_callbacksetup::AbortLevel();
		wait 1;
		return;
	}
	if ( !isDefined( level.spawnpoints ) )
		level.spawnpoints = [];
	if(!isDefined(level.teamSpawnPoints))
		level.teamSpawnPoints = [];
	for ( index = 0; index < level.teamSpawnPoints[team].size; index++ )
	{
		spawnpoint = level.teamSpawnPoints[team][index];
		if ( !isdefined( spawnpoint.inited ) ){
			spawnpoint spawnPointInit();
			level.spawnpoints[ level.spawnpoints.size ] = spawnpoint;
		}
	}
	for ( index = 0; index < oldSpawnPoints.size; index++ )
	{
		origin = oldSpawnPoints[index].origin;
		level.spawnMins = expandMins( level.spawnMins, origin );
		level.spawnMaxs = expandMaxs( level.spawnMaxs, origin );
		level.teamSpawnPoints[team][ level.teamSpawnPoints[team].size ] = oldSpawnPoints[index];
	}
}

spawnPointInit()
{
	spawnpoint = self;
	origin = spawnpoint.origin;
	level.spawnMins = expandMins( level.spawnMins, origin );
	level.spawnMaxs = expandMaxs( level.spawnMaxs, origin );
	spawnpoint placeSpawnpoint();
	spawnpoint.forward = anglesToForward( spawnpoint.angles );
	spawnpoint.sightTracePoint = spawnpoint.origin + (0,0,50);
	spawnpoint.inited = true;
}

getSpawnpoint_Final( spawnpoints, useweights )
{
	prof_begin( " spawn_final" );
	bestspawnpoint = spawnpoints[randomint(spawnpoints.size)];
	prof_end( " spawn_final" );
	return bestspawnpoint;
}

getSpawnpoint_Random(spawnpoints)
{
	if(!isdefined(spawnpoints))
		return undefined;
	for(i = 0; i < spawnpoints.size; i++)
	{
		j = randomInt(spawnpoints.size);
		spawnpoint = spawnpoints[i];
		spawnpoints[i] = spawnpoints[j];
		spawnpoints[j] = spawnpoint;
	}
	return getSpawnpoint_Final(spawnpoints, false);
}

getTeamSpawnPoints( team )
{
	return level.teamSpawnPoints[team];
}