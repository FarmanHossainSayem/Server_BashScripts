# Email settings
$emailFrom = "your-email@domain.com"
$emailTo = "rgraff@bard.edu"
$smtpServer = "your-smtp-server"
$smtpPort = 587  # Adjust the port as needed for your SMTP server
$username = ""  # Leave blank, to be filled in later
$password = ""  # Leave blank, to be filled in later

# Email content
$logFile = "C:\Users\BardCS-01\Downloads\Fall 2024\sysadmin project\email_alert\ping_results.log"
$subject = "Server Connection Status Report"
$body = Get-Content -Path $logFile | Out-String  # Read the log file content

# Check if the current time is midnight or 6am
$currentHour = (Get-Date).Hour
if ($currentHour -eq 0 -or $currentHour -eq 6) {
    # Create the email message
    $message = New-Object System.Net.Mail.MailMessage
    $message.From = $emailFrom
    $message.To.Add($emailTo)
    $message.Subject = $subject
    $message.Body = $body
    $message.IsBodyHtml = $false

    # Set up the SMTP client and credentials
    $smtp = New-Object System.Net.Mail.SmtpClient($smtpServer, $smtpPort)
    $smtp.EnableSsl = $true
    $smtp.Credentials = New-Object System.Net.NetworkCredential($username, $password)

    # Send the email
    try {
        $smtp.Send($message)
        Write-Host "Email sent successfully."
    } catch {
        Write-Host "Failed to send email: $_"
    }
} else {
    Write-Host "Current time is not midnight or 6am. Email will not be sent."
}
