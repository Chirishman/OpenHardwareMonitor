function New-HardwareMonitor {
    Param(
        [switch]$MainboardEnabled,
        [switch]$CPUEnabled,
        [switch]$RAMEnabled,
        [switch]$GPUEnabled,
        [switch]$FanControllerEnabled,
        [switch]$HDDEnabled
    )
    
    $HardwareMonitor = [OpenHardwareMonitor.Hardware.Computer]::new()
    
    $MonitorSwitches = @{
        MainboardEnabled = $MainboardEnabled
        CPUEnabled = $CPUEnabled
        RAMEnabled = $RAMEnabled
        GPUEnabled = $GPUEnabled
        FanControllerEnabled = $FanControllerEnabled
        HDDEnabled = $HDDEnabled
    }
    
    $MonitorSwitches.GetEnumerator() | %{
        $HardwareMonitor.($_.Key) = $_.Value
    }
    $HardwareMonitor.Open()

    $HardwareMonitor
}