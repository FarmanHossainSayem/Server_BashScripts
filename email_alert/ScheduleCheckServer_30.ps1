# Define parameters for the primary task
$TaskName = "ServerConnectionCheck"
$PrimaryScriptPath = "C:\Users\BardCS-01\Downloads\FALL 2024\sysadmin_project\email_alert\connection_status_checker.ps1"  # Path to the primary script
$StartTime = (Get-Date).AddMinutes(1).ToString("HH:mm")  # Starts 1 minute from the current time

# Define parameters for the email sending task
$EmailTaskName = "SendPingResults"
$EmailScriptPath = "C:\Users\BardCS-01\Downloads\FALL 2024\sysadmin_project\email_alert\SendResults.ps1"  # Path to the email script

# Create the task trigger to run once initially and then repeat every 30 minutes
$TaskTrigger = New-ScheduledTaskTrigger -Once -At $StartTime -RepetitionInterval (New-TimeSpan -Minutes 30) -RepetitionDuration (New-TimeSpan -Days 1)
$TaskAction = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -WindowStyle Hidden -File `"$PrimaryScriptPath`""

# Check if the primary task already exists and remove it if it does
if (Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue) {
    Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false
}

# Register the primary scheduled task
Register-ScheduledTask -TaskName $TaskName -Trigger $TaskTrigger -Action $TaskAction -RunLevel Highest -Description "Checks server connection status every 30 minutes."
Write-Host "Scheduled task '$TaskName' created successfully to run every 30 minutes."


# Create the task trigger for the email script to run every 30 minutes
$EmailTaskTrigger = New-ScheduledTaskTrigger -Once -At $StartTime -RepetitionInterval (New-TimeSpan -Minutes 30) -RepetitionDuration (New-TimeSpan -Days 1)
$EmailTaskAction = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -WindowStyle Hidden -File `"$EmailScriptPath`""

# Check if the email task already exists and remove it if it does
if (Get-ScheduledTask -TaskName $EmailTaskName -ErrorAction SilentlyContinue) {
    Unregister-ScheduledTask -TaskName $EmailTaskName -Confirm:$false
}

# Register the new scheduled task for sending email
Register-ScheduledTask -TaskName $EmailTaskName -Trigger $EmailTaskTrigger -Action $EmailTaskAction -RunLevel Highest -Description "Sends email report at midnight and 6am."
Write-Host "Scheduled task '$EmailTaskName' created successfully to check for email sending times."
