global function initFrontierDefenseData
void function initFrontierDefenseData()
{
    shopPosition = < -710.46, 210.69 , 408>
	shopAngles = < 0, -90, 0 >
	FD_spawnPosition = < 2430.80, 594.53, 128 >
	FD_spawnAngles = < 0, 180, 0 >
	FD_groundspawnPosition = < 961, 845, 409 >
	FD_groundspawnAngles = < 0, -130, 0 >
	
	FD_DropPodSpawns.append(< 1403, 1310, 256 >)
	FD_DropPodSpawns.append(< -1135, 1450, 224 >)
	FD_DropPodSpawns.append(< 1041, -1422, 264 >)
	
	waveAnnouncement.append("fd_introEasy")
	waveAnnouncement.append("fd_waveTypeTicks")
	waveAnnouncement.append("fd_waveTypeReaperTicks")
	waveAnnouncement.append("fd_waveTypeFlyers")
	waveAnnouncement.append("fd_waveTypeTitanArc")
	
	AddStationaryAIPosition(< 576, -3436, 141 >, eStationaryAIPositionTypes.LAUNCHER_REAPER)
	AddStationaryAIPosition(< 3468, -3461, 0 >, eStationaryAIPositionTypes.LAUNCHER_REAPER)
	AddStationaryAIPosition(< 3256, 3423, -47 >, eStationaryAIPositionTypes.LAUNCHER_REAPER)
	AddStationaryAIPosition(< -1910, 3458, 84 >, eStationaryAIPositionTypes.LAUNCHER_REAPER)
	AddStationaryAIPosition(< 1968, 1282, 256 >, eStationaryAIPositionTypes.LAUNCHER_REAPER)
	AddStationaryAIPosition(< 455, -3620, 144 >, eStationaryAIPositionTypes.LAUNCHER_REAPER)
	AddStationaryAIPosition(< 3484, 1129, -25 >, eStationaryAIPositionTypes.LAUNCHER_REAPER)

	int index = 1
	
    array<WaveEvent> wave1
	wave1.append(CreateWarningEvent( FD_IncomingWarnings.Infantry, index++ ))
	wave1.append(CreateDroppodGruntEvent(< 1291, 1519, 256 >,"leftNear",index++))
	wave1.append(CreateWaitForTimeEvent(1.5,index++))
	wave1.append(CreateDroppodGruntEvent(< -1844, -2248, 101 >,"midHalfway_infantry",index++))
	wave1.append(CreateWaitForTimeEvent(1.5,index++))
	wave1.append(CreateDroppodGruntEvent(< -1198, 1588, 208 >,"leftHalfway_infantry",index++))
	wave1.append(CreateWaitForTimeEvent(1.5,index++))
	wave1.append(CreateDroppodGruntEvent(< 1000, -3102, 127 >,"right_infantry",index++))
	wave1.append(CreateWaitForTimeEvent(1.5,index++))
	wave1.append(CreateDroppodGruntEvent(< -375, -2590, 185 >,"infantyPerch_right1",index++))
	wave1.append(CreateWaitForTimeEvent(1.5,index++))
	wave1.append(CreateDroppodGruntEvent(< 1638, -2005, 240 >,"rightHalfway_infantry",index++))
	wave1.append(CreateWaitForTimeEvent(1.0,index++))
	wave1.append(CreateWaitUntilAliveEvent( 6, index++ ) )
	wave1.append(CreateWarningEvent( FD_IncomingWarnings.Stalkers, index++ ))
	wave1.append(CreateDroppodStalkerEvent(< 1000, -3102 , 127 >,"midNear",index++))
	wave1.append(CreateWaitForTimeEvent(1.0,index++))
	wave1.append(CreateDroppodGruntEvent(< 177, 3409, 120 >,"leftFar0",index++))
	wave1.append(CreateWaitForTimeEvent(1.0,index++))
	wave1.append(CreateDroppodStalkerEvent(< 2295, -2782, -45 >,"rightFar02",index++))
	wave1.append(CreateWaitForTimeEvent(1.0,index++))
	wave1.append(CreateDroppodGruntEvent(< 2488, 3691, -101 >,"leftFar1",index++))
	wave1.append(CreateWaitForTimeEvent(1.0,index++))
	wave1.append(CreateDroppodStalkerEvent(< -485, -1377, 256 >,"midNear",index++))
	wave1.append(CreateWaitForTimeEvent(1.0,index++))
	wave1.append(CreateDroppodGruntEvent(< -774, -3387, 144 >,"midHalfway_infantry",index++))
	wave1.append(CreateWaitForTimeEvent(1.0,index++))
	wave1.append(CreateWaitUntilAliveEvent( 6, index++ ) )
	wave1.append(CreateDroppodGruntEvent(< -1811, 1345, 84 >,"leftHalfway_infantry",index++))
	wave1.append(CreateWaitForTimeEvent(1.0,index++))
	wave1.append(CreateDroppodStalkerEvent(< 2336, -1184, -75 >,"midNear",index++))
	wave1.append(CreateWaitForTimeEvent(1.0,index++))
	wave1.append(CreateDroppodGruntEvent(< -1803, 3370, 84 >,"leftHalfway_infantry",index++))
	wave1.append(CreateWaitForTimeEvent(1.0,index++))
	wave1.append(CreateDroppodStalkerEvent(< 1105, -1909, 240 >,"midNear",index++))
	wave1.append(CreateWaitForTimeEvent(1.0,index++))
	wave1.append(CreateDroppodGruntEvent(< -695, 2408, 128 >,"leftHalfway_infantry",index++))
	wave1.append(CreateWaitForTimeEvent(1.0,index++))
	wave1.append(CreateDroppodStalkerEvent(< -591, -1787, 240 >,"midNear",index++))
	wave1.append(CreateWaitForTimeEvent(1.0,index++))
	wave1.append(CreateSuperSpectreEvent(< 2720, -3720, -51 >,< 0, 90, 0 >,"rightFar01",index++))
	wave1.append(CreateWaitForTimeEvent(1.0,index++))
	wave1.append(CreateWaitUntilAliveEvent( 6, index++ ) )
	wave1.append(CreateDroppodGruntEvent(< -354, -1161, 256 >,"infantyPerch_right3",index++))
	wave1.append(CreateWaitForTimeEvent(0.8,index++))
	wave1.append(CreateDroppodGruntEvent(< 1173, 1859, 258 >,"leftNear",index++))
	wave1.append(CreateWaitForTimeEvent(0.8,index++))
	wave1.append(CreateDroppodGruntEvent(< 488, 1548, 256 >,"leftNear",index++))
	wave1.append(CreateWaitForTimeEvent(0.8,index++))
	wave1.append(CreateDroppodStalkerEvent(< 919, -966, 255 >,"midNear",index++))
	wave1.append(CreateWaitForTimeEvent(0.8,index++))
	wave1.append(CreateDroppodStalkerEvent(< 728, 3312, 81 >,"leftFar1",index++))
	wave1.append(CreateWaitForTimeEvent(0.8,index++))
	wave1.append(CreateDroppodStalkerEvent(< -1202, 2671, 74 >,"leftFar0",index++))
	wave1.append(CreateWaitForTimeEvent(0.8,index++))
	wave1.append(CreateDroppodStalkerEvent(< 211, -3057, 165 >,"right_infantry",index++))
	wave1.append(CreateWaitForTimeEvent(1.0,index++))
	wave1.append(CreateWaitUntilAliveEvent( 6, index++ ) )
	wave1.append(CreateDroppodGruntEvent(< -1844, -2248, 101 >,"midHalfway_infantry",index++))
	wave1.append(CreateWaitForTimeEvent(0.5,index++))
	wave1.append(CreateDroppodGruntEvent(< 1173, 1859, 258 >,"leftNear",index++))
	wave1.append(CreateWaitForTimeEvent(0.5,index++))
	wave1.append(CreateDroppodGruntEvent(< -1198, 1588, 208 >,"leftHalfway_infantry",index++))
	wave1.append(CreateWaitForTimeEvent(0.5,index++))
	wave1.append(CreateDroppodGruntEvent(< 2488, 3691, -101 >,"leftFar1",index++))
	wave1.append(CreateWaitForTimeEvent(0.5,index++))
	wave1.append(CreateDroppodGruntEvent(< 1000, -3102, 127 >,"right_infantry",index++))
	wave1.append(CreateWaitForTimeEvent(0.5,index++))
	wave1.append(CreateSuperSpectreEvent(< 636, 3499, 81 >,< 0, -90, 0 >,"leftFar0",index++))
	wave1.append(CreateWaitForTimeEvent(1.0,index++))
	wave1.append(CreateWaitUntilAliveEvent( 6, index++ ) )
	wave1.append(CreateDroppodGruntEvent(< 1291, 1519, 256 >,"leftNear",index++))
	wave1.append(CreateWaitForTimeEvent(0.5,index++))
	wave1.append(CreateDroppodGruntEvent(< -774, -3387, 144 >,"midHalfway_infantry",index++))
	wave1.append(CreateWaitForTimeEvent(0.4,index++))
	wave1.append(CreateDroppodGruntEvent(< -354, -1161, 256 >,"infantyPerch_right3",index++))
	wave1.append(CreateWaitForTimeEvent(0.3,index++))
	wave1.append(CreateDroppodGruntEvent(< 488, 1548, 256 >,"leftNear",index++))
	wave1.append(CreateWaitForTimeEvent(0.2,index++))
	wave1.append(CreateDroppodGruntEvent(< 177, 3409, 120 >,"leftFar0",0))
	waveEvents.append(wave1)
	index = 1
    array<WaveEvent> wave2
	wave2.append(CreateSmokeEvent(< 1236, 2449, 82 >, 90, index++))
	wave2.append(CreateWaitForTimeEvent(1.0,index++))
	wave2.append(CreateSmokeEvent(< -305, 1646, 256 >, 90, index++))
	wave2.append(CreateWaitForTimeEvent(1.0,index++))
	wave2.append(CreateWarningEvent( FD_IncomingWarnings.Ticks, index++ ))
	wave2.append(CreateDroppodTickEvent(< 1605 , 3012 , 86 >, 4, "leftFar0", index++ ) )
	wave2.append(CreateWaitForTimeEvent(1.2,index++))
	wave2.append(CreateDroppodTickEvent(< 570 , 2765 , 76 >, 4, "leftFar0", index++ ) )
	wave2.append(CreateWaitForTimeEvent(1.0,index++))
	wave2.append(CreateDroppodTickEvent(< 1053 , 3099 , 96 >, 4, "leftFar0", index++ ) )
	wave2.append(CreateWaitForTimeEvent(0.8,index++))
	wave2.append(CreateDroppodTickEvent(< 1299 , 2639 , 84 >, 4, "leftFar0", index++ ) )
	wave2.append(CreateWaitForTimeEvent(1.0,index++))
	wave2.append(CreateWaitUntilAliveEvent( 6, index++ ) )
	wave2.append(CreateDroppodTickEvent(< -1693 , 2672 , 92 >, 4, "leftFar0", index++ ) )
	wave2.append(CreateWaitForTimeEvent(0.6,index++))
	wave2.append(CreateDroppodTickEvent(< -2033 , 3516 , 126 >, 4, "leftFar0", index++ ) )
	wave2.append(CreateWaitForTimeEvent(0.8,index++))
	wave2.append(CreateDroppodTickEvent(< -1445 , 3084 , 112 >, 4, "leftFar0", index++ ) )
	wave2.append(CreateWaitForTimeEvent(1.0,index++))
	wave2.append(CreateDroppodTickEvent(< -923 , 3165 , 177 >, 4, "leftFar0", index++ ) )
	wave2.append(CreateWaitForTimeEvent(1.0,index++))
	wave2.append(CreateWaitUntilAliveEvent( 6, index++ ) )
	wave2.append(CreateDroppodTickEvent(< 1106 , 5144 , 251 >, 4, "leftFar0", index++ ) )
	wave2.append(CreateWaitForTimeEvent(0.5,index++))
	wave2.append(CreateDroppodTickEvent(< 1410 , 4322 , 142 >, 4, "leftFar0", index++ ) )
	wave2.append(CreateWaitForTimeEvent(0.5,index++))
	wave2.append(CreateDroppodTickEvent(< 422 , 4292 , 124 >, 4, "leftFar0", index++ ) )
	wave2.append(CreateWaitForTimeEvent(0.5,index++))
	wave2.append(CreateDroppodTickEvent(< 776 , 4689 , 223 >, 4, "leftFar0", index++ ) )
	wave2.append(CreateWaitForTimeEvent(1.0,index++))
	wave2.append(CreateWaitUntilAliveEvent( 6, index++ ) )
	wave2.append(CreateDroppodStalkerEvent(< -481, -1272, 256 >,"midNear",index++))
	wave2.append(CreateWaitForTimeEvent(0.5,index++))
	wave2.append(CreateDroppodTickEvent(< 1053 , 3099 , 96 >, 4, "leftFar0", index++ ) )
	wave2.append(CreateWaitForTimeEvent(1.0,index++))
	wave2.append(CreateDroppodTickEvent(< 570 , 2765 , 76 >, 4, "leftFar0", index++ ) )
	wave2.append(CreateWaitForTimeEvent(1.5,index++))
	wave2.append(CreateSuperSpectreEvent(< 636, 3499, 81 >,< 0, -90, 0 >,"leftFar0",index++))
	wave2.append(CreateWaitForTimeEvent(2.0,index++))
	wave2.append(CreateWarningEvent( FD_IncomingWarnings.EnemyTitansIncoming, index++ ))
	wave2.append(CreateToneSniperTitanEvent(< 3313, -527, -70 >,< 0, 180, 0 >,index++))
	wave2.append(CreateWaitForTimeEvent(1.5,index++))
	wave2.append(CreateDroppodTickEvent(< 1605 , 3012 , 86 >, 4, "leftFar0", index++ ) )
	wave2.append(CreateWaitForTimeEvent(1.0,index++))
	wave2.append(CreateDroppodTickEvent(< 1299 , 2639 , 84 >, 4, "leftFar0", index++ ) )
	wave2.append(CreateWaitForTimeEvent(1.0,index++))
	wave2.append(CreateWaitUntilAliveEvent( 4, index++ ) )
	wave2.append(CreateDroppodStalkerEvent(< 1178, 1370, 256 >,"leftNear",index++))
	wave2.append(CreateWaitForTimeEvent(0.5,index++))
	wave2.append(CreateDroppodTickEvent(< -179 , -1193 , 256 >, 4, "midNear", index++ ) )
	wave2.append(CreateWaitForTimeEvent(0.8,index++))
	wave2.append(CreateDroppodTickEvent(< -520 , -1109 , 256 >, 4, "midNear", index++ ) )
	wave2.append(CreateWaitForTimeEvent(1.0,index++))
	wave2.append(CreateSuperSpectreEvent(< 2226, -3592, -64 >,< 0, 90, 0 >,"rightFar02",index++))
	wave2.append(CreateWaitForTimeEvent(2.0,index++))
	wave2.append(CreateToneSniperTitanEvent(< 210, 3401, 120 >,< 0, -55, 0 >,index++))
	wave2.append(CreateWaitForTimeEvent(1.0,index++))
	wave2.append(CreateDroppodTickEvent(< -467 , -1788 , 240 >, 4, "midNear", index++ ) )
	wave2.append(CreateWaitForTimeEvent(0.5,index++))
	wave2.append(CreateDroppodTickEvent(< 924 , -1128 , 256 >, 4, "midNear", index++ ) )
	wave2.append(CreateWaitForTimeEvent(1.0,index++))
	wave2.append(CreateWaitUntilAliveEvent( 4, index++ ) )
	wave2.append(CreateRoninTitanEvent(< -1809, 1301, 84 >,< 0, -90, 0 >,"rightSwitchShort1",index++))
	wave2.append(CreateWaitForTimeEvent(1.5,index++))
	wave2.append(CreateRoninTitanEvent(< -1784, -1113, 101 >,< 0, -90, 0 >,"rightSwitchShort1",index++))
	wave2.append(CreateWaitForTimeEvent(2.5,index++))
	wave2.append(CreateDroppodTickEvent(< 1053 , 3099 , 96 >, 4, "leftFar0", index++ ) )
	wave2.append(CreateWaitForTimeEvent(0.5,index++))
	wave2.append(CreateDroppodTickEvent(< 1299 , 2639 , 84 >, 4, "leftFar0", index++ ) )
	wave2.append(CreateWaitForTimeEvent(0.5,index++))
	wave2.append(CreateDroppodGruntEvent(< 1638, -2005, 240 >,"rightHalfway_infantry",index++))
	wave2.append(CreateWaitForTimeEvent(2.5,index++))
	wave2.append(CreateMortarTitanEvent(< 1268, -3696, 144 >,< 0, 90, 0 >,index++))
	wave2.append(CreateWaitForTimeEvent(1.0,index++))
	wave2.append(CreateWaitUntilAliveEvent( 6, index++ ) )
	wave2.append(CreateDroppodTickEvent(< 1605 , 3012 , 86 >, 4, "leftFar0", index++ ) )
	wave2.append(CreateWaitForTimeEvent(0.3,index++))
	wave2.append(CreateDroppodTickEvent(< -179 , -1193 , 256 >, 4, "midNear", index++ ) )
	wave2.append(CreateWaitForTimeEvent(0.5,index++))
	wave2.append(CreateDroppodTickEvent(< -1693 , 2672 , 92 >, 4, "leftFar0", index++ ) )
	wave2.append(CreateWaitForTimeEvent(1.5,index++))
	wave2.append(CreateMortarTitanEvent(< -1808, -1112, 101 >,< 0, 0, 0 >,index++))
	wave2.append(CreateWaitForTimeEvent(0.5,index++))
	wave2.append(CreateDroppodTickEvent(< 1106 , 5144 , 251 >, 4, "leftFar0", index++ ) )
	wave2.append(CreateWaitForTimeEvent(0.5,index++))
	wave2.append(CreateMortarTitanEvent(< -1820, 1308, 84 >,< 0, 0, 0 >,index++))
	wave2.append(CreateWaitForTimeEvent(0.5,index++))
	wave2.append(CreateDroppodTickEvent(< 1053 , 3099 , 96 >, 4, "leftFar0", 0 ) )
	waveEvents.append(wave2)
	index = 1
    array<WaveEvent> wave3
	wave3.append(CreateDroppodStalkerEvent(< 1105, -1909, 240 >,"midNear",index++))
	wave3.append(CreateWaitForTimeEvent(0.5,index++))
	wave3.append(CreateDroppodStalkerEvent(< -1202, 2671, 74 >,"leftFar0",index++))
	wave3.append(CreateWaitForTimeEvent(0.5,index++))
	wave3.append(CreateDroppodStalkerEvent(< 211, -3057, 165 >,"right_infantry",index++))
	wave3.append(CreateWaitForTimeEvent(1.5,index++))
	wave3.append(CreateSuperSpectreEvent(< 636, 3499, 81 >,< 0, -90, 0 >,"leftFar0",index++))
	wave3.append(CreateWaitForTimeEvent(1.5,index++))
	wave3.append(CreateSuperSpectreEvent(< 2226, -3592, -64 >,< 0, 90, 0 >,"rightFar02",index++))
	wave3.append(CreateWaitForTimeEvent(1.0,index++))
	wave3.append(CreateWaitUntilAliveEvent( 2, index++ ) )
	wave3.append(CreateDroppodStalkerEvent(< 919, -966, 255 >,"midNear",index++))
	wave3.append(CreateWaitForTimeEvent(0.5,index++))
	wave3.append(CreateDroppodStalkerEvent(< 1000, -3102 , 127 >,"midNear",index++))
	wave3.append(CreateWaitForTimeEvent(0.5,index++))
	wave3.append(CreateDroppodStalkerEvent(< 728, 3312, 81 >,"leftFar1",index++))
	wave3.append(CreateWaitForTimeEvent(2.5,index++))
	wave3.append(CreateMonarchTitanEvent(< 3380, 2238, -47 >,< 0, 180, 0 >,"leftFar1",index++))
	wave3.append(CreateWaitForTimeEvent(2.5,index++))
	wave3.append(CreateWarningEvent( FD_IncomingWarnings.ReaperAlt, index++ ))
	wave3.append(CreateSuperSpectreEvent(< 2720, -3720, -51 >,< 0, 90, 0 >,"rightFar01",index++))
	wave3.append(CreateWaitForTimeEvent(1.5,index++))
	wave3.append(CreateSuperSpectreEvent(< 3372, -416, -72 >,< 0, -145, 0 >,"rightFar01",index++))
	wave3.append(CreateWaitForTimeEvent(1.5,index++))
	wave3.append(CreateSuperSpectreEventWithMinion(< 313, 3391, 120 >,< 0, -90, 0 >,"",index++))
	wave3.append(CreateWaitForTimeEvent(1.5,index++))
	wave3.append(CreateSuperSpectreEventWithMinion(< 3396, 2393, -47 >,< 0, 180, 0 >,"",index++))
	wave3.append(CreateWaitForTimeEvent(1.0,index++))
	wave3.append(CreateWaitUntilAliveEvent( 2, index++ ) )
	wave3.append(CreateDroppodStalkerEvent(< -485, -1377, 256 >,"midNear",index++))
	wave3.append(CreateWaitForTimeEvent(0.4,index++))
	wave3.append(CreateDroppodStalkerEvent(< 2295, -2782, -45 >,"rightFar02",index++))
	wave3.append(CreateWaitForTimeEvent(0.2,index++))
	wave3.append(CreateDroppodGruntEvent(< -354, -1161, 256 >,"infantyPerch_right3",index++))
	wave3.append(CreateWaitForTimeEvent(2.5,index++))
	wave3.append(CreateLegionTitanEvent(< -1782, -2253, 101 >,< 0, -90, 0 >,"leftSwitchShort02",index++))
	wave3.append(CreateWaitForTimeEvent(2.5,index++))
	wave3.append(CreateSmokeEvent(< 1236, 2449, 82 >, 90, index++))
	wave3.append(CreateWaitForTimeEvent(0.5,index++))
	wave3.append(CreateSmokeEvent(< -305, 1646, 256 >, 90, index++))
	wave3.append(CreateWaitForTimeEvent(0.5,index++))
	wave3.append(CreateSmokeEvent(< 2181, -963, -39 >, 90, index++))
	wave3.append(CreateWaitForTimeEvent(0.5,index++))
	wave3.append(CreateSmokeEvent(< -523, -2326, 240 >, 90, index++))
	wave3.append(CreateWaitForTimeEvent(0.5,index++))
	wave3.append(CreateWarningEvent( FD_IncomingWarnings.ComboArcNuke, index++ ))
	wave3.append(CreateArcTitanEvent(< 2775, -3683, -66 >,< 0, 90, 0 >,"rightFar01",index++))
	wave3.append(CreateWaitForTimeEvent(1.5,index++))
	wave3.append(CreateArcTitanEvent(< 2704, 3655, -111 >,< 0, -90, 0 >,"leftFar1",index++))
	wave3.append(CreateWaitForTimeEvent(5.0,index++))
	wave3.append(CreateNukeTitanEvent(< -1225, 3397, 179 >,< 0, -90, 0 >,"leftFar0",index++))
	wave3.append(CreateWaitForTimeEvent(1.0,index++))
	wave3.append(CreateWaitUntilAliveEvent( 4, index++ ) )
	wave3.append(CreateIonTitanEvent(< 1239, -3684, 146 >,< 0, 180, 0 >,"rightFar02",index++))
	wave3.append(CreateWaitForTimeEvent(1.5,index++))
	wave3.append(CreateDroppodStalkerEvent(< 2336, -1184, -75 >,"midNear",index++))
	wave3.append(CreateWaitForTimeEvent(3.5,index++))
	wave3.append(CreateNukeTitanEvent(< -442, -3685, 144 >,< 0, 90, 0 >,"rightNear",index++))
	wave3.append(CreateWaitForTimeEvent(1.5,index++))
	wave3.append(CreateDroppodStalkerEvent(< -481, -1272, 256 >,"midNear",index++))
	wave3.append(CreateWaitForTimeEvent(0.5,index++))
	wave3.append(CreateSuperSpectreEvent(< 501, -3710, 144 >,< 0, -145, 0 >,"rightNear",index++))
	wave3.append(CreateWaitForTimeEvent(0.5,index++))
	wave3.append(CreateDroppodStalkerEvent(< -591, -1787, 240 >,"midNear",index++))
	wave3.append(CreateWaitForTimeEvent(1.0,index++))
	wave3.append(CreateWaitUntilAliveEvent( 8, index++ ) )
	wave3.append(CreateNukeTitanEvent(< 2621, 3662, -111 >,< 0, -90, 0 >,"leftFar1",index++))
	wave3.append(CreateWaitForTimeEvent(5.0,index++))
	wave3.append(CreateArcTitanEvent(< 3382, 3304, -47 >,< 0, 180, 0 >,"leftFar1",index++))
	wave3.append(CreateWaitForTimeEvent(5.0,index++))
	wave3.append(CreateNukeTitanEvent(< 3356, -365, -65 >,< 0, -180, 0 >,"rightFar02",index++))
	wave3.append(CreateWaitForTimeEvent(1.5,index++))
	wave3.append(CreateSuperSpectreEventWithMinion(< -1815, 1375, 84 >,< 0, 90, 0 >,"",index++))
	wave3.append(CreateWaitForTimeEvent(2.5,index++))
	wave3.append(CreateArcTitanEvent(< -1883, 3478, 84 >,< 0, -90, 0 >,"rightSwitchShort1",index++))
	wave3.append(CreateWaitForTimeEvent(1.5,index++))
	wave3.append(CreateSuperSpectreEventWithMinion(< -549, -3730, 144 >,< 0, 90, 0 >,"",index++))
	wave3.append(CreateWaitForTimeEvent(2.5,index++))
	wave3.append(CreateArcTitanEvent(< -1830, -1105, 101 >,< 0, 0, 0 >,"leftSwitchShort02",0))
	waveEvents.append(wave3)
	index = 1
    array<WaveEvent> wave4
	wave4.append(CreateSpawnDroneEvent(< 3596, -5433, 256 >,< 0 , 90 , 0 >,"rightDrone01",index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateSpawnDroneEvent(< 2563, -5827, 256 >,< 0 , 90 , 0 >,"rightDrone01",index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateSpawnDroneEvent(< 1477, -6026, 256 >,< 0 , 90 , 0 >,"rightDrone02",index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateSpawnDroneEvent(< 62, -6254, 256 >,< 0 , 90 , 0 >,"rightDrone03",index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateSpawnDroneEvent(< -600, -6465, 256 >,< 0 , 90 , 0 >,"rightDrone04",index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateSmokeEvent(< 450, -1024, 256 >, 90, index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateWaitUntilAliveEvent( 12, index++ ) )
	wave4.append(CreateSpawnDroneEvent(< 3596, -5433, 256 >,< 0 , 90 , 0 >,"rightDrone01",index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateSpawnDroneEvent(< 2563, -5827, 256 >,< 0 , 90 , 0 >,"rightDrone01",index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateSpawnDroneEvent(< 1477, -6026, 256 >,< 0 , 90 , 0 >,"rightDrone02",index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateSpawnDroneEvent(< 62, -6254, 256 >,< 0 , 90 , 0 >,"rightDrone03",index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateSpawnDroneEvent(< -600, -6465, 256 >,< 0 , 90 , 0 >,"rightDrone04",index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateWaitUntilAliveEvent( 8, index++ ) )
	wave4.append(CreateWarningEvent( FD_IncomingWarnings.Reaper, index++ ))
	wave4.append(CreateSuperSpectreEvent(< -1842, 3301, 86 >,< 0, -35, 0 >,"leftFar0",index++))
	wave4.append(CreateWaitForTimeEvent(0.8,index++))
	wave4.append(CreateSuperSpectreEvent(< -2271, 2787, 152 >,< 0, 0, 0 >,"leftFar0",index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateSuperSpectreEventWithMinion(< -1842, 3301, 86 >,< 0, -90, 0 >,"",index++))
	wave4.append(CreateWaitForTimeEvent(1.2,index++))
	wave4.append(CreateToneSniperTitanEvent(< 210, 3401, 120 >,< 0, -55, 0 >,index++))
	wave4.append(CreateWaitForTimeEvent(5.0,index++))
	wave4.append(CreateSpawnDroneEvent(< 62, -6254, 256 >,< 0 , 90 , 0 >,"rightDrone03",index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateSuperSpectreEvent(< 2967, -3395, -73 >,< 0, 90, 0 >,"rightFar01",index++))
	wave4.append(CreateWaitForTimeEvent(0.8,index++))
	wave4.append(CreateSuperSpectreEvent(< 2386, -3242, -72 >,< 0, 90, 0 >,"rightFar01",index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateSuperSpectreEventWithMinion(< 1795, -3741, 26 >,< 0, 90, 0 >,"rightFar01",index++))
	wave4.append(CreateWaitForTimeEvent(1.2,index++))
	wave4.append(CreateToneSniperTitanEvent(< 3313, -527, -70 >,< 0, 180, 0 >,index++))
	wave4.append(CreateWaitForTimeEvent(5.0,index++))
	wave4.append(CreateSpawnDroneEvent(< 2563, -5827, 256 >,< 0 , 90 , 0 >,"rightDrone01",index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateNukeTitanEvent(< -442, -3685, 144 >,< 0, 90, 0 >,"rightNear",index++))
	wave4.append(CreateWaitForTimeEvent(4.0,index++))
	wave4.append(CreateCloakDroneEvent(< 2629, -5409, 2560 >,< 0 , 0 , 0 >,index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateCloakDroneEvent(< 632, 3000, 2560 >,< 0 , 0 , 0 >,index++))
	wave4.append(CreateWaitForTimeEvent(2.0,index++))
	wave4.append(CreateDroppodStalkerEvent(< 1291, 1519, 256 >,"leftNear",index++))
	wave4.append(CreateWaitForTimeEvent(0.3,index++))
	wave4.append(CreateDroppodStalkerEvent(< 857, 2639, 83 >,"leftNear",index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateWaitUntilAliveEvent( 6, index++ ) )
	wave4.append(CreateSuperSpectreEvent(< 3413, 3326, -48 >,< 0, 180, 0 >,"leftFar1",index++))
	wave4.append(CreateWaitForTimeEvent(0.8,index++))
	wave4.append(CreateSuperSpectreEvent(< 2778, 3681, -112 >,< 0, 225, 0 >,"leftFar1",index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateSuperSpectreEventWithMinion(< 1700, 3413, 95 >,< 0, -90, 0 >,"",index++))
	wave4.append(CreateWaitForTimeEvent(1.2,index++))
	wave4.append(CreateWarningEvent( FD_IncomingWarnings.EliteTitan, index++ ))
	wave4.append(CreateMonarchTitanEvent(< 3397, 2145, -48 >,< 0, 180, 0 >,"leftFar1",index++,1,"",FD_TitanType.TITAN_ELITE))
	wave4.append(CreateWaitForTimeEvent(5.0,index++))
	wave4.append(CreateSuperSpectreEvent(< -762, -3475, 144 >,< 0, 90, 0 >,"rightNear",index++))
	wave4.append(CreateWaitForTimeEvent(0.8,index++))
	wave4.append(CreateSuperSpectreEvent(< 255, -2990, 164 >,< 0, 180, 0 >,"rightNear",index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateSuperSpectreEventWithMinion(< -269, -2948, 164 >,< 0, 90, 0 >,"",index++))
	wave4.append(CreateWaitForTimeEvent(1.2,index++))
	wave4.append(CreateSpawnDroneEvent(< 62, -6254, 256 >,< 0 , 90 , 0 >,"rightDrone03",index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateSpawnDroneEvent(< 1477, -6026, 256 >,< 0 , 90 , 0 >,"rightDrone02",index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateSpawnDroneEvent(< -600, -6465, 256 >,< 0 , 90 , 0 >,"rightDrone04",index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateRoninTitanEvent(< -6, -3462, 121 >,< 0, 90, 0 >,"rightNear",index++,1,"",FD_TitanType.TITAN_ELITE))
	wave4.append(CreateWaitForTimeEvent(5.0,index++))
	wave4.append(CreateDroppodStalkerEvent(< 1000, -3102 , 127 >,"midNear",index++))
	wave4.append(CreateWaitForTimeEvent(0.3,index++))
	wave4.append(CreateDroppodStalkerEvent(< 1105, -1909, 240 >,"midNear",index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateWaitUntilAliveEvent( 6, index++ ) )
	wave4.append(CreateSuperSpectreEvent(< 2573, 3587, -107 >,< 0, -90, 0 >,"leftFar1",index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateDroppodStalkerEvent(< 919, -966, 255 >,"midNear",index++))
	wave4.append(CreateWaitForTimeEvent(0.8,index++))
	wave4.append(CreateSuperSpectreEventWithMinion(< 1690, 3417, 95 >,< 0, -90, 0 >,"",index++))
	wave4.append(CreateWaitForTimeEvent(0.6,index++))
	wave4.append(CreateDroppodStalkerEvent(< -402, -2545, 188 >,"rightNear",index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateSuperSpectreEvent(< -2026, 3459, 122 >,< 0, -90, 0 >,"leftFar0",index++))
	wave4.append(CreateWaitForTimeEvent(0.8,index++))
	wave4.append(CreateDroppodStalkerEvent(< 211, -3057, 165 >,"right_infantry",index++))
	wave4.append(CreateWaitForTimeEvent(0.6,index++))
	wave4.append(CreateSuperSpectreEventWithMinion(< -1443, 3438, 216 >,< 0, -90, 0 >,"",index++))
	wave4.append(CreateWaitForTimeEvent(2.0,index++))
	wave4.append(CreateSuperSpectreEventWithMinion(< 650, 3542, 82 >,< 0, -90, 0 >,"",index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateDroppodGruntEvent(< -354, -1161, 256 >,"infantyPerch_right3",index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateWaitUntilAliveEvent( 4, index++ ) )
	wave4.append(CreateSpawnDroneEvent(< 3596, -5433, 256 >,< 0 , 90 , 0 >,"rightDrone01",index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateSpawnDroneEvent(< 1477, -6026, 256 >,< 0 , 90 , 0 >,"rightDrone02",index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateSpawnDroneEvent(< 62, -6254, 256 >,< 0 , 90 , 0 >,"rightDrone03",index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateSpawnDroneEvent(< -600, -6465, 256 >,< 0 , 90 , 0 >,"rightDrone04",index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateSpawnDroneEvent(< 1477, -6026, 256 >,< 0 , 90 , 0 >,"rightDrone02",index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateWaitUntilAliveEvent( 10, index++ ) )
	wave4.append(CreateIonTitanEvent(< 2970, -3597, -68 >,< 0, 90, 0 >,"rightNear",index++,1,"",FD_TitanType.TITAN_ELITE))
	wave4.append(CreateWaitForTimeEvent(0.5,index++))
	wave4.append(CreateIonTitanEvent(< 2521, -3597, -68 >,< 0, 90, 0 >,"rightNear",index++,1,"",FD_TitanType.TITAN_ELITE))
	wave4.append(CreateWaitForTimeEvent(2.5,index++))
	wave4.append(CreateSuperSpectreEvent(< 3648, 1286, 0 >,< 0, 180, 0 >,"rightFar01",index++))
	wave4.append(CreateWaitForTimeEvent(0.5,index++))
	wave4.append(CreateSuperSpectreEvent(< 3648, 2037, 0 >,< 0, 180, 0 >,"rightFar01",index++))
	wave4.append(CreateWaitForTimeEvent(1.5,index++))
	wave4.append(CreateSuperSpectreEvent(< 1505, 3090, 95 >,< 0, 90, 0 >,"leftNear",index++))
	wave4.append(CreateWaitForTimeEvent(0.5,index++))
	wave4.append(CreateSuperSpectreEvent(< 1086, 3090, 96 >,< 0, 90, 0 >,"leftNear",index++))
	wave4.append(CreateWaitForTimeEvent(2.5,index++))
	wave4.append(CreateToneTitanEvent(< -1785, -2252, 101 >,< 0, 90, 0 >,"rightNear",index++,1,"",FD_TitanType.TITAN_ELITE))
	wave4.append(CreateWaitForTimeEvent(2.5,index++))
	wave4.append(CreateSpawnDroneEvent(< 1477, -6026, 256 >,< 0 , 90 , 0 >,"rightDrone02",index++))
	wave4.append(CreateWaitForTimeEvent(1.0,index++))
	wave4.append(CreateSpawnDroneEvent(< 3596, -5433, 256 >,< 0 , 90 , 0 >,"rightDrone01",0))
	waveEvents.append(wave4)
	index = 1
    array<WaveEvent> wave5
	wave5.append(CreateArcTitanEvent(< 1722, -3681, 50 >,< 0, 90, 0 >,"rightFar01",index++))
	wave5.append(CreateWaitForTimeEvent(2.0,index++))
	wave5.append(CreateArcTitanEvent(< -1867, 3529, 86 >,< 0, -90, 0 >,"leftFar0",index++))
	wave5.append(CreateWaitForTimeEvent(2.0,index++))
	wave5.append(CreateArcTitanEvent(< -2261, 3078, 152 >,< 0, -90, 0 >,"rightSwitchLong1",index++))
	wave5.append(CreateWaitForTimeEvent(5.0,index++))
	wave5.append(CreateMonarchTitanEvent(< 3400, 1243, -65 >,< 0, 180, 0 >,"midFar",index++,1,"",FD_TitanType.TITAN_ELITE))
	wave5.append(CreateWaitForTimeEvent(2.5,index++))
	wave5.append(CreateIonTitanEvent(< 3644, 2023, 0 >,< 0, 180, 0 >,"midFar",index++,1,"",FD_TitanType.TITAN_ELITE))
	wave5.append(CreateWaitForTimeEvent(5.0,index++))
	wave5.append(CreateLegionTitanEvent(< 151, 3402, 121 >,< 0, -90, 0 >,"leftFar1",index++,1,"",FD_TitanType.TITAN_ELITE))
	wave5.append(CreateWaitForTimeEvent(1.5,index++))
	wave5.append(CreateToneTitanEvent(< 613, 3522, 83 >,< 0, -90, 0 >,"leftFar1",index++,1,"",FD_TitanType.TITAN_ELITE))
	wave5.append(CreateWaitForTimeEvent(2.5,index++))
	wave5.append(CreateNukeTitanEvent(< 2756, -3626, -71 >,< 0, 90, 0 >,"rightFar01",index++))
	wave5.append(CreateWaitForTimeEvent(4.0,index++))
	wave5.append(CreateCloakDroneEvent(< 2756, -3626, 2560 >,< 0 , 0 , 0 >,index++))
	wave5.append(CreateWaitForTimeEvent(1.0,index++))
	wave5.append(CreateDroppodGruntEvent(< -1786, -2257, 101 >,"midHalfway_infantry",index++))
	wave5.append(CreateWaitForTimeEvent(1.0,index++))
	wave5.append(CreateWaitUntilAliveEvent( 2, index++ ) )
	wave5.append(CreateArcTitanEvent(< 3417, 3310, -46 >,< 0, 180, 0 >,"rightSwitchLong2",index++))
	wave5.append(CreateWaitForTimeEvent(2.0,index++))
	wave5.append(CreateArcTitanEvent(< 3417, 3689, -46 >,< 0, 180, 0 >,"rightSwitchLong2",index++))
	wave5.append(CreateWaitForTimeEvent(2.0,index++))
	wave5.append(CreateArcTitanEvent(< -442, -3685, 144 >,< 0, 90, 0 >,"rightNear",index++))
	wave5.append(CreateWaitForTimeEvent(5.0,index++))
	wave5.append(CreateRoninTitanEvent(< -1909, 3657, 85 >,< 0, -90, 0 >,"rightSwitchShort1",index++,1,"",FD_TitanType.TITAN_ELITE))
	wave5.append(CreateWaitForTimeEvent(2.5,index++))
	wave5.append(CreateRoninTitanEvent(< -1909, 3373, 86 >,< 0, -90, 0 >,"rightSwitchShort1",index++,1,"",FD_TitanType.TITAN_ELITE))
	wave5.append(CreateWaitForTimeEvent(5.0,index++))
	wave5.append(CreateToneSniperTitanEvent(< 3313, -527, -70 >,< 0, 180, 0 >,index++,1,"",FD_TitanType.TITAN_ELITE))
	wave5.append(CreateWaitForTimeEvent(2.5,index++))
	wave5.append(CreateToneSniperTitanEvent(< 1721, 3440, 95 >,< 0, -90, 0 >,index++,1,"",FD_TitanType.TITAN_ELITE))
	wave5.append(CreateWaitForTimeEvent(2.5,index++))
	wave5.append(CreateDroppodGruntEvent(< -354, -1161, 256 >,"infantyPerch_right3",index++))
	wave5.append(CreateWaitForTimeEvent(1.0,index++))
	wave5.append(CreateWaitUntilAliveEvent( 2, index++ ) )
	wave5.append(CreateScorchTitanEvent(< 2970, -3597, -68 >,< 0, 90, 0 >,"rightFar01",index++,1,"",FD_TitanType.TITAN_ELITE))
	wave5.append(CreateWaitForTimeEvent(0.5,index++))
	wave5.append(CreateScorchTitanEvent(< 2521, -3597, -68 >,< 0, 90, 0 >,"rightFar01",index++,1,"",FD_TitanType.TITAN_ELITE))
	wave5.append(CreateWaitForTimeEvent(7.0,index++))
	wave5.append(CreateArcTitanEvent(< 2970, -3597, -68 >,< 0, 90, 0 >,"rightFar01",index++))
	wave5.append(CreateWaitForTimeEvent(1.5,index++))
	wave5.append(CreateArcTitanEvent(< 2521, -3597, -68 >,< 0, 90, 0 >,"rightFar01",index++))
	wave5.append(CreateWaitForTimeEvent(7.0,index++))
	wave5.append(CreateArcTitanEvent(< -1909, 3657, 85 >,< 0, -90, 0 >,"rightSwitchLong1",index++))
	wave5.append(CreateWaitForTimeEvent(1.5,index++))
	wave5.append(CreateArcTitanEvent(< -1909, 3373, 86 >,< 0, -90, 0 >,"rightSwitchLong1",index++))
	wave5.append(CreateWaitForTimeEvent(5.0,index++))
	wave5.append(CreateSuperSpectreEventWithMinion(< 2967, -3395, -73 >,< 0, 90, 0 >,"",index++))
	wave5.append(CreateWaitForTimeEvent(1.5,index++))
	wave5.append(CreateSuperSpectreEventWithMinion(< 2386, -3242, -72 >,< 0, 90, 0 >,"",index++))
	wave5.append(CreateWaitForTimeEvent(2.5,index++))
	wave5.append(CreateNukeTitanEvent(< 2621, 3662, -111 >,< 0, -90, 0 >,"leftFar1",index++))
	wave5.append(CreateWaitForTimeEvent(5.0,index++))
	wave5.append(CreateMortarTitanEvent(< -1793, -2237, 101 >,< 0, 0, 0 >,index++))
	wave5.append(CreateWaitForTimeEvent(2.5,index++))
	wave5.append(CreateMortarTitanEvent(< -1784, -1120, 101 >,< 0, 0, 0 >,index++))
	wave5.append(CreateWaitForTimeEvent(1.0,index++))
	wave5.append(CreateWaitUntilAliveEvent( 4, index++ ) )
	wave5.append(CreateArcTitanEvent(< -1909, 3657, 85 >,< 0, -90, 0 >,"leftFar0",index++))
	wave5.append(CreateWaitForTimeEvent(1.5,index++))
	wave5.append(CreateArcTitanEvent(< -1909, 3373, 86 >,< 0, -90, 0 >,"leftFar0",index++))
	wave5.append(CreateWaitForTimeEvent(3.0,index++))
	wave5.append(CreateLegionTitanEvent(< 2695, -3333, -73 >,< 0, 90, 0 >,"leftSwitchShort01",index++,1,"",FD_TitanType.TITAN_ELITE))
	wave5.append(CreateWaitForTimeEvent(0.5,index++))
	wave5.append(CreateRoninTitanEvent(< 2854, -3538, -73 >,< 0, 90, 0 >,"leftSwitchShort01",index++,1,"",FD_TitanType.TITAN_ELITE))
	wave5.append(CreateWaitForTimeEvent(0.5,index++))
	wave5.append(CreateRoninTitanEvent(< 2554, -3538, -73 >,< 0, 90, 0 >,"leftSwitchShort01",index++,1,"",FD_TitanType.TITAN_ELITE))
	wave5.append(CreateWaitForTimeEvent(5.0,index++))
	wave5.append(CreateMonarchTitanEvent(< -1793, -2237, 101 >,< 0, 0, 0 >,"rightNear",index++,1,"",FD_TitanType.TITAN_ELITE))
	wave5.append(CreateWaitForTimeEvent(1.0,index++))
	wave5.append(CreateMonarchTitanEvent(< -1784, -1120, 101 >,< 0, 0, 0 >,"rightNear",index++,1,"",FD_TitanType.TITAN_ELITE))
	wave5.append(CreateWaitForTimeEvent(1.0,index++))
	wave5.append(CreateWaitUntilAliveEvent( 2, index++ ) )
	wave5.append(CreateArcTitanEvent(< -1443 , 3100 , 124 >,< 0 , -65 , 0 >,"rightSwitchShort1",index++))
	wave5.append(CreateWaitForTimeEvent(5.0,index++))
	wave5.append(CreateArcTitanEvent(< -1867 , 3356 , 96 >,< 0 , -90 , 0 >,"rightSwitchShort1",index++))
	wave5.append(CreateWaitForTimeEvent(5.0,index++))
	wave5.append(CreateArcTitanEvent(< -2203 , 2963 , 164 >,< 0 , -35 , 0 >,"rightSwitchShort1",index++))
	wave5.append(CreateWaitForTimeEvent(5.0,index++))
	wave5.append(CreateArcTitanEvent(< -1858 , 3613 , 96 >,< 0 , -90 , 0 >,"rightSwitchShort1",index++))
	wave5.append(CreateWaitForTimeEvent(5.0,index++))
	wave5.append(CreateArcTitanEvent(< -2215 , 3278 , 164 >,< 0 , -90 , 0 >,"rightSwitchShort1",index++))
	wave5.append(CreateWaitForTimeEvent(5.0,index++))
	wave5.append(CreateArcTitanEvent(< -1443 , 3100 , 124 >,< 0 , -65 , 0 >,"rightSwitchShort1",index++))
	wave5.append(CreateWaitForTimeEvent(5.0,index++))
	wave5.append(CreateArcTitanEvent(< -1867 , 3356 , 96 >,< 0 , -90 , 0 >,"rightSwitchShort1",index++))
	wave5.append(CreateWaitForTimeEvent(5.0,index++))
	wave5.append(CreateArcTitanEvent(< -2203 , 2963 , 164 >,< 0 , -35 , 0 >,"rightSwitchShort1",index++))
	wave5.append(CreateWaitForTimeEvent(5.0,index++))
	wave5.append(CreateArcTitanEvent(< -1858 , 3613 , 96 >,< 0 , -90 , 0 >,"rightSwitchShort1",index++))
	wave5.append(CreateWaitForTimeEvent(5.0,index++))
	wave5.append(CreateNukeTitanEvent(< -442, -3685, 144 >,< 0, 90, 0 >,"rightNear",0))
    waveEvents.append(wave5)
}