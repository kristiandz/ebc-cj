precache()
{
	for ( i = 0; i <= 6; i++ )
	{
		precacheShader(tableLookup( "mp/rankIconTable.csv", 0, i, 1 ));
		precacheString(tableLookupIString( "mp/rankTable.csv", 0, i, 16 ));
	}
	
	//PRECACHE SHADERS
	precacheShader("black");
	precacheShader("line_horizontal");
	precacheShader("white");
	precacheShader("damage_feedback");
	precacheShader("cj_frame");
	precacheshader("foward_pressed");
    precacheshader("back_pressed");
    precacheshader("left_pressed");
    precacheshader("right_pressed");
    precacheshader("jump_pressed");

	//PRECACHE WEAPONS
	precacheItem("rpg_mp");
	precacheItem("beretta_mp");
	precacheItem("deserteagle_mp");
	precacheItem("deserteaglegold_mp");
	precacheItem("colt45_mp");
	precacheItem("usp_mp");
	precacheItem("brick_blaster_mp");
	precacheItem("rpg_sustain_mp");
	precacheItem("gravitygun_mp");
	precacheItem("no_weapon_mp");
	precacheItem("dog_mp");

	//PRECACHE MENUS
	precacheMenu("cj");
	precacheMenu("vip");
	precacheMenu("shop");
	precacheMenu("clientcmd");
	precacheMenu("poslog");
	precacheMenu("scoreboard");
	precacheMenu("ingame_controls" );
	precacheMenu("ingame_options" );
	precacheMenu("team_marinesopfor" );
	precacheMenu("cj_vote" );
	precacheMenu("cj_graphic" );
	precacheMenu("cj_script" );
	precacheMenu("quickcommands" );
	
	//PRECACHE PLAYER AND VIEWMODELS
	PrecacheModel("viewmodel_base_viewhands");
	PrecacheModel("body_mp_sas_urban_assault");
	precacheModel("viewhands_usmc");
	precacheModel("playermodel_dnf_duke");
	precacheModel("viewhands_dnf_duke");
	precacheModel("body_makarov");
	precacheModel("body_zoey");
	precacheModel("mc_char");
	precacheModel("german_sheperd_dog");
	precacheModel("body_masterchief");
	precacheModel("body_shepherd");
	precacheModel("body_juggernaut");
	precacheModel("body_complete_mp_price_woodland");
	precacheModel("body_complete_mp_russian_farmer");
	precacheModel("body_complete_mp_zakhaev");
	precacheModel("playermodel_ghost_recon");
	precacheModel("playermodel_GTA_IV_NICO");
	precacheModel("playermodel_vin_diesel");
	precacheModel("playermodel_terminator");
	precacheModel("playermodel_fifty_cent");
	precacheModel("playermodel_css_badass_terrorist");
	precacheModel("body_mp_usmc_rifleman");
	precacheModel("body_complete_mp_velinda_desert");
	precacheModel("body_complete_mp_zack_desert");

	//PRECACHE STATUS ICONS / OTHER
	precacheStatusIcon("hud_status_connecting" );
	precacheStatusIcon("hud_status_spectator" );
	
	precacheLocationSelector("map_artillery_selector" );
	
	/*//WIP
	precacheMenu("admin");
	precacheShellShock("flashbang");
	precacheHeadIcon( "talkingicon" );		
	*/
}