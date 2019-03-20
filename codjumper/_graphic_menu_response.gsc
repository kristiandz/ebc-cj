#include codjumper\_cj_utility;

player(response)
{
	self endon ( "disconnect" );

	switch(response)
	{
		case "wasd":
			if(self GetStat(1225) == 0)       {self SetStat(1225,1);}
			else if(self GetStat(1225) == 1)  {self SetStat(1225,2);}
			else if(self GetStat(1225) == 2)  {self SetStat(1225,0);}
			break;
			
		case "graphic_fx":
			if(self GetStat(1302)==0) 	   	  {self setclientdvar("fx_enable", int(1)); self SetStat(1302, 1);}
			else if(self GetStat(1302)==1) 	  {self setclientdvar("fx_enable", int(0)); self SetStat(1302, 0);}
			break;
			
		case "third_on":
			if(self GetStat(1303) == 0)	      {self setClientDvar("cg_thirdperson", int(1)); self SetStat(1303,1);}
			else if(self GetStat(1303) == 1)  {self setClientDvar("cg_thirdperson", int(0)); self SetStat(1303,0);}
			break;
			
		case "third_range":
			if(self getStat(1304) == 0 ) 	  {self setclientdvar("cg_thirdpersonrange", int(200)); self SetStat(1304,1);}
			else if(self getStat(1304) == 1 ) {self setclientdvar("cg_thirdpersonrange", int(300)); self SetStat(1304,2);}
			else if(self getStat(1304) == 2 ) {self setclientdvar("cg_thirdpersonrange", int(50));  self SetStat(1304,3);}
			else if(self getStat(1304) == 3 ) {self setclientdvar("cg_thirdpersonrange", int(120)); self SetStat(1304,0);}
			break;
			
		case "third_rotate":
			if(self getStat(1305) == 0 ) 	  {self setclientdvar("cg_thirdpersonangle", int(90));  self SetStat(1305,1);}
			else if(self getStat(1305) == 1 ) {self setclientdvar("cg_thirdpersonangle", int(180)); self SetStat(1305,2);}
			else if(self getStat(1305) == 2 ) {self setclientdvar("cg_thirdpersonangle", int(270)); self SetStat(1305,3);}
			else if(self getStat(1305) == 3 ) {self setclientdvar("cg_thirdpersonangle", int(0));   self SetStat(1305,0);}
			break;
			
		case "graphic_drawdecals":
			if(self getStat(1306) == 0 )      {self setClientDvar("r_drawdecals", int(1)); self SetStat(1306,1);}
			else if(self getStat(1306) == 1 ) {self setClientDvar("r_drawdecals", int(0)); self SetStat(1306,0);}
			break;
			
		case "graphic_fog":
			if(self getStat(1307) == 0 )      {self setClientDvar("r_fog", int(1)); self SetStat(1307,1);}
			else if(self getStat(1307) == 1 ) {self setClientDvar("r_fog", int(0)); self SetStat(1307,0);}
			break;
			
		case "graphic_drawdistance":
			stat = self loopthrough_cjcfg("CJ_DRAW", 16);
			self setclientdvar("r_zfar", 250 * int(stat));
			self setStat(1308,int(stat));
			break;
		
		case "sounds":
			if(self getstat(1224) == 0 )
			self setstat(1224,1);
		    else if(self getstat(1224) == 1 )
			self setstat(1224,0);				
			break;		
			
		case "fov0":
			self setstat(1300,0);
			self setClientDvar( "cg_fovscale", 1 );
			break;
			
		case "fov1":
			self setstat(1300,1);
			self setClientDvar( "cg_fovscale", 1.125 );
			break;

		case "fov2":
			self setstat(1300,2);
			self setClientDvar( "cg_fovscale", 1.15 );
			break;

		case "fov3":
			self setstat(1300,3);
			self setClientDvar( "cg_fovscale", 1.20 );
			break;

		case "fov4":
			self setstat(1300,4);
			self setClientDvar( "cg_fovscale", 1.25 );
			break;

		case "fov5":
			self setstat(1300,5);
			self setClientDvar( "cg_fovscale", 1.30 );
			break;

		case "fov6":
			self setstat(1300,6);
			self setClientDvar( "cg_fovscale", 1.35 );
			break;

		case "fov7":
			self setstat(1300,7);
			self setClientDvar( "cg_fovscale", 1.40 );
			break;

		case "fov8":
			self setstat(1300,8);
			self setClientDvar( "cg_fovscale", 1.45 );
			break;

		case "fpson":
			self setClientDvar( "r_fullbright", 1 );
			self setstat(1301,1);
			break;

		case "fpsoff":
			self setClientDvar( "r_fullbright", 0 );
			self setstat(1301,0);
			break;
			
		default:
		break;
	}	
}