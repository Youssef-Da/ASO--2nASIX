# Passar OU i Grups a fitxers, que es pugui triar la ruta però que n'hi hagi una una per defecte. A més, que comprovi que el fitxer existeix.
param(
    [Parameter(Mandatory=$true)]
    [string]$fitxer = ".\projectemusicloud\Implementació d'Active Directory\Scripts Activitat Oral\Grups\ou_exercici9.csv",
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