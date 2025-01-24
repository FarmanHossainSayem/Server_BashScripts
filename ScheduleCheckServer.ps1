# Define parameters
$TaskName = "ServerConnectionCheck"
$PrimaryScriptPath = "C:\Users\BardCS-01\Downloads\FALL 2024\sysadmin project\connection_status_checker.ps1"  # Path to the primary script
$StartTime = (Get-Date).AddMinutes(1).ToString("HH:mm")  # Starts 1 minute from the current time

# Create the task trigger to run once initially and then repeat every 30 minutes
$TaskTrigger = New-ScheduledTaskTrigger -Once -At $StartTime -RepetitionInterval (New-TimeSpan -Minutes 30) -RepetitionDuration (New-TimeSpan -Days 1)
$TaskAction = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -WindowStyle Hidden -File `"$PrimaryScriptPath`""

# Check if the task already exists and remove it if it does
if (Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue) {
    Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false
}

# Register the new scheduled task
Register-ScheduledTask -TaskName $TaskName -Trigger $TaskTrigger -Action $TaskAction -RunLevel Highest -Description "Checks server connection status every 30 minutes."

Write-Host "Scheduled task '$TaskName' created successfully to run every 30 minutes."
