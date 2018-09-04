function tasks-run-in-last-x-hours([int]$hours) {
    Get-ScheduledTask | Where-Object { ($_ | Get-ScheduledTaskInfo).LastRunTime -GT (Get-Date).AddHours(-$hours) }
}
