## to do task list.
##install chocolaty
##install emacs ripgrep fd git
##set $PATH veriables 
## run doom install script
## set up emacs server
## add shortcut to desktop for client




Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco install git ripgrep fd git -y 


##This bit of code writes the new $PATH value to the registry... yes windows is this stupid you have to read the old value, add yours to it, and write it back whole hog.
$LoggedInUser = $env:UserName
$NewPathData = "C:\Users\"+ $LoggedInUser +"\.emacs.d\bin" +":"+ "C:\Users\"+ $LoggedInUser +"\.emacs.d\bin"
$RegistryPath = "Registry::HKLM\System\CurrentControlSet\Control\Session Manager\Environment"
$OldPathData = (Get-ItemProperty -Path "$RegistryPath" -Name PATH).Path
$FinalPathData = $OldPathData + ":" + $NewPathData
Set-ItemProperty -Path "$RegistryPath" -Name PATH -Value $FinalPathData

$EnvVeriableHOMEData = "C:\Users\"+$LoggedInUser+"\"
Set-ItemProperty -Path "$RegistryPath" -Name HOME -Value $EnvVeriableHOMEData
