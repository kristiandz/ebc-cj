#include codjumper\_cj_utility;

onMenuResponse()
{
	self endon("disconnect");

	for(;;)
	{
		self waittill("menuresponse", menu, response);
		if ( response == "back" )
		{
			self closeMenu();
			self closeInGameMenu();
		}
		
		if(response == "player")
		{
			self [[level.menuPlayer]]();
		}
		
		else if(response == "spectate")
		{
			self [[level.menuSpectator]]();
		}

		if(response == "vip")
		{
			if(!self _isPlayer())
			self openMenu("vip");	
			else self iprintlnBold("^1Unauthorized");
		}

		if(menu == "vip")
		{
			if(!self _isPlayer())
			{
				self detachAll();
				self setClientDvar("currentmodel",TableLookup( "mp/modelTable.csv", 0, response, 1 ));
				self setModel(TableLookup( "mp/modelTable.csv", 0, response, 2 ));
				self setViewModel(TableLookup( "mp/modelTable.csv", 0, response, 3 ));
				self setStat(100,int(response));
			}
		}
		if(menu == "shop")
		{
			if(self getStat(110+int(response))==1 && self getStat(1169)==(int(response)+1)) 
				self setClientDvar("shop"+int(response)+"action","^2Activated");
			if(self getStat(110+int(response))==1 && self getStat(1169)!=(int(response)+1))
			{
				self detachAll();
				self setModel(level.shopmodel[int(response)+1][0]);
				self setClientDvar("shopmodel",level.shopmodel[int(response)+1][1]);
				self setClientDvar("shop"+int(response)+"action","^3Activated");
				self setStat(1169,int(response)+1);
				self thread emz\shop::check();
			}
			else if(self.pers["points"] >= level.modelcost[int(response)])
			{
				self.pers["points"] = self.pers["points"]-level.modelcost[int(response)];
				self setStat(2561,self.pers["points"]);
				self setStat(110+int(response),1);
				self setStat(1169,int(response)+1);
				self detachAll();
				self setModel(level.shopmodel[int(response)+1][0]);
				self setClientDvar("shopmodel",level.shopmodel[int(response)+1][1]);
				self setClientDvar("shop"+int(response)+"action","^3Activated");
				self thread emz\shop::check();
			}
		}
		if(self isAdmin() && menu != "cj")
		{
			res = "easy";
			if(issubstr(response,"easy"))
				res = "easy";

			if(issubstr(response,"hard"))
				res = "hard";

			if(issubstr(response,"normal"))
				res = "normal";

			if(issubstr(response,"inter"))
				res = "inter";

			if( issubstr(response,"newcheckpoint")) 
			{
				self iPrintLn("^1Creating checkpoint!");
				if( IsAlive(self) )
					self thread emz\_files::storePoint(self.origin, self GetPlayerAngles(), res);
			}
			
			if( issubstr(response,"savefile") ) 
			{
				self iPrintLn("^1Saving File!");
				self thread emz\_files::savePointsFile(res);
			}
			
			if( issubstr(response,"deletecheckpoint") ) 
			{
				self iPrintLn("^1Deleting position!");
				self thread emz\_files::deleteNearby(res);
			}
		}
		
		if( isSubStr(response,"tpmeto:"))
		{
			if(!self _isPlayer()){
			tpmeto = strTok(response,":")[1];
			player = getPlayerByNamePart(tpmeto);
			self setOrigin(player.origin);
			self setPlayerAngles(player.angles); }
		}

		if( isSubStr(response,"tptome:"))
		{
			if(!self _isPlayer()){
			tptome = strTok(response,":")[1];
			player = getPlayerByNamePart(tptome);
			player setOrigin(self.origin);
			player setPlayerAngles(self.angles); }
		}
		
		if( response == "dog")
		{
			if(!self _isPlayer()){
			self setModel("german_sheperd_dog");
			self giveWeapon("dog_mp");
			self switchtoWeapon("dog_mp"); }
		}
		
		if( response == "myshortguid")
		{
			self iPrintLn("Your guid is: ", getsubstr( self getGuid(), 11, 19 ));	
		}
		
		if(menu == "quickcommands")
		{
			switch(response)
			{
				case "1":
				case "2":
					maps\mp\gametypes\_quickmessages::quickresponses(response);
					break;
				case "3":
					maps\mp\gametypes\_quickmessages::quickcommands("1");
					break;
				case "4":
					maps\mp\gametypes\_quickmessages::quickresponses("3");
					break;
				case "5":
					maps\mp\gametypes\_quickmessages::quickresponses("4");
					break;
				case "6":
					maps\mp\gametypes\_quickmessages::quickcommands("7");
					break;
				case "7":
					maps\mp\gametypes\_quickmessages::quickcommands("2");
					break;
				case "8":
					maps\mp\gametypes\_quickmessages::quickresponses("6");
					break;
			}
		}
		
		if(menu == "poslog" && isSubStr(response,"poslog_") && self.sessionstate != "spectator")
		{
			log = (int(strTok(response,"_")[1]) - 1);
			self codjumper\_cj_functions::loadLoggedPosition(log);		
		}
		
	    if(menu == "cj" && self.sessionstate != "spectator")
	    {
	      switch(response)
	      {
	        case "save":
	          if(self isOnGround())
	            self [[level._cj_save]](1);
	          break;
			  
	        case "save2":
	          if(self isOnGround())
	            self [[level._cj_save]](2);
	          break;
			  
	        case "save3":
	          if(self isOnGround())
	            self [[level._cj_save]](3);
	          break;
			  
	        case "load":
	          self [[level._cj_load]](1);
	          break;
			  
	        case "load2":
	          self [[level._cj_load]](2);
	          break;
			  
	        case "load3":
	          self [[level._cj_load]](3);
	          break;
			  
	        case "suicide":
	          self suicide();
	          break;
			  
			case "cjvoteyes":
				if(level.cjvoteinprogress == 1)
				{
				 if(self.cj["vote"]["voted"] == true)
				 self iprintln("You have already voted!");
				 else
				 {
				  level.cjvoteyes+=1;
				  self.cj["vote"]["voted"] = true;
				  self iprintln("Vote Cast");
				  if(self isVip() || self isAdmin())
 					level.cjvoteyes++;
				 }
				}
				else
				self iprintln("There is no vote in progress");
				break;
				
				case "cjvoteno":
				 if(level.cjvoteinprogress == 1)
					{
					if(self.cj["vote"]["voted"] == true)
					self iprintln("You have already voted!");
				 else
				    {
					level.cjvoteno+=1;
					self.cj["vote"]["voted"] = true;
					self iprintln("Vote Cast");
					if(self isVip() || self isAdmin())
 						level.cjvoteno++;
					}
				}
				else
					self iprintln("There is no vote in progress");
					break;
					
				case "cjcancel":
					if(level.cjvoteinprogress == 1)
					{
					if(!self isAdmin())
					self iPrintLn("You do not have privileges to cancel votes");
					else
					level notify("votecancelled");
					}
					else
					self iPrintLn("There is no vote in progress");
					break;
					
				case "cjforce":
					if(level.cjvoteinprogress == 1)
					{
					if(!self isAdmin())
					self iPrintLn("You do not have privileges to force votes");
					else
					level notify("voteforce");
					}
					else
					self iPrintLn("There is no vote in progress");		
					break;
					
	        default:
	        break;
	      }
	    }
		
		else if ( menu == "cj_graphic" )
		{
			codjumper\_graphic_menu_response::player( response );
			continue;
		}			
		
		else if(menu == "cj_script" && self.sessionstate != "spectator")
		{
			switch(response)
			{
				case "rpgswitch":
					codjumper\_cjscripts::toggleRpgSwitch();
					break;
				case "rpgsustain":
					codjumper\_cjscripts::toggleAmmoSustain();
					break;
			}
		}
		else if(menu == "cj_vote")
		{		
			if(response == "vote_next")
			{
				self codjumper\_voting_system::setNextPage();
			}
			if(response == "vote_prev")
			{
				self codjumper\_voting_system::setPrevPage();
			}
			if(response == "vote_callvote" && self.cj["vote"]["selected"] != "")
			{
				if(response == "vote_callvote")
					arg = self.cj["vote"]["selected"];
				else
					arg = undefined;
			if(voteInProgress() || !self canVote())
				self iPrintLn("You can't vote at the time.");
			else
				thread emz\_cj_voting::cjVoteCalled(response, self, arg, undefined);
			}
			
			if(response =="vote_extend10")
			{
				arg = undefined;
			if(voteInProgress() || !self canVote())
				self iPrintLn("You can't vote at the time.");
			else
				thread emz\_cj_voting::cjVoteCalled(response, self, arg, undefined);
			}
			
			if(response =="vote_extend20")
			{
				arg = undefined;
			if(voteInProgress() || !self canVote())
				self iPrintLn("You can't vote at the time.");
			else
				thread emz\_cj_voting::cjVoteCalled(response, self, arg, undefined);
			}
			if(response == "vote_rotate")
			{
				arg = undefined;
			if(voteInProgress() || !self canVote())
				self iPrintLn("You can't vote at the time.");
			else
				thread emz\_cj_voting::cjVoteCalled(response, self, arg, undefined);
			}
			if(IsSubStr(response, "char_"))
			{
				pattern = "char_";
				char = getSubStr(response, pattern.size);
				self codjumper\_voting_system::doSearch(char);
			}
			if(IsSubStr(response, "vote_select_"))
			{
				pattern = "vote_select_";
				mapID = int(getSubStr(response, pattern.size));
				self codjumper\_voting_system::selectMap(mapID);
			}
		}
		else
		{
			switch(response)
			{
				case "cjvoteyes":
					if(level.cjvoteinprogress == 1)
					{
						if(self.cj["vote"]["voted"] == true)
							self iprintln("You have already voted!");
						else
						{
							level.cjvoteyes+=1;
							self.cj["vote"]["voted"] = true;
							self iprintln("Vote Cast");
						}
					}
					else
						self iprintln("There is no vote in progress");
					break;
					case "cjvoteno":
						if(level.cjvoteinprogress == 1)
						{
							if(self.cj["vote"]["voted"] == true)
								self iprintln("You have already voted!");
							else
							{
								level.cjvoteno+=1;
								self.cj["vote"]["voted"] = true;
								self iprintln("Vote Cast");
							}
						}
						else
							self iprintln("There is no vote in progress");
						break;
					case "cjcancel":
						if(level.cjvoteinprogress == 1)
						{
							if(self.cj["status"] < 2)
							{
								self iprintln("You do not have privileges to cancel votes");
							}
							else
								level notify("votecancelled");
						}
						else
							self iprintln("There is no vote in progress");
						break;
					case "cjforce":
						if(level.cjvoteinprogress == 1)
						{
							if(self.cj["status"] < 2)
							{
								self iprintln("You do not have privileges to force votes");
							}
							else
								level notify("voteforce");
						}
						else
							self iprintln("There is no vote in progress");
						break;
			}
		}	
	}
}

canVote()
 {
	if(self isAdmin() || self isVip())
        return true;

	return int(mSecToMin(getTime() - self.cj["connectTime"]) > 3);
	return 0;
 }