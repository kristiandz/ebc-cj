init()
{ 
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