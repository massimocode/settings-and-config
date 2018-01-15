mkdir -Force "$env:userprofile\Documents\WindowsPowerShell"
Write-Output ". C:\projects\settings-and-config\profile.ps1" >> "$env:userprofile\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
npm config set package-lock false
git config --global include.path "C:\projects\settings-and-config\.gitconfig"
