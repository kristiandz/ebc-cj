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
	precacheshader("forward_pressed");
    precacheshader("back_pressed");
    precacheshader("left_pressed");
    precacheshader("right_pressed");
    precacheshader("jump_pressed");
	precacheShader("progress_bar_fill");
	precacheShader("progress_bar_bg");
	precacheShader("ObjPoint_default");

	//PRECACHE WEAPONS
	precacheItem("rpg_mp");
	precacheItem("deserteaglegold_mp");
	precacheItem("rpg_sustain_mp");
	precacheItem("gravitygun_mp");
	precacheItem("dog_mp");
	
	precacheItem( "colt45_mp" );
	precacheItem( "usp_mp" );
	precacheItem( "beretta_mp" );
	precacheItem( "deserteagle_mp" );
    precacheItem( "usp_silencer_mp" );
    precacheItem( "mp5_reflex_mp" );
    precacheItem( "mp5_mp" );
    precacheItem( "mp5_silencer_mp" );
    precacheItem( "mp5_acog_mp" );
    precacheItem( "remington700_mp" );
    precacheItem( "remington700_acog_mp" );
    precacheItem( "m4_reflex_mp" );
    precacheItem( "m4_gl_mp" );
    precacheItem( "m4_acog_mp" );
    precacheItem( "m4_silencer_mp" );
    precacheItem( "m4_mp" );
    precacheItem( "g3_reflex_mp" );
    precacheItem( "g3_mp" );
    precacheItem( "g3_silencer_mp" );
    precacheItem( "g3_gl_mp" );
    precacheItem( "g3_acog_mp" );
    precacheItem( "ak74u_reflex_mp" );
    precacheItem( "ak74u_mp" );
    precacheItem( "ak74u_acog_mp" );
    precacheItem( "ak74u_silencer_mp" );
    precacheItem( "ak47_reflex_mp" );
    precacheItem( "ak47_mp" );
    precacheItem( "ak47_gl_mp" );
    precacheItem( "ak47_acog_mp" );
    precacheItem( "ak47_silencer_mp" );
    precacheItem( "m14_reflex_mp" );
    precacheItem( "m14_mp" );
    precacheItem( "m14_silencer_mp" );
    precacheItem( "m14_acog_mp" );
    precacheItem( "m14_gl_mp" );
    precacheItem( "m21_mp" );
    precacheItem( "m21_acog_mp" );
    precacheItem( "m40a3_mp" );
    precacheItem( "m40a3_acog_mp" );
    precacheItem( "m1014_reflex_mp" );
    precacheItem( "m1014_mp" );
    precacheItem( "m1014_grip_mp" );
    precacheItem( "p90_mp" );
    precacheItem( "p90_reflex_mp" );
    precacheItem( "p90_acog_mp" );
    precacheItem( "p90_silencer_mp" );
    precacheItem( "saw_reflex_mp" );
    precacheItem( "saw_mp" );
    precacheItem( "saw_acog_mp" );
    precacheItem( "saw_grip_mp" );
    precacheItem( "skorpion_reflex_mp" );
    precacheItem( "skorpion_mp" );
    precacheItem( "skorpion_acog_mp" );
    precacheItem( "skorpion_silencer_mp" );
    precacheItem( "uzi_reflex_mp" );
    precacheItem( "uzi_mp" );
    precacheItem( "uzi_acog_mp" );
    precacheItem( "uzi_silencer_mp" );
    precacheItem( "barrett_mp" );
    precacheItem( "barrett_acog_mp" );
    precacheItem( "g36c_reflex_mp" );
    precacheItem( "g36c_mp" );
    precacheItem( "g36c_gl_mp" );
    precacheItem( "g36c_acog_mp" );
    precacheItem( "g36c_silencer_mp" );
    precacheItem( "m60e4_reflex_mp" );
    precacheItem( "m60e4_mp" );
    precacheItem( "m60e4_acog_mp" );
    precacheItem( "m60e4_grip_mp" );
    precacheItem( "m16_reflex_mp" );
    precacheItem( "m16_mp" );
    precacheItem( "m16_acog_mp" );
    precacheItem( "m16_silencer_mp" );
    precacheItem( "m16_gl_mp" );
    precacheItem( "rpd_reflex_mp" );
    precacheItem( "rpd_mp" );
    precacheItem( "rpd_acog_mp" );
    precacheItem( "rpd_grip_mp" );
    precacheItem( "mp44_mp" );
    precacheItem( "dragunov_mp" );
    precacheItem( "dragunov_acog_mp" );
    precacheItem( "c4_mp" );
    precacheItem( "claymore_mp" );
    precacheItem( "defaultweapon_mp" );
	
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
	precacheModel("body_complete_mp_zack_desert");

	//PRECACHE STATUS ICONS / OTHER
	precacheStatusIcon("hud_status_connecting" );
	precacheStatusIcon("hud_status_spectator" );
	precacheHeadIcon( "talkingicon" );	
	precacheLocationSelector("map_artillery_selector" );
	precacheShellShock("flashbang");
}