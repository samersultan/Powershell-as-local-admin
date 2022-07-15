<#
......
Add to start of script to run as local admin 
Source: https://petri.com/run-powershell-scripts-with-administrative-privileges
Source: https://old.reddit.com/r/usefulscripts/comments/779y4v/run_a_powershell_script_as_a_local_administrator/
......
#> 

param([switch]$Elevated)

function Test-Admin {
  $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
    if ($elevated) 
    {
        # tried to elevate, did not work, aborting
    } 
    else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
}

exit
}

'running with full privileges'

<#
......
End of local Admin Script 
......
#> 
