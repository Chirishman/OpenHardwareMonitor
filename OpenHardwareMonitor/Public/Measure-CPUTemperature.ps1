function Measure-CPUTemperature {
    Param(
        [OpenHardwareMonitor.Hardware.Computer]$HardwareMonitor = (New-HardwareMonitor -CPUEnabled)
    )
    
    $HardwareMonitor.Hardware.Update()
    $HardwareMonitor.Hardware.sensors |
        ?{$_.SensorType -eq 'Temperature' -and $_.Identifier -match 'cpu'} |
            Select @{
                N='CPU Core'
                E={
                    $ID = [int]($_.Identifier -split '/')[-1]
                    if (!$ID){
                        "CPU Package"
                    } else {
                        "CPU Core #$ID"
                    }
                }
            },@{
                N='CPU Core ID'
                E={
                    [int]($_.Identifier -split '/')[-1]
                }
            },@{
                N='Current Temperature'
                E={
                    $_.Value
                }
            },@{
                N='Minimum Observed'
                E={
                    $_.Min
                }
            },@{
                N='Maximum Observed'
                E={
                    $_.Max
                }
            } |
                Sort 'CPU Core ID' |
                    Select 'CPU Core','Current Temperature','Minimum Observed','Maximum Observed'
}