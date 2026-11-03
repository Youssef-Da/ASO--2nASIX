$elements = Get-ChildItem

$fitxers = $elements | Where-Object { -not $_.PSIsContainer }

$cincMesGrans = $fitxers |
    Sort-Object -Property Length -Descending |
    Select-Object -First 5 -Property Name, Length

Write-Host "===== ANÀLISI DE LA CARPETA ====="
Write-Host ""
Write-Host "Nombre total d'elements: $(@($elements).Count)"
Write-Host ""
Write-Host "Els cinc fitxers més grans (mida en bytes):"
$cincMesGrans | Format-Table -AutoSize | Out-Host