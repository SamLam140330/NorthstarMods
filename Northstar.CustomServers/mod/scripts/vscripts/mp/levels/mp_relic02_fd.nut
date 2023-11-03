global function initFrontierDefenseData
void function initFrontierDefenseData()
{
    shopPosition = < 4586, -4594, 208>
	shopAngles = <0, 180, 0>
	FD_spawnPosition = < 2919.59, -4426.63, 2242 >
	FD_spawnAngles = < 0, 0, 0 >
	FD_groundspawnPosition = < 2343, -5258, 128 >
	FD_groundspawnAngles = < 0, 135, 0 >
	
	FD_DropPodSpawns.append(< 2677, -5238, 127 >)
	FD_DropPodSpawns.append(< 5106, -4429, 143 >)
	FD_DropPodSpawns.append(< 3306, -3815, 644 >)

	int index = 1

    array<WaveEvent> wave1
	wave1.append(CreateWaitForTimeEvent( 1.0, 0 ) )
    waveEvents.append(wave1)
	index = 1
	array<WaveEvent> wave2
	wave2.append(CreateWaitForTimeEvent( 1.0, 0 ) )
    waveEvents.append(wave2)
	index = 1
	array<WaveEvent> wave3
	wave3.append(CreateWaitForTimeEvent( 1.0, 0 ) )
    waveEvents.append(wave3)
	index = 1
	array<WaveEvent> wave4
	wave4.append(CreateWaitForTimeEvent( 1.0, 0 ) )
    waveEvents.append(wave4)
	index = 1
	array<WaveEvent> wave5
	wave5.append(CreateWaitForTimeEvent( 1.0, 0 ) )
    waveEvents.append(wave5)
}