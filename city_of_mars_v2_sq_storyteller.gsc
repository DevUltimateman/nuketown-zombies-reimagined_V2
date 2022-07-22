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

    level thread sq_talker_logic();
    //handles notifies for next files & current teleport enable`=? 
    level thread stop_cacs_notify(); //level specific one!
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
}



sq_talker_logic()
{
    level endon( "end_game" );

    flag_wait( "initial_blackscreen_passed" );
    wait 15;
    level thread sq_talk1();
    wait 1;
    level waittill( "sq_talk_1_pt2" );
    wait 1;
    level thread sq_talk_1_pt2();
    wait 1;
    level waittill( "step1_completed" );
    wait 2;
    level thread sq_talk2_manne_finished();
    wait 1;
    level waittill( "step2_completed" );
    wait 3;
    level thread sq_talk_3_barbeque();
    wait 1;
    level waittill( "spawn_teleport_fx" );
    wait 0.5;
    level thread sq_talk_4_perk_heaven();
}



stop_cacs_notify() //level specific one!
{
    level endon( "end_game" );

    flag_wait( "initial_blackscreen_passed" );
    level waittill( "step1_completed" );
    wait 1.2;
    level notify( "stop_cacs_playing" );

    wait 1;
    level waittill( "spawn_teleport_fx" );
    wait 3;
    level thread teleport_used_check(); //notify to move on to the next file

}



//HUD ELEMENTS FOR STORYTELLING _before_perk_heaven
//arrays are per player basis, always call them on all players instead of 1

teleport_used_check()
{
    level endon( "end_game" );
    while ( !level.someone_used_teleporter )
    {
        wait 2;
    }
    wait randomintrange( 15, 35 );
    level notify( "teleport_has_been_accessed" );
    wait 0.5;
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
sq_talk1()
{
    level endon( "end_game" );

    level.sq1 = [];
    level.shades = [];
    level.restricted = [];
    r_width = 40;
    r_height = 40;

    width = 310;
    height = 16;
    x = 1.8;
    r = 1.6;
    x = 0;
    level.talker = newHudElem();
    level.talker.x = 10;
    level.talker.y = 0;
    level.talker.alignx = "left";
    level.talker.aligny = "top";
    level.talker.horzalign = "user_left";
    level.talker.vertalign = "user_top";
    level.talker.alpha = 0;
    level.talker.foreground = true;
    level.talker.hidewheninmenu = true;
    level.talker setshader( "zombies_rank_3_ded", r_width, r_height );

    level.talker.y = 26;
    level.talker.glowalpha = 0.8;
    level.talker.glowcolor = ( 1, 0.7, 0 );
    level.talker thread sq_talk_skull_icon_blinker();
    s = 0;
    level playlocalsound( level.zmb_laugh_alias );
    level.cyto = newHudElem();
    level.cyto.x = 21;
    level.cyto.y = 0;
    level.cyto.alignx = "left";
    level.cyto.aligny = "top";
    level.cyto.horzalign = "user_left";
    level.cyto.vertalign = "user_top";
    level.cyto.alpha = 0;
    level.cyto.foreground = true;
    level.cyto.hidewheninmenu = true;
    level.cyto.fontscale = 1;
    level.cyto settext( "T^2.^2E^7.^7D^2.^2D" );
    level.cyto.y = 67.5;
    

    for( x = 0; x < 6; x++ )
    {
        level.shades[ x ] = newHudElem();
        level.shades[ x ].x = 45;
        level.shades[ x ].y = 0;
        level.shades[ x ].alignx = "left";
        level.shades[ x ].aligny = "top";
        level.shades[ x ].horzalign = "user_left";
        level.shades[ x ].vertalign = "user_top";
        level.shades[ x ].alpha = 0;
        level.shades[ x ].color = ( 0.67, 0, 0.01 );
        level.shades[ x ].inuse = false;
        level.shades[ x ].hidewheninmenu = true;
        level.shades[ x ] setshader( "scorebar_zom_1", width, height );
        wait 0.05;
    }

    level.shades[ 0 ].y = 18;
    level.shades[ 1 ].y = 28;
    level.shades[ 2 ].y = 38;
    level.shades[ 3 ].y = 48;
    level.shades[ 4 ].y = 58;
    level.shades[ 5 ].y = 68;

    for ( f = 0; f < 4; f++ )
    {
        level.sq1[ f ] = newHudElem();
        level.sq1[ f ].x = 60;
        level.sq1[ f ].y = 0;
        level.sq1[ f ].alignx = "left";
        level.sq1[ f ].aligny = "top";
        level.sq1[ f ].horzalign = "user_left";
        level.sq1[ f ].vertalign = "user_top";
        level.sq1[ f ].foreground = true;
        level.sq1[ f ].alpha = 0;
        level.sq1[ f ].color = ( 1, 1, 1 );
        level.sq1[ f ].inuse = false;
        level.sq1[ f ].hidewheninmenu = true;
        level.sq1[ f ].font = "default";
    }

    level.sq1[ 0 ].y = 20;
    level.sq1[ 1 ].y = 35;
    level.sq1[ 2 ].y = 50;
    level.sq1[ 3 ].y = 65;

    level.sq1[ 0 ].fontscale = 1.25; //1.25
    level.sq1[ 1 ].fontscale = 1.25; //1.4
    level.sq1[ 2 ].fontscale = 1.25; //1.25
    level.sq1[ 3 ].fontscale = 1.25; //1.4

    level.sq1[ 0 ] settext( "Ahh I see. ^3Test Subjects^7 have woken up!" );
    level.sq1[ 1 ] settext( "Glad to see at least someone ^3still alive^7, hah!" );
    level.sq1[ 2 ] settext( "Others have already ^3perished^7 a long time ago." );
    level.sq1[ 3 ] settext( "Anyways..." );

    f = 2;
    cut = true;
    for ( s = 0; s < level.shades.size; s++ )
    {
        if ( cut )
        {
            level notify( "beep_talker" );
            playsoundatposition( "zmb_meteor_activate", ( 0, 0, 0 ) );
            cut = false;
        }
        level.shades[ s ] fadeovertime( f );
        level.shades[ s ].alpha = 1;
        wait randomfloatrange( 0.3, 0.8 );
        f -= 0.25;
    }
    playsoundatposition( "zmb_box_poof", ( 0, 0, 0 ) );
    level.cyto.alpha = 0;
    level.cyto fadeovertime( 4 );
    level.cyto.alpha = 1;
    wait 0.1;
    f = 2;
    for( s = 0; s < level.sq1.size; s++ )
    {
        level.sq1[ s ].alpha = 0;
        level.sq1[ s ] fadeovertime( f );
        level.sq1[ s ].alpha = 1;
        level.sq1[ s ] thread sq_talk_turn_colors();
        wait randomfloatrange( 0.3, 0.7 );
        f -= 0.25;
    }
    wait 8;
    x = 2.5;
    level.sq1 = array_randomize( level.sq1 );
    level.talker.alpha =1;
    level.talker fadeovertime( 2.5 );
    level.talker.alpha = 0;

    level.cyto.alpha = 1;
    level.cyto fadeovertime( 2.5 );
    level.cyto.alpha = 0;

    x = 2.5;
    for ( i = 0; i < level.shades.size; i++ )
    {
        level.shades[ i ].alpha = 1;
        level.shades[ i ] fadeovertime( x );
        level.shades[ i ].alpha = 0;
        x -= 0.35;
    }
    x = 2.5;
    for ( i = 0; i < level.sq1.size; i++ )
    {
        level.sq1[ i ].alpha = 1;
        level.sq1[ i ] fadeovertime( x );
        level.sq1[ i ].alpha = 0;
        x -= 0.35;
        wait 1;
    }
    
    wait 0.1;
    level notify( "sq_talk_1_pt2" );
    wait 3;

    level.cyto destroy_hud();
    level.talker destroy_hud();

    for ( i = 0; i < level.sq1.size; i++ )
    {
        level.sq1[ i ] destroy_hud();
        level.shades[ i ] destroy_hud();
    }
    level.cyto delete();
    level.talker delete();
    level.sq1 delete();
    level.shades delete();
    
}

sq_talk_1_pt2()
{
    
    level endon( "end_game" );

    level.sq1_pt2 = [];
    level.shades2 = [];
    r_width = 40;
    r_height = 40;

    width = 310;
    height = 16;
    x = 1.8;
    r = 1.6;
    x = 0;
    level.talker2 = newHudElem();
    level.talker2.x = 10;
    level.talker2.y = 0;
    level.talker2.alignx = "left";
    level.talker2.aligny = "top";
    level.talker2.horzalign = "user_left";
    level.talker2.vertalign = "user_top";
    level.talker2.alpha = 0;
    level.talker2.foreground = true;
    level.talker2.hidewheninmenu = true;
    level.talker2 setshader( "zombies_rank_3_ded", r_width, r_height );
    level.talker2.y = 26;
    level.talker2 thread sq_talk_skull_icon_blinker();
    s = 0;

    level.cyto2 = newHudElem();
    level.cyto2.x = 21;
    level.cyto2.y = 0;
    level.cyto2.alignx = "left";
    level.cyto2.aligny = "top";
    level.cyto2.horzalign = "user_left";
    level.cyto2.vertalign = "user_top";
    level.cyto2.alpha = 0;
    level.cyto2.foreground = true;
    level.cyto2.hidewheninmenu = true;
    level.cyto2.fontscale = 1;
    level.cyto2 settext( "T^2.^2E^7.^7D^2.^2D" );
    level.cyto2.y = 67.5;

    for( x = 0; x < 6; x++ )
    {
        level.shades2[ x ] = newHudElem();
        level.shades2[ x ].x = 45;
        level.shades2[ x ].y = 0;
        level.shades2[ x ].alignx = "left";
        level.shades2[ x ].aligny = "top";
        level.shades2[ x ].horzalign = "user_left";
        level.shades2[ x ].vertalign = "user_top";
        level.shades2[ x ].alpha = 0;
        level.shades2[ x ].color = ( 0.67, 0, 0.01 );
        level.shades2[ x ].inuse = false;
        level.shades2[ x ].hidewheninmenu = true;
        level.shades2[ x ] setshader( "scorebar_zom_1", width, height );
        wait 0.05;
       
    }

    level.shades2[ 0 ].y = 18;
    level.shades2[ 1 ].y = 28;
    level.shades2[ 2 ].y = 38;
    level.shades2[ 3 ].y = 48;
    level.shades2[ 4 ].y = 58;
    level.shades2[ 5 ].y = 68;

    for ( f = 0; f < 4; f++ )
    {
        level.sq1_pt2[ f ] = newHudElem();
        level.sq1_pt2[ f ].x = 60;
        level.sq1_pt2[ f ].y = 0;
        level.sq1_pt2[ f ].alignx = "left";
        level.sq1_pt2[ f ].aligny = "top";
        level.sq1_pt2[ f ].horzalign = "user_left";
        level.sq1_pt2[ f ].vertalign = "user_top";
        level.sq1_pt2[ f ].foreground = true;
        level.sq1_pt2[ f ].alpha = 0;
        level.sq1_pt2[ f ].color = ( 1, 1, 1 );
        level.sq1_pt2[ f ].inuse = false;
        level.sq1_pt2[ f ].hidewheninmenu = true;
        level.sq1_pt2[ f ].font = "default";
    }

    level.sq1_pt2[ 0 ].y = 20;
    level.sq1_pt2[ 1 ].y = 35;
    level.sq1_pt2[ 2 ].y = 50;
    level.sq1_pt2[ 3 ].y = 65;

    level.sq1_pt2[ 0 ].fontscale = 1.25;
    level.sq1_pt2[ 1 ].fontscale = 1.25;
    level.sq1_pt2[ 2 ].fontscale = 1.25;
    level.sq1_pt2[ 3 ].fontscale = 1.25;
    

    level.sq1_pt2[ 0 ] settext( "We must take ^3revenge^7.." );
    level.sq1_pt2[ 1 ] settext( "^3You ^7can help me with that... ^3Yes?" );
    level.sq1_pt2[ 2 ] settext( "Start off by ^3decapitating^7 every ^3dummy's ^7head!" );
    level.sq1_pt2[ 3 ] settext( "I'll see if I can locate the ^3floating head^7 for ^3you^7 after that." );

    level.sq1_pt2[ 0 ].alpha = 0;
    level.sq1_pt2[ 1 ].alpha = 0;
    level.sq1_pt2[ 2 ].alpha = 0;
    level.sq1_pt2[ 3 ].alpha = 0;

    f = 2;
    lovely = true;
    for ( s = 0; s < level.shades2.size; s++ )
    {
        level.shades2[ s ].alpha = 0;
        level.shades2[ s ] fadeovertime( f );
        level.shades2[ s ].alpha = 1;
        if ( lovely )
        {
            level notify( "beep_talker" );
            playsoundatposition( "zmb_meteor_activate", ( 0, 0, 0 ) );
            lovely = false;
        }
        wait randomfloatrange( 0.14, 0.3 );
        f -= 0.25;
    }
    level.cyto2.alpha = 0;
    level.cyto2 fadeovertime( 4 );
    level.cyto2.alpha = 1;

    wait 0.1;

    f = 2;
    for( i = 0; i < level.sq1_pt2.size; i++ )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.sq1_pt2[ i ].alpha = 0;
        level.sq1_pt2[ i ] fadeovertime( v );
        level.sq1_pt2[ i ].alpha = 1;
        wait 0.08;
    }

    for( i = level.sq1_pt2.size; i > 0; i-- )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.sq1_pt2[ i ].alpha = 1;
        level.sq1_pt2[ i ] fadeovertime( v );
        level.sq1_pt2[ i ].alpha = 0;
        wait 0.08;        
    }
    wait 0.1;

    for( i = 0; i < level.sq1_pt2.size; i++ )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.sq1_pt2[ i ].alpha = 0;
        level.sq1_pt2[ i ] fadeovertime( v );
        level.sq1_pt2[ i ].alpha = 1;
        wait 0.08;    
    }
    wait 0.1;

    for( i = level.sq1_pt2.size; i > 0; i-- )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.sq1_pt2[ i ].alpha = 1;
        level.sq1_pt2[ i ] fadeovertime( v );
        level.sq1_pt2[ i ].alpha = 0;
        wait 0.08;
    }
    wait 0.05;

    for( i = 0; i < level.sq1_pt2.size; i++ )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.sq1_pt2[ i ].alpha = 0;
        level.sq1_pt2[ i ] fadeovertime( v );
        level.sq1_pt2[ i ].alpha = 1;
        wait 0.08;  
    }
    wait 0.05;

    for( i = level.sq1_pt2.size; i > 0; i-- )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.sq1_pt2[ i ].alpha = 1;
        level.sq1_pt2[ i ] fadeovertime( v );
        level.sq1_pt2[ i ].alpha = 0;
        wait 0.08;
    }
    wait 0.1;

    for( i = 0; i < level.sq1_pt2.size; i++ )
    {
        v = randomfloatrange( 0.4, 0.9 );
        level.sq1_pt2[ i ].alpha = 0;
        level.sq1_pt2[ i ] fadeovertime( v );
        level.sq1_pt2[ i ].alpha = 1;
        wait 0.08;  
    }
    wait 1;

    for ( s = 0; s < level.sq1_pt2.size; s++ )
    {
        level.sq1_pt2[ s ] thread sq_talk_turn_colors();
        wait randomfloatrange( 0.4, 0.9 );
    }
    wait 8.5;

    level.sq1_pt2 = array_randomize( level.sq1_pt2 );


    level.talker2.alpha = 1;
    level.talker2 fadeovertime( 3.5 );
    level.talker2.alpha = 0;

    level.cyto2.alpha = 1;
    level.cyto2 fadeovertime( 3.5 );
    level.cyto2.alpha = 0;
    wait .1;

    x = 2.5;
    for ( u = 0; u < level.shades2.size; u++ )
    {
        s = randomfloatrange( 0.3, 0.6 );
        level.shades2[ u ].alpha = 1;
        level.shades2[ u ] fadeovertime( x );
        level.shades2[ u ].alpha = 0;
        x -= 0.35;
        wait s;
    }
    x = 2.5;
    for( i = 0; i < level.sq1_pt2.size; i++ )
    {
        level.sq1_pt2[ i ].alpha = 1;
        level.sq1_pt2[ i ] fadeovertime( x );
        level.sq1_pt2[ i ].alpha = 0;
        x -= 0.35;
    }

    wait 3;
    level.talker2 destroy_hud();
    level.cyto2 destroy_hud();

    for ( i = 0; i < level.sq1_pt2.size; i++ )
    {
        level.sq1_pt2[ i ] destroy_hud();
    }

    for( i = 0; i < level.shades2.size; i++ )
    {
        level.shades2[ i ] destroy_hud();
    }

    level.cyto2 delete();
    level.talker2 delete();
    level.sq1_pt2 delete();
    level.shades2 delete();
}

sq_talk2_manne_finished()
{
    level endon( "end_game" );

    level.sq2 = [];
    level.shades3 = [];
    r_width = 40;
    r_height = 40;

    width = 310;
    height = 16;
    x = 1.8;
    r = 1.6;
    x = 0;
    level.talker3 = newHudElem();
    level.talker3.x = 10;
    level.talker3.y = 0;
    level.talker3.alignx = "left";
    level.talker3.aligny = "top";
    level.talker3.horzalign = "user_left";
    level.talker3.vertalign = "user_top";
    level.talker3.alpha = 0;
    level.talker3.foreground = true;
    level.talker3.hidewheninmenu = true;
    level.talker3 setshader( "zombies_rank_3_ded", r_width, r_height );
    level.talker3.y = 26;
    level.talker3.glowalpha = 0.8;
    level.talker3.glowcolor = ( 1, 0.7, 0 );
    level.talker3 thread sq_talk_skull_icon_blinker();
    s = 0;

    level.cyto3 = newHudElem();
    level.cyto3.x = 21;
    level.cyto3.y = 0;
    level.cyto3.alignx = "left";
    level.cyto3.aligny = "top";
    level.cyto3.horzalign = "user_left";
    level.cyto3.vertalign = "user_top";
    level.cyto3.alpha = 0;
    level.cyto3.foreground = true;
    level.cyto3.hidewheninmenu = true;
    level.cyto3.fontscale = 1;
    level.cyto3 settext( "T^2.^2E^7.^7D^2.^2D" );
    level.cyto3.y = 67.5;
    

    for( x = 0; x < 6; x++ )
    {
        level.shades3[ x ] = newHudElem();
        level.shades3[ x ].x = 45;
        level.shades3[ x ].y = 0;
        level.shades3[ x ].alignx = "left";
        level.shades3[ x ].aligny = "top";
        level.shades3[ x ].horzalign = "user_left";
        level.shades3[ x ].vertalign = "user_top";
        level.shades3[ x ].alpha = 0;
        level.shades3[ x ].color = ( 0.67, 0, 0.01 );
        level.shades3[ x ].inuse = false;
        level.shades3[ x ].hidewheninmenu = true;
        level.shades3[ x ] setshader( "scorebar_zom_1", width, height );
        wait 0.05;
    }

    level.shades3[ 0 ].y = 18;
    level.shades3[ 1 ].y = 28;
    level.shades3[ 2 ].y = 38;
    level.shades3[ 3 ].y = 48;
    level.shades3[ 4 ].y = 58;
    level.shades3[ 5 ].y = 68;

    for ( f = 0; f < 4; f++ )
    {
        level.sq2[ f ] = newHudElem();
        level.sq2[ f ].x = 60;
        level.sq2[ f ].y = 0;
        level.sq2[ f ].alignx = "left";
        level.sq2[ f ].aligny = "top";
        level.sq2[ f ].horzalign = "user_left";
        level.sq2[ f ].vertalign = "user_top";
        level.sq2[ f ].foreground = true;
        level.sq2[ f ].alpha = 0;
        level.sq2[ f ].color = ( 1, 1, 1 );
        level.sq2[ f ].inuse = false;
        level.sq2[ f ].hidewheninmenu = true;
        level.sq2[ f ].font = "default";
    }

    level.sq2[ 0 ].y = 20;
    level.sq2[ 1 ].y = 35;
    level.sq2[ 2 ].y = 50;
    level.sq2[ 3 ].y = 65;

    level.sq2[ 0 ].fontscale = 1.25;
    level.sq2[ 1 ].fontscale = 1.25;
    level.sq2[ 2 ].fontscale = 1.25;
    level.sq2[ 3 ].fontscale = 1.25;

    level.sq2[ 0 ] settext( "zzz... Oh great, all the ^3mannequins^7 are now ^3headless^7. Wunderbar haha!" );
    level.sq2[ 1 ] settext( "^3Anyways^7, what took ^3you^7 so long?" );
    level.sq2[ 2 ] settext( "I have already ^3teleported^7 the head for ^3you^7, but I can't remember where I ^3left^7 it at." );
    level.sq2[ 3 ] settext( "Take a look around the area and ^3see^7 if you can ^3find^7 it!" );
    f = 2;
    
    salsa = false;
    for ( s = 0; s < level.shades3.size; s++ )
    {
        level.shades3[ s ] fadeovertime( f );
        level.shades3[ s ].alpha = 1;
        wait randomfloatrange( 0.3, 0.8 );
        if ( !salsa )
        {
            level notify( "beep_talker" );
            playsoundatposition( "zmb_meteor_activate", ( 0, 0, 0 ) );
            salsa = true;
        }
        f -= 0.25;
    }
    level.cyto3.alpha = 0;
    level.cyto3 fadeovertime( 4 );
    level.cyto3.alpha = 1;
    wait 0.1;
    f = 2;
    for( s = 0; s < level.sq2.size; s++ )
    {
        level.sq2[ s ].alpha = 0;
        level.sq2[ s ] fadeovertime( f );
        level.sq2[ s ].alpha = 1;
        level.sq2[ s ] thread sq_talk_turn_colors();
        wait randomfloatrange( 0.3, 0.7 );
        f -= 0.25;
    }
    wait 8;
    x = 2.5;
    level.sq2 = array_randomize( level.sq2 );
    level.talker3.alpha = 1;
    level.talker3 fadeovertime( 2.5 );
    level.talker3.alpha = 0;

    level.cyto3.alpha = 1;
    level.cyto3 fadeovertime( 2.5 );
    level.cyto3.alpha = 0;

    x = 2.5;
    for ( i = 0; i < level.shades3.size; i++ )
    {
        level.shades3[ i ].alpha = 1;
        level.shades3[ i ] fadeovertime( x );
        level.shades3[ i ].alpha = 0;
        x -= 0.35;
    }
    x = 2.5;
    for ( i = 0; i < level.sq2.size; i++ )
    {
        level.sq2[ i ].alpha = 1;
        level.sq2[ i ] fadeovertime( x );
        level.sq2[ i ].alpha = 0;
        x -= 0.35;
        wait 1;
    }

    wait 6;
    level.cyto3 destroy_hud();
    level.talker3 destroy_hud();
    for ( i = 0; i < level.sq2.size; i++ )
    {
        level.sq2[ i ] destroy_hud();
        level.shades3[ i ] destroy_hud();
    }
    level.cyto3 delete();
    level.talker3 delete();
    self.sq3 delete();
    level.shades3 delete();
}


sq_talk_3_barbeque()
{
    
    level endon( "end_game" );
    level.sqb = [];
    level.shadesb = [];
    r_width = 40;
    r_height = 40;

    width = 310;
    height = 16;
    x = 1.8;
    r = 1.6;
    x = 0;
    level.talkerb = newHudElem();
    level.talkerb.x = 10;
    level.talkerb.y = 0;
    level.talkerb.alignx = "left";
    level.talkerb.aligny = "top";
    level.talkerb.horzalign = "user_left";
    level.talkerb.vertalign = "user_top";
    level.talkerb.alpha = 0;
    level.talkerb.foreground = true;
    level.talkerb.hidewheninmenu = true;
    level.talkerb setshader( "zombies_rank_3_ded", r_width, r_height );
    level.talkerb.y = 26;
    level.talkerb thread sq_talk_skull_icon_blinker();
    s = 0;

    level.cytob = newHudElem();
    level.cytob.x = 21;
    level.cytob.y = 0;
    level.cytob.alignx = "left";
    level.cytob.aligny = "top";
    level.cytob.horzalign = "user_left";
    level.cytob.vertalign = "user_top";
    level.cytob.alpha = 0;
    level.cytob.foreground = true;
    level.cytob.hidewheninmenu = true;
    level.cytob.fontscale = 1;
    level.cytob settext( "T^2.^2E^7.^7D^2.^2D" );
    level.cytob.y = 67.5;

    for( x = 0; x < 4; x++ )
    {
        level.shadesb[ x ] = newHudElem();
        level.shadesb[ x ].x = 45;
        level.shadesb[ x ].y = 0;
        level.shadesb[ x ].alignx = "left";
        level.shadesb[ x ].aligny = "top";
        level.shadesb[ x ].horzalign = "user_left";
        level.shadesb[ x ].vertalign = "user_top";
        level.shadesb[ x ].alpha = 0;
        level.shadesb[ x ].color = ( 0.67, 0, 0.01 );
        level.shadesb[ x ].inuse = false;
        level.shadesb[ x ].hidewheninmenu = true;
        level.shadesb[ x ] setshader( "scorebar_zom_1", width, height );
        wait 0.05;
       
    }

    level.shadesb[ 0 ].y = 28;
    level.shadesb[ 1 ].y = 38;
    level.shadesb[ 2 ].y = 48;
    level.shadesb[ 3 ].y = 58;


    for ( f = 0; f < 4; f++ )
    {
        level.sqb[ f ] = newHudElem();
        level.sqb[ f ].x = 60;
        level.sqb[ f ].y = 0;
        level.sqb[ f ].alignx = "left";
        level.sqb[ f ].aligny = "top";
        level.sqb[ f ].horzalign = "user_left";
        level.sqb[ f ].vertalign = "user_top";
        level.sqb[ f ].foreground = true;
        level.sqb[ f ].alpha = 0;
        level.sqb[ f ].color = ( 1, 1, 1 );
        level.sqb[ f ].inuse = false;
        level.sqb[ f ].hidewheninmenu = true;
        level.sqb[ f ].font = "default";
    }

    level.sqb[ 0 ].y = 20;
    level.sqb[ 1 ].y = 35;
    level.sqb[ 2 ].y = 50;
    level.sqb[ 3 ].y = 65;

    level.sqb[ 0 ].fontscale = 1.25;
    level.sqb[ 1 ].fontscale = 1.25;
    level.sqb[ 2 ].fontscale = 1.25;
    level.sqb[ 3 ].fontscale = 1.25;
    
    // dedicate empty string for top & bottom, aligment seems to be perfect then due to set values from previous functions
    //x, y 
    level.sqb[ 0 ] settext( "" );
    level.sqb[ 1 ] settext( "Ah, you ^3found^7 it. Great ^3success^7!" );
    level.sqb[ 2 ] settext( "Barbeque the ^3head^7 at in front of the ^3bunker^7. Someone's ^3waiting^7 for you.." );
    level.sqb[ 3 ] settext( "" );
    level.sqb[ 0 ].alpha = 0;
    level.sqb[ 1 ].alpha = 0;
    level.sqb[ 2 ].alpha = 0;
    level.sqb[ 3 ].alpha = 0;
    keb = false;
    f = 2;
    for ( s = 0; s < level.shadesb.size; s++ )
    {
        level.shadesb[ s ].alpha = 0;
        level.shadesb[ s ] fadeovertime( f );
        level.shadesb[ s ].alpha = 1;
        wait randomfloatrange( 0.14, 0.3 );
        if( !keb )
        {
            level notify( "beep_talker" );
            playsoundatposition( "zmb_meteor_activate", ( 0, 0, 0 ) );
            keb = true;
        }
        f -= 0.25;
    }
    level.cytob.alpha = 0;
    level.cytob fadeovertime( 4 );
    level.cytob.alpha = 1;

    wait 0.1;

    f = 2;
    for( i = 0; i < level.sqb.size; i++ )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.sqb[ i ].alpha = 0;
        level.sqb[ i ] fadeovertime( v );
        level.sqb[ i ].alpha = 1;
        wait 0.08;
    }

    for( i = level.sqb.size; i > 0; i-- )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.sqb[ i ].alpha = 1;
        level.sqb[ i ] fadeovertime( v );
        level.sqb[ i ].alpha = 0;
        wait 0.08;        
    }
    wait 0.1;

    //display the text for a x duration
    for( i = 0; i < level.sqb.size; i++ )
    {
        v = randomfloatrange( 0.4, 0.9 );
        level.sqb[ i ].alpha = 0;
        level.sqb[ i ] fadeovertime( v );
        level.sqb[ i ].alpha = 1;
        wait 0.08;  
    }
    wait 1;

    for ( s = 0; s < level.sqb.size; s++ )
    {
        level.sqb[ s ] thread sq_talk_turn_colors();
        wait randomfloatrange( 0.4, 0.9 );
    }
    wait 8.5;

    level.sqb = array_randomize( level.sqb );


    level.talkerb.alpha = 1;
    level.talkerb fadeovertime( 3.5 );
    level.talkerb.alpha = 0;

    level.cytob.alpha = 1;
    level.cytob fadeovertime( 3.5 );
    level.cytob.alpha = 0;
    wait .1;

    x = 2.5;
    for ( u = 0; u < level.shadesb.size; u++ )
    {
        s = randomfloatrange( 0.3, 0.6 );
        level.shadesb[ u ].alpha = 1;
        level.shadesb[ u ] fadeovertime( x );
        level.shadesb[ u ].alpha = 0;
        x -= 0.35;
        wait s;
    }
    x = 2.5;
    for( i = 0; i < level.sqb.size; i++ )
    {
        level.sqb[ i ].alpha = 1;
        level.sqb[ i ] fadeovertime( x );
        level.sqb[ i ].alpha = 0;
        x -= 0.35;
    }

    wait 3;

    level.talkerb destroy_hud();
    level.cytob destroy_hud();
    for ( i = 0; i < level.sqb.size; i++ )
    {
        level.sqb[ i ] destroy_hud();
    }

    for( i = 0; i < level.shadesb.size; i++ )
    {
        level.shadesb[ i ] destroy_hud();
    }
    level.talkerb delete();
    level.cytob delete();
    level.sqb delete();
    level.shadesb delete();
}

sq_talk_4_perk_heaven()
{
    
    level endon( "end_game" );
    level.sq_talk_4_pheaven = [];
    level.shades_pheaven = [];
    r_width = 40;
    r_height = 40;

    width = 310;
    height = 16;
    x = 1.8;
    r = 1.6;
    x = 0;
    level.talker_pheaven = newHudElem();
    level.talker_pheaven.x = 10;
    level.talker_pheaven.y = 0;
    level.talker_pheaven.alignx = "left";
    level.talker_pheaven.aligny = "top";
    level.talker_pheaven.horzalign = "user_left";
    level.talker_pheaven.vertalign = "user_top";
    level.talker_pheaven.alpha = 0;
    level.talker_pheaven.foreground = true;
    level.talker_pheaven.hidewheninmenu = true;
    level.talker_pheaven setshader( "zombies_rank_3_ded", r_width, r_height );
    level.talker_pheaven.y = 26;
    level.talker_pheaven thread sq_talk_skull_icon_blinker();
    s = 0;

    level.cyto_pheaven = newHudElem();
    level.cyto_pheaven.x = 21;
    level.cyto_pheaven.y = 0;
    level.cyto_pheaven.alignx = "left";
    level.cyto_pheaven.aligny = "top";
    level.cyto_pheaven.horzalign = "user_left";
    level.cyto_pheaven.vertalign = "user_top";
    level.cyto_pheaven.alpha = 0;
    level.cyto_pheaven.foreground = true;
    level.cyto_pheaven.hidewheninmenu = true;
    level.cyto_pheaven.fontscale = 1;
    level.cyto_pheaven settext( "T^2.^2E^7.^7D^2.^2D" );
    level.cyto_pheaven.y = 67.5;

    for( x = 0; x < 6; x++ )
    {
        level.shades_pheaven[ x ] = newHudElem();
        level.shades_pheaven[ x ].x = 45;
        level.shades_pheaven[ x ].y = 0;
        level.shades_pheaven[ x ].alignx = "left";
        level.shades_pheaven[ x ].aligny = "top";
        level.shades_pheaven[ x ].horzalign = "user_left";
        level.shades_pheaven[ x ].vertalign = "user_top";
        level.shades_pheaven[ x ].alpha = 0;
        level.shades_pheaven[ x ].color = ( 0.67, 0, 0.01 );
        level.shades_pheaven[ x ].inuse = false;
        level.shades_pheaven[ x ].hidewheninmenu = true;
        level.shades_pheaven[ x ] setshader( "scorebar_zom_1", width, height );
        wait 0.05;
       
    }

    level.shades_pheaven[ 0 ].y = 18;
    level.shades_pheaven[ 1 ].y = 28;
    level.shades_pheaven[ 2 ].y = 38;
    level.shades_pheaven[ 3 ].y = 48;
    level.shades_pheaven[ 4 ].y = 58;
    level.shades_pheaven[ 5 ].y = 68;

    for ( f = 0; f < 4; f++ )
    {
        level.sq_talk_4_pheaven[ f ] = newHudElem();
        level.sq_talk_4_pheaven[ f ].x = 60;
        level.sq_talk_4_pheaven[ f ].y = 0;
        level.sq_talk_4_pheaven[ f ].alignx = "left";
        level.sq_talk_4_pheaven[ f ].aligny = "top";
        level.sq_talk_4_pheaven[ f ].horzalign = "user_left";
        level.sq_talk_4_pheaven[ f ].vertalign = "user_top";
        level.sq_talk_4_pheaven[ f ].foreground = true;
        level.sq_talk_4_pheaven[ f ].alpha = 0;
        level.sq_talk_4_pheaven[ f ].color = ( 1, 1, 1 );
        level.sq_talk_4_pheaven[ f ].inuse = false;
        level.sq_talk_4_pheaven[ f ].hidewheninmenu = true;
        level.sq_talk_4_pheaven[ f ].font = "default";
    }

    level.sq_talk_4_pheaven[ 0 ].y = 20;
    level.sq_talk_4_pheaven[ 1 ].y = 35;
    level.sq_talk_4_pheaven[ 2 ].y = 50;
    level.sq_talk_4_pheaven[ 3 ].y = 65; 

    level.sq_talk_4_pheaven[ 0 ].fontscale = 1.25;
    level.sq_talk_4_pheaven[ 1 ].fontscale = 1.25;
    level.sq_talk_4_pheaven[ 2 ].fontscale = 1.25; 
    level.sq_talk_4_pheaven[ 3 ].fontscale = 1.25;
    
    
    level.sq_talk_4_pheaven[ 0 ] settext( "^3What^7?! How are you not ^3dead^7 yet? ^3Lucky^7 you I assume..." );
    level.sq_talk_4_pheaven[ 1 ] settext( "..but I must admit that you ^3did^7 a good job on ^3repairing^7 that bunker." );
    level.sq_talk_4_pheaven[ 2 ] settext( "The ^3bunker is transmitting ^3power^7 to the ^3teleporter^7 again!" );
    level.sq_talk_4_pheaven[ 3 ] settext( "Go ^3buy^7 some ^3drinks^7 now. We are ^3not^7 done yet haha!" );

    level.sq_talk_4_pheaven[ 0 ].alpha = 0;
    level.sq_talk_4_pheaven[ 1 ].alpha = 0;
    level.sq_talk_4_pheaven[ 2 ].alpha = 0;
    level.sq_talk_4_pheaven[ 3 ].alpha = 0;
    ra = false;
    f = 2;
    for ( s = 0; s < level.shades_pheaven.size; s++ )
    {
        level.shades_pheaven[ s ].alpha = 0;
        level.shades_pheaven[ s ] fadeovertime( f );
        level.shades_pheaven[ s ].alpha = 1;
        wait randomfloatrange( 0.14, 0.3 );
        if ( !ra )
        {
            level notify( "beep_talker" );
            playsoundatposition( "zmb_meteor_activate", ( 0, 0, 0 ) );
            ra = true;
        }
        f -= 0.25;
    }
    level.cyto_pheaven.alpha = 0;
    level.cyto_pheaven fadeovertime( 4 );
    level.cyto_pheaven.alpha = 1;

    wait 0.1;

    //display a flashing loop fx at first
    f = 2;
    for( i = 0; i < level.sq_talk_4_pheaven.size; i++ )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.sq_talk_4_pheaven[ i ].alpha = 0;
        level.sq_talk_4_pheaven[ i ] fadeovertime( v );
        level.sq_talk_4_pheaven[ i ].alpha = 1;
        wait 0.08;
    }

    for( i = level.sq_talk_4_pheaven.size; i > 0; i-- )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.sq_talk_4_pheaven[ i ].alpha = 1;
        level.sq_talk_4_pheaven[ i ] fadeovertime( v );
        level.sq_talk_4_pheaven[ i ].alpha = 0;
        wait 0.08;        
    }
    wait 0.1;

    //display the text for a x duration
    for( i = 0; i < level.sq_talk_4_pheaven.size; i++ )
    {
        v = randomfloatrange( 0.4, 0.9 );
        level.sq_talk_4_pheaven[ i ].alpha = 0;
        level.sq_talk_4_pheaven[ i ] fadeovertime( v );
        level.sq_talk_4_pheaven[ i ].alpha = 1;
        wait 0.08;  
    }
    wait 1;

    for ( s = 0; s < level.sq_talk_4_pheaven.size; s++ )
    {
        level.sq_talk_4_pheaven[ s ] thread sq_talk_turn_colors();
        wait randomfloatrange( 0.4, 0.9 );
    }
    wait 8.5;

    level.sq_talk_4_pheaven = array_randomize( level.sq_talk_4_pheaven );


    level.talker_pheaven.alpha = 1;
    level.talker_pheaven fadeovertime( 3.5 );
    level.talker_pheaven.alpha = 0;

    level.cyto_pheaven.alpha = 1;
    level.cyto_pheaven fadeovertime( 3.5 );
    level.cyto_pheaven.alpha = 0;
    wait .1;

    x = 2.5;
    for ( u = 0; u < level.shades_pheaven.size; u++ )
    {
        s = randomfloatrange( 0.3, 0.6 );
        level.shades_pheaven[ u ].alpha = 1;
        level.shades_pheaven[ u ] fadeovertime( x );
        level.shades_pheaven[ u ].alpha = 0;
        x -= 0.35;
        wait s;
    }
    x = 2.5;
    for( i = 0; i < level.sq_talk_4_pheaven.size; i++ )
    {
        level.sq_talk_4_pheaven[ i ].alpha = 1;
        level.sq_talk_4_pheaven[ i ] fadeovertime( x );
        level.sq_talk_4_pheaven[ i ].alpha = 0;
        x -= 0.35;
    }

    wait 3;
    level.talker_pheaven destroy_hud();
    level.cyto_pheaven destroy_hud();
    for ( i = 0; i < level.sq_talk_4_pheaven.size; i++ )
    {
        level.sq_talk_4_pheaven[ i ] destroy_hud();
    }

    for( i = 0; i < level.shades_pheaven.size; i++ )
    {
        level.shades_pheaven[ i ] destroy_hud();
    }
    level.talker_pheaven delete();
    level.cyto_pheaven delete();
    level.sq_talk_4_pheaven delete();
    level.shades_pheaven delete();

}
