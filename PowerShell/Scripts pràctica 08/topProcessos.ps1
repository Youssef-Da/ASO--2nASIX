$processos = Get-Process

$topProcessos = $processos |
    Sort-Object -Property CPU -Descending |
    Select-Object -First 10 -Property Name, Id, CPU

Write-Host "===== 10 PROCESSOS AMB MÉS CPU ====="
$topProcessos | Format-Table -AutoSize | Out-Host

Write-Host "Nombre total de processos: $($processos.Count)"