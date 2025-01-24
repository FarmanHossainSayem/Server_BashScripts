# Define the servers/machines to check
$servers = @("codd.bard.edu", "eros.bard.edu", "RKC-GOLAB-BASEM")
$logFile = "C:\Users\BardCS-01\Downloads\Fall 2024\sysadmin_project\email_alert\ping_results.log"

# Get current date and time for logging
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$logContent = "$timestamp - Server Connection Status:`n"

# Loop through each server and test the connection
foreach ($server in $servers) {
    # Test the connection
    $connectionStatus = Test-Connection -ComputerName $server -Count 1 -Quiet
    if ($connectionStatus) {
        $logContent += "$server is reachable.`n"
    } else {
        $logContent += "$server is not reachable.`n"
    }
}

# Append results to log file
Add-Content -Path $logFile -Value $logContent
