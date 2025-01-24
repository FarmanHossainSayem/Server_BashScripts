# Define the servers/machines to check
$servers = @("codd.bard.edu", "eros.bard.edu", "RKC-GOLAB-BASEM")

# Loop through each server and test the connection
foreach ($server in $servers) {
    # Test the connection using Test-Connection (Pings the server)
    $connectionStatus = Test-Connection -ComputerName $server -Count 1 -Quiet
    
    if ($connectionStatus) {
        Write-Host "$server is reachable." -ForegroundColor Green
    } else {
        Write-Host "$server is not reachable." -ForegroundColor Red
    }
}
