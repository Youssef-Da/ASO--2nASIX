# 8. L'script amb funcions per crear grups
param(
    [Parameter(Mandatory=$true)]
    [string[]]$nomGrup,
    [Parameter(Mandatory=$false)]
    [string]$ruta = "DC=musiccloud,DC=local",
    [Parameter(Mandatory=$false)]
    [string]$scope = "Global",
    [Parameter(Mandatory=$false)]
    [string]$categoria = "Security"
)