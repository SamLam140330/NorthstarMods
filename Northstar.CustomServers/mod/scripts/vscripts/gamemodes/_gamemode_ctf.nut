untyped

global function CaptureTheFlag_Init
global function RateSpawnpoints_CTF

const array<string> SWAP_FLAG_MAPS = [
	"mp_forwardbase_kodai",
	"mp_lf_meadow"
]

struct {
	entity imcFlagSpawn
	entity imcFlag
	
	entity militiaFlagSpawn
	entity militiaFlag
	
	array<entity> imcCaptureAssistList
	array<entity> militiaCaptureAssistList
} file

void function CaptureTheFlag_Init()
{
	PrecacheModel( CTF_FLAG_MODEL )
	PrecacheModel( CTF_FLAG_BASE_MODEL )
	PrecacheParticleSystem( FLAG_FX_FRIENDLY )
	PrecacheParticleSystem( FLAG_FX_ENEMY )
	
	CaptureTheFlagShared_Init()
	SetSwitchSidesBased( true )
	SetSuddenDeathBased( true )
	SetShouldUseRoundWinningKillReplay( true )
	SetRoundWinningKillReplayKillClasses( false, false ) // make these fully manual
	
	AddCallback_OnClientConnected( CTFInitPlayer )
	AddCallback_OnClientDisconnected( CTFPlayerDisconnected )

	AddCallback_GameStateEnter( eGameState.Prematch, CreateFlags )
	AddCallback_GameStateEnter( eGameState.Epilogue, RemoveFlags )
	AddCallback_GameStateEnter( eGameState.Playing, OnPlaying )
	AddCallback_OnTouchHealthKit( "item_flag", OnFlagCollected )
	AddCallback_OnPlayerKilled( OnPlayerKilled )
	AddCallback_OnPilotBecomesTitan( DropFlagForBecomingTitan )
	
	AddSpawnCallback( "npc_titan", PlayerTitanSpawning )
	
	AddSpawnpointValidationRule( VerifyCTFSpawnpoint )
	
	RegisterSignal( "FlagReturnEnded" )
	RegisterSignal( "ResetDropTimeout" )
	
	// setup stuff for the functions in sh_gamemode_ctf
	// don't really like using level for stuff but just how it be
	level.teamFlags <- {}
	
	// setup score event earnmeter values
	ScoreEvent_SetEarnMeterValues( "KillPilot", 0.05, 0.20 )
	ScoreEvent_SetEarnMeterValues( "Headshot", 0.0, 0.02 )
	ScoreEvent_SetEarnMeterValues( "FirstStrike", 0.0, 0.05 )
	ScoreEvent_SetEarnMeterValues( "KillTitan", 0.0, 0.25 )
	ScoreEvent_SetEarnMeterValues( "PilotBatteryStolen", 0.0, 0.35 )
	
	ScoreEvent_SetEarnMeterValues( "FlagCarrierKill", 0.0, 0.20 )
	ScoreEvent_SetEarnMeterValues( "FlagTaken", 0.0, 0.10 )
	ScoreEvent_SetEarnMeterValues( "FlagCapture", 0.0, 0.30 )
	ScoreEvent_SetEarnMeterValues( "FlagCaptureAssist", 0.0, 0.20 )
	ScoreEvent_SetEarnMeterValues( "FlagReturn", 0.0, 0.20 )
}

void function RateSpawnpoints_CTF( int checkClass, array<entity> spawnpoints, int team, entity player ) 
{
	vector allyFlagSpot
	vector enemyFlagSpot
	foreach ( entity spawn in GetEntArrayByClass_Expensive( "info_spawnpoint_flag" ) )
	{
		if( spawn.GetTeam() == team )
			allyFlagSpot = spawn.GetOrigin()
		else
			enemyFlagSpot = spawn.GetOrigin()
	}
	
	foreach ( entity spawn in spawnpoints )
	{
		float rating = 0.0
		float allyFlagDistance = Distance2D( spawn.GetOrigin(), allyFlagSpot )
		float enemyFlagDistance = Distance2D( spawn.GetOrigin(), enemyFlagSpot )
		
		if( enemyFlagDistance > allyFlagDistance )
		{
			rating += spawn.NearbyAllyScore( team, "ai" )
			rating += spawn.NearbyAllyScore( team, "titan" )
			rating += spawn.NearbyAllyScore( team, "pilot" )
			
			rating += spawn.NearbyEnemyScore( team, "ai" )
			rating += spawn.NearbyEnemyScore( team, "titan" )
			rating += spawn.NearbyEnemyScore( team, "pilot" )
		
			rating = rating / allyFlagDistance
		}

		if ( spawn == player.p.lastSpawnPoint )
			rating += GetConVarFloat( "spawnpoint_last_spawn_rating" )
		
		spawn.CalculateRating( checkClass, team, rating, rating * 0.25 )
	}
	//RateSpawnpoints_SpawnZones( checkClass, spawnpoints, team, player )
}

bool function VerifyCTFSpawnpoint( entity spawnpoint, int team )
{
	// ensure spawnpoints aren't too close to enemy base
	vector allyFlagSpot
	vector enemyFlagSpot
	foreach ( entity spawn in GetEntArrayByClass_Expensive( "info_spawnpoint_flag" ) )
	{
		if( spawn.GetTeam() == team )
			allyFlagSpot = spawn.GetOrigin()
		else
			enemyFlagSpot = spawn.GetOrigin()
	}
	
	if( Distance2D( spawnpoint.GetOrigin(), allyFlagSpot ) > Distance2D( spawnpoint.GetOrigin(), enemyFlagSpot ) )
		return false
	
	return true
}

void function PlayerTitanSpawning( entity ent )
{
	if ( GetCurrentPlaylistVarInt( "ctf_friendly_hightlights", 0 ) != 0 )
		thread OnFriendlyNPCTitanSpawnThreaded( ent )
}

void function OnFriendlyNPCTitanSpawnThreaded( entity npc )
{
	npc.EndSignal( "OnDestroy" )
	
	WaitFrame()
	
	WaitTillHotDropComplete( npc )
	
	Highlight_SetFriendlyHighlight( npc, "sp_friendly_hero" )
	npc.Highlight_SetParam( 1, 0, HIGHLIGHT_COLOR_FRIENDLY )
}

void function CTFInitPlayer( entity player )
{
	if ( GetGameState() >= eGameState.Playing && GetCurrentPlaylistVarInt( "ctf_friendly_hightlights", 0 ) != 0 )
		Highlight_SetFriendlyHighlight( player, "sp_friendly_hero" )
	
	if( !GamePlaying() )
		return
	
	if ( IsValid( file.imcFlagSpawn ) )
	{
		vector imcSpawn = file.imcFlagSpawn.GetOrigin()
		Remote_CallFunction_NonReplay( player, "ServerCallback_SetFlagHomeOrigin", TEAM_IMC, imcSpawn.x, imcSpawn.y, imcSpawn.z )
	}
	
	if ( IsValid( file.militiaFlagSpawn ) )
	{
		vector militiaSpawn = file.militiaFlagSpawn.GetOrigin()
		Remote_CallFunction_NonReplay( player, "ServerCallback_SetFlagHomeOrigin", TEAM_MILITIA, militiaSpawn.x, militiaSpawn.y, militiaSpawn.z )
	}
}

void function CTFPlayerDisconnected( entity player )
{
	//This has no validity checks on the player because the disconnection callback happens in the exact last frame the player entity still exists
	if ( PlayerHasEnemyFlag( player ) )
	{
		entity flag = GetFlagForTeam( GetOtherTeam( player.GetTeam() ) )
	
		if( !IsValid( flag ) )
			return
	
		if ( flag.GetParent() != player )
			return
		
		flag.ClearParent()
		flag.SetAngles( < 0, 0, 0 > )
		flag.SetVelocity( < 0, 0, 0 > )
		thread TrackFlagDropTimeout( flag )
		SetFlagStateForTeam( flag.GetTeam(), eFlagState.Home )
	}
		
}

void function OnPlayerKilled( entity victim, entity attacker, var damageInfo )
{
	if ( !IsValid( GetFlagForTeam( GetOtherTeam( victim.GetTeam() ) ) ) ) // getting a crash idk
		return
	
	if ( PlayerHasEnemyFlag( victim ) )
	{
		if ( victim != attacker && attacker.IsPlayer() )
			AddPlayerScore( attacker, "FlagCarrierKill", victim )
		
		DropFlag( victim )
	}
}

void function CreateFlags()
{	
	if ( IsValid( file.imcFlagSpawn ) )
	{
		file.imcFlagSpawn.Destroy()
		file.imcFlag.Destroy()
	}
	if ( IsValid( file.militiaFlagSpawn ) )
	{
		file.militiaFlagSpawn.Destroy()
		file.militiaFlag.Destroy()
	}

	foreach ( entity spawn in GetEntArrayByClass_Expensive( "info_spawnpoint_flag" ) )
	{
		// on some maps flags are on the opposite side from what they should be
		// likely this is because respawn uses distance checks from spawns to check this in official
		// but i don't like doing that so just using a list of maps to swap them on lol
		bool switchedSides = HasSwitchedSides() == 1

		// i dont know why this works and whatever we had before didn't, but yeah
		bool shouldSwap = switchedSides 
		if (!shouldSwap && SWAP_FLAG_MAPS.contains( GetMapName() ))
			shouldSwap = !shouldSwap

		int flagTeam = spawn.GetTeam()
		if ( shouldSwap )
		{
			flagTeam = GetOtherTeam( flagTeam )
			SetTeam( spawn, flagTeam )
		}

		// create flag base
		entity base = CreatePropDynamic( CTF_FLAG_BASE_MODEL, spawn.GetOrigin(), spawn.GetAngles(), 0 )
		SetTeam( base, spawn.GetTeam() )
		svGlobal.flagSpawnPoints[ flagTeam ] = base

		// create flag
		entity flag = CreateEntity( "item_flag" )
		flag.SetValueForModelKey( CTF_FLAG_MODEL )
		SetTeam( flag, flagTeam )
		flag.MarkAsNonMovingAttachment()
		flag.Minimap_AlwaysShow( TEAM_IMC, null ) // show flag icon on minimap
		flag.Minimap_AlwaysShow( TEAM_MILITIA, null )
		flag.Minimap_SetAlignUpright( true )
		DispatchSpawn( flag )
		flag.SetModel( CTF_FLAG_MODEL )
		flag.SetOrigin( spawn.GetOrigin() + < 0, 0, base.GetBoundingMaxs().z * 2 > ) // ensure flag doesn't spawn clipped into geometry
		flag.SetVelocity( < 0, 0, 1 > )

		flag.s.canTake <- true
		flag.s.playersReturning <- []

		level.teamFlags[ flag.GetTeam() ] <- flag
		
		thread FlagProximityTracker( flag )
			
		if ( flagTeam == TEAM_IMC )
		{
			file.imcFlagSpawn = base
			file.imcFlag = flag
			
			SetGlobalNetEnt( "imcFlag", file.imcFlag )
			SetGlobalNetEnt( "imcFlagHome", file.imcFlagSpawn )
		}
		else
		{
			file.militiaFlagSpawn = base
			file.militiaFlag = flag
			
			SetGlobalNetEnt( "milFlag", file.militiaFlag )
			SetGlobalNetEnt( "milFlagHome", file.militiaFlagSpawn )
		}
	}
	
	// reset the flag states, prevents issues where flag is home but doesnt think it's home when halftime goes
	SetFlagStateForTeam( TEAM_MILITIA, eFlagState.None )
	SetFlagStateForTeam( TEAM_IMC, eFlagState.None )
}

void function RemoveFlags()
{
	// destroy all the flag related things
	if ( IsValid( file.imcFlagSpawn ) )
	{
		PlayFX( $"P_phase_shift_main", file.imcFlagSpawn.GetOrigin() )
		file.imcFlagSpawn.Destroy()
		file.imcFlag.Destroy()
	}
	if ( IsValid( file.militiaFlagSpawn ) )
	{
		PlayFX( $"P_phase_shift_main", file.militiaFlagSpawn.GetOrigin() )
		file.militiaFlagSpawn.Destroy()
		file.militiaFlag.Destroy()
	}

	// unsure if this is needed, since the flags are destroyed? idk
	SetFlagStateForTeam( TEAM_MILITIA, eFlagState.None )
	SetFlagStateForTeam( TEAM_IMC, eFlagState.None )
}

void function FlagProximityTracker( entity flag )
{
	flag.EndSignal( "OnDestroy" )
	
	array < entity > playerInsidePerimeter
	while( true )
	{
		if( !playerInsidePerimeter.len() )
			ArrayRemoveDead( playerInsidePerimeter )
		
		foreach ( player in GetPlayerArrayOfTeam_Alive( flag.GetTeam() ) )
		{
			if ( Distance( player.GetOrigin(), flag.GetOrigin() ) < CTF_GetFlagReturnRadius() )
			{
				if ( player.IsTitan() || player.GetTeam() != flag.GetTeam() || IsFlagHome( flag ) || flag.GetParent() != null )
					continue
				
				if( playerInsidePerimeter.contains( player ) )
					continue
				
				playerInsidePerimeter.append( player )
				thread TryReturnFlag( player, flag )
			}
			else
			{
				if( playerInsidePerimeter.contains( player ) )
				{
					player.Signal( "FlagReturnEnded" ) // Cut the progress if outside range
					playerInsidePerimeter.removebyvalue( player )
				}
			}
		}
		
		WaitFrame()
	}
}

void function SetFlagStateForTeam( int team, int state )
{
	if ( state == eFlagState.Away ) // we tell the client the flag is the player carrying it if they're carrying it
		SetGlobalNetEnt( team == TEAM_IMC ? "imcFlag" : "milFlag", ( team == TEAM_IMC ? file.imcFlag : file.militiaFlag ).GetParent() )
	else
		SetGlobalNetEnt( team == TEAM_IMC ? "imcFlag" : "milFlag", team == TEAM_IMC ? file.imcFlag : file.militiaFlag )

	SetGlobalNetInt( team == TEAM_IMC ? "imcFlagState" : "milFlagState", state )
}

bool function OnFlagCollected( entity player, entity flag )
{
	if ( !IsAlive( player ) || flag.GetParent() != null || player.IsTitan() || player.IsPhaseShifted() ) 
		return false

	if ( player.GetTeam() != flag.GetTeam() && flag.s.canTake )
		GiveFlag( player, flag ) // pickup enemy flag
	else if ( player.GetTeam() == flag.GetTeam() && IsFlagHome( flag ) && PlayerHasEnemyFlag( player ) )
		CaptureFlag( player, GetFlagForTeam( GetOtherTeam( flag.GetTeam() ) ) ) // cap the flag

	return false // don't wanna delete the flag entity
}

void function GiveFlag( entity player, entity flag )
{
	print( player + " picked up the flag!" )
	flag.Signal( "ResetDropTimeout" )

	flag.SetParent( player, "FLAG" )
	if( GetCurrentPlaylistVarInt( "phase_shift_drop_flag", 0 ) == 1 )
		thread DropFlagIfPhased( player, flag )

	// do notifications
	MessageToPlayer( player, eEventNotifications.YouHaveTheEnemyFlag )
	EmitSoundOnEntityOnlyToPlayer( player, player, "UI_CTF_1P_GrabFlag" )
	AddPlayerScore( player, "FlagTaken", player )
	PlayFactionDialogueToPlayer( "ctf_flagPickupYou", player )
	
	MessageToTeam( player.GetTeam(), eEventNotifications.PlayerHasEnemyFlag, player, player )
	EmitSoundOnEntityToTeamExceptPlayer( flag, "UI_CTF_3P_TeamGrabFlag", player.GetTeam(), player )
	PlayFactionDialogueToTeamExceptPlayer( "ctf_flagPickupFriendly", player.GetTeam(), player )
	
	MessageToTeam( flag.GetTeam(), eEventNotifications.PlayerHasFriendlyFlag, player, player )
	EmitSoundOnEntityToTeam( flag, "UI_CTF_3P_EnemyGrabFlag", flag.GetTeam() )
	
	SetFlagStateForTeam( flag.GetTeam(), eFlagState.Away ) // used for held
}

void function DropFlagIfPhased( entity player, entity flag )
{
	player.EndSignal( "StartPhaseShift" )
	player.EndSignal( "OnDestroy" )
	flag.EndSignal( "OnDestroy" )
	
	OnThreadEnd( function() : ( player ) 
	{
		if ( IsValidPlayer( player ) )
		{
			if ( GetGameState() == eGameState.Playing || GetGameState() == eGameState.SuddenDeath )
				DropFlag( player, true )
		}
	})

	while( flag.GetParent() == player )
		WaitFrame()
}

void function DropFlagForBecomingTitan( entity pilot, entity titan )
{
	DropFlag( pilot, true )
}

void function DropFlag( entity player, bool realDrop = true )
{
	entity flag = GetFlagForTeam( GetOtherTeam( player.GetTeam() ) )
	
	if( !IsValid( flag ) )
		return
	
	if ( flag.GetParent() != player )
		return
		
	print( player + " dropped the flag!" )
	
	flag.ClearParent()
	flag.SetAngles( < 0, 0, 0 > )
	flag.SetVelocity( < 0, 0, 0 > )
	
	if ( realDrop )
	{
		// start drop timeout countdown
		thread TrackFlagDropTimeout( flag )
	
		// add to capture assists
		if ( player.GetTeam() == TEAM_IMC && !file.imcCaptureAssistList.contains( player ) )
			file.imcCaptureAssistList.append( player )
		else if( !file.militiaCaptureAssistList.contains( player ) )
			file.militiaCaptureAssistList.append( player )

		// do notifications
		MessageToPlayer( player, eEventNotifications.YouDroppedTheEnemyFlag )
		EmitSoundOnEntityOnlyToPlayer( player, player, "UI_CTF_1P_FlagDrop" )

		MessageToTeam( player.GetTeam(), eEventNotifications.PlayerDroppedEnemyFlag, player, player )
		// todo need a sound here maybe
		MessageToTeam( GetOtherTeam( player.GetTeam() ), eEventNotifications.PlayerDroppedFriendlyFlag, player, player )
		// todo need a sound here maybe
	}
	
	SetFlagStateForTeam( flag.GetTeam(), eFlagState.Home ) // used for return prompt
}

void function TrackFlagDropTimeout( entity flag )
{
	flag.EndSignal( "ResetDropTimeout" )
	
	wait CTF_GetDropTimeout()
	
	ResetFlag( flag )
}

void function ResetFlag( entity flag )
{
	// prevents crash when flag is reset after it's been destroyed due to epilogue
	if ( !IsValid( flag ) )
		return
	
	// ensure we can't pickup the flag after it's been dropped but before it's been reset
	flag.s.canTake = false
	
	if ( flag.GetParent() != null )
		DropFlag( flag.GetParent(), false )
	
	entity spawn
	if ( flag.GetTeam() == TEAM_IMC )
		spawn = file.imcFlagSpawn
	else
		spawn = file.militiaFlagSpawn
		
	flag.SetOrigin( spawn.GetOrigin() + < 0, 0, spawn.GetBoundingMaxs().z + 1 > )
	
	// we can take it again now
	flag.s.canTake = true
	
	SetFlagStateForTeam( flag.GetTeam(), eFlagState.None ) // used for home
	
	flag.Signal( "ResetDropTimeout" )
}

void function CaptureFlag( entity player, entity flag )
{
	// can only capture flags during normal play or sudden death
	if ( GetGameState() != eGameState.Playing && GetGameState() != eGameState.SuddenDeath )
	{
		printt( player + " tried to capture the flag, but the game state was " + GetGameState() + " not " + eGameState.Playing + " or " + eGameState.SuddenDeath)
		return
	}
	// reset flag
	ResetFlag( flag )
	
	print( player + " captured the flag!" )
	
	// score
	int team = player.GetTeam() 
	AddTeamScore( team, 1 )
	AddPlayerScore( player, "FlagCapture", player )
	player.AddToPlayerGameStat( PGS_ASSAULT_SCORE, 1 ) // add 1 to captures on scoreboard
	SetRoundWinningKillReplayAttacker( player ) // set attacker for last cap replay
	
	array<entity> assistList
	if ( player.GetTeam() == TEAM_IMC )
		assistList = file.imcCaptureAssistList
	else
		assistList = file.militiaCaptureAssistList
	
	foreach( entity assistPlayer in assistList )
	{
		if ( IsValidPlayer( assistPlayer ) )
		{
			if ( player != assistPlayer )
				AddPlayerScore( assistPlayer, "FlagCaptureAssist", player )
			if( !HasPlayerCompletedMeritScore( assistPlayer ) )
			{
				AddPlayerScore( assistPlayer, "ChallengeCTFCapAssist" )
				SetPlayerChallengeMeritScore( assistPlayer )
			}
		}
	}
		
	assistList.clear()

	// notifs
	MessageToPlayer( player, eEventNotifications.YouCapturedTheEnemyFlag )
	EmitSoundOnEntityOnlyToPlayer( player, player, "UI_CTF_1P_PlayerScore" )
	
	if( !HasPlayerCompletedMeritScore( player ) )
		SetPlayerChallengeMeritScore( player )
	
	MessageToTeam( team, eEventNotifications.PlayerCapturedEnemyFlag, player, player )
	EmitSoundOnEntityToTeamExceptPlayer( flag, "UI_CTF_3P_TeamScore", player.GetTeam(), player )
	
	MessageToTeam( GetOtherTeam( team ), eEventNotifications.PlayerCapturedFriendlyFlag, player, player )
	EmitSoundOnEntityToTeam( flag, "UI_CTF_3P_EnemyScores", flag.GetTeam() )
	
	if ( GameRules_GetTeamScore( team ) == GetRoundScoreLimit_FromPlaylist() - 1 )
	{
		PlayFactionDialogueToTeam( "ctf_notifyWin1more", team )
		PlayFactionDialogueToTeam( "ctf_notifyLose1more", GetOtherTeam( team ) )
		foreach( entity otherplayer in GetPlayerArray() )
			Remote_CallFunction_NonReplay( otherplayer, "ServerCallback_CTF_PlayMatchNearEndMusic" )
	}
}

void function TryReturnFlag( entity player, entity flag )
{
	// start return progress bar
	Remote_CallFunction_NonReplay( player, "ServerCallback_CTF_StartReturnFlagProgressBar", Time() + CTF_GetFlagReturnTime() )
	EmitSoundOnEntityOnlyToPlayer( player, player, "UI_CTF_1P_FlagReturnMeter" )
	
	OnThreadEnd( function() : ( flag, player )
	{
		// cleanup
		if ( IsValidPlayer( player ) )
		{
			Remote_CallFunction_NonReplay( player, "ServerCallback_CTF_StopReturnFlagProgressBar" )
			StopSoundOnEntity( player, "UI_CTF_1P_FlagReturnMeter" )
		}
	})
	
	player.EndSignal( "FlagReturnEnded" )
	flag.EndSignal( "FlagReturnEnded" ) // avoid multiple players to return one flag at once
	player.EndSignal( "OnDeath" )
	player.EndSignal( "OnDestroy" )
	
	wait CTF_GetFlagReturnTime()
	
	// flag return succeeded
	// return flag
	ResetFlag( flag )
	
	MessageToTeam( flag.GetTeam(), eEventNotifications.PlayerReturnedFriendlyFlag, null, player )
	EmitSoundOnEntityToTeam( flag, "UI_CTF_3P_TeamReturnsFlag", flag.GetTeam() )
	PlayFactionDialogueToTeam( "ctf_flagReturnedFriendly", flag.GetTeam() )
	
	// do notifications for return
	MessageToPlayer( player, eEventNotifications.YouReturnedFriendlyFlag )
	AddPlayerScore( player, "FlagReturn", player )
	player.AddToPlayerGameStat( PGS_DEFENSE_SCORE, 1 )
	
	if ( !HasPlayerCompletedMeritScore( player ) )
	{
		AddPlayerScore( player, "ChallengeCTFRetAssist" )
		SetPlayerChallengeMeritScore( player )
	}
	
	MessageToTeam( GetOtherTeam( flag.GetTeam() ), eEventNotifications.PlayerReturnedEnemyFlag, null, player )
	EmitSoundOnEntityToTeam( flag, "UI_CTF_3P_EnemyReturnsFlag", GetOtherTeam( flag.GetTeam() ) )
	EmitSoundOnEntityOnlyToPlayer( player, player, "UI_CTF_1P_ReturnsFlag" )
	PlayFactionDialogueToTeam( "ctf_flagReturnedEnemy", GetOtherTeam( flag.GetTeam() ) )
	
	flag.Signal( "FlagReturnEnded" )
}

void function OnPlaying()
{
	foreach ( entity player in GetPlayerArray() )
		CTFInitPlayer( player )
}