# Email settings
$emailFrom = "fs2606@bard.edu"
$emailTo = "rgraff@bard.edu"
$smtpServer = ""  # Fill in your SMTP server
$smtpPort = 587   # Adjust if needed; commonly 587 for TLS or 25 for non-secure
$username = ""    # Username for SMTP server authentication
$password = ""    # Password for SMTP server authentication

# Email subject and body
$subject = "Server Connection Status Report"

# Email content
$logFile = "C:\Users\BardCS-01\Downloads\Fall 2024\sysadmin_project\email_alert\ping_results.log"
$body = Get-Content -Path $logFile | Out-String  # Read the log file content as email body

# Check if the current time is midnight or 6am
$currentHour = (Get-Date).Hour
if ($currentHour -eq 0 -or $currentHour -eq 6) {
    # Send the email using Send-MailMessage
    Send-MailMessage -From $emailFrom -To $emailTo -Subject $subject -Body $body -SmtpServer $smtpServer -Port $smtpPort `
                     -Credential (New-Object PSCredential -ArgumentList $username, (ConvertTo-SecureString $password -AsPlainText -Force)) `
                     -UseSsl
    Write-Host "Email sent successfully."
} else {
    Write-Host "Current time is not midnight or 6am. Email will not be sent."
}