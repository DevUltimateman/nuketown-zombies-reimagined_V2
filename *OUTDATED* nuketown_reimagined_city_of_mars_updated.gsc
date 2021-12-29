/*
    Nuketown Reimagined "City Of Mars"
    Made by Ultimateman
    June 2021 - December 2021
    Release version

    Color Codes:

    ^0 -> Black
    ^1 -> Red
    ^2 -> Green
    ^3 -> Yellow
    ^4 -> Blue
    ^5 -> Cyan
    ^6 -> Pink
    ^7 -> White
*/

//TESTING FOR SETLOWREADY FUNC INCLUDES
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
    replaceFunc( ::main_start, ::main_start_CUSTOM );
    replaceFunc( ::main_end, ::main_end_CUSTOM );
    replaceFunc( ::nuked_collision_patch, ::nuked_collision_patch_CUSTOM );
    //replaceFunc( ::survival_init, ::survival_init_CUSTOM );
}
/*
survival_init_CUSTOM()
{
    level.force_team_characters = 1;
    level.should_use_cia = 0;
    level.precachecustomchracters = maps/mp/zm_nuked(::precache_team_characters);
    level.givecustomcharacters = maps/mp/zm_nuked( ::give_team_characters );
    flag_wait("start_zombie_round_logic");
}
*/
nuked_collision_patch_CUSTOM()
{

}

main_start_CUSTOM()
{

}

main_end_CUSTOM()
{

}

perks_from_the_sky_CUSTOM()
{
	level thread turn_perks_on();
	top_height = 8000;
	machines = [];
	machine_triggers = [];
	machines[ 0 ] = getent( "vending_revive", "targetname" );
	if ( !isDefined( machines[ 0 ] ) )
	{
		return;
	}
	machine_triggers[ 0 ] = getent( "vending_revive", "target" );
	move_perk( machines[ 0 ], top_height, 5, 0.001 );
	machine_triggers[ 0 ] trigger_on();
	machines[ 1 ] = getent( "vending_doubletap", "targetname" );
	machine_triggers[ 1 ] = getent( "vending_doubletap", "target" );
	move_perk( machines[ 1 ], top_height, 5, 0.001 );
	machine_triggers[ 1 ] trigger_on();
	machines[ 2 ] = getent( "vending_sleight", "targetname" );
	machine_triggers[ 2 ] = getent( "vending_sleight", "target" );
	move_perk( machines[ 2 ], top_height, 5, 0.001 );
	machine_triggers[ 2 ] trigger_on();
	machines[ 3 ] = getent( "vending_jugg", "targetname" );
	machine_triggers[ 3 ] = getent( "vending_jugg", "target" );
	move_perk( machines[ 3 ], top_height, 5, 0.001 );
	machine_triggers[ 3 ] trigger_on();
	machine_triggers[ 4 ] = getent( "specialty_weapupgrade", "script_noteworthy" );
	machines[ 4 ] = getent( machine_triggers[ 4 ].target, "targetname" );
	move_perk( machines[ 4 ], top_height, 5, 0.001 );
	machine_triggers[ 4 ] trigger_on();
	flag_wait( "initial_blackscreen_passed" );
	wait randomfloatrange( 1, 2 );
	players = get_players();
	if ( players.size == 1 )
	{
		wait 4;
		index = 0;
		bring_perk( machines[ index ], machine_triggers[ index ] );
		arrayremoveindex( machines, index );
		arrayremoveindex( machine_triggers, index );
	}
	wait_for_round_range( 245, 246 );
	wait randomintrange( 1, 1 );
	bring_random_perk( machines, machine_triggers );
	wait_for_round_range( 245, 246 );
	wait randomintrange( 1, 1 );
	bring_random_perk( machines, machine_triggers );
	wait_for_round_range( 245, 246 );
	wait randomintrange( 1, 1 );
	bring_random_perk( machines, machine_triggers );
	wait_for_round_range( 245, 246 );
	wait randomintrange( 1, 1 );
	bring_random_perk( machines, machine_triggers );
	wait_for_round_range( 245, 246 );
	wait randomintrange( 1, 1 );
	bring_random_perk( machines, machine_triggers );
}

turn_perks_on_custom()
{
    flag_wait("initial_blackscreen_passed");
	wait 3;
	maps/mp/zombies/_zm_game_module::turn_power_on_and_open_doors();
}

bring_perk_CUSTOM()
{

}

bring_random_perk_CUSTOM()
{

}
init_nuked_perks_CUSTOM()
{
	flag_init( "perk_vehicle_bringing_in_perk" );
	structs = getstructarray( "zm_perk_machine", "targetname" );
	
	i = 0;
	while ( i < structs.size )
	{
		structs[ i ] structdelete();
		i++;
	}
	level.nuked_perks = [];
	level.nuked_perks[ 0 ] = spawnstruct();
	level.nuked_perks[ 0 ].model = "zombie_vending_revive";
	level.nuked_perks[ 0 ].script_noteworthy = "specialty_quickrevive";
	level.nuked_perks[ 0 ].turn_on_notify = "revive_on";
	level.nuked_perks[ 1 ] = spawnstruct();
	level.nuked_perks[ 1 ].model = "zombie_vending_sleight";
	level.nuked_perks[ 1 ].script_noteworthy = "specialty_fastreload";
	level.nuked_perks[ 1 ].turn_on_notify = "sleight_on";
	level.nuked_perks[ 2 ] = spawnstruct();
	level.nuked_perks[ 2 ].model = "zombie_vending_doubletap2";
	level.nuked_perks[ 2 ].script_noteworthy = "specialty_rof";
	level.nuked_perks[ 2 ].turn_on_notify = "doubletap_on";
	level.nuked_perks[ 3 ] = spawnstruct();
	level.nuked_perks[ 3 ].model = "zombie_vending_jugg";
	level.nuked_perks[ 3 ].script_noteworthy = "specialty_armorvest";
	level.nuked_perks[ 3 ].turn_on_notify = "juggernog_on";
	level.nuked_perks[ 4 ] = spawnstruct();
	level.nuked_perks[ 4 ].model = "p6_anim_zm_buildable_pap";
	level.nuked_perks[ 4 ].script_noteworthy = "specialty_weapupgrade";
	level.nuked_perks[ 4 ].turn_on_notify = "Pack_A_Punch_on";

    level.override_perk_targetname = "zm_perk_machine_override";
	random_perk_structs = [];
	perk_structs = getstructarray( "zm_random_machine", "script_noteworthy" );
	i = 0;
    
	while ( i < perk_structs.size )
	{
		random_perk_structs[ i ] = getstruct( perk_structs[ i ].target, "targetname" );
		random_perk_structs[ i ].script_int = perk_structs[ i ].script_int;
		i++;
	}
    
	level.random_perk_structs = array_randomize( random_perk_structs );
	
    i = 0;
	while ( i > 6 )
	{
		level.random_perk_structs[ i ].targetname = "zm_perk_machine_override";
		level.random_perk_structs[ i ].model = level.nuked_perks[ i ].model;
		level.random_perk_structs[ i ].blocker_model = getent( level.random_perk_structs[ i ].target, "targetname" );
		level.random_perk_structs[ i ].script_noteworthy = level.nuked_perks[ i ].script_noteworthy;
		level.random_perk_structs[ i ].turn_on_notify = level.nuked_perks[ i ].turn_on_notify;
		if ( !isDefined( level.struct_class_names[ "targetname" ][ "zm_perk_machine_override" ] ) )
		{
			level.struct_class_names[ "targetname" ][ "zm_perk_machine_override" ] = [];
		}
		level.struct_class_names[ "targetname" ][ "zm_perk_machine_override" ][ level.struct_class_names[ "targetname" ][ "zm_perk_machine_override" ].size ] = level.random_perk_structs[ i ];
		i++;
    }
}

init()
{	
	replaceFunc( ::perks_from_the_sky, ::perks_from_the_sky_CUSTOM );
    replaceFunc( ::turn_perks_on, ::turn_perks_on_custom);
    replaceFunc( ::bring_perk, ::bring_perk_CUSTOM);
    replaceFunc( ::bring_random_perk, ::bring_random_perk_CUSTOM);
    replaceFunc( ::init_nuked_perks, ::init_nuked_perks_CUSTOM );
	level.player_out_of_playable_area_monitor = 0;
	level.CurMap = getDvar( "mapname" );
    if ( level.CurMap == "zm_nuked" )
    {
        level.custom_zm_powerups_loaded = 1;
        level thread onplayerconnect();
        level.perk_purchase_limit = 6;
        level.music_override = 0;
        level.spacesongwait = 0;
        level.upgrade_in_place = 0;
        level.should_use_cia = 0;

        include_zombie_powerup( "nuke" );
        add_zombie_powerup( "nuke", "zombie_bomb", &"ZOMBIE_POWERUP_NUKE", ::func_should_always_drop, 0, 0, 0, "misc/fx_zombie_mini_nuke_hotness" );
        powerup_set_can_pick_up_in_last_stand("nuke", 1);

        //Precache models just in case of a missing model entity.
        /////////////////////////////////////////////////////////
        precacheModel	( "c_zom_dlc0_zom_haz_body1" );
        precacheModel   ( "c_zom_dlc0_zom_haz_body1_g_llegspawn" );
        
                    
        precacheModel   ( "c_zom_dlc0_zom_sol_body1" );
        precacheModel   ( "c_zom_player_cdc_fb" );
        precacheModel   ( "c_zom_player_cia_fb" );
        precacheModel   ( "com_pipe_break_256_metal" );
        precacheModel   ( "cub_table_01" );
        precacheModel   ( "defaultactor" );
        //precacheModel            ( "dest_electrical_transformer01_d0" );
        //precacheModel            ( "dest_electrical_transformer02_d0" );

        preCacheModel ( "dest_electrical_transformer01_d0" );
        preCacheModel ( "dest_electrical_transformer02_d0" );
        preCacheModel ( "dest_zm_nuked_female_01_d0" );
        preCacheModel ( "p6_zm_wood_fence_double_01b" );
        
        
        preCacheModel ( "p6_zm_slate_shingles_128_b" );
        preCacheModel ( "p6_zm_slate_shingles_128_a" );
        preCacheModel ( "p6_zm_deck_stairs" );
        //precacheModel            ( "dest_zm_nuked_female_01_d0" );
        precacheModel ( "fx_cube_createfx" );
        precacheModel ( "mlv_cub_table_01" );
        precacheModel ( "mlv_iw_debris_wood_shard_med" );
        precacheModel ( "mlv_p_glo_powerline_tower" );
        precacheModel ( "mlv_p_glo_electrical_transformer" );
        precacheModel ( "mlv_p_glo_rock_fp_large01b" );
        precacheModel ( "mlv_p_glo_rock_fp_large02" );
        precacheModel ( "mlv_p_glo_rubble_small_rocks" );
        precachemodel( "collision_player_64x64x128" );
                    
        precacheModel ( "mlv_p_jun_roof_vent" );
        precacheModel ( "mlv_p_jun_antenna1_single" );
        precacheModel ( "mlv_p6_angola_technical_rocks_clump" );
        precacheModel ( "mlv_p6_rocks_desert_01c" );
        precacheModel ( "mlv_p6_zm_door_brown" );
        precacheModel ( "mlv_p6_zm_door_white" );
        precacheModel ( "mlv_p6_zm_foliage_hedge_boxy_01" );
        precacheModel ( "mlv_p6_zm_foliage_hedge_boxy_01_pristine" );

        precacheModel ( "mlv_p6_zm_foliage_hedge_boxy_02" );
        precacheModel ( "mlv_p6_zm_foliage_hedge_rounded_01" );
        precacheModel ( "mlv_p6_zm_foliage_hedge_rounded_01_prestine" );
        precacheModel ( "mlv_p6_zm_nuked_armoire" );
        precacheModel ( "mlv_p6_zm_nuked_barbwire_barricade" );
        precacheModel ( "mlv_p6_zm_nuked_bed" );
        precacheModel ( "mlv_p6_zm_nuked_couch_01" );

                        //level.models[34] = ( "NEXT LIST = p6 MODELS / DNT SPAWN THIS" );
        precacheModel ( "mlv_p6_zm_nuked_rock_clump_02" );
        precacheModel ( "mlv_p6_zm_nuked_rock_clump_01" );
        precacheModel ( "mlv_p6_zm_nuked_townsign" );
        precacheModel ( "mlv_p6_zm_openhouse1_roof_clump" );
        precacheModel ( "mlv_p6_zm_openhouse1_stairs_boards_clump" );
        precacheModel ( "mlv_p6_zm_openhouse2_garage_clump" );
        precacheModel ( "mlv_p6_zm_refrigerator_red" );
        precacheModel ( "mlv_p6_zm_rock_clump_04" );
        precacheModel ( "mlv_p6_zm_ripple_02_clump" );
        precacheModel ( "mlv_p6_zm_white_fence_64_01" );
        precacheModel ( "mlv_p6_zm_wood_fence_trav_01" );
        precacheModel ( "mlv_t5_foliage_shrub_desert02" );
        precacheModel ( "mlv_t5_foliage_tree_burnt05" );
        precacheModel ( "mlv_veh_t6_dlc_schoolbus_dead" );
        precacheModel ( "mlv_veh_t6_dlc_movingtruck_zmb" );
        precacheModel ( "p_dest_bicycle01_body" );
        precacheModel ( "p_glo_rock_fp_large02" );
        precacheModel ( "p_jun_antenna1_single" );
        precacheModel ( "p_jun_powerpole_transformer_ornate" );

        precacheModel ( "p_lights_fluorescent_tube_fixture_on" );
        precacheModel ( "p_rus_chainlink_fence" );
        precacheModel ( "p_us_powerpole" );
        precacheModel ( "p6_angola_technical_rocks_clump" );
        precacheModel ( "p6_rocks_desert_01_large" );
        precacheModel ( "p6_zm_cratepile" );

        precacheModel ( "p6_zm_flathouse_clump" );
        precacheModel ( "p6_zm_nuked_bunker" );
        precacheModel ( "p6_zm_nuked_clocktower_frame" );
        precacheModel ( "p6_zm_nuked_floodlight_a" );
        precacheModel ( "p6_zm_nuked_painting_large_03" );
        precacheModel ( "p6_zm_nuked_streetsign" );
        precacheModel ( "p6_zm_nuked_street_lights_bent_off" );
        precacheModel ( "p6_zm_nuked_vista_bushes01_clump" );
        precacheModel ( "p6_zm_openhouse2_shed02_clump" );
        precacheModel ( "p6_zm_rocks_rubble_clump_256" );
        precacheModel ( "p6_zm_white_fence_6_01" );
                        
                        
        precacheModel ( "veh_t6_dlc_m35_low" );
        preCacheModel ( "collision_clip_512x512x10" );
        precachemodel ( "collision_player_512x512x10" );

        precachemodel ( "p_rus_mountain_desert_b" );

        precachemodel ("test_macbeth_chart_unlit");
        precachemodel ("t5_foliage_shrub_desert_set1");
        precachemodel ("machbeth_chart");
        precachemodel ("p6_zm_nuked_rocket_cam");

        precachemodel ("c_zom_dlc0_zom_head3");
        
        preCacheModel ("p_glo_electrical_insulator01");
        preCacheModel ("p_glo_powerline_tower");
        preCacheModel ("gp_glo_powerline_tower");
        preCacheModel ("collision_wall_128x128x10_standard");
        

        precachemodel ("collision_clip_64x64x10");
        precachemodel ("collision_clip_64x64x128");
        precachemodel ("collision_clip_64x64x256");
        precachemodel ("collision_clip_32x32x128");
        precachemodel ("collision_clip_256x256x10");
        precachemodel ("collision_clip_128x128x10");
        
        precachemodel( "zombie_vending_jugg" );
		precachemodel( "zombie_vending_jugg_on" );
   	 	precachemodel("t6_wpn_smg_ak74u_world");
   		precachemodel( "zombie_vending_marathon" );
		precachemodel( "zombie_vending_marathon_on" );
		precachemodel( "zombie_vending_revive" );
		precachemodel( "zombie_vending_revive_on" );
		precachemodel( "zombie_vending_sleight" );
		precachemodel( "zombie_vending_sleight_on" );
		precachemodel( "zombie_vending_doubletap2" );
		precachemodel( "zombie_vending_doubletap2_on" );
		precachemodel( "zombie_vending_ads" );
		precachemodel( "zombie_vending_ads_on" );
		precachemodel( "p6_anim_zm_buildable_pap" );
		precachemodel( "p6_anim_zm_buildable_pap_on" );
		
		preCacheRumble("damage_heavy");

        //FOR TELEPORT STUFF
        
        thread goToHeaven( ( 848.399, 602.883, -56.875 ), ( 51291.4, -139693, 89389.1 ), ( 59975.7, 142321, 88737.5 ), ( 848.399, 900.883, -46.875 )  );
        
        level thread setCustomModel();
        precache_fx();

        //level thread testingFX(); //commented out 13/12/2021

        level thread lampFires(); 
        //level thread risingsmokefxs();

        level thread darksmokes(); //fxlrg black smoke, savupiipussa ja muutama out of map
        //level thread randomfiresanddust();

        /////////////////////////////////////
        //level thread morefire(); //THIS NEEDS TO GET DELETED, ONLY LEAVE NECESSARY FXS IN 
        //JOB FOR TOMMOROW,  ^^^^^^^^^^^^^

        //bent tower flame fx
        level thread towerFX();
        level thread spawnRocketTowers();
        level thread all_rockets();
        level thread spawnfloormodel();
        level thread spawnfloors4();
        level thread spawnfloorsbeforeperks();
        level thread spawnperkplatform();
        level thread runSpaceDebris();
        //pap location debris
        level thread papDebris();
        level thread init_perks_sky();
        //elevators in space
        level thread spawnelevator1();
        level thread spawnelevator2();
        level thread spawnelevator3();
        //new stuff below
        level thread spawnNewMainPlatforms();
        level thread spawnfloorgates();  
        //space fxs
        level thread spawnSpaceEmbers();
        level thread skyPlatformLights(); 
        level thread floatingSpaceAmbers(); 

        level thread remainingHeavenFX(); 
        level thread intro_screen();
        
        //level thread RemovePerks();
        
        //vector for x * x
        vector_scal();

        //bunker stuff
        //bunker threads have been moved into the bunkerteleport function & will be called from there.
        level thread bunkerteleport();
        //level thread nukeCores();
        level thread spawnLampHolders();
        level thread weaponTracerUpgrade();

        //debug when crash occurs
        //level thread debugCrash();
        //register custom callback
        if( getdvar( "mapname" ) == "zm_nuked" ) //custom death call back for headshot step & soul collector step
        {
            register_zombie_death_event_callback( ::Custom_death_callback );
        }
        level thread ee_step1();
        level thread ee_step2();
        level thread ee_step3();
        level thread ee_step4();
        
        //Update Fixes
        level thread BunkerZombieFix();

        level.kill_box_active = 0;
        level thread teleportBunkerBlock();
        
        //custom hud round counter by ZECxR3ap3r, modified by Ultimateman
        level thread CustomRoundNumber();
        flag_clear( "spawn_zombies" );
        flag_wait( "start_zombie_round_logic" );
        level notify("end_round_think");
        wait 1;
        level thread round_think();
        //Remove the Perk Vehicle
    }
}

BunkerZombieFix()
{
	flag_wait("initial_blackscreen_passed"); //Great fix by zecxR3ap3r
	//First Exploit
	zombie_trigger_origin = ( 881.238, 340.372, -52.0168 );
	zombie_trigger_radius = 180;
	zombie_trigger_height = 180;
	player_trigger_origin = ( 871.213, 834.678, -68.3978 );
	player_trigger_radius = 350;
	zombie_goto_point = ( 1161.09, 468.895, -53.413 );
	level thread path_exploit_fix_mew( zombie_trigger_origin, zombie_trigger_radius, zombie_trigger_height, player_trigger_origin, player_trigger_radius, zombie_goto_point );
	zombie_trigger_origin2 = ( 1161.09, 468.895, -53.413 );
	zombie_trigger_radius2 = 50;
	zombie_trigger_height2 = 50;
	player_trigger_origin2 = ( 871.213, 834.678, -68.3978 );
	player_trigger_radius2 = 350;
	zombie_goto_point2 = ( 1003.13, 846.714, -94.4934 );
	level thread path_exploit_fix_mew( zombie_trigger_origin2, zombie_trigger_radius2, zombie_trigger_height2, player_trigger_origin2, player_trigger_radius2, zombie_goto_point2 );
	//Second Exploit
	level.zombietriggergarage2 = spawn( "trigger_radius", (831.109, 576.997, -56.875), 9, 160, 160 );
	level.zombietriggergarage2 setteamfortrigger( level.zombie_team );
	while ( 1 )
	{
		level.zombietriggergarage2 waittill( "trigger", who );
		who dodamage( who.health + 666, who.origin);
		spawner = random( level.zombie_spawners );
		spawn_point = level.zombie_spawn_locations[ randomint( level.zombie_spawn_locations.size ) ];
		ai = spawn_zombie( spawner, spawner.targetname, spawn_point );
	}
}

path_exploit_fix_mew( zombie_trigger_origin, zombie_trigger_radius, zombie_trigger_height, player_trigger_origin, player_trigger_radius, zombie_goto_point )
{
	level endon("spawn_teleport_fx");
	spawnflags = 9;
	zombie_trigger = spawn( "trigger_radius", zombie_trigger_origin, spawnflags, zombie_trigger_radius, zombie_trigger_height );
	zombie_trigger setteamfortrigger( level.zombie_team );
	while ( 1 )
	{
		zombie_trigger waittill( "trigger", who );
		if ( !is_true( who.reroute ) )
		{
			who thread exploit_reroute( zombie_trigger, player_trigger_origin, player_trigger_radius, zombie_goto_point );
		}
	}
}

stop_ai()
{
    level endon("end_game");
    flag_wait("initial_blackscreen_passed");
    if ( level.round_number <= 1 )
    {   
        foreach( player in level.players )
        {
            player setClientDvar("g_ai", 0 );
        }
    }
    wait 15;
    foreach ( player in level.players )
    {
        player setClientDvar("g_ai", 1 );
    }

}
onplayerconnect() //when player connects // keeps looping this stuff
{
	while ( true )
	{
		
		level waittill( "connected", player );
        player thread onplayerspawned();
		player thread spawn_if_round_one();
		
		player thread load_visuals();
		player thread never_run_out_of_breath();
        player thread fadecrosshairOnJump();
        player thread levelragdoll();
        player thread staticPhaseText();
        player thread printSaveInfo();
        player thread pAnglesOnSpawn();
        player thread monitorangles();

	}
}

onplayerspawned()
{
	self endon( "disconnect" );
    level endon( "end_game" );
    self.firstSpawn = true;
    while( true )
    {
        self waittill( "spawned_player" );
		
		if ( self.firstSpawn )
		{
			self.score = 500;
            self.firstSpawn = false;
		}
        wait .1;
        self.perk_reminder = 0;
        self.perk_count = 0;
        self.num_perks = 0;
        self thread perkboughtcheck();
		never_run_out_of_breath();
    }
}

disable_crosshair()
{
    level endon("end_game");
    self endon("disconnect");

    self waittill("spawned_player");
    wait 9;
    self setClientDvar("cg_crosshairalpha", 0 );
}

all_rockets()
{
    level endon("end_game");

    flag_wait("initial_blackscreen_passed");
    level thread rocket1(); //intro rocket
    level thread rocket2(); //intro rocket
    level thread rocket3(); //ee rocket
    level thread rocketTowers(); //tower locs
    level thread rockettowerlights(); // tower lights
    
}
Custom_death_callback( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, boneindex ) 
{
    
    if ( isDefined( self ) && isDefined( self.damagelocation ) && isDefined( self.damagemod ) && isDefined( self.damageweapon ) && isDefined( self.attacker ) && isplayer( self.attacker ) )
	{
		if ( is_headshot( self.damageweapon, self.damagelocation, self.damagemod ) )
		{
			level.headshots_ee1++;
            //iPrintLnBold( "^2Current level headshot count: ^7" + level.headshots_ee1 );
		}
	}

    if ( level.kill_box_active )
    {
        if ( distance ( level.kill_box.origin, self.origin ) <= 350 )
        {
            self zombie_souls( level.kill_box.origin );

            level.kill_box_kills++;

            if ( level.kill_box_kills_needed <= level.kill_box_kills )
            {
                wait 2;
                level notify ( "soul_step1_done" );
                wait .3;
                level.kill_box delete();
                level.kill_box_active = 0;
            }
        }
    }
}

monitorangles()
{
    self endon("disconnect");
    level endon("game_ended");

    self waittill("spawned_player");
    while ( true )
    {
        self iprintln("^3Angles: ^2" + self.angles + "\n^3Origin: ^1" + self.origin );
        wait 1;
    }
}

finish_killbox1() //fx and sound for doing finsihing bunker step 4
{
    level endon( "end_game" );

    fxpos = ( -1317.53, 1088.42, 59 );
    PlaySoundAtPosition("zmb_perks_incoming_land", fxpos );
    wait 0.05;
    playfx( level._effect[ "fx_zm_nuked_exp_perk_impact_ext" ], fxpos );
}

ee_step1()
{
    /* GOAL: PLAYERS MUST GET 40 HEADSHOTS IN TOTAL
        TO SPAWN IN A FLOATING HEAD INSIDE OF BLUE GARAGE
    */
    level endon( "end_game" );
    flag_wait("initial_blackscreen_passed");
    
    //count
    level.headshots_ee1 = 0;

    while ( true )
    {
        max_head = 40 - level.headshots_ee1; 
        
        if ( max_head == 0 )
        {
            level notify("step1_completed");
            break;
        }
        wait 0.1;
    }
    
}

ee_step2()
{
    /* GOAL: ONE OF THE PLAYERS MUST PICK UP THE FLOATING HEAD FROM THE GARAGE
        AND THEN BRING IT BACK TO THE BUNKER TO INITATE 3RD STEP
    */
    level endon("end_game");
    //level endon( "" );
    level waittill( "step1_completed" );

    //randomize location
    getHeadSpawn = randomintrange ( 1, 5 );
    
    if ( getHeadSpawn <= 1 )
    {
        location = ( -873.572, 171.989, -20 );
        trigloc = ( -873.572, 171.989, -55 );
    }
    if ( getHeadSpawn == 2 ) 
    {
        location = ( 657.857, 174.608, 102.125 ); 
        trigloc = ( 657.857, 174.608, 79.125  );
    }
    
    if ( getHeadSpawn > 2 ) 
    {                                           
        location = ( 1224.3, 1027.9, -75 ); 
        trigloc = ( 1224.3, 1027.9, -79 );
    }

    mangles = ( -90, 0, 0 );

    boom = "fx_zombie_powerup_caution_wave";
    m = "fx_zombie_monkey_light";

    floatingHead = spawn("script_model", location );
    floatingHead setModel ( "c_zom_dlc0_zom_head3" );
    floatingHead.angles = mangles;
    floatingHead thread ee_step2_playLight();
    wait .1;
    floatingHead thread ee_step2_move_head(); 
    floatingHead thread ee_step2_rotate_head(); 
    
    headTrig = spawn ( "trigger_radius", trigloc, 26, 26, 55 );
    headTrig setCursorHint( "HINT_NOICON" );

    while ( true )
    {
        headTrig waittill( "trigger", player );

        foreach( player in level.players )
        {
            is_close = distance( player.origin, trigloc );
        

            if ( player useButtonPressed() && is_close < 40 )
            {
                headTrig delete();
                playsoundatposition( "zmb_box_poof", floatingHead.origin );
                wait .05;
                playFXOnTag( level._effect[ boom ], floatingHead, "tag_origin" );
                wait 0.09;
                floatingHead delete(); //debug tommorow
                level notify( "stop_ee2_light" );
                level notify( "stop_mov_ee2" );
                level notify( "head_spin_off" );
                level notify( "step2_completed" );

                break;
            }
        }
        wait .05;
    }
}

ee_step3() //bring the head back in front of bunker & game then spawns in a souls collector
{
    level endon("end_game");
    
    flag_wait("initial_blackscreen_passed");
    wait 2;
    rStick = ( -1308.97, 992.37, 6.765 );
    lStick = ( -1386.97, 1018.9, 6.765 );
    tilt = ( -180, 0, 0 );

    //stick spark
    sparkie = "fx_mp_elec_spark_burst_xsm_thin_runner";
    ///////////////////////////////////////////////
    //STICK WHERE HEADS GET ATTACHED ON
    rightStick = spawn( "script_model", rStick );
    rightStick setModel( "p_jun_antenna1_single" );
    rightStick.angles = tilt;
    
    leftStick = spawn( "script_model", lStick );
    leftStick setModel( "p_jun_antenna1_single" );
    leftStick.angles = tilt;

    //play sparks on sticks
    playFXOnTag( level._effect[ sparkie ], leftStick, "tag_origin" );
    wait .1;
    playFXOnTag( level._effect[ sparkie ], rightStick, "tag_origin" );

    level waittill( "step2_completed" );
    ///////////////////////////////////////////////
    //soul heads
    rOrg = ( -1308.97, 992.37, -4.66273 );
    lOrg = ( -1386.97, 1018.9, -4.66273);
    zHead1 = spawn( "script_model", rOrg );
    zHead2 = spawn( "script_model", lOrg );
    zHead1 setModel( "c_zom_dlc0_zom_head3" );
    zHead2 setModel( "c_zom_dlc0_zom_head3" );
    zHead1.angles = ( -90, 155, 0 );
    zHead2.angles = ( -90, 180, 0 );
    zHead1 hide();
    zHead2 hide();
    level thread ee_step3_monitor_head();
    level waittill( "close_enough_head" );
    zHead1 show();
    zHead2 show();
    wait .1;
    level notify( "monitor_done" );
    level notify( "heads_placed" );
}

ee_step4()
{
    /* GOAL: FEED THE MANNEQUIN WITH  ZOMBIE SOULS
        SOUL CAP = 45;
        ENABLE BUNKER TELEPORTATION TO PERK HEAVEN AFTER THIS
    */
    level endon ( "end_game" );
    level waittill( "heads_placed" );

    //head fires and ground fires
    level thread bunkerHeadFire();
    //script model for pandora light
    fake1loc = ( -1326.69, 1069.13, -70.7255 );   
    fake1 = spawn("script_model", fake1loc );
    fake1 setModel("c_zom_dlc0_zom_head3");
    fake1.angles = ( -90, 0, 0 );
    wait .3;
    fake2loc = ( -1338.26, 1117.13, -104.300 );   
    fake2 = spawn("script_model", fake2loc );
    fake2 setModel("c_zom_dlc0_zom_head3");
    fake2.angles = ( -90, 0, 0 );
    wait .5;
    fake3loc = ( -1281.88, 1090.13, -110.045 );   
    fake3 = spawn("script_model", fake3loc );
    fake3 setModel("c_zom_dlc0_zom_head3");
    fake3.angles = ( -90, 0, 0 );

    wait 5;
    //z = -
    manLoc = ( -1351.93, 995.822, -63.8435 );

    //explode before spawning mannequin
    temp = spawn ("script_model", manLoc );
    temp setModel( "tag_origin" );

    playfxontag( level._effect["fx_zm_nuked_exp_perk_impact_ext" ], temp, "tag_origin" );
    wait .05;
    playsoundatposition( "zmb_endgame", manLoc );
    thread shakeplayers();
    wait .1;

    //spawn mannequin inside of the explosion
    mannequin = spawn( "script_model", manLoc );
    mannequin setModel( "dest_zm_nuked_female_01_d0" );
    mannequin.angles = ( 0, -115 ,0 );
    wait .1;
    playfxontag( level._effect[ "lght_marker" ], fake1, "tag_origin" );
    wait .1;
    playfxontag( level._effect[ "lght_marker" ], fake2, "tag_origin" );
    wait .1;
    playfxontag( level._effect[ "lght_marker" ], fake3, "tag_origin" );
    
    wait .1;
    mannequin thread manne_fx();
    wait 1;
    newLoc = ( -1317.53, 1088.42, 59 );
    mannequin MoveTo( newLoc, 3, 1, 1 );
    temp thread removedirt(); //remove dirt patch quickly after spawning the explosion
    wait 4;
    mannequin thread manneFloat(); //float mannequing
    mannequin thread manneVib(); // vibrate mannequin
    wait 1;
    level thread ee_step4_teleport_fxs();
    /*
    foreach( player in level.players )
    {
        iPrintLnBold( "^1 KILL BOX CHALLENGE STARTED" );
    }
    */
    mannequin thread startKillBox();
    level waittill( "soul_step1_done" );
    level thread finish_killbox1(); //fx and sonunds for completion

    //delete pandora lights that were tagged to zombie heads inside of the bunker
    fake1 delete(); 
    fake2 delete();
    fake3 delete();
    
    //marlton bunker fx active
    level thread bunker1fx();
    /*
    iprintln("^2 STEP DONE STEP DONE STEP DONE NOW" );
    */
    wait 1;
    level notify( "spawn_teleport_fx" ); //enable teleport bunker fxs

    //spawn in the teleport bunker fx & make it usable

    

}

removedirt()
{
    level endon( "end_game" );
    wait 3;
    self delete();
}

ee_step4_teleport_fxs()
{
    level endon( "end_game" );
    level waittill( "spawn_teleport_fx" );

     //powerupflash
    thread playbunkerflash();
    wait .2;
    //spark shower
    thread playbunkersparks();
    //elec arcs pt.1
    thread playbunkerelecs();
    //bunker light models
    thread bunkerLightTags();
    //bunker light pole
    thread playbunkerelevatorfx();
    
    wait 1;
    //-90z pipe's fxs
    thread bunkerPipeSparks();
    //pap lights on entrance
    thread bunkerPapLights();
    //elec arcs pt.2
    thread bunkerAntennaArcs();
    //ambers
    thread bunkerAmbers(); //need to enable later

    thread bunkerSlapSound();
    wait .5;
    thread bunkerClockSound();

    wait 1;
    //bottom pap light for bunk
    thread bunkerBottomLight();
    //shake player when close to bunker
    thread bunkerEarthQuake();

    //traphole fx
    thread bunkerPoleFlash();
}

teleportBunkerBlock()
{
    level endon( "end_game" );
    level waittill( "initial_blackscreen_passed" );

    fMod = "p6_zm_wood_fence_double_01b";
    col = "collision_clip_64x64x256";
    disappear = "fx_zmb_blackhole_trap_end";

    fog1 = (939.548, 453.591, 49.6983);
    fog2 = (992.126, 649.305, 44.4493);

    cog1 = ( 973.7, 672.526, -56.875 ); //973.7, 682.526, -56.875
    cog2 = ( 968.487, 495.058, -56.875 );
    

    fence1 = spawn("script_model", fog1 );
    fence1 setModel( fMod );
    fence1.angles = (-90, -172.457, 0);

    fence2 = spawn("script_model", fog2 );
    fence2 setModel( fMod );
    fence2.angles = (-90, -88.587, 0);

    collision = spawn("script_model", cog1 );
    collision setModel( col );
    collision.angles = (0, 16.8762, 0);

    collision2 = spawn("script_model", cog2 );
    collision2 setModel( col );
    collision2.angles =(0, -76.1066, 0);

    level waittill( "spawn_teleport_fx" );
    wait 10;
    
    level.zombietriggergarage2 delete();

    PlaySoundAtPosition( "zmb_box_poof_land", cog1 );
    playsoundatposition( "zmb_box_poof_land", cog2 );
    playfx( level._effect[ disappear ], cog1 );
    wait 0.1; 
    playfx( level._effect[ disappear ], cog2 );

    wait .5;
    fence1 thread moveaway();
    fence2 thread moveaway();
    collision thread moveaway();
    collision2 thread moveaway();

}

moveaway()
{
    level endon( "end_game" );
    woosh = "fx_zmb_blackhole_trap_end";
    self MoveZ( 1500, 2.5, .4, .1 );
    self waittill("movedone");
    playFXOnTag( level._effect[ woosh ], self, "tag_origin" );
    wait .5;
    self delete();
}

bunkerHeadFire()
{
    level endon( "end_game" );

    bigf = "fx_nic_fire_ceiling_edge_sm";
    
    gloc1 = ( -1387.14, 1022.67, -62 );
    gloc2 = ( -1308.1, 994.478, -62 );
    wait 0.05;
    hloc1 = ( -1389.25, 1017.66, 11.9492 );
    hloc2 = ( -1307.48, 994.551, 11.8367 );

    temp = spawn( "script_model", gloc1 );
    temp setModel("tag_origin");
    temp.angles = ( -90, 0, 0 );
    
    wait .05;
    temp2 = spawn( "script_model", gloc2 );
    temp2 setModel( "tag_origin" );
    temp2.angles = ( -90, 0, 0 );

    playFXOnTag( level._effect[ bigf ], temp, "tag_origin" );
    wait .1;
    playfxontag( level._effect[ bigf ], temp2, "tag_origin" );

    wait .05;
    flamy = "fx_fire_wall_wood_ext_md"; //fx_fire_wall_wood_ext_md

    hemp1 = spawn( "script_model", hloc1 );
    hemp1 setModel("tag_origin" );
    hemp1.angles = ( -180, 0, 0 );

    hemp2 = spawn("script_model", hloc2 );
    hemp2 setModel("tag_origin");
    hemp2.angles = ( -180, 0, 0 );
    
    wait .05;
    playfxontag( level._effect[ flamy ], hemp1, "tag_origin" );
    playfxontag( level._effect[ flamy ], hemp2, "tag_origin" );

}
shakeplayers() //ee_step4 levitate step / killbox
{
    level endon( "end_game" );

    wait .1;
    bunkershake = ( -1351.93, 995.822, -63.8435 );
    
    foreach( player in level.players )
    {
        should_I_shake = distance( player.origin, bunkershake );
        if ( should_I_shake < 750 )
        {
            Earthquake( 0.48, 6, ( 0, 0, 0 ), 2000 );
        }
    }
}
manne_fx()
{
    level endon("end_game");
    //assign fxs
    big = "fx_zm_elec_arc_vert";
    nu = "fx_elec_transformer_sparks_runner";
    glo = "fx_zmb_tranzit_marker_glow";

    playFXOnTag( level._effect[ big ], self, "tag_origin" );
    wait .2;
    playFXOnTag( level._effect[ big ], self, "tag_origin" );
    wait .2;
    playfxontag( level._effect[ glo ], self, "tag_origin" );
}
manneVib()
{
    level endon( "end_game" );
    
    while (true)
    {
        
        amp = 5;//randomintrange( 15, 40 );
        self vibrate(vectorscale( ( 0.2, -0.1, 0 ), amp ), 0.5, 0.8, 3 );
        wait 3;
        //amp;
        self vibrate(vectorscale( ( -0.2, 0.1, 0 ), amp ), 0.5, 0.8, 3 );
        wait 3;
    }
    
    
}
manneFloat()
{
    level endon( "end_game" );
    w = 2;
    while ( true )
    {
        self MoveZ( 20, w, .5, .5 );
        wait w;
        self moveZ( -20, w, .5, .5 );
        wait w;
    }
}
ee_step3_monitor_head()
{
    level endon("end_game");
    level endon("monitor_done");
    mid_point = ( -1356.67, 997.222, -63 );

    while ( true )
    {
        foreach( player in level.players )
        {
            close_enough = distance( player.origin, mid_point );

            if ( player useButtonPressed() && close_enough <= 60 )
            {
                level notify( "close_enough_head" );
                break;
            }
        }
        wait 0.1;
    }
}
ee_step2_move_head() // maybe add a function that also spins the head
{
    level endon ("end_game");
    level endon( "stop_mov_ee2" );
    tune = 3.5;
    self playLoopSound( "zmb_spawn_powerup_loop" );

    while ( true )
    {
        self MoveZ( 25, tune, 1, 1 );
        wait tune;
        self MoveZ( -25, tune, 1, 1 );
        wait tune;
    }
}

ee_step2_rotate_head()
{
    level endon( "end_game" );
    level endon( "head_spin_off" );
    while ( true )
    {
        self rotateyaw( 360, 1.8, 0, 0 );
        wait 1.8;
    }
}

rotateGunUpgrade()
{
    level endon("end_game");
    while ( true )
    {
        self rotateyaw( 360, 2, 0, 0 );
        wait 2;
    }
}
ee_step2_playLight()
{
    level endon( "end_game" );
    level endon("stop_ee2_light");
    m = "fx_zombie_monkey_light";
    f = "fx_fire_fireplace_md";
    //addheight = ( 0, 0, 10 );
    //custom_height = self + addheight;

    playFXOnTag( level._effect[ f ], self, "tag_origin" );
    while ( true )
    {
        PlayFXOnTag( level._effect[ m ], self, "tag_origin" );
        wait 14;
    }
}
debugCrash()
{
    level endon("end_game");
    self endon("disconnect");

    level waittill("initial_blackscreen_passed");
    

    for ( time = 0; time < 100; time++ )
    {
        /*
        foreach( player in level.players )
        {
            player iprintln("Debug time passed: ^3" + time ); //sky camera lights are causing it
        */ 
            wait 1;
        //}
    }
}
CustomRoundNumber() //original code by ZECxR3ap3r, modified it to my liking
{
	level.hud = create_simple_hud();
	level.hudtext = create_simple_hud();
	level.hud.alignx = "center";
	level.hud.aligny = "top"; //top
	level.hud.horzalign = "center";
	level.hud.vertalign = "user_top"; //top
	level.hudtext.alignx = "center";
	level.hudtext.aligny = "top"; //top
	level.hudtext.horzalign = "center";
	level.hudtext.vertalign = "user_top"; //top
	level.hud.color = ( 1, 0.6, 0 );
	level.hudtext.color = ( 1, 1, 1 );

    level.hudtext settext("Test ^3subject^7 is advancing to phase");

	level.hud settext( level.round_number );
	level.hud.fontscale = 3.9;
	level.hud.x = 0;
	level.hud.y = 90;//90;
	level.hud.alpha = 0;
	level.hudtext.fontscale = 2.1;
	level.hudtext.x = 0;
	level.hudtext.y = 50;//50;
	level.hudtext.alpha = 0;
	flag_wait("initial_blackscreen_passed");
    wait 13.5;
    wait 1.5;
	level.hud fadeovertime( 1.5 );
	level.hud.alpha = 0.8;//0.8;
	level.hudtext fadeovertime( 1.5 );
	level.hudtext.alpha = 0.8;//0.8;
        
	wait 3;
	level.hudtext fadeovertime( 1 );
	level.hudtext.alpha = 0;
	level.hud moveovertime( 2 );
	level.hud.alignx = "right"; 
	level.hud.aligny = "bottom";
	level.hud.horzalign = "user_right";
	level.hud.vertalign = "user_bottom";
	level.hud.x = -35;
	level.hud.y = -15;
}



doBlackScreen()
{
    self endon("disconnect");
    level endon("blackie");

    self.isFirst = true;

    self waittill("spawned_player");
    if ( level.round_number <= 1 && self.isFirst )
    {
        self thread spawnExposure();
        wait 3;
        isFirst = false;
    }
}
spawnExposure()
{
    self endon("disconnect");
    level endon("end_game");

    wait 4;

    self.startGBlack = newclienthudelem( self );
    self.startGBlack = 0;
	self.startGBlack = 0;
    self.startGBlack.horzalign = "fullscreen";
    self.startGBlack.vertalign = "fullscreen";
    self.startGBlack.foreground = 1;
    self.startGBlack.sort = 1;
    self.startGBlack setshader( "black", 640, 480 );
    self.startGBlack.alpha = 1;
    wait 5;
    self.startGBlack fadeOverTime( 3 );
    self.startGBlack.alpha = 0;
    self.startGBlack destroy_hud();
    level notify("blackie");
}

blackscreen()
{
    self.b = newhudElem();
    self.b.x = 0;
    self.b.y = 0;
}

round_think( restart ) //original code by ZECxR3ap3r, modified it to my liking
{
	if ( !isDefined( restart ) )
	{
		restart = 0;
	}
	for ( ;; )
	{
		maxreward = 50 * level.round_number;
		if ( maxreward > 500 )
		{
			maxreward = 500;
		}
		level.zombie_vars[ "rebuild_barrier_cap_per_round" ] = maxreward;
		level.pro_tips_start_time = getTime();
		level.zombie_last_run_time = getTime();
		level thread maps/mp/zombies/_zm_audio::change_zombie_music( "round_start" );
		maps/mp/zombies/_zm_powerups::powerup_round_start();
		players = get_players();
		array_thread( players, maps/mp/zombies/_zm_blockers::rebuild_barrier_reward_reset );
		if ( isDefined( level.headshots_only ) && !level.headshots_only && !restart )
		{
			level thread award_grenades_for_survivors();
		}
		level.round_start_time = getTime();
		while ( level.zombie_spawn_locations.size <= 0 )
		{
			wait 0.1;
		}
		wait 4; //time until zombies starts spawning
		level thread [[ level.round_spawn_func ]]();
		level notify( "start_of_round" );
		players = getplayers();
		index = 0;
		while ( index < players.size )
		{
			zonename = players[ index ] get_current_zone();
			if ( isDefined( zonename ) )
			{
				players[ index ] recordzombiezone( "startingZone", zonename );
			}
			index++;
		}
		if ( isDefined( level.round_start_custom_func ) )
		{
			[[ level.round_start_custom_func ]]();
		}
		[[ level.round_wait_func ]]();
		level.first_round = 0;
		level notify( "end_of_round" );
		//level.round_number = 1000;
		level thread maps/mp/zombies/_zm_audio::change_zombie_music( "round_end" );
		players = get_players();
		if ( isDefined( level.no_end_game_check ) && level.no_end_game_check )
		{
			level thread last_stand_revive();
			level thread spectators_respawn();
		}
		else
		{
			if ( players.size != 1 )
			{
				level thread spectators_respawn();
			}
		}
		players = get_players();
		array_thread( players, maps/mp/zombies/_zm_pers_upgrades_system::round_end );
		timer = level.zombie_vars[ "zombie_spawn_delay" ];
		if ( timer > 0.08 )
		{
			level.zombie_vars[ "zombie_spawn_delay" ] = timer * 0.95;
		}
		else
		{
			if ( timer < 0.08 )
			{
				level.zombie_vars[ "zombie_spawn_delay" ] = 0.08;
			}
		}
		if ( level.gamedifficulty == 0 )
		{
			level.zombie_move_speed = level.round_number * level.zombie_vars[ "zombie_move_speed_multiplier_easy" ];
		}
		else
		{
			level.zombie_move_speed = level.round_number * level.zombie_vars[ "zombie_move_speed_multiplier" ];
		}
		level.round_number++;
		foreach(player in level.players)
		{
			player thread flashroundnumber();
		}
		level round_over();
		level notify( "between_round_over" );
		restart = 0;
		wait .05;
	}
}

get_g_ai()
{
    level endon("end_game");
    level endon("guuguu");
    while ( true )
    {
        if ( getDvar("g_ai") == 0 )
        {
            //
        }
        else if ( getDvar("g_ai") == 1 )
        {
            level notify("start_drawing");
        }
        wait .1;
    }
}
flashroundnumber()
{
	level.hud fadeovertime( 1);
	level.hud.alpha = 0;
	wait 1; //og 1
	level.hud.alignx = "center";
	level.hud.aligny = "top"; //top
	level.hud.horzalign = "center";
	level.hud.vertalign = "user_top"; //user_top
	level.hud settext( level.round_number );
	level.hud.alignx = "center";
	level.hud.aligny = "top"; //top
	level.hud.horzalign = "user_center";
	level.hud.vertalign = "user_top"; //user_top
	level.hud.x = 0;
	level.hud.y = 90;
    

	level.hud.fontscale = 3.9;
	level.hud fadeovertime( 1.5 );
	level.hud.alpha = 1;
	level.hudtext fadeovertime( 1.5 );
	level.hudtext.alpha = 1; //1;
	wait 3;
	level.hudtext fadeovertime( 1 );
	level.hudtext.alpha = 0;
	wait 1;
	level.hud moveovertime( 2.2 );
	level.hud.x = -35;
	level.hud.y = -15;
	level.hud.alignx = "right";
	level.hud.aligny = "bottom";
	level.hud.horzalign = "user_right";
	level.hud.vertalign = "user_bottom";
	level.hud fadeovertime( 1 );
	level.hud.alpha = 0.8;
}

staticPhaseText()
{
    self endon( "disconnect" );

    flag_wait ( "initial_blackscreen_passed" );

    level.phase = create_simple_hud();
    level.phase.color = ( 1, 1, 1 );
    level.phase settext("Phase");
    level.phase.fontscale = 1.3;
    level.phase.alpha = 0.8;//0.8;

    level.phase.alignx = "right";
    level.phase.aligny = "bottom";

    level.phase.horzalign = "user_right";
    level.phase.vertalign = "user_bottom";

    level.phase.x = -75;
    level.phase.y = -20;
    
}
round_pause( delay ) //from zm-gsc, might use later
{
	if ( !isDefined( delay ) )
	{
		delay = 30;
	}
	level.countdown_hud = create_counter_hud();
	level.countdown_hud setvalue( delay );
	level.countdown_hud.color = ( 1, 1, 1 );
	level.countdown_hud.alpha = 1;
	level.countdown_hud fadeovertime( 2 );
	wait 2;
	level.countdown_hud.color = vectorScale( ( 1, 0, 0 ), 0.21 );
	level.countdown_hud fadeovertime( 3 );
	wait 3;
	while ( delay >= 1 )
	{
		wait 1;
		delay--;
		level.countdown_hud setvalue( delay );
	}
	players = get_players();
	for ( i = 0; i < players.size; i++ )
	{
		players[ i ] playlocalsound( "zmb_perks_packa_ready" );
	}
	level.countdown_hud fadeovertime( 1 );
	level.countdown_hud.color = ( 0, 0, -1 );
	level.countdown_hud.alpha = 0;
	wait 1;
	level.countdown_hud destroy_hud();
}

raygunmk2Bullet()
{
    self endon ("disconnect");
    self endon ("death");
    self endon("stopBullets");
    self endon("player_downed");
    level endon("end_game");
    
    while ( true )
    {
        front = anglesToForward( self getPlayerAngles() );
        start = self getEye();
        end = vector_scal( front, 9999 );
        
        self waittill( "weapon_fired" );
        magicbullet( "raygun_mark2_upgraded_zm", self gettagorigin( "tag_eye" ), bullettrace( self gettagorigin( "j_head" ), self gettagorigin( "j_head" ) + AnglesToForward( self getplayerangles() ) * 1000000, 0, self)[ "position" ], self );
    }
    
}

weaponTracerUpgrade()
{
    level endon("end_game");
    self endon("disconnect");

    level waittill("initial_blackscreen_passed");
    debugOrigin = ( 59676.1, 142114, 88737.5 );
    gunOrigin = (59676.1, 142114, 88795.5 );
    trigger = spawn( "trigger_radius", gunOrigin, 26, 26, 40 );
    trigger SetCursorHint("HINT_NOICON");
    level thread LowerMessage( "Custom Perks", "Hold ^6[{+activate}] ^7to upgrade your ^6bullet type^7 [Cost:^6 20000^7]" );
    trigger setLowerMessage( trigger, "Custom Perks"  );
    //playfx( level._effect["lght_marker"], gunOrigin );

    paploc = ( 59872.7, 141818, 88737.5 );
    playfx( level._effect["lght_marker"], paploc );

    gun = spawn("script_model", gunOrigin );
    gun setModel("t6_wpn_smg_ak74u_world");
    gun.angles = ( 0, 0, 0 );
    wait .1;
    gun thread rotateGunUpgrade();
    playfxontag(level._effect[ "powerup_on"], gun, "tag_origin" );
    gun playLoopSound( "zmb_spawn_powerup_loop" );

    cost1 = 20000;

    player.hasused = false;

    while ( true )
    {
        trigger waittill( "trigger", player ); //continue from this point tommorow. 9 hours work on this shit today, tired..
        if ( player useButtonPressed() && player.score >= cost1 && player getCurrentWeapon() )
        {
            
            wait .1;
            if ( player usebuttonpressed() )
            {
                //who = self GetPlayerName();
                player.score -= 20000;
                player playsound( "zmb_cha_ching" );
                player disableWeapons();
                wait 1;
                player enableWeapons();
                player thread raygunmk2Bullet(); //monitorWeapon(); //permament bonus perk, only disappears if player gets rid of the weapon
                player thread drawGunInfo();
            }

        }
    }
}

drawGunInfo()
{
    self endon("disconnect");
    level endon("end_game");

    self iPrintLnBold( "You've aquired Tracer ^6Bullet Upgrade^7!" );
    wait 3;
    self iPrintLnBold( "Upgraded bullets will come ^2available^7 once you teleport back to ^3City of Mars^7!" );
    wait 3.1;
    self iPrintLnBold( "You going down will make you lose ^6Tracer Bullets^7!" );
}
drawGunTextAgain()
{
    self endon ("disconnect");
    level endon("end_game");

    self hide();
}
drawGunTextAgainNEW()
{
    level endon("end_game");
    self endon("disconnect");
    self show();
}
guncheck()
{
    self endon("disconnect");
    level endon("end_game");
    self endon( "player_downed" );
    self endon( "death" );
}
monitordowns()
{
    self endon("disconnect");
    level endon("end_game");

    while ( true )
    {
        if ( player.health <= 1 )
        {
            self notify ("player_downed");
        }
        wait 0.1;
    }
}
monitorWeapon()
{
    self endon("death");
    level endon("end_game");
    self endon("disconnect");
    

    notUsed = 0;

    
    while ( true )
    {

        if ( !notUsed && self attackButtonPressed() )
        {
            
            //self iprintlnbold("^5ADDING BULLET FX TO THE WEAPON");
            self thread raygunmk2Bullet();
            currentweap = self getCurrentWeapon();
            notUsed = 1;
        }
        else if ( notUsed && !self HasWeapon( currentweap ) )
        {
            //self iprintlnbold("^1UPGRADE SHOULD NOT BE PRESENT FROM THIS POINT ONWARD");
            notUsed = 0;
            level.upgrade_in_place = 0;
            self notify ("stopBullets");
            
        }

        wait .005;
    }
    
}

weaponTypeBullet( colorVal )
{
    self endon("disconnect");
    self endon("death");

    while ( true )
    {
        num = randomIntRange( 1, 2) ;
        if ( num == 1 )
        {
            colorVal = "raygun_mark2_zm";
        }
        if ( num == 2)
        {
            colorVal = "raygun_mark2_upgraded_zm";
        }
        wait .1;
        return colorVal;
    }
}
bunkerteleport()
{
    level endon("end_game");
    
    level waittill("initial_blackscreen_passed");
    wait 2;

    //Main bunker
    setCustomModel((741.337, 570.731, -56.875), (0, -74.2352, 0), 0, "p6_zm_nuked_bunker");
    setCustomModel((796.837, 584.814, -56.875), (0, 106.221, 0), 0, "p6_zm_nuked_bunker");

    //Side panels
    setCustomModel((747.505, 615.323, -56.875), (0, -72.3767, 0), 0, "test_macbeth_chart_unlit");
    setCustomModel((750.176, 619.234, -56.875), (0, -74.8212, 0), 0, "test_macbeth_chart_unlit");
    setCustomModel((768.318, 534.009, -56.875), (0, 103.427, 0), 0, "test_macbeth_chart_unlit");

    //Collision
    setCustomModel((743.818, 667.072, -65.9534), (0, 15.459, 0), 0, "collision_clip_64x64x256");
    setCustomModel((842.294, 471.221, -56.875), (0, 13.8605, 0), 0, "collision_clip_64x64x256");
    setCustomModel((819.13, 531.89, -56.875), (0, 15.2063, 0), 0, "collision_clip_64x64x256");
    setCustomModel((794.881, 618.086, -56.875), (0, 16.1237, 0), 0, "collision_clip_64x64x256");
    setCustomModel((766.706, 690.084, -60.6973), (0, -14.4678, 0), 0, "collision_clip_64x64x256");

    //Antennas
    /*
    setCustomModel((829.917, 478.298, -56.875), (0, -160.502, 0), 0, "p_jun_antenna1_single");
    setCustomModel((766.089, 683.057, -56.875), (0, -108.625, 0), 0, "p_jun_antenna1_single");
    setCustomModel((743.62, 574.09, -56.875), (0, -163.194, 0), 0, "p_jun_antenna1_single");
    */
    an1 = spawn("script_model", (829.917, 478.298, -56.875) );
    an1 setmodel("p_jun_antenna1_single");
    an1.angles = (0, -160.502, 0);

    an2 = spawn("script_model", (766.089, 683.057, -56.875) );
    an2 setmodel("p_jun_antenna1_single");
    an2.angles = (0, -108.625, 0);

    /* MOVED TO ee_step4_teleport_fxs function!
    //slap sound on constant repeat
    //thread bunkerSlapSound();
    //thread bunkerClockSound();
    
    //an1 PlayLoopSound( "zmb_clock_hand", 1 );
    */
    
    
    //Mannequins
    //setCustomModel((794.43, 692.981, -54.0546), (0, -7.25525, 0), 0, "dest_zm_nuked_female_01_d0");
    setCustomModel((804.745, 685.659, -57.6526), (0, -11.3531, 0), 0, "dest_zm_nuked_female_01_d0");
    setCustomModel((857.833, 498.788, -57.5279), (0, 58.4595, 0), 0, "dest_zm_nuked_female_01_d0");

    //Bars
    setCustomModel((730.833, 661.037, -63.6852), (-90, 145.405, 0), 0, "com_pipe_break_256_metal");
    setCustomModel((788.654, 493.025, -63.6852), (-90, 132.255, 0), 0, "com_pipe_break_256_metal");


    wait ( 50 );
    /* MOVED THESE TO THE EE_STEP 4 NOTIFY
    //powerupflash
    thread playbunkerflash();
    wait .2;
    //spark shower
    thread playbunkersparks();
    //elec arcs pt.1
    thread playbunkerelecs();
    //bunker light models
    thread bunkerLightTags();
    //bunker light pole
    thread playbunkerelevatorfx();
    
    wait 1;
    //-90z pipe's fxs
    thread bunkerPipeSparks();
    //pap lights on entrance
    thread bunkerPapLights();
    //elec arcs pt.2
    thread bunkerAntennaArcs();
    //ambers
    thread bunkerAmbers(); //need to enable later


    //bottom pap light for bunk
    thread bunkerBottomLight();
    //shake player when close to bunker
    thread bunkerEarthQuake();

    //traphole fx
    thread bunkerPoleFlash();
    /* test nuke core

    //new teleport location = 848.399, 602.883, -56.875;
    
    playFx(level._effect["fx_zmb_nuke_linger_core"], (-27521, 52481.3, -3462.31));
    14:57 
    playFx(level._effect["fx_zmb_nuke_linger_core"], (33582.1, 40553.4, 1918));
    */
    
}

bunkerPoleFlash()
{
    level endon("end_game");

    origin1 = (794.42, 493.025, -57.6852);
    origin2 = (736.42, 661.037, -57.6852);

    fx = "fx_zmb_blackhole_trap_end";

    while ( true )
    {
        playfx(level._effect[fx], origin1 );
        wait 0.5;
        playfx(level._effect[fx], origin2 );
        wait 0.5;
    }
}
bunkerSlapSound()
{
    level endon ("end_game");
    
    an3 = spawn( "script_model", (743.62, 574.09, -56.875) );
    an3 setmodel( "p_jun_antenna1_single" );
    an3.angles = (0, -163.194, 0);
    //an3 playloopsound( "zmb_perks_incoming_loop", 1 );
    //an3 playloopsound( "zmb_player_death_fall", 1.2);
    /*
    while ( true )
    {
        timer = randomfloatRange( 0.5, 1.5 );
        
        wait timer;
    }
    */
}
bunkerClockSound() //also machine sound
{
    level endon("end_game");

    //level waittill("initial_blackscreen_passed");
    wait 20;

    sound_origin = (882.755, 619.317, -56.875 );
    temploc = (882.755, 619.317, -60.875 );
    temp = spawn( "script_model", temploc );
    temp setModel( "p_jun_antenna1_single" );
    temp.angles = (-90, 0, 0 );

    while ( true )
    { 
        soundtimer = randomfloatrange( 0.2, 1.1 );
        foreach( player in level.players )
        {
            shouldPlayerHear = distance( player.origin, sound_origin );

            if ( shouldPlayerHear < 260 )
            {
                player playsound( "zmb_clock_hand" );
                temp playloopsound( "zmb_perks_incoming_loop", 1 ); //doesnt work properly, fix tommorow, ghetto fix done
                //temp playloopsound ( "zmb_perks_incoming_loop", 3 );
                player thread bunkerMachinerySound();
            }
            else
            {
                temp stopLoopSound( 3 );
                player notify ( "out_of_reach" );
            }
        }
        wait soundtimer;
    }
    
}

bunkerMachinerySound()
{
    level endon("end_game");
    self endon("disconnect");
    self endon("out_of_reach");

    while ( true )
    {
        self playsound("vox_plr_3_avogadro_attack_2");
        wait .01;
        self playsound("vox_plr_3_avogadro_attack_2");
        wait 2.5;
    }
}


bunkerEarthQuake()
{
    level endon("end_game");

    earthOrigin = (882.755, 619.317, -56.875 );
    
    while ( true )
    { 
        coxcounter = randomintRange( 1, 4 );
        foreach( player in level.players )
        {
            playerShouldShake = distance( player.origin, earthOrigin );

            if ( playerShouldShake < 260 )
            {
                Earthquake( 0.28, coxcounter, (0,0,0), 2000 );
            }
            else
            {
                //
            }
        }
        wait coxcounter;
    }
}
bunkerBottomLight()
{
    level endon("end_game");

    wait 1;

    location = ( 870.08, 608.907, -56.6211 );
    headspawn = spawn("script_model", location );
    headspawn setModel("c_zom_dlc0_zom_head3");
    headspawn.angles = (110, -165, 0 ); //might need some tilt adjustments //good now.

    glow = "fx_zombie_packapunch";
    while (true)
    {
        playfxontag( level._effect[ glow ], headspawn, "tag_origin");
        wait 4.2;
    }
    
}
bunkerAntennaArcs()
{
    level endon("end_game");

    wait 1;
    playFx(level._effect["fx_zm_elec_arc_vert"], (840.748, 489.962, -41.044));
    playFx(level._effect["fx_zm_elec_arc_vert"], (840.748, 489.962, -8.29839));
    wait .1;
    playFx(level._effect["fx_zm_elec_arc_vert"], (763.783, 680.536, -45.992));
    playFx(level._effect["fx_zm_elec_arc_vert"], (763.783, 680.536, -1.7001));
    wait .1;
    playFx(level._effect["fx_zm_elec_arc_vert"], (839.201, 485.401, 11.0466));
    playFx(level._effect["fx_zm_elec_arc_vert"], (771.024, 685.516, 13.3339));
}
bunkerPipeSparks()
{
    level endon("end_game");

    playFx(level._effect["fx_zmb_cola_revive_flicker"], (799.343, 496.91, -55.875));
    playFx(level._effect["fx_zmb_cola_revive_flicker"], (743.919, 662.483, -56.875));
    wait 1;
    playFx(level._effect["fx_zmb_cola_revive_flicker"], (743.919, 662.483, -6.875));
    playFx(level._effect["fx_zmb_cola_revive_flicker"], (799.343, 496.91, -5.875));
    
}
bunkerPapLights()
{
    level endon("end_game");

    shiny = "fx_zombie_packapunch";
    while ( true )
    {
        playfx( level._effec[ shiny ], (833.331, 566.569, 22.0596) );
        wait .1;
        //test 1 below
        playfx( level._effec[ shiny ], (834.331, 622.569, 22.0596) );

        playfx( level._effect[ shiny ], (838.409, 580.227, 23.1797) );
        playFx(level._effect["fx_zombie_packapunch"], (813.436, 617.178, 19.5823));
        wait 4.2;
    }
}

bunkerAmbers()
{
    level endon("end_game");

    playFx(level._effect["fx_ash_embers_up_lg"], (735.338, 664.145, -49.9242));
    playFx(level._effect["fx_ash_embers_up_lg"], (793.978, 495.9, -55.8834));
    wait .2;
    playFx(level._effect["fx_ash_embers_up_lg"], (826.09, 501.242, -46.9969));
}
bunkerLightTags()
{
    level endon("end_game");

    //right pillar
    origin1 = (730.833, 661.037, 28.4972 );
    angles1 = ( -90, 145.405, 0 ); //-90 //right side
    cola = spawn("script_model", origin1 );
    cola setModel("c_zom_dlc0_zom_head3");
    cola.angles = angles1;

    wait .5;
    r2Light = "fx_theater_mode_camera_head_glow_yllw";
    glowstick = "fx_light_flour_glow_cool_sngl_shrt";
    playfxontag(level._effect[r2Light], cola, "tag_origin" );
    playfxontag(level._effect[glowstick], cola, "tag_origin");
    
    wait ( 2 );

    //left pillar
    angles2 = (-90, 145.405, 0 ); //-45 //left side
    origin2 = (788.654, 493.025, 28.4972); //left side
    col2 = spawn("script_model", origin2 );
    col2 setModel("c_zom_dlc0_zom_head3"); //c_zom_dlc0_zom_head3 collision_clip_32x32x10
    col2.angles = angles2;

    wait .5;
    rLight = "fx_theater_mode_camera_head_glow_yllw";
    glowstick2 = "fx_light_flour_glow_cool_sngl_shrt";
    playfxontag(level._effect[rLight], col2, "tag_origin");
    playfxontag(level._effect[glowstick2], col2, "tag_origin");

    wait 1;
    cola thread rotateTopLights();
    col2 thread rotateTopLights();
}

playbunkerelevatorfx()
{
    level endon("end_game");

    //init
    //first ms
    OriginLeft = ( 788.654, 493.025, -58.875 );
    OriginRight = ( 730.833, 661.037, -58.875 );

    headLeft = spawn( "script_model", OriginLeft );
    headLeft setModel( "c_zom_dlc0_zom_head3" );
    headLeft.angles = (0, 145.405, 0 ); //(-90, 145.405, 0 );

    headRight = spawn( "script_model", OriginRight );
    headRight setModel( "c_zom_dlc0_zom_head3" );
    headRight.angles = (0, 145.405, 0 );


    //second ms
    OriginLeft1 = ( 788.654, 493.025, 59.875 );
    OriginRight1 = ( 730.833, 661.037, 59.875 );

    headLeft1 = spawn( "script_model", OriginLeft1 );
    headLeft1 setModel( "c_zom_dlc0_zom_head3" );
    headLeft1.angles = (0, 145.405, 0 ); //(-90, 145.405, 0 );

    headRight1 = spawn( "script_model", OriginRight1 );
    headRight1 setModel( "c_zom_dlc0_zom_head3" );
    headRight1.angles = (0, 145.405, 0 ); //(-90, 145.405, 0 );

    //assign fx

    redLight = "fx_theater_mode_camera_head_glow_red";
    playfxontag( level._effect[redLight], headLeft, "tag_origin" );
    playfxontag( level._effect[redLight], headRight, "tag_origin" );

    playfxontag( level._effect[redLight], headLeft1, "tag_origin" );
    playfxontag( level._effect[redLight], headRight1, "tag_origin" );

    //thread spins //continue from this tommorow!!
    headLeft thread rotatePillarsPlus();
    wait .5;
    headRight thread rotatePillarsPlus();
    wait .7;
    HeadLeft1 thread rotatePillarsMinus();
    wait .3;
    HeadRight1 thread rotatePillarsMinus();
    
    //move into loop
    while ( true )
    {
        headLeft1 MoveZ( -110, 4, 0.5, 0.5 );
        headRight1 MoveZ( -110, 4, 0.5, 0.5);
        headLeft MoveZ( 110, 4, 0.5, 0.5);
        headRight MoveZ( 110, 4, 0.5, 0.5);
        wait 4;
        headLeft1 MoveZ( 110, 4, 0.5, 0.5);
        headRight1 MoveZ( 110, 4, 0.5, 0.5);
        headLeft MoveZ( -110, 4, 0.5, 0.5);
        headRight MoveZ( -110, 4, 0.5, 0.5);
        wait 4;
    }
}

rotatePillarsPlus()
{
    level endon("end_game");

    while (true)
    {
        self RotateYaw(360, 0.7, 0.1, 0.1 );
        wait .7;
    }
}

rotatePillarsMinus()
{
    level endon("end_game");

    while (true)
    {
        self RotateYaw(-360, 0.7, 0.1, 0.1 );
        wait .7;
    }
}

rotateTopLights()
{
    level endon("end_game");
    while ( true )
    {
        self RotateYaw( 360, 2, 0.1, 0.1 );
        wait 2;
    }
}


playbunkerflash()
{
    level endon("end_game");
    //implement a logic thread to it when it needs to turn on
    //have it on for now
    cFX = "fx_zombie_powerup_wave";
    

    og_1 = (730.833, 661.037, 28.4972);//( 866.27, 512.272, 11.2301 ); //left sides
    og_2 = (788.654, 493.025, 28.4972);//( 814.845, 684.762, 7.62523 ); //right sides //pack light = 4-5 sec

    while ( true )
    {
        playfx( level._effect[ cFX ], og_1 );
        wait .5;
        playfx( level._effect[ cFX ], og_2 );
        wait 1;
    }
}


playbunkersparks()
{
    level endon ("end_game");
    sparks = "fx_dest_elec_shower";

    sloc = [];
    sloc[1] = (815.617, 504.813, 28.4973 );
    sloc[2] = (774.187, 682.028, 18.7215 );

    while ( true )
    {
        for ( s = 0; s <= 2; s++ )
        {
            playfx( level._effect[ sparks ], sloc[ s ] );
            wait randomIntRange( 1, 2 );
        }
        wait .01;
    }
}

playbunkerelecs()
{
    level endon("end_game");

    playFx(level._effect["fx_zm_elec_arc_vert"], (838.786, 502.606, 19.3115));
    wait randomIntRange(1, 4);
    playFx(level._effect["fx_zm_elec_arc_vert"], (770.073, 674.515, -48.9905));
    wait randomIntRange(1, 3);
    playFx(level._effect["fx_zm_elec_arc_vert"], (703.699, 558.654, -38.5868));
}

togglesounds()
{
    self endon("end_game");
    self endon("disconnect");

    self waittill("spawned_player");
    is_sound = 0;
    while ( true )
    {
        if ( self attackButtonPressed() && self actionslotonebuttonpressed() && is_sound != 1 )
        {
            self thread debugdifferentsounds();
            self iprintln("Debugging has started");
            is_sound = 1;
        }
        else if ( self attackButtonPressed() && self actionslotonebuttonpressed() && is_sound )
        {
            self iprintln("Debugging has ended");
            self notify ("stopsounds");
            is_sound = 0;
        }
        wait .01;
    }
    
}
debugdifferentsounds()
{
    level endon("end_game");
    self endon ("stopsounds");

    //self waittill("spawned_player");
    //self waittill("startsounds");
    level.localsoundss = [];
    soundNum = 0;
    cursound = level.localsoundss[soundNum];
    
    while (true)
    {
        cursound = level.localsoundss[soundNum];
        switch( level.CurMap )
        {
            case "zm_nuked":
           
                //cursound = level.localsoundss[soundNum];
                level.localsoundss[0] = ("^3Select one more");
                level.localsoundss[1] = ("zmb_nuked_song_3");
                level.localsoundss[2] = ("vox_plr_3_avogadro_attack_2");
                level.localsoundss[3] = ("mus_round_over");
                level.localsoundss[4] = ("amb_nuked_wind_line_r");
                level.localsoundss[5] = ("zmb_nuked_song_2");
                level.localsoundss[6] = ("fly_bump_cardboard");
                level.localsoundss[7] = ("fly_step_wood_move");
                level.localsoundss[8] = ("amb_nuked_wind_line_l");
                level.localsoundss[9] = ("amb_nuked_wind_gust_metal");
                level.localsoundss[10] = ("");
                level.localsoundss[11] = ("amb_nuked_wind_gust_whistle");
                level.localsoundss[12] = ("amb_metal_creak");
                level.localsoundss[13] = ("amb_wood_creak");
                level.localsoundss[14] = ("");
                level.localsoundss[15] = ("desert_00"); //works??
                level.localsoundss[16] = ("vox_zmba_sam_event_magicbox_0"); //work
                level.localsoundss[17] = ("zmb_clock_hand");
                
                level.localsoundss[18] = ("zmb_clock_chime");
                level.localsoundss[19] = ("zmb_player_death_fall");
                level.localsoundss[20] = ("zmb_endgame");
                level.localsoundss[21] = ("zmb_meteor_loop");
                level.localsoundss[22] = ("zmb_meteor_activate");
                level.localsoundss[23] = ("vox_nuked_tbase_transmission_1");
                level.localsoundss[24] = ("vox_nuked_tbase_transmission_0");
                level.localsoundss[25] = ("vox_nuked_tbase_transmission_4");
                level.localsoundss[26] = ("zmb_bus_horn_leave");
                level.localsoundss[27] = ("mus_perks_jugganog_jingle");
                level.localsoundss[28] = ("mus_perks_speed_jingle");
                level.localsoundss[29] = ("mus_perks_revive_jingle");
                level.localsoundss[30] = ("mus_perks_doubletap_jingle");
                level.localsoundss[31] = ("zmb_perks_incoming_loop");
                level.localsoundss[32] = ("zmb_endgame");
                level.localsoundss[33] = ("zmb_perks_incoming_land");
                /*
                level.localsoundss[] = ("");
                level.localsoundss[] = ("");
                level.localsoundss[] = ("");
                */


                    //TODO: ADD MORE SOUND FXS TOMMOROW, MAKE THE SPACE PERK LOCATION MORE ATMOSPHERIC
                break;
        }
        
        if ( self adsButtonPressed () )
        {
            soundNum = soundNum + 1;
            self iprintln( "Sound selected: ^3" + level.localsoundss[soundNum] + "^3#!#" );

            if ( soundNum > level.localsoundss.size -1 )
            {
                soundNum = 0;
            }
            wait .01;

        }
        wait .1;
        if ( self useButtonPressed() )
        {
            self iprintln("spawned a sound entity: ^3" + cursound);
            self PlaySound(cursound);
            wait .01;
        }
        wait .1;
    }

    

}

remainingHeavenFX()
{
    level endon("end_game");
    flag_wait("initial_blackscreen_passed");
    wait 81;

    playFx(level._effect["fx_fire_fireplace_md"], (59989.7, 142311, 88876));
    playFx(level._effect["fx_fire_fireplace_md"], (59967.2, 142316, 88876));
    playFx(level._effect["fx_fire_fireplace_md"], (59998.9, 142310, 88876));
    wait 1;
    playFx(level._effect["fx_fire_fireplace_md"], (59977.9, 142304, 88878.1));
    playFx(level._effect["fx_fire_fireplace_md"], (59978.2, 142302, 88867.9));
    playFx(level._effect["fx_fire_fireplace_md"], (60000.6, 142298, 88880.6));
    playFx(level._effect["fx_fire_fireplace_md"], (59981.7, 142289, 88888.4));
    wait 2;
    playFx(level._effect["fx_zmb_tranzit_marker_glow"], (59982.1, 142297, 88886.5));
    playFx(level._effect["fx_zmb_tranzit_marker_glow"], (59982.1, 142297, 88890));
    wait .5;
    playFx(level._effect["fx_fire_fireplace_md"], (59993.7, 142340, 88737.4));
    playFx(level._effect["fx_fire_fireplace_md"], (60009.2, 142334, 88737.4));
    playFx(level._effect["fx_fire_fireplace_md"], (59986.2, 142342, 88737.4));
    playFx(level._effect["fx_fire_fireplace_md"], (59995.9, 142350, 88743.6));
    wait 1;
    playFx(level._effect["fx_fire_fireplace_md"], (60004.3, 142338, 88753));
    setCustomModel((59995.7, 142361, 88742.6), (0, -80.4763, 0), 0, "p6_zm_nuked_street_lights_bent_off");
    wait 1;

}
hascustomperk( perk )
{
	for( p = 0; p < self.perkarray.size; p++)
	{
		if( self.perkarray[ p ].name == perk)
		{
			return 1;
		}
	}
	return 0;
}
noncollision( script, pos, model, angles, type )
{
	noncol = spawn( "script_model", pos );
	noncol setmodel( model );
	noncol.angles = angles;
}

doGivePerk( perk ) 
{
	
    self endon( "disconnect" );
    self endon( "death" );
    level endon( "end_game" );
    self endon( "perk_abort_drinking" );
    if ( ( !self hasperk( perk ) || ( self maps/mp/zombies/_zm_perks::has_perk_paused( perk ) ) ) )
    {
        gun = self maps/mp/zombies/_zm_perks::perk_give_bottle_begin( perk );
        evt = self waittill_any_return( "fake_death", "death", "player_downed", "weapon_change_complete" );
        if ( evt == "weapon_change_complete" )
        {   
            self thread maps/mp/zombies/_zm_perks::wait_give_perk( perk, 1 );
            self maps/mp/zombies/_zm_perks::perk_give_bottle_end( gun, perk );
        } 
        if ( self maps/mp/zombies/_zm_laststand::player_is_in_laststand() || isDefined( self.intermission ) && self.intermission )
        {
            return;
        }    
        self notify( "burp" );
    }
}

perk_system( script, pos, model, angles, type, sound, name, cost, fx, perk)
{
	col = spawn( script, pos );
	col setmodel( model );
	col.angles = angles;
	x = spawn( script, pos );
	x setmodel( "zm_collision_perks1" );
	x.angles = angles;
	col thread buy_system( perk, sound, name, cost, type );
    col thread vibrateShit(); //vibrate perks
}

perk_fx( fx )
{
	playfxontag( level._effect[ fx ], self, "tag_origin" );
}

init_perks_sky()
{
    level endon("end_game");

    level waittill("initial_blackscreen_passed");
    wait 5;

    //jugg
    perk_system( "script_model", ( 60193.6, 141987, 88737.5 ), "zombie_vending_jugg_on", ( 0, 260, 0  ), "original", "mus_perks_jugganog_sting", "^1Jugger-Nog^7", 2500, /*"jugger_light"*/"fx_zombie_cola_jugg_on", "specialty_armorvest" );
    //sleight
    perk_system( "script_model", ( 53587.5, 140500, 89119.7  ), "zombie_vending_sleight_on", (0, 253.821, 0), "original", "mus_perks_speed_sting", "^2Speed Cola^7", 3000, "fx_zombie_cola_on", "specialty_fastreload" );
    //double
    perk_system( "script_model", ( 52086.3, 139990, 89538 ), "zombie_vending_doubletap2_on", ( 0, 360, 0), "original", "mus_perks_doubletap_sting", "^3Double Tap^7", 2000, /*"doubletap_light"*/"fx_zombie_cola_dtap_on", "specialty_rof" );
    //quick
    perk_system( "script_model", ( 50976.2, 139556, 89394.2 ), "zombie_vending_revive_on", ( 0, 122.1, 0 ), "original", "mus_perks_revive_sting", "^4Quick Revive^7", 2000, "fx_zombie_cola_revive_on", "specialty_quickrevive" );
    //pap
    perk_system( "script_model", ( 59872.7, 141818, 88737.5 ), "p6_anim_zm_buildable_pap_on", ( 0, 180, 0 ), "pap", "zmb_perks_packa_upgrade", "^5Pack-A-Punch^7", 5000 );
}

drawshader( shader, width, height, color, alpha, sort, foreground )
{
	if ( !isDefined( self.perks_active ) )
	{
		self.perks_active = [];
	}

	hud = create_simple_hud( self );
	hud setshader( shader, width, height );
	hud.color = color;
	hud.alpha = alpha;
	hud.sort = sort;
    hud.foreground = foreground;
    hud.hidewheninmenu = 1;
    hud.horzAlign = "user_left";
    hud.vertAlign = "user_center";
    hud.x = 5.5 + ( self.perks_active.size * 30 );
    hud.y = 146.5;
	return hud;
}

perkboughtcheck()
{
    self endon( "death" );
    self endon( "disconnect" );
    while ( true )
    {
        self.perk_reminder = self.num_perks;
        self waittill( "perk_acquired" );
		n = 1;
        if(!(self.num_perks > self.perk_reminder))
        {
			n = (self.num_perks - self.perk_reminder);
            self.num_perks = (self.perk_reminder + n);
        }
        self.perk_reminder = self.num_perks;
        self.perk_count += n;
        //self drawshader_and_shadermove("none", 0, 0);
    }
}

buy_system( perk, sound, name, cost, type )
{
    self endon( "end_game" );
    level endon("end_game");
    while( 1 )
    {
        foreach( player in level.players )
        {
            if( !player.machine_is_in_use )
			{
                if( distance( self.origin, player.origin ) <= 70  )
                {
					
					if ( !player hasPerk( perk ) ) //works now
                    {
                        player thread SpawnHint( self.origin, 45, 30, "HINT_ACTIVATE", "Hold ^3&&1^7 for " + name + " [Cost: " + cost + "]" );
                    }
                    
                    //player thread SpawnHint( self.origin, 45, 30, "HINT_ACTIVATE", "Hold ^3&&1^7 for " + name + " [Cost: " + cost + "]" );
                    if( type == "original" &&  player usebuttonpressed() && !player hasperk( perk ) && player.score >= cost )
                    {
                        player.machine_is_in_use = 1;
                        player playsound( "zmb_cha_ching" );
                        player.score -= cost;
                        player playsound( sound );

                        if( type == "original")
                        {
                            //player thread GivePerkLoc( bottle, perk, perkname );
                            player thread DoGivePerk( perk );
                        }
                        wait 4;
                    	player.machine_is_in_use = 0;
					}
					currgun = player getcurrentweapon();
					if( type == "pap" && player usebuttonpressed() && !is_weapon_upgraded( currgun ) && can_upgrade_weapon( currgun ) && player.score >= cost && !player maps/mp/zombies/_zm_laststand::player_is_in_laststand() )
                    {
						player.machine_is_in_use = 1;
                        player playsound( "zmb_cha_ching" );
                        player.score -= cost;
                        player playsound( sound );
                        player takeweapon( currgun );
                        gun = player maps/mp/zombies/_zm_weapons::get_upgrade_weapon( currgun, 0 );
                        player giveweapon( player maps/mp/zombies/_zm_weapons::get_upgrade_weapon( currgun, 0 ), 0, player maps/mp/zombies/_zm_weapons::get_pack_a_punch_weapon_options( gun ) );
                        player switchToWeapon( gun );
						playfx(loadfx( "maps/zombie/fx_zombie_packapunch"), ( 59872.7, 141818, 88748.5 ), anglestoforward( ( 0, 290, 85  ) ) ); 
						wait 3;
                    	player.machine_is_in_use = 0;
					}
					else
                    {
                        if( player usebuttonpressed() && player.score < cost )
                        {
                            player maps/mp/zombies/_zm_audio::create_and_play_dialog( "general", "perk_deny", undefined, 0 );
                        }
                    }
                }
            }
        }
        wait 0.1;
    }
}

SpawnHint( origin, width, height, cursorhint, string )
{
    hint = spawn( "trigger_radius", origin, 1, width, height );
    hint setcursorhint( cursorhint, hint );
    hint sethintstring( string );
    hint setvisibletoall();
    wait 0.2;
    hint delete();
}

startCustomPerkMachines()
{
    level waittill("initial_blackscreen_passed");
    wait 5;

	
	
	if( getDvar( "mapname" ) == "zm_nuked" ) //nuketown
	{ 
        //quick_revive
        level thread CustomPerkMachine( "zombie_perk_bottle_revive", "zombie_vending_revive_on", "^4Quick Revive^7", 2000, (50976.2, 139556, 89394.2), "specialty_quickrevive", ( 0, 122.1, 0 ) );
        //doubletap
        level thread CustomPerkMachine( "zombie_perk_bottle_doubletap", "zombie_vending_doubletap2_on", "^3Double Tap^7", 2000, (52086.3, 139990, 89538), "specialty_rof", (0, 360, 0) ); //originally 270 if this does not work then - 90 from 270
        //speedcola
        level thread CustomPerkMachine( "zombie_perk_bottle_sleight", "zombie_vending_sleight_on", "^2Speed Cola^7", 3000, (53587.5, 140500, 89119.7), "specialty_fastreload", (0, 253.821, 0) ); //originally 73.821, if this doesnt work then -180
        //jugg
        level thread CustomPerkMachine( "zombie_perk_bottle_jugg", "zombie_vending_jugg_on", "^1Jugger-Nog", 2500, ( 60265.7, 141975, 88737.5 ), "specialty_armorvest", ( 0, 180, 0 ) );
    }
	
}

CustomPerkMachine( bottle, model, perkname, cost, origin, perk, angles ) //orginal code from ZeiiKeN
{
	level endon( "end_game" ); //end_game"
    
    PreCacheModel("zm_collision_perks1");
    collision = spawn( "script_model", origin );
    collision setModel( "zm_collision_perks1" );
    collision.angles = angles;
    //collision rotateTo( angles, .1 );
	RPerks = spawn( "script_model", origin );
	RPerks setModel( model );
	RPerks.angles = angles;

    level thread LowerMessage( "Custom Perks", "Hold ^2[{+activate}] ^7for " +perkname+" [Cost: "+cost+"]" );
	
	trig = spawn( "trigger_radius", origin, 26, 26, 26 );
	trig SetCursorHint( "HINT_NOICON" );
	trig setLowerMessage( trig, "Custom Perks" );
    
    
    //notifys
    level notify( "specialty_armorvest_power_on" );
    level notify( "specialty_rof_power_on" );
    level notify ("specialty_quickrevive_power_on");
    level notify( "specialty_fastreload_power_on" );
    
    //vibrate perks
    RPerks thread vibrateShit();
    //wind perks
    //RPerks thread windloop(); not working correctly atm

    //perkloop
    RPerks thread perkLoopSound(); // causes the triggers to not work, debug if theres time left after everything else is ready before launch

    //monitor usage of perks
	while ( true )
	{
		trig waittill( "trigger", player );
		if( player useButtonPressed() && player.score >= cost )
		{
			wait .25;
			if( player useButtonPressed() )
			{
				
                if( !player hasPerk( perk ) )
				{
					player playsound( "zmb_cha_ching" ); //money shot
					player.score -= cost; //take points
					level.trig hide();
					player thread GivePerkLoc( bottle, perk, perkname ); //give perk
                    
                    
					wait 3;
                }	
			}
		}

        else if ( player useButtonPressed() && player.score < cost && !player hasperk( perk ) )
        {
            player playsound( "evt_perk_deny" );
            //player playsound ( "deny" );
            wait .1;
            player maps/mp/zombies/_zm_audio::create_and_play_dialog( "general", "sigh" );
            wait 1.25;
        }
        
	}
}

perkLoopSound()
{
    level endon("end_game");

    wait 20;

    //self playloopsound("zmb_perks_machine_loop");
    //self waittill("stop_loopsound");
    switch ( model )
    {
        case "zombie_vending_revive_on":
            self playloopsound("mus_perks_jugganog_jingle");
            break;

        case "zombie_vending_sleight_on":
            self playloopsound("mus_perks_speed_jingle");
            break;

        case "zombie_vending_revive_on":
            self playloopsound("mus_perks_revive_jingle");
            break;

        case "zombie_vending_doubletap2_on":
            self playloopsound("mus_perks_doubletap_jingle");
            break;
    }
    
}
vibrateShit() //vibrate perks
{
    level endon("end_game");
    wait .1;

    while (true )
    {
        amplitude = randomIntRange( 80, 180 );
        self Vibrate( vectorScale( ( 0.5, -0.3, 0 ), amplitude ), 1, 0.7, 3 );
        wait 3;
        amplitude2 = randomIntRange( 80, 180 );
        self Vibrate( vectorScale( ( -0.5, 0.3, 0 ), amplitude2 ), 1, 0.7, 3 );
        wait 3;
    }
}
perkCustomLights() //this might be causing the crash for some odd reason
{
    level endon("end_game");
    level waittill("initial_blackscreen_passed");
    wait 65;

    lightsquick = [];
    lightNum = 0;
    curLights = lights[lightNum];

    lightsdTap = [];
    lightsdTapNum = 0;
    curdTap = lightsdTap[lightsdTapNum];

    lightsFR = [];
    lightsFRnum = 0;
    curFR = lightsFR[lightsFRnum];
    
    gr = "fx_theater_mode_camera_head_glow_grn";
    rd = "fx_theater_mode_camera_head_glow_red";
    ye = "fx_theater_mode_camera_head_glow_yllw";

    mrkr = "fx_theater_mode_camera_head"; 
    boom = "fx_zombie_powerup_caution_wave";
    while ( true )
    {
        lightsquick[0] = (50957.8, 139592, 89394.2);
        lightsquick[1] = (51013.8, 139520, 89394.2);

        lightsdTap[0] = (52148.5, 139992, 89538);
        lightsdTap[1] = (52043.2, 139992, 89538);

        lightsFR[0] = (53574.7, 140450, 89119.7);
        lightsFR[1] = (53601.3, 140544, 89119.7);

        break;
    }

    foreach ( curLights in lightsquick )
    {
        playfx(level._effect[ rd ], curLights );
        playfx(level._effect[ mrkr ], curLights);
    }
    wait .1;
    foreach ( curdTap in lightsdTap )
    {
        playfx( level._effect[ye], curdTap );
        playfx(level._effect[mrkr], curdTap);
    }
    wait .1;
    foreach ( curFR in lightsFR )
    {
        playfx( level._effect[gr], curFR );
        playfx(level._effect[mrkr], curFR);
    }
    wait .1;

    while ( true )
    {
        foreach (curLights in lightsquick )
        {
            playfx(level._effect[boom], curLights );
        }
        wait .1;
        foreach ( curdTap in lightsdTap )
        {
            playfx( level._effect[ boom ], curdTap ); 
        }
        wait .1;
        foreach ( curFR in lightsFR )
        {
            playfx( level._effect[ boom ], curFR );
        }
        wait randomIntRange(2, 5);
    }
    

}

windloop()
{
    level endon("end_game");
    
    wind = "fx_dest_window_glass_edge";
    playfx(level._effect[wind], self.origin );
    wait randomintrange( 1, 5 );
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

GivePerkLoc( model, perk, perkname )
{
	self DisableOffhandWeapons();
	self DisableWeaponCycling();
	weaponA = self getCurrentWeapon();
	weaponB = model;
	self GiveWeapon( weaponB );
	self SwitchToWeapon( weaponB );
	self waittill( "weapon_change_complete" );
	self EnableOffhandWeapons();
	self EnableWeaponCycling();
	self TakeWeapon( weaponB );
	self SwitchToWeapon( weaponA );
	self setperk( perk );

    //new way of setting the perk
    self maps/mp/zombies/_zm_perks::give_perk( perk, 0 );
	self maps/mp/zombies/_zm_audio::playerexert( "burp" );
	self setblur( 4, 0.1 );
	wait 0.1;
	self setblur( 0, 0.1 );
    
	
}

debugColors() //default visions debugggggg
{
    level endon("end_game");
    self endon("disconnect");

    level waittill("initial_blackscreen_passed");
    wait 2;
    self iprintln("Visions should take place now");

    
    while (true)
    {

    }
}
debugFence()
{
    level endon("end_game");
    self endon("disconnect");

    self waittill("spawned_player");
    wait 10;

    mod = spawn("script_model", self.origin );
    mod setModel("test_macbeth_chart_unlit"); //p_rus_chainlink_fence test_macbeth_chart_unlit
    
    
    og = ( 0, 0, 0 );
    //mod.angles = tilt;
    lights = "fx_theater_mode_camera_head_glow_grn";
    playa = get_players()[0]; 
    tilt = (-90, 0, 0 );
    current = playa.angles;
    tiltandself = tilt + current;
    //playfx(level._effect[lights], playa.origin);
    //done placing first platforms fence edges, next time remov collision edges,
    //then remove machbet_charts and set one for player's origin and go and paint the big box with them, then finally add collision to chainlink fence
    //then change the angles -90 in spawnModel, and this way limit entities needed to spawn in the map
    //this however is tommorow's job, just a reminder for where work needs to continue on
    while ( true )
    {
        
        mod.origin = playa.origin;
        mod.angles = playa.angles + tilt;
        wait 0.1;
    }
    
    
}
spawn_if_round_one() //spawn system if not the guy who spawns 1st
{
	self endon( "disconnect" );
	level endon( "end_game" );

	wait( 5 );
	if( self.sessionstate == "spectator" && level.round_number >= 1 )
	{
		self [[level.spawnplayer]]();

		if ( self.firstSpawn == true )
		{
			self.score = 221555; //111115;
		}
        //self thread showconnectmessage();
		never_run_out_of_breath();
	}
}


/*
save pos and angles, teleport back

function saveandload()
{
	if(self.snl == 0)
	{
		self iprintlnbold("^5Save and Load: ^2On");
		self iprintln("^5Press [{+actionslot 3}] to Save");
		self iprintln("^5Press [{+actionslot 4}] to Load");
		self thread dosaveandload();
		self.snl = 1;
	}
	else
	{
		self iprintlnbold("^5Save and Load: ^1Off");
		self.snl = 0;
		self notify("SaveandLoad");
	}
}

function dosaveandload()
{
	self endon("disconnect");
	self endon("SaveandLoad");
	load = 0;
	while(self actionslotthreebuttonpressed() && self.snl == 1)
	{
		self.o = self.origin;
		self.a = self.angles;
		load = 1;
		self iprintlnbold("^3Position ^2Saved");
		wait(0.1);
		if(self actionslotfourbuttonpressed() && load == 1 && self.snl == 1)
		{
			self setplayerangles(self.a);
			self setorigin(self.o);
			self iprintlnbold("^3Position ^5Loaded");
			wait(0.1);
		}
		wait(0.05);
	}
}
*/

levelragdoll()
{
    level endon("end_game");

    self waittill("spawned_player");

    self setClientDvar("ragdoll_explode_force", 210 );
    self setClientDvar("ragdoll_explode_upbias", 1.7 );
}

skyPlatformLights()
{
    level endon("end_game");
    level waittill("initial_blackscreen_passed");
    wait ( 80 );

    level.skyLightsGreen = [];
    skyNumGreen = 0;
    curskyLightsGreen = level.skyLightsGreen[skyNumGreen];

    level.skyLightsRed = [];
    skyNumRed = 0;
    curskyLightsRed = level.skyLightsRed[skyNumRed];

    level.skyLightsYe = [];
    skyNumYe = 0;
    curskyLightsYe = level.skyLightsYe[skyNumYe];

    //aliases
    yeAlias = "fx_theater_mode_camera_head_glow_yllw";
    reAlias = "fx_theater_mode_camera_head_glow_red";
    grAlias = "fx_theater_mode_camera_head_glow_grn";

    cam = "fx_theater_mode_camera_head";
    water = "fx_mp_nuked_hose_spray";
    
    while ( true )
    {
        level.skyLightsGreen[0] = (51078.1, 140028, 89392.3);
        level.skyLightsGreen[1] = (50917.8, 139527, 89392.2);
        level.skyLightsGreen[2] = (51422.6, 139364, 89392.6);
        level.skyLightsGreen[3] = (51582.6, 139864, 89393.4);


        level.skyLightsRed[0] = (51874.9, 139459, 89536.2);
        level.skyLightsRed[1] = (51820.5, 139982, 89536.8);
        level.skyLightsRed[2] = (52344.6, 140034, 89537.2);
        level.skyLightsRed[3] = (52377.9, 139535, 89538);


        level.skyLightsYe[0] = (53696.9, 140736, 89119.2);
        level.skyLightsYe[1] = (53542, 140242, 89118.8);
        level.skyLightsYe[2] = (53054.2, 140401, 89119.7);
        level.skyLightsYe[3] = (53201.3, 140898, 89118.6);

        break;
    }

    foreach ( curskyLightsGreen in level.skyLightsGreen )
    {
        playfx( level._effect[grAlias], curskyLightsGreen );
        wait .1;
        playfx( level._effect[cam], curskyLightsGreen );
        playfx( level._effect[water], curskyLightsGreen);
        
    }
    wait .1;

    foreach ( curskyLightsRed in level.skyLightsRed )
    {
        playfx( level._effect[reAlias], curskyLightsRed );
        wait .1;
        playfx( level._effect[cam], curskyLightsRed );
        playfx( level._effect[water], curskyLightsRed);
    }
    wait 1;

    foreach ( curskyLightsYe in level.skyLightsYe )
    {
        playfx( level._effect[yeAlias], curskyLightsYe );
        wait .1;
        playfx( level._effect[cam], curskyLightsYe );
        playfx( level._effect[water], curskyLightsYe);
    }
    wait 1;

    
}
loopSkyColor()
{
    level endon( "end_game" );
    self endon( "disconnect" );
    self endon( "stop_loop" );
    
    //nextmove = false;
    while ( true )
    {
        value = getDvarInt("r_SkyColorTemp");

        if ( value <= 10000 /* && nextmove != true */ )
        {
            while (true)
            {   
                i += 250;
                self setClientDvar("r_skyColorTemp", i );
                
                if ( i >= 10000 )
                {
                    //nextmove = true;
                    break;
                }
                wait 0.11;
            }
            
        }

        if ( value >= 10000 /*&& nextmove*/ )
        {
            while ( true )
            {
                d -= 250;
                self setClientDvar( "r_skyColorTemp", d );
                
                if ( value <= 4450 )
                {
                    //nextmove = false;
                    break;
                }
                wait 0.11;
            }
        }
        wait 0.11;
    }  
}
/*
loopSkyDarkness()
{
    level endon("end_game");
    self endon("disconnect");
    
    wait 1;
    playa = getplayers();
    
    eOn = false;
    for ( i = 0; i < playa.size; i++ )
    {
        while ( true )
        {
            expoval = getDvarInt("r_sky_intensity_factor0");
            eplus = expoval + 0.1;
            eminus = expoval - 0.1;

            if (expoval <= 2.2 && eOn != true )
            {
                self setClientDvar("r_sky_intensity_factor0", eplus );
            }
            if ( expoval >= 5.1 )
            {
                eOn = true;
            }
            if ( expoval >= 5.1 && eOn )
            {
                self setClientDvar("r_sky_intensity_factor0", eminus );
            }
            if ( expoval <= 2.2 )
            {
                eOn = false;
            }

            //timer = randomIntRange(0.05, 0.5 ); //change to randomintrange¨
            //self iPrintLnBold(timer);
            wait ( 0.1 );
        }     
    }     
}
*/
testingFX()
{
    level endon ("end_game");

    //self waittill("spawned_player");
    //NEED TO HAVE ( WAIT ) otherwise fx will not load
    wait 3;

    //pl = getplayers()[0];

    //self iPrintLnBold("EFFECT SHOULD APPEAR NOW!");
    randomlight = "lght_marker";
    org = ( 835.463, 594.962, -56.875 );
    playFX( level._effect[randomlight], ( org ) );
    
    wait 0.005;
    glowlight = "fx_zmb_tranzit_marker_glow";
    testglow1 = (-199.022, -385.919, -59.1801);

    playFx(level._effect[glowlight], (testglow1));
    //testglow2 = (200.368, -549.22, -66.6524)
    
    


    //playFx(level._effect[glowlight], (testglow1));
    
    //playFx(level._effect[glowlight], (testglow2));
    /*
    while (1)
    {
        rotateYaw( 360, 3 );
        wait 0.05;
    }
    */
}


spawnallMagic()
{
    level endon("end_game");
    
    level waittill("initial_blackscreen_passed");
    
    
    
    level.nuked2PerkArray = array( "specialty_fastreload", "specialty_armorvest", "specialty_quickrevive", "specialty_weapupgrade", "specialty_rof" );
        
    level.nuked2PerkArray["specialty_fastreload"] = spawnStruct();
    level.nuked2PerkArray["specialty_fastreload"].origin = (51078.1, 140028, 89392.3);
    level.nuked2PerkArray["specialty_fastreload"].angles = ( 0, 90, 0 );
    level.nuked2PerkArray["specialty_fastreload"].model = "zombie_vending_sleight";
    level.nuked2PerkArray["specialty_fastreload"].script_noteworthy = "specialty_fastreload";


    level.nuked2PerkArray["specialty_armorvest"] = spawnStruct();
    level.nuked2PerkArray["specialty_armorvest"].origin = ( 52078.1, 140128, 89992.3);
    level.nuked2PerkArray["specialty_armorvest"].angles = ( 0, 50, 0 );
    level.nuked2PerkArray["specialty_armorvest"].model = "zombie_vending_jugg";
    level.nuked2PerkArray["specialty_armorvest"].script_noteworthy = "specialty_armorvest";
    
}
vector_scal( vec, scale )
{
    vec = ( vec[ 0 ] * scale, vec[ 1 ] * scale,vec[ 2 ] * scale);
    return vec;
}

nukeCores()
{
    level endon("end_game");
    level waittill("initial_blackscreen_passed");

    wait .1;
    //playFx(level._effect["fx_zmb_nuke_linger_core"], (-38096.2, 67013.3, 1054.31));
    //playFx(level._effect["fx_zmb_nuke_linger_core"], (34441.9, 67013.3, 1054.31));
    //wait .1;
    

}

monitorPain()
{
    self endon("disconnect");
    level endon("end_game");

    self.allowpain = 0;

    self waittill("allowpainagain");

    self.allowpain = 1;
}

pAnglesOnSpawn()
{
    level endon("end_game");
    self endon("disconnect");
    self waittill("spawned_player");

    sAngles = ( 0, -90, 0 );
    self setPlayerAngles(sAngles);
}
goToHeaven( startOrigin, endOrigin, sOrigin, eOrigin )
{   /*
    startOrigin = from bunker to sky
    endOrigin = spawn on sky
    sOrigin = from sky to mars
    eOrigin = spawn on mars


    sEnter = bunker interact origin
    sSpawn = perk heaven spawn
    tEnter = perk heaven interact origin back to mars
    tExit = back to mars origin
    */
	level endon( "end_game" );
	
	sEnter = spawn("script_model", startOrigin);
    sEnter setModel( "tag_origin" );
	sEnter setCursorHint("HINT_NOICON");
	sEnter setHintString("Hold ^2[{+activate}] ^7to travel perk heaven");
	sEnter makeUsable();

    sSpawn = spawn("script_model", endOrigin);
    sSpawn setModel("tag_origin");
	

    tEnter = spawn("script_model", sOrigin );
    tEnter setModel("c_zom_dlc0_zom_head3");
    tEnter setCursorHint("HINT_NOICON");
    tEnter setHintString("Hold ^2[{+activate}] ^7to travel back to ^3City Of Mars^7");
    tEnter MakeUsable();

    tExit = spawn( "script_model", eOrigin );
    tExit setModel("tag_origin");
    //tExit setCursorHint("HINT_NOICON");

    entAngles = ( 0, -154.515, 0 );
    marsAngles = ( 0, 21.2362, 0 );
	while ( true ) //
	{
		wait .1;
		foreach ( player in level.players ) //fix this now it gets applied to everyone instead of justone //fixed
		{
			is_in_reach_enter = distance( player.origin, startOrigin );
            if ( is_in_reach_enter < 50 && player useButtonPressed() )
            {
                player setClientDvar( "r_poisonfx_debug_enable", 1 );
                player thread dizzyOut();
                player playsound( "zmb_meteor_activate"); 
                player playsound ( "zmb_endgame" );
                player thread whiteout();

                /*Grab player's fps value and save it.
                    Then change it to 125 to prevent stuck spots & floaty points. 
                    Return the saved value once player exits perk heaven.
                */
                oldfps = getDvarInt( "com_maxfps" );
                player waittill( "WeReady" );
                player setClientDvar( "r_poisonfx_debug_enable", 0 );

                playfx(level._effect[ "fx_elec_transformer_exp_lg_os" ], player.origin );
                wait .05;
                playfx(level._effect[ "fx_temp_exp_electrical_md" ], player.origin );
                
                player.ignoreme = 1;
                player setClientDvar("g_speed", 160 );
                player setOrigin( sSpawn.origin );
                player SetPlayerAngles( entAngles );
                player thread saveLoadOrigin();
                player notify( "show_print" );
                player thread spaceSongNew();
                
                player thread spacePack();
                player thread spacePackExtraBoost();
                playfx( level._effect[ "fx_zmb_blackhole_trap_end" ], player.origin );

                /*set fps limiter once player has been spawned in the perks heaven
                    will return the value back to player's og fps once leaving
                    perk heaven
                */
                player setClientDvar( "com_maxfps", 140 );
                player setClientDvar( "r_fog", 0 );
                player setClientDvar( "r_skyColorTemp", 3700 );
                player setClientDvar ( "r_sky_intensity_factor0", 4.9 );
                wait .15;

                continue;
            }

            is_in_reach_exit = distance( player.origin, sOrigin );
			if ( is_in_reach_exit < 50 && player useButtonPressed() )
			{
                
                player notify( "stop_loop" );
                player playsound( "zmb_meteor_activate"); 
                
                player thread dizzyOut();
                player waittill( "WeReady" );
                playfx( level._effect[ "fx_zmb_blackhole_trap_end" ], player.origin );

                player notify ( "removeSound" );
                player notify ( "stop_saveLoadOrigin" );
                player notify( "destroyHUD" );
                //notify to stop the color loop
                //player notify( "stopTemp" );
                player setClientDvar( "r_skipPvs", 0 );
				player setOrigin( tExit.origin );
                player setPlayerAngles( marsAngles );
                player notify( "stop_boost" );
                player notify( "stop_extra" );
                
                
                wait .05;

                playfx( level._effect[ "fx_zmb_blackhole_trap_end" ], player.origin );
                playfx(level._effect[ "fx_elec_transformer_exp_lg_os" ], player.origin );
                
                /* Return saved com_maxfps back to player upon exiting perk heaven */
                player setClientDvar( "g_speed", 196 );
                player setClientDvar( "com_maxfps", oldfps );
                player setClientDvar( "r_fog", 1 );
                player setClientDvar( "r_skyColorTemp", 1650 );
                player setClientDvar ( "r_sky_intensity_factor0", 6.2);
                player.ignoreme = 0;
                player DisableInvulnerability();

                if ( getDvar( "r_skyTransition" ) == 1 )
                {
                    player setClientDvar( "r_skyTransition", 0 );
                }
				continue;
			}
        }
	}
}

saveLoadOrigin()
{
    level endon("end_game");
    self endon("disconnect");
    self endon("stop_saveLoadOrigin");
    gotorigin = false;
    safe_spawn = (51291.4, -139693, 89389.1);
    hassaved = 0;
    while ( true )
    {
        wait .05;

        if ( self meleeButtonPressed() )
        {
            get = self getOrigin();
            hassaved = 1;
            gotorigin = true;
        }

        if ( self ActionSlotOneButtonPressed() && !hassaved )
        {
            self setOrigin( safe_spawn );
        }

        if ( self ActionSlotTwoButtonPressed() )
        {
            self setOrigin( safe_spawn );
        }
        else if ( self ActionSlotOneButtonPressed() && gotorigin )
        {
            self setOrigin( get );
        }
    }
}

printSaveInfo() //fix this, its printing to everyone, make it to print only self
{
    level endon("end_game");
    self endon("disconnect");
    
    while ( true )
    {
        self waittill( "show_print" );
        
        self.info = createFontString( "Objective", 1.2 );
        self.info setPoint( "LEFT", "BOTTOM", -400, -20/*"LEFT"*/ );

        self.info.color = ( 1, 1, 1 );
        self.info settext( "Hold ^2[{+melee}]^7 to save your position\nHold ^5[{+actionslot 1}]^7 to load your saved position\nHold ^6[{+actionslot 2}]^7 to load a failsafe position" );
        //self.info.fontscale = 1.3;
        self.info.alpha = 0.0;
        self.info fadeovertime( 1.5 );
        self.info.alpha = 0.8;
        
        self waittill( "destroyHUD" );
        self.info destroy_hud();
    }
    
    
}

printsaves()
{
    level endon("end_game");
    self endon("disconnect");
    self endon("stopPrintingInfo");

    wait 3;

    while ( true )
    {
        self iPrintLn("Hold ^2[{+melee}]^7 to save your position" );
        wait 1.5;
        self iprintln( "Hold ^3[{+actionslot1}]^7 to spawn on saved position" );
        wait 30;
    }
}

jumpstuffOFF()
{
    level endon("end_game");
    self endon("disconnect");

    wait .05;
    self setClientDvar( "bg_gravity", 800 );
    wait .01;
    self setClientDvar( "jump_height", 39 );

}

jumpstuffON()
{
    level endon( "end_game" );
    self endon("disconnect");

    wait .05;
    self setClientDvar( "bg_gravity", 250 );
    wait .01;
    self setClientDvar( "jump_height", 999 );
}

spacePack()
{
    
    level endon( "end_game" );
    self endon( "disconnect" );
    self endon( "stop_boost" );

    self.sprint_boost = 0;
    self.jump_boost = 0;
    self.second_boost = 0;
    while( true )
    {
        if( !self IsOnGround() )
        {   
            self.sprint_boost = 0;
            self.jump_boost = 0;
            self.second_boost = 0;
            while( !self IsOnGround() )
            {
                if( self JumpButtonPressed() && self.jump_boost < 1 )
                {
                    self.is_flying_jetpack = true;
                    self.jump_boost++;
                    angles = self getplayerangles();
                    angles = ( 0,angles[ 1 ], 0 );
                    
                    self.loop_value = 10;
                    
                    if( IsDefined( self.loop_value ) )
                    {
                        direction = AnglesToUp( angles ) * 3000;
                        direction2 = anglesToForward( angles ) * 15;
                        self thread land();
                        for( l = 0; l < self.loop_value; l++ )
                        {
                            self SetVelocity( self getVelocity() + direction + direction2 );
                            wait .05;
                        }
                    }
                    
                    if( self JumpButtonPressed() && self.jump_boost >= 1 )
                    {
                        self.is_flying_jetpack = true;
                        self.second_boost++;
                        angles = self getplayerangles();
                        angles = ( 0 ,angles[ 1 ], 0 );
                        
                        self.loop_value = 4;
                        
                        if( IsDefined( self.loop_value ) )
                        {
                            direction = AnglesToUp(angles) * 3000;
                            
                            self thread land();
                            for( l = 0; l < self.loop_value; l++ )
                            {
                                self SetVelocity( self getVelocity() + direction  );
                                wait .05;
                            }
                        }
                    }       
                    
                }
                wait 0.05;
            }
        }
        wait 0.05;
    }
}

spacePackExtraBoost()
{
    
    level endon( "end_game" );
    self endon( "disconnect" );
    self endon( "stop_extra" );

    self.sprint_boost = 0;
    self.jump_boost = 0;
    self.second_boost = 0;
    while( true )
    {
        if( !self IsOnGround() )
        {   
            self.sprint_boost = 0;
            self.jump_boost = 0;
            self.second_boost = 0;
            while( !self IsOnGround() )
            {
                if( self JumpButtonPressed() && self.jump_boost < 1 )
                {
                    self.is_flying_jetpack = true;
                    self.jump_boost++;
                    angles = self getplayerangles();
                    angles = ( 0,angles[ 1 ], 0 );
                    
                    self.loop_value = 10;
                    
                    if( IsDefined( self.loop_value ) )
                    {
                        direction = AnglesToUp( angles ) * 3000;
                        direction2 = anglesToForward( angles ) * 15; //35 if loopvalue = 6
                        self thread land();
                        for( l = 0; l < self.loop_value; l++ )
                        {
                            self SetVelocity( self getVelocity() + direction + direction2 );
                            wait .05;
                        }
                        
                    }
                    
                    if( self JumpButtonPressed() && self.jump_boost >= 1 )
                    {
                        self.is_flying_jetpack = true;
                        self.second_boost++;
                        angles = self getplayerangles();
                        angles = ( 0 ,angles[ 1 ], 0 );
                        
                        self.loop_value = 4;
                        
                        if( IsDefined( self.loop_value ) )
                        {
                            direction = AnglesToUp(angles) * 3000;
                            
                            self thread land();
                            for( l = 0; l < self.loop_value; l++ )
                            {
                                self SetVelocity( self getVelocity() + direction  );
                                wait .05;
                            }
                        }
                    }       
                    
                }
                wait 0.05;
            }
        }
        wait 0.05;
    }
}

land()
{
    while( !self IsOnGround() )
        wait .1;
    self AllowMelee(true);
    self.is_flying_jetpack = false;
}

dizzyOut() //fake fade player when entering teleporter
{
    level endon( "end_game" );
    
    wait 1;
    self freezecontrols( true );
    self enableinvulnerability();
    self disableWeapons();

    self freezecontrols( true );

    dark = 4.8;
    
    while ( 1 )
    {
        dark += 0.3;

        
        self setClientDvar ( "r_exposureValue", dark );
        wait 0.1;

        if ( dark >= 15.9 )
        {
            self notify ( "WeReady" );
            self setClientDvar("r_exposureValue", 4.8 );
            self setClientDvar("r_skipPvs", 1 );
            
            self enableWeapons();
            self freezeControls( 0 );

            break;
        }
        
    }

    
	
}

whiteout()
{
    level endon ( "end_game" );

    wait 1;
        
    white = 2.0;

    while ( white <= 3 )
    {
        white += 0.1;
        self setClientDvar( "r_exposureValue", white );
        wait 0.5;

        if ( white == 2.5 )
        {
            wait .2;

            while ( true )
            {
                white += 0.05;
                self setClientDvar( "r_exposureValue", white );
                wait .01;

                if ( white >= 3 )
                {
                    self setClientDvar( "r_exposureValue", 4.8 );
                    break;
                }
            }
        }
    }
}

precache_fx()
{
    level endon ("end_game");

    //PlayFX ( level._effect["lght_marker"], ( 835.463, 594.962, -56.875 ) );
    level._effect["lght_marker"] = loadfx( "maps/zombie/fx_zombie_coast_marker" );

    //SNOW
    level._effect[ "player_snow" ] = loadfx( "maps/zombie_tomb/fx_tomb_player_weather_snow" );

    //glow
    level._effect[ "special_glow" ] = loadfx( "maps/zombie_tomb/fx_tomb_elem_reveal_glow" );

    //explosion 1
    level._effect[ "fx_zm_nuked_exp_perk_impact_int" ] = loadfx( "explosions/fx_zm_nuked_exp_perk_impact_int");

    //explosion bigger
    level._effect["fx_zm_nuked_exp_perk_impact_ext"] = loadfx( "explosions/fx_zm_nuked_exp_perk_impact_ext");

    //doubletap
    level._effect[ "doubletap_light" ] = loadfx( "maps/zombie_alcatraz/fx_alcatraz_perk_smk" );

    level._effect["fx_zmb_tranzit_marker_glow"] = loadfx( "maps/zombie/fx_zmb_tranzit_marker_glow");
    level._effect["fx_zmb_tranzit_marker"] = loadfx( "maps/zombie/fx_zmb_tranzit_marker_glow");


    level._effect["fx_snow_sm_em"] = loadfx("system_elements/fx_snow_sm_em");
    level._effect["fx_heli_water_spray"] = loadfx( "vehicle/treadfx/fx_heli_water_spray");

    //TESTING NEW FXS TO LOAD

    level._effect["fx_elec_spark_bounce_blue"] = loadfx("electrical/fx_elec_spark_bounce_blue"); //not working

    //November 22nd, 2021
    level._effect["fx_zmb_blackhole_trap_end"] = loadfx("maps/zombie/fx_zmb_blackhole_trap_end");
    level._effect["fx_zmb_cola_revive_flicker"] = loadfx("maps/zombie/fx_zmb_cola_revive_flicker");
    level._effect["fx_zombie_dog_lightning_buildup"] = loadfx("maps/zombie/fx_zombie_dog_lightning_buildup");
    level._effect["fx_zombie_monkey_light"] = loadfx("maps/zombie/fx_zombie_monkey_light");
    level._effect["fx_zombie_packapunch"] = loadfx("maps/zombie/fx_zombie_packapunch");
    level._effect["fx_theater_mode_camera_head_glow_red"] = loadfx("misc/fx_theater_mode_camera_head_glow_red");
    level._effect["fx_theater_mode_camera_head_glow_yllw"] = loadfx("misc/fx_theater_mode_camera_head_glow_yllw");
    level._effect["fx_zombie_cola_dtap_on"] = loadfx("misc/fx_zombie_cola_dtap_on");
    level._effect["fx_zombie_cola_jugg_on"] = loadfx("misc/fx_zombie_cola_jugg_on");
    level._effect["fx_zombie_powerup_wave"] = loadfx("misc/fx_zombie_powerup_wave");
    level._effect["fx_heli_dust_default"] = loadfx("misc/fx_heli_dust_default");
    level._effect["fx_zm_raygun2_ug_view"] = loadfx("weapon/raygun2/fx_zm_raygun2_ug_view");
    level._effect["fx_zm_raygun2_bolt_emit"] = loadfx("weapon/raygun2/fx_zm_raygun2_bolt_emit");
    level._effect["fx_weapon_attchmnt_laser_point_red"] = loadfx("weapon/laser/fx_weapon_attchmnt_laser_point_red");
    level._effect["fx_laser_sight_attchmnt_3p"] = loadfx("weapon/laser/fx_laser_sight_attchmnt_3p");
    level._effect["fx_emp_explosion_equip"] = loadfx("emp/fx_emp_explosion_equip");
    level._effect["fx_ir_scope_heartbeat"] = loadfx("ir_scope/fx_ir_scope_heartbeat");
    level._effect["fx_elec_transformer_exp_lg_os"] = loadfx("electrical/fx_elec_transformer_exp_lg_os");
    level._effect["fx_dest_elec_shower"] = loadfx("destructibles/fx_dest_elec_shower");
    level._effect["fx_dest_window_glass_edge"] = loadfx("destructibles/fx_dest_window_glass_edge");
    level._effect["fx_dest_elec_box"] = loadfx("destructibles/fx_dest_elec_box");
    level._effect["fx_player_water_waist_ripple"] = loadfx("bio/player/fx_player_water_waist_ripple");
    level._effect["fx_theater_mode_camera_head_glow_grn"] = loadfx("misc/fx_theater_mode_camera_head_glow_grn");
    level._effect["fx_theater_mode_camera_head_glow_white"] = loadfx("misc/fx_theater_mode_camera_head_glow_white");
    level._effect["fx_theater_mode_camera_head"] = loadfx("misc/fx_theater_mode_camera_head");
    level._effect["fx_zombie_cola_revive_on"] = loadfx("misc/fx_zombie_cola_revive_on");
    level._effect["fx_zombie_powerup_caution_wave"] = loadfx("misc/fx_zombie_powerup_caution_wave");
    level._effect["fx_plane_smoke_damage_emit"] = loadfx("system_elements/fx_plane_smoke_damage_emit");
    level._effect["fx_temp_exp_electrical_md"] = loadfx("temp_effects/fx_temp_exp_electrical_md");

    level._effect[ "claymore_laser" ] = loadfx( "weapon/claymore/fx_claymore_laser" );
    level._effect[ "rocket_fx" ] = loadfx( "maps/zombie/fx_zmb_trail_perk_meteor" );
}



/* EFFECTS, ORIGIN & ARRAY */

floatingSpaceAmbers()
{
    level endon("end_game");
    
    flag_wait("initial_blackscreen_passed");

    wait 40;
    //space amber count = 26
    playFx(level._effect["fx_ash_embers_up_lg"], (54450.9, 138546, 89784.9));
    playFx(level._effect["fx_ash_embers_up_lg"], (50422.9, 139441, 89484.2));
    playFx(level._effect["fx_ash_embers_up_lg"], (51826.3, 139845, 89398.3));
    playFx(level._effect["fx_ash_embers_up_lg"], (52273.9, 139398, 89586.3));
    wait 1;
    playFx(level._effect["fx_ash_embers_up_lg"], (52253.4, 140035, 89578.5));
    playFx(level._effect["fx_ash_embers_up_lg"], (52800.4, 139903, 89369.8));
    playFx(level._effect["fx_ash_embers_up_lg"], (53267.4, 140140, 89101.2));
    playFx(level._effect["fx_ash_embers_up_lg"], (52716.4, 142781, 89245.4));
    wait 1;
    playFx(level._effect["fx_ash_embers_up_lg"], (54763, 144131, 89442.6));
    playFx(level._effect["fx_ash_embers_up_lg"], (54538.6, 143392, 88724.8));
    playFx(level._effect["fx_ash_embers_up_lg"], (53911.2, 141023, 89083.2));
    playFx(level._effect["fx_ash_embers_up_lg"], (54696, 140630, 88873.5));
    wait 1;
    playFx(level._effect["fx_ash_embers_up_lg"], (54609.4, 143460, 91266.5));
    playFx(level._effect["fx_ash_embers_up_lg"], (55124, 142091, 91745.9));
    playFx(level._effect["fx_ash_embers_up_lg"], (56135.6, 142672, 91738.6));
    wait 1;
    playFx(level._effect["fx_ash_embers_up_lg"], (57005.2, 142702, 91046.5));
    playFx(level._effect["fx_ash_embers_up_lg"], (58211.5, 143699, 90318.6));
    playFx(level._effect["fx_ash_embers_up_lg"], (59371.5, 142843, 89165.5));
    wait 1;
    playFx(level._effect["fx_ash_embers_up_lg"], (60491.7, 141752, 88754.7));
    playFx(level._effect["fx_ash_embers_up_lg"], (60022.6, 142541, 88749));
    playFx(level._effect["fx_ash_embers_up_lg"], (59476, 141802, 88593));
    wait 1;
    playFx(level._effect["fx_ash_embers_up_lg"], (59762.5, 141843, 88777.7));
    playFx(level._effect["fx_ash_embers_up_lg"], (59567.5, 142172, 88761.7));
    playFx(level._effect["fx_ash_embers_up_lg"], (60340.2, 142510, 88744.2));
    wait 1;
    playFx(level._effect["fx_ash_embers_up_lg"], (50487.8, 140440, 89623.2));
    playFx(level._effect["fx_ash_embers_up_lg"], (51215.2, 139567, 89405.2));
    wait 1;
}




lampFires()
{
    level endon ("end_game");

    flag_wait ( "initial_blackscreen_passed" );

    level.lampfirefx = [];
    level.lampfireloc = [];
    firefx = 0;
    fireloc = 0;
    curFX = level.lampfirefx[firefx];
    curLoc = level.lampfireloc[fireloc];
    fireplace = "fx_fire_fireplace_md";


    level.smallsparkfxa = [];
    level.smallsparkloca = [];
    smallsparkfx = 0;
    smallsparkloc = 0;
    sparkfx = level.smallsparkfxa[smallsparkfx];
    sparkloc = level.smallsparkloca[smallsparkloc];
    smallspark = "fx_mp_elec_spark_burst_xsm_thin_runner";


    level.sparkwirefx = [];
    level.sparkwireloc = [];
    wirefx = 0;
    wireloc = 0;
    curWire = level.sparkwirefx[wirefx];
    cureWireLoc = level.sparkwireloc[wireloc];
    wirealias = "fx_elec_spark_wire_xsm_runner";

    level.transformerfx = [];
    level.transformerloc = [];
    tfxn = 0;
    tfxlocn = 0;
    curtransformerfx = level.transformerfx[tfxn];
    curtransformerloc = level.transformerloc[tfxlocn];
    transalias = "fx_elec_transformer_sparks_runner";

    level.firewallfx = [];
    level.firewallloc = [];
    firewfx = 0;
    firewloc = 0;
    curFirewfx = level.firewallfx[firewfx];
    curFirewloc = level.firewallloc[firewloc];
    firewall = "fx_fire_wall_wood_ext_md";


    level.transitfirefx = [];
    level.transitfireloc = [];
    tfx = 0;
    tloc = 0;
    curtfx = level.transitfirefx[tfx];
    curtloc = level.transitfireloc[tloc];
    tfire = "fx_zmb_tranzit_fire_lrg";


    level.ceilingfx = [];
    level.ceilingloc = [];
    lfx = 0;
    lloc = 0;
    curlfx = level.ceilingfx[lfx];
    curlloc = level.ceilingloc[lloc];
    cfire = "fx_nic_fire_ceiling_edge_sm";


    while( true )
    {
        level.ceilingfx[0] = "fx_nic_fire_ceiling_edge_sm";

        level.ceilingloc[0] = (-168.64, -1138.82, 79.9948);
        level.ceilingloc[1] = (789049, -421010, 447383);
        level.ceilingloc[2] = (-164.414, -1118.51, 63.5727);
        level.ceilingloc[3] = (-168.956, -1077.27, -59.4552);
        level.ceilingloc[4] = (535.245, -861.056, -63.2943);


        level.transitfirefx[0] = "fx_zmb_tranzit_fire_lrg";
        //level.transitfireloc[0] = (458.498, -2731.23, 107.633);
        level.transitfireloc[0] = (459.874, -2731.85, 158.014);
        //level.transitfireloc[2] = (460.399, -2732.1, 196.601);
        
        //level.transitfireloc[1] = (-16399.5, -998261, 56631.1);



        ////////////////////////////////////////////////////////////////

        //////////////////////////////////////////////////////////////////////////

        level.transformerfx[0] = "fx_elec_transformer_sparks_runner";

        level.transformerloc[0] = (343.661, -581.745, 232.318);
        //level.transformerloc[1] = (351.714, -570.393, 210.161);
        //level.transformerloc[2] = (343.661, -581.745, 232.318);
        level.transformerloc[1] = (-228.881, -1836.52, 247.878);
        level.transformerloc[2] = (-234.955, -1821.22, 212.643);
        
        ////////////////////////////////////////////////////////////////////////////

        level.firewallfx[0] = "fx_fire_wall_wood_ext_md";
        /*
        level.firewallloc[0] = (-1862.37, 836.575, 65.2501);
        level.firewallloc[1] = (-1791.97, 811.909, 64.7627);
        level.firewallloc[2] = (-1755.73, 796.286, 65.9994);
        level.firewallloc[3] = (-1856.04, 704.229, -30.9758);
        level.firewallloc[4] = (-1798.55, 688.834, 18.4534);
        
        level.firewallloc[5] = (-1796.92, 769.843, 87.0657);
        level.firewallloc[6] = (-1737.03, 747.159, 87.5167);
        level.firewallloc[7] = (-1635.3, 769.923, -57.793);
        level.firewallloc[8] = (-1628.61, 762.15, -54.9963);
        level.firewallloc[9] = (-1701.02, 799.257, -63.1233);
        */
        level.firewallloc[10] = (-200.222, -671.637, 82.9658);
        level.firewallloc[11] = (207.925, -769.729, 76.4309);
        
        //level.firewallloc[] = 
        
        ////////////////////////////////////////////////////////////////////////////


        break;
    }
    
    wait .2;
    wait .05;
    foreach( tfxlocn in level.transformerloc )
    {
        playfx( level._effect[ transalias ], ( tfxlocn ) );
    }
    wait 0.05;
    foreach ( firewloc in level.firewallloc )
    {
        playfx( level._effect[ firewall ], ( firewloc ) );
    
    } //commented out
    wait 0.05;
    
    foreach( tloc in level.transitfireloc )
    {
        playfx( level._effect[ tfire ], ( tloc ) );
    }
    wait 0.05;
    /*
    foreach( lloc in level.ceilingloc )
    {
        playfx(level._effect[ cfire ], ( lloc ) );
    }
    */
    
}

risingsmokefxs()
{
    level endon( "end_game");

    flag_wait( "initial_blackscreen_passed" );

    level.smokeblackfx = [];
    level.smokeblackloc = [];
    blackfx = 0;
    blackloc = 0;
    curblackfx = level.smokeblackfx[blackfx];
    curblackloc = level.smokeblackloc[blackloc];
    smoke = "fx_smk_fire_lg_black";

    level.smokeplumefx = [];
    level.smokeplumeloc = [];
    sfx = 0;
    sloc = 0;
    cursfx = level.smokeplumefx[sfx];
    cursloc = level.smokeplumeloc[sloc];
    plume = "fx_smk_plume_md_blk_wispy_dist";

    level.smblackfx = [];
    level.smblackloc = [];
    smfx = 0;
    smloc = 0;
    cursm = level.smblackfx[smfx];
    cursmloc = level.smblackloc[smloc];
    sm = "fx_smk_wood_sm_black";

    while ( true ) //FIX SMOKES!!! //fixed
    {

        level.smblackfx[0] = "fx_smk_wood_sm_black";
        level.smblackloc[0] = (-244.284, -1807.01, 208.035);
        
        level.smblackloc[1] = (-248.593, -379.382, 235.106);
        /*
        level.smblackloc[2] = (-618.141, 1488.66, -221.597);
        */

        //////////////////////////////////////////////////////////////////////

        level.smokeblackfx[0] = "fx_smk_fire_lg_black";

        //level.smokeblackloc[0] = (707.065, -2030.91, 169.936);
        level.smokeblackloc[0] = (771.715, -2025.53, 188.618);
        //level.smokeblackloc[2] = (761.263, -2025.53, 187.467);
        level.smokeblackloc[1] = (-897.262, -632.225, 192.21);
        
        
        level.smokeblackloc[4] = (-2616.75, 891.722, -121.103);
        //level.smokeblackloc[5] = (-1853.33, 792.232, 86.1218);
        
        level.smokeplumefx[0] = "fx_smk_plume_md_blk_wispy_dist";

        level.smokeplumeloc[0] = (-1891.18, -1848.31, -77.6658);
        level.smokeplumeloc[1] = (-1065.68, -824.731, 94.8167);
        /*
        level.smokeplumeloc[2] = (-3054.31, -649.259, 68.4666);
        level.smokeplumeloc[3] = (-347.222, -2157.11, -59.0929);
        level.smokeplumeloc[4] = (-166.461, -1137.23, 79.9162);
        level.smokeplumeloc[5] = (353.638, -557.27, 211.853);
        level.smokeplumeloc[6] = (353.639, -557.268, 211.849);
        */
        break;
    }
    /*
    foreach ( blackloc in level.smokeblackloc )
    {
        playfx( level._effect[ smoke ], blackloc );
    }
    wait 0.1;

    foreach( sloc in level.smokeplumeloc )
    {
        playfx( level._effect[ plume ], sloc );
    }

    wait .1;
    foreach( smloc in level.smblackloc )
    {
        playfx( level._effect[ sm ], ( smloc ) );
    }
    */
}

fxboxes1()
{
    level endon ( "end_game" );

    level waittill( "initial_blackscreen_passed" );

    wait .2;
    
    fireW = "fx_zmb_nuke_fire_windblown_md";
    o1 = (-449.294, 636.945, -55.2801);
    
    o3 = (-414.911, 620.577, -53.8392);

    playFx( level._effect[ fireW ], (o1) );
    wait .005;
    
    wait .005;
    playFx( level._effect[ fireW ], (o3) );
    wait .005;

    smk = "fx_smk_wood_sm_black";
    o4 = (-442.176, 633.561, -55.7521);

    playFx( level._effect[ smk ], (o4) );

    wait .005;
    lg = "fx_smk_fire_lg_black";
    o5 = (-440.677, 632.839, -53.8688);

    playFx( level._effect[ lg ], (o5) );
    wait .005;

    spk = "fx_elec_transformer_sparks_runner";
    o6 = (-444.02, 638.947, -64.246);
    playFx( level._effect[ spk ], (o6) );
    
}

fxboxes2()
{
    level endon ( "end_game" );

    level waittill( "initial_blackscreen_passed" );

    wait .2;

    fp = "fx_fire_fireplace_md";
    
    o1 = (-102.292, 784.483, -64.0206);
    playFx(level._effect[fp], (o1));
    wait .005;
    o2 = (-103.111, 705.93, -63.9528);
    playFx(level._effect[fp], (o2));
    wait .005;
    o3 = (-126.977, 750.498, -64);
    playFx(level._effect[fp], (o3));
    wait .005;
    o4 = (-120.986, 721.726, -64);
    playFx(level._effect[fp], (o4));
    wait .005;
    o5 = (-58.6508, 720.43, -64);
    playFx(level._effect[fp], (o5));
    wait .005;
    o6 = (-74.5267, 712.513, -63.8726);
    playFx(level._effect[fp], (o6));
    wait .005;
    o7 = (-87.405, 704.419, -63.8227);
    playFx(level._effect[fp], (o7));
    wait .005;
    o8 = (-121.732, 769.919, -64);
    playFx(level._effect[fp], (o8));
    wait .005;
    o9 = (-75.8831, 770.772, -64.1713);
    playFx(level._effect[fp], (o9));
    wait .005;
    o0 = (-63.9762, 746.207, -64);
    playFx(level._effect[fp], (o0));
    wait .005;
    o11 = (-84.5449, 783.918, -64.2888);
    playFx(level._effect[fp], (o11));
    wait .005;

    fb = "fx_zmb_nuke_fire_windblown_md";
    u1 = (-112.836, 744.934, -58.3623);
    playFx(level._effect[fb], (u1));
    wait .005;

    sm = "fx_smk_wood_sm_black";
    j1 = (-61.0539, 735.902, -58.4215);
    playFx( level._effect[sm], (j1));
}


randomfxs()
{
    level endon("end_game");

    //level waittill("initial_blackscreen_passed");
    wait .01;
    level.fireplacefx = [];
    level.fireplaceloc = [];

    firefx = 0;
    fireloc = 0;

    curfirefx = level.fireplacefx[firefx];
    curfireloc = level.fireplaceloc[fireloc];
    firep = "fx_fire_fireplace_md";

    while ( true )
    {
        level.fireplacefx[0] = "fx_fire_fireplace_md";

        level.fireplaceloc[0] = (-1315.26, 1085.72, 16.187);
        level.fireplaceloc[1] = (1581.28, 981.65, -59.7338);
        level.fireplaceloc[2] = (1581.76, 957.665, -61.163);
        level.fireplaceloc[3] = (1571.2, 925.371, -61.3135);
        level.fireplaceloc[4] = (1580.45, 917.928, -59.9781);
        level.fireplaceloc[5] = (1593.32, 899.4, -59.0119);
        level.fireplaceloc[6] = (1596.65, 916.98, -51.5787);
        level.fireplaceloc[7] = (1619.99, 894.798, -59.4783);
        level.fireplaceloc[8] = (1601.47, 885.217, -61.3699);
        level.fireplaceloc[9] = (1628.99, 870.35, -62.8952);
        level.fireplaceloc[10] = (1651.37, 863.243, -65.3298);
        level.fireplaceloc[11] = (1675.83, 869.738, -65.4679);
        break;
    }

    foreach ( fireloc in level.fireplaceloc )
    {
        playfx(level._effect[firep], (fireloc));
    }
}

bunker1fx()
{
    level endon("end_game");

    //level waittill("initial_blackscreen_passed");
    wait .01;

    level.elecart = [];
    level.elecartloc = [];
    elecloc = 0;
    elecfx = 0;
    curloc = level.elecartloc[elecloc];
    curfx = level.elecart[elecfx];
    alias = "fx_zm_elec_arc_vert";

    level.wires = [];
    level.wireloc = [];
    wire = 0;
    wireloc = 0;
    curwire = level.wires[wire];
    curwireloc = level.wireloc[wireloc];
    wirealias = "fx_elec_spark_wire_xsm_runner";

    level.bursts = [];
    level.burstloc = [];
    burloc = 0;
    burfx = 0;
    curbur = level.bursts[burfx];
    curburloc = level.burstloc[burloc];
    burali = "fx_mp_elec_spark_burst_xsm_thin_runner";

    level.bunker1fire = [];
    bunkNum = 0;
    curBunkerLoc = level.bunker1fire[bunkNum];
    fireAlias = "fx_zmb_tranzit_fire_med";

    level.smokethis = [];
    smokeNum = 0;
    curSmokeThis = level.smokethis[smokeNum];
    smokeAlias = "fx_smk_wood_sm_black";

    
    while ( true )
    {
        level.bursts[0] = "fx_mp_elec_spark_burst_xsm_thin_runner";

        level.burstloc[0] = (-1284.68, 1078.29, 16.187);
        level.burstloc[1] = (-1289.22, 1066.74, 16.187);
        level.burstloc[2] = (-1401.53, 1054.41, -32.5504);
        level.burstloc[3] = (-1394.07, 1074.66, -32.1396);
        level.burstloc[4] = (-1385.99, 1097.21, -32.707);
        level.burstloc[5] = (-1388.41, 1125.12, -25.4413);
        level.burstloc[6] = (-1397.55, 1045.1, -31.9079);
        level.burstloc[7] = (-1387.32, 1040.9, -32.1021);
        level.burstloc[8] = (-1373.33, 1035.27, -32.1244);
        level.burstloc[9] = (-1313.89, 1013.52, -32.396);
        level.burstloc[10] = (-1298.95, 1009.11, -31.946);
        level.burstloc[11] = (-1282.34, 1003.79, -31.4045);
        level.burstloc[12] = (-1276.53, 1012.78, -32.0378);
        level.burstloc[13] = (-1270.16, 1029.87, -33.4719);
        level.burstloc[14] = (-1261.91, 1051.9, -34.4196);
        level.burstloc[15] = (-1254.38, 1073.48, -31.6278);

        level.elecart[0] = "fx_zm_elec_arc_vert";

        level.elecartloc[0] = (-1299.81, 1115.85, -68.6253);
        level.elecartloc[1] = (-1287.39, 1052.77, -64);
        level.elecartloc[2] = (-1378.83, 1085.83, -64);
        level.elecartloc[3] = (-1290.13, 1055.43, -64);
        level.elecartloc[4] = (-1363.68, 1082.95, -64);
        level.elecartloc[5] = (-1302.83, 1055.85, -64);
        //level.elecartloc[6] = (-1339.88, 1082.8, -64);
        //level.elecartloc[7] = (-1290.51, 1078.01, -64);
        //level.elecartloc[8] = (-1363.61, 1061.31, -64);
        //level.elecartloc[9] = (-1293.92, 1089.13, -64);
        //level.elecartloc[10] = (-1328.11, 1098.36, -64);
        //level.elecartloc[11] = (-1322.78, 1069.62, -64);
        

        level.wire[0] = "fx_elec_spark_wire_xsm_runner";

        level.wireloc[0] = (-1285.79, 1077.22, 16.187);
        level.wireloc[1] = (-1285.48, 1076.8, 16.187);
        level.wireloc[2] = (-1284.96, 1077.19, 16.187);
        level.wireloc[3] = (-1285.47, 1076.97, 16.187);
        level.wireloc[4] = (-1284.95, 1077.19, 16.187);
        

        //level.bunker1fire[0] = (-1295.34, 1059.71, 4.46001);
        level.bunker1fire[0] = (-1354.72, 1081.89, 4.25756);
        level.bunker1fire[1] = (-1326.65, 1072.39, 4.20887);
        //level.bunker1fire[4] = (-1347.06, 1089.88, 11.1853);
        
        level.smokethis[0] = (-1310.51, 1083.66, 4.36124);
        
        break;
    }

    foreach( burloc in level.burstloc )
    {
        playfx( level._effect[burali], (burloc) );
        wait( randomFloatRange( 0.01, 0.2 ) );
        
    }
    wait .4;

    foreach ( curSmokeThis in level.smokethis )
    {
        playfx(level._effect[smokeAlias], curSmokeThis );
        wait .1;
    }

    foreach( curBunkerLoc in level.bunker1fire )
    {
        playfx( level._effect[fireAlias], curBunkerLoc );
        wait 1;
    }

    
    wait .01;
    foreach ( elecloc in level.elecartloc )
    {
        playfx(level._effect[alias], (elecloc));
        wait 0.08;
    }
    wait .01;
    foreach ( wireloc in level.wireloc )
    {
        playfx(level._effect[wirealias], (wireloc ) );
        //wait 0.08;
    }

}

darksmokes()
{
    level endon("end_game");
    level waittill("initial_blackscreen_passed");

    wait .1;

    level.bigsmokes = [];
    level.bigsmokesloc = [];

    loc = 0;
    fx = 0;

    curloc = level.bigsmokesloc[loc];
    curfx = level.bigsmokes[fx];
    alias = "fx_smk_fire_lg_black";

    while ( true )
    {
        level.bigsmokes[0] = "fx_smk_fire_lg_black";

        level.bigsmokesloc[0] = (742.237, -2025.53, 175.737);
        //level.bigsmokesloc[1] = (781.12, 285.601, 116.137);
        //level.bigsmokesloc[1] = (3699.52, 621.094, -105.116);
        //level.bigsmokesloc[2] = (5172.35, -2079.55, -142.521);
        //level.bigsmokesloc[3] = (-2535.84, -1545.99, -145.374);
        break;

    }
    foreach (loc in level.bigsmokesloc )
    {
        playfx( level._effect[alias], (loc ) );
    }
}

randomfiresanddust()
{
    level endon( "end_game" );
    level waittill( "initial_blackscreen_passed" );

    wait .1;

    level.fires = [];
    level.firesloc = [];
    loc = 0;
    fx = 0;
    curloc = level.firesloc[loc];
    curfx = level.fires[fx];
    alias = "fx_fire_fireplace_md";
    

    level.sands = [];
    level.sand = [];
    sandloc = 0;
    sandfx = 0;
    cursand = level.sands[sandfx];
    cursands = level.sand[sandloc];
    allu = "fx_zmb_nuke_sand_windy_hvy_md";

    level.cefire = [];
    level.cefireloc = [];
    celoc = 0;
    cefx = 0;
    curCe = level.cefire[cefx];
    curCeLoc = level.cefireloc[celoc];
    ceal = "fx_nic_fire_ceiling_edge_sm";
    while (true)
    {
        level.cefire[0] = "fx_nic_fire_ceiling_edge_sm";
        level.cefireloc[0] = (2047.7, 176.044, -62.0729);
        //level.cefireloc[1] = (2029.42, 173.937, -29.5804);
        level.cefireloc[1] = (2075.3, 171.968, -42.8532);
        //level.cefireloc[3] = (2099.03, 191.225, -40.7448);
        level.cefireloc[2] = (2095.85, 201.502, -44.7303);
        //level.cefireloc[5] = (2098.53, 192.855, -63.7954);
        //level.cefireloc[3] = (2072.79, 182.976, -50.1366);
        //level.cefireloc[7] = (2040.21, 169.451, -15.7601);
        level.cefireloc[4] = (2028.76, 170.769, -61.1664);
        level.cefireloc[5] = (359.717, -564.915, 209.35);
        //level.cefireloc[6] = (328.12, -562.986, 239.751);
        //level.cefireloc[7] = (346.459, -577.293, 228.023);

        
        break;
    }
    /*

    foreach( celoc in level.cefireloc )
    {
        playfx( level._effect[ceal], (celoc) );
    }
    */
    wait 0.01;
    /*
    foreach( sandloc in level.sand )
    {
        playfx(level._effect[allu], (sandloc) );
    }
    */
    wait .01;
    /*
    foreach( loc in level.firesloc )
    {
        playfx(level._effect[alias], (loc ) );
    }
    */
    wait .01;
}

morefire()
{
    level endon( "end_game" );
    level waittill( "initial_blackscreen_passed" );
    wait .1;

    level.firefx = [];
    level.fireloc = [];
    firefxx = 0;
    firelocc = 0;
    curfx = level.firefx[firefxx];
    curloc = level.fireloc[firelocc];
    alias = "fx_fire_wall_wood_ext_md";


    level.nicfx = [];
    level.nicloc = [];
    locnicc = 0;
    fxnic = 0;
    curNic = level.nicfx[fxnic];
    curNics = level.nicloc[locnicc];
    alii = "fx_nic_fire_ceiling_md";


    level.smk = [];
    level.smkloc = [];
    fxsmk = 0;
    locsmk = 0;
    curfxsmk = level.smk[fxsmk];
    curlocsmk = level.smkloc[locsmk];
    allu = "fx_smk_wood_sm_black";


    level.firemed = [];
    level.firemedloc = [];
    medloc = 0;
    medfx = 0;
    curmedloc = level.firemedloc[medloc];
    curmedfx = level.firemed[medfx];
    al = "fx_zmb_nuke_fire_md";

    while ( true )
    {
        level.firemed[0] = "fx_zmb_nuke_fire_md";
        level.firemedloc[0] = (-605.914, 1570.11, -304.609);
        level.firemedloc[1] = (-595.245, 1504.4, -253.08);
        level.firemedloc[2] = (80.2344, 1189.21, 436.921);
        level.firemedloc[3] = (-504.736, 1517.1, 163.55);
        level.firemedloc[4] = (-224.036, 1499.64, 308.849);
        level.firemedloc[5] = (-214.787, 1264.56, 418.767);


        level.smk[0] = "fx_smk_wood_sm_black";
        level.smkloc[0] = (-823.101, 1509.02, 166.182);
        level.smkloc[1] = (-57.4516, 1189.21, 464.175);
        level.smkloc[2] = (9.53658, 1189.21, 500.182);
        



        level.firefx[0] = "fx_fire_wall_wood_ext_md";
        level.fireloc[0] = (1692.09, 967.768, -61.8178);
        level.fireloc[1] = (1645.32, 924.341, -59.1455);
        level.fireloc[2] = (1668.21, 947.773, -69.9173);
        level.fireloc[3] = (210.903, -1387.74, 80.912);
        level.fireloc[4] = (-223.236, -1625.56, 80.8562);
        level.fireloc[5] = (216.71, -1385.77, 76.0596);
        level.fireloc[6] = (-866.133, 1511.93, 167.195);
        level.fireloc[7] = (-819.896, 1509.09, 168.525);
        //level.fireloc[] = 

        level.nicfx[0] = "fx_nic_fire_ceiling_md";
        level.nicloc[0] = (-502.223, 1427.72, 167.176);
        level.nicloc[1] = (-601.538, 1477.27, 109.533);
        level.nicloc[2] = (-682.489, 1500.44, 71.479);
        level.nicloc[3] = (-239.924, 1516.18, 315.313);
        level.nicloc[4] = (-76.5274, 1194.85, 388.834);
        level.nicloc[5] = (-628.27, 1520.87, -200.529);
        level.nicloc[6] = (-1014.7, 1573.33, -265.044);
        level.nicloc[7] = (-664.885, 1846.33, -272.246);

        break;
    }

    foreach(firelocc in level.fireloc )
    {
        playfx( level._effect[ alias ], ( firelocc ) ) ;
    }
    wait .01;
    foreach( locnicc in level.nicloc )
    {
        playfx(level._effect[ alii ], ( locnicc ) );
        wait .01;
    }
    foreach( locsmk in level.smkloc )
    {
        playfx( level._effect[ allu ], ( locsmk ) );
    }
    wait .1;
    foreach(medloc in level.firemedloc )
    {
        playfx(level._effect[ al ], ( medloc ) );
    }
}

towerFX() //clocktower, not rockettower
{
    level endon("end_game");
    level waittill("initial_blackscreen_passed");

    wait .1;

    level.towerfx = [];
    level.towerloc = [];
    fxtower = 0;
    loctower = 0;
    curFX = level.towerfx[fxtower];
    curLoc = level.towerloc[loctower];
    alias = "fx_zmb_nuke_fire_windblown_md";

    level.towerfx1 = [];
    level.towerloc1 = [];
    fxtower1 = 0;
    loctower1 = 0;
    curfx1 = level.towerfx1[fxtower1];
    curloc1 = level.towerloc[loctower1];
    al = "fx_nic_fire_building_md_dist";
    
    level.smokes = [];
    level.smokesloc = [];
    fxsmoke = 0;
    locsmoke = 0;
    curfxsmoke = level.smokes[fxsmoke];
    curlocsmoke = level.smokesloc[locsmoke];
    als = "fx_smk_wood_sm_black";


    level.transit = [];
    level.transitloc = [];
    tfx = 0;
    tloc = 0;
    curtfx = level.transit[tfx];
    curtloc = level.transitloc[tloc];
    tal = "fx_zmb_tranzit_fire_med";
    while ( true )
    {
        level.transit[0] = "fx_zmb_tranzit_fire_med";
        level.transitloc[0] = (-617.336, 1488.99, -226.763);
        level.transitloc[1] = (-586.798, 1468.24, -247.36);
        level.transitloc[2] = (-654.585, 1738.72, 313.025);
        //level.transitloc[3] = (-608.418, 1734.67, 270.205);
        level.transitloc[3] = (-569.347, 1734.27, 226.39);
        //level.transitloc[5] = (-525.522, 1734.29, 177.42);
        level.transitloc[4] = (-47.6271, 1258.35, 366.196);
        //level.transitloc[7] = (-36.894, 1305.89, 359.632);
        level.transitloc[5] = (-20.7759, 1354.62, 353.46);
        level.transitloc[6] = (-40.5914, 1275.54, 364.166);
        //level.transitloc[10] = (-58.1456, 1284.69, 454.39);
        level.transitloc[7] = (-973.311, 1533.73, -218.065);
        level.transitloc[8] = (-414.616, 608.112, -51.5904);
        //level.transitloc[13] = (-7.3071, 1184.34, 292.775);
        //level.transitloc[14] = (-397.314, 621.503, -63.6553);
        level.transitloc[9] = (-162.232, -1131.1, 74.2552);
        level.transitloc[10] = (2776.66, 16212.1, -2948.8);
        level.transitloc[11] = (1643.44, 941.186, -40.2681);
        //level.transitloc[18] = (2391.95, 479.51, -140.75);
       // level.transitloc[19] = (798.339, -465.845, -23.875);
        level.transitloc[12] = (787.068, -409.72, 12.8477);
        //level.transitloc[21] = (-863.005, -480.975, -26.802);
        //level.transitloc[22] = (-870.558, -338.932, -64);
        level.transitloc[13] = (-898.165, -267.527, -59.2952);
        //level.transitloc[] = 
        


        level.towerfx[0] = "fx_zmb_nuke_fire_windblown_md";

        level.towerloc[0] = (-663.749, 1857.54, -252.829);
        level.towerloc[1] = (-52.4067, 1189.21, 498.396);
        //level.towerloc[2] = (-84.7106, 1189.21, 416.325);
        level.towerloc[2] = (-76.037, 1230.52, 555.081);
        //level.towerloc[4] = (-351.569, 1502.61, 240.552);
        //level.towerloc[5] = (-371.204, 1500.69, 181.774);
        level.towerloc[3] = (-1710.93, 9663.62, -3681.84);
        level.towerloc[4] = (-458.736, 1466.82, 168.09);
        //level.towerloc[8] = (-420.853, 1475.39, 179.902);
        
        //level.towerloc[] = 

        level.towerfx1[0] = "fx_nic_fire_building_md_dist";
        level.towerloc1[0] = (-979.334, 1536.01, -210.568);
        //level.towerloc1[1] = (-563.243, 1804.42, -13.7314);
        //level.towerloc1[1] = (-308.056, 1510, 457.349);

        level.smokes[0] = "fx_smk_wood_sm_black";
        //level.smokesloc[0] = (-552.942, 1643.67, -11.4598);
        //level.smokesloc[1] = (-500.811, 1742.98, 154.112);
        //level.smokesloc[2] = (-315.817, 1511.76, 480.511);
        //level.smokesloc[3] = (-695.229, 1886.15, -253.417);
        //level.smokesloc[1] = (-617.336, 1488.99, -226.763);
        //level.smokesloc[] = 

        break;
    }

    foreach( loctower1 in level.towerloc1 )
    {
        playfx(level._effect[ al ], ( loctower1 ) );
        wait 0.08;
    }
    
    foreach( tloc in level.transitloc )
    {
        playfx(level._effect[ tal ], ( tloc ) );
    }
    wait .1;
    /*
    foreach( locsmoke in level.smokesloc )
    {
        playfx( level._effect[ als ], ( locsmoke ) );
    }
    */
    wait .01;
    foreach( loctower in level.towerloc )
    {
        playfx( level._effect[ alias ], ( loctower ) );
    }



}



rocket1() //MIDDLE ROCKET
{
    level endon ("end_game");
    
    //level waittill("initial_blackscreen_passed");
    origin = (27.666, -2507.4, 680.2); //middle of the road
    rocket1 = spawn( "script_model", origin );
    rocket1 setModel( "p6_zm_nuked_rocket_cam" );
    angless = ( -90, -90.531, 0 ); 
    
    

    launchfxorigin = (27.666, -2507.4, -68.5302 );
    launchfx = spawn ("script_model", launchfxorigin );
    launchfx setModel ("c_zom_dlc0_zom_head3");
    //launchfx hide();
    fxangle = (-90, -90.531, 0);
    launchfx.angles = fxangle;


    /*FIX HERE*/
    rocket1.angles = angless;
    //NEED TO IMPLEMENT IT FULLY IN LATER
    /*
        //init countdown
        playsoundatposition( "zmb_perks_incoming_alarm", (27.666, -2507.4, 680.2) );
        for ( t = 1; t < 10; t++ )
        {
            foreach( player in level.players )
            {
                iprintlnBold( "^1Rocket launching in: ^7" + t );
            }
            wait 1;
        }

        
        foreach( player in level.players )
        {
            //PlayRumbleLoopOnEntity( "damage_heavy" );
            //iprintln("should be rumbling now");
        }
        


    //make an alias for the sound
    salias = "zmb_perks_incoming_loop";
    
    //fx loop
    //need better sounds
    rocket1 playloopsound( "zmb_perks_incoming_loop", 2 );
    playsoundatposition( "zmb_perks_incoming_land", rocket1.origin );
    
    //seperate function "fakesoundorigin"
    thread fakesoundorigin();
    for ( i = 0; i < 30; i++ )
    {
        
        PlayFxOnTag( level._effect["fx_zm_nuked_exp_perk_impact_ext"], launchfx, "tag_origin" );
        wait .15;
    }

    
    

    //step 1 launch //////////////////////////////////////
    z = 200000.22;
    times = 55;
    speedup = 25;
    speeddown = 20;
    rocket1 MoveZ( z, times, speedup, speeddown );
    wait .005;
    launchfx moveZ( z, times, speedup, speeddown );

    foreach( player in level.players )
    {
        iprintln ( "ROCKETHEAD SHOULD BE MOVING AT THIS POINT");
    }
    time = 300;
    while ( true )
    {

        playFXOnTag(level._effect["fx_zm_nuked_exp_perk_impact_ext"], launchfx, "tag_origin" );
        playfxontag(level._effect[""], rocket1, "tag_origin");
        wait .1;
        time --;
        foreach ( player in level.players )
        {
            iprintln("Time until removal: ^2" + time );
        }
        if( time <= 0 )
        {
            rocket1 delete();
            launchfx delete();
            break;
        }
        
    }
    */
    

}

testrumbleonrocket()
{
    level endon("end_game");
    self endon ("disconnect");

    level waittill("initial_blackscreen_passed");
    wait 0.3;
    for ( i = 1; i < 10; i++ )
    {
        if ( i == 9 )
        {
            self iprintln("RUMBLE TAKING PLACE!");
        }
        wait 1;
    }
    
    player PlayRumbleOnEntity("damage_heavy");
    wait 8;
    player StopRumble("damage_heavy");
}

initSong()
{
    level endon("end_game");
    self endon("disconnect");
    self endon ( "stop_heaven_song" );

    level.spacesounds = [];
    soundNum = 0;
    curSound = level.spacesounds[soundNum];

    //paredolia = "zmb_nuked_song_3";
    
    remix = "paradol_8bit";
    sam = "zmb_nuked_song_2";
    damned = "zmb_nuked_song_1";
    
    while ( true )
    {
        level.spacesounds[0] = paredolia;
        level.spacesounds[1] = sam;
        level.spacesounds[2] = damned;
        break;
    }

    pwait = 80;
    swait = 60;
    dwait = 88;
    
    while ( true )
    {
        //numbers = randomintrange(0, 2);

        //self playsound(level.spacesounds[numbers] );
        self playsound( paredolia );
        //wait 76;
        /*
        if ( numbers == 0 )
        {
            wait pwait;
        }

        if ( numbers == 1 )
        {
            //wait swait;
        }

        if ( numbers == 2 )
        {
            //wait dwait;
        }
        */
        
    }
    
}
//aretexturesloaded
//level._effect[ "eye_glow" ] = loadfx( "misc/fx_zombie_eye_single" );
//level._effect[ "upgrade_aquired" ] = loadfx( "maps/zombie/fx_zmb_tanzit_upgrade" );
spaceSongNew()
{
    level endon( "end_game" );
    self endon( "removeSound" );

    songtimerwait = 76;
    songtype = "zmb_nuked_song_3";

    while ( true )
    {   /*
        foreach ( player in level.players )
        {
            player iprintlnbold("^3Starting to play the space song!" );
        }
        */
        self PlaySound( songtype ); //play spacesong
        self thread songTimerWait(); //waiter
        //self thread debugwaiterprint(); //debug timer, disable once problem has been solved

        self waittill ( "return_space_loop" ); //waiter's notify to continue, gets callbacked from songTimerWait notify
        self notify ( "break_waiter" ); //kill songTimerWait thread
        wait 0.05;
    }

}

debugwaiterprint()
{
    level endon("end_game");

    for ( i = 76; i > 0; i-- )
    {
        foreach (player in level.players)
        {
            player iPrintLnBold( "^3Time before the song plays again: ^7" + i );
            wait 1;
        }
    }
}

songTimerWait()
{
    level endon( "end_game" );
    self endon ( "break_waiter" );

    waiter = 76;
    wait waiter;
    self notify ( "return_space_loop" );
}

rocket2() //RIGHT ROCKET
{
    level endon ("end_game");
    
    //level waittill("initial_blackscreen_passed");
    //wait 0.3;
    origin2 = (-663.537, -3139.59, 624.819 );//(-642.359, -313.84, -237.351 ); //rightside of road
    rocket2 = spawn( "script_model", origin2 );
    rocket2 setModel( "p6_zm_nuked_rocket_cam" );
    angless2 = ( -90, -90.531, 0 ); 
    rocket2.angles = angless2;
    

    launchfxorigin2 = (-663.537, -3139.59, -83.8842 );
    launchfx2 = spawn ("script_model", launchfxorigin2 );
    launchfx2 setModel ("c_zom_dlc0_zom_head3");
    //launchfx hide();
    fxangle2 = (-90, -90.531, 0);
    launchfx2.angles = fxangle2;


    /*FIX HERE*/
    

    //init countdown
    
    playsoundatposition( "zmb_perks_incoming_alarm", (27.666, -2507.4, 680.2) );
    for ( t2 = 1; t2 < 10; t2++ )
    {
        /*
        foreach( player in level.players )
        {
            iprintlnBold( "^1Rockets launching in: ^7" + t2 );
        }
        */
        wait 1;
    }

    //make an alias for the sound
    salias2 = "zmb_perks_incoming_loop";
    
    //fx loop
    //need better sounds
    rocket2 playloopsound( "zmb_perks_incoming_loop", 2 );
    playsoundatposition( "zmb_perks_incoming_land", rocket2.origin );
    
    //make rocket sounds louder by faking them ( spawn in seperate ents )
    thread fakesoundorigin();
    //seperate function for groundfxlaunch
    thread groundfxlaunch1();

    foreach ( player in level.players )
    {
        Earthquake(0.43, 8.5, ( 0,0,0 ), 20000);
        
    }
    
    //thread towerfxlaunch1(); //old stupid shit, don't include
    for ( i = 0; i < 15; i++ ) // wait time till next launch step = 4.5 seconds //30 if wait = .15
    {
        
        PlayFxOnTag( level._effect["fx_zm_nuked_exp_perk_impact_ext"], launchfx2, "tag_origin" );
        wait .30; //.15
    } 
    // wait .15 x 30 logic below
    //90 = 6x
    //180 = 12x
    //360 = 24x
    //24x + 6x = 30x
    //360 + 90 = 450 = 4.5 seconds
    foreach ( player in level.players )
    {
        Earthquake( 0.15, 1.6, ( 0,0,0 ), 20000 );
    }

    //step 1 launch //////////////////////////////////////
    z2 = 200000.22;
    times2 = 55;
    speedup2 = 25;
    speeddown2 = 20;
    rocket2 MoveZ( z2, times2, speedup2, speeddown2 );
    wait .005;
    launchfx2 moveZ( z2, times2, speedup2, speeddown2  );
    /*
    foreach ( player in level.players )
    {
        Earthquake( 0.1, 1.6, ( 0,0,0 ), 20000 );
    }
    */
    /*
    foreach( player in level.players )
    {
        iprintln ( "ROCKETHEAD SHOULD BE MOVING AT THIS POINT");
    }
    */
    time2 = 250;
    //takeoff fxs
    launchfx2 thread flying_rocket_fx(); //fx precached in func "precache_fx"
    thread enable_zombies_back();
    while ( true )
    {
        wait .1;
        time2 --;
        if( time2 <= 0 )
        {
            rocket2 delete();
            launchfx2 delete();
            wait .1;
            break;
        }
        
    }
    

}

enable_zombies_back()
{
    level endon("end_game");
    wait 5;
    //level setClientDvar("g_ai", 1 );
    flag_set( "spawn_zombies" );
    
}
rocket3() //LEFT ROCKET
{
    level endon ("end_game");
    //level waittill( "initial_blackscreen_passed" );
    //wait .4;
    origin3 = ( 697.556, -3144.83, 640.267 );//(-642.359, -313.84, -237.351 );//(563.569, -3147.5, -235.929 ); //left of the road
    rocket3 = spawn( "script_model", origin3 );
    rocket3 setModel( "p6_zm_nuked_rocket_cam" );
    angless3 = ( -90, -90.531, 0 ); 
    

    launchfxorigin3 = (697.556, -3144.83, -108.4632 );
    launchfx3 = spawn ("script_model", launchfxorigin3 );
    launchfx3 setModel ("c_zom_dlc0_zom_head3");
    //launchfx hide();
    fxangle3 = (-90, -90.531, 0);
    launchfx3.angles = fxangle3;


    /*FIX HERE*/
    rocket3.angles = angless3;

    //init countdown
    
    for ( t = 1; t < 12; t++ )
    {
        wait 1;
    }
    //make an alias for the sound
    salias3 = "zmb_perks_incoming_loop";
    
    //fx loop
    //need better sounds
    rocket3 playloopsound( "zmb_perks_incoming_loop", 2 );
    playsoundatposition( "zmb_perks_incoming_land", rocket3.origin );
    
    //seperate function "fakesoundorigin"
    thread fakesoundorigin1();
    for ( i = 0; i < 15; i++ ) //30 if wait = .15
    {
        
        PlayFxOnTag( level._effect["fx_zm_nuked_exp_perk_impact_ext"], launchfx3, "tag_origin" );
        wait .30;
    }

    
    

    //step 1 launch //////////////////////////////////////
    z3 = 200000.22;
    times3 = 55;
    speedup3 = 25;
    speeddown3 = 20;
    rocket3 MoveZ( z3, times3, speedup3, speeddown3 );
    wait .005;
    launchfx3 moveZ( z3, times3, speedup3, speeddown3 );

    time3 = 250;
    launchfx3 thread flying_rocket_fx();
    while ( true )
    {

        //playFXOnTag(level._effect["fx_zm_nuked_exp_perk_impact_ext"], launchfx3, "tag_origin" );
        //playfxontag(level._effect[""], rocket3, "tag_origin");

        wait .1;
        time3 --;
        if( time3 <= 0 )
        {
            rocket3 delete();
            launchfx3 delete();
            break;
        }
        
    }
    
}

flying_rocket_fx() //simplified rocket fx and doesnt make the sun flicker when rockets have taken off
{
    level endon( "end_game" );
    playfxontag( level._effect[ "rocket_fx" ], self, "tag_origin" );
}


groundfxlaunch1() //needs fixing, effects stay looped
{
    level endon ( "end_game" );
    
    level.groundfx = [];
    groundfxloc = 0;
    curFX = level.groundfx[ groundfxloc ];
    nimi = "fx_zm_nuked_exp_perk_impact_ext";

    
    while ( true )
    {
        level.groundfx[0] = (-650.306, -2767.52, -62.2977 );
        level.groundfx[1] = (-364.357, -2690.28, -36.2731 );
        level.groundfx[2] = (-42.7154, -2685.66, -35.9709 );
        level.groundfx[3] = (265.013, -2709.49, -37.0504 );
        level.groundfx[4] = (459.989, -2968.46, -69.8446 );
        level.groundfx[5] = (213.795, -3025.58, -22.6509 );
        level.groundfx[6] = (-107.664, -3039.39, -57.3907 );
        level.groundfx[7] = (27.1439, -2558.73, -33.089 );
        break;
    }

    for (i = 0; i < 9; i++ ) //188 if wait = 0.01
    {
        foreach ( groundfxloc in level.groundfx )
        {
            playfx( level._effect[ nimi ], ( groundfxloc ) );
            wait .05;
            
        }
        //wait .1; //0.01
    }
    /*
    foreach( player in level.players )
    {
        iprintln("^1Explosions should get deleted now");
    }
    */
    //no need to delete entities, fxs in this function are "one shot";
}




towerfxlaunch1()
{
    
    level endon ( "end_game" );
    
    //level waittill("initial_blackscreen_passed");
    wait .5;
    level.towerfxx = [];
    towerfxxloc = 0;
    curFXX = level.towerfxx[towerfxxloc];
    fireX = "fx_zmb_nuke_fire_med";

    level.transformerfx = [];
    transformerloc = 0;
    curLoc = level.transformerfx[transformerloc];
    trans = "fx_elec_transformer_sparks_runnder";


    
    while ( true )
    {
        level.towerfxx[0] = (-650.306, -2767.52, -62.2977 );
        level.towerfxx[1] = (-364.357, -2690.28, -36.2731 );
        level.towerfxx[2] = (-42.7154, -2685.66, -35.9709 );
        level.towerfxx[3] = (265.013, -2709.49, -37.0504 );
        level.towerfxx[4] = (459.989, -2968.46, -69.8446 );
        level.towerfxx[5] = (213.795, -3025.58, -22.6509 );
        level.towerfxx[6] = (-107.664, -3039.39, -57.3907 );
        level.towerfxx[7] = (27.1439, -2558.73, -33.089 );
        break;
    }

    
    foreach ( curFXX in level.towerfxx )
    {

        //tutorial in rockettowerlights
        temp1 = spawn( "script_model", curFXX );
        temp1 setmodel( "tag_origin" );
        angula = ( -90, 90, 0 );

        temp1.angles = angula;

        level.towerfxx[level.towerfxx.size] = temp1;
        playfxontag(level._effect[fireX], temp1, "tag_origin" );
        wait .18;  
    }

    while ( true )
    {
        level.transformerfx[0] = (-1010.45, -5510.37, -205.945);
        level.transformerfx[1] = (-523.969, -12288, -140.309);
        level.transformerfx[2] = (745.018, -2885.26, -170.641);
        level.transformerfx[3] = (728.104, -2842, -162.04);
        level.transformerfx[4] = (-564.039, -2484.76, -60.2148);
        level.transformerfx[5] = (-562.124, -2559.14, -58.402);
        level.transformerfx[6] = (1585.37, -7940.23, -103.01);
        level.transformerfx[7] = (1777.59, -8776.38, -69.0242);
        level.transformerfx[8] = (2234.31, -10755.8, -176.611);
        break;

    }

    foreach( curLoc in level.transformerfx )
    {
        //tutorial in rockettowerlights
        temp2 = spawn("script_model", curLoc);
        temp2 setmodel("tag_origin");
        angulas = ( -90, 90, 0 );

        temp2.angles = angulas;

        level.transformerfx[level.transformerfx.size] = temp2;
        playfxontag(level._effect[trans], temp2, "tag_origin" );
        wait .1;
    }

    //wait time before deleting entities & linked fxs
    for ( i = 0; i < 10; i++ )
    {
        wait 1;
    }

    //delete now
    array_delete( level.towerfxx );
    wait .1;
    array_delete( level.transformerfx );
    
}

rockettowerlights()
{
    level endon("end_game");
    //level waittill("initial_blackscreen_passed");
    wait .1;
    level.markerloc = [];
    markerlocs = 0;
    curlocs = level.markerloc[markerlocs];
    marker = "lght_marker";

    while ( true )
    {   //first assign origins for ( curlocs )
        level.markerloc[0] = (-540.455, -3138.92, -109.44);
        level.markerloc[1] = (-822.141, -3129.49, -113.589);
        level.markerloc[2] = (-805.918, -3198.41, -117.942);
        level.markerloc[3] = (-700.061, -3258.71, -120.027);
        level.markerloc[4] = (-578.404, -3228.52, -115.341);
        level.markerloc[5] = (507.441, -3152.45, -150.124);
        level.markerloc[6] = (558.529, -3302.73, -166.267);
        level.markerloc[7] = (677.367, -3338.45, -192.569);
        level.markerloc[8] = (812.16, -3315.77, -203.312);
        level.markerloc[9] = (858.238, -3190.52, -197.188);
        break;
    }

    foreach( curlocs in level.markerloc ) //curlocs in level.markerloc
    {
        //gucci = important asset so that we can finally delete the fxs upon ready
        //first define array & locations for spawnable gucci
        //then spawn in gucci foreach curlocs location gotten from the array
        //then assign "heads" to the new locations
        //then playfxontag, in this case zombie heads
        //once finsished, either force remove level.markerloc array or delete one gucci at a time, whichever looks better
        //finally this system is ready. It only took 2 days to figure it out thru constant trial & error... :D
        gucci = spawn("script_model", curlocs);
        gucci setmodel("c_zom_dlc0_zom_head3");
        angula = ( -90, 90, 0 );

        gucci.angles = angula;

        level.markerloc[level.markerloc.size] = gucci;
        playFXOnTag(level._effect[marker], gucci, "tag_origin"  ); //curlocs
        wait .3;
    }
    
    
    //debug whats messing it up
    wait 5;
   
    wait 5;
    //try moving the lights down first
    //gucci MoveZ(-2500, 20, 10, 5);
    foreach( gucci in level.markerloc )
    {
        //gucci rotateyaw(90, 5, 2, 2);
        //gucci rotateroll(-180, 5, 2, 2);
        gucci RotatePitch(-180, 7, 3, 2);
        gucci MoveZ(-7400, 20, 10, 5);
        
    }
    wait 7;
    //force remove one "gucci" at a time
    array_delete(level.markerloc);
        
    
    
    //Target_Remove(gucci);
    //self DeleteFX( 0, marker, 1 );
    /* //NONE WORKS, NEED TO FIND ANOTHER WAY......
    curlocs deletefx(); //TRY THIS WHEN BACK AT HOME!!!
    curlocs delete();
    markerloc deletefx();
    markerloc delete();
    playa = getplayers();
    */
    /*
    foreach( player in level.players )
    {
        iprintln("LIGHTS GETS DELETED NOW!");
    }
    */

    
}

//array removals, call in a function

deletelights1by1( level.markerloc )
{
	for( i = 0; i < 9; i++)
    {
        level.markerloc[ i ] delete();
        wait .005;
    }
}

deletefx()
{
    level endon("end_game");

    wait.1;

    self delete();
}
spawnRocketTowers( pos, rot, opt, name )
{
    level endon ("end_game");

    //level waittill("initial_blackscreen_passed");

    //rockettower struct
    model = spawn( "script_model", pos );
	model setModel( name );
	model.angles = rot;

    if ( opt == 1 )
    {
        //model delete();
    }
    else
    {
    }	
    //timer & tower movers during rocket launch
    flag_wait("initial_blackscreen_passed");
    model thread towercollapsemonitor();


}

towercollapsemonitor()
{
    level endon("end_game");
    

    //level waittill("initial_blackscreen_passed");
    for( a = 1; a < 13; a++ )
    {
        wait 1;
    }
    
    points = (797.727, -3352.66, -3000);
    time1 = 20;
    acc1 = 10;
    decc1 = 10;

    self MoveTo( points, time1, acc1, decc1 );
    //self RotatePitch(-180, 7, 3, 2);

    wait 12;
    self delete();
}

rocketTowers()
{
    level endon("end_game");
    wait .1;

    rt1();
    rt2();
    rt3();
    rt4();
    rt5();
    rt6();
    rt7();
    rt8();
    rt9();
    rt10();
    rt11();
    rt12();
    rt13();
    rt14();
    rt15();
    rt16();
    rt17();
    rt18();
    rt19();
    rt20();
    rt21();
    rt22();
    rt23();
    rt24();
    rt25();
    rt26();
    rt27();
    rt28();
    rt29();
    rt30();
    rt31();
    rt32();
    rt33();
    rt34();
    rt35();
    rt36();
    rt37();
    rt38();
    rt39();
    rt40();
    rt41();
    rt42();
    rt43();
    rt44();
    rt45();
    rt46();
    rt47();
    rt48();
    rt49();
    rt50();
    rt51();
    rt52();
    rt53();
    rt54();
    rt55();
    rt56();
    rt57();
    //rt58();




}

rt1()
{
    spawnRocketTowers((797.727, -3352.66, -229.436), (0, 87.6501, 0), 0, "p_rus_chainlink_fence");
//  8:36 
}

rt2()
{
    spawnRocketTowers((797.727, -3352.66, -110.182), (0, 87.6501, 0), 0, "p_rus_chainlink_fence");
//  8:39 
}

rt3()
{
    spawnRocketTowers((797.727, -3352.66, 10.1274), (0, 87.6501, 0), 0, "p_rus_chainlink_fence");
//  8:43 
}

rt4()
{
    spawnRocketTowers((797.727, -3352.66, 129.259), (0, 87.6501, 0), 0, "p_rus_chainlink_fence");
}

rt5()
{
    spawnRocketTowers((797.727, -3352.66, 252.734), (0, 87.6501, 0), 0, "p_rus_chainlink_fence");
}

rt6()
{
    spawnRocketTowers((797.727, -3352.66, 380.432), (0, 87.6501, 0), 0, "p_rus_chainlink_fence");
}

rt7()
{
    spawnRocketTowers((797.727, -3352.66, 417.37), (0, 87.6501, 0), 0, "p_rus_chainlink_fence");
//  9:10 
}

rt8()
{
    spawnRocketTowers((666.92, -3344.02, -208.229), (0, 80.4926, 0), 0, "p_rus_chainlink_fence");
//  9:13 
}

rt9()
{
    spawnRocketTowers((666.92, -3344.02, -93.1494), (0, 80.4926, 0), 0, "p_rus_chainlink_fence");
//  9:16 
}

rt10()
{
    spawnRocketTowers((666.92, -3344.02, 26.0591), (0, 80.4926, 0), 0, "p_rus_chainlink_fence");
//  9:19 
}

rt11()
{
    spawnRocketTowers((666.92, -3344.02, 155.92), (0, 80.4926, 0), 0, "p_rus_chainlink_fence");
//  9:23 
}

rt12()
{
    spawnRocketTowers((666.92, -3344.02, 278.389), (0, 80.4926, 0), 0, "p_rus_chainlink_fence");
//  9:27 
}

rt13()
{
    spawnRocketTowers((666.92, -3344.02, 403.918), (0, 80.4926, 0), 0, "p_rus_chainlink_fence");
//  9:30 
}

rt14()
{
    spawnRocketTowers((666.92, -3344.02, 418.646), (0, 80.4926, 0), 0, "p_rus_chainlink_fence");
//  9:45 say;53415;0;Ultimateman;spawnall
}



rt15()
{
    spawnRocketTowers((-822.131, -3171.47, -133.294), (0, -0.927124, 0), 0, "p_rus_chainlink_fence");
// 10:20 
}

rt16()
{
    spawnRocketTowers((-822.131, -3171.47, -17.2233), (0, -0.927124, 0), 0, "p_rus_chainlink_fence");
// 10:22 
}

rt17()
{
    spawnRocketTowers((-822.131, -3171.47, 105.231), (0, -0.927124, 0), 0, "p_rus_chainlink_fence");
// 10:28 
}

rt18()
{
    spawnRocketTowers((-822.131, -3171.47, 229.583), (0, -0.927124, 0), 0, "p_rus_chainlink_fence");
// 10:30 
}

rt19()
{
    spawnRocketTowers((-822.131, -3171.47, 356.303), (0, -0.927124, 0), 0, "p_rus_chainlink_fence");
// 10:33 
}

rt20()
{
    spawnRocketTowers((-822.131, -3171.47, 411.215), (0, -0.927124, 0), 0, "p_rus_chainlink_fence");
// 10:45 
}

rt21()
{
    spawnRocketTowers((-705.826, -3254.64, -129.602), (0, 62.486, 0), 0, "p_rus_chainlink_fence");
// 10:50 
}

rt22()
{
    spawnRocketTowers((-706.69, -3246.03, -6.36514), (0, 66.4026, 0), 0, "p_rus_chainlink_fence");
// 10:53 
}

rt23()
{
    spawnRocketTowers((-706.69, -3246.03, 116.097), (0, 64.8206, 0), 0, "p_rus_chainlink_fence");
// 10:56 
}

rt24()
{
    spawnRocketTowers((-706.69, -3246.03, 240.669), (0, 64.8206, 0), 0, "p_rus_chainlink_fence");
// 10:58 
}

rt25()
{
    spawnRocketTowers((-706.69, -3246.03, 368.408), (0, 64.8206, 0), 0, "p_rus_chainlink_fence");
// 11:02 
}

rt26()
{
    spawnRocketTowers((-706.69, -3246.03, 406.413), (0, 64.8206, 0), 0, "p_rus_chainlink_fence");
// 11:11 
}

rt27()
{
    spawnRocketTowers((-570.63, -3216.89, -124.762), (0, 112.073, 0), 0, "p_rus_chainlink_fence");
}

rt28()
{
    spawnRocketTowers((-570.63, -3216.89, -3.34557), (0, 112.073, 0), 0, "p_rus_chainlink_fence");
}

rt29()
{
    spawnRocketTowers((-570.63, -3216.89, 125.461), (0, 112.073, 0), 0, "p_rus_chainlink_fence");
}

rt30()
{
    spawnRocketTowers((-570.63, -3216.89, 255.323), (0, 112.073, 0), 0, "p_rus_chainlink_fence");
}

rt31()
{
    spawnRocketTowers((-570.63, -3216.89, 374.627), (0, 112.073, 0), 0, "p_rus_chainlink_fence");
}

rt32()
{
    spawnRocketTowers((-570.63, -3216.89, 398.91), (0, 112.073, 0), 0, "p_rus_chainlink_fence");
}

rt33()
{
    spawnRocketTowers((-541.795, -3089.5, -126.323), (0, -178.186, 0), 0, "p_rus_chainlink_fence");
}

rt34()
{
    spawnRocketTowers((-541.795, -3089.5, -14.4463), (0, -178.186, 0), 0, "p_rus_chainlink_fence");
}

rt35()
{
    spawnRocketTowers((-541.795, -3089.5, 111.152), (0, -178.186, 0), 0, "p_rus_chainlink_fence");
}

rt36()
{
    spawnRocketTowers((-541.795, -3089.5, 236.75), (0, -178.186, 0), 0, "p_rus_chainlink_fence");
}

rt37()
{
    spawnRocketTowers((-541.795, -3089.5, 368.681), (0, -178.186, 0), 0, "p_rus_chainlink_fence");
}

rt38()
{
    spawnRocketTowers((-541.795, -3089.5, 399.29), (0, -178.186, 0), 0, "p_rus_chainlink_fence");
}



rt39()
{
    spawnRocketTowers((547.406, -3301.43, -195.347), (0, 25.1239, 0), 0, "p_rus_chainlink_fence");
}

rt40()
{
    spawnRocketTowers((547.917, -3304.89, -69.3906), (0, 29.4196, 0), 0, "p_rus_chainlink_fence");
}

rt41()
{
    spawnRocketTowers((545.864, -3301.19, 61.5164), (0, 29.0076, 0), 0, "p_rus_chainlink_fence");
}

rt42()
{
    spawnRocketTowers((545.864, -3301.19, 199.626), (0, 29.0076, 0), 0, "p_rus_chainlink_fence");
}

rt43()
{
    spawnRocketTowers((545.864, -3301.19, 333.706), (0, 29.0076, 0), 0, "p_rus_chainlink_fence");
}

rt44()
{
    spawnRocketTowers((545.864, -3301.19, 423.271), (0, 29.0076, 0), 0, "p_rus_chainlink_fence");
}

rt45()
{
    spawnRocketTowers((855.117, -3227.71, -214.401), (0, 162.739, 0), 0, "p_rus_chainlink_fence");
}


rt46()
{
    spawnRocketTowers((855.117, -3227.71, -95.4939), (0, 162.964, 0), 0, "p_rus_chainlink_fence");
}


rt47()
{
    spawnRocketTowers((855.117, -3227.71, 35.0392), (0, 162.964, 0), 0, "p_rus_chainlink_fence");
}


rt48()
{
    spawnRocketTowers((855.117, -3227.71, 158.066), (0, 162.964, 0), 0, "p_rus_chainlink_fence");
}

rt49()
{
    spawnRocketTowers((855.117, -3227.71, 284.389), (0, 162.964, 0), 0, "p_rus_chainlink_fence");
}


rt50()
{
    spawnRocketTowers((855.117, -3227.71, 394.039), (0, 162.816, 0), 0, "p_rus_chainlink_fence");
}

rt51()
{
    spawnRocketTowers((855.117, -3227.71, 413.032), (0, 162.816, 0), 0, "p_rus_chainlink_fence");
}

rt52()
{
    spawnRocketTowers((825.42, -3088.69, -187.61), (0, -158.227, 0), 0, "p_rus_chainlink_fence");
}

rt53()
{
    spawnRocketTowers((825.42, -3088.69, -64.4663), (0, -158.227, 0), 0, "p_rus_chainlink_fence");
}

rt54()
{
    spawnRocketTowers((825.42, -3088.69, 63.0331), (0, -158.227, 0), 0, "p_rus_chainlink_fence");
}


rt55()
{
    spawnRocketTowers((825.42, -3088.69, 193.478), (0, -158.227, 0), 0, "p_rus_chainlink_fence");
}


rt56()
{
    spawnRocketTowers((825.42, -3088.69, 320.977), (0, -158.227, 0), 0, "p_rus_chainlink_fence");
}

rt57()
{
    spawnRocketTowers((825.42, -3088.69, 412.116), (0, -158.227, 0), 0, "p_rus_chainlink_fence");
}

/*
rt58()
{
    
}


rt59()
{
    
}
*/






// ADD ROCKET LAUNCH SOUNDS AROUND THE LAUNCH AREA
fakesoundorigin()
{
    level endon("end_game");

    level.soundname = [];
    level.soundorigin = [];
    soundd = 0; //"zmb_perks_incoming_loop"; //20 loop time
    origins = 0;
    curname = level.soundname[soundd];
    curorigin = level.soundorigin[origins];

    //salainen = liian matala, tarvii paremman!
    salainen = "zmb_perks_incoming_loop";
    salainen2 = "zmb_perks_incoming_land";
    salainen3 = "zmb_endgame";


    ///////////////////////////////////////////////////////////////////////////////////////////
    /* FAKE SOUNDS FOR ROCKET
        SPAWN IN AN ENTITY
            THEN LINK THE SOUND TO THAT ENTITY
                AND REMOVE THE ENTITY AND SOUND ONCE TAKEOFF HAS BEEN COMPLETED SUCCESFULLY
    */
    /////////////////////////////////////////////////////////////////////////////////////////

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

    //PlayRumbleLoopOnEntity
    /*
    foreach ( player in level.players )
    {
        self playRumbleOnEntity("damage_heavy");
    }
    */
    
    o1 playloopsound( "zmb_perks_incoming_loop", 1 );
    wait .01;
    o2 playloopsound( "zmb_perks_incoming_loop", 2 );
    wait .05;
    o3 playloopsound( "zmb_perks_incoming_loop", 3 );
    wait .009;
    o4 playloopsound( "zmb_perks_incoming_loop", 4 );
    wait .01;
    o5 playloopsound( "zmb_perks_incoming_loop", 5 );
    /*
    while (true )
    {
        /*
        level.soundname[0] = "zmb_perks_incoming_loop";
        level.soundname[1] = "zmb_perks_incoming_land";
        */
        //level.soundorigin[0] = (444.141, -249.61, -165.923);
        //level.soundorigin[1] = ( -604.804, -267.685, -214.889 );
        //level.soundorigin[2] = ( 289, -761.831, -187.426 );
        //level.soundorigin[3] = ( -471.454, -740.086, -148.474 );
        //level.soundorigin[4] = ( 19.6329, -324.979, -173.521 );

        //break;
    //}
    
    //sam laugh
    //playsoundatposition( salainen3, level.soundorigin[3] );
    /*
    foreach ( origins in level.soundorigin )
    {
        playsoundatposition( salainen, origins );
        //origins playLoopSound( salainen );
        //origins playloopsound( "zmb_perks_incoming_loop", 20 );
        wait .08;
    }
    */

    wait 2;

    for( i = 1; i < 15; i++ )
    {   /*
        foreach( player in level.player )
        {
            iprintlnbold("time left ^1" + t );    
        }
        */
        wait 1;
    }
    

    o1 stoploopsound( 4 );
    o2 stoploopsound( 4 );
    o3 stoploopsound( 4 );
    o4 stoploopsound( 4 );
    o5 stoploopsound( 4 );
    o1 delete();
    o2 delete();
    o3 delete();
    o4 delete();
    o5 delete();
    //sam laugh
    //playsoundatposition( salainen3, level.soundorigin[3] );
    /*
    t = 0;
    while ( t < 15 )
    {
        t++;
        foreach ( player in level.player )
        {
            iprintln("value of t =  ^1" + t );
        }
        if ( t >= 15 )
        {
            o1 stoploopsound( 1 );
            o2 stoploopsound( 1 );
            o3 stoploopsound( 1 );
            o4 stoploopsound( 1 );
            o5 stoploopsound( 1 );

            foreach ( player in level.players )
            {
                iprintln("^2Loop sound has been stopped" );
            }
        }
        wait 1;
    }
    */
    
}

fakesoundorigin1()
{
    level endon("end_game");

    level.soundname1 = [];
    level.soundorigin1 = [];
    soundd1 = 0; //"zmb_perks_incoming_loop"; //20 loop time
    origins1 = 0;
    curname1 = level.soundname1[soundd1];
    curorigin1 = level.soundorigin1[origins1];

    //salainen = liian matala, tarvii paremman!
    salainen = "zmb_perks_incoming_loop";
    salainen2 = "zmb_perks_incoming_land";
    salainen3 = "zmb_endgame";


    ///////////////////////////////////////////////////////////////////////////////////////////
    /* FAKE SOUNDS FOR ROCKET
        SPAWN IN AN ENTITY
            THEN LINK THE SOUND TO THAT ENTITY
                AND REMOVE THE ENTITY AND SOUND ONCE TAKEOFF HAS BEEN COMPLETED SUCCESFULLY
    */
    /////////////////////////////////////////////////////////////////////////////////////////

    tempangles1 = ( -90, -90.531, 0 );
    o1 = spawn("script_model", (444.141, -249.61, -165.923) );
    o1 setModel ("c_zom_dlc0_zom_head3");
    o1.angles = tempangles1;

    o2 = spawn("script_model", ( -604.804, -267.685, -214.889 ) );
    o2 setModel ("c_zom_dlc0_zom_head3");
    o2.angles = tempangles1;

    o3 = spawn("script_model", ( 289, -761.831, -187.426 ) );
    o3 setModel ("c_zom_dlc0_zom_head3");
    o3.angles = tempangles1;

    o4 = spawn("script_model", ( -471.454, -740.086, -148.474 ) );
    o4 setModel ("c_zom_dlc0_zom_head3");
    o4.angles = tempangles1;

    o5 = spawn("script_model",( 19.6329, -324.979, -173.521 ) );
    o5 setModel ("c_zom_dlc0_zom_head3");
    o5.angles = tempangles1;

    //PlayRumbleLoopOnEntity
    /*
    foreach ( player in level.players )
    {
        self playRumbleOnEntity("damage_heavy");
    }
    */
    
    o1 playloopsound( "zmb_perks_incoming_loop", 1 );
    wait .01;
    o2 playloopsound( "zmb_perks_incoming_loop", 2 );
    wait .05;
    o3 playloopsound( "zmb_perks_incoming_loop", 3 );
    wait .009;
    o4 playloopsound( "zmb_perks_incoming_loop", 4 );
    wait .01;
    o5 playloopsound( "zmb_perks_incoming_loop", 5 );
    /*
    while (true )
    {
        /*
        level.soundname[0] = "zmb_perks_incoming_loop";
        level.soundname[1] = "zmb_perks_incoming_land";
        */
        //level.soundorigin[0] = (444.141, -249.61, -165.923);
        //level.soundorigin[1] = ( -604.804, -267.685, -214.889 );
        //level.soundorigin[2] = ( 289, -761.831, -187.426 );
        //level.soundorigin[3] = ( -471.454, -740.086, -148.474 );
        //level.soundorigin[4] = ( 19.6329, -324.979, -173.521 );

        //break;
    //}
    
    //sam laugh
    //playsoundatposition( salainen3, level.soundorigin[3] );
    /*
    foreach ( origins in level.soundorigin )
    {
        playsoundatposition( salainen, origins );
        //origins playLoopSound( salainen );
        //origins playloopsound( "zmb_perks_incoming_loop", 20 );
        wait .08;
    }
    */

    wait 2;

    for( i = 1; i < 15; i++ )
    {
        /*
        foreach( player in level.player )
        {
            iprintlnbold("time left ^1" + t );    
        }
        */
        wait 1;
    }
    

    o1 stoploopsound( 4 );
    o2 stoploopsound( 4 );
    o3 stoploopsound( 4 );
    o4 stoploopsound( 4 );
    o5 stoploopsound( 4 );
    o1 delete();
    o2 delete();
    o3 delete();
    o4 delete();
    o5 delete();
    //sam laugh
    //playsoundatposition( salainen3, level.soundorigin[3] );
}

showconnectmessage() //shows custom message on the killfeed section
{
	wait( 2.5 );
	self iprintln( "^7Hello:^2 " + self.name + "^7!" );
	wait( 1.5 );
	self iprintln( "^2|| ^7Nuketown Beta Build Loaded ^2||" );
    /*
	wait( 4 );
	self iprintln( "^2|| ^7Following patch has been applied for you: ^2||" );
	wait( 2.5 );
	self iprintln( "^2|| ^7Nuketown ^2Unpatched ^7Build ^2||" );
    wait ( 2.0 );
    //self thread player_model_origin();
    */
}

load_visuals()
{

	self waittill( "spawned_player" );

	self setClientDvar( "r_sky_intensity_factor0", 6.2 );
    self setClientDvar( "r_skyTransition", 0 );
	self setClientDvar( "r_skyColorTemp", 1650 );
	self setClientDvar( "r_lodBiasRigid", -1000 );
	self setClientDvar( "r_lodBiasSkinned", -1000 );
	self setClientDvar( "r_filmuseTweaks", 1 );
	self setClientDvar( "vc_fsm", "1 1 1 1" );
	self setClientDvar( "r_bloomtweaks", 1 );
	self setClientDvar( "r_lighttweaksuncolor", ( 0.8, 0.8, 0.8 ) );
	self setClientDvar( "r_lighttweaksunlight", 18 );
	self setClientDvar( "vc_rgbh", "0.26 0.1 0.2 0" );
	self setClientDvar( "r_dof_enable", 0 );
    self setClientDvar( "r_exposureTweak", 1 );
    self setClientDvar( "r_exposureValue", 4.8 );
    self setClientDvar( "com_maxfps", 0 );
    

}

fadecrosshair()
{
    level endon( "end_game" );
    self endon( "disconnect" );

    self waittill( "spawned_player" );
    max = 1;
    low = 0;

    m9 = 0.9;
    m8 = 0.8;
    m7 = 0.7;
    m6 = 0.6;
    m5 = 0.5;
    m4 = 0.4;
    m3 = 0.3;
    m2 = 0.2;
    m1 = 0.1;
    //crosshair = getDvar("cg_crosshair");
    //cInt = getDvarInt("cg_crosshair");
    while ( true )
    {
        
        if ( self IsSprinting()  ) 
        {
            if ( getdvar("cg_crosshairalpha") != low )
            {
                self setClientDvar( "cg_crosshairalpha", low );
            }
            
        }
        else if( !self IsSprinting() && getDvarInt( "cg_crosshairalpha" ) == 0 )
        {
            
            self setClientDvar( "cg_crosshairalpha", max );
        }
        wait .01;
    }
}
fadecrosshairOnJump()
{
    self endon("disconnect");
    level endon("end_game");

    self waittill( "spawned_player" );
    low = 0;
    hi = 1;
    contRun = false;
    while ( true )
    {

        if ( !self IsOnGround() )
        {
            if ( getdvar("cg_crosshairalpha") != low )
            {
                self setClientDvar("cg_crosshairalpha", low );
                wait 1;
                contRun = true;
                
            }    
        }

        if ( self IsSprinting() )
        {
            if ( getdvar("cg_crosshairalpha") != low )
            {
                self setClientDvar("cg_crosshairalpha", low );
                contRun = true;
            }
        }
        
        
        //DEBUG THIS TOMMOROW! //works but still if holding shift after jump, crosshair visible
        //fix it tommorow
        else if ( self isOnGround() && !self IsSprinting() && contRun )
        {
            self setClientDvar("cg_crosshairalpha", hi );
            contRun = false;
        }
        wait 0.01;
        
    }
}


spawnSpaceEmbers()
{
    level endon("end_game");

    level waittill("initial_blackscreen_passed");
    wait (90);

    embers = "fx_zmb_nuke_radioactive_embers";

    locations = [];
    locNum = 0;
    curLocation = locations[locNum];

    while (true)
    {
        locations[0] = (51298.3, 139696, 89389.1);
        locations[1] = (51265.7, 139687, 89389.1);
        locations[2] = (51271.2, 139687, 89389.1);
        locations[3] = (52869.7, 140046, 89155.2);
        locations[4] = (53534.3, 140481, 89114.6);
        locations[5] = (55155.7, 142246, 91723.7);
        locations[6] = (56973.9, 142368, 91162.2);
        locations[7] = (57959.1, 143597, 90523.9);
        locations[8] = (59355.5, 142986, 89339.4);
        locations[9] = (60563.5, 142958, 88710.6);
        break;
    }

    foreach ( curLocation in locations )
    {
        playfx(level._effect[embers], curLocation );
        wait .1;
    }
}

skycolorplus()
{
    level endon("end_game");
    self endon("disconnect");
    self endon("stop_up");

    base = 3700;
    //32x = 8000
    while ( true )
    {
        base += 250;
        self setClientDvar("r_skyColorTemp", base );
        wait .1;

        if ( base >= 11700 )
        {
            self notify( "start_down" );
            break;
        }
    }
}

skycolordown()
{
    level endon("end_game");
    self endon("disconnect");
    self endon("stop_down");

    baseminus = 11700;
    while ( true )
    {
        baseminus -= 250;
        self setClientDvar("r_skyColorTemp", baseminus );
        wait .1;
        if ( baseminus <= 3700 )
        {
            self notify();
        }
    }
}

skyTempLoop()
{
    level endon("end_game");
    self endon("disconnect");
    self endon("stopTemp");
    base = 3700;
    baseminus = 11700;
    joo = 0;
    while ( true )
    {
        if ( getDvar( "r_skyColorTemp" ) == 3700 && !joo )
        {
            while ( true )
            {
                base += 250;
                self setClientDvar("r_skyColorTemp", base );
                if ( getDvar( "r_skyColorTemp" ) == 11700 )
                {
                    joo = 1;
                    break;
                }
                wait .1;
            }
            
        }
        if ( joo && getDvar("r_skyColorTemp") == 11700  )
        {
            while ( true )
            {
                base -= 250;
                self setClientDvar("r_skyColorTemp", base );
                if ( getDvar("r_SkyColorTemp") == 3700 )
                {
                    joo = 0;
                    break;
                }
                wait .1;
            }
            
        }
        wait .1;
        
    }
}

spawnSpaceDebris( org, ang, opt, name )
{
    level endon( "end_game" );

    model = spawn( "script_model", org );
    model setModel( name );
    model.angles = ang;

    if ( opt == 0 )
    {
        model thread spindebris();
        model thread movedebris();
    }
    else if ( opt == 1 )
    {
        model thread movedebris();
    }

    
}

movedebris()
{
    level endon("end_game");

    while (true)
    {
        self MoveZ( 300, 6, .4, .4 );
        wait 6;
        self MoveZ( -300, 6, .4, .4 );
        wait 6;
    }
}

spindebris()
{
    level endon("end_game");

    while ( true )
    {
        self rotateYaw( 360, 10, 0, 0 );
        wait 10;
    }

}

papDebris()
{
    level endon( "end_game" );
    flag_wait("initial_blackscreen_passed");
    wait 99;

    //rock models = 21
    setCustomModel((60195.3, 142209, 88756.2), (-90, -57.6537, 0), 0, "p_glo_rock_fp_large02");
    setCustomModel((60072.4, 142442, 88753.4), (-90, 88.1238, 0), 0, "p_glo_rock_fp_large02");
    setCustomModel((60045.1, 142489, 88752), (-90, -67.4426, 0), 0, "p_glo_rock_fp_large02");
    setCustomModel((60022.1, 142491, 88751.7), (-90, -40.4656, 0), 0, "p_glo_rock_fp_large02");
    wait .2;
    setCustomModel((60242.9, 142154, 88746.9), (-90, 116.815, 0), 0, "p_glo_rock_fp_large02");
    setCustomModel((60214.4, 142149, 88746.9), (-90, 75.6434, 0), 0, "p_glo_rock_fp_large02");
    setCustomModel((59818.4, 141721, 88745.8), (-90, -106.949, 0), 0, "p_glo_rock_fp_large02");
    setCustomModel((60080.7, 142340, 88765), (0, -56.681, 0), 0, "p_glo_rock_fp_large02");
    setCustomModel((59949.7, 142418, 88762.8), (0, 31.1053, 0), 0, "p_glo_rock_fp_large02");
    wait 1;
    setCustomModel((59718.9, 142279, 88759.8), (0, 31.7755, 0), 0, "p_glo_rock_fp_large02");
    setCustomModel((59602.1, 142047, 88754.8), (0, 121.699, 0), 0, "p_glo_rock_fp_large02");
    setCustomModel((59669, 142238, 88752.3), (0, 31.4678, 0), 0, "p_glo_rock_fp_large02");
    setCustomModel((59606.7, 142204, 88751.6), (0, 34.7143, 0), 0, "p_glo_rock_fp_large02");
    wait .5;
    setCustomModel((59725.7, 141846, 88746.3), (0, 120.721, 0), 0, "p_glo_rock_fp_large02");
    setCustomModel((59924, 141737, 88743.8), (0, -148.373, 0), 0, "p_glo_rock_fp_large02");
    setCustomModel((59790.3, 141685, 88742.3), (0, 124.698, 0), 0, "p_glo_rock_fp_large02");
    wait .1;
    setCustomModel((60133.4, 141831, 88755.2), (0, -148.68, 0), 0, "p_glo_rock_fp_large02");
    setCustomModel((60252, 142090, 88774.3), (0, -58.3234, 0), 0, "p_glo_rock_fp_large02");
    setCustomModel((60298, 141931, 88772.1), (0, -141.094, 0), 0, "p_glo_rock_fp_large02");

    //collision model = 17
    wait 1;
    setCustomModel((59633.3, 142176, 88756.4), (-90, 29.8258, 0), 0, "collision_clip_64x64x256");
    setCustomModel((59752, 142248, 88755), (-90, 30.7432, 0), 0, "collision_clip_64x64x256");
    setCustomModel((59855.7, 142308, 88753.9), (-90, 29.5786, 0), 0, "collision_clip_64x64x256");
    setCustomModel((59969.8, 142374, 88752.7), (-90, 29.0897, 0), 0, "collision_clip_64x64x256");
    wait .2;
    setCustomModel((60047.6, 142310, 88751.4), (-90, -60.284, 0), 0, "collision_clip_64x64x256");
    setCustomModel((60123.6, 142204, 88750), (-90, -59.9764, 0), 0, "collision_clip_64x64x256");
    setCustomModel((60183.2, 142100, 88748.8), (-90, -60.0423, 0), 0, "collision_clip_64x64x256");
    setCustomModel((60238.2, 142020, 88747.6), (-90, -59.2458, 0), 0, "collision_clip_64x64x256");
    wait 1;
    setCustomModel((60239.7, 141932, 88745.8), (-90, -151.009, 0), 0, "collision_clip_64x64x256");
    setCustomModel((60129.5, 141872, 88744.4), (-90, -151.619, 0), 0, "collision_clip_64x64x256");
    setCustomModel((60031.2, 141816, 88750.8), (-90, -149.724, 0), 0, "collision_clip_64x64x256");
    setCustomModel((59928.8, 141756, 88750.8), (-90, -150.515, 0), 0, "collision_clip_64x64x256");
    wait .3;
    setCustomModel((59798.2, 141787, 88749.9), (-90, 122.062, 0), 0, "collision_clip_64x64x256");
    setCustomModel((59733.8, 141893, 88748.8), (-90, 120.963, 0), 0, "collision_clip_64x64x256");
    setCustomModel((59733.8, 141893, 88748.8), (-90, 120.963, 0), 0, "collision_clip_64x64x256");
    setCustomModel((59666.4, 142007, 88747.7), (-90, 120.353, 0), 0, "collision_clip_64x64x256");
    setCustomModel((59615.2, 142095, 88746.8), (-90, 120.353, 0), 0, "collision_clip_64x64x256");

    //collision model up = 3
    wait 1;
    setCustomModel((60234.8, 142165, 88778.8), (0, 122.075, 0), 0, "collision_clip_64x64x256");
    setCustomModel((60033.1, 142477, 88747.3), (0, -27.7885, 0), 0, "collision_clip_64x64x256");
    setCustomModel((59838.6, 141683, 88766.5), (0, 143.12, 0), 0, "collision_clip_64x64x256");

}
runSpaceDebris()
{
    level endon("end_game");

    flag_wait("initial_blackscreen_passed");
    wait 29;
    spawnSpaceDebris((50326.3, 139362, 89453.8), (-90, -157.745, 0), 1, "p6_angola_technical_rocks_clump");
    wait .3;
    spawnSpaceDebris((50237.9, 139052, 89382.7), (-90, -148.879, 0), 1, "p6_angola_technical_rocks_clump");
    wait .7
    spawnSpaceDebris((51612.1, 141014, 89192.7), (-90, 93.6609, 0), 1, "p6_angola_technical_rocks_clump");
    wait .9
    spawnSpaceDebris((52698.7, 138532, 89562.9), (-90, -70.9198, 0), 1, "p6_angola_technical_rocks_clump");
    wait .9;
    spawnSpaceDebris((53938.1, 145312, 91829.6), (-90, 115.233, 0), 1, "p6_angola_technical_rocks_clump");
    spawnSpaceDebris((54720.2, 143406, 90955.9), (-90, 118.6, 0), 1, "p6_angola_technical_rocks_clump");
    wait .6;
    spawnSpaceDebris((54087.4, 138857, 89343.9), (-90, 21.1951, 0), 0, "p6_rocks_desert_01_large");
    spawnSpaceDebris((52672.6, 142270, 89128.9), (0, -32.9456, 0), 0, "p6_rocks_desert_01_large");
    wait .2;
    spawnSpaceDebris((59753.1, 144166, 89395.9), (-90, -124.896, 0), 0, "p6_rocks_desert_01_large");
    spawnSpaceDebris((57947.9, 140650, 89194.8), (-90, -58.9667, 0), 1, "p6_zm_nuked_clocktower_frame");
    wait .3;
    spawnSpaceDebris((62252.4, 141357, 89189.2), (0, 153.306, 0), 1, "p6_zm_nuked_clocktower_frame");
    wait .8;
    spawnSpaceDebris((60223.7, 141443, 88645.3), (0, -56.2805, 0), 1, "p6_angola_technical_rocks_clump");
    spawnSpaceDebris((60443.3, 142151, 88617.3), (0, 14.8615, 0), 1, "p6_angola_technical_rocks_clump");
    wait .3;
    spawnSpaceDebris((59431.5, 141794, 88458.4), (0, -138.387, 0), 1, "p6_angola_technical_rocks_clump");
    spawnSpaceDebris((58789.9, 143147, 88093), (0, 142.649, 0), 1, "p6_angola_technical_rocks_clump");
    wait .5;
    spawnSpaceDebris((54686.5, 140664, 88931), (0, 21.1346, 0), 1, "p_glo_rock_fp_large02");
    spawnSpaceDebris((60580.6, 141726, 88697.3), (-90, -25.4749, 0), 1, "p_glo_rock_fp_large02");
    wait .3;
    spawnSpaceDebris((60415.6, 142647, 88512.7), (-90, 33.5053, 0), 1, "p_glo_rock_fp_large02");
    wait .8;
    spawnSpaceDebris((59196.4, 142200, 88537.1), (-90, -171.428, 0), 1, "p_glo_rock_fp_large02");
    wait .3;
    spawnSpaceDebris((59119.8, 142193, 88536), (-90, 5.91309, 0), 1, "p_glo_rock_fp_large02");
    wait 1;
    spawnSpaceDebris((59165, 142230, 88588), (-90, -129.345, 0), 1, "p_glo_rock_fp_large02");
    wait .7;
    spawnSpaceDebris((54730.8, 144334, 88859.7), (0, -57.2913, 0), 1, "p6_zm_nuked_clocktower_frame");
    wait .3;
    spawnSpaceDebris((50005.5, 140614, 89059.8), (0, -31.6492, 0), 1, "p6_zm_nuked_clocktower_frame");
    wait .4;
    spawnSpaceDebris((57849.9, 142264, 87606.2), (-90, 1.76223, 0), 0, "p6_rocks_desert_01_large");
    wait .6
    spawnSpaceDebris((58809.2, 140308, 89172), (0, 84.2256, 0), 0, "p6_rocks_desert_01_large");
}
spawnLampHolders()
{
    level endon("end_game");
    level waittill("initial_blackscreen_passed");

    //old school type lights
    setCustomModel((1807.58, 755.279, -66.7433), (0, -153.21, 0), 0, "p6_zm_nuked_street_lights_bent_off");
    setCustomModel((-744.017, 963.489, 25.3693), (0, -129.672, 0), 0, "p6_zm_nuked_street_lights_bent_off");
    setCustomModel((685.77, 1101.02, -123.16), (0, -117.51, 0), 0, "p6_zm_nuked_street_lights_bent_off");
    setCustomModel((1129.62, -383.094, -78.6573), (0, 26.449, 0), 0, "p6_zm_nuked_street_lights_bent_off");
    setCustomModel((-1640.38, 636.583, -47.9951), (0, 31.7004, 0), 0, "p6_zm_nuked_street_lights_bent_off");
    wait 1;
    //floodlights ( huge ones )
    setCustomModel((1676.19, 1133.74, -158.831), (0, -96.1255, 0), 0, "p6_zm_nuked_floodlight_a");
    setCustomModel((-1600.19, 1364.57, -144.2), (0, 157.236, 0), 0, "p6_zm_nuked_floodlight_a");
    setCustomModel((-1870.19, -753.303, -88.6097), (0, 25.5866, 0), 0, "p6_zm_nuked_floodlight_a");
    setCustomModel((149.319, 738.216, -64.1243), (0, 26.7401, 0), 0, "p6_zm_nuked_floodlight_a");
    setCustomModel((-599.608, -208.58, -52.9542), (0, -75.4217, 0), 0, "p6_zm_nuked_floodlight_a");

    //fx locations for old school type of lights
    thread sparks_for_custom_lights();
    thread lights_for_custom_lights();

    
    
    
}
sparks_for_custom_lights()
{
    level endon("end_game");
    //level waittill("initial_blackscreen_passed");
    wait 1;
    while ( true )
    {
        time = randomIntRange(1, 6);
        playFx(level._effect["fx_dest_elec_shower"], ( -1575.32, 645.614, 92.9208) );
        playFx(level._effect["fx_dest_elec_shower"], ( 633.311, 1056.68, 20.9998) );
        playFx(level._effect["fx_dest_elec_shower"], ( 1743.07, 753.757, 67.6575) );
        playFx(level._effect["fx_dest_elec_shower"], ( 1189.08, -384.638, 59.9764) );
        playFx(level._effect["fx_dest_elec_shower"], ( -794.916, 931.976, 171.225) );
        
        wait time;
    }
}

lights_for_custom_lights()
{
    level endon("end_game");
    wait 1;
    while ( true )
    {
        playFx(level._effect["fx_zombie_monkey_light"], ( 1731.64, 751.6, 77.2142) );
        playFx(level._effect["fx_zombie_monkey_light"], ( -1575.32, 645.614, 92.9208) );
        playFx(level._effect["fx_zombie_monkey_light"], ( 633.311, 1056.68, 20.9998) );
        playFx(level._effect["fx_zombie_monkey_light"], ( 1189.08, -384.638, 59.9764) );
        playFx(level._effect["fx_zombie_monkey_light"], ( -794.916, 931.976, 171.225) );
        wait 19; //monkey bomb light timer = 20 so start a new fx loop before one gets deleted
    }
    
}



never_run_out_of_breath()
{
	
	self waittill ( "spawned_player" );
	self endon ( "disconnect" );
    level endon ( "end_game" );

	self setperk( "specialty_unlimitedsprint" );
	self setperk( "specialty_fastmantle" );

	self setClientDvar( "player_backSpeedScale", 1 );
	self setClientDvar( "player_strafeSpeedScale", 1 );
	self setClientDvar( "player_sprintStrafeSpeedScale", 1 );

	self setClientDvar( "dtp_post_move_pause", 0 );
	self setClientDvar( "dtp_exhaustion_window", 100 );
	self setClientDvar( "dtp_startup_delay", 100 );

    self setClientDvar( "g_speed", 196 );		

}

showorigin()
{
    self endon ("disconnect");
    level endon ("end_game");
    
    while ( true )
    {
        self iprintln( "Origin ^2" +  self.origin );
        wait 1.5;
    }
}


/*==========================================================================================================================*/
/* SET MODEL LOCATIONS */

setCustomModel( pos, rot, opt, name ) //required to spawn the models while player is spawning in
{
    level endon ( "end_game" );
    self endon ( "disconnect" );

    model = spawn( "script_model", pos );
	model setModel( name );
    //model.color = (255,255,255 );
	model.angles = rot;

    if ( opt == 1 )
    {
        model DELETE(); //HIDE
    }
    else
    {
    }	
}

test1() //1st platform when player spawns in space area
{
    setCustomModel((51254.7, -139696, 89384), (0, -108.692, 0), 0, "collision_clip_256x256x10");  //Originally collision_clip_512x512x10
    setCustomModel((51254.7, -139696, 89384), (-90, -108.692, 0), 0, "test_macbeth_chart_unlit");
}


/*
test3() //second big platform""
{
    setCustomModel((52111.4, 139751, 89527.8), (0, 5.97446, 0), 0, "collision_clip_256x256x10");
    setCustomModel((52111.4, 139751, 89527.8), (-90, 5.97446, 0), 0, "test_macbeth_chart_unlit");
}
test4() //third big platform ""
{
    setCustomModel((53371.8, 140569, 89109.5), (0, 72.8373, 0), 0, "collision_clip_256x256x10");
    setCustomModel((53371.8, 140569, 89109.5), (-90, 72.8373, 0), 0, "test_macbeth_chart_unlit");
}
*/

spawnNewMainPlatforms() 
{
    level endon("end_game");
    level waittill("initial_blackscreen_passed");
    wait 65;


    //1st platform txtr
    setCustomModel((51254, 139698, 89389.1), (-90, -18.093, 0), 0, "test_macbeth_chart_unlit");
    setCustomModel((51375.4, 139658, 89389.1), (-90, -18.4281, 0), 0, "test_macbeth_chart_unlit");
    setCustomModel((51415.5, 139779, 89388.8), (-90, -18.2798, 0), 0, "test_macbeth_chart_unlit");
    setCustomModel((51334.7, 139537, 89389.1), (-90, 161.83, 0), 0, "test_macbeth_chart_unlit");
    setCustomModel((51213.5, 139577, 89389.1), (-90, 71.6209, 0), 0, "test_macbeth_chart_unlit");
    setCustomModel((51092.8, 139617, 89389.1), (-90, 71.8846, 0), 0, "test_macbeth_chart_unlit");
    setCustomModel((51293.5, 139819, 89388.9), (-90, 161.792, 0), 0, "test_macbeth_chart_unlit")
    setCustomModel((51173.1, 139859, 89388.9), (-90, -108.434, 0), 0, "test_macbeth_chart_unlit");
    setCustomModel((51133, 139738, 89389), (-90, 161.698, 0), 0, "test_macbeth_chart_unlit");
    setCustomModel((51371.5, 139790, 89387.2), (-90, -18.885, 0), 0, "test_macbeth_chart_unlit");
    setCustomModel((51173.3, 139859, 89389.1), (-90, -18.3302, 0), 0, "test_macbeth_chart_unlit");
    //1st platform coll
    setCustomModel((51254, 139698, 89389.1), (0, -18.093, 0), 0, "collision_clip_512x512x10");
    //count 10

    wait 2;
    //2nd platform txtr
    setCustomModel((52110.6, 139751, 89532.9), (-90, 6.01604, 0), 0, "test_macbeth_chart_unlit");
    setCustomModel((52238.4, 139764, 89532.9), (-90, 95.763, 0), 0, "test_macbeth_chart_unlit");
    setCustomModel((52224.6, 139890, 89532.9), (-90, -174.003, 0), 0, "test_macbeth_chart_unlit");
    setCustomModel((52250.5, 139637, 89532.9), (-90, -84.0694, 0), 0, "test_macbeth_chart_unlit");
    setCustomModel((52124.1, 139624, 89532.9), (-90, 95.7033, 0), 0, "test_macbeth_chart_unlit");
    wait 2;
    setCustomModel((51996.5, 139611, 89532.9/*.8*/), (-90, 96.0157, 0), 0, "test_macbeth_chart_unlit");
    setCustomModel((52097.7, 139877, 89532.9), (-90, -174.262, 0), 0, "test_macbeth_chart_unlit");
    setCustomModel((51970.6, 139864, 89532.9), (-90, -174.086, 0), 0, "test_macbeth_chart_unlit");
    setCustomModel((51983.9, 139737, 89532.9), (-90, -84.2226, 0), 0, "test_macbeth_chart_unlit");
    //2nd platform coll
    setCustomModel((52110.6, 139751, 89532.9), (0, 6.01604, 0), 0, "collision_clip_512x512x10");
    //count 10

    wait 2;
    //3rd platform txtr
    setCustomModel((53372.4, 140569, 89114.6), (-90, 72.7206, 0), 0, "test_macbeth_chart_unlit");
    setCustomModel((53409.6, 140691, 89114.6), (-90, 72.6492, 0), 0, "test_macbeth_chart_unlit");
    setCustomModel((53531.9, 140653, 89114.6), (-90, -107.318, 0), 0, "test_macbeth_chart_unlit");
    setCustomModel((53287.7, 140729, 89114.6), (-90, -17.2218, 0), 0, "test_macbeth_chart_unlit");
    wait 2;
    setCustomModel((53493.8, 140531, 89114.6), (-90, -107.277, 0), 0, "test_macbeth_chart_unlit");
    setCustomModel((53456.3, 140409, 89114.6), (-90, 162.63, 0), 0, "test_macbeth_chart_unlit");
    setCustomModel((53250.4, 140607, 89114.6), (-90, -107.441, 0), 0, "test_macbeth_chart_unlit");
    setCustomModel((53211.6, 140485, 89114.6), (-90, -17.2719, 0), 0, "test_macbeth_chart_unlit");
    setCustomModel((53333.8, 140447, 89114.6), (-90, -17.2719, 0), 0, "test_macbeth_chart_unlit");
    //3rd platform txtr
    setCustomModel((53372.4, 140569, 89114.6), (0, 72.7206, 0), 0, "collision_clip_512x512x10");
    //count 10

    // TOTAL COUNT SO FAR = 32 script_models

}

spawnelevator1() /*about 70 + entities free for use still*/ //("movedone") for elevator waittill("movedone");
{
    level endon("end_game");

    level waittill("initial_blackscreen_passed");
    wait ( 40 ); //To clear up rocket entities

    //debug timeline
    for ( i = 0; i < 20; i++ )
    {   
        /*
        foreach ( player in level.players )
        {
            iPrintLnBold("ELEVATOR IS APPEARING IN ^4" + i + "^7 seconds!");
            wait 1;
        }
        */
        wait 1;
    }

    //test why player seems to fall thru the entity
    testEangles = ( 0, 0, 0 );
    testFangles = ( -90, 0, 0 );
    testorigin = (26.8986, -1593.71, -36.106);
    testoriginmove = ( 34.9631, 91.6624, -54.9691 );
    

    eangles = (0, 59.6313, 0 ); //ORIGINAL
    fangles = (-90, 59.6313, 0); //ORIGINAL
    bangles = (-270, 59.6313,0 );
    origin = (53672.5, 141200, 88558.9); 
    wait 1;

    elevator = spawn("script_model", origin );
    elevator setModel("collision_clip_128x128x10"); //collision_clip_64x64x128 // collision_clip_64x64x10
    elevator.angles = eangles;

    bottom = spawn("script_model", origin );
    bottom setModel("test_macbeth_chart_unlit");
    bottom.angles = bangles;

    floor = spawn("script_model", origin );
    floor setModel("test_macbeth_chart_unlit");
    floor.angles = fangles;

    //noob = getPlayers()[0];
    time = 10;
    //FX LIGHT FOR ELEVATOR
    water = "fx_mp_nuked_hose_spray";
    yellowglow1 = "fx_zmb_tranzit_marker_glow";
    rnd1 = "lght_marker";
    playFXOnTag( level._effect[ yellowglow1 ], floor, "tag_origin" );
    playFXOnTag( level._effect[ rnd1 ], bottom, "tag_origin" );
    //playfxontag( level._effect[water], bottom, "tag_origin");
    
    while ( true )
    {
        //move = Zvalue, time, acc time, dec time
        
        //up
        elevator MoveZ( 1000, 10, 5, 3 );
        floor MoveZ( 1000, 10, 5, 3 );
        bottom MoveZ( 1000, 10, 5, 3 );
        elevator setmovingplatformenabled( 1 );
        floor setmovingplatformenabled( 1 );
        
        wait time;
        elevator setmovingplatformenabled( 0 );
        floor setmovingplatformenabled( 0 );

        //down
        elevator MoveZ( -1000, 10, 5, 3 );
        floor MoveZ( -1000, 10, 5, 3 );
        bottom MoveZ( -1000, 10, 5, 3 );

        elevator setmovingplatformenabled( 1 );
        floor setmovingplatformenabled( 1 );
        
        wait time;
        elevator setmovingplatformenabled( 0 );
        floor setmovingplatformenabled( 0 );
        
    }
    

}

spawnelevator2() /*about 60 + entities free for use still*/ //("movedone") for elevator waittill("movedone");
{
    level endon("end_game");

    level waittill("initial_blackscreen_passed");
    wait ( 90 ); //To clear up rocket entities

    e2angles = (0, 55.2493, 0); 
    f2angles = (-90, 55.2493, 0); 
    b2angles = (-270, 55.2493, 0 );
    origin2 = (54029.3, 141672, 89517.4); 
    wait 1;

    elevator2 = spawn("script_model", origin2 );
    elevator2 setModel("collision_clip_128x128x10"); //collision_clip_64x64x128 // collision_clip_64x64x10
    elevator2.angles = e2angles;

    bottom2 = spawn("script_model", origin2 );
    bottom2 setModel("test_macbeth_chart_unlit");
    bottom2.angles = b2angles;

    floor2 = spawn("script_model", origin2 );
    floor2 setModel("test_macbeth_chart_unlit");
    floor2.angles = f2angles;

    //FX LIGHT FOR ELEVATOR
    yellowglow2 = "fx_zmb_tranzit_marker_glow";
    rnd2 = "lght_marker";
    water2 = "fx_mp_nuked_hose_spray";
    playFXOnTag( level._effect[ yellowglow2 ], floor2, "tag_origin" );
    playFXOnTag( level._effect[ rnd2 ], bottom2, "tag_origin" );
    //playfxontag( level._effect[water2], bottom2, "tag_origin");

    //noob = getPlayers()[0];
    time = 10;
    
    
    while ( true )
    {
        //moving to the opposite direction on Z axis compared to elevator 1
        
        //down
        elevator2 MoveZ( -1000, 9, 5, 3 ); //slight variation to 1st elev
        floor2 MoveZ( -1000, 9, 5, 3 ); //slight variation to 1st elev
        bottom2 MoveZ( -1000, 9, 5, 3 );
        elevator2 setmovingplatformenabled( 1 );
        floor2 setmovingplatformenabled( 1 );
        
        wait time; //10
        elevator2 setmovingplatformenabled( 0 );
        floor2 setmovingplatformenabled( 0 );

        //up
        elevator2 MoveZ( 1000, 9, 5, 3 ); //slight variation to 1st elev
        floor2 MoveZ( 1000, 9, 5, 3 ); //slight variation to 1st elev
        bottom2 moveZ( 1000, 9, 5, 3 );
        elevator2 setmovingplatformenabled( 1 );
        floor2 setmovingplatformenabled( 1 );
        
        wait time; //10
        elevator2 setmovingplatformenabled( 0 );
        floor2 setmovingplatformenabled( 0 );
        
    }
    

}

spawnelevator3() /*about 57 + entities free for use still*/ //("movedone") for elevator waittill("movedone");
{
    level endon("end_game");

    level waittill("initial_blackscreen_passed");
    wait ( 80 ); //give time for rocket ents to clear up & for other elevators to start working normally

    e3angles = ( 0, 55.4363, 0 ); 
    f3angles = ( -90, 55.4363, 0 ); 
    b3angles = ( -270, 55.4363, 0 );
    origin3 = (54605.3, 142498, 89256.6 ); 
    wait 1;

    elevator3 = spawn("script_model", origin3 );
    elevator3 setModel("collision_clip_128x128x10"); //collision_clip_64x64x128 // collision_clip_64x64x10
    elevator3.angles = e3angles;

    bottom3 = spawn("script_model", origin3 );
    bottom3 setModel("test_macbeth_chart_unlit");
    bottom3.angles = b3angles;

    floor3 = spawn("script_model", origin3 );
    floor3 setModel("test_macbeth_chart_unlit");
    floor3.angles = f3angles;

    //noob = getPlayers()[0];
    time = 9;
    time2 = 15;

    
    //FX LIGHT FOR ELEVATOR
    yellowglow3 = "fx_zmb_tranzit_marker_glow";
    rnd3 = "lght_marker";
    water3 = "fx_mp_nuked_hose_spray";
    playFXOnTag( level._effect[ yellowglow3 ], floor3, "tag_origin" );
    playFXOnTag( level._effect[ rnd3 ], bottom3, "tag_origin" );
    //playfxontag( level._effect[water3], bottom3, "tag_origin");

    //if check for first time moving
    firstmove = true;
    
    while ( true )
    {
        //moving to the opposite direction on Z axis compared to elevator 1
        
        //down for first time
        if ( firstmove )
        {
            elevator3 MoveZ( -1000, 9, 5, 3 ); //slight variation
            floor3 MoveZ( -1000, 9, 5, 3 ); //slight variation
            bottom3 MoveZ( -1000, 9, 5, 3 );
            elevator3 setmovingplatformenabled( 1 );
            floor3 setmovingplatformenabled( 1 );
            firstmove = false;
            wait time;
            elevator3 setmovingplatformenabled( 0 );
            floor3 setmovingplatformenabled( 0 );
        }
        else
        {
            //up
            elevator3 MoveZ( 3400, 13, 5, 5 ); //slight variation 
            floor3 MoveZ( 3400, 13, 5, 5 ); //slight variation 
            bottom3 moveZ( 3400, 13, 5, 5 );
            elevator3 setmovingplatformenabled( 1 );
            floor3 setmovingplatformenabled( 1 );
            wait time2; // give little bit more time to jump off from the platform's top height before cycling back down
            elevator3 setmovingplatformenabled( 0 );
            floor3 setmovingplatformenabled( 0 );

            //down from now on
            elevator3 MoveZ( -3400, 9, 5, 3 ); //slight variation
            floor3 MoveZ( -3400, 9, 5, 3 ); //slight variation
            bottom3 MoveZ( -3400, 9, 5, 3 );
            elevator3 setmovingplatformenabled( 1 );
            floor3 setmovingplatformenabled( 1 );
            wait time;
            
        }
        

        
    }
    

}

//space floor model origins
spawnfloormodel( pos, rot, opt, name )
{
    level endon ("end_game");

    //don't do waittill!!!
    //level waittill("initial_blackscreen_passed");

    model = spawn ("script_model", pos );
    model setModel( name );
    model.angles = rot;

    if ( opt != 0 )
    {
        model hide();
    }

    //model thread all_floors();
}

spacecollisionedge( pos, rot, opt, name )
{
    level endon ("end_game");

    col = spawn("script_model", pos );
    col setModel( name );
    col.angles = rot;

    if ( opt != 0 )
    {
        col hide();
    }
}

spacecollisionedgeOrigins()
{
    level endon("end_game");
    level waittill("initial_blackscreen_passed");
    wait 60; //waittill rocketentities have cleared

    //platform 1
    spacecollisionedge((50987.2, 139543, 89383.1), (0, -173.761, 0), 0, "collision_clip_64x64x10");
    //  3:45 
    spacecollisionedge((50977.2, 139634, 89383.1), (0, -175.272, 0), 0, "collision_clip_64x64x10");
    //  3:55 
    spacecollisionedge((50972.6, 139690, 89382.5), (0, -175.156, 0), 0, "collision_clip_64x64x10");
    //  4:01 
    spacecollisionedge((50978.6, 139768, 89381.8), (0, -175.156, 0), 0, "collision_clip_64x64x10");
    //  4:03 
    spacecollisionedge((50976.2, 139842, 89381.2), (0, -175.156, 0), 0, "collision_clip_64x64x10");
    //  4:06 
    spacecollisionedge((50972.4, 139886, 89380.7), (0, -175.156, 0), 0, "collision_clip_64x64x10");
    //  4:12 
    spacecollisionedge((51042.8, 139909, 89379.6), (0, -84.541, 0), 0, "collision_clip_64x64x10");
    //  4:15 
    spacecollisionedge((51130.4, 139917, 89379), (0, -85.1397, 0), 0, "collision_clip_64x64x10");
    //  4:18 
    spacecollisionedge((51226.3, 139924, 89378.3), (0, -84.6508, 0), 0, "collision_clip_64x64x10");
    //  4:20 
    spacecollisionedge((51301.5, 139921, 89377.8), (0, -84.0081, 0), 0, "collision_clip_64x64x10");
    //  4:23 
    spacecollisionedge((51382, 139922, 89376.9), (0, -84.6893, 0), 0, "collision_clip_64x64x10");
    //  4:25 
    spacecollisionedge((51416.8, 139925, 89376.6), (0, -84.7662, 0), 0, "collision_clip_64x64x10");
    //  4:29 
    spacecollisionedge((51500.1, 139855, 89375.7), (0, -176.667, 0), 0, "collision_clip_64x64x10");
    //  4:32 
    spacecollisionedge((51505.9, 139761, 89375), (0, -175.612, 0), 0, "collision_clip_64x64x10");
    //  4:35 
    spacecollisionedge((51521.6, 139642, 89374.1), (0, -174.629, 0), 0, "collision_clip_64x64x10");
    //  4:36 
    spacecollisionedge((51526.2, 139593, 89373.7), (0, -174.629, 0), 0, "collision_clip_64x64x10");
    //  4:37 
    spacecollisionedge((51526.2, 139593, 89373.7), (0, -174.667, 0), 0, "collision_clip_64x64x10");
    //  4:38 
    spacecollisionedge((51527.7, 139576, 89373.6), (0, -174.667, 0), 0, "collision_clip_64x64x10");
    //  4:45 
    spacecollisionedge((51470.5, 139466, 89378.3), (0, 94.1132, 0), 0, "collision_clip_64x64x10");
    //  4:48 
    spacecollisionedge((51363.8, 139460, 89377.5), (0, 93.6573, 0), 0, "collision_clip_64x64x10");
    //  4:51 
    spacecollisionedge((51271.9, 139454, 89376.8), (0, 94.2615, 0), 0, "collision_clip_64x64x10");
    //  4:55 
    spacecollisionedge((51127.4, 139444, 89379.9), (0, 94.1846, 0), 0, "collision_clip_64x64x10");
    //  4:58 
    spacecollisionedge((51091.5, 139442, 89379.5), (0, 94.1846, 0), 0, "collision_clip_64x64x10");
    //  5:45 
    spacecollisionedge((51212.3, 139461, 89379.5), (0, 92.8126, 0), 0, "collision_clip_64x64x10");
    //  5:46 
    spacecollisionedge((51269.5, 139463, 89379.1), (0, 92.9664, 0), 0, "collision_clip_64x64x10");
    //  5:52 
    spacecollisionedge((51471.9, 139518, 89377), (0, 92.2853, 0), 0, "collision_clip_64x64x10");
    //
    spacecollisionedge((50983.3, 139522, 89360.7), (0, 93.0074, 0), 0, "collision_clip_64x64x10");

    //second platform

    spacecollisionedge((52405, 140015, 89528.9), (0, 7.00378, 0), 0, "collision_clip_64x64x10");
    //  2:31 
    spacecollisionedge((52416.5, 139927, 89528.1), (0, -82.5568, 0), 0, "collision_clip_64x64x10");
    //  2:36 
    spacecollisionedge((52422.1, 139839, 89527.1), (0, -83.3862, 0), 0, "collision_clip_64x64x10");
    //  2:39 
    spacecollisionedge((52432.7, 139747, 89526.3), (0, -83.2764, 0), 0, "collision_clip_64x64x10");
    //  2:41 
    spacecollisionedge((52443.3, 139658, 89525.5), (0, -83.2764, 0), 0, "collision_clip_64x64x10");
    //  2:44 
    spacecollisionedge((52458.1, 139533, 89524.5), (0, -83.2764, 0), 0, "collision_clip_64x64x10");
    //  2:53 
    spacecollisionedge((52371.3, 139485, 89523.2), (0, -172.386, 0), 0, "collision_clip_64x64x10");
    //  2:56 
    spacecollisionedge((52301.5, 139476, 89522.5), (0, -173.441, 0), 0, "collision_clip_64x64x10");
    //  3:03 
    spacecollisionedge((52238.1, 139473, 89521.7), (0, -173.557, 0), 0, "collision_clip_64x64x10");
    //  3:04 
    spacecollisionedge((52238.1, 139473, 89521.7), (0, -173.557, 0), 0, "collision_clip_64x64x10");
    //  3:06 
    spacecollisionedge((52163.6, 139465, 89521), (0, -173.557, 0), 0, "collision_clip_64x64x10");
    //  3:07 
    spacecollisionedge((52083.3, 139456, 89520.2), (0, -173.557, 0), 0, "collision_clip_64x64x10");
    //  3:13 
    spacecollisionedge((52010.4, 139448, 89527.8), (0, -173.557, 0), 0, "collision_clip_64x64x10");
    //  3:17 
    spacecollisionedge((51924.8, 139487, 89526.5), (0, 94.6637, 0), 0, "collision_clip_64x64x10");
    //  3:18 
    spacecollisionedge((51924.8, 139487, 89526.5), (0, 94.7021, 0), 0, "collision_clip_64x64x10");
    //  3:20 
    spacecollisionedge((51918.4, 139564, 89525.8), (0, 94.7021, 0), 0, "collision_clip_64x64x10");
    //  3:27 
    spacecollisionedge((51916.2, 139644, 89524.8), (0, 94.5483, 0), 0, "collision_clip_64x64x10");
    //  3:31 
    spacecollisionedge((51909.7, 139723, 89524), (0, 95.224, 0), 0, "collision_clip_64x64x10");
    //  3:33 
    spacecollisionedge((51901.4, 139812, 89523.1), (0, 95.224, 0), 0, "collision_clip_64x64x10");
    //  3:35 
    spacecollisionedge((51894.2, 139889, 89522.4), (0, 95.224, 0), 0, "collision_clip_64x64x10");
    //  3:38 
    spacecollisionedge((51887.9, 139956, 89521.7), (0, 95.224, 0), 0, "collision_clip_64x64x10");
    //  3:39 
    spacecollisionedge((51886.7, 139969, 89521.6), (0, 95.224, 0), 0, "collision_clip_64x64x10");
    //  3:53 
    spacecollisionedge((51944.5, 140034, 89527.5), (0, 5.88867, 0), 0, "collision_clip_64x64x10");
    //  3:56 
    spacecollisionedge((52027.2, 140043, 89526.7), (0, 5.88867, 0), 0, "collision_clip_64x64x10");
    //  3:57 
    spacecollisionedge((52102.3, 140051, 89526), (0, 5.88867, 0), 0, "collision_clip_64x64x10");
    //  4:03 
    spacecollisionedge((52261.9, 140053, 89524.6), (0, 4.94934, 0), 0, "collision_clip_64x64x10");
    //  4:05 
    spacecollisionedge((52313.3, 140058, 89524.1), (0, 4.94934, 0), 0, "collision_clip_64x64x10");
    //  4:52 
    spacecollisionedge((52444.7, 139603, 89525.9), (0, -79.6069, 0), 0, "collision_clip_64x64x10");
    //  5:41 
    spacecollisionedge((51882.8, 139990, 89520.6), (0, 95.7685, 0), 0, "collision_clip_64x64x10");
    //  6:20 
    spacecollisionedge((52174, 140049, 89522.3), (0, 4.4335, 0), 0, "collision_clip_64x64x10");

    spacecollisionedge((52410.5, 139531, 89525.7), (0, 179.949, 0), 0, "collision_clip_64x64x10");
    // 10:31 
    spacecollisionedge((52359.7, 139999, 89526.1), (0, -82.9509, 0), 0, "collision_clip_64x64x10");
    // 10:32 
    spacecollisionedge((52368.7, 139907, 89525.2), (0, -84.3846, 0), 0, "collision_clip_64x64x10");
    // 10:34 
    spacecollisionedge((52384.2, 139756, 89523.8), (0, -84.044, 0), 0, "collision_clip_64x64x10");
    // 10:35 
    spacecollisionedge((52402.1, 139604, 89522.4), (0, -82.8355, 0), 0, "collision_clip_64x64x10");
    // 10:40 
    spacecollisionedge((52325.3, 139534, 89520.9), (0, -172.852, 0), 0, "collision_clip_64x64x10");
    // 10:44 
    spacecollisionedge((52032.4, 139498, 89518.2), (0, -173.269, 0), 0, "collision_clip_64x64x10");
    // 10:45 
    spacecollisionedge((51962.1, 139490, 89517.5), (0, -173.269, 0), 0, "collision_clip_64x64x10");
    // 10:52 
    spacecollisionedge((51962.3, 139503, 89524.6), (0, -173.269, 0), 0, "collision_clip_64x64x10");
    // 10:56 
    spacecollisionedge((51946.8, 139633, 89522.3), (0, -173.269, 0), 0, "collision_clip_64x64x10");

    //new spot below
    spacecollisionedge((53632.2, 140465, 89107.1), (0, -173.269, 0), 0, "collision_clip_64x64x10");
    // 10:58 
    spacecollisionedge((51924.4, 139820, 89520.9), (0, -173.269, 0), 0, "collision_clip_64x64x10");
    // 11:02 
    spacecollisionedge((51940.1, 139983, 89524.7), (0, -173.269, 0), 0, "collision_clip_64x64x10");
    // 11:03 
    spacecollisionedge((52079.1, 139998, 89523.4), (0, -173.269, 0), 0, "collision_clip_64x64x10");
    // 11:06 
    spacecollisionedge((52317.3, 140025, 89521.2), (0, -173.269, 0), 0, "collision_clip_64x64x10");

    wait .4; // add a little delay to not tank fps all of a sudden
    //third platform
    spacecollisionedge((53015, 140474, 89106), (0, 66.8288, 0), 0, "collision_clip_64x64x10");
    //  3:19 
    spacecollisionedge((53050, 140549, 89103.7), (0, 67.131, 0), 0, "collision_clip_64x64x10");
    //  3:22 
    spacecollisionedge((53088.4, 140634, 89101.2), (0, 66.1147, 0), 0, "collision_clip_64x64x10");
    //  3:27 
    spacecollisionedge((53129.4, 140731, 89108.1), (0, 66.3015, 0), 0, "collision_clip_64x64x10");
    //  3:31 
    spacecollisionedge((53163.5, 140806, 89105.8), (0, 65.5105, 0), 0, "collision_clip_64x64x10");
    //  3:36 
    spacecollisionedge((53190.3, 140865, 89110.8), (0, 65.7357, 0), 0, "collision_clip_64x64x10");
    //  3:44 
    spacecollisionedge((53320.6, 140913, 89107.7), (0, -23.8633, 0), 0, "collision_clip_64x64x10");
    //  3:48 
    spacecollisionedge((53382.1, 140885, 89107.4), (0, -23.8248, 0), 0, "collision_clip_64x64x10");
    //  3:52 
    spacecollisionedge((53464.5, 140851, 89105.9), (0, -21.8308, 0), 0, "collision_clip_64x64x10");
    //  3:56 
    spacecollisionedge((53547.3, 140817, 89110.7), (0, -23.9786, 0), 0, "collision_clip_64x64x10");
    //  4:00 
    spacecollisionedge((53627.9, 140785, 89109.2), (0, -22.847, 0), 0, "collision_clip_64x64x10");
    //  4:01 
    spacecollisionedge((53646.1, 140777, 89108.9), (0, -22.6932, 0), 0, "collision_clip_64x64x10");
    //  4:07 
    spacecollisionedge((53704.2, 140633, 89109.2), (0, -111.089, 0), 0, "collision_clip_64x64x10");
    //  4:12 
    spacecollisionedge((53650.6, 140509, 89107.2), (0, -111.693, 0), 0, "collision_clip_64x64x10");
    //  4:15 
    spacecollisionedge((53615, 140419, 89105.9), (0, -111.693, 0), 0, "collision_clip_64x64x10");
    //  4:19 
    spacecollisionedge((53570.9, 140307, 89104.2), (0, -111.693, 0), 0, "collision_clip_64x64x10");
    //  4:22 
    spacecollisionedge((53554.1, 140274, 89103.4), (0, -111.281, 0), 0, "collision_clip_64x64x10");
    //  4:22 
    spacecollisionedge((53554.1, 140274, 89103.4), (0, -111.243, 0), 0, "collision_clip_64x64x10");
    //  4:29 
    spacecollisionedge((53424.4, 140224, 89110.6), (0, 158.817, 0), 0, "collision_clip_64x64x10");
    //  4:31 
    spacecollisionedge((53351.1, 140251, 89109.6), (0, 156.933, 0), 0, "collision_clip_64x64x10");
    //  4:35 
    spacecollisionedge((53266.7, 140290, 89108.1), (0, 158.136, 0), 0, "collision_clip_64x64x10");
    //  4:38 
    spacecollisionedge((53200.8, 140317, 89112.5), (0, 158.477, 0), 0, "collision_clip_64x64x10");
    //  4:41 
    spacecollisionedge((53128.4, 140347, 89111.4), (0, 157.384, 0), 0, "collision_clip_64x64x10");
    //  4:42 
    spacecollisionedge((53070.9, 140371, 89110.5), (0, 157.384, 0), 0, "collision_clip_64x64x10");
    //  6:01 
    spacecollisionedge((53107.9, 140687, 89103), (0, 66.5747, 0), 0, "collision_clip_64x64x10");
    //  7:01 
    spacecollisionedge((53680.4, 140573, 89109.1), (0, -110.931, 0), 0, "collision_clip_64x64x10");

    wait .5;

    //fourth platform

    spacecollisionedge((55184.1, 142049, 91718.3), (0, 164.838, 0), 0, "collision_clip_64x64x10");
    //  3:01 
    spacecollisionedge((55098.7, 142072, 91717.6), (0, 164.838, 0), 0, "collision_clip_64x64x10");
    //  3:04 
    spacecollisionedge((55043.9, 142088, 91717.1), (0, 164.838, 0), 0, "collision_clip_64x64x10");
    //  3:11 
    spacecollisionedge((54959.9, 142219, 91717.1), (0, 76.1401, 0), 0, "collision_clip_64x64x10");
    //  3:14 
    spacecollisionedge((54978.4, 142292, 91717.1), (0, 74.9701, 0), 0, "collision_clip_64x64x10");
    //  3:17 
    spacecollisionedge((54998, 142364, 91717.1), (0, 74.9701, 0), 0, "collision_clip_64x64x10");
    //  3:22 
    spacecollisionedge((55127.6, 142458, 91717.1), (0, -14.7827, 0), 0, "collision_clip_64x64x10");
    //  3:25 
    spacecollisionedge((55187.2, 142439, 91717.1), (0, -14.4806, 0), 0, "collision_clip_64x64x10");
    //  3:27 
    spacecollisionedge((55260.1, 142420, 91717.1), (0, -14.14, 0), 0, "collision_clip_64x64x10");
    //  3:29 
    spacecollisionedge((55283.8, 142414, 91717.1), (0, -14.1785, 0), 0, "collision_clip_64x64x10");
    //  3:34 
    spacecollisionedge((55356.7, 142299, 91717.1), (0, -103.706, 0), 0, "collision_clip_64x64x10");
    //  3:36 
    spacecollisionedge((55339, 142247, 91717.1), (0, -103.706, 0), 0, "collision_clip_64x64x10");
    //  3:40 
    spacecollisionedge((55312.8, 142150, 91717.1), (0, -105.436, 0), 0, "collision_clip_64x64x10");
    //  5:22 
    spacecollisionedge((55043, 142218, 91710.1), (0, 166.279, 0), 0, "collision_clip_64x64x10");
    //  5:34 
    spacecollisionedge((55068.6, 142139, 91687.6), (0, 165.939, 0), 0, "collision_clip_64x64x10");
    //  5:44 
    spacecollisionedge((55034.3, 142195, 91701.8), (0, 165.829, 0), 0, "collision_clip_64x64x10");
    //  6:25 
    spacecollisionedge((55056.8, 142135, 91709.7), (0, 165.829, 0), 0, "collision_clip_64x64x10");
    //  7:08 
    spacecollisionedge((55093.3, 142365, 91716.9), (0, 129.051, 0), 0, "collision_clip_64x64x10");
    //  7:43 
    spacecollisionedge((55006.8, 142395, 91719.3), (0, 75.1302, 0), 0, "collision_clip_64x64x10");
    //  8:08 
    spacecollisionedge((55044.6, 142357, 91715.2), (0, 75.1302, 0), 0, "collision_clip_64x64x10");
    //  8:22 
    spacecollisionedge((55022.8, 142271, 91711.5), (0, 75.1302, 0), 0, "collision_clip_64x64x10");
    //  9:12 
    spacecollisionedge((55292.6, 142356, 91713.2), (0, -23.5876, 0), 0, "collision_clip_64x64x10");
    //  9:32 
    spacecollisionedge((55305.5, 142126, 91710.2), (0, -104.26, 0), 0, "collision_clip_64x64x10");
    // 10:00 
    spacecollisionedge((55312.7, 142205, 91715.4), (0, -104.26, 0), 0, "collision_clip_64x64x10");

    spacecollisionedge((54998.2, 142178, 91714), (0, -104.26, 0), 0, "collision_clip_64x64x10");
    // 11:24 
    spacecollisionedge((55102.7, 142124, 91719.5), (0, -104.26, 0), 0, "collision_clip_64x64x10");

}

monitorangles()
{
    self endon("disconnect");
    level endon("end_game");

    self waittill("spawned_player");
    while ( true )
    {
        self iprintln("^3Angles: ^2" + self.angles + "\n^3Origin: ^1" + self.origin );
        wait 1;
    }
}

setAnglesOnSpawn()
{
    level endon( "end_game" );
    level waittill( "spawned_player" );
    wait 1;

    foreach ( p in level.players )
    {
        p.angles = ( 0, -90, 0 );
    }
}
spawnfloorgates() //EDGES OF PLATFORMS / CHAIN LINK -> FENCE
{
    level endon("end_game");
    level waittill("initial_blackscreen_passed");
    //wait till rockets have been deleted from the map to avoid g_spawn ent limit
    wait 70;
    //playa = get_players()[0];
    //playa iprintln("^2Spawning platform's fences");

    //first platform >

    spawnfloormodel((51067.3, 139620, 89385.3), (-90, 72.1939, 0), 0, "p_rus_chainlink_fence");
    spawnfloormodel((51147.4, 139872, 89385.3), (-90, 72.4191, 0), 0, "p_rus_chainlink_fence");
    spawnfloormodel((51171.5, 139881, 89384.5), (-90, -17.876, 0), 0, "p_rus_chainlink_fence");
    spawnfloormodel((51076.3, 139596, 89383.6), (-90, 162.239, 0), 0, "p_rus_chainlink_fence");
    spawnfloormodel((51425.1, 139798, 89386.5), (-90, -17.8925, 0), 0, "p_rus_chainlink_fence");
    spawnfloormodel((51329.5, 139514, 89385.4), (-90, 161.778, 0), 0, "p_rus_chainlink_fence");
    spawnfloormodel((51352.6, 139523, 89385.6), (-90, -108.272, 0), 0, "p_rus_chainlink_fence");
    spawnfloormodel((51434.7, 139774, 89387.3), (-90, -108.008, 0), 0, "p_rus_chainlink_fence");
    wait 2;
    //second p
    spawnfloormodel((51971.1, 139605, 89529.4), (-90, 95.9607, 0), 0, "p_rus_chainlink_fence");
    spawnfloormodel((51941.5, 139871, 89530.5), (-90, 96.6363, 0), 0, "p_rus_chainlink_fence");
    spawnfloormodel((51958.7, 139890, 89529.5), (-90, 6.74573, 0), 0, "p_rus_chainlink_fence"); //z89531.5
    spawnfloormodel((51989.5, 139587, 89528.1), (-90, -174.078, 0), 0, "p_rus_chainlink_fence");
    spawnfloormodel((52256.9, 139615, 89529.8), (-90, -174.682, 0), 0, "p_rus_chainlink_fence");
    spawnfloormodel((52274.9, 139633, 89529.8), (-90, -84.7045, 0), 0, "p_rus_chainlink_fence");
    spawnfloormodel((52250.5, 139896, 89528.9), (-90, -84.243, 0), 0, "p_rus_chainlink_fence");
    spawnfloormodel((52232, 139914, 89529.6), (-90, 5.50977, 0), 0, "p_rus_chainlink_fence");
    wait 5;
    //third p
    spawnfloormodel((53198, 140461, 89113.3), (-90, 162.789, 0), 0, "p_rus_chainlink_fence");
    spawnfloormodel((53451.8, 140382, 89113), (-90, 162.602, 0), 0, "p_rus_chainlink_fence");
    spawnfloormodel((53475.6, 140392, 89113.3), (-90, -107.568, 0), 0, "p_rus_chainlink_fence");
    spawnfloormodel((53188.9, 140485, 89113.3), (-90, 72.7833, 0), 0, "p_rus_chainlink_fence");
    spawnfloormodel((53268.7, 140745, 89112.4), (-90, 72.8767, 0), 0, "p_rus_chainlink_fence");
    spawnfloormodel((53555.8, 140649, 89112.7), (-90, -107.491, 0), 0, "p_rus_chainlink_fence");
    spawnfloormodel((53547.5, 140674, 89113), (-90, -17.9912, 0), 0, "p_rus_chainlink_fence");
    spawnfloormodel((53293.5, 140755, 89112.4), (-90, -16.8651, 0), 0, "p_rus_chainlink_fence");

    //total count = 30 ent;
    wait 2;
    //fourth platform
    



}


spawnfloors2()
{
    level endon("end_game");
    level waittill("initial_blackscreen_passed");
    //wait till rockets have been deleted from the map to avoid g_spawn ent limit
    wait 55;

    spawnfloormodel((52265.9, 139759, 89532.9), (-90, 3.78591, 0), 0, "test_macbeth_chart_unlit");
    // 13:34 
    spawnfloormodel((52169.4, 139758, 89532.9), (-90, 4.2748, 0), 0, "test_macbeth_chart_unlit");
    // 13:36 
    spawnfloormodel((52083, 139742, 89532.9), (-90, 4.2748, 0), 0, "test_macbeth_chart_unlit");
    // 13:43 
    spawnfloormodel((52022.2, 139750, 89532.9), (-90, -176.858, 0), 0, "test_macbeth_chart_unlit");
    // 15:26 
    spawnfloormodel((52037.1, 139607, 89532.9), (-90, -178.729, 0), 0, "test_macbeth_chart_unlit");
    // 15:29 
    spawnfloormodel((52030.4, 139607, 89532.9), (-90, -177.668, 0), 0, "test_macbeth_chart_unlit");
    // 15:38 
    spawnfloormodel((52030.2, 139681, 89532.9), (-90, -177.107, 0), 0, "test_macbeth_chart_unlit");
    // 15:41 
    spawnfloormodel((52029, 139681, 89532.9), (-90, -177.107, 0), 0, "test_macbeth_chart_unlit");
    // 15:48 
    spawnfloormodel((52026.8, 139681, 89532.9), (-90, -176.574, 0), 0, "test_macbeth_chart_unlit");
    // 15:54 
    wait 2;
    spawnfloormodel((52035.2, 139590, 89532.9), (-90, -176.117, 0), 0, "test_macbeth_chart_unlit");
    // 15:59 
    spawnfloormodel((52027.7, 139557, 89532.9), (-90, -176.044, 0), 0, "test_macbeth_chart_unlit");
    // 16:02 
    spawnfloormodel((52026.3, 139650, 89532.9), (-90, -176.34, 0), 0, "test_macbeth_chart_unlit");
    // 16:04 
    spawnfloormodel((52024, 139650, 89532.9), (-90, -176.191, 0), 0, "test_macbeth_chart_unlit");
    // 16:10 
    spawnfloormodel((52007.9, 139850, 89532.9), (-90, -175.737, 0), 0, "test_macbeth_chart_unlit");
    // 16:14 
    spawnfloormodel((52009.5, 139742, 89532.9), (-90, -176.038, 0), 0, "test_macbeth_chart_unlit");
    // 16:37 
    spawnfloormodel((52019.6, 139932, 89532.9), (-90, -176.183, 0), 0, "test_macbeth_chart_unlit");
    // 16:43 
    spawnfloormodel((52014.1, 139932, 89532.9), (-90, -176.068, 0), 0, "test_macbeth_chart_unlit");
    // 16:44 
    spawnfloormodel((51999, 139932, 89532.9), (-90, -175.996, 0), 0, "test_macbeth_chart_unlit");
    // 16:50 
    spawnfloormodel((52000.4, 139864, 89532.9), (-90, -175.236, 0), 0, "test_macbeth_chart_unlit");
    // 17:00 
    spawnfloormodel((52156, 139943, 89532.9), (-90, -176.215, 0), 0, "test_macbeth_chart_unlit");
    // 17:08 
    spawnfloormodel((52131.6, 139941, 89532.9), (-90, -173.193, 0), 0, "test_macbeth_chart_unlit");
    // 17:17 
    spawnfloormodel((52220.6, 139947, 89532.9), (-90, 4.85248, 0), 0, "test_macbeth_chart_unlit");
    // 17:25 
    spawnfloormodel((52289.1, 139950, 89532.9), (-90, 6.54953, 0), 0, "test_macbeth_chart_unlit");
    // 17:48 
    spawnfloormodel((52281.3, 139900, 89532.9), (-90, -84.4559, 0), 0, "test_macbeth_chart_unlit");
    // 17:51 
    wait 2;
    spawnfloormodel((52292.3, 139900, 89532.9), (-90, -84.4559, 0), 0, "test_macbeth_chart_unlit");
    // 17:54 
    spawnfloormodel((52297.2, 139826, 89532.9), (-90, -83.8516, 0), 0, "test_macbeth_chart_unlit");
    // 17:57 
    spawnfloormodel((52303.3, 139757, 89532.9), (-90, -84.2691, 0), 0, "test_macbeth_chart_unlit");
    // 18:05 
    spawnfloormodel((52308.9, 139687, 89532.9), (-90, -84.7579, 0), 0, "test_macbeth_chart_unlit");
    // 18:09 
    spawnfloormodel((52326.8, 139624, 89532.9), (-90, -81.1764, 0), 0, "test_macbeth_chart_unlit");
    // 18:14 
    spawnfloormodel((52329.2, 139670, 89532.9), (-90, 97.1193, 0), 0, "test_macbeth_chart_unlit");
    // 18:16 
    spawnfloormodel((52324.7, 139715, 89532.9), (-90, 97.273, 0), 0, "test_macbeth_chart_unlit");
    // 18:20 
    spawnfloormodel((52318.9, 139770, 89532.9), (-90, 97.421, 0), 0, "test_macbeth_chart_unlit");
    // 18:22 
    spawnfloormodel((52309.5, 139848, 89532.9), (-90, 97.421, 0), 0, "test_macbeth_chart_unlit");
    // 18:23 
    spawnfloormodel((52301.7, 139916, 89532.9), (-90, 97.421, 0), 0, "test_macbeth_chart_unlit");
    // 18:27 
    spawnfloormodel((52299.8, 139939, 89532.9), (-90, 97.421, 0), 0, "test_macbeth_chart_unlit");
    // 18:29 
    spawnfloormodel((52298.6, 139951, 89532.9), (-90, 97.421, 0), 0, "test_macbeth_chart_unlit");
    // 19:05 
    spawnfloormodel((52338.9, 139607, 89532.9), (-90, 4.70253, 0), 0, "test_macbeth_chart_unlit");
    // 19:14 
    spawnfloormodel((52229.3, 139589, 89532.9), (-90, -174.615, 0), 0, "test_macbeth_chart_unlit");
    // 19:16 
    wait 2;
    spawnfloormodel((52328.3, 139599, 89532.9), (-90, -172.125, 0), 0, "test_macbeth_chart_unlit");
    // 19:21 
    spawnfloormodel((52145, 139580, 89532.9), (-90, -175.325, 0), 0, "test_macbeth_chart_unlit");
    // 19:24 
    spawnfloormodel((52137.1, 139560, 89532.9), (-90, -173.478, 0), 0, "test_macbeth_chart_unlit");
    // 19:30 
    spawnfloormodel((52230.2, 139580, 89532.9), (-90, -172.232, 0), 0, "test_macbeth_chart_unlit");
    // 19:34 
    spawnfloormodel((52247.2, 139674, 89532.9), (-90, -172.955, 0), 0, "test_macbeth_chart_unlit");
    // 19:35 
    spawnfloormodel((52175, 139669, 89532.9), (-90, -173.52, 0), 0, "test_macbeth_chart_unlit");
    // 19:37 
    spawnfloormodel((52110.4, 139663, 89532.9), (-90, -173.629, 0), 0, "test_macbeth_chart_unlit");
    // 19:40 
    spawnfloormodel((52081.2, 139843, 89532.9), (-90, 3.73406, 0), 0, "test_macbeth_chart_unlit");
    // 19:42 
    spawnfloormodel((52178.7, 139845, 89532.9), (-90, 5.77203, 0), 0, "test_macbeth_chart_unlit");

}

spawnfloors3()
{
    level endon("end_game");
    level waittill("initial_blackscreen_passed");

    //wait till rockets have been deleted from the map to avoid g_spawn ent limit
    wait 75;
    spawnfloormodel((53399.6, 140603, 89114.6), (-90, 66.2702, 0), 0, "test_macbeth_chart_unlit");
    // 12:19 
    spawnfloormodel((53427.7, 140670, 89114.6), (-90, 65.8197, 0), 0, "test_macbeth_chart_unlit");
    // 12:21 
    spawnfloormodel((53452.1, 140729, 89114.6), (-90, 65.8197, 0), 0, "test_macbeth_chart_unlit");
    // 12:25 
    spawnfloormodel((53355.2, 140497, 89114.6), (-90, 65.8197, 0), 0, "test_macbeth_chart_unlit");
    // 12:29 
    spawnfloormodel((53308.6, 140386, 89114.6), (-90, 65.8197, 0), 0, "test_macbeth_chart_unlit");
    // 12:36 
    spawnfloormodel((53244.3, 140410, 89114.6), (-90, 155.248, 0), 0, "test_macbeth_chart_unlit");
    // 12:41 
    spawnfloormodel((53186.3, 140438, 89114.6), (-90, 155.582, 0), 0, "test_macbeth_chart_unlit");
    // 13:06 
    spawnfloormodel((53169.6, 140553, 89114.6), (-90, -114.697, 0), 0, "test_macbeth_chart_unlit");
    // 13:11 
    spawnfloormodel((53141.5, 140490, 89114.6), (-90, -115, 0), 0, "test_macbeth_chart_unlit");
    // 13:14 
    spawnfloormodel((53131, 140465, 89114.6), (-90, -115.34, 0), 0, "test_macbeth_chart_unlit");
    // 13:44 
    spawnfloormodel((53176.8, 140567, 89114.6), (-90, 65.3007, 0), 0, "test_macbeth_chart_unlit");
    // 13:55 
    spawnfloormodel((53214.9, 140652, 89114.6), (-90, 65.1891, 0), 0, "test_macbeth_chart_unlit");
    // 13:58 
    spawnfloormodel((53263.4, 140754, 89114.6), (-90, 65.6004, 0), 0, "test_macbeth_chart_unlit");
    // 14:02 
    spawnfloormodel((53285.8, 140795, 89114.6), (-90, 66.0173, 0), 0, "test_macbeth_chart_unlit");
    // 14:05 
    spawnfloormodel((53282.5, 140797, 89114.6), (-90, 65.1493, 0), 0, "test_macbeth_chart_unlit");
    // 14:08 
    spawnfloormodel((53284.6, 140802, 89114.6), (-90, 65.3031, 0), 0, "test_macbeth_chart_unlit");
    // 14:12 
    spawnfloormodel((53373.7, 140763, 89114.6), (-90, 65.3031, 0), 0, "test_macbeth_chart_unlit");
    // 14:17 
    spawnfloormodel((53574.3, 140678, 89114.6), (-90, 65.3413, 0), 0, "test_macbeth_chart_unlit");
    // 14:21 
    spawnfloormodel((53515.4, 140702, 89114.6), (-90, 65.1103, 0), 0, "test_macbeth_chart_unlit");
    // 14:38 
    spawnfloormodel((53579.5, 140650, 89114.6), (-90, 64.9226, 0), 0, "test_macbeth_chart_unlit");
    // 14:40 
    spawnfloormodel((53586.7, 140667, 89114.6), (-90, 64.9226, 0), 0, "test_macbeth_chart_unlit");
    // 14:42 
    spawnfloormodel((53590, 140674, 89114.6), (-90, 64.9226, 0), 0, "test_macbeth_chart_unlit");
    // 14:46 
    spawnfloormodel((53528.9, 140700, 89114.6), (-90, 64.9226, 0), 0, "test_macbeth_chart_unlit");
    // 14:49 
    spawnfloormodel((53450.8, 140734, 89114.6), (-90, 64.9226, 0), 0, "test_macbeth_chart_unlit");
    // 14:50 
    spawnfloormodel((53387.9, 140760, 89114.6), (-90, 64.9226, 0), 0, "test_macbeth_chart_unlit");
    // 14:52 
    spawnfloormodel((53327.1, 140786, 89114.6), (-90, 64.9226, 0), 0, "test_macbeth_chart_unlit");
    // 14:55 
    spawnfloormodel((53291.5, 140801, 89114.6), (-90, 64.9226, 0), 0, "test_macbeth_chart_unlit");
    // 14:58 
    spawnfloormodel((53351.6, 140727, 89114.6), (-90, -114.731, 0), 0, "test_macbeth_chart_unlit");
    // 14:59 
    spawnfloormodel((53308.5, 140626, 89114.6), (-90, -114.621, 0), 0, "test_macbeth_chart_unlit");
    // 15:02 
    spawnfloormodel((53254.5, 140499, 89114.6), (-90, -114.544, 0), 0, "test_macbeth_chart_unlit");
    // 15:05 
    spawnfloormodel((53281.1, 140561, 89114.6), (-90, -114.506, 0), 0, "test_macbeth_chart_unlit");
    // 15:08 
    spawnfloormodel((53357.4, 140365, 89114.6), (-90, -22.7921, 0), 0, "test_macbeth_chart_unlit");
    // 15:11 
    spawnfloormodel((53412.1, 140344, 89114.6), (-90, -23.6215, 0), 0, "test_macbeth_chart_unlit");
    // 15:13 
    spawnfloormodel((53439.5, 140332, 89114.6), (-90, -24.2258, 0), 0, "test_macbeth_chart_unlit");
    // 15:15 
    spawnfloormodel((53454, 140325, 89114.6), (-90, -24.2258, 0), 0, "test_macbeth_chart_unlit");
    // 15:18 
    spawnfloormodel((53481.3, 140387, 89114.6), (-90, 65.8287, 0), 0, "test_macbeth_chart_unlit");
    // 15:21 
    spawnfloormodel((53506.3, 140447, 89114.6), (-90, 66.0152, 0), 0, "test_macbeth_chart_unlit");
    // 15:24 
    spawnfloormodel((53535.8, 140518, 89114.6), (-90, 66.0536, 0), 0, "test_macbeth_chart_unlit");
    // 15:26 
    spawnfloormodel((53564.1, 140585, 89114.6), (-90, 65.6744, 0), 0, "test_macbeth_chart_unlit");
    // 15:28 
    spawnfloormodel((53591.2, 140649, 89114.6), (-90, 65.7513, 0), 0, "test_macbeth_chart_unlit");
    // 15:30 
    spawnfloormodel((53594.7, 140658, 89114.6), (-90, 65.7513, 0), 0, "test_macbeth_chart_unlit");
    // 15:31 
    spawnfloormodel((53600.5, 140671, 89114.6), (-90, 65.7513, 0), 0, "test_macbeth_chart_unlit");
    // 15:34 
    spawnfloormodel((53486.3, 140606, 89114.6), (-90, -113.611, 0), 0, "test_macbeth_chart_unlit");
    // 15:38 
    spawnfloormodel((53445.4, 140510, 89114.6), (-90, -112.37, 0), 0, "test_macbeth_chart_unlit");
    // 15:41 
    spawnfloormodel((53410.1, 140417, 89114.6), (-90, -112.183, 0), 0, "test_macbeth_chart_unlit");
    // 16:24 
}

spawnfloors4()
{
    level endon("end_game");
    level waittill("initial_blackscreen_passed");
    wait 120;

    //plat
    //spawnfloormodel((55168.6, 142253, 91718.6), (0, -19.5776, 0), 0, "collision_clip_256x256x10");

    //textures
    //spawnfloormodel((55168.6, 142253, 91718.6), (-90, -19.5776, 0), 0, "test_macbeth_chart_unlit");
    /*
    spawnfloormodel((55288.3, 142210, 91723.7), (-90, -19.8048, 0), 0, "test_macbeth_chart_unlit");
    spawnfloormodel((55331.4, 142330, 91723.7), (-90, 69.8689, 0), 0, "test_macbeth_chart_unlit");
    spawnfloormodel((55244.6, 142090, 91723.7), (-90, -19.8075, 0), 0, "test_macbeth_chart_unlit");
    spawnfloormodel((55124.8, 142133, 91723.7), (-90, 160.175, 0), 0, "test_macbeth_chart_unlit");
    spawnfloormodel((55168.3, 142253, 91723.7), (-90, 160.2, 0), 0, "test_macbeth_chart_unlit");
    spawnfloormodel((55211.2, 142373, 91723.7), (-90, -109.753, 0), 0, "test_macbeth_chart_unlit");
    spawnfloormodel((55048.3, 142296, 91723.7), (-90, 160.256, 0), 0, "test_macbeth_chart_unlit");
    spawnfloormodel((55005.4, 142176, 91723.7), (-90, 160.073, 0), 0, "test_macbeth_chart_unlit");
    spawnfloormodel((55090.6, 142416, 91723.7), (-90, 70.0824, 0), 0, "test_macbeth_chart_unlit");
    */
    spawnfloormodel((55157.4, 142266, 91641.5), (0, -15.9003, 0), 0, "p6_rocks_desert_01_large");
    l = (55157.4, 142266, 91641.5);
    cl = spawn("script_model", l );
    cl setModel("tag_origin");
    cl.angles = ( -270, 0, 0 );
    clmarker = "lght_marker";
    playFXOnTag( level._effect[ clmarker ], cl, "tag_origin" );
}


spawnfloorsbeforeperks()
{
    level endon("end_game");
    level waittill("initial_blackscreen_passed");
    wait ( 80 );

    yellow = "fx_theater_mode_camera_head_glow_yllw";
    red = "fx_theater_mode_camera_head_glow_red";
    green = "fx_theater_mode_camera_head_glow_grn";

    yAngles = ( -180, 0, 0 );
    rAngles = ( -180, 0, 0 );
    gAngles = ( -180, 0, 0 );

    

    //collision
    spawnfloormodel((55899.2, 142604, 91779.7), (0, 25.0575, 0), 0, "collision_clip_128x128x10");
    spawnfloormodel((57011.3, 142366, 91157.1), (0, -7.53345, 0), 0, "collision_clip_128x128x10");
    spawnfloormodel((57458.1, 143143, 90653.3), (0, 66.1995, 0), 0, "collision_clip_128x128x10");
    spawnfloormodel((57953.9, 143585, 90518.8), (0, 38.1668, 0), 0, "collision_clip_128x128x10");
    spawnfloormodel((59343.3, 142973, 89334.3), (0, -28.9378, 0), 0, "collision_clip_128x128x10");
    wait 1;

    //textures
    spawnfloormodel((55899.2, 142604, 91779.7), (-90, 25.0575, 0), 0, "test_macbeth_chart_unlit");
    spawnfloormodel((57011.3, 142366, 91157.1), (-90, -7.53345, 0), 0, "test_macbeth_chart_unlit");
    spawnfloormodel((57458.1, 143143, 90653.3), (-90, 66.1995, 0), 0, "test_macbeth_chart_unlit");
    spawnfloormodel((57953.9, 143585, 90518.8), (-90, 38.1668, 0), 0, "test_macbeth_chart_unlit");
    spawnfloormodel((59343.3, 142973, 89334.3), (-90, -28.9378, 0), 0, "test_macbeth_chart_unlit");

    //bottom side  txtrs & lght fx
    
    
    spawnfloormodel((55899.2, 142604, 91779.7), (-270, 25.0575, 0), 0, "test_macbeth_chart_unlit");
    loc = (55899.2, 142604, 91779.7);
    light1 = playfx(level._effect[green], loc );
    light1.angles = (-180, 0, 0 );
    //  3:31 
    spawnfloormodel((57011.3, 142366, 91157.1), (-270, -7.53345, 0), 0, "test_macbeth_chart_unlit");
    loc2 = (57011.3, 142366, 91157.1);
    light2 = playfx(level._effect[red], loc2 );
    light2.angles = (-180, 0, 0 );
    //  3:42 
    spawnfloormodel((57458.1, 143143, 90653.3), (-270, 66.1995, 0), 0, "test_macbeth_chart_unlit");
    loc3 = (57458.1, 143143, 90653.3);
    light3 = playfx(level._effect[yellow], loc3 );
    light3.angles = ( -180, 0, 0 );
    //  3:50 
    spawnfloormodel((57953.9, 143585, 90518.8), (-270, 38.1668, 0), 0, "test_macbeth_chart_unlit");
    loc4 = (57953.9, 143585, 90518.8);
    light4 = playfx(level._effect[green], loc4 );
    light4.angles = (-180, 0, 0 );
    //  3:59 
    spawnfloormodel((59343.3, 142973, 89334.3), (-270, -28.9378, 0), 0, "test_macbeth_chart_unlit");
    loc5 = (59343.3, 142973, 89334.3);
    light5 = playfx(level._effect[red], loc5 );
    light5.angles = (-180, 0, 0 );


}

spawnperkplatform()
{
    level endon("end_game");
    level waittill("initial_blackscreen_passed");
    wait 90;

    //see where the model is located at
    lg = "lght_marker";
    og = (59919.5, 142064, 88732.4);
    spawnfloormodel((59919.5, 142064, 88732.4), (0, -58.8175, 0), 0, "collision_clip_512x512x10");
    //spawnfloormodel((59919.5, 142064, 88732.4), (-90, -58.8175, 0), 0, "test_macbeth_chart_unlit");


    spawnfloormodel((59920, 142064, 88737.5), (-90, -58.7797, 0), 0, "test_macbeth_chart_unlit");
    spawnfloormodel((59985.6, 141955, 88737.5), (-90, -58.9009, 0), 0, "test_macbeth_chart_unlit");
    spawnfloormodel((60051.6, 141846, 88737.5), (-90, -59.0201, 0), 0, "test_macbeth_chart_unlit");
    spawnfloormodel((59854, 142173, 88737.5), (-90, 121.203, 0), 0, "test_macbeth_chart_unlit");
    spawnfloormodel((59787.8, 142282, 88737.5), (-90, 121.076, 0), 0, "test_macbeth_chart_unlit");
    spawnfloormodel((59943.3, 141780, 88737.5), (-90, 121.322, 0), 0, "test_macbeth_chart_unlit");
    spawnfloormodel((59834, 141714, 88737.5), (-90, 121.132, 0), 0, "test_macbeth_chart_unlit");

    wait 1;
    spawnfloormodel((59877.5, 141889, 88737.5), (-90, 121.377, 0), 0, "test_macbeth_chart_unlit");
    spawnfloormodel((59768, 141823, 88737.5), (-90, -58.8361, 0), 0, "test_macbeth_chart_unlit");
    spawnfloormodel((59811.4, 141998, 88737.5), (-90, -58.9069, 0), 0, "test_macbeth_chart_unlit");
    spawnfloormodel((59702.1, 141932, 88737.5), (-90, -58.9069, 0), 0, "test_macbeth_chart_unlit");
    spawnfloormodel((59745.4, 142107, 88737.5), (-90, 30.9589, 0), 0, "test_macbeth_chart_unlit");

    wait 3;
    spawnfloormodel((59636.2, 142041, 88737.5), (-90, -58.6621, 0), 0, "test_macbeth_chart_unlit");
    spawnfloormodel((59679.1, 142216, 88737.5), (-90, 121.246, 0), 0, "test_macbeth_chart_unlit");
    spawnfloormodel((59570.4, 142150, 88737.5), (-90, 121.062, 0), 0, "test_macbeth_chart_unlit");
    spawnfloormodel((60160.8, 141912, 88737.5), (-90, -58.6553, 0), 0, "test_macbeth_chart_unlit");
    spawnfloormodel((60269.8, 141978, 88737.5), (-90, -58.7761, 0), 0, "test_macbeth_chart_unlit");

    spawnfloormodel((60094.9, 142021, 88737.5), (-90, 31.3275, 0), 0, "test_macbeth_chart_unlit");
    wait 2;
    spawnfloormodel((60203.6, 142087, 88737.5), (-90, -58.7825, 0), 0, "test_macbeth_chart_unlit");
    spawnfloormodel((60137.8, 142196, 88737.5), (-90, 31.3913, 0), 0, "test_macbeth_chart_unlit");
    spawnfloormodel((60028.6, 142130, 88737.5), (-90, 30.9628, 0), 0, "test_macbeth_chart_unlit");
    spawnfloormodel((59962.6, 142239, 88737.5), (-90, 31.517, 0), 0, "test_macbeth_chart_unlit");
    spawnfloormodel((60072.4, 142305, 88737.5), (-90, 31.4563, 0), 0, "test_macbeth_chart_unlit");
    spawnfloormodel((60004.7, 142414, 88737.5), (-90, 31.6888, 0), 0, "test_macbeth_chart_unlit");
    spawnfloormodel((59896.7, 142348, 88737.5), (-90, 31.3862, 0), 0, "test_macbeth_chart_unlit");
    //playfx(level._effect[lg], (og) );
}


intro_screen()
{
    level endon("end_game");
	level waittill("initial_blackscreen_passed");
	wait(1);
	level.intro_hud = [];
	for(i = 0;  i < 4; i++)
	{
		level.intro_hud[i] = NewHudElem();
		level.intro_hud[i].x = 0;
		level.intro_hud[i].y = 0;
		level.intro_hud[i].alignX = "left";
		level.intro_hud[i].alignY = "bottom";
		level.intro_hud[i].horzAlign = "left";
		level.intro_hud[i].vertAlign = "bottom";
		level.intro_hud[i].foreground = true;
        //level.intro_hud[i].font = cooltext;
		
		level.intro_hud[i].alpha = 0.0;
		level.intro_hud[i].color = (1, 1, 1);
		level.intro_hud[i].inuse = false;
	}

	level.intro_hud[0].y = -110;
	level.intro_hud[1].y = -90;
	level.intro_hud[2].y = -70;
    level.intro_hud[3].y = -50;

    
	level.intro_hud[0] settext("City Of Mars");
	level.intro_hud[1] settext("3:20 ^3Afternoon");
	level.intro_hud[2] settext("18/11/2092");
    level.intro_hud[3] settext("Mod by ^3Ultimateman");

	for(i = 0 ; i < 4; i++)
	{
		level.intro_hud[i] FadeOverTime( 3.5 ); 
		level.intro_hud[i].alpha = 1;
		wait(1.5);
	}
	wait(1.5);
	for(i = 0 ; i < 4; i++)
	{
		level.intro_hud[i] FadeOverTime( 3.5 ); 
		level.intro_hud[i].alpha = 0;
		wait(1.5);
	}	
	wait(2);
	for(i = 0 ; i < 4; i++)
	{
		level.intro_hud[i] destroy();
	}
}

//DEBUG HEALTH
printHealthDebug()
{
	//level notify( "stop_printing_health_bars" );
	//level endon( "stop_printing_health_bars" );
	level endon ("end_game");

    flag_wait( "initial_blackscreen_passed" );
	const_x = 40;
	y = 40;
	
	level.healthBarHudElems = [];
	
	level.healthBarKeys[ 0 ] = "Health";

	for ( i = 0; i < level.healthBarKeys.size; i++ )
	{
		key = level.healthBarKeys[ i ];
		
		textelem = newHudElem();
		textelem.x = x;
		textelem.y = y;
		textelem.alignX = "left";
		textelem.alignY = "top";
		textelem.horzAlign = "fullscreen";
		textelem.vertAlign = "fullscreen";
		textelem setText( key );
		
		bgbar = newHudElem();
		bgbar.x = x + 79;
		bgbar.y = y + 1;
		bgbar.z = 1;
		bgbar.alignX = "left";
		bgbar.alignY = "top";
		bgbar.horzAlign = "fullscreen";
		bgbar.vertAlign = "fullscreen";
		bgbar.maxwidth = 3;
		bgbar setshader( "white", bgbar.maxwidth, 10 );
		bgbar.color = ( 0.5, 0.5, 0.5 );

		bar = newHudElem();
		bar.x = x + 80;
		bar.y = y + 2;
		bar.alignX = "left";
		bar.alignY = "top";
		bar.horzAlign = "fullscreen";
		bar.vertAlign = "fullscreen";
		bar setshader( "black", 1, 8 );
		
		textelem.bar = bar;
		textelem.bgbar = bgbar;
		textelem.key = key;
		
		y += 10;
		
		level.healthBarHudElems[ key ] = textelem;
	}

	//flag_wait( "initial_blackscreen_passed" );
	
	while ( 1 )
	{
		wait .05;
		
		players = get_players()[0];
		
		for ( i = 0; i < level.healthBarKeys.size && players.size > 0; i++ )
		{
			key = level.healthBarKeys[ i ];
			
			player = players;
			
			width = 0;

			if ( i == 0 )
			{
				width = player.health / player.maxhealth * 300;
			}
			
            
			width = ( max( width, 1 ) );
			width = ( min( width, 300 ) );

			bar = level.healthBarHudElems[ key ].bar;
			bar setShader( "black", width, 8 );

			bgbar = level.healthBarHudElems[ key ].bgbar;
			if( width + 2 > bgbar.maxwidth )
			{
				bgbar.maxwidth = width + 2;
				bgbar setshader( "white", bgbar.maxwidth, 10 );
				bgbar.color = ( 0.5, 0.5, 0.5 );
			}
		}
	}
}


startKillBox() //need  to fix disspawn fxs once player has completed the challenge, continue tmrw.
{
    level._effect[ "monkeylight" ] = loadfx( "maps/zombie/fx_zombie_monkey_light" );
    level.kill_box_active = 1;
    level.kill_box_kills_needed = 45;
    level.kill_box_kills = 0;
    level.kill_box = self; //mannequin, called on mannequin
}


zombie_souls( level.kill_box.origin ) //box
{
    level._effect[ "powerup_on" ] = loadfx( "misc/fx_zombie_powerup_on" );
    wave = "fx_zombie_powerup_wave";
    zombiehead = self gettagorigin( "j_head" );
    targetlocation = level.kill_box.origin; //pos + ( 0, 0, 20 );

    inv = spawn( "script_model", zombiehead );
    inv setmodel( "tag_origin" );
    wait .1;
    playFXOnTag( level._effect[ "powerup_on" ], inv, "tag_origin" );
    inv moveto ( targetlocation, 1.6 );
    inv waittill( "movedone" );

    playFXOnTag( level._effect[ wave ], level.kill_box.origin, "tag_origin" );
    playsoundatposition( "zmb_box_poof", level.kill_box.origin );
    wait .2;
    inv delete();
}
//zmb_box_poof_land






