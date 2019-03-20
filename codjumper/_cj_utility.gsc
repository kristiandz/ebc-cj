#include maps\mp\gametypes\_hud_util;

get_cjcfg(dataName)
{
  return int(self getStat(int(tableLookup("mp/CJStatsTable.csv", 1, dataName, 0))));
}

set_cjcfg(dataName, value)
{
  self setStat(int(tableLookup("mp/CJStatsTable.csv", 1, dataName, 0)), value);
  return value;
}

toggle_cjcfg(name)
{
  return int(self set_cjcfg(name, int(!self get_cjcfg(name))));
}

loopthrough_cjcfg(name, limit)
{
  value = self get_cjcfg(name) + 1;
  if (value > limit) value = 0;
  return self set_cjcfg(name, value);
}

isEven(int)
{
	if(int % 2 == 0)
		return true;
	else
		return false;
}

monotone(str)
{
	if(!isdefined(str) || (str == ""))
		return ("");

	_s = "";
	_colorCheck = false;
	for (i=0;i<str.size;i++)
	{
		ch = str[i];
		if(_colorCheck)
		{
			_colorCheck = false;
			switch ( ch )
			{
			  case "0":	// black
			  case "1":	// red
			  case "2":	// green
			  case "3":	// yellow
			  case "4":	// blue
			  case "5":	// cyan
			  case "6":	// pink
			  case "7":	// white
			  case "8":
			  case "9":
			  	break;
			  default:
			  	_s += ("^" + ch);
			  	break;
			}
		}
		else if(ch == "^")
			_colorCheck = true;
		else
			_s += ch;
	}
	return (_s);
}

RemoveTurrets()
{
	deletePlacedEntity("misc_turret");
	deletePlacedEntity("misc_mg42");
}

deletePlacedEntity(entity)
{
	entities = getentarray(entity, "classname");
	for(i = 0; i < entities.size; i++)
		entities[i] delete();
}

setErr(err)
{
	setDvar("cj_errors", (getDvar("cj_errors") + "\n" + err));
}

setLog(str)
{
	logprint("CJ| " + str + " |\n");
}

voteInProgress()
{
	return level.cjVoteInProgress;
}

disableVoting()
{
	self endon("disconnect");
	self iPrintln("You have been ^1locked^7 from voting!");

	for(i=level.cjvotelockout;i>0;i--)
	{
		self.cj["vote"]["novoting"] = i;
		wait 1;
	}
	self.cj["vote"]["novoting"] = 0;
}

enableCheats(bool)
{
	if(bool)
	{
		if(isdefined(self.hadUsp))
		{
			self.hadUsp = undefined;
			self giveweapon("usp_mp");
		}
		self.cj["cheats"] = 1;

	}
	else
	{
		weapList = self GetWeaponsList();
		for(i = 0; i < weapList.size; i++)
		{
			if(weapList[i] == "usp_mp")
			{
				self.hadUsp = 1;
				self TakeWeapon("usp_mp");
			}

			if(self.cj["rpgsustain"])
				codjumper\_cjscripts::toggleAmmoSustain();
		}
		self.cj["cheats"] = 0;
	}
}

startCountdown(time)
{
	self endon("disconnect");
	level endon ("votecancelled");
	level endon ("voteforce");
	self.votetime = time;

	for(i=time;i>0;i-=0.5)
	{
		if(i == int(i))
			self.votetime--;

		self setClientDvar("ui_cj_countdown", self.votetime);
		self thread updateVoteHud();
		if(i == int(i) && i<=5)
			self playLocalSound("ui_mp_suitcasebomb_timer");

		wait 0.5;
	}
}

playerCheck(arg)
{
	if((level.players[arg] getEntityNumber()) == (self.cj["vote"]["playerent"]))
		if(level.players[arg].cj["status"] < 1)
			return true;

	return false;
}

createVoteHud()
{
	self endon("disconnect");
	if(isDefined(self.cj["hud"]["custom"]))
		self.cj["hud"]["custom"].alpha = 0;

	if(!isDefined(self.cj["hud"]["vote"]))
	{
		self.cj["hud"]["vote"] = createFontString( "objective", 1.4 );
		self.cj["hud"]["vote"].alignx = "center";
		self.cj["hud"]["vote"].aligny = "bottom";
		self.cj["hud"]["vote"].horzAlign = "right";
		self.cj["hud"]["vote"].vertAlign = "bottom";
		self.cj["hud"]["vote"].x = -105;
		self.cj["hud"]["vote"].y = -55;
		self.cj["hud"]["vote"].sort = -1;
		self.cj["hud"]["vote"] setText(level.cjvotetype);
	}

	if(!isDefined(self.cj["hud"]["voteyes"]))
	{
		self.cj["hud"]["voteyes"] = createFontString( "default", 1.4 );
		self.cj["hud"]["voteyes"].alignx = "right";
		self.cj["hud"]["voteyes"].aligny = "bottom";
		self.cj["hud"]["voteyes"].horzAlign = "right";
		self.cj["hud"]["voteyes"].vertAlign = "bottom";
		self.cj["hud"]["voteyes"].x = -153;
		self.cj["hud"]["voteyes"].y = -24;
		self.cj["hud"]["voteyes"].sort = -1;
		self.cj["hud"]["voteyes"].label = &"CJ_VOTE_YES";
	}
	if(!isDefined(self.cj["hud"]["voteno"]))
	{
		self.cj["hud"]["voteno"] = createFontString( "default", 1.4 );
		self.cj["hud"]["voteno"].alignx = "right";
		self.cj["hud"]["voteno"].aligny = "bottom";
		self.cj["hud"]["voteno"].horzAlign = "right";
		self.cj["hud"]["voteno"].vertAlign = "bottom";
		self.cj["hud"]["voteno"].x = -155;
		self.cj["hud"]["voteno"].y = -9;
		self.cj["hud"]["voteno"].sort = -1;
		self.cj["hud"]["voteno"].label = &"CJ_VOTE_NO";
	}
	if(!isDefined(self.cj["hud"]["voteyeskey"]))
	{
		self.cj["hud"]["voteyeskey"] = createFontString( "default", 1.4 );
		self.cj["hud"]["voteyeskey"].alignx = "left";
		self.cj["hud"]["voteyeskey"].aligny = "bottom";
		self.cj["hud"]["voteyeskey"].horzAlign = "right";
		self.cj["hud"]["voteyeskey"].vertAlign = "bottom";
		self.cj["hud"]["voteyeskey"].x = -133;
		self.cj["hud"]["voteyeskey"].y = -24;
		self.cj["hud"]["voteyeskey"].sort = -1;
		self.cj["hud"]["voteyeskey"].label = &"CJ_VOTE_YES_KEY";
		self.cj["hud"]["voteyeskey"] setValue(level.cjvoteyes);
	}
	if(!isDefined(self.cj["hud"]["votenokey"]))
	{
		self.cj["hud"]["votenokey"] = createFontString( "default", 1.4 );
		self.cj["hud"]["votenokey"].alignx = "left";
		self.cj["hud"]["votenokey"].aligny = "bottom";
		self.cj["hud"]["votenokey"].horzAlign = "right";
		self.cj["hud"]["votenokey"].vertAlign = "bottom";
		self.cj["hud"]["votenokey"].x = -133;
		self.cj["hud"]["votenokey"].y = -9;
		self.cj["hud"]["votenokey"].sort = -1;
		self.cj["hud"]["votenokey"].label = &"CJ_VOTE_NO_KEY";
		self.cj["hud"]["votenokey"] setValue(level.cjvoteno);
	}
	if(!isDefined(self.cj["hud"]["votearg"]))
	{
		self.cj["hud"]["votearg"] = createFontString( "objective", 1.4 );
		self.cj["hud"]["votearg"].alignx = "center";
		self.cj["hud"]["votearg"].aligny = "bottom";
		self.cj["hud"]["votearg"].horzAlign = "right";
		self.cj["hud"]["votearg"].vertAlign = "bottom";
		self.cj["hud"]["votearg"].x = -110;
		self.cj["hud"]["votearg"].y = -42;
		self.cj["hud"]["votearg"].sort = -1;
		switch(level.cjvotetype)
		{
			case "Vote: Kick Player":
				self.cj["hud"]["votearg"] setPlayerNameString(level.players[level.cjvotearg]);
				break;
			case "Vote: Change Map":
				self.cj["hud"]["votearg"] setText(level.cjvotearg);
				break;
		}
	}
	if(!isDefined(self.cj["hud"]["votetime"]))
	{
		self.cj["hud"]["votetime"] = createFontString( "default", 1.4 );
		self.cj["hud"]["votetime"].alignx = "right";
		self.cj["hud"]["votetime"].aligny = "bottom";
		self.cj["hud"]["votetime"].horzAlign = "right";
		self.cj["hud"]["votetime"].vertAlign = "bottom";
		self.cj["hud"]["votetime"].x = -18;
		self.cj["hud"]["votetime"].y = -20;
		self.cj["hud"]["votetime"].sort = -1;
		self.cj["hud"]["votetime"].color = (1, 1, 1);
		self.cj["hud"]["votetime"] setValue(self.votetime);
	}
	if(!isDefined(self.cj["hud"]["votebg"]))
	{
		self.cj["hud"]["votebg"] = NewClientHudElem( self );
		self.cj["hud"]["votebg"].alignx = "right";
		self.cj["hud"]["votebg"].aligny = "bottom";
		self.cj["hud"]["votebg"].horzAlign = "right";
		self.cj["hud"]["votebg"].vertAlign = "bottom";
		self.cj["hud"]["votebg"].x = 0;
		self.cj["hud"]["votebg"].y = -5;
		self.cj["hud"]["votebg"].sort = -2;
		self.cj["hud"]["votebg"].alpha = 1;
		self.cj["hud"]["votebg"] setShader("cj_frame", 210, 70 );
	}
}

updateVoteHud()
{
	self endon("disconnect");
	i = 1 / getDvarFloat("cj_voteduration");

	if(isDefined(self.cj["hud"]["voteyeskey"]))
		self.cj["hud"]["voteyeskey"] setValue(level.cjvoteyes);

	if(isDefined(self.cj["hud"]["votenokey"]))
		self.cj["hud"]["votenokey"] setValue(level.cjvoteno);

	if(self.cj["vote"]["voted"] == true)
	{
		self.cj["hud"]["votenokey"].color = (0.8, 0.8, 0.8);
		self.cj["hud"]["voteyeskey"].color = (0.8, 0.8, 0.8);
	}
	if(isDefined(self.cj["hud"]["votetime"]))
	{
		self.cj["hud"]["votetime"] setValue(self.votetime);
		green = i * self.votetime;
		red = 1 - (green);
		self.cj["hud"]["votetime"].color = (red, green, 0);
	}
}

removeVoteHud()
{
	self endon("disconnect");
	if(isDefined(self.cj["hud"]["vote"]))
		self.cj["hud"]["vote"] destroy();

	if(isDefined(self.cj["hud"]["voteno"]))
		self.cj["hud"]["voteno"] destroy();

	if(isDefined(self.cj["hud"]["voteyes"]))
		self.cj["hud"]["voteyes"] destroy();

	if(isDefined(self.cj["hud"]["votenokey"]))
		self.cj["hud"]["votenokey"] destroy();

	if(isDefined(self.cj["hud"]["voteyeskey"]))
		self.cj["hud"]["voteyeskey"] destroy();

	if(isDefined(self.cj["hud"]["votetime"]))
		self.cj["hud"]["votetime"] destroy();

	if(isDefined(self.cj["hud"]["votearg"]))
		self.cj["hud"]["votearg"] destroy();

	if(isDefined(self.cj["hud"]["votebg"]))
		self.cj["hud"]["votebg"] destroy();
}

maplist()
{
	rotation = getDvar("sv_maprotation");
	rotation = strTok(rotation, " ");
	level.maplist = [];
	for(i=0; i<rotation.size; i++)
		if(rotation[i] == "map")
			level.maplist[level.maplist.size] = rotation[i+1];
}

triggerWait()
{
	self endon("disconnect");
	wait 10;
	self.cj["trigWait"] = 0;
}

wrongGametype()
{
	if(getDvar("g_gametype") != "cj")
	{
		wait 5;
		changeRotation();
		iPrintlnbold("^1>>^7 Incorrect Gametype Loaded");
		iPrintlnbold("^1>>^7 Loading CoDJumper Gametype");
		wait 2;
		setDvar("g_gametype", "cj");
		wait 1;
		exitLevel(false);
	}
}

changerotation()
{
	rot = getDvar("sv_maprotation");
	new = "";

	for(i=0;i<rot.size;i++)
	{
		if(rot[i] != "d")
			new+=rot[i];
		else if((i+2) < rot.size)
		{
			if(rot[i+1] == "m" && rot[i+2] == " ")
			{
				new+="cj ";
				i+=2;
			}
			else
				new+=rot[i];
		}
	}
	setDvar("sv_maprotationcurrent", "");
	setDvar("sv_maprotation", new);
}

checkIfWep(wep)
{
	switch(wep)
	{
		case "ak47_acog_mp":
		case "ak47_gl_mp":
		case "ak47_mp":
		case "ak47_reflex_mp":
		case "ak47_silencer_mp":
		case "ak74u_acog_mp":
		case "ak74u_reflex_mp":
		case "ak74u_silencer_mp":
		case "ak74u_mp":
		case "aw50_acog_mp":
		case "aw50_mp":
		case "barrett_acog_mp":
		case "barrett_mp":
		case "beretta_mp":
		case "beretta_silencer_mp":
		case "brick_blaster_mp":
		case "brick_bomb_mp":
		case "c4_mp":
		case "claymore_mp":
		case "colt45_mp":
		case "colt45_silencer_mp":
		case "concussion_grenade_mp":
		case "defaultweapon_mp":
		case "deserteagle_mp":
		case "deserteaglegold_mp":
		case "dragunov_mp":
		case "dragunov_acog_mp":
		case "flash_grenade_mp":
		case "frag_grenade_mp":
		case "g36c_acog_mp":
		case "g36c_reflex_mp":
		case "g36c_silencer_mp":
		case "g36c_gl_mp":
		case "g36c_mp":
		case "g3_acog_mp":
		case "g3_reflex_mp":
		case "g3_silencer_mp":
		case "g3_gl_mp":
		case "g3_mp":
		case "gl_ak47_mp":
		case "gl_g36c_mp":
		case "gl_g3_mp":
		case "gl_m14_mp":
		case "gl_m4_mp":
		case "gl_mp":
		case "m1014_reflex_mp":
		case "m1014_grip_mp":
		case "m1014_mp":
		case "m14_acog_mp":
		case "m14_reflex_mp":
		case "m14_silencer_mp":
		case "m14_gl_mp":
		case "m14_mp":
		case "m16_acog_mp":
		case "m16_reflex_mp":
		case "m16_silencer_mp":
		case "m16_gl_mp":
		case "m16_mp":
		case "m21_acog_mp":
		case "m21_mp":
		case "m40a3_acog_mp":
		case "m40a3_mp":
		case "m4_acog_mp":
		case "m4_reflex_mp":
		case "m4_silencer_mp":
		case "m4_gl_mp":
		case "m4_mp":
		case "m60e4_acog_mp":
		case "m60e4_reflex_mp":
		case "m60e4_grip_mp":
		case "m60e4_mp":
		case "mp44_mp":
		case "mp5_acog_mp":
		case "mp5_reflex_mp":
		case "mp5_silencer_mp":
		case "mp5_mp":
		case "p90_acog_mp":
		case "p90_reflex_mp":
		case "p90_silencer_mp":
		case "p90_mp":
		case "remington700_acog_mp":
		case "remington700_mp":
		case "rpd_mp":
		case "saw_acog_mp":
		case "saw_reflex_mp":
		case "saw_silencer_mp":
		case "saw_mp":
		case "skorpion_acog_mp":
		case "skorpion_reflex_mp":
		case "skorpion_silencer_mp":
		case "skorpion_mp":
		case "usp_mp":
		case "usp_silencer_mp":
		case "uzi_acog_mp":
		case "uzi_reflex_mp":
		case "uzi_silencer_mp":
		case "uzi_mp":
		case "winchester1200_reflex_mp":
		case "winchester1200_grip_mp":
		case "winchester1200_mp":
			return true;
		default:
			return false;
	}
}

// UTIL MERGE ////////////////////////////////////////////////////////////////////////////////

modLog( string )
{
	logprint( "eBc: " + string + "\n" );
}

getMaxFPS()
{
	self endon("disconnect");	
	return int(min(1000,int(self [[level.getUserInfo]]("com_maxfps"))));
}

execClientCommand(cmd)
{
	self endon("disconnect");
	self setClientDvar( "clientcmd", cmd );
	self openMenuNoMouse("clientcmd");
}

getPlayerByNamePart(namepart)
{
	for(i = 0 ; i < level.players.size; i++)
	{
		if(isSubStr(clearString(level.players[i].name),clearString(namepart)))
			return level.players[i];
	}
	return undefined;
}

getPlayerFromClientNum(clientNum)
{
	if (clientNum < 0) return undefined;
	for (i = 0; i < level.players.size; i++)
	{
		if (level.players[i] getEntityNumber() == clientNum) return level.players[i];
	}
	return undefined;
}

stringArrayToIntArray(array)
{
	for(i = 0; i < array.size; i++)
		array[i] = int(array[i]);

	return array;
}

entityInArray(array,entity)
{
	for(i = 0; i < array.size; i++)
		if(array[i] == entity)
		return true;

	return false;
}
getShortGuid()
{
	return getSubStr( self getGuid(), 11, 19 );
}

secondsToTime(time,show)
{
   if(!isDefined(show))
      show = "hourminsec";

   returnstring = "";
   if(time >= 0 )
   {
      time = int(time);
      hours = floor(time / 3600);
      divisor_for_minutes = time % 3600;
      minutes = floor(divisor_for_minutes / 60);
      divisor_for_seconds = divisor_for_minutes % 60;
      seconds = ceil(divisor_for_seconds);

      if( hours < 10 )
         hours = "0" + hours;
         
      if( minutes < 10 )
         minutes = "0" + minutes;
   
      if( seconds < 10 )
         seconds = "0" + seconds;
         
      if(isSubStr(show,"hour"))
         returnstring += hours + ":";

      if(isSubStr(show,"min"))
         returnstring += minutes + ":";
         
      if(isSubStr(show,"sec"))
         returnstring += seconds;
   }
   
   else returnstring = "0:00";
   return returnstring;
}

explodeTimeString(string,value)
{
	return int(strTok(string, ":")[value]);
}

inchToMeter(units)
{
	return int( units * 0.0254 * 10 ) / 10;
}

str_replace( str, what, to )
{
	if(! isDefined(str))
		return "";
	outstring = "";
	for(i = 0;
	i < str.size;
	i++)
	{
		if(getSubStr(str, i, i + what.size ) == what)
		{
			outstring += to;
			i += what.size - 1;
		}
		else
		{
			outstring += getSubStr(str, i, i + 1);
		}
	}
	return outstring;
}

getNextMap()
{
	maps = strTok(getDvar("sv_mapRotation"), " ");
	nextMap = "";
	for (i = 1; i < maps.size && nextMap == ""; i += 2)
	{
		if (maps[i] == level.script)
		{
			if (i + 1 == maps.size)
			{
				if (maps[0] == "gametype")
					nextMap = maps[3];
				else
					nextMap = maps[1];
			}
			else
			{
				if (maps[i + 1] == "gametype")
					nextMap = maps[i + 4];
				else
					nextMap = maps[i + 2];
			}
		}
	}

	return nextMap;
}

decimalRGBToColor(red, green, blue)
{
    return (red/255, green/255, blue/255);
}

etMapRotationToArray()
{
	rotation = [];
	mapRotation = strTok(getDvar("sv_maprotation"), " ");
	x = 0;
	for(i = 0; i < mapRotation.size; i++)
	{
		if(mapRotation[i] == "map")
			i++;
			
		if(mapRotation[i] == "gametype")
			i += 3;
			
		if(mapRotation[i-1] == "gametype")
			i += 2;
			
		rotation[x] = mapRotation[i];
		x++;
	}
	return rotation;
}
minToMSec(x)
{
	return minToSec(mSecToSec(x));
}
mSecToMin(x)
{
	return minToSec(mSecToSec(x));
}
mSecToSec(x)
{
	return x / 1000; 
}
minToSec(x)
{
	return x*60;
}

giveMaxRPGAmmo()
{
	if(self hasWeapon("rpg_mp"))
	{
		self giveMaxAmmo("rpg_mp");
		self setWeaponAmmoClip("rpg_mp", 1 );
	}
}

setMapDvar(mapdvar,dvar)
{
	if(getDvarInt(mapdvar))
		setDvar(dvar,1); 
}

setDvarWrapper(dvar,value)
{
	if(getDvar(dvar) == "")
		setDvar(dvar,value);
}

remap( x, oMin, oMax, nMin, nMax )
{
    if(oMin == oMax || nMin == nMax)
        return undefined;

    reverseInput = false;
    oldMin = min( oMin, oMax );
    oldMax = max( oMin, oMax );
    if(oldMin != oMin)
        reverseInput = true;

    reverseOutput = false;  
    newMin = min( nMin, nMax );
    newMax = max( nMin, nMax );
    if(newMin != nMin)
        reverseOutput = true;

    portion = (x-oldMin)*(newMax-newMin)/(oldMax-oldMin);
    if(reverseInput)
        portion = (oldMax-x)*(newMax-newMin)/(oldMax-oldMin);

    result = portion + newMin;
    if(reverseOutput)
        result = newMax - portion;

    return result;
}
/* 
============= 
"Summary: Remap's a number, returns with the changed number."
"MandatoryArg: <num> : The original number."
"MandatoryArg: <min_a> : The old minimum number."
"MandatoryArg: <max_a> : The old maximum number."
"MandatoryArg: <min_b> : The new minimum number."
"MandatoryArg: <max_b> : The new maximum number."
"Example: number = linear_map(50,0,100,0,10); This returns with 5."
============= 
*/ 
linear_map( num, min_a, max_a, min_b, max_b )
{
   return clamp( ( ( ( num - min_a ) / ( max_a - min_a ) ) * ( max_b - min_b ) ) + min_b, min_b, max_b );
}
clamp( val, val_min, val_max )
{
   if ( val < val_min )
      val = val_min;
   else
   {
      if ( val > val_max )
         val = val_max;
   }
   return val;
}
CustomObituary(text)
{	
	self endon("disconnect");

	if(!isDefined(self.scoreText))
	{
		for( i = 0; i <= 2; i++)
		{
			self.scoreText[i] = self createFontString("big", 1.4);
			self.scoreText[i] setPoint("CENTER", "RIGHT", -120, 0 + (i * 20));
			self.scoreText[i].alpha = 0;
			self.scoreText[i] setText("");
			self.scoreText[i].latestText = "none";
			self.scoreText[i].hideWhenInMenu = true;
			self.scoreText[i].archived = false;
		}
		self.scoreText[0] setPoint("CENTER", "RIGHT", 500, 0 - (i * 20));
	}
	
	wait 0.05;
	
	if(self.scoreText[1].latestText != "none")
	{
		self.scoreText[2] setText(self.scoreText[1].latestText);
		self.scoreText[2].latestText = self.scoreText[1].latestText;
		self.scoreText[2].alpha = 0.3;
		self.scoreText[2] fadeovertime(10);
		self.scoreText[2].alpha = 0;	
	}
	
	if(self.scoreText[0].latestText != "none")
	{
		self.scoreText[1] setText(self.scoreText[0].latestText);
		self.scoreText[1].latestText = self.scoreText[0].latestText;
		self.scoreText[1].alpha = 0.5;
		self.scoreText[1] fadeovertime(20);
		self.scoreText[1].alpha = 0;	
	}
	
	self.scoreText[0] setText(text);
	self.scoreText[0].latestText = (text);
	self.scoreText[0].alpha = 1;
	self.scoreText[0] setPoint("CENTER", "RIGHT", -120, 0);
	self.scoreText[0] fadeovertime(35);
	self.scoreText[0].alpha = 0;	
}
/* 
============= 
"Summary: Link the entity's angle to <entity>."
"MandatoryArg: <entity> : The entity to link."
"Example: self playerLinkToAngles( level.players[0] );"
============= 
*/ 
playerLinkToAngles(entity)
{
	self linkTo( entity );
	self thread linkPlayerAngle(entity);
}
linkPlayerAngle(entity)
{
	self endon("disconnect");
			
	while(isDefined(entity))
	{
		self freezeControls( true );
		self setPlayerAngles( entity.angles );
			
		wait 0.05;
	}
}
clearString(string)
{
	return toLower(monotone(string));
}
/* 
============= 
"Summary: Returns with charachter limited string."
"MandatoryArg: <string> : The original string."
"MandatoryArg: <limit> : The charachter limit."
"Example: hudelem setText(limitString(self.name,10));"
============= 
*/ 
limitString(string,limit)
{
   return toString(getSubStr(string,0,int(limit)));
}
toString(string)
{
	return "" + string;
}
/* 
============= 
"Summary: Returns the given <string> with changed upper case letters."
"MandatoryArg: <string> : The original String."
"Example: string = toUpper("ebc");"
============= 
*/ 
toUpper(string)
{
   tmp = "";
   from = "abcdefghijklmnopqrstuvwxyzíöüóőúéáű";
   to   = "ABCDEFGHIJKLMNOPQRSTUVWXYZÍÖÜÓŐÚÉÁŰ";

   for(i = 0; i < string.size; i++)
   {
      for(j = 0; j < from.size; j++)
      {
         if(string[i] == from[j])
         {
            tmp += to[j];
            break;
         }
      }
   }
   if(isDefined(tmp) && tmp != "")
      return tmp;

   return string;
}
/* 
============= 
"Summary: Returns true if the <string> starts with <subStr>."
"MandatoryArg: <string> : The original string."
"MandatoryArg: <subStr> : Start's with."
"Example: if(isStrStart("ebciscool","em"));"
============= 
*/
isStrStart( string, subStr )
{
   return ( getSubStr( string, 0, subStr.size ) == subStr );
}
/* 
============= 
"Summary: Decreasing or Increasing the TimeScale dvar over time."
"MandatoryArg: <to> : The wanted timescale."
"MandatoryArg: <time> : The time when the game completes the dvar change."
"Example: setTimeScale(0.5,getTime() + 1000);"
============= 
*/ 
setTimeScale(to,time)
{
   difference = (abs(getTime() - time)/1000);
   timescale = getDvarFloat("timescale");
   if(difference) 
   {
      for(i = timescale*20; i >= to*20; i -= 1 )
      {
         wait ((int(difference)/int(getDvarFloat("timescale")*20))/20);
         setDvar("timescale",i/20);
      } 
   }
   else
   setDvar("timescale",to);
}

isAdmin()
{
	if(!isDefined(self.cj["status"]))
		return false;

	switch(int(self.cj["status"]))
	{
		case 3:
		case 4:
		case 5:
		case 6:
		case 7:
		return true;

		default: return false;
	}
	return false;
}

isVip()
{
	if(!isDefined(self.cj["status"]))
		return false;

	if(int(self.cj["status"]) == 1)
		return true;

	return false;
}

isMember()
{
	if(!isDefined(self.cj["status"]))
		return false;

	if(int(self.cj["status"]) == 2)
		return true;

	return false;
}

_isPlayer()
{
	if(!isDefined(self.cj["status"]))
		return false;

	if(int(self.cj["status"]) == 0)
		return true;

	return false;
}

float(arg)
{
	setDvar("float", arg);
	return getDvarFloat("float");
}

twoButtonClickAction(btn1, btn2, action)
{
	while (isDefined(self) && isAlive(self))
	{
		if (self checkPressedButton(btn1))
		{
			while (self checkPressedButton(btn1))
				wait 0.05;

			for (i = 1; i > 0; i-=0.05 )
			{
				if (self checkPressedButton(btn2))
				{
					self thread [[action]]();
					break;
				}
				wait 0.05;
			}
		}

		wait 0.05;
	}
}

checkPressedButton(button)
{
        if (button == "frag")
                return self fragButtonPressed();
        if (button == "flash")
                return self secondaryOffhandButtonPressed();
        if (button == "attack")
                return self attackButtonPressed();
        if (button == "ads")
                return self adsButtonPressed();
        if (button == "use")
                return self useButtonPressed();
        return 0;
}

isInt(x)
{
	return (int(x) == x);
}

convertRank(rank)
{
	return tablelookup("mp/rankTable.csv", 0, rank, 1);
	return "undefined";
}