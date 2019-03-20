onPlayerSpawn()
{
	fov   = self getstat(1300);
	fps   = self getstat(1301);
	fx    = self getstat(1302);
	thr   = self getstat(1303);
	thr_r = self getstat(1304);
	thr_a = self getstat(1305);
	dec   = self getstat(1306);
	fog   = self getstat(1307);
	dist  = self getstat(1308);

	switch(fov)
	{
		case 0 :	
			self setClientDvar( "cg_fovscale", 1 );
			break;		
		case 1 :	
			self setClientDvar( "cg_fovscale", 1.125 );
			break;			
		case 2 :	
			self setClientDvar( "cg_fovscale", 1.15 );
			break;		
		case 3 :	
			self setClientDvar( "cg_fovscale", 1.2 );
			break;	
		case 4 :	
			self setClientDvar( "cg_fovscale", 1.25 );
			break;	
		case 5 :	
			self setClientDvar( "cg_fovscale", 1.3 );
			break;	
		case 6 :	
			self setClientDvar( "cg_fovscale", 1.35 );
			break;	
		case 7 :	
			self setClientDvar( "cg_fovscale", 1.4 );
			break;	
		case 8 :	
			self setClientDvar( "cg_fovscale", 1.45 );
			break;			
	}
	
	switch(fps)
	{
		case 1 :
			self setClientDvar( "r_fullbright", 1 );
			break;
		case 0 :
			self setClientDvar( "r_fullbright", 0 );
			break;	
	}
	
	switch(fx)
	{
		case 1 :
			self setclientdvar("fx_enable", 1 );
			break;
		case 0 :
			self setclientdvar("fx_enable", 0 );
			break;
	}
	
	switch(thr)
	{
		case 1 :
			self setClientDvar( "cg_thirdperson", 1 );
			break;
		case 0 :
			self setClientDvar( "cg_thirdperson", 0 );
			break;
	}
	
	switch(thr_r)
	{
		case 0 :
			self setClientDvar( "cg_thirdpersonrange", 120 );
			break;
		case 1 :
			self setClientDvar( "cg_thirdpersonrange", 200 );
			break;
		case 2 :
			self setClientDvar( "cg_thirdpersonrange", 300 );
			break;
		case 3 :
			self setClientDvar( "cg_thirdpersonrange", 50 );
			break;
	}
	
	switch(thr_a)
	{
		case 0 :
			self setClientDvar( "cg_thirdpersonangle", 0 );
			break;
		case 1 :
			self setClientDvar( "cg_thirdpersonangle", 90 );
			break;
		case 2 :
			self setClientDvar( "cg_thirdpersonangle", 180 );
			break;
		case 3 :
			self setClientDvar( "cg_thirdpersonangle", 270 );
			break;
	}
	
	switch(dec)
	{
		case 0 :
			self setClientDvar( "r_drawdecals", 0 );
			break;
		case 1 :
			self setClientDvar( "r_drawdecals", 1 );
			break;
	}
	
	switch(fog)
	{
		case 0 :
			self setClientDvar( "r_fog", 0 );
			break;
		case 1 :
			self setClientDvar( "r_fog", 1 );
			break;
	}
	
	switch(dist)
	{
		case 0 :
			self setClientDvar( "r_zfar", 0 );
			break;
		case 1 :
			self setClientDvar( "r_zfar", 250 );
			break;
		case 2 :
			self setClientDvar( "r_zfar", 500 );
			break;
		case 3 :
			self setClientDvar( "r_zfar", 750 );
			break;
		case 4 :
			self setClientDvar( "r_zfar", 1000 );
			break;
		case 5 :
			self setClientDvar( "r_zfar", 1250 );
			break;
		case 6 :
			self setClientDvar( "r_zfar", 1500 );
			break;
		case 7 :
			self setClientDvar( "r_zfar", 1750 );
			break;
		case 8 :
			self setClientDvar( "r_zfar", 2000 );
			break;
		case 9 :
			self setClientDvar( "r_zfar", 2250 );
			break;
		case 10 :
			self setClientDvar( "r_zfar", 2500 );
			break;
		case 11 :
			self setClientDvar( "r_zfar", 2750 );
			break;
		case 12 :
			self setClientDvar( "r_zfar", 3000 );
			break;
		case 13 :
			self setClientDvar( "r_zfar", 3250 );
			break;
		case 14 :
			self setClientDvar( "r_zfar", 3500 );
			break;
		case 15 :
			self setClientDvar( "r_zfar", 3750 );
			break;
		case 16 :
			self setClientDvar( "r_zfar", 4000 );
			break;
	}
}