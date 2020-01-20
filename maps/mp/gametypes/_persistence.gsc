//Returns the value of the named stat
statGet( dataName )
{
	return self getStat( int(tableLookup( "mp/playerStatsTable.csv", 1, dataName, 0 )) );
}

//Sets the value of the named stat
statSet( dataName, value )
{
	self setStat( int(tableLookup( "mp/playerStatsTable.csv", 1, dataName, 0 )), value );	
}

//Adds the passed value to the value of the named stat
statAdd( dataName, value )
{	
	curValue = self getStat( int(tableLookup( "mp/playerStatsTable.csv", 1, dataName, 0 )) );
	self setStat( int(tableLookup( "mp/playerStatsTable.csv", 1, dataName, 0 )), value + curValue );
}