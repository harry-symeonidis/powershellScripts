# Get the original interface metric values
$originalCiscoMetrics = Get-NetAdapter | Where-Object {$_.InterfaceDescription -Match "Cisco AnyConnect"} | Get-NetIPInterface | Select-Object -Property InterfaceAlias, InterfaceMetric
$originalWSLMetrics = Get-NetIPInterface -InterfaceAlias "vEthernet (WSL)" | Select-Object -Property InterfaceAlias, InterfaceMetric

# Temporarily set the interface metric values
$originalCiscoMetrics | ForEach-Object {Set-NetIPInterface -InterfaceAlias $_.InterfaceAlias -InterfaceMetric 4000}
$originalWSLMetrics | ForEach-Object {Set-NetIPInterface -InterfaceAlias $_.InterfaceAlias -InterfaceMetric 1}

# Pause the script until a key is struck
Write-Host "Press any key to continue ..."
$null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

# Restore the original interface metric values
$originalCiscoMetrics | ForEach-Object {Set-NetIPInterface -InterfaceAlias $_.InterfaceAlias -InterfaceMetric $_.InterfaceMetric}
$originalWSLMetrics | ForEach-Object {Set-NetIPInterface -InterfaceAlias $_.InterfaceAlias -InterfaceMetric $_.InterfaceMetric}
