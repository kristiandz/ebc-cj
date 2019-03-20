#include codjumper\_cj_utility;

playerList()
{
	self endon("disconnect");
	i = 0;
	self.cj["vote"]["player"] = i;
	self setClientDvar("ui_cj_player", level.players[i].name);
	self.cj["vote"]["playerent"] = level.players[i] getEntityNumber();

	for(;;)
	{
		self waittill("playerlist");
		if(!isDefined(self.cj["vote"]["dir"]))
			self.cj["vote"]["dir"] = "next";

		if(self.cj["vote"]["dir"] == "next")
		{
			i++;
			if(i >= level.players.size)
			i = 0;
			self setClientDvar("ui_cj_player", level.players[i].name);
			self.cj["vote"]["playerent"] = level.players[i] getEntityNumber();
			self.cj["vote"]["player"] = i;
		}
		else if(self.cj["vote"]["dir"] == "prev")
		{
			i--;
			if(i < 0)
			i = level.players.size - 1;
			self setClientDvar("ui_cj_player", level.players[i].name);
			self.cj["vote"]["playerent"] = level.players[i] getEntityNumber();
			self.cj["vote"]["player"] = i;
		}
	}
}

mapBrowse()
{
	self endon("disconnect");
	i = 0;
	self.cj["vote"]["map"] = level.maplist[i];
	self setClientDvar("ui_cj_map", level.maplist[i]);

	for(;;)
	{
		self waittill("maplist");

		if(self.cj["vote"]["dir"] == "mnext")
		{
			i++;
			if(i >= level.maplist.size)
				i = 0;
			self setClientDvar("ui_cj_map", level.maplist[i]);
			self.cj["vote"]["map"] = level.maplist[i];
		}
		else if(self.cj["vote"]["dir"] == "mprev")
		{
			i--;
			if(i < 0)
				i = level.maplist.size - 1;
			self setClientDvar("ui_cj_map", level.maplist[i]);
			self.cj["vote"]["map"] = level.maplist[i];
		}
	}
}

cjVoteCalled(vote, player, arg, time)
{
	level endon ("votecancelled");
	level endon ("voteforce");

	if(!isDefined(time)) time = level.cjvoteduration;
	if(!isDefined(arg)) arg = -1;

	if(voteInProgress())
		return;

	if(vote == "kick")
	{
		if(level.players[arg] isAdmin())
		{
			player iprintln("Player cannot be kicked!");
			return;
		}
		level.cjvoteagainst = level.players[arg] getEntityNumber();
	}

	level.cjvoteinprogress = 1;
	level.cjvotearg = arg;

	if(isDefined(player))
	{
		iPrintLn("Vote called by:  " + monotone(player.name));
		level.cjvotecalled = player getEntityNumber();
	}

	switch(vote)
	{
		case "vote_callvote":
			level.cjvotetype = "Vote: Change Map";
			break;
		case "vote_extend10":
			level.cjvotetype = "Vote: Extend For 10 Min";
			break;
		case "vote_extend20":
			level.cjvotetype = "Vote: Extend For 20 Min";
			break;
		case "vote_rotate":
			level.cjvotetype = "Vote: Rotate Map";
			break;
		case "kick":
			level.cjvotetype = "Vote: Kick Player";
			break;
		default:
			level.cjvotetype = "Vote: Other";
			break;
	}

	for(i=0;i<level.players.size;i++)
	{
		level.players[i] thread startCountdown(time);			
		level.players[i] thread createVoteHud();

		if(i == arg && vote == "kick")
			thread watchPlayer(level.players[i]);
	}

	if(isDefined(player) && player.cj["vote"]["voted"] == false )
	{
		player.cj["vote"]["voted"] = true;
		level.cjvoteyes++;
	}

	if(level.players.size > 1)
		wait time;

	iPrintLn("Voted - Yes: ^2" + level.cjvoteyes + "^7 No: ^1" + level.cjvoteno);

	if(level.cjvoteyes > level.cjvoteno)
	{
		iprintln("Vote Passed");
		thread compareAndAction(level.cjvotetype, undefined, level.cjvotearg);
	}
	else
		iprintln("Vote Failed");

	level notify("vote_completed", int(level.cjvoteyes > level.cjvoteno));

	for(i=0;i<level.players.size;i++)
	{
		level.players[i] thread removeVoteHud();
		level.players[i].cj["vote"]["voted"] = false;
	}

	level.cjvoteyes = 0;
	level.cjvoteno = 0;
	level.cjvotetype = "";
	level.cjvotecalled = "";
	level.cjvotearg = undefined;

	wait level.cjvotedelay;
	level.cjvoteinprogress = 0;
}

watchPlayer(player)
{
	while(level.cjvoteinprogress)
	{
		if(!isDefined(player))
			level notify("votecancelled");
		wait 0.5;
	}
}

compareAndAction(vote, against, arg)
{
	switch(vote)
	{
		case "Vote: Kick Player":
			if(against == (level.players[arg] getEntityNumber()))
				kick(level.players[arg] getEntityNumber());
			else
				iprintln("Something went wrong");
			wait 0.05;
			for(i=0;i<level.players.size;i++)
				level.players[i] notify("playerlist");
			break;
		case "Vote: Extend For 10 Min":
			setDvar("scr_cj_timelimit", getDvarInt("scr_cj_timelimit") + 10);
			break;
		case "Vote: Extend For 20 Min":
			setDvar("scr_cj_timelimit", getDvarInt("scr_cj_timelimit") + 20);
			break;
		case "Vote: Rotate Map":
			thread maps\mp\gametypes\_globallogic::endGame();
			break;
		case "Vote: Change Map":
			rotation = " map " + self.cj["vote"]["selected"] + " " + getDvar("sv_mapRotationCurrent");
			setDvar( "sv_mapRotationCurrent", rotation);
			thread maps\mp\gametypes\_globallogic::endgame();
			break;
	}
}

voteCancelled()
{
	level endon ("game_ended");
	while(1)
	{
		level waittill("votecancelled");

		for(i=0;i<level.players.size;i++)
		{
			level.players[i].cj["vote"]["voted"] = false;
			level.players[i] thread removeVoteHud();
		}

		level.cjvoteinprogress = 0;
		level.cjvoteyes = 0;
		level.cjvoteno = 0;
		level.cjvotetype = "";
		level.cjvotecalled = "";
		level.cjvoteagainst = "";
		level.cjvotearg = undefined;

		iprintln("Vote Cancelled!");
	}
}

voteForced()
{
	level endon ("game_ended");
	while(1)
	{
		level waittill("voteforce");

		for(i=0;i<level.players.size;i++)
		{
			level.players[i].cj["vote"]["voted"] = false;
			level.players[i] thread removeVoteHud();
		}

		level.cjvoteinprogress = 0;
		level.cjvoteyes = 0;
		level.cjvoteno = 0;

		thread compareAndAction(level.cjvotetype, level.cjvoteagainst, level.cjvotearg);

		level.cjvotetype = "";
		level.cjvotecalled = "";
		level.cjvoteagainst = "";
		level.cjvotearg = undefined;
		iprintln("Vote Forced!");
	}
}
