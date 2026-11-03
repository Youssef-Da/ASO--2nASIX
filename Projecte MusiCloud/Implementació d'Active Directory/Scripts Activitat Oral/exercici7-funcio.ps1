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
        return $false
    }
}

function Crear-OU {
    param(
        [string[]]$nomOU,
        [string]$ruta
    )

    foreach ($nom in $nomOU) {

        try {
            $OU = Get-ADOrganizationalUnit -Identity "OU=$nom,$ruta" -ErrorAction Stop
        }
        catch {
            $OU = $null
        }
        if ($OU -eq $null) {    
            try {
                New-ADOrganizationalUnit -Name $nom -Path $ruta -ErrorAction Stop
            }
            catch {
                continue
            }
        }
    }
}