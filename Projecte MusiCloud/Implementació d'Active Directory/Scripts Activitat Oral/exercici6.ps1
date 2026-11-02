# 6. L'script ha de funcionar en totes les situacions

param(
    [Parameter(Mandatory=$true)]
    [string]$nomOU,
    [Parameter(Mandatory=$false)]
    [string]$ruta = "DC=musiccloud,DC=local"
)

try {
    Get-ADObject -Identity $ruta -ErrorAction Stop | Out-Null
}
catch {
    Write-Host "La ruta '$ruta' no existeix. Comprova la ruta i torna-ho a intentar."
    exit 1
}

try {
    $OU = Get-ADOrganizationalUnit -Identity "OU=$nomOU,$ruta" -ErrorAction Stop
}
catch {
    $OU = $null
}

if ($OU) {
    Write-Host "La OU '$nomOU' ja existeix a la ruta '$ruta'. No cal crear-la."
}
else {
    try {
        New-ADOrganizationalUnit -Name $nomOU -Path $ruta -ErrorAction Stop
        Write-Host "La OU '$nomOU' s'ha creat a la ruta '$ruta'."
    }
    catch {
        Write-Host "No s'ha pogut crear la OU '$nomOU': $($_.Exception.Message)"
        exit 1
    }
}