# 7. L'script ha de ser amb funcions
param(
    [Parameter(Mandatory=$true)]
    [string[]]$nomOU,
    [Parameter(Mandatory=$false)]
    [string]$ruta = "DC=musiccloud,DC=local"
)

function Comprovar-Ruta {
    param(
        [string]$ruta
    )

    try {
        Get-ADObject -Identity $ruta -ErrorAction Stop | Out-Null
        return $true
    }
    catch {
        Write-Host "La ruta '$ruta' no existeix. Comprova la ruta i torna-ho a intentar."
        return $false
    }
}

try {
    Get-ADObject -Identity $ruta -ErrorAction Stop | Out-Null
}
catch {
    Write-Host "La ruta '$ruta' no existeix. Comprova la ruta i torna-ho a intentar."
    exit 1
}

foreach ($nom in $nomOU) {

    try {
        $OU = Get-ADOrganizationalUnit -Identity "OU=$nom,$ruta" -ErrorAction Stop
        Write-Host "La OU '$nom' ja existeix a la ruta '$ruta'. No cal crear-la."
    }
    catch {
        try {
            New-ADOrganizationalUnit -Name $nom -Path $ruta -ErrorAction Stop
            Write-Host "La OU '$nom' s'ha creat a la ruta '$ruta'."
        }
        catch {
            Write-Host "No s'ha pogut crear la OU '$nom': $($_.Exception.Message)"
        }
    }
} 