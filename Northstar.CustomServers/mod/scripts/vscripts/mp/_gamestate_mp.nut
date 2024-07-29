untyped

global function PIN_GameStart
global function SetGameState
global function GameState_EntitiesDidLoad
global function WaittillGameStateOrHigher
global function AddCallback_OnRoundEndCleanup

global function SetShouldUsePickLoadoutScreen
global function SetShouldSpectateInPickLoadoutScreen
global function SetSwitchSidesBased
global function SetSuddenDeathBased
global function SetTimerBased
global function SetShouldUseRoundWinningKillReplay
global function SetRoundWinningKillReplayKillClasses
global function SetRoundWinningKillReplayAttacker
global function SetCallback_TryUseProjectileReplay
global function ShouldTryUseProjectileReplay
global function SetWinner
global function SetTimeoutWinnerDecisionFunc
global function AddTeamScore
global function GetWinningTeamWithFFASupport

global function GameState_GetTimeLimitOverride
global function IsRoundBasedGameOver
global function SpectatePlayerDuringPickLoadout
global function ShouldRunEvac
global function GiveTitanToPlayer
global function GetTimeLimit_ForGameMode

struct {
	// used for togglable parts of gamestate
	bool usePickLoadoutScreen
	bool spectateInPickLoadoutScreen = false
	bool switchSidesBased
	bool suddenDeathBased
	bool timerBased = true
	int functionref() timeoutWinnerDecisionFunc
	
	bool hasSwitchedSides
	
	int announceRoundWinnerWinningSubstr
	int announceRoundWinnerLosingSubstr
		
	bool roundWinningKillReplayTrackPilotKills = true 
	bool roundWinningKillReplayTrackTitanKills = false
	
	bool gameWonThisFrame
	bool hasKillForGameWonThisFrame
	float roundWinningKillReplayTime
	entity roundWinningKillReplayVictim
	entity roundWinningKillReplayAttacker
	int roundWinningKillReplayInflictorEHandle // this is either the inflictor or the attacker
	int roundWinningKillReplayMethodOfDeath
	float roundWinningKillReplayTimeOfDeath
	float roundWinningKillReplayHealthFrac
	
	array<void functionref()> roundEndCleanupCallbacks
	bool functionref( entity victim, entity attacker, var damageInfo, bool isRoundEnd ) shouldTryUseProjectileReplayCallback
} file

void function SetCallback_TryUseProjectileReplay( bool functionref( entity victim, entity attacker, var damageInfo, bool isRoundEnd ) callback )
{
	file.shouldTryUseProjectileReplayCallback = callback
}

bool function ShouldTryUseProjectileReplay( entity victim, entity attacker, var damageInfo, bool isRoundEnd )
{
	if ( file.shouldTryUseProjectileReplayCallback != null )
		return file.shouldTryUseProjectileReplayCallback( victim, attacker, damageInfo, isRoundEnd )
	// default to true (vanilla behaviour)
	return true
}

void function PIN_GameStart()
{
	// todo: using the pin telemetry function here, weird and was done veeery early on before i knew how this all worked, should use a different one

	// called from InitGameState
	//FlagInit( "ReadyToStartMatch" )
	
	SetServerVar( "switchedSides", 0 )
	SetServerVar( "winningTeam", -1 )
		
	AddCallback_GameStateEnter( eGameState.WaitingForCustomStart, GameStateEnter_WaitingForCustomStart )
	AddCallback_GameStateEnter( eGameState.WaitingForPlayers, GameStateEnter_WaitingForPlayers )
	AddCallback_OnClientConnected( WaitingForPlayers_ClientConnected )
	
	AddCallback_GameStateEnter( eGameState.PickLoadout, GameStateEnter_PickLoadout )
	AddCallback_GameStateEnter( eGameState.Prematch, GameStateEnter_Prematch )
	AddCallback_GameStateEnter( eGameState.Playing, GameStateEnter_Playing )
	AddCallback_GameStateEnter( eGameState.WinnerDetermined, GameStateEnter_WinnerDetermined )
	AddCallback_GameStateEnter( eGameState.SwitchingSides, GameStateEnter_SwitchingSides )
	AddCallback_GameStateEnter( eGameState.SuddenDeath, GameStateEnter_SuddenDeath )
	AddCallback_GameStateEnter( eGameState.Postmatch, GameStateEnter_Postmatch )
	
	AddCallback_OnPlayerKilled( OnPlayerKilled )
	AddDeathCallback( "npc_titan", OnTitanKilled )
	AddCallback_EntityChangedTeam( "player", OnPlayerChangedTeam )
	PilotBattery_SetMaxCount( GetCurrentPlaylistVarInt( "pilot_battery_inventory_size", 1 ) )
	
	RegisterSignal( "CleanUpEntitiesForRoundEnd" )
}

void function SetGameState( int newState )
{
	if ( newState == GetGameState() )
		return

	SetServerVar( "gameStateChangeTime", Time() )
	SetServerVar( "gameState", newState )
	svGlobal.levelEnt.Signal( "GameStateChanged" )

	// added in AddCallback_GameStateEnter
	foreach ( callbackFunc in svGlobal.gameStateEnterCallbacks[ newState ] )
		callbackFunc()
}

void function GameState_EntitiesDidLoad()
{
	if ( GetClassicMPMode() || ClassicMP_ShouldTryIntroAndEpilogueWithoutClassicMP() )
		ClassicMP_SetupIntro()
}

void function WaittillGameStateOrHigher( int gameState )
{
	while ( GetGameState() < gameState )
		svGlobal.levelEnt.WaitSignal( "GameStateChanged" )
}


// logic for individual gamestates:


// eGameState.WaitingForCustomStart
void function GameStateEnter_WaitingForCustomStart()
{
	// unused in release, comments indicate this was supposed to be used for an e3 demo
	// perhaps games in this demo were manually started by an employee? no clue really
}


// eGameState.WaitingForPlayers
void function GameStateEnter_WaitingForPlayers()
{
	thread WaitForPlayers() // like 90% sure there should be a way to get number of loading clients on server but idk it
}

void function WaitForPlayers()
{
	// note: atm if someone disconnects as this happens the game will just wait forever
	float endTime = Time() + 30.0
	
	SetServerVar( "connectionTimeout", endTime )
	while ( GetPendingClientsCount() != 0 && endTime > Time() || !GetPlayerArray().len() )
		WaitFrame()
	
	print( "Finished waiting for players, starting match." )
	
	wait 5
	
	SetGameState( eGameState.PickLoadout )
}

void function WaitingForPlayers_ClientConnected( entity player )
{
	if ( GetGameState() == eGameState.WaitingForPlayers )
		ScreenFadeToBlackForever( player, 0.0 )
}

// eGameState.PickLoadout
void function GameStateEnter_PickLoadout()
{
	thread GameStateEnter_PickLoadout_Threaded()
}

void function GameStateEnter_PickLoadout_Threaded()
{	
	float pickloadoutLength = 30.0
	if ( !file.usePickLoadoutScreen )
		pickloadoutLength = 5.0
	
	SetServerVar( "minPickLoadOutTime", Time() + pickloadoutLength )
	
	// titan selection menu can change minPickLoadOutTime so we need to wait manually until we hit the time
	while ( Time() < GetServerVar( "minPickLoadOutTime" ) )
		WaitFrame()
	
	SetGameState( eGameState.Prematch )
}


// eGameState.Prematch
void function GameStateEnter_Prematch()
{	
	int timeLimit = GameMode_GetTimeLimit( GAMETYPE ) * 60
	if ( file.switchSidesBased )
		timeLimit /= 2 // endtime is half of total per side
	
	SetServerVar( "gameEndTime", Time() + timeLimit + ClassicMP_GetIntroLength() )
	SetServerVar( "roundEndTime", Time() + ClassicMP_GetIntroLength() + GameMode_GetRoundTimeLimit( GAMETYPE ) * 60 )
	
	if ( !GetClassicMPMode() && !ClassicMP_ShouldTryIntroAndEpilogueWithoutClassicMP() )
		thread StartGameWithoutClassicMP()
}

void function StartGameWithoutClassicMP()
{
	foreach ( entity player in GetPlayerArray() )
		if ( IsAlive( player ) )
			player.Die()

	WaitFrame() // wait for callbacks to finish
	
	// need these otherwise game will complain
	SetServerVar( "gameStartTime", Time() )
	SetServerVar( "roundStartTime", Time() )
	
	foreach ( entity player in GetPlayerArray() )
	{
		if ( !IsPrivateMatchSpectator( player ) )
			RespawnAsPilot( player )
			
		ScreenFadeFromBlack( player, 0 )
	}
	
	SetGameState( eGameState.Playing )
}


// eGameState.Playing
void function GameStateEnter_Playing()
{
	thread GameStateEnter_Playing_Threaded()
}

void function GameStateEnter_Playing_Threaded()
{
	WaitFrame() // ensure timelimits are all properly set

	thread DialoguePlayNormal() // runs dialogue play function

	while ( GetGameState() == eGameState.Playing )
	{
		// could cache these, but what if we update it midgame?
		float endTime
		if ( IsRoundBased() )
			endTime = expect float( GetServerVar( "roundEndTime" ) )
		else
			endTime = expect float( GetServerVar( "gameEndTime" ) )
	
		// time's up!
		if ( Time() >= endTime && file.timerBased )
		{
			int winningTeam
			if ( file.timeoutWinnerDecisionFunc != null )
				winningTeam = file.timeoutWinnerDecisionFunc()
			else
				winningTeam = GetWinningTeamWithFFASupport()
			
			if ( file.switchSidesBased && !file.hasSwitchedSides && !IsRoundBased() ) // in roundbased modes, we handle this in setwinner
				SetGameState( eGameState.SwitchingSides )
			else if ( file.suddenDeathBased && winningTeam == TEAM_UNASSIGNED ) // suddendeath if we draw and suddendeath is enabled and haven't switched sides
				SetGameState( eGameState.SuddenDeath )
			else
				SetWinner( winningTeam, "#GAMEMODE_TIME_LIMIT_REACHED", "#GAMEMODE_TIME_LIMIT_REACHED" )
		}
		
		WaitFrame()
	}
}


// eGameState.WinnerDetermined
void function GameStateEnter_WinnerDetermined()
{	
	thread GameStateEnter_WinnerDetermined_Threaded()
}

void function GameStateEnter_WinnerDetermined_Threaded()
{
	// do win announcement
	int winningTeam = GetWinningTeamWithFFASupport()
		
	DialoguePlayWinnerDetermined() // play a faction dialogue when winner is determined

	foreach ( entity player in GetPlayerArray() )
	{
		int announcementSubstr
		if ( winningTeam != TEAM_UNASSIGNED )
			announcementSubstr = player.GetTeam() == winningTeam ? file.announceRoundWinnerWinningSubstr : file.announceRoundWinnerLosingSubstr
	
		if ( IsRoundBased() )
			Remote_CallFunction_NonReplay( player, "ServerCallback_AnnounceRoundWinner", winningTeam, announcementSubstr, ROUND_WINNING_KILL_REPLAY_SCREEN_FADE_TIME, GameRules_GetTeamScore2( TEAM_MILITIA ), GameRules_GetTeamScore2( TEAM_IMC ) )
		else
			Remote_CallFunction_NonReplay( player, "ServerCallback_AnnounceWinner", winningTeam, announcementSubstr, ROUND_WINNING_KILL_REPLAY_SCREEN_FADE_TIME )
	
		if ( player.GetTeam() == winningTeam )
			UnlockAchievement( player, achievements.MP_WIN )
	}
	
	WaitFrame() // wait a frame so other scripts can setup killreplay stuff
	
	if( IsRoundBased() )
		svGlobal.levelEnt.Signal( "RoundEnd" )
	else
		svGlobal.levelEnt.Signal( "GameEnd" )
	
	// set gameEndTime to current time, so hud doesn't display time left in the match
	SetServerVar( "gameEndTime", Time() )
	SetServerVar( "roundEndTime", Time() )

	entity replayAttacker = file.roundWinningKillReplayAttacker
	bool doReplay = Replay_IsEnabled() && IsRoundWinningKillReplayEnabled() && IsValid( replayAttacker ) && !ClassicMP_ShouldRunEpilogue()
				 && Time() - file.roundWinningKillReplayTime <= ROUND_WINNING_KILL_REPLAY_LENGTH_OF_REPLAY && winningTeam != TEAM_UNASSIGNED
 	
	float replayLength = 2.0 // extra delay if no replay
	if ( doReplay )
	{
		bool killcamsWereEnabled = KillcamsEnabled()
		if ( killcamsWereEnabled ) // dont want killcams to interrupt stuff
			SetKillcamsEnabled( false )
	
		replayLength = ROUND_WINNING_KILL_REPLAY_LENGTH_OF_REPLAY
		if ( "respawnTime" in replayAttacker.s && Time() - replayAttacker.s.respawnTime < replayLength )
			replayLength += Time() - expect float ( replayAttacker.s.respawnTime )
		
		SetServerVar( "roundWinningKillReplayEntHealthFrac", file.roundWinningKillReplayHealthFrac )
		
		foreach ( entity player in GetPlayerArray() )
			thread PlayerWatchesRoundWinningKillReplay( player, replayLength )
	
		wait ROUND_WINNING_KILL_REPLAY_SCREEN_FADE_TIME
		CleanUpEntitiesForRoundEnd() // fade should be done by this point, so cleanup stuff now when people won't see
		wait replayLength 
		
		WaitFrame() // prevent a race condition with PlayerWatchesRoundWinningKillReplay
		file.roundWinningKillReplayAttacker = null // clear this
		file.roundWinningKillReplayInflictorEHandle = -1
		
		if ( killcamsWereEnabled )
			SetKillcamsEnabled( true )
	}
	else if ( IsRoundBased() || !ClassicMP_ShouldRunEpilogue() )
	{
		//Observation from vanilla hints that the round ends after 10 seconds and setups player control from the gamemode
		foreach( entity player in GetPlayerArray() )
		{
			if( level.endOfRoundPlayerState == ENDROUND_FREEZE )
				player.FreezeControlsOnServer()
			else if( level.endOfRoundPlayerState == ENDROUND_MOVEONLY )
			{
				player.HolsterWeapon()
				player.Server_TurnOffhandWeaponsDisabledOn()
			}
		}
		
		wait 6
		
		foreach( entity player in GetPlayerArray() )
			ScreenFadeToBlackForever( player, 2.0 )
		
		wait 4
		
		if( IsRoundBased() )
		{
			CleanUpEntitiesForRoundEnd()
			foreach( entity player in GetPlayerArray() )
			{
				player.UnfreezeControlsOnServer()
				player.DeployWeapon()
				player.Server_TurnOffhandWeaponsDisabledOff()
			}
		}
	}
	
	wait CLEAR_PLAYERS_BUFFER //Required to properly restart without players in Titans crashing it in FD
	
	if ( IsRoundBased() )
	{
		ClearDroppedWeapons()
		int roundsPlayed = expect int ( GetServerVar( "roundsPlayed" ) )
		roundsPlayed++
		SetServerVar( "roundsPlayed", roundsPlayed )
		
		int winningTeam = GetWinningTeamWithFFASupport()
		
		int highestScore = GameRules_GetTeamScore( winningTeam )
		int roundScoreLimit = GameMode_GetRoundScoreLimit( GAMETYPE )
		
		if ( highestScore >= roundScoreLimit )
		{
			if ( ClassicMP_ShouldRunEpilogue() )
			{
				ClassicMP_SetupEpilogue()
				SetGameState( eGameState.Epilogue )
			}
			else
				SetGameState( eGameState.Postmatch )
		}
		else if ( file.usePickLoadoutScreen && GetCurrentPlaylistVarInt( "pick_loadout_every_round", 1 ) ) //Playlist var needs to be enabled as well
			SetGameState( eGameState.PickLoadout )
		else
			SetGameState( eGameState.Prematch )
	}
	else
	{
		RegisterChallenges_OnMatchEnd()
		if ( ClassicMP_ShouldRunEpilogue() )
		{
			ClassicMP_SetupEpilogue()
			SetGameState( eGameState.Epilogue )
		}
		else
			SetGameState( eGameState.Postmatch )
	}
	
	AllPlayersUnMuteAll()
}

void function PlayerWatchesRoundWinningKillReplay( entity player, float replayLength )
{
	// end if player dcs 
	player.EndSignal( "OnDestroy" )
	
	player.FreezeControlsOnServer()
	ScreenFadeToBlackForever( player, ROUND_WINNING_KILL_REPLAY_SCREEN_FADE_TIME )
	wait ROUND_WINNING_KILL_REPLAY_SCREEN_FADE_TIME
	
	player.SetPredictionEnabled( false ) // prediction fucks with replays
	
	entity attacker = file.roundWinningKillReplayAttacker
	if ( IsValid( attacker ) )
	{
		player.SetKillReplayDelay( Time() - replayLength, THIRD_PERSON_KILL_REPLAY_ALWAYS )
		player.SetKillReplayInflictorEHandle( file.roundWinningKillReplayInflictorEHandle )
		player.SetKillReplayVictim( file.roundWinningKillReplayVictim )
		player.SetViewIndex( attacker.GetIndexForEntity() )
		player.SetIsReplayRoundWinning( true )
	}
	
	if ( replayLength >= ROUND_WINNING_KILL_REPLAY_LENGTH_OF_REPLAY - 0.5 ) // only do fade if close to full length replay
	{
		// this doesn't work because fades don't work on players that are in a replay, unsure how official servers do this
		wait replayLength - 2.0
		ScreenFadeToBlackForever( player, 2.0 )
	
		wait 2.0
	}
	else
		wait replayLength
		
	//player.SetPredictionEnabled( true ) doesn't seem needed, as native code seems to set this on respawn
	player.ClearReplayDelay()
	player.ClearViewEntity()
	player.UnfreezeControlsOnServer()
}


// eGameState.SwitchingSides
void function GameStateEnter_SwitchingSides()
{
	thread GameStateEnter_SwitchingSides_Threaded()
}

void function GameStateEnter_SwitchingSides_Threaded()
{
	bool killcamsWereEnabled = KillcamsEnabled()
	if ( killcamsWereEnabled ) // dont want killcams to interrupt stuff
		SetKillcamsEnabled( false )
		
	WaitFrame() // wait a frame so callbacks can set killreplay info
	
	svGlobal.levelEnt.Signal( "RoundEnd" )
	
	entity replayAttacker = file.roundWinningKillReplayAttacker
	bool doReplay = Replay_IsEnabled() && IsRoundWinningKillReplayEnabled() && IsValid( replayAttacker ) && !IsRoundBased() // for roundbased modes, we've already done the replay
				 && Time() - file.roundWinningKillReplayTime <= ROUND_WINNING_KILL_REPLAY_LENGTH_OF_REPLAY
	
	float replayLength = SWITCHING_SIDES_DELAY_REPLAY // extra delay if no replay
	if ( doReplay )
	{		
		replayLength = GAME_WINNER_DETERMINED_ROUND_WAIT_WITH_ROUND_WINNING_KILL_REPLAY_WAIT
		if ( "respawnTime" in replayAttacker.s && Time() - replayAttacker.s.respawnTime < replayLength )
			replayLength += Time() - expect float ( replayAttacker.s.respawnTime )
			
		SetServerVar( "roundWinningKillReplayEntHealthFrac", file.roundWinningKillReplayHealthFrac )
	}
	
	foreach ( entity player in GetPlayerArray() )
		thread PlayerWatchesSwitchingSidesKillReplay( player, doReplay, replayLength )

	thread DialogueAnnounceSwitchingSides()
	wait GAME_WINNER_DETERMINED_ROUND_WAIT
	
	CleanUpEntitiesForRoundEnd() // fade should be done by this point, so cleanup stuff now when people won't see
	wait ROUND_WINNING_KILL_REPLAY_ROUND_SCORE_ANNOUNCEMENT_DURATION
	
	ClearDroppedWeapons()
	if ( killcamsWereEnabled )
		SetKillcamsEnabled( true )
	
	file.hasSwitchedSides = true
	SetServerVar( "switchedSides", 1 )
	file.roundWinningKillReplayAttacker = null // reset this after replay
	file.roundWinningKillReplayInflictorEHandle = -1
	
	if ( file.usePickLoadoutScreen && GetCurrentPlaylistVarInt( "pick_loadout_every_round", 1 ) ) //Playlist var needs to be enabled too
		SetGameState( eGameState.PickLoadout )
	else
		SetGameState ( eGameState.Prematch )
}

void function DialogueAnnounceSwitchingSides()
{
	wait ROUND_WINNING_KILL_REPLAY_LENGTH_OF_REPLAY
	foreach ( entity player in GetPlayerArray() )
		PlayFactionDialogueToPlayer( "mp_sideSwitching", player )
}


void function PlayerWatchesSwitchingSidesKillReplay( entity player, bool doReplay, float replayLength )
{
	player.EndSignal( "OnDestroy" )
	player.FreezeControlsOnServer()

	ScreenFadeToBlackForever( player, SWITCHING_SIDES_DELAY_REPLAY ) // automatically cleared 
	wait SWITCHING_SIDES_DELAY_REPLAY
	
	if ( doReplay )
	{
		player.SetPredictionEnabled( false ) // prediction fucks with replays
	
		// delay seems weird for switchingsides? ends literally the frame the flag is collected
	
		entity attacker = file.roundWinningKillReplayAttacker
		player.SetKillReplayDelay( Time() - replayLength, THIRD_PERSON_KILL_REPLAY_ALWAYS )
		player.SetKillReplayInflictorEHandle( file.roundWinningKillReplayInflictorEHandle )
		player.SetKillReplayVictim( file.roundWinningKillReplayVictim )
		player.SetViewIndex( attacker.GetIndexForEntity() )
		player.SetIsReplayRoundWinning( true )
		
		if ( replayLength >= SWITCHING_SIDES_DELAY - 0.5 ) // only do fade if close to full length replay
		{
			// this doesn't work because fades don't work on players that are in a replay, unsure how official servers do this
			wait replayLength - ROUND_WINNING_KILL_REPLAY_SCREEN_FADE_TIME
			ScreenFadeToBlackForever( player, ROUND_WINNING_KILL_REPLAY_SCREEN_FADE_TIME )

			wait ROUND_WINNING_KILL_REPLAY_SCREEN_FADE_TIME
		}
		else
			wait replayLength
	}
	else
		wait SWITCHING_SIDES_DELAY_REPLAY // extra delay if no replay
	
	//player.SetPredictionEnabled( true ) doesn't seem needed, as native code seems to set this on respawn
	player.ClearReplayDelay()
	player.ClearViewEntity()
}


// eGameState.SuddenDeath
void function GameStateEnter_SuddenDeath()
{
	// disable respawns, suddendeath calling is done on a kill callback
	SetRespawnsEnabled( false )

	// defensive fixes, so game won't stuck in SuddenDeath forever
	bool mltElimited = false
	bool imcElimited = false
	if( GetPlayerArrayOfTeam_Alive( TEAM_MILITIA ).len() < 1 )
		mltElimited = true
	if( GetPlayerArrayOfTeam_Alive( TEAM_IMC ).len() < 1 )
		imcElimited = true
	if( mltElimited && imcElimited )
		SetWinner( TEAM_UNASSIGNED )
	else if( mltElimited )
		SetWinner( TEAM_IMC, "#GAMEMODE_ENEMY_PILOTS_ELIMINATED", "#GAMEMODE_FRIENDLY_PILOTS_ELIMINATED" )
	else if( imcElimited )
		SetWinner( TEAM_MILITIA, "#GAMEMODE_ENEMY_PILOTS_ELIMINATED", "#GAMEMODE_FRIENDLY_PILOTS_ELIMINATED" )
}


// eGameState.Postmatch
void function GameStateEnter_Postmatch()
{
	SetKillcamsEnabled( false ) //Disable kill replays on this moment just to ensure no camera problems
	foreach ( entity player in GetPlayerArray() )
	{
		player.FreezeControlsOnServer()
		player.SetNoTarget( true ) //Stop AI from targeting this player at this state of the match
		player.SetInvulnerable() //Players could still die to some post-damaging stuff they might release (i.e: Electric Smokes, AI)
		thread ForceFadeToBlack( player )
	}
	
	thread GameStateEnter_Postmatch_Threaded()
}

void function GameStateEnter_Postmatch_Threaded()
{
	wait GAME_POSTMATCH_LENGTH
	
	AllPlayersMuteAll( 2 ) //Vanilla has a fadeout in sound right before it really finishes the match
	
	wait 2.0
	
	GameRules_EndMatch()
}

void function ForceFadeToBlack( entity player )
{
	// todo: check if this is still necessary
	player.EndSignal( "OnDestroy" )

	// hack until i figure out what deathcam stuff is causing fadetoblacks to be cleared
	while ( true )
	{
		WaitFrame()
		ScreenFadeToBlackForever( player, 0.0 )
	}
}


// shared across multiple gamestates

void function OnPlayerKilled( entity victim, entity attacker, var damageInfo )
{
	if ( !GamePlayingOrSuddenDeath() )
	{
		if ( file.gameWonThisFrame )
		{
			if ( file.hasKillForGameWonThisFrame )
				return
		}
		else
			return
	}
	
	entity inflictor = DamageInfo_GetInflictor( damageInfo )
	bool shouldUseInflictor = IsValid( inflictor ) && ShouldTryUseProjectileReplay( victim, attacker, damageInfo, true )
	if( victim.IsPlayer() )
	{
		victim.p.numberOfDeaths++
		ShowDeathHint( victim, damageInfo )
	}

	// set round winning killreplay info here if we're tracking pilot kills
	// todo: make this not count environmental deaths like falls, unsure how to prevent this
	if ( file.roundWinningKillReplayTrackPilotKills && victim != attacker && attacker != svGlobal.worldspawn && IsValid( attacker ) )
	{
		if ( file.gameWonThisFrame )
			file.hasKillForGameWonThisFrame = true
		file.roundWinningKillReplayTime = Time()
		file.roundWinningKillReplayVictim = victim
		file.roundWinningKillReplayAttacker = attacker
		file.roundWinningKillReplayInflictorEHandle = ( shouldUseInflictor ? inflictor : attacker ).GetEncodedEHandle()
		file.roundWinningKillReplayMethodOfDeath = DamageInfo_GetDamageSourceIdentifier( damageInfo )
		file.roundWinningKillReplayTimeOfDeath = Time()
		file.roundWinningKillReplayHealthFrac = GetHealthFrac( attacker )
	}

	if ( ( Riff_EliminationMode() == eEliminationMode.Titans || Riff_EliminationMode() == eEliminationMode.PilotsTitans ) && victim.IsTitan() ) // need an extra check for this
		OnTitanKilled( victim, damageInfo )	

	if ( !GamePlayingOrSuddenDeath() )
		return

	// note: pilotstitans is just win if enemy team runs out of either pilots or titans
	if ( IsPilotEliminationBased() || GetGameState() == eGameState.SuddenDeath )
	{
		if ( !GetPlayerArrayOfTeam_Alive( victim.GetTeam() ).len() )
		{
			// for ffa we need to manually get the last team alive 
			if ( IsFFAGame() )
			{
				array<int> teamsWithLivingPlayers
				foreach ( entity player in GetPlayerArray_Alive() )
				{
					if ( !teamsWithLivingPlayers.contains( player.GetTeam() ) )
						teamsWithLivingPlayers.append( player.GetTeam() )
				}
				
				if ( teamsWithLivingPlayers.len() == 1 )
					SetWinner( teamsWithLivingPlayers[ 0 ], "#GAMEMODE_ENEMY_PILOTS_ELIMINATED", "#GAMEMODE_FRIENDLY_PILOTS_ELIMINATED" )
				else if ( teamsWithLivingPlayers.len() == 0 ) // failsafe: only team was the dead one
					SetWinner( TEAM_UNASSIGNED, "#GAMEMODE_ENEMY_PILOTS_ELIMINATED", "#GAMEMODE_FRIENDLY_PILOTS_ELIMINATED" ) // this is fine in ffa
			}
			else
				SetWinner( GetOtherTeam( victim.GetTeam() ), "#GAMEMODE_ENEMY_PILOTS_ELIMINATED", "#GAMEMODE_FRIENDLY_PILOTS_ELIMINATED" )
		}
	}
	
	array<entity> players = GetPlayerArrayOfTeam( victim.GetTeam() )
	int functionref( entity, entity ) compareFunc = GameMode_GetScoreCompareFunc( GAMETYPE )
	if ( compareFunc != null && players.len() )
	{
		players.sort( compareFunc )
		if( victim == players[0] && attacker.IsPlayer() && attacker != victim )
			AddPlayerScore( attacker, "KilledMVP" )
	}
}

void function OnTitanKilled( entity victim, var damageInfo )
{
	if ( !GamePlayingOrSuddenDeath() )
	{
		if ( file.gameWonThisFrame )
		{
			if ( file.hasKillForGameWonThisFrame )
				return
		}
		else
			return
	}

	entity inflictor = DamageInfo_GetInflictor( damageInfo )
	bool shouldUseInflictor = IsValid( inflictor ) && ShouldTryUseProjectileReplay( victim, DamageInfo_GetAttacker( damageInfo ), damageInfo, true )

	// set round winning killreplay info here if we're tracking titan kills
	// todo: make this not count environmental deaths like falls, unsure how to prevent this
	entity attacker = DamageInfo_GetAttacker( damageInfo )
	if ( file.roundWinningKillReplayTrackTitanKills && victim != attacker && attacker != svGlobal.worldspawn && IsValid( attacker ) )
	{
		if ( file.gameWonThisFrame )
			file.hasKillForGameWonThisFrame = true
		file.roundWinningKillReplayTime = Time()
		file.roundWinningKillReplayVictim = victim
		file.roundWinningKillReplayAttacker = attacker
		file.roundWinningKillReplayInflictorEHandle = ( shouldUseInflictor ? inflictor : attacker ).GetEncodedEHandle()
		file.roundWinningKillReplayMethodOfDeath = DamageInfo_GetDamageSourceIdentifier( damageInfo )
		file.roundWinningKillReplayTimeOfDeath = Time()
		file.roundWinningKillReplayHealthFrac = GetHealthFrac( attacker )
	}
	
	if ( !GamePlayingOrSuddenDeath() )
		return

	// note: pilotstitans is just win if enemy team runs out of either pilots or titans
	if ( IsTitanEliminationBased() )
	{
		int livingTitans
		foreach ( entity titan in GetTitanArrayOfTeam( victim.GetTeam() ) )
			livingTitans++
	
		if ( livingTitans == 0 )
		{
			// for ffa we need to manually get the last team alive 
			if ( IsFFAGame() )
			{
				array<int> teamsWithLivingTitans
				foreach ( entity titan in GetTitanArray() )
				{
					if ( !teamsWithLivingTitans.contains( titan.GetTeam() ) )
						teamsWithLivingTitans.append( titan.GetTeam() )
				}
				
				if ( teamsWithLivingTitans.len() == 1 )
					SetWinner( teamsWithLivingTitans[ 0 ], "#GAMEMODE_ENEMY_TITANS_DESTROYED", "#GAMEMODE_FRIENDLY_TITANS_DESTROYED" )
				else if ( teamsWithLivingTitans.len() == 0 ) // failsafe: only team was the dead one
					SetWinner( TEAM_UNASSIGNED, "#GAMEMODE_ENEMY_TITANS_DESTROYED", "#GAMEMODE_FRIENDLY_TITANS_DESTROYED" ) // this is fine in ffa
			}
			else
				SetWinner( GetOtherTeam( victim.GetTeam() ), "#GAMEMODE_ENEMY_TITANS_DESTROYED", "#GAMEMODE_FRIENDLY_TITANS_DESTROYED" )
		}
	}
}

void function AddCallback_OnRoundEndCleanup( void functionref() callback )
{
	file.roundEndCleanupCallbacks.append( callback )
}

void function CleanUpEntitiesForRoundEnd()
{
	// this function should clean up any and all entities that need to be removed between rounds, ideally at a point where it isn't noticable to players
	SetPlayerDeathsHidden( true ) // hide death sounds and such so people won't notice they're dying
	svGlobal.levelEnt.Signal( "CleanUpEntitiesForRoundEnd" ) 
	foreach ( entity player in GetPlayerArray() )
	{
		PlayerEarnMeter_Reset( player )
		ClearTitanAvailable( player )
		PROTO_CleanupTrackedProjectiles( player )
		player.SetPlayerNetInt( "batteryCount", 0 ) 
		player.ClearInvulnerable()
		player.SetNoTarget( false )
		player.ClearParent() //Dropship parenting causes observer mode crash
		if ( IsAlive( player ) )
			player.Die( svGlobal.worldspawn, svGlobal.worldspawn, { damageSourceId = eDamageSourceId.round_end } )
	}
	
	foreach ( entity npc in GetNPCArray() )
	{
		if ( !IsValid( npc ) || !IsAlive( npc ) )
			continue
		
		if( npc.e.fd_roundDeployed != -1 || npc.ai.buddhaMode ) //FD uses this var to cleanup stuff placed in current wave restart, buddha is for offline Turrets
			continue
		
		// kill rather than destroy, as destroying will cause issues with children which is an issue especially for dropships and titans
		npc.Die( svGlobal.worldspawn, svGlobal.worldspawn, { damageSourceId = eDamageSourceId.round_end } )
	}
	
	// destroy weapons
	ClearDroppedWeapons()
		
	foreach ( entity battery in GetEntArrayByClass_Expensive( "item_titan_battery" ) )
		battery.Destroy()
	
	// allow other scripts to clean stuff up too
	foreach ( void functionref() callback in file.roundEndCleanupCallbacks )
		callback()
	
	WaitFrame()
	SetPlayerDeathsHidden( false )
}



// stuff for gamemodes to call

void function SetShouldUsePickLoadoutScreen( bool shouldUse )
{
	file.usePickLoadoutScreen = shouldUse
}

void function SetShouldSpectateInPickLoadoutScreen( bool shouldSpec )
{
	file.spectateInPickLoadoutScreen = shouldSpec
}

bool function SpectatePlayerDuringPickLoadout()
{
	return ( file.usePickLoadoutScreen && file.spectateInPickLoadoutScreen )
}

void function SetSwitchSidesBased( bool switchSides )
{
	file.switchSidesBased = switchSides
}

void function SetSuddenDeathBased( bool suddenDeathBased )
{
	file.suddenDeathBased = suddenDeathBased
}

void function SetTimerBased( bool timerBased )
{
	file.timerBased = timerBased
}

void function SetShouldUseRoundWinningKillReplay( bool shouldUse )
{
	SetServerVar( "roundWinningKillReplayEnabled", shouldUse )
}

void function SetRoundWinningKillReplayKillClasses( bool pilot, bool titan )
{
	file.roundWinningKillReplayTrackPilotKills = pilot
	file.roundWinningKillReplayTrackTitanKills = titan // player kills in titans should get tracked anyway, might be worth renaming this
}

void function SetRoundWinningKillReplayAttacker( entity attacker, int inflictorEHandle = -1 )
{
	file.roundWinningKillReplayTime = Time()
	file.roundWinningKillReplayHealthFrac = GetHealthFrac( attacker )
	file.roundWinningKillReplayAttacker = attacker
	file.roundWinningKillReplayInflictorEHandle = inflictorEHandle == -1 ? attacker.GetEncodedEHandle() : inflictorEHandle
	file.roundWinningKillReplayTimeOfDeath = Time()
}

void function DebounceScoreTie( int team )
{
	if( IsRoundBased() )
	{
		if( GameRules_GetTeamScore( team ) < GameMode_GetRoundScoreLimit( GAMETYPE ) )
			GameRules_SetTeamScore( team, GameMode_GetRoundScoreLimit( GAMETYPE ) )
					
		if( GameRules_GetTeamScore2( team ) < GameMode_GetRoundScoreLimit( GAMETYPE ) )
			GameRules_SetTeamScore2( team, GameMode_GetRoundScoreLimit( GAMETYPE ) )
	}
	else
	{
		if( GameRules_GetTeamScore( team ) < GameMode_GetScoreLimit( GAMETYPE ) )
			GameRules_SetTeamScore( team, GameMode_GetScoreLimit( GAMETYPE ) )
				
		if( GameRules_GetTeamScore2( team ) < GameMode_GetScoreLimit( GAMETYPE ) )
			GameRules_SetTeamScore2( team, GameMode_GetScoreLimit( GAMETYPE ) )
	}
}

void function SetWinner( int team, string winningReason = "", string losingReason = "" )
{	
	SetServerVar( "winningTeam", team )
	
	file.gameWonThisFrame = true
	thread UpdateGameWonThisFrameNextFrame()
	
	if ( winningReason == "" )
		file.announceRoundWinnerWinningSubstr = 0
	else
		file.announceRoundWinnerWinningSubstr = GetStringID( winningReason )
		
	if ( losingReason == "" )
		file.announceRoundWinnerLosingSubstr = 0
	else
		file.announceRoundWinnerLosingSubstr = GetStringID( losingReason )
	
	float endTime
	if ( IsRoundBased() )
		endTime = expect float( GetServerVar( "roundEndTime" ) )
	else
		endTime = expect float( GetServerVar( "gameEndTime" ) )
	
	if( GameRules_GetGameMode() == FD ) //Reset IMC scorepoints to prevent ties and properly display winner in post-summary screen for FD
	{
		if( team == TEAM_MILITIA )
		{
			GameRules_SetTeamScore( TEAM_IMC, 0 )
			GameRules_SetTeamScore( TEAM_MILITIA, 1 )
		}
		else if( team == TEAM_IMC && !IsRoundBased() )
		{
			GameRules_SetTeamScore( TEAM_IMC, 1 )
			GameRules_SetTeamScore( TEAM_MILITIA, 0 )
		}
	}
	else if ( team != TEAM_UNASSIGNED )
	{
		if( !file.timerBased )
			DebounceScoreTie( team )
		
		else if( Time() < endTime )
			DebounceScoreTie( team )
	}
	
	if ( GamePlayingOrSuddenDeath() )
	{
		if ( IsRoundBased() )
		{
			SetGameState( eGameState.WinnerDetermined )
			ScoreEvent_RoundComplete( team )
		}
		else
		{
			SetGameState( eGameState.WinnerDetermined )
			ScoreEvent_MatchComplete( team )
			
			array<entity> players = GetPlayerArray()
			int functionref( entity, entity ) compareFunc = GameMode_GetScoreCompareFunc( GAMETYPE )
			if ( compareFunc != null )
			{
				players.sort( compareFunc )
				int playerCount = players.len()
				int currentPlace = 1
				for ( int i = 0; i < 3; i++ )
				{
					if ( i >= playerCount )
						continue
					
					if ( i > 0 && compareFunc( players[i - 1], players[i] ) != 0 )
						currentPlace += 1

					switch( currentPlace )
					{
						case 1:
							UpdatePlayerStat( players[i], "game_stats", "mvp" )
							UpdatePlayerStat( players[i], "game_stats", "mvp_total" )
							UpdatePlayerStat( players[i], "game_stats", "top3OnTeam" )
							break
						case 2:
							UpdatePlayerStat( players[i], "game_stats", "top3OnTeam" )
							break
						case 3:
							UpdatePlayerStat( players[i], "game_stats", "top3OnTeam" )
							break
					}
				}
			}
		}
	}
}

void function UpdateGameWonThisFrameNextFrame()
{
	WaitFrame()
	file.gameWonThisFrame = false
	file.hasKillForGameWonThisFrame = false
}

void function AddTeamScore( int team, int amount )
{
	GameRules_SetTeamScore( team, GameRules_GetTeamScore( team ) + amount )
	GameRules_SetTeamScore2( team, GameRules_GetTeamScore2( team ) + amount )
	
	int scoreLimit
	int score = GameRules_GetTeamScore( team )
	
	if ( IsRoundBased() )
		scoreLimit = GameMode_GetRoundScoreLimit( GAMETYPE )
	else
		scoreLimit = GameMode_GetScoreLimit( GAMETYPE )
	
	if ( score >= scoreLimit && IsRoundBased() )
		SetWinner( team, "#GAMEMODE_ROUND_LIMIT_REACHED", "#GAMEMODE_ROUND_LIMIT_REACHED" )
	else if( score >= scoreLimit )
		SetWinner( team, "#GAMEMODE_SCORE_LIMIT_REACHED", "#GAMEMODE_SCORE_LIMIT_REACHED" )
	else if( GetGameState() == eGameState.SuddenDeath )
		SetWinner( team )
	
	else if ( ( file.switchSidesBased && !file.hasSwitchedSides ) && score >= ( scoreLimit.tofloat() / 2.0 ) )
	{
		thread DialogueAnnounceHalftime()
		SetGameState( eGameState.SwitchingSides )
	}
}

void function DialogueAnnounceHalftime()
{
	wait 1.0
	foreach ( entity player in GetPlayerArray() )
		PlayFactionDialogueToPlayer( "mp_halftime", player )
}

void function SetTimeoutWinnerDecisionFunc( int functionref() callback )
{
	file.timeoutWinnerDecisionFunc = callback
}

int function GetWinningTeamWithFFASupport()
{
	if ( !IsFFAGame() )
		return GameScore_GetWinningTeam()
	else
	{
		// custom logic for calculating ffa winner as GameScore_GetWinningTeam doesn't handle this
		int winningTeam = TEAM_UNASSIGNED
		int winningScore = 0
		
		foreach ( entity player in GetPlayerArray() )
		{
			int currentScore = GameRules_GetTeamScore( player.GetTeam() )
			
			if ( currentScore == winningScore )
				winningTeam = TEAM_UNASSIGNED // if 2 teams are equal, return TEAM_UNASSIGNED
			else if ( currentScore > winningScore )
			{
				winningTeam = player.GetTeam()
				winningScore = currentScore
			}
		}
		
		return winningTeam
	}
	
	unreachable
}

// idk

float function GameState_GetTimeLimitOverride()
{
	return 100
}

bool function IsRoundBasedGameOver()
{
	return false
}

bool function ShouldRunEvac()
{
	return GameMode_GetEvacEnabled( GAMETYPE )
}

void function GiveTitanToPlayer( entity player )
{
	if( !IsValid( player ) )
		return
	
	if( !player.IsPlayer() )
		return
	
	PlayerEarnMeter_SetMode( player, eEarnMeterMode.DEFAULT )
	PlayerEarnMeter_AddEarnedAndOwned( player, 1.0, 1.0 )
}

float function GetTimeLimit_ForGameMode()
{
	string mode = GameRules_GetGameMode()
	string playlistString = "timelimit"

	// default to 10 mins, because that seems reasonable
	return GetCurrentPlaylistVarFloat( playlistString, 10 )
}

// faction dialogue

void function DialoguePlayNormal()
{
	svGlobal.levelEnt.EndSignal( "GameEnd" )
	svGlobal.levelEnt.EndSignal( "RoundEnd" )
	int totalScore = GameMode_GetScoreLimit( GameRules_GetGameMode() )
	int winningTeam
	int losingTeam
	float diagIntervel = 91

	while( GamePlaying() )
	{
		wait diagIntervel
		if( GameRules_GetTeamScore( TEAM_MILITIA ) < GameRules_GetTeamScore( TEAM_IMC ) )
		{
			winningTeam = TEAM_IMC
			losingTeam = TEAM_MILITIA
		}
		if( GameRules_GetTeamScore( TEAM_MILITIA ) > GameRules_GetTeamScore( TEAM_IMC ) )
		{
			winningTeam = TEAM_MILITIA
			losingTeam = TEAM_IMC
		}
		if( GameRules_GetTeamScore( winningTeam ) - GameRules_GetTeamScore( losingTeam ) >= totalScore * 0.4 )
		{
			PlayFactionDialogueToTeam( "scoring_winningLarge", winningTeam )
			PlayFactionDialogueToTeam( "scoring_losingLarge", losingTeam )
		}
		else if( GameRules_GetTeamScore( winningTeam ) - GameRules_GetTeamScore( losingTeam ) <= totalScore * 0.2 )
		{
			PlayFactionDialogueToTeam( "scoring_winningClose", winningTeam )
			PlayFactionDialogueToTeam( "scoring_losingClose", losingTeam )
		}
		else if( GameRules_GetTeamScore( winningTeam ) == GameRules_GetTeamScore( losingTeam ) )
		{
			continue
		}
		else
		{
			PlayFactionDialogueToTeam( "scoring_winning", winningTeam )
			PlayFactionDialogueToTeam( "scoring_losing", losingTeam )
		}
	}
}

void function DialoguePlayWinnerDetermined()
{
	int totalScore = GameMode_GetScoreLimit( GameRules_GetGameMode() )
	int winningTeam
	int losingTeam

	if( GameRules_GetTeamScore( TEAM_MILITIA ) < GameRules_GetTeamScore( TEAM_IMC ) )
	{
		winningTeam = TEAM_IMC
		losingTeam = TEAM_MILITIA
	}
	if( GameRules_GetTeamScore( TEAM_MILITIA ) > GameRules_GetTeamScore( TEAM_IMC ) )
	{
		winningTeam = TEAM_MILITIA
		losingTeam = TEAM_IMC
	}
	if( IsRoundBased() ) // check for round based modes
	{
		if( GameRules_GetTeamScore( winningTeam ) != GameMode_GetRoundScoreLimit( GAMETYPE ) ) // no winner dialogue till game really ends
			return
	}
	if( GameRules_GetTeamScore( winningTeam ) - GameRules_GetTeamScore( losingTeam ) >= totalScore * 0.4 )
	{
		PlayFactionDialogueToTeam( "scoring_wonMercy", winningTeam )
		PlayFactionDialogueToTeam( "scoring_lostMercy", losingTeam )
	}
	else if( GameRules_GetTeamScore( winningTeam ) - GameRules_GetTeamScore( losingTeam ) <= totalScore * 0.2 )
	{
		PlayFactionDialogueToTeam( "scoring_wonClose", winningTeam )
		PlayFactionDialogueToTeam( "scoring_lostClose", losingTeam )
	}
	else if( GameRules_GetTeamScore( winningTeam ) == GameRules_GetTeamScore( losingTeam ) )
	{
		PlayFactionDialogueToTeam( "scoring_tied", winningTeam )
		PlayFactionDialogueToTeam( "scoring_tied", losingTeam )
	}
	else
	{
		PlayFactionDialogueToTeam( "scoring_won", winningTeam )
		PlayFactionDialogueToTeam( "scoring_lost", losingTeam )
	}
}

// This is to move all NPCs that a player owns from one team to the other during a match
/// Auto-Titans, Turrets, Ticks and Hacked Spectres will all move along together with the player to the new Team
/// Also possibly prevents mods that spawns other types of NPCs that players can own from breaking when switching (i.e Drones, Hacked Reapers)
void function OnPlayerChangedTeam( entity player )
{
	if ( !player.hasConnected ) //Prevents players who just joined to trigger below code, as server always pre setups their teams
		return
	
	NotifyClientsOfTeamChange( player, GetOtherTeam( player.GetTeam() ), player.GetTeam() )
	
	foreach( npc in GetNPCArray() )
	{
		entity bossPlayer = npc.GetBossPlayer()
		if ( IsValidPlayer( bossPlayer ) && bossPlayer == player && IsAlive( npc ) )
			SetTeam( npc, player.GetTeam() )
	}
}