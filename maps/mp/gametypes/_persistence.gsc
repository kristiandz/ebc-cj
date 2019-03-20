statGet( dataName )
{
	return self getStat( int(tableLookup( "mp/playerStatsTable.csv", 0, dataName, 1 )) );
}
statSet( dataName, value )
{
	self setStat( int(tableLookup( "mp/playerStatsTable.csv", 0, dataName, 1 )), value );	
}
statAdd( dataName, value )
{	
	curValue = self statGet( dataName );
	self statSet( dataName, value + curValue );
}
