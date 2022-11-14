## to do task list.
##install chocolaty             ✓
##install emacs ripgrep fd git  ✓
##set $PATH veriables           ✓
## run doom install script
## set up emacs server
## add Shortcut to desktop for client
## Install all-the-icons font  https://github.com/domtronn/all-the-icons.el/tree/master/fonts

$LoggedInUser = $env:UserName


function SetEnvironmentalVeriables {
    ##This bit of code writes the new $PATH value to the registry... yes windows is this stupid you have to read the old value, add yours to it, and write it back whole hog.
    $LoggedInUser = $env:UserName

    $NewPathData = "C:\Users\" + $LoggedInUser + "\.emacs.d\bin" + ":" + "C:\Users\" + $LoggedInUser + "\.emacs.d\bin"
    #Set registry key
    $RegistryPath = "Registry::HKLM\System\CurrentControlSet\Control\Session Manager\Environment"
    #pull current registry key data
    $OldPathData = (Get-ItemProperty -Path "$RegistryPath" -Name PATH).Path
    #create the final string
    $FinalPathData = $OldPathData + ":" + $NewPathData
    #write string back to registry for PATH
    Set-ItemProperty -Path "$RegistryPath" -Name PATH -Value $FinalPathData

    #Create the "HOME" path for emacs, so it uses that insted of the appdata folder.
    $EnvVeriableHOMEData = "C:\Users\" + $LoggedInUser + "\"
    Set-ItemProperty -Path "$RegistryPath" -Name HOME -Value $EnvVeriableHOMEData
}

functon installchco {
    #Installs chocolatey and requried software
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    choco install git ripgrep fd git -y 
    choco install git ripgrep fd git -y 
}

function EmacsShortcuts {
    $LoggedInUser = $env:UserName
    $ShortcutPath = "C:\Users\" + $LoggedInUser + "\Desktop\DoomEmacs.lnk"
    $SourceFilePath = "C:\Program Files\Emacs\emacs-28.1\bin\emacsclientw.exe"
    $WScriptObj = New-Object -ComObject ("WScript.Shell")
    $Shortcut = $WscriptObj.CreateShortcut($ShortcutPath)
    $Shortcut.TargetPath = $SourceFilePath
    $Shortcut.Arguments = "-n -c -a `" `""
    $Shortcut.Save()

}