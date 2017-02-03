# To configure this file to be dot sourced, do the following:
#   1) code $env:userprofile\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
#   2) Add the following line of code to the top of the file and save:
#      . C:\projects\settings-and-config\profile.ps1

Set-Location ~

# NPM
function npm_install { npm install $args }
Set-Alias ni npm_install -Force -Option AllScope
function nis { npm install --save $args }
function nid { npm install --save-dev $args }
function nr { npm run $args }

# Git
function amend { git commit --amend }
function merge { git mergetool }
function gs { git status $args }
function git_checkout { git checkout $args }
Set-Alias gc git_checkout -Force -Option AllScope
function gcm { git checkout master }
function gr { git rebase $args }
function grc { git rebase --continue }
function gro { git rebase origin/master $args }
function gru { git rebase upstream/master $args }
function gf { git fetch --all $args }
function gb { git branch $args }
function git_push { git push $args }
Set-Alias gp git_push -Force -Option AllScope
function rewrite {
  git filter-branch --env-filter "export GIT_COMMITTER_NAME='Massimo Hamilton' && export GIT_COMMITTER_EMAIL=massimo.hamilton@outlook.com && export GIT_AUTHOR_NAME='Massimo Hamilton' && export GIT_AUTHOR_EMAIL=massimo.hamilton@outlook.com" -- --branches
}
function pr {
  new-pull-request origin "/compare/master..."
}
function pru {
  new-pull-request upstream "/compare/master...massimocode:"
}
function new-pull-request {
  (git log HEAD...HEAD^)[4].Trim() | clip
  $branchName = (git branch | Where-Object {$_.trim().indexOf("*") -eq 0}).Substring(2);
  $prUrl = (git remote show $args[0])[1].Trim()
  $prUrl = $prUrl.Substring(11, $prUrl.Length - 15) + $args[1] + $branchName;
  Start-Process microsoft-edge:$($prUrl);
}
function deleteoldbranches
{
  git remote prune origin
  git branch --merged |
    ForEach-Object { $_.Trim() } |
    Where-Object {$_ -NotMatch "^\*"} |
    Where-Object {-not ( $_ -Like "*master" )} |
    ForEach-Object { git branch -d $_ }
}

# Navigation
function proj { Set-Location "C:\projects" }

# General
function exp { explorer . }
function ep { code C:\projects\settings-and-config\profile.ps1 }
function epl { code $env:userprofile\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 }
function code { code-insiders $args }
function gulp { node node_modules/gulp/bin/gulp $args }
function tslint { node node_modules/tslint/bin/tslint $args }
function tsc { node node_modules/typescript/bin/tsc $args }
function msbuild { & "C:\Program Files (x86)\MSBuild\14.0\Bin\MSBuild.exe" $args }
function open {
  $solutionFile = Get-ChildItem '.' *.sln -Recurse | Select-Object -First 1;
  if ($solutionFile) {
    Start-Process $solutionFile.FullName -WorkingDirectory $solutionFile.DirectoryName
  }
}
function build {
  $solutionFile = Get-ChildItem '.' *.sln -Recurse | Select-Object -First 1;
  if ($solutionFile) {
    & "C:\Program Files (x86)\NuGet\Visual Studio 2015\nuget.exe" restore $solutionFile
    msbuild $solutionFile
  }
}
function p {
  ping www.google.co.uk -t
}
function hosts { code c:\windows\system32\drivers\etc\hosts }
function changeextension {
  $ext1 = $args[0];
  $ext2 = $args[1];
  Get-ChildItem ('*.' + $ext1) | Rename-Item -newname {  $_.name  -replace ("." + $ext1), ("." + $ext2)  }
}