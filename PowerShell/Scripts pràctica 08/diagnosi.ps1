Write-Host "===== DIAGNOSI DEL SISTEMA ====="
Write-Host ""

$totsElsProcessos = Get-Process
$topProcessos = $totsElsProcessos |
    Sort-Object -Property CPU -Descending |
    Select-Object -First 5 -Property Name, Id, CPU

Write-Host "--- Processos (5 amb més CPU) ---"
$topProcessos | Format-Table -AutoSize | Out-Host

$serveis = Get-Service
$totalServeis = $serveis.Count
$serveisEnExecucio = @($serveis | Where-Object { $_.Status -eq "Running" }).Count
$serveisNoExecutats = @($serveis | Where-Object { $_.Status -ne "Running" }).Count

Write-Host "--- Serveis ---"
Write-Host "Total de serveis: $totalServeis"
Write-Host "Serveis en execució: $serveisEnExecucio"
Write-Host "Serveis no executats: $serveisNoExecutats"
Write-Host ""

$fitxers = Get-ChildItem | Where-Object { -not $_.PSIsContainer }
$tresMesGrans = $fitxers |
    Sort-Object -Property Length -Descending |
    Select-Object -First 3 -Property Name, Length

Write-Host "--- Fitxers (3 més grans de la carpeta actual) ---"
$tresMesGrans | Format-Table -AutoSize | Out-Host

Write-Host "===== RESUM ====="
Write-Host ""
Write-Host "Processos analitzats: $(@($totsElsProcessos).Count)"
Write-Host "Serveis analitzats: $totalServeis"
Write-Host "Fitxers analitzats: $(@($fitxers).Count)"