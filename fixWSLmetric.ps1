# Get the original interface metric values
$originalCiscoMetric = (Get-NetAdapter | Where-Object {$_.InterfaceDescription -Match "Cisco AnyConnect"} | Get-NetIPInterface).InterfaceMetric
$originalWSLMetric = (Get-NetIPInterface -InterfaceAlias "vEthernet (WSL)").InterfaceMetric

# Temporarily set the interface metric values
Get-NetAdapter | Where-Object {$_.InterfaceDescription -Match "Cisco AnyConnect"} | Set-NetIPInterface -InterfaceMetric 4000
Get-NetIPInterface -InterfaceAlias "vEthernet (WSL)" | Set-NetIPInterface -InterfaceMetric 1

# Pause the script until a key is struck
Write-Host "Press any key to continue ..."
$null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

# Restore the original interface metric values
Get-NetAdapter | Where-Object {$_.InterfaceDescription -Match "Cisco AnyConnect"} | Set-NetIPInterface -InterfaceMetric $originalCiscoMetric
Get-NetIPInterface -InterfaceAlias "vEthernet (WSL)" | Set-NetIPInterface -InterfaceMetric $originalWSLMetric
