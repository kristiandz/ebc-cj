init()
{ 
	level.ninjaServerFile = false;
	level.authorizeMode = getDvarInt("sv_authorizemode");
	level.getGuid = ::_getGuid;
	level.getUserInfo = ::_getUserInfo;
} 

_getUserInfo(arg)
{
	return 0;
}

_getGuid()
{
	return self getGuid();
}