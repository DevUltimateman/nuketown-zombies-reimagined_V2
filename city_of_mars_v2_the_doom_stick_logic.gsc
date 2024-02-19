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
    precachemodel( "c_zom_dlc0_zom_head3" );
    level.destruction_in_place = false;
    level.black_hole_active = false;
    level thread ee_reward_spawner();
    precachemodel( "t6_wpn_launch_m32_world" );
}

mover()
{
    level endon( "end_game" );
    while( true )
    {
        self MoveZ(15, 4, 0.1, 0.1 );
        self rotateYaw( 360, 4 );
        self rotatePitch( 360, 4 );
        wait 4;
        self MoveZ(-15, 4, 0.1, 0.1 );
        self rotateYaw( 360, 4 );
        self rotatePitch( 360, 4 );
        wait 4;
    }
}

ee_reward_spawner() // spawn in the doomstick at the backyard
{
    level endon( "end_game" );

    flag_wait( "initial_blackscreen_passed" );
    //level.playa_has_dooma = false;

    level waittill( "reward_the_weapons" );
    wait 1;
    trigger_location = ( -1959.16, 180.891, -56.1344 );
    head_location = ( -1959.16, 180.891, -29.4342 );

    headd = spawn( "script_model", head_location );
    headd setmodel( "t6_wpn_launch_m32_world" );
    headd.angles = ( -90, 0 , 0 );
    wait 1;
    playfxontag( level._effect[ "fx_fire_fireplace_md" ], headd, "tag_origin" );
    wait 0.05;
    playfxontag( level._effect[ "powerup_on" ], headd, "tag_origin" );
    headd thread mover();
    trigg = spawn( "trigger_radius", trigger_location, 25, 40, 40 );
    trigg setcursorhint( "HINT_NOICON" );
    trigg.active = false;
    trigg.in_use = false;
    level thread LowerMessage( "missing_", "Hold ^3[{+activate}]^7 to pick up ^3THE DOOMSTICK^7" );
    trigg setlowermessage( trigg, "missing_" );
    level thread LowerMessage( "someone_has_it", "^3THE DOOMSTICK^7 is in use! Come ^3back^7 later." );

    while ( true )
    {
        trigg waittill( "trigger", activator );
        
        if( activator in_revive_trigger() )
        {
            continue;
        }
        if( is_player_valid( activator ) )
        {
            if( !trigg.active )
            {
                wait 0.1;
                level.whos = activator;
                headd setmodel( "tag_origin" );
                PlaySoundAtPosition( "zmb_meteor_activate", headd.origin );
                trigg setlowermessage( trigg, "someone_has_it" );
                stt_weap = level.whos getCurrentWeapon();
                level.whos takeWeapon( stt_weap );
                activator thread print_weap_info();
                //level.playa_has_dooma = true;
                wait 0.5;
                level.whos giveweapon( "m32_upgraded_zm" );
                level.whos giveMaxAmmo( "m32_upgraded_zm" );
                level.whos switchtoweapon( "m32_upgraded_zm" );
                wait 0.8;
                level thread track_colors();
                level thread stop_tracking_colors();
                level.whos thread ee_reward_weapon();
                level.whos thread still_has_ee_weapon();
                level.whos thread notify_on_leave();
                trigg.active = true;
                trigg.in_use = true;
            }
        }

        level waittill( "ee_weapon_available" );

        wait 1;
        trigg setlowermessage( trigg, "missing_" );
        headd setmodel( "t6_wpn_launch_m32_world" );
        level.whos = undefined;
        playfxontag( level._effect[ "fx_zombie_powerup_caution_wave" ], headd, "tag_origin" );
        wait 0.05;
        playfxontag( level._effect[ "powerup_on" ], headd, "tag_origin" );
        wait 0.05;
        trigg.active = false;
        trigg.in_use = false;
        playfxontag( level._effect[ "fx_fire_fireplace_md" ], headd, "tag_origin" );
        wait 1;

    }
    
}

print_weap_info()
{
    level endon( "end_game" );
    self endon( "disconnect" );

    wait 1;
    self iprintlnbold( "^3Doomstick ^7will return to it's ^3original spawn^7 upon losing the weapon." );
}
notify_on_leave()
{
    level endon( "end_game" );
    level endon( "stop_doom_from_player" );

    self waittill( "disconnect" );
    level notify( "ee_weapon_available" );
    wait 0.05;
    level notify( "no_one_has_ee_weapon" );
}
still_has_ee_weapon()
{
    level endon( "end_game" );
    level endon( "no_one_has_ee_weapon" );
    self endon( "disconnect" );
    level endon( "no_need_to_track" );
    //self = level.whos/activator
    while ( true )
    {
        if( self hasweapon( "m32_upgraded_zm" )  )
        {
            wait 1;
        }

        if( !self hasweapon( "m32_upgraded_zm" ) )
        {
            wait 0.05;
            level notify( "ee_weapon_available" );
            level notify( "stop_doom_from_player" );
            //level notify( "no_one_has_ee_weapon" );
            break;
        }
        if( !IsAlive( self ) )
        {
            wait 0.1;
            level notify( "ee_weapon_available" );
            wait 0.1;
            level notify( "no_need_to_track" );
            break;
        }
        
        wait 1;
    }
}


boomstick_visuals()
{
    level endon( "stop_visuals_1_fs" );
    level endon( "stop_tracking_colors" );
    rgbh_v = "0.26 0.1 0.2";
    suncolor = ( 1, 0.8, 0.8 );

    target_rgbl = "3.25 0 0 0";
    target_rgbh = "0.26 0.1 0.2 0.14";
    target_fog = 0;
    rgplus = "0.1 0 0 0";
    se = "0 0 0 0";
    //this vc_effect length = 2.8 seconds
    
    self setclientdvar( "vc_rgbl", "0 0 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "0.1 0.01 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "0.2 0.02 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "0.3 0.03 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "0.4 0.03 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "0.5 0.04 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "0.6 0.05 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "0.7 0.1 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "0.8 0.15 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "0.9 0.2 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "1 0.25 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "1.1 0.3 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "1.2 0.35 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "1.3 0.4 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "1.4 0.45 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "1.5 0.5 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "1.6 0.55 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "1.7 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "1.8 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "1.9 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "2 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "2.1 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "2.2 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "2.3 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "2.4 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "2.5 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "2.6 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "2.7 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "2.8 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "2.9 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "3 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "3.1 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "3.2 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "3.3 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "3.4 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "3.5 0.6 0 0" );
    //level waittill( "restore_visuals_1" );
    //self setclientdvar( "vc_rgbl", "0 0 0 0" );  
    
    
}
boomstick_2visuals()
{
    level endon( "stop_visuals2_fs" );
    level endon( "stop_tracking_colors" );
    wait 0.7;
    if( !level._endgame_active )
    {
        self setclientdvar( "vc_rgbh", "0.26 0.1 0.2 0.13" );
    }
    
    //level waittill( "restore_visuals_2" );
    //self setclientdvar( "vc_rgbh", "0.26 0.1 0.2 0.2" );
    //self setclientdvar("vc_rgbh", "0.26 0.1 0.2 0.1" );
    //self setclientdvar("vc_rgbh", "0.26 0.1 0.2 0" );
}

stop_tracking_colors()
{
    level endon( "end_game" );
    
    while ( true )
    {
        level waittill( "stop_tracking_colors" );
        if( !level._endgame_active )
        {
            foreach( player in level.players )
            {
                player thread stop_visuals();
            }
        }
        
    }
}

stop_visuals()
{
    level endon( "end_game" );
    self endon( "disconnect" );
    if( !level._endgame_active )
    {
        self setclientdvar("vc_rgbh", "0.26 0.1 0.2 0" );
        self setclientdvar( "vc_rgbl", "0 0 0 0" );  
        self setclientdvar( "r_dof_tweak", 0 );
        self setclientdvar( "r_dof_enable", 0 );
    }
   
}
boomstick_blur_visuals()
{
    level endon("stop_blurs_fs");
    level endon( "stop_tracking_colors" );
    if(!level._endgame_active)
    {
        self setclientdvar( "r_dof_tweak", 1 );
        self setclientdvar( "r_dof_enable", 1 );
        self setclientdvar("r_dof_bias", 0 );
        self setclientdvar( "r_dof_farblur", 3.1 );
        self setclientdvar( "r_dof_farend", 1000 );
        self setclientdvar( "r_dof_farstart", 700 );
        self setclientdvar( "r_dof_nearblur", 6 );
        self setclientdvar( "r_dof_nearstart", 1000 );
        self setclientdvar( "r_dof_nearend", 1000 );
        self setclientdvar( "r_dof_viewmodelend", 0 );
    }
    

    //level waittill( "disable_dof_setup" );
    //self setclientdvar( "r_dof_tweak", 0 );
    //self setclientdvar( "r_dof_enable", 0 );
}

do_black_hole_move()
{
    level endon("end_game");
    self endon( "at_location" );

    i = 0;
    tagger = spawn( "script_model", self.origin );
    tagger setmodel( "tag_origin" );
    tagger.angles = ( -90, 0, 0 );
    get_tag = [];
    get_tag[ 0 ] = "j_head";
    get_tag[ 1 ] = "j_neck";
    get_tag[ 2 ] = "J_Shoulder_RI";
    get_tag[ 3 ] = "J_SpineLower";
    get_tag[ 4 ] = "J_SpineUpper";
    get_tag[ 5 ] = "J_Spine4";
    get_tag[ 6 ] = "J_Hip_LE";
    random_tag = randomintrange( 0, get_tag.size );
    self playLoopSound( "zmb_perks_incoming_loop" );
    //failsafe?
    playsoundatposition( "pre_spawn", self.origin );
    self linkto( tagger, "tag_origin" );
    tagger thread angle_pitcher(); //rotates the zombies on all axis ( x, y, z )
    whatNum = randomintrange( 0, 3 );
    if( whatNum >= 2 )
    {
        playfxontag( level._effect[ "fx_ash_embers_up_lg" ], self, "tag_origin" );
    }
    else if( whatNum <= 1 )
    {
        playfxontag( level._effect[ "fx_zm_elec_arc_vert" ], self, "tag_origin" );
    }
    playfxontag( level._effect[ "fx_zmb_tranzit_fire_med" ], self, "tag_origin" );
    tagger MoveZ( 30, 0.2 );
    tagger waittill("movedone");
    tagger MoveTo( level.target_boom.origin, randomfloatrange( 1.1, 2/*1.7, 3.1*/ ), 0.6, 0 ); //*1.7, 3.1*/
    tagger waittill( "movedone" );
    tagger notify( "done_pitcher" );
    self hide();
    self dodamage( self.health + 500, self.origin );
    self unlink();
    self delete();
    wait 0.05;
    tagger delete();
    wait 0.05;
    self notify( "bhole_done" );
}


kill_zombie_failsafe()
{
    wait 4;
    if( isAlive( self ) )
    {
        self dodamage( self.health + 500, self.origin );
        self delete();
    }
}


angle_pitcher()
{
    self endon( "done_pitcher" );
    
    get_ang = self getangles();
    randomize = randomintrange( 0, 3 );
    if ( randomize <= 1 )
    {
        while ( true )
        {
            wait 0.01;
            plussa = 4;
            self.angles = self.angles + ( plussa, plussa, plussa );
            if ( self.angles == ( 360, 360, 360 ) )
            {
                wait 0.01;
                self.angles = ( 0, 0, 0 );
                plussa = 0;
            }
        }
    }
    else if( randomize >= 2 )
    {
        self.angles =  ( 360, 360, 360 );
        while ( true )
        {
            wait 0.01;
            plussa = -4;
            self.angles = self.angles + ( plussa, plussa, plussa );
            if ( self.angles == ( 0, 0, 0 ) )
            {
                wait 0.01;
                self.angles = ( 360, 360, 360 );
                plussa = -4;
            }
        }
    }
    
}

should_drop_power_up()
{
    level endon( "end_game" );

    powers = [];
    powers[ 0 ] = ( "bonfire_sale" );
    powers[ 1 ] = ( "insta_kill" );
    powers[ 2 ] = ( "carpenter" );
    powers[ 3 ] = ( "double_points" );
    powers[ 4 ] = ( "full_ammo" );

    checker = randomintrange( 0, 100 );
    if ( checker > 95 )
    {
        chosen = randomIntRange( 0, powers.size );
        level specific_powerup_drop( powers[ chosen ], self.origin + vectorScale( ( 0, 0, 1 ), 10 ) );
    }
    else 
    {
        /*
        /#
            iprintlnbold( "CHECKER WAS ^2" + checker + ". No power up created" );
        #/
        */
    }
}


LowerMessage( ref, text )
{
	if( !IsDefined( level.zombie_hints ) )
    {
        level.zombie_hints = [];
    }
	PrecacheString( text );
	level.zombie_hints[ ref ] = text;
}

setLowerMessage( ent, default_ref )
{
	if( IsDefined( ent.script_hint ) )
    {
        self SetHintString( get_zombie_hint( ent.script_hint ) );
    }	
	else
    {
        self SetHintString( get_zombie_hint( default_ref ) );
    }
		
}

track_colors()
{
    level endon( "end_game" );

    //flag_wait( "initial_blackscreen_passed" );
    //level waittill("ee_weapon_ready");
    //level waittill(); //needs a notify once picked up
    while( true )
    {
        level waittill( "target_boom_created" );
        if ( level.black_hole_active )
        {
            foreach ( player in level.players )
            {
                distance_from_player = distance( level.target_boom.origin, player.origin );
                if ( distance_from_player <= 1000 )
                {
                    if( level._endgame_active )
                    {
                        Earthquake( 0.22, 4, ( 0, 0, 0 ), 3500 );
                    }
                    else if( !level._endgame_active )
                    {
                        player thread boomstick_visuals();
                        player thread boomstick_2visuals();
                        player thread boomstick_blur_visuals();
                        Earthquake( 0.22, 4, ( 0, 0, 0 ), 3500 );
                    }
                    
                }
            }
        }
        level waittill( "target_boom_deleted" );
        level notify( "stop_tracking_colors" ); 
    }
}

black_hole_looper_sound()
{
    level endon( "end_game" );
    self playLoopSound( "zmb_perks_incoming_loop", 1 );
    wait 0.05;
    level waittill( "stop_bhole_looper_snd" );
    self stopLoopSound(1);
}

death_checker()
{
    self waittill( "death" );
    level.s -= 1;
}

sizechecker()
{
    i = 0;
    while( true )
    {
        wait 0.05; 
        if ( level.s <= 0 && level.black_hole_active )
        {
            
            level notify( "target_boom_deleted" );
            wait 0.05;
            playfx( level._effect[ "fx_zm_nuked_exp_perk_impact_ext" ], level.target_boom.origin );
            PlaySoundAtPosition( "zmb_perks_incoming_land", level.target_boom.origin );
            wait 0.05;
            level.black_hole_active = false;
            level.target_boom delete();
            //level notify( "bhole_done" ); //possible failsafe
            break;
            
            
        }
          
    }
}

buff_health_during_impact()
{
    new_health =  self.health + 10000;
    self.health = new_health;
}

bholer_wait()
{
    self waittill( "bhole_done" );
}

weapon_zombie_find_sourcer()
{
    level endon( "end_game" );
    self endon( "disconnect" );
    level.playable_areas = getentarray( "player_volume", "script_noteworthy" );
    level.self_destruct = false;
    a_zombies = getaiarray( level.zombie_team );
    level.s = 0;
    foreach( area in level.playable_areas )
    {
        for( i = 0; i < a_zombies.size; i++ )
        {
            if ( a_zombies[ i ] IsTouching( area ) )
            {
                if( isalive( a_zombies[ i ] ) )
                {
                    
                    dist = distance( self.origin, a_zombies[ i ].origin );
                    if( dist <= 500 )
                    {
                        level.s += 1;
                        wait randomFloatRange( 0.1, 0.2 );
                        a_zombies[ i ] thread do_black_hole_move();
                        a_zombies[ i ] buff_health_during_impact();
                        a_zombies[ i ] thread should_drop_power_up();
                        a_zombies[ i ] thread kill_zombie_failsafe();
                        a_zombies[ i ] allowedStances( "crouch" );
                        a_zombies[ i ] AllowPitchAngle( true );
                        a_zombies[ i ] thread bholer_wait();
                        a_zombies[ i ] thread death_checker();
                        
                    }
                    
                }   
                
            }
        }
        
    }
    wait 2;  
}


ee_reward_weapon()
{
    level endon("end_game");
    self endon( "disconnect" );
    level endon( "ee_weapon_available" );
    level.black_hole_active = false;

    level.tagger = [];
    while ( true )
    {
        self waittill( "weapon_fired", weapon );
        wait .1;
        if ( self getcurrentweapon() == "m32_upgraded_zm" )
        {
            
            if ( level.black_hole_active && !level.destruction_in_place )
            {
                level notify( "target_boom_deleted" );
                level.black_hole_active = false; 
                //level.target_boom notify( "stop_this_one" ); //maybe uncomment
                level.target_boom delete();
                wait 0.05;
                level notify( "stop_bhole_looper_snd" );
                
                
            }
            wait 0.05;
            trace = bullettrace( self gettagorigin( "tag_eye" ), self gettagorigin( "j_head" ) + AnglesToForward( self getplayerangles() ) * 1000000, 0, self );
            pos = trace[ "position" ];
            up_loc = pos + ( 0, 0, 90 );
            playfx( level._effect[ "fx_zm_nuked_exp_perk_impact_int" ], pos );
            level.target_boom = spawn( "script_model", up_loc  );
            level.target_boom setModel( "tag_origin" );
            level.black_hole_active = true;
            level notify( "target_boom_created" );

            //remove the remaining clip's ammo to not be too op
            clip_ammo = self getweaponammoclip( weapon );
            if( clip_ammo >= 4 )
            {
                self setweaponammoclip( weapon, clip_ammo - 5 );
            }

            dis = distance( level.target_boom.origin, self.origin );

            level.target_boom thread black_hole_looper_sound();
            level.target_boom thread weapon_zombie_find_sourcer();
            level thread sizechecker(); //works nicely now but need to make sizecheck only for the zombies that were affected
            wait 0.05;
            playfxontag( level._effect[ "rocket_fx" ], level.target_boom, "tag_origin" );
            wait 0.05;
        }
        wait 0.1;
    }
}
