#Script base per treballar amb fitxers

$servers = Import-Csv ".\Dades\servers.csv"
$i=0
wRITe-host $servers.COUNT

foreach ($server in $servers) {
    $i = $i + 1
    write-host "$i - $server.IPADDRESS"
}
#$servers

#Si volgues agafar tota la info d'un servidor en concret seria aixi:

$servers = Import-Csv ".\Dades\servers.csv"
$i=0
wRITe-host $servers.COUNT

$servers | where-Object -filter {$_.SERVERNAME -eq 'SRVWEB'} | Format-list

foreach ($server in $servers) {
    $i = $i + 1
    write-host "$i - $server.IPADDRESS"
}
#$servers


#Si volem tractar més protocols

$servers = Import-Csv ".\Dades\servers.csv"
$i=0
wRITe-host $servers.COUNT

$servers | where-Object -filter {$_.SERVERNAME -eq 'SRVWEB'} | Format-list

$protocols = Import-Csv ".\Dades\protocols.csv" | where-object -filter {$_.SERVERNAME -eq 'SRVWEB'}
$protocols

#Si l'arxiu no existeix fem aixo:

$FILE = ".\Dades\servers.csv"

if (Test-Path $FILE) {

    $servers = Import-Csv $FILE

    $servers
    $i=0
    write-host $servers.COUNT

    $servers | where-Object -filter {$_.SERVERNAME -eq 'SRVWEB'} | Format-list

    $protocols = Import-Csv ".\Dades\protocols.csv" | where-object -filter {$_.SERVERNAME -eq 'SRVWEB'}
    $protocols
    
}
