
/*
    Developed by Ultimateman
    Release: 07/22/2022
    Part of City Of Mars Mod for Black Ops II Plutonium
*/


#include common_scripts/utility;
#include maps/_utility;
#include maps/_anim;
///////////////////////////////////////
#include maps/mp/gametypes/_hud_util;
#include maps/mp/_utility;
#include common_scripts/utility;
#include maps/mp/zombies/_zm_utility;
#include maps/mp/gametypes_zm/_hud_util;
#include maps/mp/gametypes_zm/_hud_message;
#include maps/mp/zombies/_zm_weapons;
#include maps/mp/zombies/_zm_net;
#include maps/mp/zombies/_zm_unitrigger;
#include maps/mp/zombies/_zm;
#include maps/mp/gametypes_zm/_spawning;
#include maps/mp/zombies/_load;
#include maps/mp/zombies/_zm_clone;
#include maps/mp/zombies/_zm_ai_basic;
#include maps/mp/animscripts/shared;
#include maps/mp/zombies/_zm_audio;
#include maps/mp/zombies/_zm_zonemgr;
#include maps/mp/zm_alcatraz_travel;
#include maps/mp/gametypes_zm/_zm_gametype;
#include maps/mp/zombies/_zm_equipment;

#include maps/mp/zombies/_zm_perks;
#include maps/mp/_visionset_mgr;
#include maps/mp/zombies/_zm_laststand;
#include maps/mp/gametypes_zm/_hud;
#include maps/mp/zombies/_zm_powerups;
#include maps/mp/zombies/_zm_magicbox;

//MYOWN ABOVE


#include maps/mp/zm_alcatraz_grief_cellblock;
#include maps/mp/zm_alcatraz_weap_quest;
#include maps/mp/zombies/_zm_weap_tomahawk;
#include maps/mp/zombies/_zm_weap_blundersplat;
#include maps/mp/zombies/_zm_magicbox_prison;
#include maps/mp/zm_prison_ffotd;
#include maps/mp/zm_prison_fx;
#include maps/mp/zm_alcatraz_gamemodes;

#include maps/mp/zombies/_zm_stats;
#include maps/mp/gametypes_zm/_spawnlogic;
#include maps/mp/animscripts/traverse/shared;
#include maps/mp/animscripts/utility;

#include maps/mp/_createfx;
#include maps/mp/_music;
#include maps/mp/_busing;
#include maps/mp/_script_gen;
#include maps/mp/gametypes_zm/_globallogic_audio;
#include maps/mp/gametypes_zm/_tweakables;
#include maps/mp/_challenges;
#include maps/mp/gametypes_zm/_weapons;
#include maps/mp/_demo;
#include maps/mp/gametypes_zm/_globallogic_utils;
#include maps/mp/gametypes_zm/_spectating;
#include maps/mp/gametypes_zm/_globallogic_spawn;
#include maps/mp/gametypes_zm/_globallogic_ui;
#include maps/mp/gametypes_zm/_hostmigration;
#include maps/mp/gametypes_zm/_globallogic_score;
#include maps/mp/gametypes_zm/_globallogic;

#include maps/mp/zombies/_zm_ai_faller;
#include maps/mp/zombies/_zm_spawner;
#include maps/mp/zombies/_zm_pers_upgrades_functions;
#include maps/mp/zombies/_zm_pers_upgrades;
#include maps/mp/zombies/_zm_score;

#include maps/mp/animscripts/zm_run;
#include maps/mp/animscripts/zm_death;
#include maps/mp/zombies/_zm_blockers;
#include maps/mp/animscripts/zm_shared;
#include maps/mp/animscripts/zm_utility;

#include maps/mp/zombies/_zm_power;
#include maps/mp/zombies/_zm_server_throttle;

#include maps/mp/zombies/_zm_melee_weapon;
#include maps/mp/zombies/_zm_audio_announcer;

#include maps/mp/zombies/_zm_ai_dogs;
#include codescripts/character;
#include maps/mp/zombies/_zm_buildables;
#include maps/mp/zombies/_zm_game_module;
#include maps/mp/zm_transit_buildables;
#include maps/mp/zm_transit;
#include maps/mp/zombies/_zm_magicbox_lock;
#include maps/mp/zombies/_zm_afterlife;
#include maps/mp/zombies/_zm_ai_brutus;
#include maps/mp/zm_alcatraz_craftables;
#include maps/mp/zombies/_zm_craftables;
#include maps/mp/zm_alcatraz_utility;

#include maps/mp/zm_alcatraz_traps;
#include maps/mp/zm_prison;
#include maps/mp/zm_alcatraz_sq;
#include maps/mp/zm_prison_sq_bg;
#include maps/mp/zm_prison_spoon;
#include maps/mp/zm_prison_achievement;


/*=====================================================================================================================================================================*/

#include maps/mp/zm_nuked_perks;

#include maps/mp/zombies/_zm_game_module;
#include maps/mp/animscripts/zm_death;
#include maps/mp/zombies/_zm_perks;
#include maps/mp/zombies/_zm_weapons;
#include maps/mp/zombies/_zm_utility;
#include maps/mp/_utility;
#include common_scripts/utility;

#include maps/mp/zombies/_zm_ffotd;
#include maps/mp/zombies/_zm_utility;
#include common_scripts/utility;
#include maps/mp/_utility;

#include maps/mp/zm_nuked;


init()
{
    level thread check_all_players_perks();
	level.global_pap_cost = 5000;
	level.keep_perk_reward_on = false; // set true after check_all_players_perks()
    //level thread remove_hud(); //nohud
    //level thread removestatic(); //static hud_elem removal
    level thread play_test_money();
    //level thread ff();
}

ff()
{
    flag_wait( "initial_blackscreen_passed" );
    level notify( "reward_the_weapons" );
}

play_test_money()
{
    level endon( "end_game" );
    
    flag_wait( "initial_blackscreen_passed" );
    //for( i = 0; i < level.players.size; i++ )
    //{
    //    level.players[ i ].score += 345000;
    //}
}
removestatic()
{
    level endon( "end_game" );
    flag_wait( "initial_blackscreen_passed" );
    wait 7;
    foreach( player in level.players )
    {
        player notify( "remove_static" );
    }
}

keep_perks_on_spawn()
{
	self endon( "disconnect" );
	level endon( "end_game" );

    wait 3;
	while ( true )
	{
		self waittill( "spawned_player" );
		if ( level.keep_perk_reward_on )
		{
			self thread set_remaining_perks();
            self thread player_reward_flopper();
            wait 3.6;
            self thread player_reward_marathon();
		}
	}
}

check_all_players_perks()
{
    level endon( "end_game" );
	flag_wait( "initial_blackscreen_passed" );
	wait 5;
	level waittill( "reward_the_weapons" );
	level thread sq_15_tell_about_rocket_permaperks();
	level.keep_perk_reward_on = true;
    //player = get_players();

	//first time perks thread
    for( i = 0; i < level.players.size; i++ )
    {
        level.players[ i ] thread set_remaining_perks();
        level.players[ i ] thread player_set_perma_jugg_health();
        wait 0.1;
    }

	//thread a func to make sure players receive perma perks back upon respawn
	//function waits till game respawns player back and then runs set_remaining_perks func again
	for( s = 0; s < level.players.size; s++ )
	{
		level.players[ s ] thread keep_perks_on_spawn();
	}

    // dive into a loop if more players join in the game after completing the easter egg. 
    while ( true )
    {
        level waittill( "connected", player );
        player thread dont_give_perks_before_spawn_flag_clear(); //function handles the spawn check + give perks func
    }
}



player_reward_flopper()
{
    
    level endon( "end_game" );
    self endon( "disconnect" );
    
    wait 1;
    
    //notifier has been moved into main caller func
    self.talk_phd = [];
    r_width = 20;
    r_height = 20;

    width = 310;
    height = 16;
    x = 1.8;
    r = 1.6;
    x = 0;

    self.talker_phd = newClientHudElem( self );
    self.talker_phd.x = -40;
    self.talker_phd.alignx = "center";
    self.talker_phd.aligny = "center";
    self.talker_phd.horzalign = "user_center";
    self.talker_phd.vertalign = "user_center";
    self.talker_phd.alpha = 0;
    self.talker_phd.foreground = true;
    self.talker_phd.hidewheninmenu = true;
    self.talker_phd setshader( "hud_chalk_3", r_width, r_height );
    self.talker_phd.color = ( 1, 0, 1 );
    self.talker_phd.y = -25;
    s = 0;

    for ( f = 0; f < 2; f++ )
    {
        self.talk_phd[ f ] = newClientHudElem( self );
        self.talk_phd[ f ].x = 0;
        self.talk_phd[ f ].y = 0;
        self.talk_phd[ f ].alignx = "center";
        self.talk_phd[ f ].aligny = "center";
        self.talk_phd[ f ].horzalign = "user_center";
        self.talk_phd[ f ].vertalign = "user_center";
        self.talk_phd[ f ].foreground = true;
        self.talk_phd[ f ].alpha = 0;
        self.talk_phd[ f ].color = ( 1, 1, 1 );
        self.talk_phd[ f ].inuse = false;
        self.talk_phd[ f ].hidewheninmenu = true;
        self.talk_phd[ f ].font = "default";
    }
    wait 0.05;
    self.talk_phd[ 0 ].y = 10;
    self.talk_phd[ 1 ].y = -5;
   

    self.talk_phd[ 0 ].fontscale = 1.6;
    self.talk_phd[ 1 ].fontscale = 1.3;
    

    self.talk_phd[ 0 ] settext( "[ ^6Permament Perk Rewarded^7 ]" );
    self.talk_phd[ 1 ] settext( "PHD ^6Flopper" );
    
    
    self.talk_phd[ 0 ].alpha = 0;
    self.talk_phd[ 1 ].alpha = 0;

    f = 2;
    for ( s = 0; s < self.talk_phd.size; s++ )
    {
        self.talk_phd[ s ].alpha = 0;
        self.talk_phd[ s ] fadeovertime( f );
        self.talk_phd[ s ].alpha = 1;
        wait 1.5;
        f -= 0.25;
    }


    self.talker_phd.alpha = 0;
    self.talker_phd fadeovertime( 1 );
    self.talker_phd.alpha = 1;
    
    wait 6;

    self.talker_phd.alpha = 1;
    self.talker_phd fadeovertime( 2 );
    self.talker_phd.alpha = 0;

    f = 2;
    for ( s = 0; s < self.talk_phd.size; s++ )
    {
        self.talk_phd[ s ].alpha = 1;
        self.talk_phd[ s ] fadeovertime( f );
        self.talk_phd[ s ].alpha = 0;
        wait 1.5;
        f -= 0.25;
    }
    wait 3;
    self.talker_phd.alignx = "left";
    self.talker_phd.aligny = "bottom";
    self.talker_phd.horzalign = "user_left";
    self.talker_phd.vertalign = "user_bottom";

    for( s = 0; s < self.talk_phd.size; s++ )
    {
        self.talk_phd[ s ].alignx = "left";
        self.talk_phd[ s ].aligny = "bottom";
        self.talk_phd[ s ].horzalign = "user_left";
        self.talk_phd[ s ].vertalign = "user_bottom";
        wait 0.08;
    }
    self.talker_phd.x = 10;
    self.talker_phd.y = -45;
    self.talk_phd[ 1 ].x = 25;
    self.talk_phd[ 1 ].y = -50;

    self.talker_phd.alpha = 0;
    self.talker_phd fadeovertime( 1.5 );
    self.talker_phd.alpha = 1; 

    wait 0.05;

    self.talk_phd[ 1 ].alpha = 0;
    self.talk_phd[ 1 ] fadeovertime( 1.5 );
    self.talk_phd[ 1 ].alpha = 1; 

    wait 1.5;

    self setperk( "specialty_phd" );
    self setperk( "specialty_flakjacket" );
    //self setperk( "specialty_armorvest" );
    self waittill_any( "death", "remove_static", "disconnect" );
    self.talker_phd destroy_hud();
    self.talk_phd[ 0 ] destroy_hud();
    self.talk_phd[ 1 ] destroy_hud();

}

player_reward_marathon()
{
    
    level endon( "end_game" );
    self endon( "disconnect" );

    wait 1;
    
    self.talk_marathon = [];
    r_width = 20;
    r_height = 20;

    width = 310;
    height = 16;
    x = 1.8;
    r = 1.6;
    x = 0;

    self.talker_marathon = newClientHudElem( self );
    self.talker_marathon.x = -40;
    self.talker_marathon.alignx = "center";
    self.talker_marathon.aligny = "center";
    self.talker_marathon.horzalign = "user_center";
    self.talker_marathon.vertalign = "user_center";
    self.talker_marathon.alpha = 0;
    self.talker_marathon.foreground = true;
    self.talker_marathon.hidewheninmenu = true;
    self.talker_marathon setshader( "hud_chalk_3", r_width, r_height );
    self.talker_marathon.color = ( 1, 0.7, 0 );
    self.talker_marathon.y = -25;
    s = 0;

    for ( f = 0; f < 2; f++ )
    {
        self.talk_marathon[ f ] = newClientHudElem( self );
        self.talk_marathon[ f ].x = 0;
        self.talk_marathon[ f ].y = 0;
        self.talk_marathon[ f ].alignx = "center";
        self.talk_marathon[ f ].aligny = "center";
        self.talk_marathon[ f ].horzalign = "user_center";
        self.talk_marathon[ f ].vertalign = "user_center";
        self.talk_marathon[ f ].foreground = true;
        self.talk_marathon[ f ].alpha = 0;
        self.talk_marathon[ f ].color = ( 1, 1, 1 );
        self.talk_marathon[ f ].inuse = false;
        self.talk_marathon[ f ].hidewheninmenu = true;
        self.talk_marathon[ f ].font = "default";
    }
    wait 0.05;
    self.talk_marathon[ 0 ].y = 10;
    self.talk_marathon[ 1 ].y = -5;
   

    self.talk_marathon[ 0 ].fontscale = 1.6;
    self.talk_marathon[ 1 ].fontscale = 1.3;
    

    self.talk_marathon[ 0 ] settext( "[ ^3Permament Perk Rewarded^7 ]" );
    self.talk_marathon[ 1 ] settext( "Stamina ^3Up" );
    
    
    self.talk_marathon[ 0 ].alpha = 0;
    self.talk_marathon[ 1 ].alpha = 0;

    f = 2;
    for ( s = 0; s < self.talk_marathon.size; s++ )
    {
        self.talk_marathon[ s ].alpha = 0;
        self.talk_marathon[ s ] fadeovertime( f );
        self.talk_marathon[ s ].alpha = 1; //1
        wait 1.5;
        f -= 0.25;
    }


    self.talker_marathon.alpha = 0;
    self.talker_marathon fadeovertime( 1 );
    self.talker_marathon.alpha = 1;
   
    wait 6;

    self.talker_marathon.alpha = 1;
    self.talker_marathon fadeovertime( 2 );
    self.talker_marathon.alpha = 0;

    f = 2;
    for ( s = 0; s < self.talk_marathon.size; s++ )
    {
        self.talk_marathon[ s ].alpha = 1;
        self.talk_marathon[ s ] fadeovertime( f );
        self.talk_marathon[ s ].alpha = 0;
        wait 1.5;
        f -= 0.25;
    }
    wait 3;
    self.talker_marathon.alignx = "left";
    self.talker_marathon.aligny = "bottom";
    self.talker_marathon.horzalign = "user_left";
    self.talker_marathon.vertalign = "user_bottom";

    for( s = 0; s < self.talk_marathon.size; s++ )
    {
        self.talk_marathon[ s ].alignx = "left";
        self.talk_marathon[ s ].aligny = "bottom";
        self.talk_marathon[ s ].horzalign = "user_left";
        self.talk_marathon[ s ].vertalign = "user_bottom";
        wait 0.08;
    }
    self.talker_marathon.x = 10;
    self.talker_marathon.y = -25;
    self.talk_marathon[ 1 ].x = 25;
    self.talk_marathon[ 1 ].y = -30;

    self.talker_marathon.alpha = 0;
    self.talker_marathon fadeovertime( 1.5 );
    self.talker_marathon.alpha = 1;

    wait 0.05;

    self.talk_marathon[ 1 ].alpha = 0;
    self.talk_marathon[ 1 ] fadeovertime( 1.5 );
    self.talk_marathon[ 1 ].alpha = 1;

    wait 1.5;

    self setperk( "specialty_unlimitedsprint" );
	self setperk( "specialty_fastmantle" );
    self setClientDvar( "player_backSpeedScale", 1 );
	self setClientDvar( "player_strafeSpeedScale", 1 );
	self setClientDvar( "player_sprintStrafeSpeedScale", 1 );

	self setClientDvar( "dtp_post_move_pause", 0 );
	self setClientDvar( "dtp_exhaustion_window", 100 );
	self setClientDvar( "dtp_startup_delay", 100 );

    self waittill_any( "death", "remove_static", "disconnect" );
    self.talker_marathon destroy_hud();
    self.talk_marathon[ 0 ] destroy_hud();
    self.talk_marathon[ 1 ] destroy_hud();

}



dont_give_perks_before_spawn_flag_clear()
{
    level endon( "end_game" );
    self endon( "disconnect" );

    self waittill( "spawned_player" );
    wait 8;
    self.hugx = newClientHudElem( self );
    self.hugx.x = 0;
    self.hugx.y = 0;
    self.hugx.alpha = 0;
    self.hugx.text = "The ^2easter egg^7 has been completed already on this server. Giving all the perma perks to the player^2 " + self.name;
    self.hugx.fontscale = 1;
    self.hugx fadeOverTime( 1 );
    self.hugx.alpha = 1; //1
    wait 2;
    wait 3;
    self.hugx fadeovertime( 3 );
    self.hugx.alpha = 0;
    wait 1.5;
    self thread set_remaining_perks();
    self thread player_set_perma_jugg_health();
    wait 3.1;
    self.hugx destroy_hud();
    wait 1;
    self thread player_reward_flopper();
    wait 6.8;
    self thread player_reward_marathon();
    wait 6;
    self thread keep_perks_on_spawn();    
}

test_flares()
{
	level endon( "end_game" );
	flag_wait( "initial_blackscreen_passed" );
	while (true)
	{
		playfx( level._effect[ "lght_marker_flare" ], ( 0, 0, 0 ) );
		wait 5;
	}
}

onplayerconnect()
{
	while (true)
	{
		level waittill("connected", player);
		//player thread temp_moneycheat();
        //player thread remove_hud();
	}
}

remove_hud()
{
    flag_wait( "initial_blackscreen_passed" );
    for( i = 0; i < level.players.size; i++ )
    {
        level.players[ i ] SetClientUIVisibilityFlag( "hud_visible", false );
    }
    wait 0.05;
}
printorigin()
{
    while( true )
    {
        iprintln( "2" + self.origin );
        wait 1.5;
    }
}
temp_moneycheat()
{
	level endon( "end_game" );
	self endon( "disconnect" );
	while ( true )
	{
		self waittill( "spawned_player" );
		wait 5;
		self.score += 500000;
	}
	//self waittill( "spawned_player" );
	//self.score += 888555;
}
set_remaining_perks()
{
	/*
    for ( s = 0; s < level.perk_perms.size; s++ )
    {
        if( !self hasperk( level.perk_perms[ s ] ) )
        {
            //self maps/mp/zombies/_zm_perks::give_perk( level.nuked_perks[ s ], 0 );
			self maps/mp/zombies/_zm_perks::give_perk( level.perk_perms[ s ] );
			iprintlnbold( "PERMA PERK GIVEN : ^2" + level.perk_perms[ s ] );
            wait 0.25;
        }
    }
	*/
	
	if( !self hasperk( "specialty_quickrevive" ) )
	{
		self playlocalsound( "cac_cmn_beep" );
		self give_perk( "specialty_quickrevive", 0 );
        self setperk( "specialty_quickrevive" );
		wait 1;
	}

	if ( !self hasperk( "specialty_fastreload" ) )
	{
		self playlocalsound( "cac_cmn_beep" );
		self give_perk( "specialty_fastreload", 0 );
        self setperk( "specialty_fastreload" );
		wait 1;
	}

	if ( !self hasperk( "specialty_armorvest" ) )
	{
		self playlocalsound( "cac_cmn_beep" );
		self give_perk( "specialty_armorvest", 0 );
        self setperk( "specialty_armorvest" );
		wait 1;
	}

	if ( !self hasperk( "specialty_rof" ) )
	{
		self playlocalsound( "cac_cmn_beep" );
		self give_perk( "specialty_rof", 0 );
        self setperk( "specialty_rof" );
		wait 1;
	}
    //self setperk( "specialty_rof" );
    //self setperk( "specialty_armorvest" );
    //self setperk( "specialty_fastreload" );
    //self setperk( "specialty_quickrevive" );
	self._retain_perks = true;
	for ( i = 0; i < 6; i++ )
	{
		
		self playlocalsound( "cac_cmn_beep" );
		wait 0.08;
	}
	wait 1;
    
}

init_perma_perk_rewards()
{
	level endon( "end_game" );
	flag_wait( "initial_blackscreen_passed" );
	
	level.perk_perms = [];

	level.perk_perms[ 0 ] = ( "specialty_quickrevive" );
	level.perk_perms[ 1 ] = ( "specialty_fastreload" );
	level.perk_perms[ 2 ] = ( "specialty_rof" );
	level.perk_perms[ 3 ] = ( "specialty_armorvest" );
}


player_set_perma_jugg_health()
{
    self endon( "disconnect" );
    level endon( "end_game" );
    self endon( "stop_perma_jugg" );
    new_health = 250;
    self.health = new_health;
    self.maxhealth = new_health;
    while ( true )
    {
        //self waittill( "damage" );
        wait 4;
        self.maxhealth = new_health;
        self.health = self.maxhealth;
    }
}
sq_15_tell_about_rocket_permaperks()
{
    
    level endon( "end_game" );
    //self endon( "disconnect" );
    //notifier has been moved into main caller func
    level.talk_permarocket = [];
    level.shades_permarocket = [];
    r_width = 40;
    r_height = 40;

    width = 310;
    height = 16;
    x = 1.8;
    r = 1.6;
    x = 0;
    level.talker_permarocket = newHudElem();
    level.talker_permarocket.x = 10;
    level.talker_permarocket.y = 0;
    level.talker_permarocket.alignx = "left";
    level.talker_permarocket.aligny = "top";
    level.talker_permarocket.horzalign = "user_left";
    level.talker_permarocket.vertalign = "user_top";
    level.talker_permarocket.alpha = 0;
    level.talker_permarocket.foreground = true;
    level.talker_permarocket.hidewheninmenu = true;
    level.talker_permarocket setshader( "zombies_rank_3_ded", r_width, r_height );
    level.talker_permarocket.y = 26;
    level.talker_permarocket thread sq_talk_skull_icon_blinker();
    s = 0;

    level.cyto_permarocket = newHudElem();
    level.cyto_permarocket.x = 21;
    level.cyto_permarocket.y = 0;
    level.cyto_permarocket.alignx = "left";
    level.cyto_permarocket.aligny = "top";
    level.cyto_permarocket.horzalign = "user_left";
    level.cyto_permarocket.vertalign = "user_top";
    level.cyto_permarocket.alpha = 0;
    //self.restricted[ i ].color = ( 1,1, 1 );
    level.cyto_permarocket.foreground = true;
    level.cyto_permarocket.hidewheninmenu = true;
    level.cyto_permarocket.fontscale = 1;
    level.cyto_permarocket settext( "T^2.^2E^7.^7D^2.^2D" );
    level.cyto_permarocket.y = 67.5;

    for( x = 0; x < 6; x++ )
    {
        level.shades_permarocket[ x ] = newHudElem();
        level.shades_permarocket[ x ].x = 45;
        level.shades_permarocket[ x ].y = 0;
        level.shades_permarocket[ x ].alignx = "left";
        level.shades_permarocket[ x ].aligny = "top";
        level.shades_permarocket[ x ].horzalign = "user_left";
        level.shades_permarocket[ x ].vertalign = "user_top";
        level.shades_permarocket[ x ].alpha = 0;
        level.shades_permarocket[ x ].color = ( 0.67, 0, 0.01 );
        level.shades_permarocket[ x ].inuse = false;
        level.shades_permarocket[ x ].hidewheninmenu = true;
        level.shades_permarocket[ x ] setshader( "scorebar_zom_1", width, height );
        wait 0.05;
       
    }

    level.shades_permarocket[ 0 ].y = 18;//-100; //100
    level.shades_permarocket[ 1 ].y = 28;//-80; //80
    level.shades_permarocket[ 2 ].y = 38;//-60;
    level.shades_permarocket[ 3 ].y = 48;//-40; //40
    level.shades_permarocket[ 4 ].y = 58;
    level.shades_permarocket[ 5 ].y = 68;

    for ( f = 0; f < 4; f++ )
    {
        level.talk_permarocket[ f ] = newHudElem();
        level.talk_permarocket[ f ].x = 60;
        level.talk_permarocket[ f ].y = 0;
        level.talk_permarocket[ f ].alignx = "left";
        level.talk_permarocket[ f ].aligny = "top";
        level.talk_permarocket[ f ].horzalign = "user_left";
        level.talk_permarocket[ f ].vertalign = "user_top";
        level.talk_permarocket[ f ].foreground = true;
        level.talk_permarocket[ f ].alpha = 0;
        level.talk_permarocket[ f ].color = ( 1, 1, 1 );
        level.talk_permarocket[ f ].inuse = false;
        level.talk_permarocket[ f ].hidewheninmenu = true;
        level.talk_permarocket[ f ].font = "default";
    }

    level.talk_permarocket[ 0 ].y = 20; //100
    level.talk_permarocket[ 1 ].y = 35; //80
    level.talk_permarocket[ 2 ].y = 50;
    level.talk_permarocket[ 3 ].y = 65; //40

    level.talk_permarocket[ 0 ].fontscale = 1.25; //1.25
    level.talk_permarocket[ 1 ].fontscale = 1.25; //1.4
    level.talk_permarocket[ 2 ].fontscale = 1.25; //1.25
    level.talk_permarocket[ 3 ].fontscale = 1.25; //1.4
    

    level.talk_permarocket[ 0 ] settext( "Ahhh! All the ^3perks^7 are your's to ^3keep forever!^7" );
    level.talk_permarocket[ 1 ] settext( "I've spawned a ^3wonder weapon^7 for you, go find it!" );
    level.talk_permarocket[ 2 ] settext( "I'll prepare the final rocket for you while you have fun." );
    level.talk_permarocket[ 3 ] settext( "I'll be waiting for ^3you.^7" );

    level.talk_permarocket[ 0 ].alpha = 0;
    level.talk_permarocket[ 1 ].alpha = 0;
    level.talk_permarocket[ 2 ].alpha = 0;
    level.talk_permarocket[ 3 ].alpha = 0;

    f = 2;
    act = false;

    for ( s = 0; s < level.shades_permarocket.size; s++ )
    {
        level.shades_permarocket[ s ].alpha = 0;
        level.shades_permarocket[ s ] fadeovertime( f );
        level.shades_permarocket[ s ].alpha = 0.8;
        wait randomfloatrange( 0.14, 0.3 );
        if( !act )
        {
            playsoundatposition( "zmb_meteor_activate", ( 0, 0, 0 ) );
            wait 0.1;
            playsoundatposition( "mus_zombie_dog_start", ( 0, 0, 0 ) );
            act = true;
            level notify( "beep_talker" );
        }
        


        f -= 0.25;
    }
    level.cyto_permarocket.alpha = 0;
    level.cyto_permarocket fadeovertime( 4 );
    level.cyto_permarocket.alpha = 1;

    wait 0.1;

    //display a flashing loop fx at first
    f = 2;
    for( i = 0; i < level.talk_permarocket.size; i++ )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.talk_permarocket[ i ].alpha = 0;
        level.talk_permarocket[ i ] fadeovertime( v );
        level.talk_permarocket[ i ].alpha = 1;
        wait 0.08;
    }

    for( i = level.talk_permarocket.size; i > 0; i-- )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.talk_permarocket[ i ].alpha = 1;
        level.talk_permarocket[ i ] fadeovertime( v );
        level.talk_permarocket[ i ].alpha = 0;
        wait 0.08;        
    }
    wait 0.1;

    //display the text for a x duration
    for( i = 0; i < level.talk_permarocket.size; i++ )
    {
        v = randomfloatrange( 0.4, 0.9 );
        level.talk_permarocket[ i ].alpha = 0;
        level.talk_permarocket[ i ] fadeovertime( v );
        level.talk_permarocket[ i ].alpha = 1;
        wait 0.08;  
    }
    wait 1;

    for ( s = 0; s < level.talk_permarocket.size; s++ )
    {
        if ( s == 2)
        {
            level.talk_permarocket[ s ] thread sq_talk_brace_for_impact();    
        }

        if ( s == 0 || s == 1  )
        {
            level.talk_permarocket[ s ] thread sq_talk_turn_colors();
        }
        else if ( s == 3 )
        {
            level.talk_permarocket[ s ] thread sq_talk_blink();
        }
        wait randomfloatrange( 0.4, 0.9 );
    }
    wait 8.5;

    level.talk_permarocket = array_randomize( level.talk_permarocket );


    level.talker_permarocket.alpha = 1;
    level.talker_permarocket fadeovertime( 3.5 );
    level.talker_permarocket.alpha = 0;

    level.cyto_permarocket.alpha = 0.8;
    level.cyto_permarocket fadeovertime( 3.5 );
    level.cyto_permarocket.alpha = 0;
    wait .1;

    x = 2.5;
    for ( u = 0; u < level.shades_permarocket.size; u++ )
    {
        s = randomfloatrange( 0.3, 0.6 );
        level.shades_permarocket[ u ].alpha = 0.8;
        level.shades_permarocket[ u ] fadeovertime( x );
        level.shades_permarocket[ u ].alpha = 0;
        x -= 0.35;
        wait s;
    }
    x = 2.5;
    for( i = 0; i < level.talk_permarocket.size; i++ )
    {
        level.talk_permarocket[ i ].alpha = 1;
        level.talk_permarocket[ i ] fadeovertime( x );
        level.talk_permarocket[ i ].alpha = 0;
        x -= 0.35;
    }
    wait 3;

    level.talker_permarocket destroy_hud();
    level.cyto_permarocket destroy_hud();
    for ( i = 0; i < level.talk_permarocket.size; i++ )
    {
        level.talk_permarocket[ i ] destroy_hud();
    }

    for( i = 0; i < level.shades_permarocket.size; i++ )
    {
        level.shades_permarocket[ i ] destroy_hud();
    }
    level.talker_permarocket delete();
    level.cyto_permarocket delete();
    level.talk_permarocket delete();
    level.shades_permarocket delete();
}







sq_talk_blinker()
{
    level endon( "end_game" );
    self endon( "stop_blinking" );

    x = 0;
    wait 0.1;
    while ( true )
    {
        x += 0.025;
        self.alpha = x;
        wait 0.05;

        if ( x >= 0.8 )
        {
            for ( i = 0; i < 16; i++ )
            {
                x -= 0.025;
                self.alpha = x;
                wait 0.05;
            }
        }
    }
}

sq_talk_turn_colors()
{
    level endon( "end_game" );
    self endon( "activate_sq_turn" );
    r = 1;
    g = 1;
    b = 1;
    wait randomfloatrange( 4, 6.5 );
    while ( true )
    {
        r -= 0.05;
        b -= 0.05;
        g -= 0.05;
        self.color = ( r, g, b );
        wait 0.05;
        if ( r <= 0.1 && g <= 0.1 && g <= 0.1 )
        {
            r = 0.1;
            g = 0.1;
            b = 0.1;
            self.color = ( r, g, b );
            break;
        }
    }
}

sq_talk_brace_for_impact()
{
    level endon( "end_game" );
    self endon( "activate_sq_turn" );
    r = 1;
    g = 1;
    b = 1;
    wait randomfloatrange( 4, 4.3 );
    while ( true )
    {
        //r -= 0.05;
        g -= 0.05;
        b -= 0.05;
        self.color = ( r, g, b );
        wait 0.05;
        if ( r == 1 && g == 0 && g == 0 )
        {
            r = 1;
            g = 0;
            b = 0;
            self.color = ( r, g, b );
            break;
        }
    }
}

sq_talk_blink()
{
    level endon( "end_game" );
    self endon( "activate_sq_turn" );
    wait 1;
    for ( i = 0; i < 16; i++ )
    {
        self.color = ( 1, 0, 0 );
        wait 0.4;
        self.color = ( 1, 1, 1 );
        wait 0.4;
    }
}
sq_talk_turn_glow()
{
    level endon( "end_game" );
    self endon( "disconnect" );
    wait randomfloatrange( 2.8, 3.1 );
    ga = 0;
    gr = 0;
    gg = 0;
    gb = 0;
    while ( true )
    {
        ga += 0.1;
        gg += 0.05;
        
        
        if ( ga >= 0.3 )
        {
            ga = 0.3;
        }
        if ( gg > 0.4 )
        {
            gg = 0.4;
            self.glowcolor = ( gr, gg, gb );

            gg = 0.4;

            while ( true )
            {
                gg -= 0.05;
                self.glowcolor = ( gr, gg, gb );
                wait 0.08;
                if ( gg <= 0 )
                {
                    self.glowcolor = ( gr, gg, gb );
                    break;
                }
            }
        }
        self.glowalpha = ga;
        self.glowcolor = ( gr, gg, gb );
        wait 0.08;
        
    }
}

sq_talk_skull_icon_blinker()
{
    level endon( "end_game" );
    self endon( "disconnect" );
    s = 0;
    for ( i = 0; i < 10; i++ )
    {
        s += 0.05;
        if ( s > 0.5 )
        {
            s = 0.5;
        }
        self.alpha = s;
        wait 0.05;
    }
    for ( i = 0; i < 24; i++ )
    {
        self.alpha = 0.5;
        wait 0.05;
        self.alpha = 0;
        wait 0.05;
    }

    x = 0;
    for ( i = 0; i < 32; i++ )
    {
        x += 0.025;
        if ( x > 0.8 )
        {
            x = 0.8;
        }
        self.alpha = x;
        wait 0.05;
    }
    //self notify( "continue_guider" );
}