global function initFrontierDefenseData
void function initFrontierDefenseData()
{
    shopPosition = < -2405, -3182, -541 >
	shopAngles = < 0, 17, 0 >
	FD_spawnPosition = < -1736, -1505, 261 >
	FD_spawnAngles = < 0, -180, 0 >
	FD_groundspawnPosition = < -1340, -1989, -192 >
	FD_groundspawnAngles = < 0, -15, 0 >
	
	FD_DropPodSpawns.append(< -1700, -4005, -206 >)
	FD_DropPodSpawns.append(< -2970, -1257, -65 >)
	FD_DropPodSpawns.append(< -1212, -1564, 328 >)
	
	waveAnnouncement.append("fd_introEasy")
	waveAnnouncement.append("fd_waveTypeReapers")
	waveAnnouncement.append("fd_soonNukeTitans")
	waveAnnouncement.append("fd_waveTypeFlyers")
	waveAnnouncement.append("fd_waveComboNukeMortar")

	int index = 1
	
    array<WaveEvent> wave1
	wave1.append(CreateWarningEvent( FD_IncomingWarnings.Infantry, index++ ))
	wave1.append(CreateDroppodGruntEvent(< -877, 699, -290>,"",index++))
	wave1.append(CreateWaitForTimeEvent( 1.0, index++ ) )
	wave1.append(CreateDroppodGruntEvent(< 586, 100, -191>,"",index++))
	wave1.append(CreateWaitForTimeEvent( 0.6, index++ ) )
	wave1.append(CreateDroppodGruntEvent(< -52, 2281, -349>,"",index++))
	wave1.append(CreateWaitForTimeEvent( 5.0, index++ ) )
	wave1.append(CreateWaitUntilAliveEvent( 4, index++ ) )
	wave1.append(CreateDroppodGruntEvent(< 1518, -3368, -249>,"",index++))
	wave1.append(CreateWaitForTimeEvent( 1.0, index++ ) )
	wave1.append(CreateDroppodGruntEvent(< 1174, -2721, -253>,"",index++))
	wave1.append(CreateWaitForTimeEvent( 1.0, index++ ) )
	wave1.append(CreateDroppodGruntEvent(< 2097, -2461, -95>,"",index++))
	wave1.append(CreateWaitForTimeEvent( 5.0, index++ ) )
	wave1.append(CreateWaitUntilAliveEvent( 4, index++ ) )
	wave1.append(CreateWarningEvent( FD_IncomingWarnings.Stalkers, index++ ))
	wave1.append(CreateDroppodStalkerEvent(< 1940, -4357, -238>,"",index++))
	wave1.append(CreateWaitForTimeEvent( 0.6, index++ ) )
	wave1.append(CreateDroppodGruntEvent(< 2371, 1085, -300>,"",index++))
	wave1.append(CreateWaitForTimeEvent( 0.8, index++ ) )
	wave1.append(CreateDroppodGruntEvent(< 1994, 2572, 79>,"left_infantry",index++))
	wave1.append(CreateWaitForTimeEvent( 1.0, index++ ) )
	wave1.append(CreateDroppodGruntEvent(< 1529, 2559, 99>,"left_infantry",index++))
	wave1.append(CreateWaitForTimeEvent( 1.2, index++ ) )
	wave1.append(CreateGruntDropshipEvent(< -118, -3714, -250>,< 0, -43, 0 >,6,"",index++))
	wave1.append(CreateWaitForTimeEvent( 5.0, index++ ) )
	wave1.append(CreateWaitUntilAliveEvent( 4, index++ ) )
	wave1.append(CreateDroppodStalkerEvent(< 2433, -3137, -305>,"",index++))
	wave1.append(CreateWaitForTimeEvent( 0.5, index++ ) )
	wave1.append(CreateDroppodGruntEvent(< 2068, -223, -127>,"",index++))
	wave1.append(CreateWaitForTimeEvent( 1.0, index++ ) )
	wave1.append(CreateDroppodGruntEvent(< 1458, 110, -243>,"",index++))
	wave1.append(CreateWaitForTimeEvent( 0.5, index++ ) )
	wave1.append(CreateDroppodStalkerEvent(< 2164, -735, 16>,"",index++))
	wave1.append(CreateWaitForTimeEvent( 1.0, index++ ) )
	wave1.append(CreateDroppodGruntEvent(< 1584, -183, -210>,"",index++))
	wave1.append(CreateWaitForTimeEvent( 5.0, index++ ) )
	wave1.append(CreateWaitUntilAliveEvent( 4, index++ ) )
	wave1.append(CreateDroppodStalkerEvent(< -881, 642, -289>,"",index++))
	wave1.append(CreateWaitForTimeEvent( 0.3, index++ ) )
	wave1.append(CreateDroppodStalkerEvent(< -868, 1613, -319>,"",index++))
	wave1.append(CreateWaitForTimeEvent( 1.5, index++ ) )
	wave1.append(CreateDroppodGruntEvent(< -562, -169, -234>,"",index++))
	wave1.append(CreateWaitForTimeEvent( 1.0, index++ ) )
	wave1.append(CreateGruntDropshipEvent(< 3681, -2573, -336>,< 0, 190, 0 >,6,"",index++))
	wave1.append(CreateWaitForTimeEvent( 2.0, index++ ) )
	wave1.append(CreateDroppodStalkerEvent(< 1972, 2066, -332>,"",index++))
	wave1.append(CreateWaitForTimeEvent( 5.0, index++ ) )
	wave1.append(CreateWaitUntilAliveEvent( 4, index++ ) )
	wave1.append(CreateDroppodStalkerEvent(< -96, -3675, -200>,"",index++))
	wave1.append(CreateWaitForTimeEvent( 1.0, index++ ) )
	wave1.append(CreateSuperSpectreEvent(< 2872, -2388, -378>,< 0, -176, 0>,"",index++))
	wave1.append(CreateWaitForTimeEvent( 1.3, index++ ) )
	wave1.append(CreateDroppodStalkerEvent(< 350, -4402, -194>,"",index++))
	wave1.append(CreateWaitForTimeEvent( 1.6, index++ ) )
	wave1.append(CreateSuperSpectreEvent(< -922, 2236, -362>,< 0, -172, 0>,"",index++))
	wave1.append(CreateWaitForTimeEvent( 2.0, index++ ) )
	wave1.append(CreateDroppodStalkerEvent(< 1049, -3360, -246>,"",0))
	waveEvents.append(wave1)
	index = 1
    array<WaveEvent> wave2
	wave2.append(CreateGruntDropshipEvent(< -50, -1004, -422>,< 0, 40, 0 >,6,"",index++))
	wave2.append(CreateWaitForTimeEvent( 1.5, index++ ) )
	wave2.append(CreateWarningEvent( FD_IncomingWarnings.ReaperAlt, index++ ))
	wave2.append(CreateSuperSpectreEvent(< 3648, -3017, -306>,< 0, 180, 0>,"",index++))
	wave2.append(CreateWaitForTimeEvent( 0.6, index++ ) )
	wave2.append(CreateSuperSpectreEvent(< 3687, -1981, -353>,< 0, 180, 0>,"",index++))
	wave2.append(CreateWaitForTimeEvent( 0.8, index++ ) )
	wave2.append(CreateSuperSpectreEvent(< 3682, -2563, -328>,< 0, 180, 0>,"",index++))
	wave2.append(CreateWaitForTimeEvent( 0.6, index++ ) )
	wave2.append(CreateSuperSpectreEvent(< 3313, -2788, -334>,< 0, 180, 0>,"",index++))
	wave2.append(CreateWaitForTimeEvent( 0.8, index++ ) )
	wave2.append(CreateSuperSpectreEvent(< 2984, 450, -313>,< 0, -125, 0>,"",index++))
	wave2.append(CreateWaitForTimeEvent( 2.0, index++ ) )
	wave2.append(CreateDroppodGruntEvent(< 1486, -2911, -246>,"",index++))
	wave2.append(CreateWaitForTimeEvent( 0.3, index++ ) )
	wave2.append(CreateDroppodStalkerEvent(< 1571, -43, -221>,"",index++))
	wave2.append(CreateWaitForTimeEvent( 5.0, index++ ) )
	wave2.append(CreateWaitUntilAliveEvent( 2, index++ ) )
	wave2.append(CreateSuperSpectreEvent(< 2718, 1120, -280>,< 0, -132, 0>,"",index++))
	wave2.append(CreateWaitForTimeEvent( 0.4, index++ ) )
	wave2.append(CreateSuperSpectreEvent(< 1787, 2052, -313>,< 0, 158, 0>,"",index++))
	wave2.append(CreateWaitForTimeEvent( 0.6, index++ ) )
	wave2.append(CreateSuperSpectreEvent(< 1018, 2858, -363>,< 0, -156, 0>,"",index++))
	wave2.append(CreateWaitForTimeEvent( 0.8, index++ ) )
	wave2.append(CreateSuperSpectreEvent(< 646, -4515, -222>,< 0, 128, 0>,"",index++))
	wave2.append(CreateWaitForTimeEvent( 1.0, index++ ) )
	wave2.append(CreateSuperSpectreEvent(< 1895, -4598, -216>,< 0, 86, 0>,"",index++))
	wave2.append(CreateWaitForTimeEvent( 2.0, index++ ) )
	wave2.append(CreateGruntDropshipEvent(< -118, -3714, -250>,< 0, -43, 0 >,6,"",index++))
	wave2.append(CreateWaitForTimeEvent( 2.5, index++ ) )
	wave2.append(CreateSpawnDroneEvent(< 3056, -2845, 2816>,< 0, 0, 0>,"midDrone",index++))
	wave2.append(CreateWaitForTimeEvent( 5.0, index++ ) )
	wave2.append(CreateWaitUntilAliveEvent( 2, index++ ) )
	wave2.append(CreateWarningEvent( FD_IncomingWarnings.EnemyTitansIncoming, index++ ))
	wave2.append(CreateToneSniperTitanEvent(< 4241, -17, -390>,< 0, -159, 0>,index++))
	wave2.append(CreateWaitForTimeEvent( 2.5, index++ ) )
	wave2.append(CreateSuperSpectreEvent(< 4323, -362, -405>,< 0, 167, 0>,"",index++))
	wave2.append(CreateWaitForTimeEvent( 0.5, index++ ) )
	wave2.append(CreateSuperSpectreEvent(< 4165, 146, -380>,< 0, -163, 0>,"",index++))
	wave2.append(CreateWaitForTimeEvent( 0.5, index++ ) )
	wave2.append(CreateSuperSpectreEvent(< 4014, -111, -417>,< 0, -158, 0>,"",index++))
	wave2.append(CreateWaitForTimeEvent( 0.5, index++ ) )
	wave2.append(CreateSuperSpectreEvent(< 2413, 1934, -331>,< 0, -176, 0>,"",index++))
	wave2.append(CreateWaitForTimeEvent( 0.5, index++ ) )
	wave2.append(CreateSuperSpectreEvent(< 2183, 1783, -321>,< 0, -51, 0>,"",index++))
	wave2.append(CreateWaitForTimeEvent( 2.5, index++ ) )
	wave2.append(CreateIonTitanEvent(< 3459, -2928, -301>,< 0, 173, 0>,"",index++))
	wave2.append(CreateWaitForTimeEvent( 2.5, index++ ) )
	wave2.append(CreateDroppodGruntEvent(< 2147, 2549, 74>,"left_infantry",index++))
	wave2.append(CreateWaitForTimeEvent( 0.2, index++ ) )
	wave2.append(CreateDroppodGruntEvent(< 1473, 2426, 93>,"left_infantry",index++))
	wave2.append(CreateWaitForTimeEvent( 0.4, index++ ) )
	wave2.append(CreateDroppodStalkerEvent(< -258, -141, -209>,"",index++))
	wave2.append(CreateWaitForTimeEvent( 5.0, index++ ) )
	wave2.append(CreateWaitUntilAliveEvent( 4, index++ ) )
	wave2.append(CreateSuperSpectreEvent(< 2848, -4144, -328>,< 0, 160, 0>,"",index++))
	wave2.append(CreateWaitForTimeEvent( 1.5, index++ ) )
	wave2.append(CreateSuperSpectreEvent(< 2182, -4263, -287>,< 0, 135, 0>,"",index++))
	wave2.append(CreateWaitForTimeEvent( 1.4, index++ ) )
	wave2.append(CreateSuperSpectreEvent(< 2004, -4563, -218>,< 0, 86, 0>,"",index++))
	wave2.append(CreateWaitForTimeEvent( 1.3, index++ ) )
	wave2.append(CreateSuperSpectreEvent(< -2369, 1961, -393>,< 0, -39, 0>,"",index++))
	wave2.append(CreateWaitForTimeEvent( 1.2, index++ ) )
	wave2.append(CreateSuperSpectreEvent(< -2073, 1489, -349>,< 0, -31, 0>,"",index++))
	wave2.append(CreateWaitForTimeEvent( 2.0, index++ ) )
	wave2.append(CreateScorchTitanEvent(< -2269, 2679, -475>,< 0, -45, 0>,"",index++))
	wave2.append(CreateWaitForTimeEvent( 1.5, index++ ) )
	wave2.append(CreateNukeTitanEvent(< -1090, 3374, -425>,< 0, -98, 0>,"",index++))
	wave2.append(CreateWaitForTimeEvent( 2.5, index++ ) )
	wave2.append(CreateDroppodGruntEvent(< -10, 2062, -327>,"",index++))
	wave2.append(CreateWaitForTimeEvent( 0.5, index++ ) )
	wave2.append(CreateDroppodGruntEvent(< 559, 99, -194>,"",index++))
	wave2.append(CreateWaitForTimeEvent( 0.2, index++ ) )
	wave2.append(CreateSpawnDroneEvent(< -2898, 3657, 2560>,< 0, 0, 0>,"closeDrone1",0))
	waveEvents.append(wave2)
	index = 1
    array<WaveEvent> wave3
	wave3.append(CreateDroppodStalkerEvent(< 1940, -4357, -238>,"",index++))
	wave3.append(CreateWaitForTimeEvent( 0.5, index++ ) )
	wave3.append(CreateSuperSpectreEvent(< 812, -4289, -214>,< 0, 132, 0>,"",index++))
	wave3.append(CreateWaitForTimeEvent( 1.5, index++ ) )
	wave3.append(CreateWarningEvent( FD_IncomingWarnings.EliteTitan, index++ ))
	wave3.append(CreateRoninTitanEvent(< 3673, -2540, -332>,< 0, 175, 0>,"",index++,1,"",FD_TitanType.TITAN_ELITE))
	wave3.append(CreateWaitForTimeEvent( 2.5, index++ ) )
	wave3.append(CreateDroppodStalkerEvent(< 2433, -3137, -305>,"",index++))
	wave3.append(CreateWaitForTimeEvent( 0.5, index++ ) )
	wave3.append(CreateRoninTitanEvent(< 3197, -3281, -324>,< 0, 148, 0>,"",index++,1,"",FD_TitanType.TITAN_ELITE))
	wave3.append(CreateWaitForTimeEvent( 2.5, index++ ) )
	wave3.append(CreateDroppodStalkerEvent(< -881, 642, -289>,"",index++))
	wave3.append(CreateWaitForTimeEvent( 2.5, index++ ) )
	wave3.append(CreateLegionTitanEvent(< 3752, -1068, -417>,< 0, 164, 0>,"",index++))
	wave3.append(CreateWaitForTimeEvent( 1.5, index++ ) )
	wave3.append(CreateSuperSpectreEvent(< 449, -4423, -197>,< 0, 149, 0>,"",index++))
	wave3.append(CreateWaitForTimeEvent( 0.5, index++ ) )
	wave3.append(CreateDroppodStalkerEvent(< 2164, -735, 16>,"",index++))
	wave3.append(CreateWaitForTimeEvent( 5.0, index++ ) )
	wave3.append(CreateWaitUntilAliveEvent( 2, index++ ) )
	wave3.append(CreateScorchTitanEvent(< -2416, 2457, -439>,< 0, -50, 0>,"",index++))
	wave3.append(CreateWaitForTimeEvent( 1.5, index++ ) )
	wave3.append(CreateScorchTitanEvent(< -813, 3976, -473>,< 0, -88, 0>,"",index++))
	wave3.append(CreateWaitForTimeEvent( 1.5, index++ ) )
	wave3.append(CreateScorchTitanEvent(< -2057, 3627, -482>,< 0, -50, 0>,"",index++))
	wave3.append(CreateWaitForTimeEvent( 1.5, index++ ) )
	wave3.append(CreateDroppodStalkerEvent(< 1972, 2066, -332>,"",index++))
	wave3.append(CreateWaitForTimeEvent( 0.5, index++ ) )
	wave3.append(CreateSuperSpectreEvent(< 580, -590, -286>,< 0, -171, 0>,"",index++))
	wave3.append(CreateWaitForTimeEvent( 0.5, index++ ) )
	wave3.append(CreateDroppodStalkerEvent(< -868, 1613, -319>,"",index++))
	wave3.append(CreateWaitForTimeEvent( 0.5, index++ ) )
	wave3.append(CreateSuperSpectreEvent(< 618, 70, -192>,< 0, -177, 0>,"",index++))
	wave3.append(CreateWaitForTimeEvent( 2.5, index++ ) )
	wave3.append(CreateWarningEvent( FD_IncomingWarnings.MortarTitanIntro, index++ ) )
	wave3.append(CreateMortarTitanEvent(< -501, 2750, -386>,< 0, 123, 0>,index++))
	wave3.append(CreateWaitForTimeEvent( 0.5, index++ ) )
	wave3.append(CreateMortarTitanEvent(< -1424, 4142, -437>,< 0, -91, 0>,index++))
	wave3.append(CreateWaitForTimeEvent( 0.5, index++ ) )
	wave3.append(CreateMortarTitanEvent(< -2547, 3096, -473>,< 0, -61, 0>,index++))
	wave3.append(CreateWaitForTimeEvent( 3.0, index++ ) )
	wave3.append(CreateSpawnDroneEvent(< -2898, 3657, 2560>,< 0, 0, 0>,"closeDrone1",index++))
	wave3.append(CreateWaitForTimeEvent( 1.0, index++ ) )
	wave3.append(CreateSpawnDroneEvent(< -896, 4959, 2560>,< 0, 0, 0>,"farDrone1",index++))
	wave3.append(CreateWaitForTimeEvent( 5.0, index++ ) )
	wave3.append(CreateWaitUntilAliveEvent( 6, index++ ) )
	wave3.append(CreateIonTitanEvent(< 3748, -1859, -359>,< 0, 170, 0>,"",index++))
	wave3.append(CreateWaitForTimeEvent( 2.5, index++ ) )
	wave3.append(CreateIonTitanEvent(< 3708, -1242, -413>,< 0, 165, 0>,"",index++))
	wave3.append(CreateWaitForTimeEvent( 1.5, index++ ) )
	wave3.append(CreateSuperSpectreEvent(< 1066, 2832, -359>,< 0, -135, 0>,"",index++))
	wave3.append(CreateWaitForTimeEvent( 5.0, index++ ) )
	wave3.append(CreateMonarchTitanEvent(< 4013, 100, -397>,< 0, -165, 0>,"",index++,1,"",FD_TitanType.TITAN_ELITE))
	wave3.append(CreateWaitForTimeEvent( 2.5, index++ ) )
	wave3.append(CreateMonarchTitanEvent(< 4114, -291, -415>,< 0, -173, 0>,"",index++,1,"",FD_TitanType.TITAN_ELITE))
	wave3.append(CreateWaitForTimeEvent( 1.5, index++ ) )
	wave3.append(CreateSuperSpectreEvent(< 957, 2210, -330>,< 0, 179, 0>,"",index++))
	wave3.append(CreateWaitForTimeEvent( 5.0, index++ ) )
	wave3.append(CreateDroppodStalkerEvent(< 1049, -3360, -246>,"",index++))
	wave3.append(CreateWaitForTimeEvent( 0.5, index++ ) )
	wave3.append(CreateSpawnDroneEvent(< 3056, -2845, 2560>,< 0, 0, 0>,"midDrone",index++))
	wave3.append(CreateWaitForTimeEvent( 0.5, index++ ) )
	wave3.append(CreateDroppodStalkerEvent(< -96, -3675, -200>,"",index++))
	wave3.append(CreateWaitForTimeEvent( 0.5, index++ ) )
	wave3.append(CreateSpawnDroneEvent(< 2548, -4935, 2560>,< 0, 0, 0>,"closeDrone2",index++))
	wave3.append(CreateWaitForTimeEvent( 0.5, index++ ) )
	wave3.append(CreateDroppodStalkerEvent(< 1280, -5518, -144>,"",index++))
	wave3.append(CreateWaitForTimeEvent( 5.0, index++ ) )
	wave3.append(CreateMortarTitanEvent(< 4204, -308, -357>,< 0, 180, 0>,index++))
	wave3.append(CreateWaitForTimeEvent( 2.5, index++ ) )
	wave3.append(CreateWarningEvent( FD_IncomingWarnings.NukeTitanIntro, index++ ) )
	wave3.append(CreateNukeTitanEvent(< 729, -4295, -215>,< 0, 91, 0>,"",index++))
	wave3.append(CreateWaitForTimeEvent( 2.5, index++ ) )
	wave3.append(CreateMortarTitanEvent(< 4043, 77, -344>,< 0, -165, 0>,index++))
	wave3.append(CreateWaitForTimeEvent( 2.5, index++ ) )
	wave3.append(CreateNukeTitanEvent(< 2013, -4526, -224>,< 0, 87, 0>,"",index++))
	wave3.append(CreateWaitForTimeEvent( 2.5, index++ ) )
	wave3.append(CreateMortarTitanEvent(< 4098, -87, -405>,< 0, -165, 0>,index++))
	wave3.append(CreateWaitForTimeEvent( 2.5, index++ ) )
	wave3.append(CreateNukeTitanEvent(< 2624, -4138, -313>,< 0, 122, 0>,"",index++))
	wave3.append(CreateWaitForTimeEvent( 5.0, index++ ) )
	wave3.append(CreateArcTitanEvent(< -93, -914, -404>,< 0, 5, 0>,"",0))
	waveEvents.append(wave3)
	index = 1
    array<WaveEvent> wave4
	wave4.append(CreateSuperSpectreEvent(< 2316, -4487, -293>,< 0, 104, 0>,"",index++))
	wave4.append(CreateWaitForTimeEvent( 1.5, index++ ) )
	wave4.append(CreateToneTitanEvent(< 1025, 2841, -361>,< 0, -146, 0>,"",index++))
	wave4.append(CreateWaitForTimeEvent( 2.5, index++ ) )
	wave4.append(CreateSuperSpectreEvent(< 1962, -4542, -214>,< 0, 102, 0>,"",index++))
	wave4.append(CreateWaitForTimeEvent( 1.5, index++ ) )
	wave4.append(CreateScorchTitanEvent(< -197, 3952, -447>,< 0, -155, 0>,"",index++,1,"",FD_TitanType.TITAN_ELITE))
	wave4.append(CreateWaitForTimeEvent( 2.5, index++ ) )
	wave4.append(CreateSuperSpectreEvent(< 2079, -4227, -272>,< 0, 93, 0>,"",index++))
	wave4.append(CreateWaitForTimeEvent( 1.5, index++ ) )
	wave4.append(CreateToneTitanEvent(< -1539, 4136, -437>,< 0, -73, 0>,"",index++))
	wave4.append(CreateWaitForTimeEvent( 5.0, index++ ) )
	wave4.append(CreateSpawnDroneEvent(< 3056, -2845, 2560>,< 0, 0, 0>,"midDrone",index++))
	wave4.append(CreateWaitForTimeEvent( 1.0, index++ ) )
	wave4.append(CreateSpawnDroneEvent(< 2548, -4935, 2560>,< 0, 0, 0>,"closeDrone2",index++))
	wave4.append(CreateWaitForTimeEvent( 1.0, index++ ) )
	wave4.append(CreateSpawnDroneEvent(< 3056, -2845, 2560>,< 0, 0, 0>,"rightDrone",index++))
	wave4.append(CreateWaitForTimeEvent( 2.5, index++ ) )
	wave4.append(CreateWarningEvent( FD_IncomingWarnings.MortarTitan, index++ ) )
	wave4.append(CreateMortarTitanEvent(< -501, 2750, -386>,< 0, 123, 0>,index++))
	wave4.append(CreateWaitForTimeEvent( 1.5, index++ ) )
	wave4.append(CreateMortarTitanEvent(< -1424, 4142, -437>,< 0, -91, 0>,index++))
	wave4.append(CreateWaitForTimeEvent( 1.5, index++ ) )
	wave4.append(CreateMortarTitanEvent(< -2547, 3096, -473>,< 0, -61, 0>,index++))
	wave4.append(CreateWaitForTimeEvent( 5.0, index++ ) )
	wave4.append(CreateWaitUntilAliveEvent( 6, index++ ) )
	wave4.append(CreateSuperSpectreEvent(< 3905, 52, -419>,< 0, -159, 0>,"",index++))
	wave4.append(CreateWaitForTimeEvent( 1.5, index++ ) )
	wave4.append(CreateRoninTitanEvent(< 2660, 1057, -285>,< 0, -94, 0>,"",index++,1,"",FD_TitanType.TITAN_ELITE))
	wave4.append(CreateWaitForTimeEvent( 2.5, index++ ) )
	wave4.append(CreateSuperSpectreEvent(< 3814, 231, -400>,< 0, -167, 0>,"",index++))
	wave4.append(CreateWaitForTimeEvent( 1.5, index++ ) )
	wave4.append(CreateIonTitanEvent(< 3818, -897, -422>,< 0, 177, 0>,"",index++))
	wave4.append(CreateWaitForTimeEvent( 2.5, index++ ) )
	wave4.append(CreateSuperSpectreEvent(< 4136, 89, -388>,< 0, -156, 0>,"",index++))
	wave4.append(CreateWaitForTimeEvent( 1.5, index++ ) )
	wave4.append(CreateLegionTitanEvent(< 3615, -2674, -325>,< 0, -168, 0>,"",index++,1,"",FD_TitanType.TITAN_ELITE))
	wave4.append(CreateWaitForTimeEvent( 2.5, index++ ) )
	wave4.append(CreateDroppodStalkerEvent(< 38, -820, -382>,"",index++))
	wave4.append(CreateWaitForTimeEvent( 0.5, index++ ) )
	wave4.append(CreateDroppodStalkerEvent(< 74, -4479, -237>,"",index++))
	wave4.append(CreateWaitForTimeEvent( 5.0, index++ ) )
	wave4.append(CreateSpawnDroneEvent(< -896, 4959, 2560>,< 0, 0, 0>,"farDrone1",index++))
	wave4.append(CreateWaitForTimeEvent( 1.0, index++ ) )
	wave4.append(CreateSpawnDroneEvent(< -2898, 3657, 2560>,< 0, 0, 0>,"closeDrone1",index++))
	wave4.append(CreateWaitForTimeEvent( 1.0, index++ ) )
	wave4.append(CreateSpawnDroneEvent(< -896, 4959, 2560>,< 0, 0, 0>,"farDrone1",index++))
	wave4.append(CreateWaitForTimeEvent( 5.0, index++ ) )
	wave4.append(CreateWaitUntilAliveEvent( 6, index++ ) )
	wave4.append(CreateSuperSpectreEvent(< -1725, 2522, -403>,< 0, -89, 0>,"",index++))
	wave4.append(CreateWaitForTimeEvent( 1.5, index++ ) )
	wave4.append(CreateLegionTitanEvent(< 3319, -3133, -320>,< 0, 177, 0>,"",index++,1,"",FD_TitanType.TITAN_ELITE))
	wave4.append(CreateWaitForTimeEvent( 2.5, index++ ) )
	wave4.append(CreateSuperSpectreEvent(< -1337, 2796, -399>,< 0, -73, 0>,"",index++))
	wave4.append(CreateWaitForTimeEvent( 1.5, index++ ) )
	wave4.append(CreateIonTitanEvent(< 2796, -4140, -330>,< 0, 140, 0>,"",index++,1,"",FD_TitanType.TITAN_ELITE))
	wave4.append(CreateWaitForTimeEvent( 2.5, index++ ) )
	wave4.append(CreateSuperSpectreEvent(< -1100, 3355, -424>,<0, -49, 0>,"",index++))
	wave4.append(CreateWaitForTimeEvent( 1.5, index++ ) )
	wave4.append(CreateMonarchTitanEvent(< 2151, -4485, -270>,< 0, 102, 0>,"",index++))
	wave4.append(CreateWaitForTimeEvent( 2.5, index++ ) )
	wave4.append(CreateDroppodStalkerEvent(< 483, -4278, -218>,"",index++))
	wave4.append(CreateWaitForTimeEvent( 0.5, index++ ) )
	wave4.append(CreateDroppodStalkerEvent(< -185, -159, -208>,"",index++))
	wave4.append(CreateWaitForTimeEvent( 5.0, index++ ) )
	wave4.append(CreateNorthstarSniperTitanEvent(< 586, 135, -192>,< 0, 180, 0>,index++))
	wave4.append(CreateWaitForTimeEvent( 2.5, index++ ) )
	wave4.append(CreateScorchTitanEvent(< -93, -914, -404>,< 0, 5, 0>,"",index++))
	wave4.append(CreateWaitForTimeEvent( 2.5, index++ ) )
	wave4.append(CreateMortarTitanEvent(< 2445, -4363, -323>,< 0, 125, 0>,index++))
	wave4.append(CreateWaitForTimeEvent( 1.0, index++ ) )
	wave4.append(CreateMortarTitanEvent(< 4218, -286, -408>,< 0, -171, 0>,index++))
	wave4.append(CreateWaitForTimeEvent( 1.0, index++ ) )
	wave4.append(CreateMortarTitanEvent(< 4123, 162, -381>,< 0, -161, 0>,index++))
	wave4.append(CreateWaitForTimeEvent( 1.0, index++ ) )
	wave4.append(CreateMortarTitanEvent(< 3707, -2056, -355>,< 0, 168, 0>,index++))
	wave4.append(CreateWaitForTimeEvent( 2.5, index++ ) )
	wave4.append(CreateNukeTitanEvent(< 510, -4507, -231>,< 0, 119, 0>,"",0))
	waveEvents.append(wave4)
	index = 1
    array<WaveEvent> wave5
	wave5.append(CreateWarningEvent( FD_IncomingWarnings.MediumWave, index++ ) )
	wave5.append(CreateIonTitanEvent(< 3472, -2986, -302>,< 0, 176, 0>,"",index++,1,"",FD_TitanType.TITAN_ELITE))
	wave5.append(CreateWaitForTimeEvent( 1.5, index++ ) )
	wave5.append(CreateLegionTitanEvent(< 3749, -2088, -354>,< 0, 166, 0>,"",index++,1,"",FD_TitanType.TITAN_ELITE))
	wave5.append(CreateWaitForTimeEvent( 2.5, index++ ) )
	wave5.append(CreateMortarTitanEvent(< 4202, 42, -388>,< 0, -151, 0>,index++))
	wave5.append(CreateWaitForTimeEvent( 1.5, index++ ) )
	wave5.append(CreateSuperSpectreEvent(< 670, -4362, -220>,< 0, 90, 0>,"",index++))
	wave5.append(CreateWaitForTimeEvent( 5.0, index++ ) )
	wave5.append(CreateWaitUntilAliveEvent( 0, index++ ) )
	wave5.append(CreateWarningEvent( FD_IncomingWarnings.NukeTitan, index++ ) )
	wave5.append(CreateNukeTitanEvent(< -1904, 2592, -433>,< 0, -55, 0>,"",index++))
	wave5.append(CreateWaitForTimeEvent( 1.4, index++ ) )
	wave5.append(CreateNukeTitanEvent(< -1161, 3367, -422>,< 0, -54, 0>,"",index++))
	wave5.append(CreateWaitForTimeEvent( 1.2, index++ ) )
	wave5.append(CreateNukeTitanEvent(< 2153, -4379, -278>,< 0, 131, 0>,"",index++))
	wave5.append(CreateWaitForTimeEvent( 1.0, index++ ) )
	wave5.append(CreateNukeTitanEvent(< 2810, -4170, -332>,< 0, 138, 0>,"",index++))
	wave5.append(CreateWaitForTimeEvent( 2.5, index++ ) )
	wave5.append(CreateMortarTitanEvent(< 2394, 1975, -334>,< 0, -143, 0>,index++))
	wave5.append(CreateWaitForTimeEvent( 5.0, index++ ) )
	wave5.append(CreateWaitUntilAliveEvent( 2, index++ ) )
	wave5.append(CreateLegionTitanEvent(< 3427, -3299, -303>,< 0, 147, 0>,"",index++,1,"",FD_TitanType.TITAN_ELITE))
	wave5.append(CreateWaitForTimeEvent( 1.5, index++ ) )
	wave5.append(CreateMonarchTitanEvent(< 4219, -42, -393>,< 0, -158, 0>,"",index++,1,"",FD_TitanType.TITAN_ELITE))
	wave5.append(CreateWaitForTimeEvent( 2.5, index++ ) )
	wave5.append(CreateNukeTitanEvent(< -613, 3681, -444>,< 0, -79, 0>,"",index++))
	wave5.append(CreateWaitForTimeEvent( 2.0, index++ ) )
	wave5.append(CreateNukeTitanEvent(< -1905, 3665, -478>,< 0, -67, 0>,"",index++))
	wave5.append(CreateWaitForTimeEvent( 1.6, index++ ) )
	wave5.append(CreateNukeTitanEvent(< -1838, 2537, -421>,< 0, -52, 0>,"",index++))
	wave5.append(CreateWaitForTimeEvent( 1.3, index++ ) )
	wave5.append(CreateNukeTitanEvent(< -2166, 1661, -368>,< 0, -34, 0>,"",index++))
	wave5.append(CreateWaitForTimeEvent( 5.0, index++ ) )
	wave5.append(CreateMortarTitanEvent(< -1207, 4138, -449>,< 0, -81, 0>,index++))
	wave5.append(CreateWaitForTimeEvent( 1.5, index++ ) )
	wave5.append(CreateMortarTitanEvent(< -227, 3983, -448>,< 0, -132, 0>,index++))
	wave5.append(CreateWaitForTimeEvent( 5.0, index++ ) )
	wave5.append(CreateWaitUntilAliveEvent( 0, index++ ) )
	wave5.append(CreateScorchTitanEvent(< 3427, -3299, -303>,< 0, 147, 0>,"",index++,1,"",FD_TitanType.TITAN_ELITE))
	wave5.append(CreateWaitForTimeEvent( 1.5, index++ ) )
	wave5.append(CreateNukeTitanEvent(< 3721, -1174, -415>,< 0, -177, 0>,"",index++))
	wave5.append(CreateWaitForTimeEvent( 2.0, index++ ) )
	wave5.append(CreateNukeTitanEvent(< 3657, -2016, -354>,< 0, -175, 0>,"",index++))
	wave5.append(CreateWaitForTimeEvent( 2.0, index++ ) )
	wave5.append(CreateNukeTitanEvent(< 2714, -4188, -333>,< 0, 127, 0>,"",index++))
	wave5.append(CreateWaitForTimeEvent( 2.0, index++ ) )
	wave5.append(CreateNukeTitanEvent(< 1933, -4395, -234>,< 0, 88, 0>,"",index++))
	wave5.append(CreateWaitForTimeEvent( 5.0, index++ ) )
	wave5.append(CreateMortarTitanEvent(< 4106, 100, -389>,< 0, -141, 0>,index++))
	wave5.append(CreateWaitForTimeEvent( 1.5, index++ ) )
	wave5.append(CreateMortarTitanEvent(< 2419, 1885, -328>,< 0, 180, 0>,index++))
	wave5.append(CreateWaitForTimeEvent( 5.0, index++ ) )
	wave5.append(CreateNorthstarSniperTitanEvent(< 586, 135, -192>,< 0, 180, 0>,index++,1,"",FD_TitanType.TITAN_ELITE))
	wave5.append(CreateWaitForTimeEvent( 1.0, index++ ) )
	wave5.append(CreateSpawnDroneEvent(< -896, 4959, 2560>,< 0, 0, 0>,"farDrone1",index++))
	wave5.append(CreateWaitForTimeEvent( 1.0, index++ ) )
	wave5.append(CreateSpawnDroneEvent(< -2898, 3657, 2560>,< 0, 0, 0>,"closeDrone1",index++))
	wave5.append(CreateWaitForTimeEvent( 1.0, index++ ) )
	wave5.append(CreateSpawnDroneEvent(< -896, 4959, 2560>,< 0, 0, 0>,"farDrone1",index++))
	wave5.append(CreateWaitForTimeEvent( 5.0, index++ ) )
	wave5.append(CreateWaitUntilAliveEvent( 4, index++ ) )
	wave5.append(CreateNukeTitanEvent(< 4053, -83, -410>,< 0, -156, 0>,"",index++))
	wave5.append(CreateWaitForTimeEvent( 1.0, index++ ) )
	wave5.append(CreateNukeTitanEvent(< 3795, -1990, -350>,< 0, -179, 0>,"",index++))
	wave5.append(CreateWaitForTimeEvent( 0.8, index++ ) )
	wave5.append(CreateNukeTitanEvent(< 3708, -2992, -305>,< 0, 164, 0>,"",index++))
	wave5.append(CreateWaitForTimeEvent( 0.6, index++ ) )
	wave5.append(CreateNukeTitanEvent(< 552, -4475, -227>,< 0, 134, 0>,"",index++))
	wave5.append(CreateWaitForTimeEvent( 0.4, index++ ) )
	wave5.append(CreateNukeTitanEvent(< -1985, 2467, -425>,< 0, -61, 0>,"",index++))
	wave5.append(CreateWaitForTimeEvent( 0.2, index++ ) )
	wave5.append(CreateNukeTitanEvent(< -1054, 3271, -422>,< 0, -95, 0>,"",index++))
	wave5.append(CreateWaitForTimeEvent( 5.0, index++ ) )
	wave5.append(CreateSpawnDroneEvent(< 3056, -2845, 2560>,< 0, 0, 0>,"midDrone",index++))
	wave5.append(CreateWaitForTimeEvent( 1.0, index++ ) )
	wave5.append(CreateSpawnDroneEvent(< 2548, -4935, 2560>,< 0, 0, 0>,"closeDrone2",index++))
	wave5.append(CreateWaitForTimeEvent( 1.0, index++ ) )
	wave5.append(CreateSpawnDroneEvent(< 3056, -2845, 2560>,< 0, 0, 0>,"rightDrone",index++))
	wave5.append(CreateWaitForTimeEvent( 5.0, index++ ) )
	wave5.append(CreateMortarTitanEvent(< -1491, 3937, -471>,< 0, -74, 0>,index++))
	wave5.append(CreateWaitForTimeEvent( 1.0, index++ ) )
	wave5.append(CreateMortarTitanEvent(< -2393, 3087, -470>,< 0, -59, 0>,index++))
	wave5.append(CreateWaitForTimeEvent( 0.8, index++ ) )
	wave5.append(CreateMortarTitanEvent(< 2660, 1079, -285>,< 0, -104, 0>,index++))
	wave5.append(CreateWaitForTimeEvent( 0.6, index++ ) )
	wave5.append(CreateMortarTitanEvent(< 3851, 224, -397>,< 0, -139, 0>,0))
    waveEvents.append(wave5)
}