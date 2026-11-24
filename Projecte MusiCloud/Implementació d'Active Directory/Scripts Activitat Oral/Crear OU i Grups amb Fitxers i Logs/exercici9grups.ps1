param(
    [Parameter(Mandatory=$true)]
    [string]$fitxer = ".\projectemusicloud\Implementació d'Active Directory\Scripts Activitat Oral\Grups\grups_exercici9.csv",
    [Parameter(Mandatory=$true)]
    [string]$ruta   = "DC=musiccloud,DC=local"
)
function Comprovar-Ruta {
    try {
        Get-ADObject -Identity $ruta -ErrorAction Stop | Out-Null
        return $true
    }
    catch {
        return $false
    }
}
function Crear-Grup {
    param([string]$nom)

    try {
        Get-ADGroup -Identity $nom -ErrorAction Stop | Out-Null
    }
    catch {
        New-ADGroup -Name $nom -Path $ruta -GroupScope $scope -GroupCategory $categoria -ErrorAction SilentlyContinue
    }
}