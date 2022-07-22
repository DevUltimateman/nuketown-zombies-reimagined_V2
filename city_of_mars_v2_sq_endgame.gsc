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
    level thread initiate_killer_rocket();
    level._effect[ "explosion" ] = loadfx( "explosions/fx_zm_nuked_exp_perk_impact_ext" );
    level thread flagger();
    //flag_clear( "spawn_zombies" );

    precacheshader( "black" );
    level.huds_active = 0;
    precacheshader( "zombies_rank_5_ded" );
    level.transit_fire = "fx_zmb_tranzit_fire_lrg";
    level.nuke_fire = "fx_zmb_nuke_fire_md";
    level.players_alive = 0;
    level thread end_game_button();
    setdvar( "g_speed", 196 );
    level._endgame_active = false;
    //level thread zombies_in_pain_restart();
    //level.zombie_ai_limit = 32;
    //bullettypetracer only pitch, fix 
    //level thread skiptoNade();  
    //test extra gib fxs while shooting zombies
    //moved to city_of_mars_v2_main.gsc
    //level.callbackactordamage = ::callback_actorr();
    
}



skiptoNade()
{
    level endon( "end_game" );
    flag_wait( "initial_blackscreen_passed" );
    cur_gun = level.players[ 0 ] getCurrentWeapon();
    level.players[0] takeweapon( cur_gun );
    level.players[ 0 ] giveweapon( "galil_zm" );
    level.players[ 0 ] giveMaxAmmo( "galil_zm" );
    wait 10;
    //level notify( "callitquits" );
    level.someone_used_teleporter = true;
    wait 0.05;
    wait 50;
    level notify( "bunker_melee" );
}


/*
zombies_in_pain_restart()
{
    level endon( "end_game" );
    flag_wait( "initial_blackscreen_passed" );
    while( true )
    {
        level thread zombies_in_pain();
        level waittill( "restart_round" );
    }
}
zombies_in_pain()
{
    level endon( "end_game" );
    level endon( "restart_round" );
    wait 7;
    //def_health = ::ai_calculate_health( level.round_number );
    iprintlnbold( "ZOMBIES HEALTH IS NOW " + def_health );
    has_not_gibbed = true;
    while( true )
    {
        specific_zombie = getAIArray( level.zombie_team );
        for( i = 0; i < all_zombies.size; i++ )
        {

            if( specific_zombie[ i ].health < level.zombie_health  )
            {
                
                    specific_zombie[ i ] thread doGibbing();
                    specific_zombie[ i ].has_not_gibbed = false;
                
            }
            wait 0.05;
        }
        wait 0.05;
    }
}

doGibbing()
{
    level endon( "end_game" );
    self endon( "death" );
    while ( true )
    {
        playfx( level._effect[ "zombie_gib" ], self getTagOrigin( "J_Shoulder_LE" ) );
        wait randomfloatrange( 0.05, 0.1 );
        playfx( level._effect[ "headshot" ], self gettagorigin( "J_Head" ) );
        wait randomfloatrange( 0.1, 0.17 );
        playfx( level._effect[ "zombie_guts_explosion" ], self gettagorigin( "J_Shoulder_LE" ) );
        playfx( level._effect[ "zombie_gib" ], self gettagorigin(  "J_SpineLower" ) );
        wait randomintrange( 1, 2 );
    }
}
*/
flagger() //important, reset back the crazy viewmodel amplitudes set by the final stand battle in end game
{
    level endon("end_game" );
    flag_wait( "initial_blackscreen_passed" );
    
    foreach( player in level.players )
    {
        player setclientdvar( "cg_useColorControl", 0 );
        player setclientdvar( "cg_colorscale", "1 1 1" );
        player setclientdvar( "cg_colortemp", 6500 );
        player setclientdvar( "cg_colorHue", 0 );
        player setclientdvar( "cg_colorSaturation", 1 );
        player setclientdvar( "r_watersheetingfx_enable", 0 );
        player setclientdvar( "r_dof_tweak", 0 );

        player setclientdvar( "bg_viewbobAmplitudeDucked", "0.0075, 0.0075" );
        player setclientdvar( "bg_viewbobAmplitudeduckedads", "0.0075, 0.0075" );
        player setclientdvar( "bg_viewbobAmplituderoll", 1.5 );
        player setclientdvar( "bg_viewbobAmplitudestanding", "0.007, 0.007" );
        player setclientdvar( "bg_viewbobAmplitudestandingads", "0.007, 0.007" );

        player setclientdvar( "bg_weaponbobAmplitudeducked", " 0.045, 0.025" );
        player setclientdvar( "bg_weaponbobAmplituderoll", 1.5 );
        player setclientdvar( "bg_weaponbobAmplitudeStanding", " 0.055, 0.025" );
        player setclientdvar( "bg_weaponbobMax", 8 );
    }
}

set_coloring()
{
    level endon( "end_game" );
    self endon( "disconnect" );

    sky_int = 6.2;

    wait 3;
    for ( i = 0; i < 56; i++ )
    {
        sky_int += 0.05;
        self setclientdvar( "r_sky_intensity_factor0", sky_int );
        wait 0.05;
    }

    if ( sky_int != 9 )
    {
        self setclientdvar( "r_sky_intensity_factor0", 9 );
    }

    self thread set_darkening();
    
    wait 0.1;
    self_exp = 4.8;
    for( i = 0; i < 28; i++ )
    {
        self_exp += 0.1;
        self setclientdvar( "r_exposurevalue", self_exp );
        wait 0.08;
    }
}

player_is_hit()
{
    level endon( "end_game" );

    wait 2;
    for( s = 0; s < level.players.size; s++ )
    {
        level.players[ s ] setstance( "prone" );
        level.players[ s ] freezecontrols( true );
        
        level.players[ s ] allowSprint( false );
        
        
        level.players[ s ] setclientdvar( "bg_viewbobAmplitudeDucked", " 0.002, 0.002 " );
        level.players[ s ] setclientdvar( "bg_viewbobAmplitudeduckedads", " 1, 0.008 " );
        level.players[ s ] setclientdvar( "bg_viewbobAmplituderoll", 20 );
        level.players[ s ] setclientdvar( "bg_viewbobAmplitudestanding", " 1, 0.008 " );
        level.players[ s ] setclientdvar( "bg_viewbobAmplitudestandingads", " 1, 0.02 " );
        level.players[ s ] setclientdvar( "bg_weaponbobAmplitudeducked", " 0.2, 0.02 " );
        level.players[ s ] setclientdvar( "bg_weaponbobAmplituderoll", 3 );
        level.players[ s ] setclientdvar( "bg_weaponbobAmplitudeStanding", " 0.3, 0.09 " );
        level.players[ s ] setclientdvar( "bg_weaponbobMax", 30 );
        level.players[ s ] setclientdvar( "com_maxfps", 200 );
    }
    wait 1;
    if( level.players.size == 1 )
    {
        setdvar( "g_speed", 85 );
        player thread solo_game_end_notifier();
    }

    else if ( level.players.size > 1 )
    {
        setdvar( "g_speed", 85 );
    }
    wait 3;
    level thread allowmove();
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
end_game_button()
{
    level endon( "end_game" );

    flag_wait( "initial_blackscreen_passed"  );
    level waittill( "reward_the_weapons" );
    fxorg = ( -873.572, 171.989, -20 );
    trigloc = ( -873.572, 171.989, -55 );
    
    end_fx = spawn( "script_model", fxorg );
    end_fx setmodel( "tag_origin" ); //
    end_fx.angles = ( 0, 0, 0 );
    wait 0.05;
    playfxontag( level._effect[ "powerup_on" ], end_fx, "tag_origin" );
    wait 0.05;
    playfxontag( level._effect[ "fx_fire_fireplace_md" ], end_fx, "tag_origin" );
    end_fx thread mover();
    wait 0.05;

    end_trig = spawn( "trigger_radius", trigloc, 30, 30, 30 );
    end_trig setcursorhint( "HINT_NOICON" );
    level thread LowerMessage( "ender", "^3Launch final rocket ^7 ^2[^7 All players must hold ^3[{+activate}] ^7at the same time ^2]" );
    end_trig setLowerMessage( end_trig, "ender" );

    //logic behind counting the presses & resetting it's state after a failure
    is_pressing = 0;
    while ( true )
    {
        for( i = 0; i < level.players.size; i++ )
        {
            
            if( level.players[ i ] isTouching( end_trig ) && level.players[ i ] useButtonPressed() )
            {
                is_pressing++;
            }
            else
            {
                is_pressing = is_pressing;
            }
        }

        wait 0.05;
        if( is_pressing >= level.players.size )
        {
            //level notify( "do_endgame" ); , original notify start in the bracket tree
            level notify( "beep_talker" );
            PlaySoundAtPosition( "zmb_box_poof", trigloc );
            playfx( level._effect[ "fx_zombie_powerup_wave" ], end_fx.origin );
            wait 0.05;
            end_fx delete();
            end_trig delete();
            wait 2;
            level notify( "do_endgame" );
            wait 0.1;
            break;
        }
        else if ( is_pressing < level.players.size )
        {
            is_pressing = 0;
        }
        wait 0.05;
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

blackout_players()
{
    level endon( "end_game" );

	//fix tomorrow!!!
    level.fade_out_overlay = NewHudElem();
    level.fade_out_overlay.x = 0;
    level.fade_out_overlay.y = 0;
    level.fade_out_overlay.horzAlign = "fullscreen";
    level.fade_out_overlay.vertAlign = "fullscreen";
    level.fade_out_overlay.foreground = false; 
    //level.fade_out_overlay.sort = 50; 
	level.fade_out_overlay SetShader( "black", 640, 480 );

	level.fade_out_overlay.alpha = 0;
	level.fade_out_overlay fadeOverTime( 5 );
	level.fade_out_overlay.alpha = 1;
    //iprintlnbold( "FADE IN DONE" );
	wait 3.4;
    

    for( i = 0; i < level.players.size; i++ )
    {
        level.players[ i ] SetClientUIVisibilityFlag( "hud_visible", false );
    }

    level thread flame_fx_burning();
    wait 3.6;

    level.fade_out_overlay.alpha = 1;
    level thread disableAndEnable_everything(); //some callbacks to v2_main
    level.fade_out_overlay fadeOverTime( 7.5 );
	level.fade_out_overlay.alpha = 0;
    //iprintlnbold( "FADE OUT DONE" );
    wait 3.8;
    level notify( "start_fading" );
    wait 3.8;
    level.fade_out_overlay destroy_hud();

}


allowmove()
{
    level endon( "end_game" );
    level waittill( "start_fading" );

    
    foreach( player in level.players )
    {
        player setStance( "stand" );
        player freezeControls( false );
        player allowStand( true );
        player allowCrouch( true );
        player allowProne( true );
        player allowjump( false );
    }
}


set_darkening()
{
    level endon( "end_game" );
    self endon( "disconnect" );
    self setclientdvar( "cg_colorHue", 359 );
    wait 0.3;
    self setclientdvar( "cg_useColorControl", 1 );
    wait 0.05;
    self thread setColorTemp(); //cg_colorTemp
    self thread setColorHue(); //cg_colorHue
    wait 1;
    self thread setDeSaturation(); //cg_saturation --
    self thread setColorScale(); //cg_colorScale


}

setColorScale()
{
    level endon( "end_game" );
    self endon( "disconnect" );

    a = 1;
    b = 1;
    c = 1;

    self setclientdvar( "cg_colorscale", "1 1 1" );
    wait 0.2;
    self setclientdvar( "cg_colorscale", "1 1 0.95" );
    wait 0.2;
    self setclientdvar( "cg_colorscale", "1 1 0.9" );
    wait 0.2;
    self setclientdvar( "cg_colorscale", "1 1 0.85" );
    wait 0.2;
    self setclientdvar( "cg_colorscale", "1 1 0.8" );
    wait 0.2;
    self setclientdvar( "cg_colorscale", "1 1 0.75" );
    wait 0.2;
    self setclientdvar( "cg_colorscale", "1 1 0.7" );
    wait 0.2;
    self setclientdvar( "cg_colorscale", "1 1 0.65" );
    wait 0.2;
    self setclientdvar( "cg_colorscale", "1 1 0.6" );
    wait 0.2;
    self setclientdvar( "cg_colorscale", "1 1 0.55" );
    wait 0.2;
    self setclientdvar( "cg_colorscale", "1 1 0.5" );
    wait 0.1;
    self setclientdvar( "cg_colorscale", "1 1 0.45" );
    wait 0.1;
    self setclientdvar( "cg_colorscale", "1 1 0.4" );
    wait 0.1;
    self setclientdvar( "cg_colorscale", "1 1 0.35" );
    wait 0.1;
    self setclientdvar( "cg_colorscale", "1 1 0.3" );
}
setDeSaturation()
{
    level endon( "end_game" );
    self endon( "disconnect" );

    self_desat = 1;

    while ( true )
    {
        self_desat -= 0.05;
        self setclientdvar( "cg_colorSaturation", self_desat );
        wait 0.1;

        if ( self_desat <= 0.8 )
        {
            self setclientdvar( "cg_colorsaturation", 0.8 );
            wait 0.1;
            break;
        }
    }
}
setColorHue()
{
    level endon( "end_game" );
    self endon( "disconnect" );

    self_hue = 359;
    wait 0.1;
    while ( true )
    {
        self_hue -= 0.05;
        self setclientdvar( "cg_colorHue", self_hue );
        wait 0.1;
        if ( self_hue <= 355 )
        {
            self setclientdvar( "cg_colorhue", 355 );
            wait 0.1;
            break;
        }
    }
}

setColorTemp()
{
    level endon( "end_game" );
    self endon( "disconnect" );

    self_temp = 6500;

    while ( true )
    {
        self_temp -= 10;
        self setclientdvar( "cg_colorTemp", self_temp );
        wait 0.05;

        if ( self_temp <= 3000 )
        {
            self setclientdvar( "cg_colortemp", 3000 );
            wait 0.1;
            break;
        }
    }
}


disableAndEnable_everything()
{
    level endon( "end_game" );

    for( f = 0; f < level.players.size; f++ )
    {
        level.players[ f ] setclientdvar( "cg_drawcrosshair", 0 );
        level.players[ f ] SetClientUIVisibilityFlag( "hud_visible", false );
        level.players[ f ] notify( "remove_static" );
        level.players[ f ] setclientdvar( "r_dof_tweak", 1 );
        level.players[ f ] setclientdvar( "r_dof_farstart", 200 );
        level.players[ f ] setclientdvar( "r_dof_farend", 10000 );
        level.players[ f ] setclientdvar( "r_dof_nearstart", 1 );
        level.players[ f ] setclientdvar( "r_dof_nearend", 60 );
        level.players[ f ] setclientdvar( "r_watersheetingfx_enable", 1 );
        level.players[ f ] setclientdvar( "r_watersheetingfx_magnitude", 0.005 );
        level.players[ f ] setclientdvar( "r_watersheetingfx_radius", 0.05 );
        wait 0.05;
        //level.players[ f ] setclientdvar( "r_dof_tweak", 1 );
    }
    
    level.sEnter delete();
    level.sSpawn delete();
    level.tEnter delete();
    level.tExit delete();
    level.buzz_trigger delete();
    level.trigger_switch_manne delete();
    level.zombie_total = 10000;
    level notify( "disable_teletoheaven" ); //disable teleporter
    level notify( "deathgame_remove" ); // disables certain running threads from city_of_mars_v2_main.gsc
    level.hud destroy_hud();
    level.hudtext destroy_hud();
    level thread notify_bout_endgame();
    level thread infinite_bleedout();
    level thread attach_notifiers();
    
    
}

infinite_bleedout()
{
    level endon( "end_game" );
    
    setdvar( "revive_trigger_radius", "1" );
    setdvar( "player_lastStandBleedoutTime", "1500" );
    for( i = 0; i < level.players.size; i++ )
    {
        level.players[ i ] setclientdvar( "player_lastStandBleedoutTime", 1500 );
    }
}


track_players()
{
    level endon( "end_game" );

    level.end_game_players = [];

    for( i = 0; i < level.players.size; i++ )
    {
        ArrayInsert( level.end_game_players, "blah", i );
    }
    
    while( true )
    {
        level waittill( "player_downed", player );
        get_random_index = RandomInt( level.end_game_players.size );
        ArrayRemoveIndex( level.end_game_players, get_random_index );
        
        if ( level.end_game_players.size <= 0 )
        {
            iprintlnbold( "THIS PLAYER WON + PLAYER NAME" );
        }
    }
}

check_if_someone_disconnects()
{
    level endon( "end_game" );
    level endon( "nochecksmore" );

    while ( true )
    {
        level waittill( "disconnect", player );
        rnd = randomint( level.end_game_players.size );
        ArrayRemoveIndex( level.end_game_players, rnd );
        if ( level.end_game_players.size < 1 )
        {
            wait 0.1;
            break;
        }
    }
}

attach_notifiers()
{
    if( level.players.size > 1 )
    {
        foreach( player in level.players )
        {
            player thread notifier_printers();
        }
    }
    
    level.players_alive = level.players.size;

    level thread track_deads();   

    // minus players_alive score thread upon disconnecting
    // because players_alive int is first defined by level.players size 
    // and is only decreased by 1 if player goes down
    // hence notifyondisconnect thread
    // so that player_alive score gets down if player leaves so that the size stays correct
    // for the declare winner check
    for( f = 0; f < level.players.size; f++ )
    {
        level.players[ f ] thread notifyOnDisconnectt(); 
    }
}

notifyOnDisconnectt()
{
    level endon( "end_game" );
    self waittill( "disconnect" );
    level.players_alive--;
}
track_deads()
{
    level endon( "end_game" );
    while( true )
    {
        if ( level.players_alive <= 1 && level.players.size > 1 )
        {
            level thread check_dead();
            wait 2;
            level thread declare_the_winner();
            level specific_powerup_drop( "nuke", level.winnhaname.origin + vectorScale( ( 0, 0, 1 ), 2 ) );
            wait 1;
            flag_clear( "spawn_zombies" );
            level setclientdvar( "g_ai", 0 );
        }

        if ( level.players_alive <= 1 && level.players.size == 1 )
        {
            if( level.players[ 0 ] player_is_in_laststand() )
            {
                wait 3;
                level notify( "end_game" );
            }
            
        }
        wait 0.1;
        
    }
}

declare_the_winner()
{
    level endon( "end_game" );

    level.winnah = newHudElem();

    level.winnah.x = 0;
    level.winnah.y = 0;
    level.winnah.alignx = "center";
    level.winnah.aligny = "center";
    level.winnah.vertalign = "user_center";
    level.winnah.horzalign = "user_center";

    level.winnah.y = 25;

    level.winnahs = newHudElem();

    level.winnahs.x = 0;
    level.winnahs.y = 0;
    level.winnahs.alignx = "center";
    level.winnahs.aligny = "center";
    level.winnahs.vertalign = "user_center";
    level.winnahs.horzalign = "user_center";

    level.winnah.fontscale = 1.6;
    level.winnahs.fontscale = 1.7;

    level.winnahs settext( "No glory in winning the battle, ^3" + level.winnahname.name );
    level.winnah settext( "^3You did it anyway.^7 Congratulations!");
    level.winnah.alpha = 0;
    level.winnahs.alpha = 0;
    level.winnahs fadeovertime( 0.25 );
    level.winnahs.alpha = 1;
    wait 0.8;
    level.winnah.alpha fadeovertime( 0.25 );
    level.winnas.alpha = 1;
    wait 3;
    level.winnah fadeovertime( 2 );
    level.winnah.alpha = 0;
    level.winnahs fadeovertime( 2 );
    level.winnahs.alpha = 0;
    wait 3;
    level.winnah destroy_hud();
    level.winnahs destroy_hud();
    level notify( "end_game" );

}

check_dead()
{
    level endon( "end_game" );

    for( i = 0; i < level.players.size; i++ )
    {
        //if( isAlive( level.players[ i ] ) )
        //{
        //    level.winnahname = level.players[ i ].name;
        //}
        if( level.players[ i ] player_is_in_laststand() )
        {
            //level.winnahname = level.players[ i ].name;
        }
        else
        {
            level.winnahname = level.players[ i ];

        }
    }
}

solo_game_end_notifier()
{
    self endon( "disconnect" );

    hud_printer = newHudElem();
    hud_printer.x = 0;
    hud_printer.y = 0;
    hud_printer.alignx = "center";
    hud_printer.aligny = "center";

    hud_printer.vertalign = "user_center";
    hud_printer.horzalign = "user_center";
    hud_printer.fontscale = 1.5;
    hud_printer.alpha = 0;
    
    hud_printer settext( "Test Subject ^3" + self.name + " ^7couldn't survive any longer. ^3Remaining ^7Test Subjects ^3eliminated.^7" );
    level waittill( "end_game" );
    
    
    hud_printer fadeOverTime( 2 );
    hud_printer.alpha = 1;
    wait 5;
    hud_printer fadeOverTime( 1 );
    hud_printer.alpha = 0;
    wait 1;
    hud_printer destroy_hud();

}
notifier_printers( /*pointer*/ )
{
    //level endon( "end_game" );
    self endon( "disconnect" );
    level endon( "end_game" );

    //level.to_addHUD + pointer = newHudElem();
    hud_printer = newHudElem();
    hud_printer.x = 0;
    hud_printer.y = 0;
    hud_printer.alignx = "center";
    hud_printer.aligny = "center";

    hud_printer.vertalign = "user_center";
    hud_printer.horzalign = "user_center";
    hud_printer.fontscale = 1.5;
    hud_printer.alpha = 0;
    hud_printer settext( "Test Subject ^3" + self.name + " ^7couldn't survive any longer. ^3Another one^7 down..." );

    while( true )
    {
        
        self waittill_any( "player_downed", "player_suicide", "death" ); //end_game
        wait 0.3;
        if( level.players_alive <= 1 && level.players.size > 1 )
        {
            break;
        }
        PlaySoundAtPosition("zmb_clock_chime", ( 0, 0, 0 ) );
        if( level.huds_active > 1 )
        {
            hud_printer.y = hud_printer.y * level.huds_active;
        }

        level.huds_active++;
        hud_printer.alpha = 0;
        hud_printer fadeOverTime( 0.5 );
        hud_printer.alpha = 1;
        wait 4;
        hud_printer fadeOverTime( 0.5 );
        hud_printer.alpha = 0;
        wait 1;
        hud_printer destroy_hud();
        level.huds_active--;
        level.players_alive--;
        wait 1;
        break;
        
    }


}
notify_bout_endgame()
{
    level endon( "end_game" );

    level.end_teller = newHudElem();
    level.end_teller_icon = newHudElem();

    level.end_teller.x = 0;
    level.end_teller.y = 0;
    level.end_teller.alignx = "center";
    level.end_teller.aligny = "center";
    level.end_teller.vertalign = "user_center";
    level.end_teller.horzalign = "user_center";

    level.end_teller.alpha = 0;
    level.end_teller.y = 15;

    if( level.players.size > 1 )
    {
        level.end_teller settext( "The last ^3Test Subject^7 alive ^3wins!" );
    }
    else if ( level.players.size == 1 )
    {
        level.end_teller settext( "Your ^1perishment^7 is inevitable!" );
    }
    

    level.end_teller_icon.x = 0;
    level.end_teller_icon.y = 0;
    level.end_teller_icon.alignx = "center";
    level.end_teller_icon.aligny = "center";
    level.end_teller_icon.vertalign = "user_center";
    level.end_teller_icon.horzalign = "user_center";

    level.end_teller_icon.alpha = 0;
    level.end_teller_icon.y = -10;
    level.end_teller.fontscale = 1.8;
    level.end_teller_icon.width = 25;
    level.end_teller_icon.height = 25;
    level.end_teller_icon setshader( "zombies_rank_5_ded" );

    wait 1;
    level.end_teller fadeovertime( 4 );
    level.end_teller_icon fadeovertime( 4 );
    
    level.end_teller_icon.alpha = 1;
    level.end_teller.alpha = 1;
    wait 5.5;
    level.end_teller fadeovertime( 4 );
    level.end_teller_icon fadeovertime( 4 );
    level.end_teller_icon.alpha = 0;
    level.end_teller.alpha = 0;
    wait 6;

    level.end_teller_icon destroy_hud();
    level.end_teller destroy_hud();


}
flame_fx_burning()
{
    level endon( "end_game" );

    fireHazardLoc = [];
    fireHazardLoc[ 0 ] = ( 1149.52, 161.932, 209.635 );
    fireHazardLoc[ 1 ] = ( 1628.71, 603.261, -1.89408 );
    fireHazardLoc[ 2 ] = ( 214.301, 81.6155, 47.4399 );
    fireHazardLoc[ 3 ] = ( -386.96, -485.854, -64.9316 );
    fireHazardLoc[ 4 ] = ( -685.249, 220.856, -53.1149 );
    fireHazardLoc[ 5 ] = ( -1143.53, 244.431, -48.2651 );
    fireHazardLoc[ 6 ] = ( -1648.7, 661.206, 42.2665 );
    fireHazardLoc[ 7 ] = ( -2102.93, 601.182, -45.5931 );
    fireHazardLoc[ 8 ] = ( -1003.9, 1016.6, -43.468 );
    fireHazardLoc[ 9 ] = ( -611.325, 813.347, 46.6712 );
    fireHazardLoc[ 10 ] = ( 129.452, 839.276, -67.9674 );
    fireHazardLoc[ 11 ] = ( 455.257, 905.122, -80.4949 );
    fireHazardLoc[ 12 ] = ( 337.822, -174.097, -43.5009 );

    //level.transit_fire;
    //level.nuke_fire;
    for( i = 0; i < fireHazardLoc.size; i++ )
    {
        ss = randomintrange( 0, 1 );
        if( ss == 0 )
        {
            cool_fx = level.transit_fire;
        }
        else if ( ss == 1 )
        {
            cool_fx = level.nuke_fire;
        }
        playfx( level._effect[ cool_fx ], fireHazardLoc[ i ] );
        wait randomfloatrange( 0.05, 0.1 );
    }
}

rocket_text()
{
    level endon( "end_game" );
    
    level.rocket_text = newHudElem();
    level.rocket_text.x = 0;
    level.rocket_text.y = -60;
    level.rocket_text.alignx = "center";
    level.rocket_text.aligny = "center";

    level.rocket_text.vertalign = "user_center";
    level.rocket_text.horzalign = "user_center";
    level.rocket_text.fontscale = 1.7;
    level.rocket_text.alpha = 0;
    level.rocket_text settext( "Mission failed!" );

    level.rocket_text2 = newHudElem();
    level.rocket_text2.x = 0;
    level.rocket_text2.y = -40;
    level.rocket_text2.alignx = "center";
    level.rocket_text2.aligny = "center";

    level.rocket_text2.vertalign = "user_center";
    level.rocket_text2.horzalign = "user_center";
    level.rocket_text2.fontscale = 1.5;
    level.rocket_text2.alpha = 0;

    level.rocket_text2 settext( "^3Crew^7 betrayal" );


    wait 1;
    level.rocket_text fadeOverTime( 2 );
    level.rocket_text.alpha = 1;
    wait 1;
    level.rocket_text thread text_danger(); //turn red
    level.rocket_text2 fadeovertime( 2 );
    level.rocket_text2.alpha = 1;

    wait 7;

    level.rocket_text2 fadeovertime( 2.5 );
    level.rocket_text fadeOverTime( 4 );
    level.rocket_text.alpha = 0;
    level.rocket_text2.alpha = 0;
    wait 5;

    level.rocket_text destroy_hud();
    level.rocket_text2 destroy_hud();

}

text_danger()
{
    level endon( "end_game" );
    //self endon( "activate_sq_turn" );
    r = 1;
    g = 1;
    b = 1;
    wait 1;
    while ( true )
    {
        b -= 0.05;
        g -= 0.05;
        self.color = ( 1, g, b );
        wait 0.05;
        if ( r == 1 && g <= 0.1 && g <= 0.1 )
        {
            g = 0.1;
            b = 0.1;
            self.color = ( 1, g, b );
            break;
        }
    }
}

rocket_countdown()
{
    level endon( "end_game" );
    //flag_clear( "spawn_zombies" );
    wait 1.5;
    playsoundatposition( "zmb_perks_incoming_alarm", (27.666, -2507.4, 680.2) );
    
    level thread rocket_text();
    //playsoundatposition( "vox_nuked_tbase_transmission_2", ( 0, 0, 7 )  );
    //foreach( player in level.players )
    //{
    //    player playsoundtoplayer( "vox_nuked_tbase_transmission_2", level.players[ s ] );
    //}
        
    foreach( player in level.players )
    {
        player playsound( "vox_nuked_tbase_transmission_2" );
    }
    Earthquake( 0.42, 8, ( 0,0,0 ), 2600 );
    //level.players[ 0 ] PlaySoundToPlayer( "vox_nuked_tbase_transmission_2", level.players[ 0 ] );
    //make an alias for the sound
    salias = "zmb_perks_incoming_loop";
    //fx loop
    level.killer_rocket playloopsound( "zmb_perks_incoming_loop", 2 );
    playsoundatposition( "zmb_perks_incoming_land", level.killer_rocket.origin );
    level thread fake_launch_sound();
    wait 0.5;
    //thread groundfxlaunch1();
    for ( i = 0; i < 30; i++ )
    {
        
        PlayFxOnTag( level._effect["fx_zm_nuked_exp_perk_impact_ext"], level.launchfx2, "tag_origin" );
        wait .15;
    }
    z = 2100;
    times = 7;
    speedup = 3;
    speeddown = 1.2;
    playfxontag( level._effect[ "rocket_fx" ], level.launchfx2, "tag_origin" );
    //level.launchfx2
    level.killer_rocket MoveZ( z, times, speedup, speeddown );
    wait .05;
    level.launchfx2 moveZ( z, times, speedup, speeddown );
    
    
    level.killer_rocket waittill( "movedone" );
    PlaySoundAtPosition( "zmb_perks_incoming_alarm", level.killer_rocket.origin );
    level.killer_rocket thread tilt_fall();
    //level.launchfx2 thread tilt_fall();
    level.launchfx2 moveto( ( -99.3382, -1848.51, 1110.27 ), 5, .6, 0 );

    level thread fake_launch_sound2();
    level.killer_rocket thread rocket_is_breaking_fx();
    level.killer_rocket movez( -1100, 5, 1.2, 0 );
    PlaySoundAtPosition( "nuclear_bomb", ( 0, 0, 0) );
    //playsoundatposition( "evt_exp_trasnformers_01", ( 0, 0, 2 )  );
    playsoundatposition( "amb_thunder_clap_02", ( 0, 0, 0 )  );
    
    //level.launchfx2 movez( -1100, 5, .6, 0.1 );
    level.killer_rocket waittill( "movedone" );
    //level.killer_rocket notify( "stop_tilt" );
    level._endgame_active = true;
    
    level thread do_explosion_of_rocket();
    wait 0.05;
    PlaySoundAtPosition("zmb_endgame", ( 0, 0, 0 ) );
    
    Earthquake( 0.62, 15, ( 0,0,0 ), 2600 );
    
    
    for ( t = 0; t < level.players.size; t++ )
    {
        level.players[ t ] thread set_coloring();
    }
    wait 2.4;
    level.killer_rocket delete();
    wait 0.1;
    level.launchfx2 delete();
    wait 2;
    level thread blackout_players();
    i = 0;
    while ( true )
    {
        if( isAlive( level.players[ i ] ) )
        {
            level specific_powerup_drop( "nuke", level.players[ i ].origin + vectorScale( ( 0, 0, 1 ), 2 ) );
            wait 0.1;
            break;
        }
        else
        {
            i++;
            wait 0.05;
        }
    }
    wait 2.5;
    level thread player_is_hit();
    //explosion height = 2780 ( z axis )
}

kick_joining_players()
{
    level endon( "end_game" );
    level notify( "normal_join_disabled" );
    while( true )
    {
        level waittill( "connected", player );
        kick( player getEntityNumber() );
    }
}
tilt_fall()
{
    level endon( "end_game" );
    self endon( "stop_tilt" );
    x = self.angles[ 0 ];
    y = self.angles[ 1 ];
    t = self.angles[ 2 ];
    while( true )
    {
        x += 0.5;
        self.angles = ( x, y, t );
        wait 0.05;
    }
}

rocket_is_breaking_fx()
{
    for( i = 0; i < 3; i++ )
    {
        customloc = ( self.origin - 60 );
        playFX( level._effect[ "explosion" ], customloc, "tag_origin" );
        wait randomfloatrange( 0.2, 0.6 );
    }

    for( i = 0; i < 10; i++ )
    {
        customloc2 = ( self.origin - 95 );
        playFX( level._effect[ "explosion" ], customloc2, "tag_origin" );
        wait randomfloatrange( 0.2, 0.6 );
    }
}
do_explosion_of_rocket()
{
    level endon( "end_game" );
    level._effect[ "rocket_fx" ] = loadfx( "maps/zombie/fx_zmb_trail_perk_meteor" );
    level._effect[ "explosion" ] = loadfx( "explosions/fx_zm_nuked_exp_perk_impact_ext" );

    level.explosion_locs = [];
    level.explosion_locs[ 0 ] = ( 404.182, -2509.24, 1607.01 );
    level.explosion_locs[ 1 ] = ( 175.797, -2510.01, 1594.87 );
    level.explosion_locs[ 2 ] = ( -99.3662, -2510.94, 1586.82 );
    level.explosion_locs[ 3 ] = ( -424.058, -2512.03, 1577.33 );
    level.explosion_locs[ 4 ] = ( -641.437, -2512.77, 1570.98 );
    level.explosion_locs[ 5 ] = ( -545.847, -2126.99, 1749.31 );
    level.explosion_locs[ 6 ] = ( -296.065, -2116.02, 1734.68 );
    level.explosion_locs[ 7 ] = ( 48.3446, -2054.87, 1274.75 );
    level.explosion_locs[ 8 ] = ( 319.294, -2042.96, 1042.74 );
    level.explosion_locs[ 9 ] = ( 179.724, -2220.42, 1678.39 );
    level.explosion_locs[ 10 ] = ( 1721.44, -2787.37, 3209.74 );
    level.explosion_locs[ 11 ] = ( 282.681, -3145.73, 4081.12 );
    level.explosion_locs[ 12 ] = ( -1360.75, 3202.53, 4593.56 );
    level.explosion_locs[ 13 ] = ( -2891.54, -3311.6, 6264.43 );
    level.explosion_locs[ 14 ] = ( 1138.03, -4682.79, 6179.74 );
    /*
    level.spawner_for_explosion = [];
    //level.spawner_for_rocketfx = [];

    for ( i = 0; i < level.explosion_locs; i++ )
    {
        level.spawner_for_explosion[ i ] = spawn( "script_model", level.explosion_locs[ i ]  );
        level.spawner_for_explosion[ i ] setmodel( "tag_origin" );
        
    }
    */
    level.fx1 = "rocket_fx";
    level.fx2 = "explosion";
   
    guccimane = 0;
    thread foodoora_explosion();
    for ( i = 0; i < level.players.size; i++ )
    {
        level.players[ i ] thread betrayal_explosion_visual1();
    }

    
    for( s = 0; s < 8; s++ )
    {
        level.explosion_locs = array_randomize( level.explosion_locs );
        for ( i = 0; i < /*level.spawner_for_explosion.size*/level.explosion_locs.size; i++ )
        {
            playfx( level._effect[ level.fx2 ], /*level.spawner_for_explosion.origin*/level.explosion_locs[i] );
            wait randomfloatrange( 0.05, 0.08 );
        }
    }

}

foodoora_explosion()
{
    level endon( "end_game" );

    first_end_location = [];
    first_end_location[ 0 ] = ( -226.053, -1379.72, -106.634 );
    first_end_location[ 1 ] = ( 93.5224, -1039.55, -107.755 );
    first_end_location[ 2 ] = ( 941.041, -1318.64, -136.359 );
    first_end_location[ 3 ] = ( -661.132, -2999.62, -109.5 );
    first_end_location[ 4 ] = ( 3566.15, -3761.7, -112.153 );
    first_end_location[ 5 ] = ( 1014.43, -5973.73, 113.945 );
    first_end_location[ 6 ] = ( -533.418, -292.669, -73 );

    second_end_location = [];
    second_end_location[ 0 ] = ( 1211.66, -189.88, -78.4474 );
    second_end_location[ 1 ] = ( -659.868, -204.825, -68.7154 );
    second_end_location[ 2 ] = ( -407.128, 512.425, -65.1569 );
    second_end_location[ 3 ] = ( -1887.37, 296.807, -71.7286 );
    second_end_location[ 4 ] = ( -531.931, 1018.33, -67.5856 );
    second_end_location[ 5 ] = ( 586.245, 423.378, 141.841 );
    second_end_location[ 6 ] = ( 1799.98, 412.722, -69.9933 );

    starter = [];
    starter_second = [];
    
    for( i = 0; i < first_end_location.size; i++ )
    {
        starter[ i ] = spawn( "script_model", level.killer_rocket.origin );
        starter[ i ] setmodel( "tag_origin" );
    }

    for( f = 0; f < second_end_location.size; f++ )
    {
        starter_second[ f ] = spawn( "script_model", level.killer_rocket.origin );
        starter_second[ f ] setmodel( "tag_origin" );
    }
    wait 0.2;

    for( s = 0; s < starter.size; s++ )
    {
        wait 0.05;
        playfxontag( level._effect[ level.fx1], starter[ s ], "tag_origin" );
        starter[ s ] MoveTo( first_end_location[ s ], randomfloatrange( 4, 6 ), 0.3, 0.3 );
    }

    for( a = 0; a < starter_second.size; a++ )
    {
        wait randomfloatrange( 0.05, 0.28 );
        playfxontag( level._effect[ level.fx1 ], starter_second[ a ], "tag_origin" );
        starter_second[ a ] moveto( second_end_location[ a ], randomfloatrange( 3.4, 6.3 ), randomfloatrange( 0.05, 0.6 ), randomfloatrange( 0.05, 0.1 ) );
    }

    level waittill( "forever" );
    foreach( st in starter )
    { 
        st delete();
    }

}


initiate_killer_rocket()
{
    level endon ("end_game");
    flag_wait( "initial_blackscreen_passed" );
    
    origin = (27.666, -2507.4, 680 ); //middle of the road
    level.killer_rocket = spawn( "script_model", origin );
    level.killer_rocket setModel( "p6_zm_nuked_rocket_cam" );
    angless = ( -90, -90.531, 0 ); 

    launchfxorigin = (27.666, -2507.4, -78.5302 );
    level.launchfx2 = spawn ("script_model", launchfxorigin );
    level.launchfx2 setModel ("c_zom_dlc0_zom_head3");
    fxangle = (-90, -90.531, 0);
    level.launchfx2.angles = fxangle;
    level.killer_rocket.angles = angless;
    //wait 35;

    level waittill( "do_endgame" );
    level thread rocket_countdown();

}



    

fake_launch_sound()
{
    level endon( "end_game" );

    tempangles = ( -90, -90.531, 0 );
    o1 = spawn("script_model", (444.141, -249.61, -165.923) );
    o1 setModel ("c_zom_dlc0_zom_head3");
    o1.angles = tempangles;

    o2 = spawn("script_model", ( -604.804, -267.685, -214.889 ) );
    o2 setModel ("c_zom_dlc0_zom_head3");
    o2.angles = tempangles;

    o3 = spawn("script_model", ( 289, -761.831, -187.426 ) );
    o3 setModel ("c_zom_dlc0_zom_head3");
    o3.angles = tempangles;

    o4 = spawn("script_model", ( -471.454, -740.086, -148.474 ) );
    o4 setModel ("c_zom_dlc0_zom_head3");
    o4.angles = tempangles;

    o5 = spawn("script_model",( 19.6329, -324.979, -173.521 ) );
    o5 setModel ("c_zom_dlc0_zom_head3");
    o5.angles = tempangles;

    o1 playloopsound( "zmb_perks_incoming_loop", 1 );
    wait .01;
    o2 playloopsound( "zmb_perks_incoming_loop", 2 );
    wait .05;
    o3 playloopsound( "zmb_perks_incoming_loop", 2 );
    wait .009;
    o4 playloopsound( "zmb_perks_incoming_loop", 2 );
    wait .01;
    o5 playloopsound( "zmb_perks_incoming_loop", 2 );
    
    wait 2;

    for( i = 1; i < 14; i++ )
    {   
        wait 1;
    }
    

    o1 stoploopsound( 4 );
    o2 stoploopsound( 4 );
    o3 stoploopsound( 4 );
    o4 stoploopsound( 4 );
    o5 stoploopsound( 4 );
    wait 4;
    o1 delete();
    o2 delete();
    o3 delete();
    o4 delete();
    o5 delete();
}

fake_launch_sound2()
{
    level endon( "end_game" );

    tempangles = ( -90, -90.531, 0 );
    o1 = spawn("script_model", (447.141, -269.61, -165.923) );
    o1 setModel ("c_zom_dlc0_zom_head3");
    o1.angles = tempangles;

    o2 = spawn("script_model", ( -404.804, -227.685, -214.889 ) );
    o2 setModel ("c_zom_dlc0_zom_head3");
    o2.angles = tempangles;

    o3 = spawn("script_model", ( 269, -441.831, -187.426 ) );
    o3 setModel ("c_zom_dlc0_zom_head3");
    o3.angles = tempangles;

    o4 = spawn("script_model", ( -271.454, -740.086, -148.474 ) );
    o4 setModel ("c_zom_dlc0_zom_head3");
    o4.angles = tempangles;

    o5 = spawn("script_model",( 12.6429, -464.979, -173.521 ) );
    o5 setModel ("c_zom_dlc0_zom_head3");
    o5.angles = tempangles;

    o1 playloopsound( "zmb_perks_incoming_loop", 1 );
    wait .01;
    o2 playloopsound( "zmb_perks_incoming_loop", 2 );
    wait .05;
    o3 playloopsound( "zmb_perks_incoming_loop", 2 );
    wait .009;
    o4 playloopsound( "zmb_perks_incoming_loop", 2 );
    wait .01;
    o5 playloopsound( "zmb_perks_incoming_loop", 2 );
    
    wait 2;

    for( i = 1; i < 14; i++ )
    {   
        wait 1;
    }
    

    o1 stoploopsound( 4 );
    o2 stoploopsound( 4 );
    o3 stoploopsound( 4 );
    o4 stoploopsound( 4 );
    o5 stoploopsound( 4 );
    wait 4;
    o1 delete();
    o2 delete();
    o3 delete();
    o4 delete();
    o5 delete();
}


flying_rocket_fx() //simplified rocket fx and doesnt make the sun flicker when rockets have taken off
{
    level endon( "end_game" );
    playfxontag( level._effect[ "rocket_fx" ], self, "tag_origin" );
}


groundfxlaunch1() //needs fixing, effects stay looped
{
    level endon ( "end_game" );
    
    level.groundfxcs = [];
    groundfxloc = 0;
    curFX = level.groundfxcs[ groundfxloc ];
    nimi = "fx_zm_nuked_exp_perk_impact_ext";

    
    while ( true )
    {
        level.groundfxcs[0] = (-650.306, -2767.52, -62.2977 );
        level.groundfxcs[1] = (-364.357, -2690.28, -36.2731 );
        level.groundfxcs[2] = (-42.7154, -2685.66, -35.9709 );
        level.groundfxcs[3] = (265.013, -2709.49, -37.0504 );
        level.groundfxcs[4] = (459.989, -2968.46, -69.8446 );
        level.groundfxcs[5] = (213.795, -3025.58, -22.6509 );
        level.groundfxcs[6] = (-107.664, -3039.39, -57.3907 );
        level.groundfxcs[7] = (27.1439, -2558.73, -33.089 );
        break;
    }

    for (i = 0; i < 18; i++ ) //188 if wait = 0.01
    {
        foreach ( groundfxloc in level.groundfxcs )
        {
            playfx( level._effect[ nimi ], ( groundfxloc ) );
            wait .05;
            
        }
        //wait .1; //0.01
    }
    
}



betrayal_explosion_visual1()
{
    //flag_wait( "initial_blackscreen_passed" );
    //level waittill( "initexpo_ready" );

    wait 0.8;
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
    wait 3.25;
}
