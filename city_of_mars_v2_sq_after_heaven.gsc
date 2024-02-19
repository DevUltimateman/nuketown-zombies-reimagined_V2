/*
    Developed by Ultimateman
    Release: 07/22/2022
    Part of City Of Mars Mod for Black Ops II Plutonium
*/





#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;
///////////////////////////////////////
#include maps\mp\gametypes\_hud_util;
#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\gametypes_zm\_hud_message;
#include maps\mp\zombies\_zm_weapons;
#include maps\mp\zombies\_zm_net;
#include maps\mp\zombies\_zm_unitrigger;
#include maps\mp\zombies\_zm;
#include maps\mp\gametypes_zm\_spawning;
#include maps\mp\zombies\_load;
#include maps\mp\zombies\_zm_clone;
#include maps\mp\zombies\_zm_ai_basic;
#include maps\mp\animscripts\shared;
#include maps\mp\zombies\_zm_audio;
#include maps\mp\zombies\_zm_zonemgr;
#include maps\mp\zm_alcatraz_travel;
#include maps\mp\gametypes_zm\_zm_gametype;
#include maps\mp\zombies\_zm_equipment;

#include maps\mp\zombies\_zm_perks;
#include maps\mp\_visionset_mgr;
#include maps\mp\zombies\_zm_laststand;
#include maps\mp\gametypes_zm\_hud;
#include maps\mp\zombies\_zm_powerups;
#include maps\mp\zombies\_zm_magicbox;

//MYOWN ABOVE


#include maps\mp\zm_alcatraz_grief_cellblock;
#include maps\mp\zm_alcatraz_weap_quest;
#include maps\mp\zombies\_zm_weap_tomahawk;
#include maps\mp\zombies\_zm_weap_blundersplat;
#include maps\mp\zombies\_zm_magicbox_prison;
#include maps\mp\zm_prison_ffotd;
#include maps\mp\zm_prison_fx;
#include maps\mp\zm_alcatraz_gamemodes;

#include maps\mp\zombies\_zm_stats;
#include maps\mp\gametypes_zm\_spawnlogic;
#include maps\mp\animscripts\traverse\shared;
#include maps\mp\animscripts\utility;

#include maps\mp\_createfx;
#include maps\mp\_music;
#include maps\mp\_busing;
#include maps\mp\_script_gen;
#include maps\mp\gametypes_zm\_globallogic_audio;
#include maps\mp\gametypes_zm\_tweakables;
#include maps\mp\_challenges;
#include maps\mp\gametypes_zm\_weapons;
#include maps\mp\_demo;
#include maps\mp\gametypes_zm\_globallogic_utils;
#include maps\mp\gametypes_zm\_spectating;
#include maps\mp\gametypes_zm\_globallogic_spawn;
#include maps\mp\gametypes_zm\_globallogic_ui;
#include maps\mp\gametypes_zm\_hostmigration;
#include maps\mp\gametypes_zm\_globallogic_score;
#include maps\mp\gametypes_zm\_globallogic;

#include maps\mp\zombies\_zm_ai_faller;
#include maps\mp\zombies\_zm_spawner;
#include maps\mp\zombies\_zm_pers_upgrades_functions;
#include maps\mp\zombies\_zm_pers_upgrades;
#include maps\mp\zombies\_zm_score;

#include maps\mp\animscripts\zm_run;
#include maps\mp\animscripts\zm_death;
#include maps\mp\zombies\_zm_blockers;
#include maps\p\animscripts\zm_shared;
#include maps\mp\animscripts\zm_utility;

#include maps\mp\zombies\_zm_power;
#include maps\mp\zombies\_zm_server_throttle;

#include maps\mp\zombies\_zm_melee_weapon;
#include maps\mp\zombies\_zm_audio_announcer;

#include maps\mp\zombies\_zm_ai_dogs;
#include codescripts\character;
#include maps\mp\zombies\_zm_buildables;
#include maps\mp\zombies\_zm_game_module;
#include maps\mp\zm_transit_buildables;
#include maps\mp\zm_transit;
#include maps\mp\zombies\_zm_magicbox_lock;
#include maps\mp\zombies\_zm_afterlife;
#include maps\mp\zombies\_zm_ai_brutus;
#include maps\mp\zm_alcatraz_craftables;
#include maps\mp\zombies\_zm_craftables;
#include maps\mp\zm_alcatraz_utility;

#include maps\mp\zm_alcatraz_traps;
#include maps\mp\zm_prison;
#include maps\mp\zm_alcatraz_sq;
#include maps\mp\zm_prison_sq_bg;
#include maps\mp\zm_prison_spoon;
#include maps\mp\zm_prison_achievement;


/*=====================================================================================================================================================================*/

#include maps\mp\zm_nuked_perks;

#include maps\mp\zombies\_zm_game_module;
#include maps\mp\animscripts\zm_death;
#include maps\mp\zombies\_zm_perks;
#include maps\mp\zombies\_zm_weapons;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\_utility;
#include common_scripts\utility;

#include maps\mp\zombies\_zm_ffotd;
#include maps\mp\zombies\_zm_utility;
#include common_scripts\utility;
#include maps\mp\_utility;

#include maps\mp\zm_nuked;



init()
{
    //do all callbacks after perk heaven working ( leveel specific ones, with new system only the rocket call backstep )
    level thread do_storytelling_after_unlocking_heaven();
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

do_storytelling_after_unlocking_heaven()
{
    level endon( "end_game" );

    flag_wait( "initial_blackscreen_passed" );
    
    level waittill( "teleport_has_been_accessed" );
    wait 0.4;
    playsoundatposition( "zmb_meteor_activate", ( 0, 0, 0 ) );
    level thread sq_talk_5_melee_reminder(); //melee bunker talk


    level waittill( "bunker_melee_talk_done" );
    level thread wait_for_radio_signals(); //interrupt radio signals
    wait .1;
    
    level waittill( "bunker_melee" ); 
    level thread sq_talk_6_interrupt_signals();

    wait .1;
    level waittill( "ted_say_aargh" );
    level thread sq_talk_7_ted_off();

    wait .1;
    level waittill( "callitquits" );
    level thread sq_talk_8_ted_on();
    wait .1;

    level waittill( "sq_talk_8_pt2" );
    wait 2;
    level thread sq_talk_8_ted_on2();

    wait .1;
    level waittill( "tell_about_traps" );
    wait 3;
    level thread sq_talk_9_traps_enabled();
    
    wait .1;
    level waittill( "grenade_step_done" );
    level thread sq_talk_10_collected_nades();

    wait .1;
    level waittill( "bomb_aquired" );
    level thread sq_talk_11_space_bomb();
    
    wait .1;
    level waittill( "galvas_unlocked" );
    level thread sq_talk_12_knife_elec();
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

wait_for_radio_signals()
{
    level endon( "end_game" );
    
    wait 0.1;
    knife_location = ( -1338.97, 990.55, -62.675 );
    touch_trig = spawn( "trigger_radius", knife_location, 1, 70, 70 );
    touch_trig setcursorhint( "HINT_NOICON" );
    wait 1;
    while ( true )
    {
        wait 0.1;
        for( i = 0; i < level.players.size; i++ )
        {
            
            if ( level.players[ i ] istouching( touch_trig ) && level.players[ i ] meleeButtonPressed() )
            {
                level notify( "beep_talker" );
                level notify( "bunker_melee" );
                touch_trig delete();
                wait 0.5;
                break;
            }

        }
    }
}

sq_talk_5_melee_reminder()
{
    
    level endon( "end_game" );

    level.talk_melee_reminder = [];
    level.shades_melee_reminder = [];
    r_width = 40;
    r_height = 40;

    width = 310;
    height = 16;
    x = 1.8;
    r = 1.6;
    x = 0;
    level.talker_melee_reminder = newHudElem();
    level.talker_melee_reminder.x = 10;
    level.talker_melee_reminder.y = 0;
    level.talker_melee_reminder.alignx = "left";
    level.talker_melee_reminder.aligny = "top";
    level.talker_melee_reminder.horzalign = "user_left";
    level.talker_melee_reminder.vertalign = "user_top";
    level.talker_melee_reminder.alpha = 0;
    level.talker_melee_reminder.foreground = true;
    level.talker_melee_reminder.hidewheninmenu = true;
    level.talker_melee_reminder setshader( "zombies_rank_3_ded", r_width, r_height );
    level.talker_melee_reminder.y = 26;
    level.talker_melee_reminder thread sq_talk_skull_icon_blinker();
    s = 0;

    level.cyto_melee_reminder = newHudElem();
    level.cyto_melee_reminder.x = 21;
    level.cyto_melee_reminder.y = 0;
    level.cyto_melee_reminder.alignx = "left";
    level.cyto_melee_reminder.aligny = "top";
    level.cyto_melee_reminder.horzalign = "user_left";
    level.cyto_melee_reminder.vertalign = "user_top";
    level.cyto_melee_reminder.alpha = 0;
    level.cyto_melee_reminder.foreground = true;
    level.cyto_melee_reminder.hidewheninmenu = true;
    level.cyto_melee_reminder.fontscale = 1;
    level.cyto_melee_reminder settext( "T^2.^2E^7.^7D^2.^2D" );
    level.cyto_melee_reminder.y = 67.5;

    for( x = 0; x < 6; x++ )
    {
        level.shades_melee_reminder[ x ] = newHudElem();
        level.shades_melee_reminder[ x ].x = 45;
        level.shades_melee_reminder[ x ].y = 0;
        level.shades_melee_reminder[ x ].alignx = "left";
        level.shades_melee_reminder[ x ].aligny = "top";
        level.shades_melee_reminder[ x ].horzalign = "user_left";
        level.shades_melee_reminder[ x ].vertalign = "user_top";
        level.shades_melee_reminder[ x ].alpha = 0;
        level.shades_melee_reminder[ x ].color = ( 0.67, 0, 0.01 );
        level.shades_melee_reminder[ x ].inuse = false;
        level.shades_melee_reminder[ x ].hidewheninmenu = true;
        level.shades_melee_reminder[ x ] setshader( "scorebar_zom_1", width, height );
        wait 0.05;
       
    }

    level.shades_melee_reminder[ 0 ].y = 18;
    level.shades_melee_reminder[ 1 ].y = 28;
    level.shades_melee_reminder[ 2 ].y = 38;
    level.shades_melee_reminder[ 3 ].y = 48;
    level.shades_melee_reminder[ 4 ].y = 58;
    level.shades_melee_reminder[ 5 ].y = 68;

    for ( f = 0; f < 4; f++ )
    {
        level.talk_melee_reminder[ f ] = newHudElem();
        level.talk_melee_reminder[ f ].x = 60;
        level.talk_melee_reminder[ f ].y = 0;
        level.talk_melee_reminder[ f ].alignx = "left";
        level.talk_melee_reminder[ f ].aligny = "top";
        level.talk_melee_reminder[ f ].horzalign = "user_left";
        level.talk_melee_reminder[ f ].vertalign = "user_top";
        level.talk_melee_reminder[ f ].foreground = true;
        level.talk_melee_reminder[ f ].alpha = 0;
        level.talk_melee_reminder[ f ].color = ( 1, 1, 1 );
        level.talk_melee_reminder[ f ].inuse = false;
        level.talk_melee_reminder[ f ].hidewheninmenu = true;
        level.talk_melee_reminder[ f ].font = "default";
    }

    level.talk_melee_reminder[ 0 ].y = 20;
    level.talk_melee_reminder[ 1 ].y = 35;
    level.talk_melee_reminder[ 2 ].y = 50;
    level.talk_melee_reminder[ 3 ].y = 65;

    level.talk_melee_reminder[ 0 ].fontscale = 1.25;
    level.talk_melee_reminder[ 1 ].fontscale = 1.25;
    level.talk_melee_reminder[ 2 ].fontscale = 1.25;
    level.talk_melee_reminder[ 3 ].fontscale = 1.25;
    

    level.talk_melee_reminder[ 0 ] settext( "I suppose that I ^3forgot^7 to tell you something.." );
    level.talk_melee_reminder[ 1 ] settext( "..come and ^3stop by^7 at the ^3bunker^7 when you're not ^3busy^7." );
    level.talk_melee_reminder[ 2 ] settext( "^3Knock^7 on the ^3door^7 should wake me up from beauty ^3sleep^7." );
    level.talk_melee_reminder[ 3 ] settext( "^3What?^7 I need sleep too!" );

    level.talk_melee_reminder[ 0 ].alpha = 0;
    level.talk_melee_reminder[ 1 ].alpha = 0;
    level.talk_melee_reminder[ 2 ].alpha = 0;
    level.talk_melee_reminder[ 3 ].alpha = 0;
    tulli = false;
    f = 2;
    for ( s = 0; s < level.shades_melee_reminder.size; s++ )
    {
        level.shades_melee_reminder[ s ].alpha = 0;
        level.shades_melee_reminder[ s ] fadeovertime( f );
        level.shades_melee_reminder[ s ].alpha = 1;
        wait randomfloatrange( 0.14, 0.3 );
        if( !tulli )
        {
            level notify( "beep_talker" );
            playsoundatposition( "zmb_clock_chime", ( 0, 0, 0 ) );
            tulli = true;
        }
        f -= 0.25;
    }
    level.cyto_melee_reminder.alpha = 0;
    level.cyto_melee_reminder fadeovertime( 4 );
    level.cyto_melee_reminder.alpha = 1;

    wait 0.1;

    //display a flashing loop fx at first
    f = 2;
    for( i = 0; i < level.talk_melee_reminder.size; i++ )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.talk_melee_reminder[ i ].alpha = 0;
        level.talk_melee_reminder[ i ] fadeovertime( v );
        level.talk_melee_reminder[ i ].alpha = 1;
        wait 0.08;
    }

    for( i = level.talk_melee_reminder.size; i > 0; i-- )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.talk_melee_reminder[ i ].alpha = 1;
        level.talk_melee_reminder[ i ] fadeovertime( v );
        level.talk_melee_reminder[ i ].alpha = 0;
        wait 0.08;        
    }
    wait 0.1;

    //display the text for a x duration
    for( i = 0; i < level.talk_melee_reminder.size; i++ )
    {
        v = randomfloatrange( 0.4, 0.9 );
        level.talk_melee_reminder[ i ].alpha = 0;
        level.talk_melee_reminder[ i ] fadeovertime( v );
        level.talk_melee_reminder[ i ].alpha = 1;
        wait 0.08;  
    }
    wait 1;

    for ( s = 0; s < level.talk_melee_reminder.size; s++ )
    {
        level.talk_melee_reminder[ s ] thread sq_talk_turn_colors();
        wait randomfloatrange( 0.4, 0.9 );
    }
    wait 8.5;

    level.talk_melee_reminder = array_randomize( level.talk_melee_reminder );


    level.talker_melee_reminder.alpha = 1;
    level.talker_melee_reminder fadeovertime( 3.5 );
    level.talker_melee_reminder.alpha = 0;

    level.cyto_melee_reminder.alpha = 1;
    level.cyto_melee_reminder fadeovertime( 3.5 );
    level.cyto_melee_reminder.alpha = 0;
    wait .1;

    x = 2.5;
    for ( u = 0; u < level.shades_melee_reminder.size; u++ )
    {
        s = randomfloatrange( 0.3, 0.6 );
        level.shades_melee_reminder[ u ].alpha = 1;
        level.shades_melee_reminder[ u ] fadeovertime( x );
        level.shades_melee_reminder[ u ].alpha = 0;
        x -= 0.35;
        wait s;
    }
    x = 2.5;
    for( i = 0; i < level.talk_melee_reminder.size; i++ )
    {
        level.talk_melee_reminder[ i ].alpha = 1;
        level.talk_melee_reminder[ i ] fadeovertime( x );
        level.talk_melee_reminder[ i ].alpha = 0;
        x -= 0.35;
    }

    wait 3;
    level notify( "bunker_melee_talk_done" );
    level.talker_melee_reminder destroy_hud();
    level.cyto_melee_reminder destroy_hud();

    for ( i = 0; i < level.talk_melee_reminder.size; i++ )
    {
        level.talk_melee_reminder[ i ] destroy_hud();
    }

    for( i = 0; i < level.shades_melee_reminder.size; i++ )
    {
        level.shades_melee_reminder[ i ] destroy_hud();
    }
    level.talker_melee_reminder delete();
    level.cyto_melee_reminder delete();
    level.talk_melee_reminder delete();
    level.shades_melee_reminder delete();
}
sq_talk_6_interrupt_signals()
{
    
    level endon( "end_game" );

    level.talk_interrupt_signals = [];
    level.shades_interrupt_signals = [];
    r_width = 40;
    r_height = 40;

    width = 310;
    height = 16;
    x = 1.8;
    r = 1.6;
    x = 0;
    level.talker_interrupt_signals = newHudElem();
    level.talker_interrupt_signals.x = 10;
    level.talker_interrupt_signals.y = 0;
    level.talker_interrupt_signals.alignx = "left";
    level.talker_interrupt_signals.aligny = "top";
    level.talker_interrupt_signals.horzalign = "user_left";
    level.talker_interrupt_signals.vertalign = "user_top";
    level.talker_interrupt_signals.alpha = 0;
    level.talker_interrupt_signals.foreground = true;
    level.talker_interrupt_signals.hidewheninmenu = true;
    level.talker_interrupt_signals setshader( "zombies_rank_3_ded", r_width, r_height );
    level.talker_interrupt_signals.y = 26;
    level.talker_interrupt_signals thread sq_talk_skull_icon_blinker();
    s = 0;

    level.cyto_interrupt_signals = newHudElem();
    level.cyto_interrupt_signals.x = 21;
    level.cyto_interrupt_signals.y = 0;
    level.cyto_interrupt_signals.alignx = "left";
    level.cyto_interrupt_signals.aligny = "top";
    level.cyto_interrupt_signals.horzalign = "user_left";
    level.cyto_interrupt_signals.vertalign = "user_top";
    level.cyto_interrupt_signals.alpha = 0;
    level.cyto_interrupt_signals.foreground = true;
    level.cyto_interrupt_signals.hidewheninmenu = true;
    level.cyto_interrupt_signals.fontscale = 1;
    level.cyto_interrupt_signals settext( "T^2.^2E^7.^7D^2.^2D" );
    level.cyto_interrupt_signals.y = 67.5;

    for( x = 0; x < 6; x++ )
    {
        level.shades_interrupt_signals[ x ] = newHudElem();
        level.shades_interrupt_signals[ x ].x = 45;
        level.shades_interrupt_signals[ x ].y = 0;
        level.shades_interrupt_signals[ x ].alignx = "left";
        level.shades_interrupt_signals[ x ].aligny = "top";
        level.shades_interrupt_signals[ x ].horzalign = "user_left";
        level.shades_interrupt_signals[ x ].vertalign = "user_top";
        level.shades_interrupt_signals[ x ].alpha = 0;
        level.shades_interrupt_signals[ x ].color = ( 0.67, 0, 0.01 );
        level.shades_interrupt_signals[ x ].inuse = false;
        level.shades_interrupt_signals[ x ].hidewheninmenu = true;
        level.shades_interrupt_signals[ x ] setshader( "scorebar_zom_1", width, height );
        wait 0.05;
       
    }

    level.shades_interrupt_signals[ 0 ].y = 18;
    level.shades_interrupt_signals[ 1 ].y = 28;
    level.shades_interrupt_signals[ 2 ].y = 38;
    level.shades_interrupt_signals[ 3 ].y = 48;
    level.shades_interrupt_signals[ 4 ].y = 58;
    level.shades_interrupt_signals[ 5 ].y = 68;

    for ( f = 0; f < 4; f++ )
    {
        level.talk_interrupt_signals[ f ] = newHudElem();
        level.talk_interrupt_signals[ f ].x = 60;
        level.talk_interrupt_signals[ f ].y = 0;
        level.talk_interrupt_signals[ f ].alignx = "left";
        level.talk_interrupt_signals[ f ].aligny = "top";
        level.talk_interrupt_signals[ f ].horzalign = "user_left";
        level.talk_interrupt_signals[ f ].vertalign = "user_top";
        level.talk_interrupt_signals[ f ].foreground = true;
        level.talk_interrupt_signals[ f ].alpha = 0;
        level.talk_interrupt_signals[ f ].color = ( 1, 1, 1 );
        level.talk_interrupt_signals[ f ].inuse = false;
        level.talk_interrupt_signals[ f ].hidewheninmenu = true;
        level.talk_interrupt_signals[ f ].font = "default";
    }

    level.talk_interrupt_signals[ 0 ].y = 20;
    level.talk_interrupt_signals[ 1 ].y = 35;
    level.talk_interrupt_signals[ 2 ].y = 50;
    level.talk_interrupt_signals[ 3 ].y = 65;

    level.talk_interrupt_signals[ 0 ].fontscale = 1.25;
    level.talk_interrupt_signals[ 1 ].fontscale = 1.25;
    level.talk_interrupt_signals[ 2 ].fontscale = 1.25;
    level.talk_interrupt_signals[ 3 ].fontscale = 1.25;
    

    level.talk_interrupt_signals[ 0 ] settext( "Ah so are you ^3ready^7 to move forward with ^3our plan^7?" );
    level.talk_interrupt_signals[ 1 ] settext( "We could ^3eavesdrop^7 on Griffin Station and see what they are ^3REALLY^7 up to." );
    level.talk_interrupt_signals[ 2 ] settext( "See if you can get a ^3signal^7 thru the ^3television^7." );
    level.talk_interrupt_signals[ 3 ] settext( "Listenable ^3frequency^7 should be ^3@ 847.01^3" );
    
    level.talk_interrupt_signals[ 0 ].alpha = 0;
    level.talk_interrupt_signals[ 1 ].alpha = 0;
    level.talk_interrupt_signals[ 2 ].alpha = 0;
    level.talk_interrupt_signals[ 3 ].alpha = 0;

    f = 2;
    ss = false;
    for ( s = 0; s < level.shades_interrupt_signals.size; s++ )
    {
        level.shades_interrupt_signals[ s ].alpha = 0;
        level.shades_interrupt_signals[ s ] fadeovertime( f );
        level.shades_interrupt_signals[ s ].alpha = 1;
        wait randomfloatrange( 0.14, 0.3 );
        if( !ss  )
        {
            level notify( "beep_talker" );
            playsoundatposition( "zmb_meteor_activate", ( 0, 0, 0 ) );
            ss = true;
        }
        f -= 0.25;
    }
    level.cyto_interrupt_signals.alpha = 0;
    level.cyto_interrupt_signals fadeovertime( 4 );
    level.cyto_interrupt_signals.alpha = 1;

    wait 0.1;

    //display a flashing loop fx at first
    f = 2;
    for( i = 0; i < level.talk_interrupt_signals.size; i++ )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.talk_interrupt_signals[ i ].alpha = 0;
        level.talk_interrupt_signals[ i ] fadeovertime( v );
        level.talk_interrupt_signals[ i ].alpha = 1;
        wait 0.08;
    }

    for( i = level.talk_interrupt_signals.size; i > 0; i-- )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.talk_interrupt_signals[ i ].alpha = 1;
        level.talk_interrupt_signals[ i ] fadeovertime( v );
        level.talk_interrupt_signals[ i ].alpha = 0;
        wait 0.08;        
    }
    wait 0.1;

    //display the text for a x duration
    for( i = 0; i < level.talk_interrupt_signals.size; i++ )
    {
        v = randomfloatrange( 0.4, 0.9 );
        level.talk_interrupt_signals[ i ].alpha = 0;
        level.talk_interrupt_signals[ i ] fadeovertime( v );
        level.talk_interrupt_signals[ i ].alpha = 1;
        wait 0.08;  
    }
    wait 1;

    for ( s = 0; s < level.talk_interrupt_signals.size; s++ )
    {
        level.talk_interrupt_signals[ s ] thread sq_talk_turn_colors();
        wait randomfloatrange( 0.4, 0.9 );
    }
    wait 8.5;

    level.talk_interrupt_signals = array_randomize( level.talk_interrupt_signals );


    level.talker_interrupt_signals.alpha = 1;
    level.talker_interrupt_signals fadeovertime( 3.5 );
    level.talker_interrupt_signals.alpha = 0;

    level.cyto_interrupt_signals.alpha = 1;
    level.cyto_interrupt_signals fadeovertime( 3.5 );
    level.cyto_interrupt_signals.alpha = 0;
    wait .1;

    x = 2.5;
    for ( u = 0; u < level.shades_interrupt_signals.size; u++ )
    {
        s = randomfloatrange( 0.3, 0.6 );
        level.shades_interrupt_signals[ u ].alpha = 1;
        level.shades_interrupt_signals[ u ] fadeovertime( x );
        level.shades_interrupt_signals[ u ].alpha = 0;
        x -= 0.35;
        wait s;
    }
    x = 2.5;
    for( i = 0; i < level.talk_interrupt_signals.size; i++ )
    {
        level.talk_interrupt_signals[ i ].alpha = 1;
        level.talk_interrupt_signals[ i ] fadeovertime( x );
        level.talk_interrupt_signals[ i ].alpha = 0;
        x -= 0.35;
    }
    wait 3;

    level.talker_interrupt_signals destroy_hud();
    level.cyto_interrupt_signals destroy_hud();

    for ( i = 0; i < level.talk_interrupt_signals.size; i++ )
    {
        level.talk_interrupt_signals[ i ] destroy_hud();
    }

    for( i = 0; i < level.shades_interrupt_signals.size; i++ )
    {
        level.shades_interrupt_signals[ i ] destroy_hud();
    }

    level.talker_interrupt_signals delete();
    level.cyto_interrupt_signals delete();
    level.talk_interrupt_signals delete();
    level.shades_interrupt_signals delete();
}

sq_talk_7_ted_off()
{
    
    level endon( "end_game" );

    level.talk_off = [];
    level.shades_off = [];
    r_width = 40;
    r_height = 40;

    width = 310;
    height = 16;
    x = 1.8;
    r = 1.6;
    x = 0;
    level.talker_off = newHudElem();
    level.talker_off.x = 10;
    level.talker_off.y = 0;
    level.talker_off.alignx = "left";
    level.talker_off.aligny = "top";
    level.talker_off.horzalign = "user_left";
    level.talker_off.vertalign = "user_top";
    level.talker_off.alpha = 0;
    level.talker_off.foreground = true;
    level.talker_off.hidewheninmenu = true;
    level.talker_off setshader( "zombies_rank_3_ded", r_width, r_height );
    level.talker_off.y = 26;
    level.talker_off thread sq_talk_skull_icon_blinker();
    s = 0;

    level.cyto_off = newHudElem();
    level.cyto_off.x = 21;
    level.cyto_off.y = 0;
    level.cyto_off.alignx = "left";
    level.cyto_off.aligny = "top";
    level.cyto_off.horzalign = "user_left";
    level.cyto_off.vertalign = "user_top";
    level.cyto_off.alpha = 0;
    level.cyto_off.foreground = true;
    level.cyto_off.hidewheninmenu = true;
    level.cyto_off.fontscale = 1;
    level.cyto_off settext( "T^2.^2E^7.^7D^2.^2D" );
    level.cyto_off.y = 67.5;

    for( x = 0; x < 6; x++ )
    {
        level.shades_off[ x ] = newHudElem();
        level.shades_off[ x ].x = 45;
        level.shades_off[ x ].y = 0;
        level.shades_off[ x ].alignx = "left";
        level.shades_off[ x ].aligny = "top";
        level.shades_off[ x ].horzalign = "user_left";
        level.shades_off[ x ].vertalign = "user_top";
        level.shades_off[ x ].alpha = 0;
        level.shades_off[ x ].color = ( 0.67, 0, 0.01 );
        level.shades_off[ x ].inuse = false;
        level.shades_off[ x ].hidewheninmenu = true;
        level.shades_off[ x ] setshader( "scorebar_zom_1", width, height );
        wait 0.05;
       
    }

    level.shades_off[ 0 ].y = 18;
    level.shades_off[ 1 ].y = 28;
    level.shades_off[ 2 ].y = 38;
    level.shades_off[ 3 ].y = 48;
    level.shades_off[ 4 ].y = 58;
    level.shades_off[ 5 ].y = 68;

    for ( f = 0; f < 4; f++ )
    {
        level.talk_off[ f ] = newHudElem();
        level.talk_off[ f ].x = 60;
        level.talk_off[ f ].y = 0;
        level.talk_off[ f ].alignx = "left";
        level.talk_off[ f ].aligny = "top";
        level.talk_off[ f ].horzalign = "user_left";
        level.talk_off[ f ].vertalign = "user_top";
        level.talk_off[ f ].foreground = true;
        level.talk_off[ f ].alpha = 0;
        level.talk_off[ f ].color = ( 1, 1, 1 );
        level.talk_off[ f ].inuse = false;
        level.talk_off[ f ].hidewheninmenu = true;
        level.talk_off[ f ].font = "default";
    }

    level.talk_off[ 0 ].y = 20;
    level.talk_off[ 1 ].y = 35;
    level.talk_off[ 2 ].y = 50;
    level.talk_off[ 3 ].y = 65;

    level.talk_off[ 0 ].fontscale = 1.25;
    level.talk_off[ 1 ].fontscale = 1.25;
    level.talk_off[ 2 ].fontscale = 1.25;
    level.talk_off[ 3 ].fontscale = 1.25;
    

    level.talk_off[ 0 ] settext( "^3Oh no^7.. did you hear that?" );
    level.talk_off[ 1 ] settext( "It's another ^3attack^7 from ^3Griffin Station^7!" );
    level.talk_off[ 2 ] settext( "Brace fo.." );
    level.talk_off[ 3 ] settext( "^8<^7 ---SIGNAL_LOST--- ^8>^7" );

    level.talk_off[ 0 ].alpha = 0;
    level.talk_off[ 1 ].alpha = 0;
    level.talk_off[ 2 ].alpha = 0;
    level.talk_off[ 3 ].alpha = 0;

    f = 2;
    act = false;

    for ( s = 0; s < level.shades_off.size; s++ )
    {
        level.shades_off[ s ].alpha = 0;
        level.shades_off[ s ] fadeovertime( f );
        level.shades_off[ s ].alpha = 1;
        wait randomfloatrange( 0.14, 0.3 );
        if( !act )
        {
            level notify( "beep_talker" );
            playsoundatposition( "zmb_meteor_activate", ( 0, 0, 0 ) );
            wait 0.1;
            playsoundatposition( "zmb_clock_chime", ( 0, 0, 0 ) );
            wait 0.05;
            act = true;
        }
        f -= 0.25;
    }
    level.cyto_off.alpha = 0;
    level.cyto_off fadeovertime( 4 );
    level.cyto_off.alpha = 1;

    wait 0.1;

    //display a flashing loop fx at first
    f = 2;
    for( i = 0; i < level.talk_off.size; i++ )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.talk_off[ i ].alpha = 0;
        level.talk_off[ i ] fadeovertime( v );
        level.talk_off[ i ].alpha = 1;
        wait 0.08;
    }

    for( i = level.talk_off.size; i > 0; i-- )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.talk_off[ i ].alpha = 1;
        level.talk_off[ i ] fadeovertime( v );
        level.talk_off[ i ].alpha = 0;
        wait 0.08;        
    }
    wait 0.1;

    //display the text for a x duration
    for( i = 0; i < level.talk_off.size; i++ )
    {
        v = randomfloatrange( 0.4, 0.9 );
        level.talk_off[ i ].alpha = 0;
        level.talk_off[ i ] fadeovertime( v );
        level.talk_off[ i ].alpha = 1;
        wait 0.08;  
    }
    wait 1;

    for ( s = 0; s < level.talk_off.size; s++ )
    {
        if ( s == 2)
        {
            level.talk_off[ s ] thread sq_talk_brace_for_impact();    
        }

        if ( s == 0 || s == 1  )
        {
            level.talk_off[ s ] thread sq_talk_turn_colors();
        }
        else if ( s == 3 )
        {
            level.talk_off[ s ] thread sq_talk_blink();
        }
        wait randomfloatrange( 0.4, 0.9 );
    }
    wait 8.5;

    level.talk_off = array_randomize( level.talk_off );


    level.talker_off.alpha = 1;
    level.talker_off fadeovertime( 3.5 );
    level.talker_off.alpha = 0;

    level.cyto_off.alpha = 1;
    level.cyto_off fadeovertime( 3.5 );
    level.cyto_off.alpha = 0;
    wait .1;

    x = 2.5;
    for ( u = 0; u < level.shades_off.size; u++ )
    {
        s = randomfloatrange( 0.3, 0.6 );
        level.shades_off[ u ].alpha = 1;
        level.shades_off[ u ] fadeovertime( x );
        level.shades_off[ u ].alpha = 0;
        x -= 0.35;
        wait s;
    }
    x = 2.5;
    for( i = 0; i < level.talk_off.size; i++ )
    {
        level.talk_off[ i ].alpha = 1;
        level.talk_off[ i ] fadeovertime( x );
        level.talk_off[ i ].alpha = 0;
        x -= 0.35;
    }

    wait 3;

    level.talker_off destroy_hud();
    level.cyto_off destroy_hud();

    for ( i = 0; i < level.talk_off.size; i++ )
    {
        level.talk_off[ i ] destroy_hud();
    }

    for( i = 0; i < level.shades_off.size; i++ )
    {
        level.shades_off[ i ] destroy_hud();
    }

    level.talker_off delete();
    level.cyto_off delete();
    level.talk_off delete();
    level.shades_off delete();
}

sq_talk_8_ted_on()
{
    
    level endon( "end_game" );

    level.talk_ted_on = [];
    level.shades_ted_on = [];
    r_width = 40;
    r_height = 40;

    width = 310;
    height = 16;
    x = 1.8;
    r = 1.6;
    x = 0;
    level.talker_ted_on = newHudElem();
    level.talker_ted_on.x = 10;
    level.talker_ted_on.y = 0;
    level.talker_ted_on.alignx = "left";
    level.talker_ted_on.aligny = "top";
    level.talker_ted_on.horzalign = "user_left";
    level.talker_ted_on.vertalign = "user_top";
    level.talker_ted_on.alpha = 0;
    level.talker_ted_on.foreground = true;
    level.talker_ted_on.hidewheninmenu = true;
    level.talker_ted_on setshader( "zombies_rank_3_ded", r_width, r_height );
    level.talker_ted_on.y = 26;
    level.talker_ted_on thread sq_talk_skull_icon_blinker();
    s = 0;

    level.cyto_ted_on = newHudElem();
    level.cyto_ted_on.x = 21;
    level.cyto_ted_on.y = 0;
    level.cyto_ted_on.alignx = "left";
    level.cyto_ted_on.aligny = "top";
    level.cyto_ted_on.horzalign = "user_left";
    level.cyto_ted_on.vertalign = "user_top";
    level.cyto_ted_on.alpha = 0;
    level.cyto_ted_on.foreground = true;
    level.cyto_ted_on.hidewheninmenu = true;
    level.cyto_ted_on.fontscale = 1;
    level.cyto_ted_on settext( "T^2.^2E^7.^7D^2.^2D" );
    level.cyto_ted_on.y = 67.5;

    for( x = 0; x < 6; x++ )
    {
        level.shades_ted_on[ x ] = newHudElem();
        level.shades_ted_on[ x ].x = 45;
        level.shades_ted_on[ x ].y = 0;
        level.shades_ted_on[ x ].alignx = "left";
        level.shades_ted_on[ x ].aligny = "top";
        level.shades_ted_on[ x ].horzalign = "user_left";
        level.shades_ted_on[ x ].vertalign = "user_top";
        level.shades_ted_on[ x ].alpha = 0;
        level.shades_ted_on[ x ].color = ( 0.67, 0, 0.01 );
        level.shades_ted_on[ x ].inuse = false;
        level.shades_ted_on[ x ].hidewheninmenu = true;
        level.shades_ted_on[ x ] setshader( "scorebar_zom_1", width, height );
        wait 0.05;
       
    }

    level.shades_ted_on[ 0 ].y = 18;
    level.shades_ted_on[ 1 ].y = 28;
    level.shades_ted_on[ 2 ].y = 38;
    level.shades_ted_on[ 3 ].y = 48;
    level.shades_ted_on[ 4 ].y = 58;
    level.shades_ted_on[ 5 ].y = 68;

    for ( f = 0; f < 4; f++ )
    {
        level.talk_ted_on[ f ] = newHudElem();
        level.talk_ted_on[ f ].x = 60;
        level.talk_ted_on[ f ].y = 0;
        level.talk_ted_on[ f ].alignx = "left";
        level.talk_ted_on[ f ].aligny = "top";
        level.talk_ted_on[ f ].horzalign = "user_left";
        level.talk_ted_on[ f ].vertalign = "user_top";
        level.talk_ted_on[ f ].foreground = true;
        level.talk_ted_on[ f ].alpha = 0;
        level.talk_ted_on[ f ].color = ( 1, 1, 1 );
        level.talk_ted_on[ f ].inuse = false;
        level.talk_ted_on[ f ].hidewheninmenu = true;
        level.talk_ted_on[ f ].font = "default";
    }

    level.talk_ted_on[ 0 ].y = 20; 
    level.talk_ted_on[ 1 ].y = 35; 
    level.talk_ted_on[ 2 ].y = 50;
    level.talk_ted_on[ 3 ].y = 65; 

    level.talk_ted_on[ 0 ].fontscale = 1.25;
    level.talk_ted_on[ 1 ].fontscale = 1.25;
    level.talk_ted_on[ 2 ].fontscale = 1.25;
    level.talk_ted_on[ 3 ].fontscale = 1.25;
    

    level.talk_ted_on[ 0 ] settext( "Well ^3hello^7 again! Glad to see you are ^3still breathing^7." );
    level.talk_ted_on[ 1 ] settext( "^3Thanks^7 for getting the ^3power^7 back on." );
    level.talk_ted_on[ 2 ] settext( "^3Otherwise^7 we wouldn't be able to continue our ^3revenge plan^7!" );
    level.talk_ted_on[ 3 ] settext( "..Shit! Give me a ^3second^7..." );

    level.talk_ted_on[ 0 ].alpha = 0;
    level.talk_ted_on[ 1 ].alpha = 0;
    level.talk_ted_on[ 2 ].alpha = 0;
    level.talk_ted_on[ 3 ].alpha = 0;

    f = 2;
    powerss = false;
    for ( s = 0; s < level.shades_ted_on.size; s++ )
    {
        level.shades_ted_on[ s ].alpha = 0;
        level.shades_ted_on[ s ] fadeovertime( f );
        level.shades_ted_on[ s ].alpha = 1;
        wait randomfloatrange( 0.14, 0.3 );
        if ( !powerss )
        {
            playsoundatposition( "zmb_meteor_activate", ( 0, 0, 0 ) );
            wait 0.3;
            playsoundatposition( "zmb_box_poof", ( 0, 0, 0 ) );
            powerss = true;
        }
        f -= 0.25;
    }
    level.cyto_ted_on.alpha = 0;
    level.cyto_ted_on fadeovertime(2 );
    level.cyto_ted_on.alpha = 1;

    wait 0.1;

    //display a flashing loop fx at first
    f = 2;
    for( i = 0; i < level.talk_ted_on.size; i++ )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.talk_ted_on[ i ].alpha = 0;
        level.talk_ted_on[ i ] fadeovertime( v );
        level.talk_ted_on[ i ].alpha = 1;
        wait 0.08;
    }

    for( i = level.talk_ted_on.size; i > 0; i-- )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.talk_ted_on[ i ].alpha = 1;
        level.talk_ted_on[ i ] fadeovertime( v );
        level.talk_ted_on[ i ].alpha = 0;
        wait 0.08;        
    }
    wait 0.1;

    //display the text for a x duration
    for( i = 0; i < level.talk_ted_on.size; i++ )
    {
        v = randomfloatrange( 0.4, 0.9 );
        level.talk_ted_on[ i ].alpha = 0;
        level.talk_ted_on[ i ] fadeovertime( v );
        level.talk_ted_on[ i ].alpha = 1;
        wait 0.08;  
    }

    wait 1;
    for ( s = 0; s < level.talk_ted_on.size; s++ )
    {
        
        level.talk_ted_on[ s ] thread sq_talk_turn_colors();
        
        wait randomfloatrange( 0.4, 0.9 );
    }
    wait 8.5;

    level.talk_ted_on = array_randomize( level.talk_ted_on );


    level.talker_ted_on.alpha = 1;
    level.talker_ted_on fadeovertime( 3.5 );
    level.talker_ted_on.alpha = 0;

    level.cyto_ted_on.alpha = 1;
    level.cyto_ted_on fadeovertime( 3.5 );
    level.cyto_ted_on.alpha = 0;
    wait .1;

    x = 2.5;
    for ( u = 0; u < level.shades_ted_on.size; u++ )
    {
        s = randomfloatrange( 0.3, 0.6 );
        level.shades_ted_on[ u ].alpha = 1;
        level.shades_ted_on[ u ] fadeovertime( x );
        level.shades_ted_on[ u ].alpha = 0;
        x -= 0.35;
        wait s;
    }
    x = 2.5;
    for( i = 0; i < level.talk_ted_on.size; i++ )
    {
        level.talk_ted_on[ i ].alpha = 1;
        level.talk_ted_on[ i ] fadeovertime( x );
        level.talk_ted_on[ i ].alpha = 0;
        x -= 0.35;
    }
    wait 0.1;
    level notify( "sq_talk_8_pt2" );
    wait 3;

    level.talker_ted_on destroy_hud();
    level.cyto_ted_on destroy_hud();

    for ( i = 0; i < level.talk_ted_on.size; i++ )
    {
        level.talk_ted_on[ i ] destroy_hud();
    }

    for( i = 0; i < level.shades_ted_on.size; i++ )
    {
        level.shades_ted_on[ i ] destroy_hud();
    }

    level.talker_ted_on delete();
    level.cyto_ted_on delete();
    level.talk_ted_on delete();
    level.shades_ted_on delete();
}
sq_talk_8_ted_on2()
{
    
    level endon( "end_game" );

    level.talk_ted_on2 = [];
    level.shades_ted_on2 = [];
    r_width = 40;
    r_height = 40;

    width = 310;
    height = 16;
    x = 1.8;
    r = 1.6;
    x = 0;
    level.talker_ted_on2 = newHudElem();
    level.talker_ted_on2.x = 10;
    level.talker_ted_on2.y = 0;
    level.talker_ted_on2.alignx = "left";
    level.talker_ted_on2.aligny = "top";
    level.talker_ted_on2.horzalign = "user_left";
    level.talker_ted_on2.vertalign = "user_top";
    level.talker_ted_on2.alpha = 0;
    level.talker_ted_on2.foreground = true;
    level.talker_ted_on2.hidewheninmenu = true;
    level.talker_ted_on2 setshader( "zombies_rank_3_ded", r_width, r_height );
    level.talker_ted_on2.y = 26;
    level.talker_ted_on2 thread sq_talk_skull_icon_blinker();
    s = 0;

    level.cyto_ted_on2 = newHudElem();
    level.cyto_ted_on2.x = 21;
    level.cyto_ted_on2.y = 0;
    level.cyto_ted_on2.alignx = "left";
    level.cyto_ted_on2.aligny = "top";
    level.cyto_ted_on2.horzalign = "user_left";
    level.cyto_ted_on2.vertalign = "user_top";
    level.cyto_ted_on2.alpha = 0;
    level.cyto_ted_on2.foreground = true;
    level.cyto_ted_on2.hidewheninmenu = true;
    level.cyto_ted_on2.fontscale = 1;
    level.cyto_ted_on2 settext( "T^2.^2E^7.^7D^2.^2D" );
    level.cyto_ted_on2.y = 67.5;

    for( x = 0; x < 6; x++ )
    {
        level.shades_ted_on2[ x ] = newHudElem();
        level.shades_ted_on2[ x ].x = 45;
        level.shades_ted_on2[ x ].y = 0;
        level.shades_ted_on2[ x ].alignx = "left";
        level.shades_ted_on2[ x ].aligny = "top";
        level.shades_ted_on2[ x ].horzalign = "user_left";
        level.shades_ted_on2[ x ].vertalign = "user_top";
        level.shades_ted_on2[ x ].alpha = 0;
        level.shades_ted_on2[ x ].color = ( 0.67, 0, 0.01 );
        level.shades_ted_on2[ x ].inuse = false;
        level.shades_ted_on2[ x ].hidewheninmenu = true;
        level.shades_ted_on2[ x ] setshader( "scorebar_zom_1", width, height );
        wait 0.05;
       
    }

    level.shades_ted_on2[ 0 ].y = 18;
    level.shades_ted_on2[ 1 ].y = 28;
    level.shades_ted_on2[ 2 ].y = 38;
    level.shades_ted_on2[ 3 ].y = 48;
    level.shades_ted_on2[ 4 ].y = 58;
    level.shades_ted_on2[ 5 ].y = 68;

    for ( f = 0; f < 4; f++ )
    {
        level.talk_ted_on2[ f ] = newHudElem();
        level.talk_ted_on2[ f ].x = 60;
        level.talk_ted_on2[ f ].y = 0;
        level.talk_ted_on2[ f ].alignx = "left";
        level.talk_ted_on2[ f ].aligny = "top";
        level.talk_ted_on2[ f ].horzalign = "user_left";
        level.talk_ted_on2[ f ].vertalign = "user_top";
        level.talk_ted_on2[ f ].foreground = true;
        level.talk_ted_on2[ f ].alpha = 0;
        level.talk_ted_on2[ f ].color = ( 1, 1, 1 );
        level.talk_ted_on2[ f ].inuse = false;
        level.talk_ted_on2[ f ].hidewheninmenu = true;
        level.talk_ted_on2[ f ].font = "default";
    }

    level.talk_ted_on2[ 0 ].y = 20;
    level.talk_ted_on2[ 1 ].y = 35;
    level.talk_ted_on2[ 2 ].y = 50;
    level.talk_ted_on2[ 3 ].y = 65;

    level.talk_ted_on2[ 0 ].fontscale = 1.25;
    level.talk_ted_on2[ 1 ].fontscale = 1.25;
    level.talk_ted_on2[ 2 ].fontscale = 1.25;
    level.talk_ted_on2[ 3 ].fontscale = 1.25;
    

    level.talk_ted_on2[ 0 ] settext( "..so ^3what^7 was I going to tell you before the signal got interrupted?" );
    level.talk_ted_on2[ 1 ] settext( "Oh yeah, I ^3noticed^7 that some ^3explosives^7 had spawned around the ^3map^7." );
    level.talk_ted_on2[ 2 ] settext( "If I ^3remember^7 correctly, you need to ^3nade^7 them in a correct ^3order^7." );
    level.talk_ted_on2[ 3 ] settext( "^3Destroy^7 the ^3explosive^7 cores!" );

    level.talk_ted_on2[ 0 ].alpha = 0;
    level.talk_ted_on2[ 1 ].alpha = 0;
    level.talk_ted_on2[ 2 ].alpha = 0;
    level.talk_ted_on2[ 3 ].alpha = 0;
    destrr = false;
    f = 2;
    for ( s = 0; s < level.shades_ted_on2.size; s++ )
    {
        level.shades_ted_on2[ s ].alpha = 0;
        level.shades_ted_on2[ s ] fadeovertime( f );
        level.shades_ted_on2[ s ].alpha = 1;
        wait randomfloatrange( 0.14, 0.3 );
        if ( !destrr )
        {
            level notify( "beep_talker" );
            playsoundatposition( "zmb_clock_chime", ( 0, 0, 0 ) );
            destrr = true;
        }
        f -= 0.25;
    }
    level.cyto_ted_on2.alpha = 0;
    level.cyto_ted_on2 fadeovertime( 4 );
    level.cyto_ted_on2.alpha = 1;

    wait 0.1;
    //f = 2;
    for( i = 0; i < level.talk_ted_on2.size; i++ )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.talk_ted_on2[ i ].alpha = 0;
        level.talk_ted_on2[ i ] fadeovertime( v );
        level.talk_ted_on2[ i ].alpha = 1;
        wait 0.08;
    }

    for( i = level.talk_ted_on2.size; i > 0; i-- )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.talk_ted_on2[ i ].alpha = 1;
        level.talk_ted_on2[ i ] fadeovertime( v );
        level.talk_ted_on2[ i ].alpha = 0;
        wait 0.08;        
    }
    wait 0.1;

    for( i = 0; i < level.talk_ted_on2.size; i++ )
    {
        v = randomfloatrange( 0.4, 0.9 );
        level.talk_ted_on2[ i ].alpha = 0;
        level.talk_ted_on2[ i ] fadeovertime( v );
        level.talk_ted_on2[ i ].alpha = 1;
        wait 0.08;  
    }
    wait 1;

    for ( s = 0; s < level.talk_ted_on2.size; s++ )
    {
        
        level.talk_ted_on2[ s ] thread sq_talk_turn_colors();
        
        wait randomfloatrange( 0.4, 0.9 );
    }
    wait 8.5;

    level.talk_ted_on2 = array_randomize( level.talk_ted_on2 );


    level.talker_ted_on2.alpha = 1;
    level.talker_ted_on2 fadeovertime( 3.5 );
    level.talker_ted_on2.alpha = 0;

    level.cyto_ted_on2.alpha = 1;
    level.cyto_ted_on2 fadeovertime( 3.5 );
    level.cyto_ted_on2.alpha = 0;
    wait .1;

    x = 2.5;
    for ( u = 0; u < level.shades_ted_on2.size; u++ )
    {
        s = randomfloatrange( 0.3, 0.6 );
        level.shades_ted_on2[ u ].alpha = 1;
        level.shades_ted_on2[ u ] fadeovertime( x );
        level.shades_ted_on2[ u ].alpha = 0;
        x -= 0.35;
        wait s;
    }
    x = 2.5;
    for( i = 0; i < level.talk_ted_on2.size; i++ )
    {
        level.talk_ted_on2[ i ].alpha = 1;
        level.talk_ted_on2[ i ] fadeovertime( x );
        level.talk_ted_on2[ i ].alpha = 0;
        x -= 0.35;
    }

    wait 3;
    level notify( "tell_about_traps" );
    level.talker_ted_on2 destroy_hud();
    level.cyto_ted_on2 destroy_hud();

    for ( i = 0; i < level.talk_ted_on2.size; i++ )
    {
        level.talk_ted_on2[ i ] destroy_hud();
    }

    for( i = 0; i < level.shades_ted_on2.size; i++ )
    {
        level.shades_ted_on2[ i ] destroy_hud();
    }

    level.talker_ted_on2 delete();
    level.cyto_ted_on2 delete();
    level.talk_ted_on2 delete();
    level.shades_ted_on2 delete();
}

sq_talk_9_traps_enabled()
{
    
    level endon( "end_game" );

    level.talk_traps = [];
    level.shades_traps = [];
    r_width = 40;
    r_height = 40;

    width = 310;
    height = 16;
    x = 1.8;
    r = 1.6;
    x = 0;
    level.talker_traps = newHudElem();
    level.talker_traps.x = 10;
    level.talker_traps.y = 0;
    level.talker_traps.alignx = "left";
    level.talker_traps.aligny = "top";
    level.talker_traps.horzalign = "user_left";
    level.talker_traps.vertalign = "user_top";
    level.talker_traps.alpha = 0;
    level.talker_traps.foreground = true;
    level.talker_traps.hidewheninmenu = true;
    level.talker_traps setshader( "zombies_rank_3_ded", r_width, r_height );
    level.talker_traps.y = 26;
    level.talker_traps thread sq_talk_skull_icon_blinker();
    s = 0;

    level.cyto_traps = newHudElem();
    level.cyto_traps.x = 21;
    level.cyto_traps.y = 0;
    level.cyto_traps.alignx = "left";
    level.cyto_traps.aligny = "top";
    level.cyto_traps.horzalign = "user_left";
    level.cyto_traps.vertalign = "user_top";
    level.cyto_traps.alpha = 0;
    level.cyto_traps.foreground = true;
    level.cyto_traps.hidewheninmenu = true;
    level.cyto_traps.fontscale = 1;
    level.cyto_traps settext( "T^2.^2E^7.^7D^2.^2D" );
    level.cyto_traps.y = 67.5;

    for( x = 0; x < 6; x++ )
    {
        level.shades_traps[ x ] = newHudElem();
        level.shades_traps[ x ].x = 45;
        level.shades_traps[ x ].y = 0;
        level.shades_traps[ x ].alignx = "left";
        level.shades_traps[ x ].aligny = "top";
        level.shades_traps[ x ].horzalign = "user_left";
        level.shades_traps[ x ].vertalign = "user_top";
        level.shades_traps[ x ].alpha = 0;
        level.shades_traps[ x ].color = ( 0.67, 0, 0.01 );
        level.shades_traps[ x ].inuse = false;
        level.shades_traps[ x ].hidewheninmenu = true;
        level.shades_traps[ x ] setshader( "scorebar_zom_1", width, height );
        wait 0.05;
       
    }

    level.shades_traps[ 0 ].y = 18;
    level.shades_traps[ 1 ].y = 28;
    level.shades_traps[ 2 ].y = 38;
    level.shades_traps[ 3 ].y = 48;
    level.shades_traps[ 4 ].y = 58;
    level.shades_traps[ 5 ].y = 68;

    for ( f = 0; f < 4; f++ )
    {
        level.talk_traps[ f ] = newHudElem();
        level.talk_traps[ f ].x = 60;
        level.talk_traps[ f ].y = 0;
        level.talk_traps[ f ].alignx = "left";
        level.talk_traps[ f ].aligny = "top";
        level.talk_traps[ f ].horzalign = "user_left";
        level.talk_traps[ f ].vertalign = "user_top";
        level.talk_traps[ f ].foreground = true;
        level.talk_traps[ f ].alpha = 0;
        level.talk_traps[ f ].color = ( 1, 1, 1 );
        level.talk_traps[ f ].inuse = false;
        level.talk_traps[ f ].hidewheninmenu = true;
        level.talk_traps[ f ].font = "default";
    }

    level.talk_traps[ 0 ].y = 20;
    level.talk_traps[ 1 ].y = 35;
    level.talk_traps[ 2 ].y = 50;
    level.talk_traps[ 3 ].y = 65;

    level.talk_traps[ 0 ].fontscale = 1.25;
    level.talk_traps[ 1 ].fontscale = 1.25;
    level.talk_traps[ 2 ].fontscale = 1.25;
    level.talk_traps[ 3 ].fontscale = 1.25;
    

    level.talk_traps[ 0 ] settext( "Oh I forgot to tell you about the traps that I fixed for you." );
    level.talk_traps[ 1 ] settext( "Traps called ^3Soul Seeker^7 & ^3Tesla Void^7 unlocked!" );
    level.talk_traps[ 2 ] settext( "Enjoy the ^3little^7 treat." );
    level.talk_traps[ 3 ] settext( "Now get back to ^3work^7!" );

    level.talk_traps[ 0 ].alpha = 0;
    level.talk_traps[ 1 ].alpha = 0;
    level.talk_traps[ 2 ].alpha = 0;
    level.talk_traps[ 3 ].alpha = 0;

    f = 2;
    oh = false;
    for ( s = 0; s < level.shades_traps.size; s++ )
    {
        level.shades_traps[ s ].alpha = 0;
        level.shades_traps[ s ] fadeovertime( f );
        level.shades_traps[ s ].alpha = 1;
        wait randomfloatrange( 0.14, 0.3 );
        if ( !oh )
        {
            level notify( "beep_talker" );
            playsoundatposition( "zmb_meteor_activate", ( 0, 0, 0 ) );
            oh = true;
        }
        f -= 0.25;
    }
    level.cyto_traps.alpha = 0;
    level.cyto_traps fadeovertime( 4 );
    level.cyto_traps.alpha = 1;

    wait 0.1;

    f = 2;
    for( i = 0; i < level.talk_traps.size; i++ )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.talk_traps[ i ].alpha = 0;
        level.talk_traps[ i ] fadeovertime( v );
        level.talk_traps[ i ].alpha = 1;
        wait 0.08;
    }

    for( i = level.talk_traps.size; i > 0; i-- )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.talk_traps[ i ].alpha = 1;
        level.talk_traps[ i ] fadeovertime( v );
        level.talk_traps[ i ].alpha = 0;
        wait 0.08;        
    }
    wait 0.1;

    for( i = 0; i < level.talk_traps.size; i++ )
    {
        v = randomfloatrange( 0.4, 0.9 );
        level.talk_traps[ i ].alpha = 0;
        level.talk_traps[ i ] fadeovertime( v );
        level.talk_traps[ i ].alpha = 1;
        wait 0.08;  
    }
    wait 1;

    for ( s = 0; s < level.talk_traps.size; s++ )
    {
        
        level.talk_traps[ s ] thread sq_talk_turn_colors();
        
        wait randomfloatrange( 0.4, 0.9 );
    }
    wait 8.5;

    level.talk_traps = array_randomize( level.talk_traps );


    level.talker_traps.alpha = 1;
    level.talker_traps fadeovertime( 3.5 );
    level.talker_traps.alpha = 0;

    level.cyto_traps.alpha = 1;
    level.cyto_traps fadeovertime( 3.5 );
    level.cyto_traps.alpha = 0;
    wait .1;

    x = 2.5;
    for ( u = 0; u < level.shades_traps.size; u++ )
    {
        s = randomfloatrange( 0.3, 0.6 );
        level.shades_traps[ u ].alpha = 1;
        level.shades_traps[ u ] fadeovertime( x );
        level.shades_traps[ u ].alpha = 0;
        x -= 0.35;
        wait s;
    }
    x = 2.5;
    for( i = 0; i < level.talk_traps.size; i++ )
    {
        level.talk_traps[ i ].alpha = 1;
        level.talk_traps[ i ] fadeovertime( x );
        level.talk_traps[ i ].alpha = 0;
        x -= 0.35;
    }
    wait 3;


    level.talker_traps destroy_hud();
    level.cyto_traps destroy_hud();

    for ( i = 0; i < level.talk_traps.size; i++ )
    {
        level.talk_traps[ i ] destroy_hud();
    }

    for( i = 0; i < level.shades_traps.size; i++ )
    {
        level.shades_traps[ i ] destroy_hud();
    }

    level.talker_traps delete();
    level.cyto_traps delete();
    level.talk_traps delete();
    level.shades_traps delete();
}

sq_talk_10_collected_nades()
{
    
    level endon( "end_game" );

    level.talk_colnad = [];
    level.shades_colnad = [];
    r_width = 40;
    r_height = 40;

    width = 310;
    height = 16;
    x = 1.8;
    r = 1.6;
    x = 0;
    level.talker_colnad = newHudElem();
    level.talker_colnad.x = 10;
    level.talker_colnad.y = 0;
    level.talker_colnad.alignx = "left";
    level.talker_colnad.aligny = "top";
    level.talker_colnad.horzalign = "user_left";
    level.talker_colnad.vertalign = "user_top";
    level.talker_colnad.alpha = 0;
    level.talker_colnad.foreground = true;
    level.talker_colnad.hidewheninmenu = true;
    level.talker_colnad setshader( "zombies_rank_3_ded", r_width, r_height );
    level.talker_colnad.y = 26;
    level.talker_colnad thread sq_talk_skull_icon_blinker();
    s = 0;

    level.cyto_colnad = newHudElem();
    level.cyto_colnad.x = 21;
    level.cyto_colnad.y = 0;
    level.cyto_colnad.alignx = "left";
    level.cyto_colnad.aligny = "top";
    level.cyto_colnad.horzalign = "user_left";
    level.cyto_colnad.vertalign = "user_top";
    level.cyto_colnad.alpha = 0;
    level.cyto_colnad.foreground = true;
    level.cyto_colnad.hidewheninmenu = true;
    level.cyto_colnad.fontscale = 1;
    level.cyto_colnad settext( "T^2.^2E^7.^7D^2.^2D" );
    level.cyto_colnad.y = 67.5;

    for( x = 0; x < 6; x++ )
    {
        level.shades_colnad[ x ] = newHudElem();
        level.shades_colnad[ x ].x = 45;
        level.shades_colnad[ x ].y = 0;
        level.shades_colnad[ x ].alignx = "left";
        level.shades_colnad[ x ].aligny = "top";
        level.shades_colnad[ x ].horzalign = "user_left";
        level.shades_colnad[ x ].vertalign = "user_top";
        level.shades_colnad[ x ].alpha = 0;
        level.shades_colnad[ x ].color = ( 0.67, 0, 0.01 );
        level.shades_colnad[ x ].inuse = false;
        level.shades_colnad[ x ].hidewheninmenu = true;
        level.shades_colnad[ x ] setshader( "scorebar_zom_1", width, height );
        wait 0.05;
       
    }

    level.shades_colnad[ 0 ].y = 18;
    level.shades_colnad[ 1 ].y = 28;
    level.shades_colnad[ 2 ].y = 38;
    level.shades_colnad[ 3 ].y = 48;
    level.shades_colnad[ 4 ].y = 58;
    level.shades_colnad[ 5 ].y = 68;

    for ( f = 0; f < 4; f++ )
    {
        level.talk_colnad[ f ] = newHudElem();
        level.talk_colnad[ f ].x = 60;
        level.talk_colnad[ f ].y = 0;
        level.talk_colnad[ f ].alignx = "left";
        level.talk_colnad[ f ].aligny = "top";
        level.talk_colnad[ f ].horzalign = "user_left";
        level.talk_colnad[ f ].vertalign = "user_top";
        level.talk_colnad[ f ].foreground = true;
        level.talk_colnad[ f ].alpha = 0;
        level.talk_colnad[ f ].color = ( 1, 1, 1 );
        level.talk_colnad[ f ].inuse = false;
        level.talk_colnad[ f ].hidewheninmenu = true;
        level.talk_colnad[ f ].font = "default";
    }

    level.talk_colnad[ 0 ].y = 20;
    level.talk_colnad[ 1 ].y = 35;
    level.talk_colnad[ 2 ].y = 50;
    level.talk_colnad[ 3 ].y = 65;

    level.talk_colnad[ 0 ].fontscale = 1.25;
    level.talk_colnad[ 1 ].fontscale = 1.25;
    level.talk_colnad[ 2 ].fontscale = 1.25;
    level.talk_colnad[ 3 ].fontscale = 1.25;
    

    level.talk_colnad[ 0 ] settext( "You really took your ^3time^7 huh?" );
    level.talk_colnad[ 1 ] settext( "Oh well at least the ^3explosive cores^7 are collected now." );
    level.talk_colnad[ 2 ] settext( "Wait a ^3minute^7.. I think there's ^3one more^7 floating somewhere in ^3perk heaven^7." );
    level.talk_colnad[ 3 ] settext( "Go locate the ^3bomb^7 whenever you can!" );

    level.talk_colnad[ 0 ].alpha = 0;
    level.talk_colnad[ 1 ].alpha = 0;
    level.talk_colnad[ 2 ].alpha = 0;
    level.talk_colnad[ 3 ].alpha = 0;
    ut = false;
    f = 2;
    for ( s = 0; s < level.shades_colnad.size; s++ )
    {
        level.shades_colnad[ s ].alpha = 0;
        level.shades_colnad[ s ] fadeovertime( f );
        level.shades_colnad[ s ].alpha = 1;
        if ( !ut )
        {
            level notify( "beep_talker" );
            playsoundatposition( "zmb_meteor_activate", ( 0, 0, 0 ) );
            ut = true;
        }
        wait randomfloatrange( 0.14, 0.3 );
        f -= 0.25;
    }
    level.cyto_colnad.alpha = 0;
    level.cyto_colnad fadeovertime( 4 );
    level.cyto_colnad.alpha = 1;

    wait 0.1;

    f = 2;
    for( i = 0; i < level.talk_colnad.size; i++ )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.talk_colnad[ i ].alpha = 0;
        level.talk_colnad[ i ] fadeovertime( v );
        level.talk_colnad[ i ].alpha = 1;
        wait 0.08;
    }

    for( i = level.talk_colnad.size; i > 0; i-- )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.talk_colnad[ i ].alpha = 1;
        level.talk_colnad[ i ] fadeovertime( v );
        level.talk_colnad[ i ].alpha = 0;
        wait 0.08;        
    }
    wait 0.1;
    for( i = 0; i < level.talk_colnad.size; i++ )
    {
        v = randomfloatrange( 0.4, 0.9 );
        level.talk_colnad[ i ].alpha = 0;
        level.talk_colnad[ i ] fadeovertime( v );
        level.talk_colnad[ i ].alpha = 1;
        wait 0.08;  
    }
    wait 1;

    for ( s = 0; s < level.talk_colnad.size; s++ )
    {
        level.talk_colnad[ s ] thread sq_talk_turn_colors();
        wait randomfloatrange( 0.4, 0.9 );
    }
    wait 8.5;

    level.talk_colnad = array_randomize( level.talk_colnad );


    level.talker_colnad.alpha = 1;
    level.talker_colnad fadeovertime( 3.5 );
    level.talker_colnad.alpha = 0;

    level.cyto_colnad.alpha = 1;
    level.cyto_colnad fadeovertime( 3.5 );
    level.cyto_colnad.alpha = 0;
    wait .1;

    x = 2.5;
    for ( u = 0; u < level.shades_colnad.size; u++ )
    {
        s = randomfloatrange( 0.3, 0.6 );
        level.shades_colnad[ u ].alpha = 1;
        level.shades_colnad[ u ] fadeovertime( x );
        level.shades_colnad[ u ].alpha = 0;
        x -= 0.35;
        wait s;
    }
    x = 2.5;
    for( i = 0; i < level.talk_colnad.size; i++ )
    {
        level.talk_colnad[ i ].alpha = 1;
        level.talk_colnad[ i ] fadeovertime( x );
        level.talk_colnad[ i ].alpha = 0;
        x -= 0.35;
    }

    wait 3;
    level.talker_colnad destroy_hud();
    level.cyto_colnad destroy_hud();

    for ( i = 0; i < level.talk_colnad.size; i++ )
    {
        level.talk_colnad[ i ] destroy_hud();
    }

    for( i = 0; i < level.shades_colnad.size; i++ )
    {
        level.shades_colnad[ i ] destroy_hud();
    }
    level.talker_colnad delete();
    level.cyto_colnad delete();
    level.talk_colnad delete();
    level.shades_colnad delete();
}

sq_talk_11_space_bomb()
{
    
    level endon( "end_game" );

    level.talk_bomb = [];
    level.shades_bomb = [];
    r_width = 40;
    r_height = 40;

    width = 310;
    height = 16;
    x = 1.8;
    r = 1.6;
    x = 0;
    level.talker_bomb = newHudElem();
    level.talker_bomb.x = 10;
    level.talker_bomb.y = 0;
    level.talker_bomb.alignx = "left";
    level.talker_bomb.aligny = "top";
    level.talker_bomb.horzalign = "user_left";
    level.talker_bomb.vertalign = "user_top";
    level.talker_bomb.alpha = 0;
    level.talker_bomb.foreground = true;
    level.talker_bomb.hidewheninmenu = true;
    level.talker_bomb setshader( "zombies_rank_3_ded", r_width, r_height );
    level.talker_bomb.y = 26;
    level.talker_bomb thread sq_talk_skull_icon_blinker();
    s = 0;

    level.cyto_bomb = newHudElem();
    level.cyto_bomb.x = 21;
    level.cyto_bomb.y = 0;
    level.cyto_bomb.alignx = "left";
    level.cyto_bomb.aligny = "top";
    level.cyto_bomb.horzalign = "user_left";
    level.cyto_bomb.vertalign = "user_top";
    level.cyto_bomb.alpha = 0;
    level.cyto_bomb.foreground = true;
    level.cyto_bomb.hidewheninmenu = true;
    level.cyto_bomb.fontscale = 1;
    level.cyto_bomb settext( "T^2.^2E^7.^7D^2.^2D" );
    level.cyto_bomb.y = 67.5;

    for( x = 0; x < 6; x++ )
    {
        level.shades_bomb[ x ] = newHudElem();
        level.shades_bomb[ x ].x = 45;
        level.shades_bomb[ x ].y = 0;
        level.shades_bomb[ x ].alignx = "left";
        level.shades_bomb[ x ].aligny = "top";
        level.shades_bomb[ x ].horzalign = "user_left";
        level.shades_bomb[ x ].vertalign = "user_top";
        level.shades_bomb[ x ].alpha = 0;
        level.shades_bomb[ x ].color = ( 0.67, 0, 0.01 );
        level.shades_bomb[ x ].inuse = false;
        level.shades_bomb[ x ].hidewheninmenu = true;
        level.shades_bomb[ x ] setshader( "scorebar_zom_1", width, height );
        wait 0.05;
       
    }

    level.shades_bomb[ 0 ].y = 18;
    level.shades_bomb[ 1 ].y = 28;
    level.shades_bomb[ 2 ].y = 38;
    level.shades_bomb[ 3 ].y = 48;
    level.shades_bomb[ 4 ].y = 58;
    level.shades_bomb[ 5 ].y = 68;

    for ( f = 0; f < 4; f++ )
    {
        level.talk_bomb[ f ] = newHudElem();
        level.talk_bomb[ f ].x = 60;
        level.talk_bomb[ f ].y = 0;
        level.talk_bomb[ f ].alignx = "left";
        level.talk_bomb[ f ].aligny = "top";
        level.talk_bomb[ f ].horzalign = "user_left";
        level.talk_bomb[ f ].vertalign = "user_top";
        level.talk_bomb[ f ].foreground = true;
        level.talk_bomb[ f ].alpha = 0;
        level.talk_bomb[ f ].color = ( 1, 1, 1 );
        level.talk_bomb[ f ].inuse = false;
        level.talk_bomb[ f ].hidewheninmenu = true;
        level.talk_bomb[ f ].font = "default";
    }

    level.talk_bomb[ 0 ].y = 20;
    level.talk_bomb[ 1 ].y = 35;
    level.talk_bomb[ 2 ].y = 50;
    level.talk_bomb[ 3 ].y = 65;

    level.talk_bomb[ 0 ].fontscale = 1.25;
    level.talk_bomb[ 1 ].fontscale = 1.25;
    level.talk_bomb[ 2 ].fontscale = 1.25;
    level.talk_bomb[ 3 ].fontscale = 1.25;
    

    level.talk_bomb[ 0 ] settext( "Very nice, you found it!" );
    level.talk_bomb[ 1 ] settext( "I guess it was a little bit further away then other ones.." );
    level.talk_bomb[ 2 ] settext( "We need to get ^3access^7 to those ^3electric^7 knifey thingies." );
    level.talk_bomb[ 3 ] settext( "^7Place down the bomb at.. hmm.. at it's location?" );
    
    level.talk_bomb[ 0 ].alpha = 0;
    level.talk_bomb[ 1 ].alpha = 0;
    level.talk_bomb[ 2 ].alpha = 0;
    level.talk_bomb[ 3 ].alpha = 0;
    si = false;
    f = 2;
    for ( s = 0; s < level.shades_bomb.size; s++ )
    {
        level.shades_bomb[ s ].alpha = 0;
        level.shades_bomb[ s ] fadeovertime( f );
        level.shades_bomb[ s ].alpha = 1;
        wait randomfloatrange( 0.14, 0.3 );
        if ( !si )
        {
            level notify( "beep_talker" );
            playsoundatposition( "zmb_meteor_activate", ( 0, 0, 0 ) );
            si = true;
        }
        f -= 0.25;
    }
    level.cyto_bomb.alpha = 0;
    level.cyto_bomb fadeovertime( 4 );
    level.cyto_bomb.alpha = 1;

    wait 0.1;

    f = 2;
    for( i = 0; i < level.talk_bomb.size; i++ )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.talk_bomb[ i ].alpha = 0;
        level.talk_bomb[ i ] fadeovertime( v );
        level.talk_bomb[ i ].alpha = 1;
        wait 0.08;
    }

    for( i =  level.talk_bomb.size; i > 0; i-- )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.talk_bomb[ i ].alpha = 1;
        level.talk_bomb[ i ] fadeovertime( v );
        level.talk_bomb[ i ].alpha = 0;
        wait 0.08;        
    }
    wait 0.1;

    //display the text for a x duration
    for( i = 0; i < level.talk_bomb.size; i++ )
    {
        v = randomfloatrange( 0.4, 0.9 );
        level.talk_bomb[ i ].alpha = 0;
        level.talk_bomb[ i ] fadeovertime( v );
        level.talk_bomb[ i ].alpha = 1;
        wait 0.08;  
    }
    wait 1;

    for ( s = 0; s < level.talk_bomb.size; s++ )
    {
        level.talk_bomb[ s ] thread sq_talk_turn_colors();
        wait randomfloatrange( 0.4, 0.9 );
    }
    wait 8.5;

    level.talk_bomb = array_randomize( level.talk_bomb );

    level.talker_bomb.alpha = 1;
    level.talker_bomb fadeovertime( 3.5 );
    level.talker_bomb.alpha = 0;

    level.cyto_bomb.alpha = 1;
    level.cyto_bomb fadeovertime( 3.5 );
    level.cyto_bomb.alpha = 0;
    wait .1;

    x = 2.5;
    for ( u = 0; u < level.shades_bomb.size; u++ )
    {
        s = randomfloatrange( 0.3, 0.6 );
        level.shades_bomb[ u ].alpha = 1;
        level.shades_bomb[ u ] fadeovertime( x );
        level.shades_bomb[ u ].alpha = 0;
        x -= 0.35;
        wait s;
    }
    x = 2.5;
    for( i = 0; i < level.talk_bomb.size; i++ )
    {
        level.talk_bomb[ i ].alpha = 1;
        level.talk_bomb[ i ] fadeovertime( x );
        level.talk_bomb[ i ].alpha = 0;
        x -= 0.35;
    }

    wait 3;
    level.talker_bomb destroy_hud();
    level.cyto_bomb destroy_hud();

    for ( i = 0; i < level.talk_bomb.size; i++ )
    {
        level.talk_bomb[ i ] destroy_hud();
    }

    for( i = 0; i < level.shades_bomb.size; i++ )
    {
        level.shades_bomb[ i ] destroy_hud();
    }
    level.talker_bomb delete();
    level.cyto_bomb delete();
    level.talk_bomb delete();
    level.shades_bomb delete();
}

sq_talk_12_knife_elec()
{
    
    level endon( "end_game" );

    level.talk_galvas = [];
    level.shades_galvas = [];
    r_width = 40;
    r_height = 40;

    width = 310;
    height = 16;
    x = 1.8;
    r = 1.6;
    x = 0;
    level.talker_galvas = newHudElem();
    level.talker_galvas.x = 10;
    level.talker_galvas.y = 0;
    level.talker_galvas.alignx = "left";
    level.talker_galvas.aligny = "top";
    level.talker_galvas.horzalign = "user_left";
    level.talker_galvas.vertalign = "user_top";
    level.talker_galvas.alpha = 0;
    level.talker_galvas.foreground = true;
    level.talker_galvas.hidewheninmenu = true;
    level.talker_galvas setshader( "zombies_rank_3_ded", r_width, r_height );
    level.talker_galvas.y = 26;
    level.talker_galvas thread sq_talk_skull_icon_blinker();
    s = 0;

    self.cyto_galvas = newHudElem();
    self.cyto_galvas.x = 21;
    self.cyto_galvas.y = 0;
    self.cyto_galvas.alignx = "left";
    self.cyto_galvas.aligny = "top";
    self.cyto_galvas.horzalign = "user_left";
    self.cyto_galvas.vertalign = "user_top";
    self.cyto_galvas.alpha = 0;
    self.cyto_galvas.foreground = true;
    self.cyto_galvas.hidewheninmenu = true;
    self.cyto_galvas.fontscale = 1;
    self.cyto_galvas settext( "T^2.^2E^7.^7D^2.^2D" );
    self.cyto_galvas.y = 67.5;

    for( x = 0; x < 6; x++ )
    {
        level.shades_galvas[ x ] = newHudElem();
        level.shades_galvas[ x ].x = 45;
        level.shades_galvas[ x ].y = 0;
        level.shades_galvas[ x ].alignx = "left";
        level.shades_galvas[ x ].aligny = "top";
        level.shades_galvas[ x ].horzalign = "user_left";
        level.shades_galvas[ x ].vertalign = "user_top";
        level.shades_galvas[ x ].alpha = 0;
        level.shades_galvas[ x ].color = ( 0.67, 0, 0.01 );
        level.shades_galvas[ x ].inuse = false;
        level.shades_galvas[ x ].hidewheninmenu = true;
        level.shades_galvas[ x ] setshader( "scorebar_zom_1", width, height );
        wait 0.05;
       
    }

    level.shades_galvas[ 0 ].y = 18;
    level.shades_galvas[ 1 ].y = 28;
    level.shades_galvas[ 2 ].y = 38;
    level.shades_galvas[ 3 ].y = 48;
    level.shades_galvas[ 4 ].y = 58;
    level.shades_galvas[ 5 ].y = 68;

    for ( f = 0; f < 4; f++ )
    {
        level.talk_galvas[ f ] = newHudElem();
        level.talk_galvas[ f ].x = 60;
        level.talk_galvas[ f ].y = 0;
        level.talk_galvas[ f ].alignx = "left";
        level.talk_galvas[ f ].aligny = "top";
        level.talk_galvas[ f ].horzalign = "user_left";
        level.talk_galvas[ f ].vertalign = "user_top";
        level.talk_galvas[ f ].foreground = true;
        level.talk_galvas[ f ].alpha = 0;
        level.talk_galvas[ f ].color = ( 1, 1, 1 );
        level.talk_galvas[ f ].inuse = false;
        level.talk_galvas[ f ].hidewheninmenu = true;
        level.talk_galvas[ f ].font = "default";
    }

    level.talk_galvas[ 0 ].y = 20;
    level.talk_galvas[ 1 ].y = 35;
    level.talk_galvas[ 2 ].y = 50;
    level.talk_galvas[ 3 ].y = 65;

    level.talk_galvas[ 0 ].fontscale = 1.25;
    level.talk_galvas[ 1 ].fontscale = 1.25;
    level.talk_galvas[ 2 ].fontscale = 1.25;
    level.talk_galvas[ 3 ].fontscale = 1.25;
    

    level.talk_galvas[ 0 ] settext( "Fantastic ^3job^7!" );
    level.talk_galvas[ 1 ] settext( "I'm surprised that the ^3bomb^7 didn't ^3explode^7 on you while you were carrying it haha!" );
    level.talk_galvas[ 2 ] settext( "You could ^3try hitting^7 those electric ^3boxes^7 beside both houses." );
    level.talk_galvas[ 3 ] settext( "Ehh.. ^3regular^7 melee attack might ^3not^7 work with this one." );
    gg = false;
    level.talk_galvas[ 0 ].alpha = 0;
    level.talk_galvas[ 1 ].alpha = 0;
    level.talk_galvas[ 2 ].alpha = 0;
    level.talk_galvas[ 3 ].alpha = 0;

    f = 2;
    for ( s = 0; s < level.shades_galvas.size; s++ )
    {
        level.shades_galvas[ s ].alpha = 0;
        level.shades_galvas[ s ] fadeovertime( f );
        level.shades_galvas[ s ].alpha = 1;
        wait randomfloatrange( 0.14, 0.3 );
        if ( !gg )
        {
            level notify( "beep_talker" );
            playsoundatposition( "zmb_meteor_activate", ( 0, 0, 0 ) );
            gg = true;
        }
        f -= 0.25;
    }
    self.cyto_galvas.alpha = 0;
    self.cyto_galvas fadeovertime( 4 );
    self.cyto_galvas.alpha = 1;

    wait 0.1;

    //display a flashing loop fx at first
    f = 2;
    for( i = 0; i < level.talk_galvas.size; i++ )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.talk_galvas[ i ].alpha = 0;
        level.talk_galvas[ i ] fadeovertime( v );
        level.talk_galvas[ i ].alpha = 1;
        wait 0.08;
    }

    for( i = level.talk_galvas.size; i > 0; i-- )
    {
        v = randomfloatrange( 0.2, 0.3 );
        level.talk_galvas[ i ].alpha = 1;
        level.talk_galvas[ i ] fadeovertime( v );
        level.talk_galvas[ i ].alpha = 0;
        wait 0.08;        
    }
    wait 0.1;

    //display the text for a x duration
    for( i = 0; i < level.talk_galvas.size; i++ )
    {
        v = randomfloatrange( 0.4, 0.9 );
        level.talk_galvas[ i ].alpha = 0;
        level.talk_galvas[ i ] fadeovertime( v );
        level.talk_galvas[ i ].alpha = 1;
        wait 0.08;  
    }
    wait 1;

    for ( s = 0; s < level.talk_galvas.size; s++ )
    {
        level.talk_galvas[ s ] thread sq_talk_turn_colors();
        wait randomfloatrange( 0.4, 0.9 );
    }
    wait 8.5;

    level.talk_galvas = array_randomize( level.talk_galvas );


    level.talker_galvas.alpha = 1;
    level.talker_galvas fadeovertime( 3.5 );
    level.talker_galvas.alpha = 0;

    self.cyto_galvas.alpha = 1;
    self.cyto_galvas fadeovertime( 3.5 );
    self.cyto_galvas.alpha = 0;
    wait .1;

    x = 2.5;
    for ( u = 0; u < level.shades_galvas.size; u++ )
    {
        s = randomfloatrange( 0.3, 0.6 );
        level.shades_galvas[ u ].alpha = 1;
        level.shades_galvas[ u ] fadeovertime( x );
        level.shades_galvas[ u ].alpha = 0;
        x -= 0.35;
        wait s;
    }
    x = 2.5;
    for( i = 0; i < level.talk_galvas.size; i++ )
    {
        level.talk_galvas[ i ].alpha = 1;
        level.talk_galvas[ i ] fadeovertime( x );
        level.talk_galvas[ i ].alpha = 0;
        x -= 0.35;
    }

    wait 3;

    level.talker_galvas destroy_hud();
    self.cyto_galvas destroy_hud();

    for ( i = 0; i < level.talk_galvas.size; i++ )
    {
        level.talk_galvas[ i ] destroy_hud();
    }

    for( i = 0; i < level.shades_galvas.size; i++ )
    {
        level.shades_galvas[ i ] destroy_hud();
    }
    level.talker_galvas delete();
    self.cyto_galvas delete();
    level.talk_galvas delete();
    level.shades_galvas delete();
}
