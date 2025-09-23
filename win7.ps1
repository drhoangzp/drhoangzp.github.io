[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
# Lấy thông tin hệ điều hành
$systemInfo = Get-WmiObject Win32_OperatingSystem
$bios = Get-WmiObject Win32_BIOS
$computerSystem = Get-WmiObject Win32_ComputerSystem

# Hiển thị thời gian hiện tại
$currentTime = Get-Date
Write-Host "Current Time: $($currentTime.ToString('yyyy-MM-dd HH:mm:ss'))`n"

# Hiển thị thông tin hệ thống cơ bản
Write-Host "Hostname: $($computerSystem.Name)"
Write-Host "Model: $($computerSystem.Model)"
Write-Host "PCSystemType: $($computerSystem.PCSystemType)`n"
Write-Host "Serial Number: $($bios.SerialNumber)"
Write-Host "Operating System: $($systemInfo.Caption)"
Write-Host "Registered Owner: $($systemInfo.RegisteredUser)"
Write-Host "Registered Organization: $($systemInfo.Organization)`n"

# Thông tin BIOS
$biosInfo = "BIOS Version: $($bios.Manufacturer) $($bios.Version), $($bios.ReleaseDate)"
Write-Host $biosInfo

# RAM
Write-Host "`nRAM Information:"
$memoryInfo = Get-WmiObject Win32_PhysicalMemory
$memoryInfo | ForEach-Object {
    $capacityGB = [math]::round($_.Capacity / 1GB, 0)
    Write-Host "Slot: $($_.DeviceLocator) - $capacityGB GB - Speed: $($_.Speed) MHz"
}

# Ổ cứng
Write-Host "`nDisk Information:"
Get-WmiObject Win32_DiskDrive | Select-Object Model, InterfaceType, Size | Format-Table -AutoSize

# CPU
Write-Host "`nCPU Information:"
$processor = Get-WmiObject Win32_Processor
$processor | ForEach-Object {
    Write-Host "Name: $($_.Name)"
    Write-Host "Cores: $($_.NumberOfCores)"
    Write-Host "Logical Processors: $($_.NumberOfLogicalProcessors)"
}

# GPU
Write-Host "`nGPU Information:"
$gpus = Get-WmiObject Win32_VideoController
$gpus | ForEach-Object {
    $ramGB = [math]::round($_.AdapterRAM / 1GB, 2)
    Write-Host "GPU: $($_.Caption) - RAM: $ramGB GB - Driver: $($_.DriverVersion)"
}

# Network
Write-Host "`nNetwork Adapters:"
$networkAdapters = Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object { $_.IPAddress -ne $null }
$networkAdapters | ForEach-Object {
    Write-Host "Adapter: $($_.Description)"
    Write-Host "IPv4: $($_.IPAddress | Where-Object { $_ -like '*.*.*.*' })"
    Write-Host "IPv6: $($_.IPAddress | Where-Object { $_ -like '*:*' })"
    Write-Host ""
}

# Battery - chỉ tạo báo cáo năng lượng (nếu có pin)
Write-Host "`nGenerating Energy Report (energy-report.html)..."
powercfg /energy /output "energy-report.html"
Write-Host "Energy report saved in: energy-report.html"
