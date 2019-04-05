/*						 __    __     _____
   ____ ___  ____       / /_  / /_  _|__  /
  / __ `__ \/ __ \     / __ \/ / / / //_ < 
 / / / / / / /_/ /    / /_/ / / /_/ /__/ / 
/_/ /_/ /_/ .___/____/_.___/_/\__,_/____/  
         /_/   /_____/                 
   _____           _       __          __         	 ______                               
  / ___/__________(_)___  / /______   / /_  __  __	/_  __/___  ____ ___  ____ ___  __  __
  \__ \/ ___/ ___/ / __ \/ __/ ___/  / __ \/ / / /	 / / / __ \/ __ `__ \/ __ `__ \/ / / /
 ___/ / /__/ /  / / /_/ / /_(__  )  / /_/ / /_/ / 	/ / / /_/ / / / / / / / / / / / /_/ / 
/____/\___/_/  /_/ .___/\__/____/  /_.___/\__, /   / / / /_/ / / / / / / / / / / / /_/ / 
                /_/                      /____/   /_/  \____/_/ /_/ /_/_/ /_/ /_/\__, /  	
																				/____/   
									XFire: noheadman											
*/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

main()
{
	maps\mp\_load::main();
	maps\mp\_compass::setupMiniMap("compass_map_mp_blu3");
	setDvar("r_specularcolorscale", "1");
	
	game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";
	
	thread musicTrigger1();
	thread musicTrigger2();
	thread musicTrigger3();
	thread musicTrigger4();
	thread musicOffTrigger();
	thread teleportEasy();
	thread teleportInter();
	thread teleportHard();
	thread easy_end();
	thread intermediate_end();
	thread hard_end();
	thread sound1();
	thread sound1_1();
	thread sound2();
	thread sound2_1();
	thread sound2_2();
	thread sound3();
	thread sound3_1();
	thread sound3_2();
	thread sound4();
	thread sound4_1();
	thread sound4_2();
	thread sound4_3();
	thread sound5();
	thread sound5_1();
	thread sound5_2();
	thread sound5_3();
	thread sound6();
	thread sound7();
	thread sound7_1();
	thread sound7_2();
	thread sound8();
	thread sound8_1();
	thread sound9();
	thread credits();
	thread sniper();
	thread sniper2();
	thread m4silenced();
	thread brickblaster();

	thread onPlayerConnect();
}

onPlayerConnect()
{
	level endon("game_ended");
	
	for(;;)
	{
		level waittill("connected", player);
		
		player.music1Playing = false;
		player.music2Playing = false;
		player.music3Playing = false;
		player.music4Playing = false;
		player.sound1 = false;
		player.sound1_1 = false;
		player.sound2 = false;
		player.sound2_1 = false;
		player.sound2_2 = false;
		player.sound3 = false;
		player.sound3_1 = false;
		player.sound3_2 = false;
		player.sound4 = false;
		player.sound4_1 = false;
		player.sound4_2 = false;
		player.sound4_3 = false;
		player.sound5 = false;
		player.sound5_1 = false;
		player.sound5_2 = false;
		player.sound5_3 = false;
		player.sound6 = false;
		player.sound7 = false;
		player.sound7_1 = false;
		player.sound7_2 = false;
		player.sound8 = false;
		player.sound8_1 = false;
		player.sound9 = false;
		player.creditsc = false;
		player.easyc = false;
		player.hardc = false;
		player.intermediatec = false;
		
		player setClientDvar("compassmaxrange", "25000");
	}
}

sniper()
{
	trigger = getEnt("sniper","targetname");
	
	for(;isDefined(trigger);wait 0.05)
	{
		trigger waittill("trigger", player);
		
		if(!player hasWeapon("m40a3_mp"))
		{
			player iprintlnbold("^3You Have Taken ^5[^2m40a3 Sniper^5]");
			player giveWeapon("m40a3_mp");
			player switchToWeapon("m40a3_mp");
		}
	}
}

sniper2()
{
	trigger = getEnt("sniper2","targetname");
	
	for(;isDefined(trigger);wait 0.05)
	{
		trigger waittill("trigger", player);
		
		if(!player hasWeapon("m40a3_mp"))
		{
			player iprintlnbold("^3You Have Taken ^5[^2m40a3 Sniper^5]");
			player giveWeapon("m40a3_mp");
			player switchToWeapon("m40a3_mp");
		}
	}
}

m4silenced()
{
	trigger = getEnt("m4silenced","targetname");
	
	for(;isDefined(trigger);wait 0.05)
	{
		trigger waittill("trigger", player);
		
		if(!player hasWeapon("m4_silencer_mp"))
		{
			player iprintlnbold("^3You Have Taken ^5[^2Silenced M4^5]");
			player giveWeapon("m4_silencer_mp");
			player switchToWeapon("m4_silencer_mp");
		}
	}
}

brickblaster()
{
	trigger = getEnt("brickblaster","targetname");
	
	for(;isDefined(trigger);wait 0.05)
	{
		trigger waittill("trigger", player);
		
		if(!player hasWeapon("brick_blaster_mp"))
		{
			player iprintlnbold("^3You Have Taken ^5[^2Brick Blaster^5]");
			player giveWeapon("brick_blaster_mp");
			player switchToWeapon("brick_blaster_mp");
		}
	}
}

credits()
{
	trig = getEnt("credits", "targetname");
	
	for(;isDefined(trig);wait 0.05)
	{
		trig waittill("trigger", player);
		
		if(!player.creditsc)
		{
			player.creditsc = true;
			player.credits = newClientHudElem(player);
			player.credits.alignX = "center";
			player.credits.alignY = "middle";
			player.credits.horzalign = "center";
			player.credits.vertalign = "middle";
			player.credits.alpha = 1;
			player.credits.x = 0;
			player.credits.y = 0;
			player.credits.font = "objective";
			player.credits.fontscale = 2;
			player.credits.glowalpha = 1;
			player.credits.glowcolor = (1,0,0);
			player.credits.label = &"mp_blu3 created by Chucky., have fun!";
			player.credits SetPulseFX( 40, 5400, 200 );
			wait 6;
			player.credits.label = &"Chucky.'s Xfire: chucky3379";
			player.credits SetPulseFX( 40, 5400, 200 );
			wait 6;
			player.credits.label = &"^3Thanks to ^2Tommy ^3for help";
			player.credits SetPulseFX( 40, 5400, 200 );
			wait 6;
			player.credits.label = &"^3Oh and ... no animals were hurt during making of this map :D";
			player.credits SetPulseFX( 40, 5400, 200 );
			wait 6;
			player.creditsc = false;
		}
	}
}

sound1()
{
	trigger = getEnt("amazing", "targetname");
	
	for(;isDefined(trigger);wait 0.05)
	{
		trigger waittill("trigger", player);
		
		if(!player.sound1)
		{
			player playLocalSound("amazing");
			player.sound1 = true;
		}
	}
}

sound1_1()
{
	trigger = getEnt("amazing1", "targetname");
	
	for(;isDefined(trigger);wait 0.05)
	{
		trigger waittill("trigger", player);
		
		if(!player.sound1_1)
		{
			player playLocalSound("amazing");
			player.sound1_1 = true;
		}
	}
}

sound2()
{
	trigger = getEnt("bitchhurt1", "targetname");
	
	for(;isDefined(trigger);wait 0.05)
	{
		trigger waittill("trigger", player);
		
		if(!player.sound2)
		{
			player playLocalSound("bitchhurt");
			player.sound2 = true;
		}
	}
}

sound2_1()
{
	trigger = getEnt("bitchhurt2", "targetname");
	
	for(;isDefined(trigger);wait 0.05)
	{
		trigger waittill("trigger", player);
		
		if(!player.sound2_1)
		{
			player playLocalSound("bitchhurt");
			player.sound2_1 = true;
		}
	}
}

sound2_2()
{
	trigger = getEnt("bitchhurt", "targetname");
	
	for(;isDefined(trigger);wait 0.05)
	{
		trigger waittill("trigger", player);
		
		if(!player.sound2_2)
		{
			player playLocalSound("bitchhurt");
			player.sound2_2 = true;
		}
	}
}

sound3()
{
	trigger = getEnt("dontfuck", "targetname");
	
	for(;isDefined(trigger);wait 0.05)
	{
		trigger waittill("trigger", player);
		
		if(!player.sound3)
		{
			player playLocalSound("dontfuck");
			player.sound3 = true;
		}
	}
}

sound3_1()
{
	trigger = getEnt("dontfuck1", "targetname");
	
	for(;isDefined(trigger);wait 0.05)
	{
		trigger waittill("trigger", player);
		
		if(!player.sound3_1)
		{
			player playLocalSound("dontfuck");
			player.sound3_1 = true;
		}
	}
}

sound3_2()
{
	trigger = getEnt("dontfuck2", "targetname");
	
	for(;isDefined(trigger);wait 0.05)
	{
		trigger waittill("trigger", player);
		
		if(!player.sound3_2)
		{
			player playLocalSound("dontfuck");
			player.sound3_2 = true;
		}
	}
}

sound4()
{
	trigger = getEnt("fuckingkidding", "targetname");
	
	for(;isDefined(trigger);wait 0.05)
	{
		trigger waittill("trigger", player);
		
		if(!player.sound4)
		{
			player playLocalSound("fuckingkidding");
			player.sound4 = true;
		}
	}
}

sound4_1()
{
	trigger = getEnt("fuckingkidding1", "targetname");
	
	for(;isDefined(trigger);wait 0.05)
	{
		trigger waittill("trigger", player);
		
		if(!player.sound4_1)
		{
			player playLocalSound("fuckingkidding");
			player.sound4_1 = true;
		}
	}
}

sound4_2()
{
	trigger = getEnt("fuckingkidding2", "targetname");
	
	for(;isDefined(trigger);wait 0.05)
	{
		trigger waittill("trigger", player);
		
		if(!player.sound4_2)
		{
			player playLocalSound("fuckingkidding");
			player.sound4_2 = true;
		}
	}
}

sound4_3()
{
	trigger = getEnt("fuckingkidding3", "targetname");
	
	for(;isDefined(trigger);wait 0.05)
	{
		trigger waittill("trigger", player);
		
		if(!player.sound4_3)
		{
			player playLocalSound("fuckingkidding");
			player.sound4_3 = true;
		}
	}
}

sound5()
{
	trigger = getEnt("laugh", "targetname");
	
	for(;isDefined(trigger);wait 0.05)
	{
		trigger waittill("trigger", player);
		
		if(!player.sound5)
		{
			player playLocalSound("laugh");
			player.sound5 = true;
		}
	}
}

sound5_1()
{
	trigger = getEnt("laugh1", "targetname");
	
	for(;isDefined(trigger);wait 0.05)
	{
		trigger waittill("trigger", player);
		
		if(!player.sound5_1)
		{
			player playLocalSound("laugh");
			player.sound5_1 = true;
		}
	}
}

sound5_2()
{
	trigger = getEnt("laugh2", "targetname");
	
	for(;isDefined(trigger);wait 0.05)
	{
		trigger waittill("trigger", player);
		
		if(!player.sound5_2)
		{
			player playLocalSound("laugh");
			player.sound5_2 = true;
		}
	}
}

sound5_3()
{
	trigger = getEnt("laugh3", "targetname");
	
	for(;isDefined(trigger);wait 0.05)
	{
		trigger waittill("trigger", player);
		
		if(!player.sound5_3)
		{
			player playLocalSound("laugh");
			player.sound5_3 = true;
		}
	}
}

sound6()
{
	trigger = getEnt("problemkilling", "targetname");
	
	for(;isDefined(trigger);wait 0.05)
	{
		trigger waittill("trigger", player);
		
		if(!player.sound6)
		{
			player playLocalSound("problemkilling");
			player.sound6 = true;
		}
	}
}

sound7()
{
	trigger = getEnt("sucker", "targetname");
	
	for(;isDefined(trigger);wait 0.05)
	{
		trigger waittill("trigger", player);
		
		if(!player.sound7)
		{
			player playLocalSound("sucker");
			player.sound7 = true;
		}
	}
}

sound7_1()
{
	trigger = getEnt("sucker1", "targetname");
	
	for(;isDefined(trigger);wait 0.05)
	{
		trigger waittill("trigger", player);
		
		if(!player.sound7_1)
		{
			player playLocalSound("sucker");
			player.sound7_1 = true;
		}
	}
}

sound7_2()
{
	trigger = getEnt("sucker2", "targetname");
	
	for(;isDefined(trigger);wait 0.05)
	{
		trigger waittill("trigger", player);
		
		if(!player.sound7_2)
		{
			player playLocalSound("sucker");
			player.sound7_2 = true;
		}
	}
}

sound8()
{
	trigger = getEnt("thingtosay", "targetname");
	
	for(;isDefined(trigger);wait 0.05)
	{
		trigger waittill("trigger", player);
		
		if(!player.sound8)
		{
			player playLocalSound("thingtosay");
			player.sound8 = true;
		}
	}
}

sound8_1()
{
	trigger = getEnt("thingtosay1", "targetname");
	
	for(;isDefined(trigger);wait 0.05)
	{
		trigger waittill("trigger", player);
		
		if(!player.sound8_1)
		{
			player playLocalSound("thingtosay");
			player.sound8_1 = true;
		}
	}
}

sound9()
{
	trigger = getEnt("whothefuck", "targetname");
	
	for(;isDefined(trigger);wait 0.05)
	{
		trigger waittill("trigger", player);
		
		if(!player.sound9)
		{
			player playLocalSound("whothefuck");
			player.sound9 = true;
		}
	}
}

musicTrigger1()
{
	trigger = getEnt("music1", "targetname");
	
	for(;isDefined(trigger);wait 0.05)
	{
		trigger waittill("trigger", player);
		
		if(!player.music1Playing)
		{
			player thread playMusic(1);
		}
	}
}

musicTrigger2()
{
	trigger = getEnt("music2", "targetname");
	
	for(;isDefined(trigger);wait 0.05)
	{
		trigger waittill("trigger", player);
		
		if(!player.music2Playing)
		{
			player thread playMusic(2);
		}
	}
}

musicTrigger3()
{
	trigger = getEnt("music3", "targetname");
	
	for(;isDefined(trigger);wait 0.05)
	{
		trigger waittill("trigger", player);
		
		if(!player.music3Playing)
		{
			player thread playMusic(3);
		}
	}
}

musicTrigger4()
{
	trigger = getEnt("music4", "targetname");
	
	for(;isDefined(trigger);wait 0.05)
	{
		trigger waittill("trigger", player);
		
		if(!player.music4Playing)
		{
			player thread playMusic(4);
		}
	}
}

playMusic(num)
{
	self endon("disconnect");
	
	ambientStop(0);
	
	switch(num)
	{
		case 1:
			self iPrintLn("^3Now playing: ^1Eminem ^7- ^1Berzerk");
			self playLocalSound("song1");
			self.music1Playing = true;
			self.music2Playing = false;
			self.music3Playing = false;
			self.music4Playing = false;
			wait 248;
			self.music1Playing = false;
			break;
		case 2:
			self iPrintLn("^3Now playing: ^1Hopsin ^7- ^1Am I A Pyscho");
			self playLocalSound("song2");
			self.music1Playing = false;
			self.music2Playing = true;
			self.music3Playing = false;
			self.music4Playing = false;
			wait 247;
			self.music2Playing = false;
			break;
		case 3:
			self iPrintLn("^3Now playing: ^1SwizZz ^7- ^1Flu Shot");
			self playLocalSound("song3");
			self.music1Playing = false;
			self.music2Playing = false;
			self.music3Playing = true;
			self.music4Playing = false;
			wait 181;
			self.music3Playing = false;
			break;
		case 4:
			self iPrintLn("^3Now playing: ^150 Cent ^7- ^1Murder One");
			self playLocalSound("song4");
			self.music1Playing = false;
			self.music2Playing = false;
			self.music3Playing = false;
			self.music4Playing = true;
			wait 174;
			self.music4Playing = false;
			break;
		default:
			break;
	}
}

musicOffTrigger()
{
	trigger = getEnt("musicstop", "targetname");
	
	for(;isDefined(trigger);wait 0.05)
	{
		trigger waittill("trigger", player);
		
		if(player.music1Playing || player.music2Playing || player.music3Playing || player.music4Playing)
		{
			player playLocalSound("stop");
			player iPrintLn("^3Music ^1Stoped");
			
			player.music1Playing = false;
			player.music2Playing = false;
			player.music3Playing = false;
			player.music4Playing = false;
		}
	}
}

teleportEasy()
{
	easy = getEnt("easy","targetname");
	
	for(;isDefined(easy);wait 0.05)
	{
		easy waittill("trigger", player);
		
		player.easy = newClientHudElem(player);
		player.easy.x = 0;
		player.easy.y = 0;
		player.easy.alignX = "left";		
		player.easy.alignY = "top";
		player.easy.horzAlign = "fullscreen";
		player.easy.vertAlign = "fullscreen";
		player.easy.alpha = 0;
		player.easy.color = (0,0,0);
		player.easy setshader("black", 640, 480);
		
		player.easy fadeOverTime(1);
		player.easy.alpha = 1;
		wait 1;
		
		player setOrigin((-2100, -5640, 416));
		player setPlayerAngles((0, 180, 0));
		
		wait 1;
		
		player.easy fadeOverTime(1);
		player.easy.alpha = 0;
		wait 1;
		
		player.easy destroy();
	}
}

teleportInter()
{
	inter = getEnt("inter","targetname");
	
	for(;isDefined(inter);wait 0.05)
	{
		inter waittill("trigger", player);
		
		player.inter = newClientHudElem(player);
		player.inter.x = 0;
		player.inter.y = 0;
		player.inter.alignX = "left";		
		player.inter.alignY = "top";
		player.inter.horzAlign = "fullscreen";
		player.inter.vertAlign = "fullscreen";
		player.inter.alpha = 0;
		player.inter.color = (0,0,0);
		player.inter setshader("black", 640, 480);
		
		player.inter fadeOverTime(1);
		player.inter.alpha = 1;
		wait 1;
		
		player setOrigin((-1171, -1053, 1819));
		player setPlayerAngles((0, 180, 0));
		
		wait 1;

		player.inter fadeOverTime(1);			
		player.inter.alpha = 0;
		wait 1;

		player.inter destroy();
	}
}

teleportHard()
{
	hard = getEnt("hard","targetname");
	
	for(;isDefined(hard);wait 0.05)
	{
		hard waittill("trigger", player);
		
		player.hard = newClientHudElem(player);
		player.hard.x = 0;
		player.hard.y = 0;
		player.hard.alignX = "left";		
		player.hard.alignY = "top";
		player.hard.horzAlign = "fullscreen";
		player.hard.vertAlign = "fullscreen";
		player.hard.alpha = 0;
		player.hard.color = (0,0,0);
		player.hard setshader("black", 640, 480);
		
		player.hard fadeOverTime(1);
		player.hard.alpha = 1;
		wait 1;
		
		player setOrigin((4116, 299, 1579));
		player setPlayerAngles((0, 270, 0));
		
		wait 1;
		
		player.hard fadeOverTime(1);
		player.hard.alpha = 0;
		wait 1;
		
		player.hard destroy();
	}
}

easy_end()
{
	end = getEnt("easyend", "targetname");
	
	for(;isDefined(end);wait 0.05)
	{
		end waittill("trigger", player);
		
		if(isDefined(player.easyc) && !player.easyc )
		{
			player iPrintLnBold("^3Congratulations ^2" + player.name + "^3, you have completed ^2Easy ^3way!");
			player.easyc = true;
		}
		
		if(!player hasWeapon("brick_blaster_mp"))
		{
			player giveWeapon("brick_blaster_mp");
			player switchToWeapon("brick_blaster_mp");
		}
	}
}

intermediate_end()
{
	end = getEnt("interend", "targetname");
	
	for(;isDefined(end);wait 0.05)
	{
		end waittill("trigger", player);
		
		if(!player.intermediatec && isDefined(player.intermediatec))
		{
			player iPrintLnBold("^3Congratulations ^2" + player.name + "^3, you have completed ^1Intermediate ^3way!");
			player.intermediatec = true;
		}
		
		if(!player hasWeapon("brick_blaster_mp"))
		{
			player giveWeapon("brick_blaster_mp");
			player switchToWeapon("brick_blaster_mp");
		}
	}
}

hard_end()
{
	end = getEnt("hardend", "targetname");
	
	for(;isDefined(end);wait 0.05)
	{
		end waittill("trigger", player);
		
		if(!player.hardc && isDefined(player.hardc))
		{
			iPrintLnBold("^3Congratulations ^2" + player.name + "^3, has completed ^1Hard ^3way!");
			player.hardc = true;
		}
		
		if(!player hasWeapon("usp_mp"))
		{
			player giveWeapon("usp_mp");
			player switchToWeapon("usp_mp");
		}
	}
}