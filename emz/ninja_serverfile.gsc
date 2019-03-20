init()
{ 
	level.ninjaServerFile = false;
	level.authorizeMode = getDvarInt("sv_authorizemode");
	level.getGuid = ::_getGuid;
	level.setJumpHeight = ::_setJumpHeight;
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
_setJumpHeight(x)
{
	self iPrintLn("Only on 1.7a Servers");
}