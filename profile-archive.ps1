# Download the RDP script if we don't already have it
if (-not (Test-Path "$env:userprofile\Connect-Mstsc.ps1")) {
  Invoke-WebRequest -Uri https://gallery.technet.microsoft.com/scriptcenter/Connect-Mstsc-Open-RDP-2064b10b/file/76025/9/Connect-Mstsc.ps1 -OutFile "$env:userprofile\Connect-Mstsc.ps1"
}
. "$env:userprofile\Connect-Mstsc.ps1"

function awsprofile {
  code $env:userprofile\.aws
}
function killprocess {
  Stop-Process -Force -Name $args
}
Set-Alias kill killprocess -Force -Option AllScope
function ssh {
  $sshPath = "$env:userprofile\OpenSSH-Win64\ssh.exe"
  if (-not (Test-Path $sshPath)) {
    Invoke-WebRequest "https://github.com/PowerShell/Win32-OpenSSH/releases/download/v0.0.20.0/OpenSSH-Win64.zip" -OutFile "$env:userprofile\OpenSSH-Win64.zip"
    Expand-Archive .\OpenSSH-Win64.zip -DestinationPath .
    Remove-Item .\OpenSSH-Win64.zip
  }
  & "$env:userprofile\OpenSSH-Win64\ssh.exe" $args
}
