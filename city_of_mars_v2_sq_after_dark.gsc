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
    level thread travel_back_to_day();
    level thread per_player_level_check_for_all();
    precacheshader( "scorebar_zom_1" );
    precacheshader( "hud_chalk_3" );
    precacheshader( "hud_zombierank_3_ded" );
    precacheshader( "zombierank_3_ded" );
    precacheshader( "zm_signpost_buried_glow" );
    PrecacheShader( "zom_icon_community_pot" );
    PrecacheShader( "zom_icon_community_pot_strip" );
    precacheshader( "waypoint_revive" );
    precacheshader("zom_icon_player_life");
    precacheshader( "zombies_rank_5" );
    precacheshader( "zombies_rank_3_ded" );
    level.lockdown_one = false;
    level.lockdown_two = false;
}

travel_back_to_day()
{
    level endon( "end_game" );
    
    level waittill( "travel_back_to_day" );
    
    level specific_powerup_drop( "nuke", level.players[ 0 ].origin + vectorScale( ( 0, 0, 1 ), 2 ) );
    
    wait 0.1;
    foreach( player in level.players )
    {
        player setClientDvar( "r_sky_intensity_factor0", 6.2 );
        player setClientDvar( "r_skyTransition", 0 );
        player setClientDvar( "r_skyColorTemp", 1650 );
        player setClientDvar( "r_lodBiasRigid", -1000 );
        player setClientDvar( "r_lodBiasSkinned", -1000 );
        player setClientDvar( "r_filmuseTweaks", 1 );
        player setClientDvar( "vc_fsm", "1 1 1 1" );
        player setClientDvar( "r_bloomtweaks", 1 );
        player setClientDvar( "r_lighttweaksuncolor", ( 1, 0.8, 0.8 ) );
        player setClientDvar( "r_lighttweaksunlight", 18 );
        player setClientDvar( "vc_rgbh", "0.26 0.1 0.2 0" );
        player setclientdvar( "vc_rgbl", "0 0 0 0" );
        player setClientDvar( "r_dof_enable", 0 );
        player setClientDvar( "r_exposureTweak", 1 );
        player setClientDvar( "r_exposureValue", 4.8 );
        player setClientDvar( "com_maxfps", 0 );
    }
    wait 1.5;
    level.night_mode_active = false;
    level notify( "daytime_back" );
    
}

per_player_level_check_for_all()
{
    level endon( "end_game" );

    flag_wait( "initial_blackscreen_passed" );
    
    level waittill( "daytime_back" );
    level thread sq_talk_13_lockdown_override();
    
    wait 8.1;
    level notify( "can_do_lockdown" );
    
    wait 1;
    for( a = 0; a < level.players.size; a++ )
    {
        level.players[ a ] thread player_reward_flopper();
        wait 0.05; // a slight delay if the script is run on a server
        level.players[ a ] thread player_reward_marathon();
    }

    level thread keep_track_of_lockdown();
    
    level waittill( "lockdown_one_completed" );
    wait 1;
    level thread reward_the_weapon_check();
}

keep_track_of_lockdown()
{
    level endon( "end_game" );
    
    wait 0.5;
    while ( true )
    {
        if ( level.lockdown_one || level.lockdown_two )
        {
            level notify( "lockdown_one_completed" );
            wait 0.5;
            break;
        }
        else 
        {
            wait 1;
        }
    }
}

reward_marathon_check()
{
    level endon( "end_game" );
    
    wait 0.5;
    while( true )
    {
        if( level.lockdown_two )
        {
            level notify( "yellow_lockdown_done" );
            wait 0.5;
            break;
        }
        else 
        {
            wait 1;
        }
    }
}

reward_the_weapon_check()
{
    level endon( "end_game" );
    
    wait 0.5;
    while( true )
    {
        if( level.lockdown_one == true && level.lockdown_two == true )
        {
            wait 2;
            level notify( "reward_the_weapons" );
            wait 0.1;
            break;
        }
        else
        {
            wait 1;
        }
    }
}

reward_phd_check()
{
    level endon( "end_game" );
    
    wait 0.5;
    while( true )
    {
        if( level.lockdown_one )
        {
            level notify( "blue_lockdown_done" );
            wait 0.5;
            break;
        }
        else 
        {
            wait 1;
        }
    }
}

sq_talk_blinker()
{
    level endon( "end_game" );

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
}


player_reward_flopper()
{
    
    level endon( "end_game" );
    self endon( "disconnect" );
    
    self.talk_phd = [];
    r_width = 20;
    r_height = 20;

    width = 310;
    height = 16;
    x = 1.8;
    r = 1.6;
    x = 0;

    self.talker_phd = newClientHudElem( self );
    self.talker_phd.x = 0;
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
    
    while( !level.lockdown_one ) //originally on top of this func
    {
        wait 1;
    }

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
    self waittill_any( "death", "remove_static", "disconnect" );
    self.talker_phd destroy_hud();
    self.talk_phd[ 0 ] destroy_hud();
    self.talk_phd[ 1 ] destroy_hud();

}

player_reward_marathon()
{
    
    level endon( "end_game" );
    self endon( "disconnect" );

    self.talk_marathon = [];
    r_width = 20;
    r_height = 20;

    width = 310;
    height = 16;
    x = 1.8;
    r = 1.6;
    x = 0;

    self.talker_marathon = newClientHudElem( self );
    self.talker_marathon.x = 0;
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
    
    while( !level.lockdown_two ) //originally on top of this func
    {
        wait 1;
    }

    f = 2;
    for ( s = 0; s < self.talk_marathon.size; s++ )
    {
        self.talk_marathon[ s ].alpha = 0;
        self.talk_marathon[ s ] fadeovertime( f );
        self.talk_marathon[ s ].alpha = 1;
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

sq_talk_14_one_more_lockdown()
{
    
    level endon( "end_game" );
    self endon( "disconnect" );
    level.talk_continue_lockdown = [];
    level.shades_continue_lockdown = [];
    r_width = 40;
    r_height = 40;

    width = 310;
    height = 16;
    x = 1.8;
    r = 1.6;
    x = 0;
    level.talker_continue_lockdown = newHudElem();
    level.talker_continue_lockdown.x = 10;
    level.talker_continue_lockdown.y = 0;
    level.talker_continue_lockdown.alignx = "left";
    level.talker_continue_lockdown.aligny = "top";
    level.talker_continue_lockdown.horzalign = "user_left";
    level.talker_continue_lockdown.vertalign = "user_top";
    level.talker_continue_lockdown.alpha = 0;
    level.talker_continue_lockdown.foreground = true;
    level.talker_continue_lockdown.hidewheninmenu = true;
    level.talker_continue_lockdown setshader( "zombies_rank_3_ded", r_width, r_height );
    level.talker_continue_lockdown.y = 26;
    level.talker_continue_lockdown thread sq_talk_skull_icon_blinker();
    s = 0;

    level.cyto_continue_lockdown = newHudElem();
    level.cyto_continue_lockdown.x = 21;
    level.cyto_continue_lockdown.y = 0;
    level.cyto_continue_lockdown.alignx = "left";
    level.cyto_continue_lockdown.aligny = "top";
    level.cyto_continue_lockdown.horzalign = "user_left";
    level.cyto_continue_lockdown.vertalign = "user_top";
    level.cyto_continue_lockdown.alpha = 0;
    level.cyto_continue_lockdown.foreground = true;
    level.cyto_continue_lockdown.hidewheninmenu = true;
    level.cyto_continue_lockdown.fontscale = 1;
    level.cyto_continue_lockdown settext( "T^2.^2E^7.^7D^2.^2D" );
    level.cyto_continue_lockdown.y = 67.5;

    for( x = 0; x < 6; x++ )
    {
        level.shades_continue_lockdown[ x ] = newHudElem();
        level.shades_continue_lockdown[ x ].x = 45;
        level.shades_continue_lockdown[ x ].y = 0;
        level.shades_continue_lockdown[ x ].alignx = "left";
        level.shades_continue_lockdown[ x ].aligny = "top";
        level.shades_continue_lockdown[ x ].horzalign = "user_left";
        level.shades_continue_lockdown[ x ].vertalign = "user_top";
        level.shades_continue_lockdown[ x ].alpha = 0;
        level.shades_continue_lockdown[ x ].color = ( 0.67, 0, 0.01 );
        level.shades_continue_lockdown[ x ].inuse = false;
        level.shades_continue_lockdown[ x ].hidewheninmenu = true;
        level.shades_continue_lockdown[ x ] setshader( "scorebar_zom_1", width, height );
        wait 0.05;
       
    }

    level.shades_continue_lockdown[ 0 ].y = 18;
    level.shades_continue_lockdown[ 1 ].y = 28;
    level.shades_continue_lockdown[ 2 ].y = 38;
    level.shades_continue_lockdown[ 3 ].y = 48;
    level.shades_continue_lockdown[ 4 ].y = 58;
    level.shades_continue_lockdown[ 5 ].y = 68;

    for ( f = 0; f < 4; f++ )
    {
        level.talk_continue_lockdown[ f ] = newHudElem();
        level.talk_continue_lockdown[ f ].x = 60;
        level.talk_continue_lockdown[ f ].y = 0;
        level.talk_continue_lockdown[ f ].alignx = "left";
        level.talk_continue_lockdown[ f ].aligny = "top";
        level.talk_continue_lockdown[ f ].horzalign = "user_left";
        level.talk_continue_lockdown[ f ].vertalign = "user_top";
        level.talk_continue_lockdown[ f ].foreground = true;
        level.talk_continue_lockdown[ f ].alpha = 0;
        level.talk_continue_lockdown[ f ].color = ( 1, 1, 1 );
        level.talk_continue_lockdown[ f ].inuse = false;
        level.talk_continue_lockdown[ f ].hidewheninmenu = true;
        level.talk_continue_lockdown[ f ].font = "default";
    }

    level.talk_continue_lockdown[ 0 ].y = 20; 
    level.talk_continue_lockdown[ 1 ].y = 35; 
    level.talk_continue_lockdown[ 2 ].y = 50;
    level.talk_continue_lockdown[ 3 ].y = 65; 

    level.talk_continue_lockdown[ 0 ].fontscale = 1.25;
    level.talk_continue_lockdown[ 1 ].fontscale = 1.25; 
    level.talk_continue_lockdown[ 2 ].fontscale = 1.25; 
    level.talk_continue_lockdown[ 3 ].fontscale = 1.25; 
    

    level.talk_continue_lockdown[ 0 ] settext( "Excellent!" );
    level.talk_continue_lockdown[ 1 ] settext( "^3Scientists'^7 anti tampering methods didn't ^3stop^7 us from ^3overriding^7 the system!" );
    level.talk_continue_lockdown[ 2 ] settext( "Great ^3job^7, we are so ^3close^7.. " );
    level.talk_continue_lockdown[ 3 ] settext( "Keep on ^3going^7!" );
    
    level.talk_continue_lockdown[ 0 ].alpha = 0;
    level.talk_continue_lockdown[ 1 ].alpha = 0;
    level.talk_continue_lockdown[ 2 ].alpha = 0;
    level.talk_continue_lockdown[ 3 ].alpha = 0;
    f = 2;
    x = 0;
    for ( s = 0; s < level.shades_continue_lockdown.size; s++ )
    {
        level.shades_continue_lockdown[ s ].alpha = 0;
        level.shades_continue_lockdown[ s ] fadeovertime( f );
        level.shades_continue_lockdown[ s ].alpha = 1;
        wait randomfloatrange( 0.14, 0.3 );

        if( x < 3 )
        {
            x++;
            level notify( "beep_talker" );
        }
        f -= 0.25;
    }
    level.cyto_continue_lockdown.alpha = 0;
    level.cyto_continue_lockdown fadeovertime( 4 );
    level.cyto_continue_lockdown.alpha = 1;
    wait 0.1;
    //display a flashing loop fx at first
    f = 2;
    for( i = 0; i < level.talk_continue_lockdown.size; i++ )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.talk_continue_lockdown[ i ].alpha = 0;
        level.talk_continue_lockdown[ i ] fadeovertime( v );
        level.talk_continue_lockdown[ i ].alpha = 1;
        wait 0.08;
    }
    for( i = level.talk_continue_lockdown.size; i > 0; i-- )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.talk_continue_lockdown[ i ].alpha = 1;
        level.talk_continue_lockdown[ i ] fadeovertime( v );
        level.talk_continue_lockdown[ i ].alpha = 0;
        wait 0.08;        
    }
    wait 0.1;
    //display the text for a x duration
    for( i = 0; i < level.talk_continue_lockdown.size; i++ )
    {
        v = randomfloatrange( 0.4, 0.9 );
        level.talk_continue_lockdown[ i ].alpha = 0;
        level.talk_continue_lockdown[ i ] fadeovertime( v );
        level.talk_continue_lockdown[ i ].alpha = 1;
        wait 0.08;  
    }
    wait 1;
    for ( s = 0; s < level.talk_continue_lockdown.size; s++ )
    {
        level.talk_continue_lockdown[ s ] thread sq_talk_turn_colors();
        wait randomfloatrange( 0.4, 0.9 );
    }
    wait 8.5;
    level.talk_continue_lockdown = array_randomize( level.talk_continue_lockdown );
    level.talker_continue_lockdown.alpha = 1;
    level.talker_continue_lockdown fadeovertime( 3.5 );
    level.talker_continue_lockdown.alpha = 0;

    level.cyto_continue_lockdown.alpha = 1;
    level.cyto_continue_lockdown fadeovertime( 3.5 );
    level.cyto_continue_lockdown.alpha = 0;
    wait .1;
    x = 2.5;
    for ( u = 0; u < level.shades_continue_lockdown.size; u++ )
    {
        s = randomfloatrange( 0.3, 0.6 );
        level.shades_continue_lockdown[ u ].alpha = 1;
        level.shades_continue_lockdown[ u ] fadeovertime( x );
        level.shades_continue_lockdown[ u ].alpha = 0;
        x -= 0.35;
        wait s;
    }
    x = 2.5;
    for( i = 0; i < level.talk_continue_lockdown.size; i++ )
    {
        level.talk_continue_lockdown[ i ].alpha = 1;
        level.talk_continue_lockdown[ i ] fadeovertime( x );
        level.talk_continue_lockdown[ i ].alpha = 0;
        x -= 0.35;
    }
    wait 0.1;
    wait 3;
    level.talker_continue_lockdown destroy_hud();
    level.cyto_continue_lockdown destroy_hud();
    for ( i = 0; i < level.talk_continue_lockdown.size; i++ )
    {
        level.talk_continue_lockdown[ i ] destroy_hud();
    }
    for( i = 0; i < level.shades_continue_lockdown.size; i++ )
    {
        level.shades_continue_lockdown[ i ] destroy_hud();
    }
    level.talker_continue_lockdown delete();
    level.cyto_continue_lockdown delete();
    level.talk_continue_lockdown delete();
    level.shades_continue_lockdown delete();
}

sq_talk_13_lockdown_override()
{
    
    level endon( "end_game" );
    level.talk_daytime = [];
    level.shades_daytime = [];
    r_width = 40;
    r_height = 40;

    width = 310;
    height = 16;
    x = 1.8;
    r = 1.6;
    x = 0;
    level.talker_daytime = newHudElem();
    level.talker_daytime.x = 10;
    level.talker_daytime.y = 0;
    level.talker_daytime.alignx = "left";
    level.talker_daytime.aligny = "top";
    level.talker_daytime.horzalign = "user_left";
    level.talker_daytime.vertalign = "user_top";
    level.talker_daytime.alpha = 0;
    level.talker_daytime.foreground = true;
    level.talker_daytime.hidewheninmenu = true;
    level.talker_daytime setshader( "zombies_rank_3_ded", r_width, r_height );
    level.talker_daytime.y = 26;
    level.talker_daytime thread sq_talk_skull_icon_blinker();
    s = 0;

    level.cyto_daytime = newHudElem();
    level.cyto_daytime.x = 21;
    level.cyto_daytime.y = 0;
    level.cyto_daytime.alignx = "left";
    level.cyto_daytime.aligny = "top";
    level.cyto_daytime.horzalign = "user_left";
    level.cyto_daytime.vertalign = "user_top";
    level.cyto_daytime.alpha = 0;
    level.cyto_daytime.foreground = true;
    level.cyto_daytime.hidewheninmenu = true;
    level.cyto_daytime.fontscale = 1;
    level.cyto_daytime settext( "T^2.^2E^7.^7D^2.^2D" );
    level.cyto_daytime.y = 67.5;

    for( x = 0; x < 6; x++ )
    {
        level.shades_daytime[ x ] = newHudElem();
        level.shades_daytime[ x ].x = 45;
        level.shades_daytime[ x ].y = 0;
        level.shades_daytime[ x ].alignx = "left";
        level.shades_daytime[ x ].aligny = "top";
        level.shades_daytime[ x ].horzalign = "user_left";
        level.shades_daytime[ x ].vertalign = "user_top";
        level.shades_daytime[ x ].alpha = 0;
        level.shades_daytime[ x ].color = ( 0.67, 0, 0.01 );
        level.shades_daytime[ x ].inuse = false;
        level.shades_daytime[ x ].hidewheninmenu = true;
        level.shades_daytime[ x ] setshader( "scorebar_zom_1", width, height );
        wait 0.05;
       
    }

    level.shades_daytime[ 0 ].y = 18;
    level.shades_daytime[ 1 ].y = 28;
    level.shades_daytime[ 2 ].y = 38;
    level.shades_daytime[ 3 ].y = 48;
    level.shades_daytime[ 4 ].y = 58;
    level.shades_daytime[ 5 ].y = 68;

    for ( f = 0; f < 4; f++ )
    {
        level.talk_daytime[ f ] = newHudElem();
        level.talk_daytime[ f ].x = 60;
        level.talk_daytime[ f ].y = 0;
        level.talk_daytime[ f ].alignx = "left";
        level.talk_daytime[ f ].aligny = "top";
        level.talk_daytime[ f ].horzalign = "user_left";
        level.talk_daytime[ f ].vertalign = "user_top";
        level.talk_daytime[ f ].foreground = true;
        level.talk_daytime[ f ].alpha = 0;
        level.talk_daytime[ f ].color = ( 1, 1, 1 );
        level.talk_daytime[ f ].inuse = false;
        level.talk_daytime[ f ].hidewheninmenu = true;
        level.talk_daytime[ f ].font = "default";
    }

    level.talk_daytime[ 0 ].y = 20; 
    level.talk_daytime[ 1 ].y = 35; 
    level.talk_daytime[ 2 ].y = 50;
    level.talk_daytime[ 3 ].y = 65; 

    level.talk_daytime[ 0 ].fontscale = 1.25; 
    level.talk_daytime[ 1 ].fontscale = 1.25;
    level.talk_daytime[ 2 ].fontscale = 1.25; 
    level.talk_daytime[ 3 ].fontscale = 1.25; 
    

    level.talk_daytime[ 0 ] settext( "Ah everything's so ^3bright^7 again haha!" );
    level.talk_daytime[ 1 ] settext( "Those ^3generators^7 should be ^3powered^7 now." );
    level.talk_daytime[ 2 ] settext( "I think we will need to ^3override^7 launch control ^3lockdowns^7." );
    level.talk_daytime[ 3 ] settext( "Pack up some ^3heat^7 before you try ^3overriding^7 them!" );
    
    level.talk_daytime[ 0 ].alpha = 0;
    level.talk_daytime[ 1 ].alpha = 0;
    level.talk_daytime[ 2 ].alpha = 0;
    level.talk_daytime[ 3 ].alpha = 0;

    f = 2;
    x = 0;
    for ( s = 0; s < level.shades_daytime.size; s++ )
    {
        level.shades_daytime[ s ].alpha = 0;
        level.shades_daytime[ s ] fadeovertime( f );
        level.shades_daytime[ s ].alpha = 1;
        wait randomfloatrange( 0.14, 0.3 );
        if ( x < 3 )
        {
            level notify( "beep_talker" );
        }
        f -= 0.25;
        x++;
    }
    level.cyto_daytime.alpha = 0;
    level.cyto_daytime fadeovertime( 2 );
    level.cyto_daytime.alpha = 1;

    wait 0.1;

    //display a flashing loop fx at first
    f = 2;
    for( i = 0; i < level.talk_daytime.size; i++ )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.talk_daytime[ i ].alpha = 0;
        level.talk_daytime[ i ] fadeovertime( v );
        level.talk_daytime[ i ].alpha = 1;
        wait 0.08;
    }

    for( i = level.talk_daytime.size; i > 0; i-- )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.talk_daytime[ i ].alpha = 1;
        level.talk_daytime[ i ] fadeovertime( v );
        level.talk_daytime[ i ].alpha = 0;
        wait 0.08;        
    }
    wait 0.1;

    //display the text for a x duration
    for( i = 0; i < level.talk_daytime.size; i++ )
    {
        v = randomfloatrange( 0.4, 0.9 );
        level.talk_daytime[ i ].alpha = 0;
        level.talk_daytime[ i ] fadeovertime( v );
        level.talk_daytime[ i ].alpha = 1;
        wait 0.08;  
    }
    wait 1;

    for ( s = 0; s < level.talk_daytime.size; s++ )
    {
        level.talk_daytime[ s ] thread sq_talk_turn_colors();
        wait randomfloatrange( 0.4, 0.9 );
    }
    wait 8.5;

    level.talk_daytime = array_randomize( level.talk_daytime );


    level.talker_daytime.alpha = 1;
    level.talker_daytime fadeovertime( 3.5 );
    level.talker_daytime.alpha = 0;

    level.cyto_daytime.alpha = 1;
    level.cyto_daytime fadeovertime( 3.5 );
    level.cyto_daytime.alpha = 0;
    wait .1;

    x = 2.5;
    for ( u = 0; u < level.shades_daytime.size; u++ )
    {
        s = randomfloatrange( 0.3, 0.6 );
        level.shades_daytime[ u ].alpha = 1;
        level.shades_daytime[ u ] fadeovertime( x );
        level.shades_daytime[ u ].alpha = 0;
        x -= 0.35;
        wait s;
    }
    x = 2.5;
    for( i = 0; i < level.talk_daytime.size; i++ )
    {
        level.talk_daytime[ i ].alpha = 1;
        level.talk_daytime[ i ] fadeovertime( x );
        level.talk_daytime[ i ].alpha = 0;
        x -= 0.35;
    }
    wait 0.1;
    wait 3;
    level.talker_daytime destroy_hud();
    level.cyto_daytime destroy_hud();
    for ( i = 0; i < level.talk_daytime.size; i++ )
    {
        level.talk_daytime[ i ] destroy_hud();
    }
    for( i = 0; i < level.shades_daytime.size; i++ )
    {
        level.shades_daytime[ i ] destroy_hud();
    }
    level.talker_daytime delete();
    level.cyto_daytime delete();
    level.talk_daytime delete();
    level.shades_daytime delete();
}
