$processos = Get-Process
$separador = "=" * 30

foreach ($proces in $processos) {

   
    Write-Host "$separador $($proces.Name) ($($proces.Id)) $separador"
    Write-Host ""

    Write-Host "Total threads: $($proces.Threads.Count)"
    Write-Host ""

    foreach ($fil in $proces.Threads) {
        try {
            $tempsCPU = $fil.TotalProcessorTime
        }
        catch {
            $tempsCPU = $null
        }
        Write-Host "ID: $($fil.Id) CPU TIME: $tempsCPU"
    }

    Write-Host ""
}