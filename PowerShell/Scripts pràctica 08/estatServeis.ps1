
$serveis = Get-Service
$totalServeis = $serveis.Count

$serveisEnExecucio = @($serveis | Where-Object { $_.Status -eq "Running" }).Count
$serveisNoExecutats = @($serveis | Where-Object { $_.Status -ne "Running" }).Count


Write-Host "===== ESTAT DELS SERVEIS ====="
Write-Host ""
Write-Host "Total: $totalServeis"
Write-Host "Running: $serveisEnExecucio"
Write-Host "Not running: $serveisNoExecutats"