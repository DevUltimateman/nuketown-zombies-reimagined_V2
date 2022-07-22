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





main()
{
    replacefunc( ::nuked_mannequin_init, ::nuked_mannequin_init_COF );
    replacefunc( ::nuked_mannequin_filter, ::nuked_mannequin_filter_COF );
}

nuked_mannequin_init_COF() //checked partially matches cerberus output did not change
{
	keep_count = 28;
	level.mannequin_count = 0;
	destructibles = getentarray( "destructible", "targetname" );
	level.mannequins_cof = nuked_mannequin_filter_COF( destructibles );
	if ( level.mannequins_cof.size <= 0 )
	{
		return;
	}
    
    
	remove_count = level.mannequins_cof.size - keep_count;
	remove_count = clamp( remove_count, 0, remove_count );
	level.mannequins_cof = array_randomize( level.mannequins_cof );
    
	i = 0;
	while ( i < remove_count )
	{
        
		collision = getent( level.mannequins_cof[ i ].target, "targetname" );
        collision delete();
		level.mannequins_cof[ i ] delete();
		level.mannequin_count--;
        //iprintlnbold( "HEAD REMOVED" );
		i++;
	}

	level waittill( "prematch_over" );
	level.mannequin_time = getTime();

    level.fake_clip = [];
    tohit = [];
    for( i = 0; i < level.mannequins_cof.size; i++ )
    {
        wait 0.1;
        tohit[ i ] = level.mannequins_cof[ i ] gettagorigin( "tag_base_d1_head" );
        level.fake_clip[ i ] = spawn( "script_model", tohit[ i ] );
        level.fake_clip[ i ] setmodel( "tag_origin" ); 
        level.fake_clip[ i ].angles = level.mannequins_cof[ i ].angles;
        wait 0.05;
        playfxontag( level._effect[ "fx_theater_mode_camera_head_glow_yllw" ], level.fake_clip[ i ], "tag_origin" );
        level.fake_clip[ i ] thread wait_for_damage();
    }

}
wait_for_damage()
{   
    hitbox = self.origin + ( 0, 0, -4 );
    gucci = spawn( "trigger_damage", hitbox,  80, 80, 80 );
    gucci.health = 20;
    gucci setcandamage( true );
    gucci waittill( "damage", player ); 
    wait 0.2;
    level notify( "play_cac_sound" );
    playfx( level._effect[ "fx_zombie_powerup_caution_wave" ], self.origin );
    wait 0.1;
    self delete();
    gucci delete();
    
}

cac_beep_mannequin_trigger()
{
    level endon( "end_game" );
    level endon( "stop_cacs_playing" );
    while ( true )
    {
        level waittill( "play_cac_sound" );
        for ( i = 0; i < 6; i++ )
        {
            foreach( player in level.players )
            {
                player playlocalsound( "cac_cmn_beep" );
            }
            wait 0.08;
        }
        
    }
}

beep_talker()
{
    level endon( "end_game" );
    level endon( "stop_cacs_playing" );
    while ( true )
    {
        level waittill( "beep_talker" );
        for ( i = 0; i < 6; i++ )
        {
            foreach( player in level.players )
            {
                player playlocalsound( "cac_cmn_beep" );
            }
            wait 0.08;
        }
        
    }
}

nuked_mannequin_filter_COF( destructibles )
{
	level.mannequins_cof = [];
	i = 0;
    
	while ( i < destructibles.size )
	{
		destructible = destructibles[ i ];
		if ( issubstr( destructible.destructibledef, "male" ) )
		{
			level.mannequins_cof[ level.mannequins_cof.size ] = destructible;
			level.mannequin_count++;
            
		}
		i++;
	}
	return level.mannequins_cof;
}


check_mannequin_count() // replaces step 1 of ee from the original file
{
    level endon( "end_game" );
    flag_wait( "initial_blackscreen_passed" );

    while ( true )
    {
        if ( level.mannequin_count <= 0 )
        {
            level notify( "step1_completed" );
            wait 1;
            level notify( "stop_cacs_playing" );
            wait 1;
            break;
        }
        wait 1;
    }
}

lockdown_yellowhouse()
{
    level endon( "end_game" );
    
    //"openhouse2_f1_zone" //Yellow House Downstairs
    //"openhouse2_f2_zone" //Yellow House Upstairs
    flag_wait( "initial_blackscreen_passed" );

    has_used_yellow = false;

    col_locs = [];
    col_locs[ 0 ] = ( 598.674, 119.577, -56.875 ); //frontdoor
    col_locs[ 1 ] = ( 879.252, 264.758, -56.875 ); //lower mid doorway
    col_locs[ 2 ] = ( 611.856, 67.3451, 79.125 ); //upwindow
    col_locs[ 3 ] = ( 1133.1, 300.653, 79.125 ); //upperdoor backyard

    starter_fire = ( 830.146, 143.98, -17.5954 );

    col = [];

    starter_trig = spawn( "trigger_radius", starter_fire, 40, 40, 40  );
    starter_trig setCursorHint( "HINT_NOICON" );
    level thread LowerMessage( "WaitLockdown", "^1[ ^7Access denied from Test Subjects ^1]^7 \n^1[ ^7Await further instructions ^1]" );
    starter_trig setlowermessage( starter_trig, "WaitLockdown" );

    button = spawn( "script_model", starter_fire );
    button setmodel( "c_zom_dlc0_zom_haz_body2_behead" );
    button.angles = ( -90, 0, 0 );

    playfxontag( level._effect[ "fx_fire_fireplace_md" ], button, "tag_origin" );
    wait 0.1;
    playfxontag( level._effect[ "fx_elec_transformer_sparks_runner" ], button, "tag_origin" );
    
    level waittill( "can_do_lockdown" );

    level thread LowerMessage( "Custom Perks", "Hold ^3[{+activate}] ^7to initiate ^1Lockdown" );
    starter_trig setlowermessage( starter_trig, "Custom Perks" );

    count_players = 0;
    while( true )
    {
        for( i = 0; i < level.players.size; i++ )
        {
            if( level.players[ i ] isTouching( starter_trig ) && level.players[ i ] useButtonPressed() )
            {
                count_players++;
            }
            else
            {
                count_players = count_players;
            }
        }

        wait 0.05;
        if ( count_players >= level.players.size )
        {
            PlaySoundAtPosition( "zmb_vox_monkey_explode", starter_fire );
    
            level.zombie_total = 10000;
            starter_trig delete();
            button delete();
            wait 1;

            PlaySoundAtPosition( "mus_zombie_dog_start", starter_fire );
            wait 0.1;
            for( i = 0; i < level.players.size; i++ )
            {
                if ( level.players[ i ] isTouching( "openhouse2_f1_zone" ) || level.players[ i ] isTouching( "openhouse2_f2_zone" ) )
                {
                    level.players[ i ].has_used_yellow = true;
                    level.players[ i ] thread lockdown_shake();
                    level.players[ i ] thread lockdown_visuals();
                    level.players[ i ] thread lockdown_rgbh();
                }
            }

            for ( i = 0; i < col_locs.size; i++ )
            {
                col[ i ] = spawn( "script_model", col_locs[ i ] );
                col[ i ] setmodel( "collision_player_64x64x128" );
                col[ i ].angles = ( 0, 0, 0 );
                wait .1;
            }
            playsoundatposition( "vox_zmba_sam_event_magicbox_0", starter_fire ); //haha bye bye
            foreach( c in col )
            {
                playfxontag( level._effect[ "fx_zmb_nuke_fire_windblown_md" ], c, "tag_origin" );
                wait .1;
                playfxontag( level._effect[ "fx_zmb_tranzit_fire_lrg" ], c, "tag_origin" );
                wait .1;
            }
            PlaySoundAtPosition( "zmb_vox_monkey_scream", starter_fire );
            level thread lock_yellow_mannequins(); //do the mannequin flickering
            wait 90;
            level.zombie_total = undefined;
            player = get_players();   
            for ( i = 0; i < 2; i++ )
            {
                level specific_powerup_drop( "nuke", player[ i ].origin + vectorScale( ( 0, 0, 1 ), 2 ) );
                wait 0.08;
            }

            level notify( "remove_manns_yellow" );
            for( a = 0; a < level.players.size; a++ )
            {
                if ( level.players[ a ].has_used_yellow )
                {
                    level.players[ a ] notify( "stop_lockdown_shake" );
                    level.players[ a ] setclientdvar( "r_exposurevalue", 4.8 ); 
                    level.players[ a ] setclientdvar( "vc_rgbh", "0.26 0.1 0.2 0" ); 
                    wait 0.04;
                }
            }
            playsoundatposition( "mus_zombie_dog_end", starter_fire );
            foreach ( m in col )
            {
                m delete();
                wait 0.1;
            }
            level.lockdown_two = true;
            wait 2;
            break;
        }
        else if ( count_players < level.players.size )
        {
            count_players = 0;
        }
        wait 0.05;
    }
   
    
}

make_lockdown_zombies( bool )
{
    if ( bool )
    {
        level.zombie_total = 10000;
    }
    else 
    {
       // return_amount = level.round_number;
        level.zombie_total = undefined;
    }
}

lockdown_visuals()
{
    self endon( "disconnect" );
    how_light = 4.8;
    while ( true )
    {
        how_light += 0.1;
        self setclientdvar( "r_exposurevalue", how_light );
        wait 0.05;
        if ( how_light >= 7.9 )
        {
            self setclientdvar( "r_exposureValue", 7.7 );
            wait .1;
            break;
        }
    }
}

lockdown_rgbh()
{
    self endon("disconnect");
    wait 0.8;
    self setclientdvar( "vc_rgbh", "3 0.1 0.2 0" );
}

lockdown_shake()
{
    level endon("end_game");
    self endon("disconnect" );
    self endon( "stop_lockdown_shake" );
    while ( true )
    {
        Earthquake( 0.18, 10, ( 0, 0, 0 ), 2500 );
        wait 10;
    }
}

lock_yellow_mannequins()
{
    level endon( "end_game" );
    level endon( "yellow_house_man_stop" );

    all_spawnpoints = [];
    all_spawnpoints[ 0 ] = ( 665.032, 44.0541, -56.875 );
    all_spawnpoints[ 1 ] = ( 804.515, 328.212, -52.2434 );
    all_spawnpoints[ 2 ] = ( 1083.53, 150.808, 79.125 );
    all_spawnpoints[ 3 ] = ( 941.219, 409.173, 98.3167 );
    all_spawnpoints[ 4 ] = ( 607.062, 174.901, 79.125 );
    all_spawnpoints[ 5 ] = ( 710.852, 332.238, 89.1098 );
    all_spawnpoints[ 6 ] = ( 881.627, 258.645, 79.125 );
    all_spawnpoints[ 7 ] = ( 759.248, 83.8286, -56.875 );
    all_spawnpoints[ 8 ] = ( 812.397, 189.735, -56.875 );

    new_height = ( 0, 0, 120 );

    man_models = [];
    man_models[ 0 ] = ( "dest_zm_nuked_female_01_d0" );
    man_models[ 1 ] = ( "c_zom_player_cia_fb" );
    man_models[ 2 ] = ( "dest_zm_nuked_female_02_d0" );
    man_models[ 3 ] = ( "dest_zm_nuked_male_01_d0" );
    man_models[ 4 ] = ( "c_zom_player_cdc_fb" );
    
    spawnpoint = [];
    wait 0.4;
    for ( i = 0; i < all_spawnpoints.size; i++ )
    {
        randomizer = randomint( man_models.size );
        spawnpoint[ i ] = spawn( "script_model", all_spawnpoints[ i ] );
        spawnpoint[ i ] setmodel( man_models[ randomizer ] );
        spawnpoint[ i ].angles = ( 0, 0, 0 );

        spawnpoint[ i ] thread mg();
        spawnpoint[ i ] thread rotate();
        wait 0.1;
    }
    
    level waittill( "remove_manns_yellow" );
    level notify( "remove_mann_blockers" );
    foreach( lol in spawnpoint )
    {
        lol notify( "delete_me" );
        lol notify( "mg_stopper" );
        lol delete();
    }
    
}

rotate()
{
    self endon( "mg_stopper" );
    level endon( "end_game" );
    while ( true )
    {
        gucci_angles = randomint( 360 );
        self.angles = ( 0, gucci_angles, 0 );
        wait randomfloatrange( 0.2, 1.8 );
    }
}

mg()
{
    level endon( "end_game" );
    self endon( "mg_stopper" );

    bck = spawn( "script_model", self.origin );
    bck setmodel( "collision_player_32x32x128" );
    bck.angles = ( 0, 0, 0 );
    bck thread bck_remover();
    self show();
    while ( true )
    {
        
        ok = randomfloatrange( 0.3, 1.2 );
        wait ok;
        self hide();
        bck hide();
        ok2 = randomfloatrange( 0.5, 1.5 );
        wait ok2;
        self show();
        bck show();
        wait 0.02;
        playfxontag( level._effect[ "fx_theater_mode_camera_head_glow_red"], self, "tag_origin"/*"tag_base_d1_head"*/ );
        
    }
}

bck_remover()
{
    level waittill( "remove_mann_blockers" );
    wait randomfloatrange( 0.05, 0.2 );
    self delete();
}


lockdown_bluehouse()
{
    level endon( "end_game" );
    
    flag_wait( "initial_blackscreen_passed" );
    
    has_used = false;

    //"openhouse2_f1_zone" //Yellow House Downstairs
    //"openhouse2_f2_zone" //Yellow House Upstairs
    
    upper_light = ( -937.403, 456.818, 80.4723 );
    down_light = ( -791.121, 470.055, -55.875 );
    
    block_locations = [];
    block_locations[ 0 ] = ( -984.22, 697.697, -53.8474 ); //downback
    block_locations[ 1 ] = ( -1014.13, 602.847, 80.125 ); //stairsupback
    block_locations[ 2 ] = ( -541.436, 301.424, 80.125 ); //upwindow
    block_locations[ 3 ] = ( -487.071, 384.867, -54.7245 ); //downfrontdoor

    blocker = [];

    blue_starter_org = ( -631.394, 268.492, 117.264 );

    trigu = spawn( "trigger_radius", blue_starter_org, 40, 40, 40 );
    trigu setcursorhint( "HINT_NOICON" );

    level thread LowerMessage( "WaitLockdown1", "^1[ ^7Access denied from Test Subjects ^1]^7 \n^1[ ^7Await further instructions ^1]" );
    trigu setlowermessage( trigu, "WaitLockdown1" );
    

    model = spawn( "script_model", blue_starter_org );
    model setmodel( "c_zom_dlc0_zom_haz_body2_behead" );
    model.angles = ( -90, 0, 0 );

    playfxontag( level._effect[ "fx_fire_fireplace_md" ], model, "tag_origin" );
    playfxontag( level._effect[ "fx_elec_transformer_sparks_runner" ], model, "tag_origin" );
    
    level waittill( "can_do_lockdown" );

    level thread LowerMessage( "Custom Perks", "Hold ^3[{+activate}] ^7to initiate ^1Lockdown" );
    trigu setLowerMessage( trigu, "Custom Perks"  );

    are_pressed = 0;
    while( true )
    {
        for( i = 0; i < level.players.size; i++ )
        {
            if( level.players[ i ] isTouching( trigu ) && level.players[ i ] useButtonPressed() )
            {
                are_pressed++;
            }
            else
            {
                are_pressed = are_pressed;
            }
        }
        wait 0.05;

        if( are_pressed >= level.players.size )
        {
            level.zombie_total = 10000;
            PlaySoundAtPosition("zmb_vox_monkey_explode", blue_starter_org );
            trigu delete();
            model delete();
            wait 1;
            PlaySoundAtPosition( "mus_zombie_dog_start", blue_starter_org );
            wait 0.1;
            //"openhouse1_f1_zone" //Green House Downstairs
            //"openhouse1_f2_zone" //Green House Upstair
            for( s = 0; s < level.players.size; s++ )
            {
                if ( level.players[ s ] isTouching( "openhouse1_f1_zone" ) || level.players[ s ] isTouching( "openhouse1_f2_zone" ) )
                {
                    level.players[ s ].has_used = true;
                    level.players[ s ] thread lockdown_shake();
                    level.players[ s ] thread lockdown_visuals();
                    level.players[ s ] thread lockdown_rgbh();
                }
            }

            for ( i = 0; i < block_locations.size; i++ )
            {
                blocker[ i ] = spawn( "script_model", block_locations[ i ] );
                blocker[ i ] setmodel( "collision_player_64x64x128" );
                blocker[ i ].angles = ( 0, 0, 0 );
                wait .1;
            }
            wait 0.1;
            playsoundatposition( "vox_zmba_sam_event_magicbox_0", blue_starter_org ); //haha bye bye
            foreach( blo in blocker )
            {
                playfxontag( level._effect[ "fx_zmb_nuke_fire_windblown_md" ], blo, "tag_origin" );
                wait .1;
                playfxontag( level._effect[ "fx_zmb_tranzit_fire_lrg" ], blo, "tag_origin" );
                wait .1;
            }
            PlaySoundAtPosition( "zmb_vox_monkey_scream", blue_starter_org );

            level thread lock_blue_mannequins(); //do the flickering mannequins inside of the house
            
            wait 90;
            level notify( "remove_manns" );
            player = get_players();   
            level.zombie_total = undefined;
            for ( i = 0; i < 2; i++ )
            {
                level specific_powerup_drop( "nuke", player[ i ].origin + vectorScale( ( 0, 0, 1 ), 2 ) );
                wait 0.08;
            }
            for( i = 0; i < level.players.size; i++ )
            {
                if ( level.players[ i ].has_used )
                {
                    level.players[ i ] notify( "stop_lockdown_shake" );
                    level.players[ i ] setclientdvar( "r_exposurevalue", 4.8 );
                    level.players[ i ] setclientdvar( "vc_rgbh", "0.26 0.1 0.2 0" );
                    wait 0.04;
                }
            }
            playsoundatposition( "mus_zombie_dog_end", blue_starter_org );
            foreach ( blockie in blocker )
            {
                blockie delete();
                wait 0.1;
            }
            level.lockdown_one = true;
            wait 2;
            break;
        }
        
        else if ( are_pressed < level.players.size )
        {
            are_pressed = 0;
        }
        wait 0.05;
    }
    
    
}

lock_blue_mannequins()
{
    level endon( "end_game" );
    level endon( "blue_house_man_stop" );

    all_spawnpoints = [];
    all_spawnpoints[ 0 ] = ( 987.772, 479.031, 80.125 );
    all_spawnpoints[ 1 ] = ( -759.149, 492.12, 80.125 );
    all_spawnpoints[ 2 ] = ( -900.562, 702.383, 80.375 );
    all_spawnpoints[ 3 ] = ( -683.673, 326.165, 80.125 );
    all_spawnpoints[ 4 ] = ( -581.676, 516.356, 99.125 );
    all_spawnpoints[ 5 ] = ( -616.072, 584.701, -39.5446 );
    all_spawnpoints[ 6 ] = ( -639.508, 363.395, -49.843 );
    all_spawnpoints[ 7 ] = ( -871.569, 633.117, -55.875 );
    all_spawnpoints[ 8 ] = ( -924.15, 421.973, -52.0617 );
    new_height = ( 0, 0, 120 );
    
    man_models = [];
    man_models[ 0 ] = ( "dest_zm_nuked_female_01_d0" );
    man_models[ 1 ] = ( "c_zom_player_cia_fb" );
    man_models[ 2 ] = ( "dest_zm_nuked_female_02_d0" );
    man_models[ 3 ] = ( "dest_zm_nuked_male_01_d0" );
    man_models[ 4 ] = ( "c_zom_player_cdc_fb" );
    
    spawnpoint = [];
    manne_clipper = [];
    wait 0.4;
    for ( i = 0; i < all_spawnpoints.size; i++ )
    {
        randomizer = randomint( man_models.size );
        spawnpoint[ i ] = spawn( "script_model", all_spawnpoints[ i ] );
        spawnpoint[ i ] setmodel( man_models[ randomizer ] );
        spawnpoint[ i ].angles = ( 0, 0, 0 );
        spawnpoint[ i ] thread mg();
        spawnpoint[ i ] thread rotate();
        wait 0.1;  
    }

    level waittill( "remove_manns" );
    level notify( "remove_mann_blockers" );
    foreach( lol in spawnpoint )
    {
        lol notify( "delete_me" );
        lol notify( "mg_stopper" );
        lol delete();
    }
    
}


mannequin_trap_think()
{
    
    //mannequins shoot lasers or something towards each other
    flag_wait( "initial_blackscreen_passed" );
    col_loc = ( -1927.73, 687.859, -64 );
    collision = spawn( "script_model", col_loc );
    collision setmodel( "collision_player_64x64x128" );
    collision.angles = ( 0, 45, 0 );
    wait 1;
    level thread do_manne_trap_start_fx();
    spawnable_mannes = [];
    spawnable_mannes[ 0 ] = ( -1945.72, 669.931, -43.6112 ); //left manne
    spawnable_mannes[ 1 ] = ( -1880.37, 681.275, -43.7578 ); //right manne

    table_mid = ( -1916.07, 677.353, -47.7723 );

    level.trigger_switch_manne = spawn( "trigger_radius", table_mid, 30, 30, 45 );
    level.trigger_switch_manne setCursorHint( "HINT_NOICON" );
    level.trigger_switch_manne.cost = 1500;
    trap_active = false;
    level.trigger_switch_manne.in_use = false;
    level.trigger_switch_manne.active = false;

    wait .1;
    mg = [];
    mgangles = [];
    mgangles[ 0 ] = ( -4, -65, 0 );
    mgangles[ 1 ] = ( -10, -111.2, 0 );
    for ( i = 0; i < spawnable_mannes.size; i++ )
    {
        mg[ i ] = spawn( "script_model", spawnable_mannes[ i ] );
        x = randomintrange( 0, 4 );
        if ( x <= 1 )
        {
            model = "dest_zm_nuked_female_01_d0";
        }
        else if ( x >= 2 )
        {
            model = "dest_zm_nuked_female_02_d0";
        }
        mg[ i ] setmodel( model );
        mg[ i ].angles = mgangles[ i ];
        wait 0.2;
    }

    table = spawn( "script_model", table_mid );
    table setmodel( "cub_table_01" );
    table.angles = ( 8, 3, 0 );

    //headspawn
    height_to_add = table.origin + ( 5, -2, 35 );
    head_height = table.origin + ( 5, -2, 28 );

    head = spawn( "script_model", head_height );
    head setmodel( "c_zom_dlc0_zom_head2" );
    head.angles = ( -92, -160, 0 );

    playfx( level._effect[ "fx_fire_fireplace_md" ], height_to_add );

    playFXOnTag( level._effect[ "fx_theater_mode_camera_head_glow_grn" ], mg[ 0 ], "tag_base_d1_head" );
    wait 0.1;
    playFXOnTag( level._effect[ "fx_theater_mode_camera_head_glow_grn" ], mg[ 1 ], "tag_base_d1_head" );
    //level.trigger_switch_manne show();

    level thread LowerMessage( "TrapNotEnableds", "^3[ ^7Come back later ^3]" );
    level.trigger_switch_manne setLowerMessage( level.trigger_switch_manne, "TrapNotEnableds" );
    level waittill( "tell_about_traps" );
    
    level thread LowerMessage( "TACTIVE", "^2[ ^7Trap active ^2]" );
    level thread LowerMessage( "TDOWN", "^1[ ^7Trap is on a cooldown ^1]" );
    level thread LowerMessage( "ManneBuy", "^3[^7 Hold ^3[{+activate}] ^7 to activate ^3City Protectors^7 trap! ^3]^7\n^3[ ^7Cost: 1500 ^3]" );
    level.trigger_switch_manne setLowerMessage( level.trigger_switch_manne, "ManneBuy" );
    while ( true ) 
    {
        level.trigger_switch_manne waittill( "trigger", me );
        if( me in_revive_trigger() )
        {
            continue;
        }
        if ( is_player_valid( me ) )
        {
            if ( me.score >= level.trigger_switch_manne.cost )
            {
                if ( !trap_active )
                {
                    wait 0.1;
                    trap_active = true;
                    head thread manne_trap_active_spinner();
                    head thread manne_trap_floater();
                    me.score -= level.trigger_switch_manne.cost;
                    level.trigger_switch_manne setLowerMessage( level.trigger_switch_manne, "TACTIVE" );
                    play_sound_at_pos( "purchase", me.origin );
                    level.trigger_switch_manne playsound( "zmb_trap_activated" );
                    level.trigger_switch_manne.in_use = true;
                    level.trigger_switch_manne.active = true;
                    level thread deathray_laser_bluehouse(); //death ray logic/think
                    PlaySoundAtPosition( "zmb_perks_incoming_alarm", table.origin );
                }
            }
        }
        level waittill( "begin_cooldown" );
        level.trigger_switch_manne.in_use = false;
        trigger_witch.active = false;
        trap_active = false;
        head notify( "spin_manne_fx" ); //stops manne spinner & floater
        if( head.angles != ( -92, -160, 0 ) )
        {
            head.angles = ( -92, -160, 0 );
        }
        level.trigger_switch_manne setLowerMessage( level.trigger_switch_manne, "TDOWN" );
        for( i = 60; i > 0; i-- )
        {
            wait 1;
        }
        PlaySoundAtPosition( "zmb_box_poof", level.trigger_switch_manne.origin );
        level.trigger_switch_manne setLowerMessage( level.trigger_switch_manne, "ManneBuy" );
        wait 1;
    }
    
}

deathray_laser_bluehouse()
{
    level endon( "end_game" );
    

    xd = get_players()[0];
    //level.manne1 = rocket side
    //level.manne2 = crater side
    manne1_start_location = ( -13156.5, 9297.38, -142.272 );
    manne2_start_location = ( -13156.5, 9297.38, -142.272 );
    manne1_arrive_loc = (1312.98, 16565, 21388.8 );
    manne2_arrive_loc = ( -2942.73, 2508.54, 2099.91 );
    arrive_time = 12;
    
    
    level.manne1 = spawn( "script_model", manne1_start_location );
    level.manne1 setmodel( "dest_zm_nuked_female_01_d0" );
    level.manne1.angles = ( 25, 0, 0 );
    playFXOnTag( level._effect[ "fx_zmb_tranzit_marker_glow" ], level.manne1, "tag_origin" );
    wait .2;
    level.manne2 = spawn( "script_model", manne2_start_location );
    level.manne2 setmodel( "dest_zm_nuked_female_02_d0" );
    level.manne2.angles = ( 25, 0, 0 );
    playFXOnTag( level._effect[ "fx_zmb_tranzit_marker_glow" ], level.manne2, "tag_origin" );
    wait 0.1;
    playfxontag( level._effect[ "lght_marker" ], level.manne1, "tag_origin" );
    wait 0.1;
    playfxontag( level._effect[ "lght_marker" ], level.manne2, "tag_origin" );
    wait 0.3;
    playfxontag( level._effect[ "fx_zmb_tranzit_fire_med" ], level.manne1, "tag_origin" );
    playfxontag( level._effect[ "fx_zmb_tranzit_fire_med" ], level.manne2, "tag_origin" );
    level.manne1 MoveTo( manne1_arrive_loc, arrive_time, 0, 1 );
    level.manne2 Moveto( manne2_arrive_loc, arrive_time, 0, 1 );
    wait 12;
    playfxontag( level._effect[ "fx_ash_embers_up_lg" ], level.manne1, "tag_origin" );
    wait 0.05;
    playfxontag( level._effect[ "fx_ash_embers_up_lg" ], level.manne2, "tag_origin" );
    level.manne1 thread manne1_target_locs(); //manne1 nodes randomized + array remove a value
    level.manne2 thread manne2_target_locs(); //manne2 nodes randomize + array remove values
    level.manne1 thread manne1_do_search_animation(); //do mann1 anim loop
    level.manne2 thread manne2_do_search_animation(); //do manne2 anim loop
    level thread do_laser_manne1(); //target the zombies
}

manne_trap_floater()
{
    self endon( "spin_manne_fx" );
    while ( true )
    {
        self MoveZ( 2, 1, 0.3, 0.3 );
        self waittill( "movedone" );
        self MoveZ( -2, 1, 0.3, 0.3 );
        self waittill( "movedone" );
    }
}
manne_trap_active_spinner()
{
    self endon( "spin_manne_fx" );
    while ( true )
    {
        self RotateYaw( 360, 0.8 );
        wait 0.8;
    }
}
do_manne_trap_start_fx()
{
    fxspots = [];
    fxspots[ 0 ] = ( -1945.72, 669.931, -39.6112 ); //left_manne
    fxspots[ 1 ] = ( -1895.37, 681.275, -45.7578 ); //right_manne
    fxspots[ 2 ] = ( -1922-46, 689.086, -45.5123 ); //table
    for ( u = 0; u < fxspots.size; u++ )
    {
        playfx( level._effect[ "rise_burst" ], fxspots[ u ] );
        wait 0.2;
        playfx( level._effect[ "rise_billow" ], fxspots[ u ] );
        wait 0.1;
    }
}
manne_spinner()
{
    self RotateYaw( 100, 2, 0.3, 0.3 );
    self waittill("rotatedone");
    self rotateyaw( -100, 2, 0.3, 0.3 );
    self waittill("rotatedone");
    wait 0.05;
    level notify( "manne_spin_stopped" );
    
}


manne1_do_search_animation()
{
    x = 0;
    self.angles = ( 25, 0, 0 );
    first = true;
    is_increasing = false;
    slow = true;
    while ( true )
    {
        if ( first )
        {
            for( i = 0; i < 2; i++ )
            {
                x += 1;
                self.angles = ( 25, x, 0 );
                wait 0.05;
            }
            first = false;
            is_increasing = true;
        }

        if ( is_increasing )
        {
            if( slow )
            {
                for( i = 0; i < 25; i++ )
                {
                    x += 0.1;
                    self.angles = ( 25, x, 0 );
                    wait 0.1;

                }
                slow = false;
            }
            x += 3;
            self.angles = ( 25, x, 0 );
            if ( x >= 180  )
            {
                maxs = randomintrange ( 200, 240 );
                while ( maxs >= x )
                {
                    x += 3;
                    self.angles = ( 25, x, 0 );
                    wait 0.05;
                }
                wait 0.05;
                is_increasing = false;
                slow = true;
            }
        }

        if( !is_increasing )
        {
            if( smooth )
            {
                for( i = 0; i < 25; i++ )
                {
                    x -= 0.1;
                    self.angles = ( 25, x, 0 );
                    wait 0.1;
                }
                smooth = false;
            }
            
            x -= 3;
            self.angles = ( 25, x, 0 );
            if( x <= -180 )
            {
                max = randomintrange ( -200, -240 );
                while ( x >= max )
                {
                    x -= 3;
                    self.angles = ( 25, x, 0 );
                    wait 0.05;
                }
                wait 0.05;
                is_increasing = true;
                smooth = true;
            }
        }
        wait 0.05;
    }
}

manne2_do_search_animation()
{
    y = 0;
    self.angles = ( 25, 0, 0 );
    first = true;
    is_increasing = false;
    while ( true )
    {
        if ( first )
        {
            for( i = 0; i < 2; i++ )
            {
                y -= 1;
                self.angles = ( 25, y, 0 );
                wait 0.05;
            }
            first = false;
            is_increasing = true;
        }

        if ( is_increasing )
        {
            if( slow )
            {
                for( i = 0; i < 25; i++ )
                {
                    x += 0.1;
                    self.angles = ( 25, x, 0 );
                    wait 0.1;

                }
                slow = false;
            }
            y -= 3;
            self.angles = ( 25, y, 0 );
            if ( y <= -180 )
            {
                maxs = randomintrange ( -200, -240 );
                while ( y >= maxs )
                {
                    y -= 3;
                    self.angles = ( 25, y, 0 );
                    wait 0.05;
                }
                wait 0.05;
                is_increasing = false;
                slow = true;
            }
        }

        if( !is_increasing )
        {
            if( smooth )
            {
                for( i = 0; i < 25; i++ )
                {
                    x -= 0.1;
                    self.angles = ( 25, x, 0 );
                    wait 0.1;
                }
                smooth = false;
            }

            y += 3;
            self.angles = ( 25, y, 0 );
            if( y >= 180 )
            {
                max = randomintrange ( 200, 240 );
                while ( max >= y )
                {
                    y += 3;
                    self.angles = ( 25, y, 0 );
                    wait 0.05;
                }
                wait 0.05;
                is_increasing = true;
                smooth = true;
            }
        }
        wait 0.05;
    }
}

manne1_target_locs()
{
    level endon( "end_game" );
    self endon( "mn1_end" );
    targets1 = [];
    targets1[ 0 ] = ( -2027.98, -167.244, 269.563 );
    targets1[ 1 ] = ( -1200.25, 14.8674, 126.35 );
    targets1[ 2 ] = ( -2045.07, 432.831, 170.535 );
    targets1[ 3 ] = ( -1636.48, 397.911, 167.282 );
    targets1[ 4 ] = ( -1389.11, 581.56, 58.9239 );
    targets1[ 5 ] = ( -1446.59, 963.084, 69.6271 );
    targets1[ 6 ] = ( -1082.9, 804.192, 381.977 );

    for ( i = 0; i < targets1.size; i++ )
    {
        get_random_target = randomIntRange( 0, targets1.size );
        timer = randomFloatRange( 2.5, 4.2 );
        self MoveTo( targets1[ get_random_target ], timer, 0.6, 1 );
        self waittill( "movedone" );
        self thread death_ray1_manneFloat();
        ArrayRemoveIndex( targets1, get_random_target );
        level.manne1_can_shoot = true;
        wait 5;
        self notify( "stop_floating1" );
        level.manne1_can_shoot = false;
    }

    exit_loc1 = ( -11117.1, -9733.4, 400.391 );
    self MoveTo( exit_loc1, 10, 2, 0 );
    self waittill( "movedone" );
    level notify( "begin_cooldown" );
    level notify( "stop_lasers");
    wait 2;
    self delete();

}

manne2_target_locs()
{
    level endon( "end_game" );
    self endon( "mn2_end" );

    targets2 = [];
    targets2[ 0 ] = ( -1479.68, 1416.69, 172.19 );
    targets2[ 1 ] = ( -1801.42, 1089.12, 74.0463 );
    targets2[ 2 ] = ( -1677.16, 693.109, 189.476 );
    targets2[ 3 ] = ( -1540.63, 1027.24, 53.2071 );
    targets2[ 4 ] = ( -1207.88, 561.429, 298.104 );
    targets2[ 5 ] = ( -1812.35, -75.0173, 63.1321 );
    targets2[ 6 ] = ( -2246.13, 705.17, 276.604 );
    
    for ( i = 0; i < targets2.size; i++ )
    {
        get_random_target = randomIntRange( 0, targets2.size );
        timer = randomFloatRange( 2.5, 4.2 );
        self MoveTo( targets2[ get_random_target ], timer, 0.6, 1 );
        self waittill( "movedone" );
        self thread death_ray2_manneFloat();
        ArrayRemoveIndex( targets2, get_random_target );
        level.manne2_can_shoot = true;
        wait 5;
        self notify( "stop_floating2" );
        level.manne2_can_shoot = false;
    }
    exit_loc2 = ( -25337.5, 16445.8, 1068.95 );
    self MoveTo( exit_loc2, 10, 2, 0 );
    self waittill( "movedone" );
    wait 2;
    self delete(); 
}
death_ray1_manneFloat()
{
    level endon( "end_game" );
    self endon( "stop_floating1" );
    while ( true )
    {
        w = randomfloatrange( 1.3, 2 );
        self MoveZ( 35, w, .5, .5 );
        wait w;
        self moveZ( -35, w, .5, .5 );
        wait w;
    }
}

death_ray2_manneFloat()
{
    level endon( "end_game" );
    self endon( "stop_floating2" );
    
    while ( true )
    {
        w = randomfloatrange( 1.3, 2 );
        self MoveZ( 35, w, .5, .5 );
        wait w;
        self moveZ( -35, w, .5, .5 );
        wait w;
    }
}

do_laser_manne1()
{
    level endon( "end_game" );
    level endon( "stop_lasers" );

    level.playable_areas = getentarray( "player_volume", "script_noteworthy" );
    zone = "openhouse1_backyard_zone";
    while ( true )
    {
        all_zombies = getaiarray( level.zombie_team );
        foreach( death_ray_zone in level.playable_areas )
        {
            for( i = 0; i < all_zombies.size; i++ )
            {
                if( all_zombies[ i ] istouching( zone ) )
                {
                    if( isalive( all_zombies[ i ] ) )
                    {
                        in_reach = distance( level.manne1.origin, all_zombies[ i ].origin );
                        in_reach2 = distance( level.manne2.origin, all_zombies[ i ].origin );
                        if( in_reach <= 770 || in_reach2 <= 730 )
                        {
                            value = randomintrange( 0, 3 );
                            if ( value >= 2 )
                            {
                                all_zombies[ i ] thread getKilledFromDeathRay();
                                all_zombies[ i ] thread should_drop_power_up();
                            }
                            else if ( value <= 1 )
                            {
                                all_zombies[ i ] thread getKilledFromDeathRayOnlyManne2();
                                all_zombies[ i ] thread should_drop_power_up();
                            }
                        }
                        wait randomfloatrange( 0.05, 0.25 );
                    }
                    wait 0.05;
                }
            }
        }
        wait randomfloatrange( 0.1, 0.3 );
    }
}

do_laser_manne2()
{
    level endon( "end_game" );
    level endon( "stop_lasers" );

    randomcolor = [];
    randomcolor[ 0 ] = ( "raygun_mark2_upgraded_zm" );
    randomcolor[ 1 ] = ( "raygun_mark2_zm" );
    level.playable_areas = getentarray( "player_volume", "script_noteworthy" );
    while ( true )
    {
        
        all_zombies = getaiarray( level._zombie_team );
        foreach( death_ray_zone in level.playable_areas )
        {
            for( i = 0; i < all_zombies.size; i++ )
            {
                if( all_zombies[ i ] istouching( death_ray_zone ) )
                {
                    if( isalive( all_zombies[ i ] ) )
                    {
                        in_reach = distance( level.manne2.origin, self.origin );
                        if( in_reach <= 850 )
                        {
                            wait randomFloatRange( 0.1, 0.4 );
                            all_zombies[ i ] thread getKilledFromDeathRay();
                        }
                    }
                }
            }
        }
        wait randomintrange( 1, 4 );
    }
}


getKilledFromDeathRay()
{

    raycol = [];
    raycol[ 0 ] = ( "raygun_mark2_upgraded_zm" );
    raycol[ 1 ] = ( "raygun_mark2_zm" );

    lolwhich = randomintrange( 0, 1 ); //3
    wait randomFloatRange( 0.2, 0.5 );
    
    if( lolwhich >= 2 )
    {
        for( i = 0; i < 1; i++ )
        {
            to_upper = level.manne1.origin + ( 0, 0, 60 );
            g = randomIntRange( 0, raycol.size );
            magicBullet( raycol[ g ], level.manne1 getTagOrigin( "tag_base_d1_head" ), self gettagorigin( "J_SpineUpper" )  ); //level.manne2.origin
            bulletTrace(  level.manne1 getTagOrigin( "tag_base_d1_head" ), self gettagorigin( "J_SpineUpper" ), true, level.players ); //level.manne2.origin
            wait randomfloatrange( 0.05, 0.1 );
        }
        playfxontag( level._effect[ "fx_zmb_blackhole_trap_end" ], self, "tag_origin" );
        for( i = 0; i < 6; i++ )
        {
            to_upper = level.manne1.origin + ( 0, 0, 60 );
            to_upper2 = level.manne2.origin + ( 0, 0, 60 );
            g = randomIntRange( 0, raycol.size );
            
            magicBullet( raycol[ g ], level.manne1 getTagOrigin( "tag_base_d1_head" ), self gettagorigin( "J_Shoulder_RI" )  ); //level.manne2.origin
            bulletTrace(  level.manne1 getTagOrigin( "tag_base_d1_head" ), self gettagorigin( "J_Shoulder_RI" ), true, level.players ); //level.manne2.origin
            wait randomfloatrange( 0.05, 0.1 );
        }
        playfxontag( level._effect[ "fx_zmb_blackhole_trap_end" ], self, "tag_origin" );
    }
    
    else if( lolwhich <= 1 )
    {
        for( i = 0; i < 1; i++ )
        {
            to_upper = level.manne1.origin + ( 0, 0, 60 );
            to_upper2 = level.manne2.origin + ( 0, 0, 60 );
            g = randomIntRange( 0, raycol.size );
            magicBullet( raycol[ g ], level.manne1 getTagOrigin( "tag_base_d1_head" ), self gettagorigin( "j_neck" )  ); //level.manne2.origin
            bulletTrace(  level.manne1 getTagOrigin( "tag_base_d1_head" ), self gettagorigin( "j_neck" ), true, level.players ); //level.manne2.origin
            magicBullet( raycol[ g ], level.manne2 getTagOrigin( "tag_base_d1_head" ), self gettagorigin( "j_neck" )  ); //level.manne2.origin
            bulletTrace(  level.manne2 getTagOrigin( "tag_base_d1_head" ), self gettagorigin( "j_neck" ), true, level.players ); //level.manne2.origin
            wait randomfloatrange( 0.05, 0.1 );
        }
        playfxontag( level._effect[ "fx_zmb_blackhole_trap_end" ], self, "tag_origin" );
        for( i = 0; i < 6; i++ )
        {
            to_upper = level.manne1.origin + ( 0, 0, 60 );
            to_upper2 = level.manne2.origin + ( 0, 0, 60 );
            g = randomIntRange( 0, raycol.size );
            magicBullet( raycol[ g ], level.manne1 getTagOrigin( "tag_base_d1_head" ), self gettagorigin( "j_neck" )  ); //level.manne2.origin
            bulletTrace(  level.manne1 getTagOrigin( "tag_base_d1_head" ), self gettagorigin( "j_neck" ), true, level.players ); //level.manne2.origin
            magicBullet( raycol[ g ], level.manne2 getTagOrigin( "tag_base_d1_head" ), self gettagorigin( "j_neck" )  ); //level.manne2.origin
            bulletTrace(  level.manne2 getTagOrigin( "tag_base_d1_head" ), self gettagorigin( "j_neck" ), true, level.players ); //level.manne2.origin
            wait randomfloatrange( 0.05, 0.1 );
        }
        playfxontag( level._effect[ "fx_zmb_blackhole_trap_end" ], self, "tag_origin" );
    }

    //assign random forces
    x = randomintrange( 0, 2 );
    if ( x <= 1 )
    {
        i = randomintrange( 80, 130 );
        j = randomintrange( 80, 110 );
        a = randomintrange( 65, 140 );
    }
    else 
    {
        i = randomintrange(70, 110 );
        j = randomintrange( 115, 140 );
        a = randomintrange( 60, 120 );
    }
    self StartRagdoll();
    self launchragdoll( ( a, i, j ) );

    for( i = 0; i < 3; i++ )
    {
        to_upper = level.manne1.origin + ( 0, 0, 60 );
        to_upper2 = level.manne2.origin + ( 0, 0, 60 );
        g = randomIntRange( 0, raycol.size );
        magicBullet( raycol[ g ], level.manne1 getTagOrigin( "tag_base_d1_head" ) , self gettagorigin( "J_SpineUpper" )  ); //level.manne2.origin
        bulletTrace(  level.manne1 getTagOrigin( "tag_base_d1_head" ), self gettagorigin( "J_SpineUpper" ), true, level.players ); //level.manne2.origin
        magicBullet( raycol[ g ], level.manne2 getTagOrigin( "tag_base_d1_head" ), self gettagorigin( "J_SpineUpper" )  ); //level.manne2.origin
        bulletTrace(  level.manne2 getTagOrigin( "tag_base_d1_head" ), self gettagorigin( "J_SpineUpper" ), true, level.players ); //level.manne2.origin
        wait randomfloatrange( 0.05, 0.1 );
    }
    wait 2;
    if ( isalive( self ) )
    {
        self DoDamage( self.health + 500, self.origin );
    }
}

//cg_cursorhints 1,2,3
getKilledFromDeathRayOnlyManne2()
{

    raycol = [];
    raycol[ 0 ] = ( "raygun_mark2_upgraded_zm" );
    raycol[ 1 ] = ( "raygun_mark2_zm" );

    wait randomFloatRange( 0.1, 0.4 );
    
    for( i = 0; i < 1; i++ )
    {
        to_upper2 = level.manne2.origin + ( 0, 0, 60 );
        g = randomIntRange( 0, raycol.size );
        magicBullet( raycol[ g ], level.manne2 getTagOrigin( "tag_base_d1_head" ), self gettagorigin( "J_SpineUpper" )  ); //level.manne2.origin
        bulletTrace(  level.manne2 getTagOrigin( "tag_base_d1_head" ), self gettagorigin( "J_SpineUpper" ), true, level.players ); //level.manne2.origin
        wait randomfloatrange( 0.05, 0.1 );
    }
    playfxontag( level._effect[ "fx_zmb_blackhole_trap_end" ], self, "tag_origin" );

    for( i = 0; i < 6; i++ )
    {
        to_upper2 = level.manne2.origin + ( 0, 0, 60 );
        g = randomIntRange( 0, raycol.size );
        magicBullet( raycol[ g ], level.manne2 getTagOrigin( "tag_base_d1_head" ), self gettagorigin( "j_neck" )  ); //level.manne2.origin
        bulletTrace(  level.manne2 getTagOrigin( "tag_base_d1_head" ), self gettagorigin( "j_neck" ), true, level.players ); //level.manne2.origin
        wait randomfloatrange( 0.05, 0.1 );
    }
    playfxontag( level._effect[ "fx_zmb_blackhole_trap_end" ], self, "tag_origin" );
    //assign random forces
    x = randomintrange( 0, 3 );
    if ( x <= 1 )
    {
        i = randomintrange( 60, 120 );
        j = randomintrange( 80, 140 );
        a = randomintrange( 65, 120 );
    }
    else 
    {
        i = randomintrange(50, 150 );
        j = randomintrange( 69, 120 );
        a = randomintrange( 80, 140 );
    }
    
    self StartRagdoll();
    self launchragdoll( ( a, i, j ) );

    for( i = 0; i < 3; i++ )
    {
        to_upper2 = level.manne2.origin + ( 0, 0, 60 );
        g = randomIntRange( 0, raycol.size );
        magicBullet( raycol[ g ], level.manne2 getTagOrigin( "tag_base_d1_head" ), self gettagorigin( "J_Hip_LE" )  ); //level.manne2.origin
        bulletTrace(  level.manne2 getTagOrigin( "tag_base_d1_head" ), self gettagorigin( "J_Hip_LE" ), true, level.players ); //level.manne2.origin
        wait randomfloatrange( 0.05, 0.1 );
    }
    wait 2;
    if ( isalive( self ) )
    {
        self DoDamage( self.health + 500, self.origin );
    }
}

look_at_zombie()
{
    self endon( "stop_looking_zomb" );
    while ( true )
    {
        a_zoms = getAIArray( level.zombie_team );
        rand = randomintrange( 0, a_zoms.size );
        t_zom = a_zoms[ rand ];
        self LookAtEntity( t_zom );
        while ( isalive( t_zom ) )
        {
            wait 1;
        }
        if ( !isalive( t_zom ) )
        {
            self lookatentity();
        }
        wait 1;
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

    checker = randomIntrange( 0, 100 );
    if ( checker >= 95 )
    {
        chosen = randomIntRange( 0, powers.size );
        level specific_powerup_drop( powers[ chosen ], self.origin + vectorScale( ( 0, 0, 1 ), 10 ) );
    }
}


deathbuzz_yellowhouse()
{
    level endon( "end_game" );
    flag_wait( "initial_blackscreen_passed" );
    trig_org = ( 1930.74, 134.867, -65.6434 );
    level.buzz_trigger = spawn ( "trigger_radius", trig_org, 25, 25, 45 );
    level.buzz_trigger setCursorHint( "HINT_NOICON" );
    level.buzz_trigger.cost = 1000;
    level.buzz_trigger.active = false;
    level.buzz_trigger.in_use = false;
    

    wait .1;
    b_origin = trig_org + ( -15, -10, 50 ); //failsafe check after float
    button = spawn( "script_model", trig_org + ( -15, -10, 50 ) );
    button setmodel( "c_zom_dlc0_zom_head3" );
    button.angles = ( -90, 320, 0 );
    lol = trig_org + ( -15, -10, 0 );
    playfx( level._effect[ "fx_theater_mode_camera_head_glow_grn" ], lol );
    playfx( level._effect[ "fx_elec_transformer_sparks_runner" ], lol );
    playfx( level._effect[ "fx_fire_fireplace_md" ], trig_org + ( -15, -10, 2 ) ); 
    playfxontag( level._effect[ "fx_fire_fireplace_md" ], button, "j_head" );

    level thread LowerMessage( "TrapNotEnabled", "^3[ ^7Come back later ^3]" );
    level.buzz_trigger setLowerMessage( level.buzz_trigger, "TrapNotEnabled" );

    level waittill( "tell_about_traps" );
    
    level thread LowerMessage( "Trapactive", "^2[ ^7Trap active ^2]" );
    level thread LowerMessage( "Cooldown", "^1[ ^7Trap is on a cooldown ^1]" );
    level thread LowerMessage( "BuyTrap", "^5[^7 Hold ^5[{+activate}] ^7 to activate ^5Buzz Shock^7 trap! ^5]^7\n^5[ ^7Cost: 1000 ^5]" );
    level.buzz_trigger setLowerMessage( level.buzz_trigger, "BuyTrap" );

    while ( true )
    {
        level.buzz_trigger waittill( "trigger", activator );
        if( activator in_revive_trigger() )
        {
            continue;
        }
        if ( is_player_valid( activator ) )
        {
            if( activator.score >= level.buzz_trigger.cost )
            {
                if ( !level.buzz_trigger.active )
                {
                    wait 0.1;
                    activator.score -= level.buzz_trigger.cost;
                    button thread button_trap_active_spinner();
                    button thread button_trap_active_hover();
                    play_sound_at_pos( "purchase", activator.origin );
                    level.buzz_trigger playsound( "zmb_trap_activated" );
                    level.buzz_trigger.active = true;
                    level.buzz_trigger.in_use = true;
                    level thread do_deathbuzz_animation();
                    level.buzz_trigger setLowerMessage( level.buzz_trigger, "Trapactive" );
                    wait 0.1;
                }
            }
        }
        level waittill( "elec_trap_ready" );
        level.buzz_trigger setLowerMessage( level.buzz_trigger, "Cooldown" );
        button notify( "stop_button_spinner" );
        button notify( "stop_button_hover" );
        wait 0.05;
        if ( button.angles != ( -90, 320, 0 ) )
        {
            button.angles = ( -90, 320, 0 );
        }
        if ( button.origin != b_origin )
        {
            button.origin = b_origin;
        }

        for ( i = 60; i > 0; i-- )
        {
            wait 1;
        }
        PlaySoundAtPosition( "zmb_box_poof", level.buzz_trigger.origin );
        level.buzz_trigger setLowerMessage( level.buzz_trigger, "BuyTrap" );
        level.buzz_trigger.active = false;
        level.buzz_trigger.in_use = false;
    }
}

button_trap_active_spinner()
{
    self endon( "stop_button_spinner" );
    while ( true )
    {
        self rotateyaw( 360, 0.8 );
        wait 0.8;
    }
}

button_trap_active_hover()
{
    self endon( "stop_button_hover" );
    while ( true )
    {
        self MoveZ( -15, 2, 0.3, 0.3 );
        self waittill( "movedone" );
        self MoveZ( 15, 2, 0.3, 0.3 );
        self waittill( "movedone" );
    }
}

do_deathbuzz_animation()
{
    level endon( "end_game" );
    //level.elec_visuals.active = false;
    starter_locs = [];
    starter_locs[ 0 ] = ( 1382.93, 829.484, -170 );
    starter_locs[ 1 ] = ( 1042.52, 757.354, -160 );
    starter_locs[ 2 ] = ( 1243.49, 123.464, -152 );
    starter_locs[ 3 ] = ( 1530.79, 229.359, -164 );

    spike_locs = [];
    spike_locs[ 0 ] = ( 1382.93, 829.484, -70 ); // sandbox side
    spike_locs[ 1 ] = ( 1042.52, 757.354, -60 ); //sandbox garage side
    spike_locs[ 2 ] = ( 1243.49, 123.464, -52 ); //next to ramp / door
    spike_locs[ 3 ] = ( 1530.79, 229.359, -64 ); //next to mystery box


    level thread initial_deathbuzz_rubble();
    antennas = [];

    for ( i = 0; i < spike_locs.size; i++ )
    {
        antennas[ i ] = spawn( "script_model", starter_locs[ i ] );
        antennas[ i ] setmodel( "p_jun_antenna1_single" );
        x = randomIntRange( 0, 360 );
        antennas[ i ].angles = ( 0, x, 0 );
        antennas[ i ] thread boltLooper(); // blackhole fx
        antennas[ i ] thread deathbuzz_antenna_vibrate(); //antenna shaker
        wait 0.05;
        
    }
    wait 2;
    wait .1;
    for ( i = 0; i < spike_locs.size; i++ )
    {
        antennas[ i ] MoveTo( spike_locs[ i ], randomIntRange( 3, 5 ), 0, 1 );
    }
    collision = [];
    for( s = 0; s < spike_locs.size; s++ )
    {
        collision[ s ] = spawn( "script_model", spike_locs[ s ] );
        collision[ s ] setmodel( "collision_player_32x32x128" );
        collision[ s ].angles = ( 0, 0, 0 );
    }
    wait 0.2;
    elecs = [];
    elecs[ 0 ] = ( 1382.93, 829.484, -10 );
    elecs[ 1 ] = ( 1042.52, 757.354, -10 );
    elecs[ 2 ] = ( 1243.49, 123.464, -12 );
    elecs[ 3 ] = ( 1530.79, 229.359, -14 );
    
    box = [];
    for ( i = 0; i < elecs.size; i++ )
    {
        box[ i ] = spawn("script_model", elecs[ i ] );
        box[ i ] setmodel( "tag_origin" );
        box[ i ].angles = ( -90, 0, 0 );
        wait 0.05;
    }

    //spark burst origins assign for abit later part
    sprk_loc = [];
    sprk_loc[ 0 ] = ( 1382.93, 829.484, 5 );
    sprk_loc[ 1 ] = ( 1042.52, 757.354, 5 );
    sprk_loc[ 2 ] = ( 1243.49, 123.464, 4 );
    sprk_loc[ 3 ] = ( 1530.79, 229.359, 5 );

    foreach( b in box )
    {
        for ( z = 0; z < 3; z++ )
        {
            playfxontag( level._effect[ "fx_zm_elec_arc_vert" ], b, "tag_origin" );
            wait randomfloatrange( 0.3, 0.65 );
        }
    }
    level thread deathbuzz_monitor_player_in_trap();
    elec_ball_locs = [];
    elec_ball_locs[ 0 ] = ( 1382.93, 829.484, -50 );
    elec_ball_locs[ 1 ] = ( 1382.93, 829.484, -10 );
    elec_ball_locs[ 2 ] = ( 1382.93, 829.484, 40 );

    elec_ball_locs[ 3 ] = ( 1042.52, 757.354, -60 );
    elec_ball_locs[ 4 ] = ( 1042.52, 757.354, -20 );
    elec_ball_locs[ 5 ] = ( 1042.52, 757.354, 30 );

    elec_ball_locs[ 6 ] = ( 1243.49, 123.464, 12 );
    elec_ball_locs[ 7 ] = ( 1243.49, 123.464, 52 );
    elec_ball_locs[ 8 ] = ( 1243.49, 123.464, 82 );

    elec_ball_locs[ 9 ] = ( 1530.79, 229.359, -14 );
    elec_ball_locs[ 10 ] = ( 1530.79, 229.359, 34 );
    elec_ball_locs[ 11 ] = ( 1530.79, 229.359, 74 );

    movers = [];
    
    antennas[ 1 ] playSound( "zmb_meteor_activate" );
    for ( i = 0; i < antennas.size; i++ )
    {
        playfxontag( level._effect[ "fx_lf_zmb_nuke_sun" ], antennas[ i ], "tag_origin" );
        antennas[ i ] thread deathbuzz_antenna_sounds();
    }

    s = [];
    for ( f = 0; f < sprk_loc.size; f++ )
    {
        s[ f ] = spawn( "script_model", sprk_loc[ f ] );
        s[ f ] setmodel( "tag_origin" );
        s[ f ].angles = ( 0, 0, 0 );
        playFXOnTag( level._effect[ "fx_elec_transformer_sparks_runner" ], s[ f ], "tag_origin" );
        wait 0.1;
    }

    level thread deathbuzz_kill_zombies();

    for ( level.i = 0; level.i < elec_ball_locs.size; level.i++ )
    {
        
        movers[ level.i ] = spawn( "script_model", elec_ball_locs[ level.i ] );
        movers[ level.i ] setmodel( "tag_origin" );
        movers[ level.i ].angles = ( 0, 0, 0 );
        movers[ level.i ] thread elec_ball_fx(); // do monkey light on the "lines"
        get_x = randomint( 3 );
        if( get_x >= 2 )
        {
            movers[ level.i ] thread sparksrunner();
        }
        movers[ level.i ] thread elec_ball_mover(); //find random target
        movers[ level.i ] thread deathbuzz_weird_sounds();
        //movers[ level.i ] thread setCorrectMovement(); // assign value to start spot relist array
        wait 0.05;
    }

    level thread blackhole_bursts();
    level thread deathbuzz_monitor_players();
    m = []; //fx org
    m[ 0 ] = ( 1381.03, -269.061, -57.8753 );
    m[ 1 ] = ( 1257.99, 253.412, -54.4479 );
    m[ 2 ] = ( 1406.9, 443.339, -54.4372 );
    m[ 3 ] = ( 1452.36, 364.425, -57.875 );
    m[ 4 ] = ( 1373.43, 668.348, -57.875 );
    m[ 5 ] = ( 1187.86, 699.323, -57.875 );
    m[ 6 ] = ( 1203.95, 516.876, -51.240 );

    m[ 7 ] =  ( 1371.61, 310.979, -57.875 );
    m[ 8 ] =  ( 1301.85, 382.205, -57.875 );
    m[ 9 ] =  ( 1281.49, 294.883, -57.875 );
    m[ 10 ] =  ( 1151.62, 543.3, -48.8118 );
    m[ 11 ] =  ( 1271.75, 723.107, -57.875 );
    m[ 12 ] =  ( 1302.19, 613.583, -57.875 );
    je = []; //entity to spawn
    
    for ( i = 0; i < m.size; i++ )
    {
        je[ i ] = spawn( "script_model", m[ i ] );
        je[ i ] setmodel( "tag_origin" );
        je[ i ].angles = ( -90, 0, 0 );
        je[ i ] thread cullanim();
        for( v = 0; v < 7; v++ )
        {
            je[ i ].origin = je[ i ].origin + ( 0, 0, 15 );
            cust = "fx_zm_elec_arc_vert";
            playfxontag( level._effect[ cust ], je[ i ], "tag_origin" );
        
            wait 0.15;
        }
    }
    
    level thread did_it_expire();
    level waittill( "trap_expired_here" );
    foreach( mov in movers )
    {
        mov notify( "stop_elec_f" );
        mov notify( "stop_ball_mover" );
        mov notify( "weird_deathbuzz_sounds_off" );
        wait 0.05;
        mov movez( -100, 1, 0, 0 );
    }

    level notify( "deathbuzz_cooldown" ); //notify to stop checking the trigger zone
    wait 1;
    level notify( "stop_elec_visuals_players" );
    level.elec_visuals.active = false;
    foreach( n in movers )
    {
        n delete();
    }

    foreach( c in collision ) //remove collision around antennas
    {
        c delete();
        wait 0.05;
    }
    foreach( sp in s )
    {
        sp delete();
    }
    //level notify( "weird_deathbuzz_sounds_off" );

    if( !level.night_mode_active )
    {
        for( s = 0; s < level.players.size; s++ )
        {
            if( level.players[ s ] istouching( "openhouse2_backyard_zone" ) )
            {
                level.players[ s ] allowSprint( true );
                level.players[ s ] allowJump( true );
                level.players[ s ] setclientdvar( "vc_rgbh", "0.26 0.1 0.2 0" );
                level.players[ s ] setclientdvar( "r_dof_tweak", 0 );
                level.players[ s ] setclientdvar( "r_watersheetingFX_enable", 0 );
                level.players[ s ] setclientdvar( "r_poisonFX_debug_enable", 0 ); 
                level.players[ s ] setclientdvar( "vc_rgbh", "0.26 0.1 0.2 0" ); 
                level.players[ s ] setclientdvar( "vc_rgbl", "0 0 0 0" );
                level.players[ s ] setMoveSpeedScale( 1 );
            }
        }
    }
    else if( level.night_mode_active )
    {
        for( a = 0; a < level.players.size; a++ )
        {
            level.players[ a ] setclientdvar( "r_watersheetingFX_enable", 0 );
            level.players[ a ] setclientdvar( "r_poisonFX_debug_enable", 0 );
            level.players[ a ] setclientdvar( "vc_rgbh", "0 0 1 0.1" );
            level.players[ a ] setclientdvar( "vc_rgbl", "0 0 4 1" );
            level.players[ a ] setmovespeedscale( 1 );
            level.players[ a ] setclientdvar( "r_dof_tweak", 0 );
            level.players[ a ] allowSprint( true );
            level.players[ a ] allowjump( true );
        }
    }
    foreach( a in antennas )
    {
        a notify( "stop_antenna_vib" );
        a notify( "wait_antenna_sound_stop" );
        a moveZ( -200, 1, 0, 0 );
    }
    level notify( "stop_bhole_bursts" ); //stop buzz curtains around the trap
    level notify( "stop_deathbuzz_shake" ); //stop earthquake to close players
    level notify( "stop_buzz_shock" ); //for player visuals
    level notify( "stop_deathbuzz_monitor" ); //for each player loop
    level notify( "destroy_weird_sounds" );
    foreach( lol in box )
    {
        lol movez( -150, 1 );
    }
    foreach( x in je )
    {
        x movez( -120, 1 );
    }
    wait 1;

    level notify( "destroy_weird_sounds" ); //force quit out of magic sound func
    
    foreach ( r in box )
    {
        r delete();
    }
    foreach( j in je )
    {
        j delete();
    }
    foreach( as in antennas )
    {
        as notify( "stop_antenna_sound" ); //force to exit out of loop
        as delete();
    }
    level notify( "elec_trap_ready" );
}

blackhole_bursts()
{
    level endon("end_game");
    level endon( "stop_bhole_bursts" );

    blackhole_locs = [];
    blackhole_locs[ 0 ] = ( 1511.89, 334.901, -59.5725 );
    blackhole_locs[ 1 ] = ( 1499.58, 409.375, -57.875 );
    blackhole_locs[ 2 ] = ( 1486.88, 478.711, -55.972 );
    blackhole_locs[ 3 ] = ( 1453.38, 600.018, -58.1344 );
    blackhole_locs[ 4 ] = ( 1432.79, 684.153, -58.3921 );
    blackhole_locs[ 5 ] = ( 1396.36, 781.127, -70.3444 );
    blackhole_locs[ 6 ] = ( 1243.63, 796.261, -69.2657 );
    blackhole_locs[ 7 ] = ( 1153.9, 782.842, -59.1968 );
    blackhole_locs[ 8 ] = ( 1062.35, 590.602, -57.875 );
    blackhole_locs[ 9 ] = ( 1161, 488.117, -50.0125 );
    blackhole_locs[ 10 ] = ( 1177.3, 359.879, -57.875 );
    blackhole_locs[ 11 ] = ( 1212.51, 257.583, -57.0932 );
    blackhole_locs[ 12 ] = ( 1355.47, 187.51, -57.875 );
    blackhole_locs[ 13 ] = ( 1435.01, 219.709, -58.4084 );
    
    blackhole_locs[ 14 ] = ( 1393.45, 343.967, -57.875 );
    blackhole_locs[ 15 ] = ( 1351.35, 460.029, -57.875 );
    blackhole_locs[ 16 ] = ( 1281.39, 352.089, -57.875 );
    blackhole_locs[ 17 ] = ( 1319.58, 270.773, -57.875 );
    blackhole_locs[ 18 ] = ( 1239.45, 376.771, -57.875 );
    blackhole_locs[ 19 ] = ( 1163.59, 631.86, -57.875 );
    blackhole_locs[ 20 ] = ( 1264.31, 691.956, -57.875 );
    blackhole_locs[ 21 ] = ( 1289.69, 569.46, -57.875 );
    blackhole_locs[ 22 ] = ( 1265.01, 465.501, -10.2868 );
    blackhole_locs[ 23 ] = ( 1188.56, 617.519, -57.875 );

    while ( true )
    {
        //b = randomIntRange( 0, blackhole_locs.size );
        for ( b = 0; b < blackhole_locs.size; b++ )
        {
            playfx( level._effect[ "fx_zmb_blackhole_trap_end" ], blackhole_locs[ b ] );
            wait randomfloatrange( 0.1, 0.2 );
        }
        wait 0.05;
        
    }
}
elec_ball_mover()
{
    self endon( "stop_ball_mover" );
    get_node_target = [];
    get_node_target[ 0 ] = ( 1382.93, 829.484, -50 );
    get_node_target[ 1 ] = ( 1042.52, 757.354, -60 );    
    get_node_target[ 2 ] = ( 1243.49, 123.464, 12 );
    get_node_target[ 3 ] = ( 1530.79, 229.359, -14 );

    get_node_target[ 4 ] = ( 1382.93, 829.484, -10 );
    get_node_target[ 5 ] = ( 1042.52, 757.354, -20 );
    get_node_target[ 6 ] = ( 1243.49, 123.464, 52 );
    get_node_target[ 7 ] = ( 1530.79, 229.359, 34 );
    
    get_node_target[ 8 ] = ( 1382.93, 829.484, 40 );
    get_node_target[ 9 ] = ( 1042.52, 757.354, 30 );
    get_node_target[ 10 ] = ( 1243.49, 123.464, 82 );
    get_node_target[ 11 ] = ( 1530.79, 229.359, 74 );
    
    correct_start = level.i;
    to = correct_start + 1;
    self moveto( get_node_target[ to ], 1, 0, 0 );
    self waittill( "movedone" );
    for( i = to; i < get_node_target.size; i++ )
    {
        self moveto( get_node_target[ i ], 1, 0, 0 );
        self waittill("movedone");
    }
    while( true )
    {
        for ( i = 0; i < get_node_target.size; i++ )
        {
            self moveto( get_node_target[ i ], 1, 0, 0 );
            self waittill("movedone");
        }
    }
}

deathbuzz_weird_sounds()
{
    level endon( "destroy_weird_sounds" );
    x = randomint( 3 );
    if ( x <= 1 )
    {
        wait 0.2;
        self playloopsound( "zmb_meteor_loop", 1 );
    }

    level waittill( "weird_deathbuzz_sounds_off" );
    self stopLoopSound( 2 );
}

deathbuzz_antenna_sounds()
{
    self endon( "stop_antenna_sound" );
    wait 0.2;
    self playloopsound( "zmb_perks_incoming_loop", 1 );
    self waittill( "wait_antenna_sound_stop" );
    self stopLoopSound( 4 );
}
deathbuzz_monitor_players()
{
    level endon( "end_game" );
    level endon( "stop_deathbuzz_monitor" );

    while ( true )
    {
        for( i = 0; i < level.players.size; i++ )
        {
            if( level.players[ i ] istouching( "openhouse2_backyard_zone" ) )
            {
                level thread deathbuzz_shake();
                wait 15;
            }
            
        }
        wait 0.1;
    }
}

deathbuzz_kill_zombies()
{
    level endon( "end_game" );
    level endon( "deathbuzz_cooldown" );

    loc = ( 1220.34, 478.77, -60.875 );
    level.touch_trigger = spawn( "trigger_radius", loc, 2, 287, 25  );

    while ( true )
    {
        a_zom = getaiarray( level.zombie_team ); 
        for ( i = 0; i < a_zom.size; i++ )
        {
            if ( a_zom[ i ] istouching( level.touch_trigger ) )
            {
                if( isalive( a_zom[ i ] ) )
                {
                    a_zom[ i ] thread kill_zombie_in_deathbuzz();
                }
            }
        }
        wait 0.15;
    }
}

kill_zombie_in_deathbuzz()
{
    wait randomfloatrange( 0.3, 0.8 );
    pusher = randomintrange( 80, 120 );
    playfxontag( level._effect[ "fx_zmb_blackhole_trap_end" ], self, "tag_origin" );
    self thread light_zombie();
    wait randomfloatrange( 0.8, 1.6 );
    playfxontag( level._effect[ "fx_elec_transformer_sparks_runner" ], self, "j_neck" );
    self DoDamage( self.health + 666, self.origin );
    x = 20;
    if( x > randomInt( 80 ) )
    {
        self thread should_drop_power_up(); //custom callback to call a power up %
    }
    self notify( "done_lighting" );
    wait 5.5;
    self delete();
    
}

light_zombie()
{
    self endon( "done_lighting" );
    whos_origin = self.origin;
    while ( true )
    {
        playfx( level._effect[ "fx_zmb_blackshole_trap_end" ], self.origin );
        wait .5;
    }
}
deathbuzz_shake()
{
    level endon( "stop_deathbuzz_shake" );
    Earthquake( .07, 15, ( 1243.49, 123.464, -52 ), 3000 );
    wait 15;
    
}

deathbuzz_antenna_vibrate()
{
    self endon( "stop_antenna_vib" );
    while ( true )
    {
        self Vibrate( vectorscale( ( 0.6, -1, 0 ), 10 ), 0.8, 1,  3 );
        wait 3;
        self Vibrate( vectorscale( ( -0.6, 1, 0 ), 10 ), 0.8, 1,  3 );
        wait 3;
    }
    
}

deathbuzz_monitor_player_in_trap()
{
    foreach( player in level.players )
    {
        player thread deathbuzz_player_in_shock();
        wait 0.05;
    }
}
deathbuzz_player_in_shock()
{
    level endon( "end_game" );
    level endon( "stop_buzz_shock" );
    self.is_in_shock = false;
    wait 0.5;
    while ( true )
    {
        if ( self istouching( level.touch_trigger )  && !self.is_in_shock  )
        {
            wait 0.05;
            if( self istouching ( level.touch_trigger ) )
            {
                self.is_in_shock = true;
                self AllowSprint( false );
                self allowjump( false );
                self setclientdvar( "r_watersheetingFX_enable", 1 );
                self setclientdvar( "r_watersheetingFX_magnitude", 1 );
                self setclientdvar( "r_watersheetingFX_distortionScaleFactor", "0.1 0 1 0" );
                self setclientdvar( "r_poisonFX_debug_enable", 1 );
                self setclientdvar( "vc_rgbh", "0.26 0.1 7 0" );
                self setmovespeedscale( 0.4 );
            }  
        }
        
        else if ( !self istouching ( level.touch_trigger ) && self.is_in_shock )
        {
            wait 0.05;
            self.is_in_shock = false;
            self AllowSprint( true );
            self allowjump( true );
            if ( level.night_mode_active )
            {
                self setclientdvar( "r_watersheetingFX_enable", 0 );
                self setclientdvar( "r_poisonFX_debug_enable", 0 );
                self setclientdvar( "vc_rgbh", "0 0 1 0.1" );
                self setclientdvar( "vc_rgbl", "0 0 4 1" );
                //self setclientdvar( "g_speed", 196 );
                self setmovespeedscale( 1 );
            }
            else 
            {
                self setclientdvar( "r_watersheetingFX_enable", 0 );
                self setclientdvar( "r_poisonFX_debug_enable", 0 );
                self setclientdvar( "vc_rgbh", "0.26 0.1 0.2 0" );
                self setclientdvar( "vc_rgbl", "0 0 0 0" );
                //self setclientdvar( "g_speed", 196 );
                self setmovespeedscale( 1 );
            }
            
        }
        else 
        {
            self setmovespeedscale( 1 );
        }
        wait 0.05;
    }

}

initial_deathbuzz_rubble()
{
    level endon( "end_game" );

    rb_locs = [];
    rb_locs[ 0 ] = ( 1382.93, 829.484, -70 ); // sandbox side
    rb_locs[ 1 ] = ( 1042.52, 757.354, -60 ); //sandbox garage side
    rb_locs[ 2 ] = ( 1243.49, 123.464, -52 ); //next to ramp / door
    rb_locs[ 3 ] = ( 1530.79, 229.359, -64 ); //next to mystery box
    for ( i = 0; i < rb_locs.size; i++ )
    {
        playfx( level._effect[ "rise_burst" ], rb_locs[ i ] );
        wait randomfloatrange( 0.05, 0.2 );
    }

    for( u = 0; u < rb_locs.size; u++ )
    {
        playfx( level._effect[ "rise_billow" ], rb_locs[ u ] );
        wait 0.05;
    }

    wait 0.1;
    for ( s = 0; s < rb_locs.size; s++ )
    {
        playfx( level._effect[ "rise_burst" ], rb_locs[ s ] );
        wait 0.1;
    }
    level waittill( "stop_elec_visuals_players" );
    for( a = 0; a < rb_locs.size; a++ )
    {
        playfx( level._effect[ "rise_burst" ], rb_locs[ a ] );
        wait randomfloatrange( 0.1, 0.2 );
    }
}
elec_visuals_for_players()
{
    level endon( "end_game" );
    level endon( "stop_elec_visuals_players" );
    has_effect = false;
    zone = "openhouse2_backyard_zone";
    zone2 = "ammo_door_zone";
    //playa.has_used = false;
    playable_areas = getentarray( "player_volume", "script_noteworthy" );
    //players = get_players();
    wait 6.3;
    while( true )
    {
        players = get_players();
        
        for( i = 0; i < players.size; i++ )
        {
            if ( players[ i ] istouching( zone ) || players[ i ] istouching( zone2 ) )
            {
                players[ i ] setclientdvar( "vc_rgbh", "0.26 0.1 3 0.3" );
                players[ i ] setclientdvar( "r_dof_tweak", 1 );
                players[ i ] setclientdvar( "r_dof_farblur", 1 );
            }
            else if ( !players[ i ] istouching( zone ) || !players[ i ] istouching( zone2 ) ) 
            {
                players[ i ] setclientdvar( "vc_rgbh", "0.26 0.1 0.2 0" );
                players[ i ] setclientdvar( "r_dof_farblur", 0 );
                players[ i ] setclientdvar( "r_dof_tweak", 0 );
            }
            wait 0.05;
        }
        wait 1;
    }
}
boltLooper()
{
    self endon( "stop_elec_f" );
    while ( true )
    {
        playfxontag( level._effect[ "fx_zmb_blackhole_trap_end" ], self, "tag_origin" );
        wait randomfloatrange( 0.14, 0.5 );
    }
}
elec_ball_fx()
{
    self endon( "stop_elec_f" );
    wait 0.1;
    
    while ( true )
    {
        playfxontag( level._effect[ "fx_zombie_monkey_light" ], self, "tag_origin" );
        wait 14;
    }
}

sparksrunner()
{
    playfxontag( level._effect[ "fx_elec_transformer_sparks_runner" ], self, "tag_origin" );
}

did_it_expire()
{
    level endon("end_game");
    wait 30;
    level notify( "trap_expired_here" );
}

cullanim()
{
    while( true )
    {
        self rotateyaw( 360,  8, 1, 1 );
        self waittill( "rotatedone" );
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

init()
{
    if ( level.script == "zm_nuked" )
    {
        
        level thread check_mannequin_count();
        level thread lockdown_yellowhouse();
        level thread lockdown_bluehouse();
        //traps
        level thread mannequin_trap_think();
        level thread deathbuzz_yellowhouse();
        level thread cac_beep_mannequin_trigger();
        


        //call rockethivisuals
        level thread onplayerconnect();
        level thread beep_talker();
        //mannequin blocker for lockdown
        precachemodel( "collision_player_32x32x128" );

        level.zombie_ai_limit = 27; // og 24, make it more difficult
    }
}

onplayerconnect()
{
    level endon( "normal_join_disabled" );
    level endon( "end_game" );
    while( true )
    {
        level waittill( "connected", player );
        player thread rockethit_visual_orange(); 
        player thread change_cursorhints(); 
    }
    
}

change_cursorhints()
{
    self endon( "disconnect" );
    self waittill( "spawned_player" );
    self setclientdvar( "cg_cursorhints", 1 );
    level waittill( "end_game" );
    self setclientdvar( "cg_cursorhints", 4 );
}


rockethit_visual_orange()
{
    flag_wait( "initial_blackscreen_passed" );
    level waittill( "initexpo_ready" );

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
    ////////////////////////////////////////////
    ///////////////////////////////////////////

    wait 0.01;
    self setclientdvar( "vc_rgbl", "3.5 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "3.4 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "3.3 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "3.2 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "3.1 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "3 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "2.9 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "2.8 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "2.7 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "2.6 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "2.5 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "2.4 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "2.3 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "2.2 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "2.1 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "2 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "1.9 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "1.8 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "1.7 0.6 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "1.6 0.55 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "1.5 0.5 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "1.4 0.45 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "1.3 0.4 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "1.2 0.35 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "1.1 0.3 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "1 0.25 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "0.9 0.2 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "0.8 0.15 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "0.7 0.1 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "0.6 0.05 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "0.5 0.04 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "0.4 0.03 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "0.3 0.03 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "0.2 0.02 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "0.1 0.01 0 0" );
    wait 0.01;
    self setclientdvar( "vc_rgbl", "0 0 0 0" );

}

