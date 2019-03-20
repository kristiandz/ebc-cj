createObjPoint( name, origin, shader, alpha, scale )
{	
	ObjPoint = getObjPointByName( name );
	
	if ( isDefined( ObjPoint ) )
		deleteObjPoint( ObjPoint );
	
	if ( !isDefined( shader ) )
		shader = "ObjPoint_default";

	if ( !isDefined( scale ) )
		scale = 1.0;
		
	ObjPoint = newClientHudElem( self );
	ObjPoint.name = name;
	ObjPoint.x = origin[0];
	ObjPoint.y = origin[1];
	ObjPoint.z = origin[2] + 50;
	ObjPoint.isFlashing = false;

	ObjPoint setShader( shader, self.ObjPointSize, self.ObjPointSize );
	ObjPoint setWaypoint( true );
	
	if ( isDefined( alpha ) )
		ObjPoint.alpha = alpha;
	else
		ObjPoint.alpha = self.ObjPoint_alpha_default;
	ObjPoint.baseAlpha = ObjPoint.alpha;
		
	ObjPoint.index = self.objPointNames.size;
	self.ObjPoints[name] = ObjPoint;
	self.objPointNames[self.objPointNames.size] = name;
	
	return ObjPoint;
}

deleteObjPointByName( name )
{
	obj = self getObjPointByName( name );
	self deleteObjPoint( obj );
}

deleteObjPoint( oldObjPoint )
{
	assert( self.ObjPoints.size == self.objPointNames.size );
	if ( self.ObjPoints.size == 1 )
	{
		assert( self.objPointNames[0] == oldObjPoint.name );
		assert( isDefined( self.ObjPoints[oldObjPoint.name] ) );
		
		self.ObjPoints = [];
		self.objPointNames = [];
		oldObjPoint destroy();
		return;
	}
	newIndex = oldObjPoint.index;
	oldIndex = (self.objPointNames.size - 1);
	ObjPoint = getObjPointByIndex( oldIndex );
	self.objPointNames[newIndex] = ObjPoint.name;
	ObjPoint.index = newIndex;
	self.objPointNames[oldIndex] = undefined;
	self.ObjPoints[oldObjPoint.name] = undefined;
	oldObjPoint destroy();
}

updateOrigin( origin )
{
	if ( self.x != origin[0] )
		self.x = origin[0];
	if ( self.y != origin[1] )
		self.y = origin[1];
	if ( self.z != origin[2] )
		self.z = origin[2];
}

setOriginByName( name, origin )
{
	ObjPoint = getObjPointByName( name );
	ObjPoint updateOrigin( origin );
}

getObjPointByName( name )
{
	if ( isDefined( self.ObjPoints[name] ) )
		return self.ObjPoints[name];
	else
		return undefined;
}

getObjPointByIndex( index )
{
	if ( isDefined( self.objPointNames[index] ) )
		return self.ObjPoints[self.objPointNames[index]];
	else
		return undefined;
}

startFlashing()
{
	self endon("stop_flashing_thread");
	
	if ( self.isFlashing )
		return;
	
	self.isFlashing = true;
	
	while ( self.isFlashing )
	{
		self fadeOverTime( 0.75 );
		self.alpha = 0.35 * self.baseAlpha;
		wait ( 0.75 );
		
		self fadeOverTime( 0.75 );
		self.alpha = self.baseAlpha;
		wait ( 0.75 );
	}
	
	self.alpha = self.baseAlpha;
}

stopFlashing()
{
	if ( !self.isFlashing )
		return;

	self.isFlashing = false;
}