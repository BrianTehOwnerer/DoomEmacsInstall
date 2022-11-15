$LoggedInUser = $env:UserName
Function Main {
    Clear-Host    
    Write-Host -Object "This will Download and install and set up everything you need to run doom emacs."
    Write-Host -Object "You should not need to do anything besides click on the new shortcut on your desktop."
    Write-Host -Object "There will be errors, Especially in the font installs portion of this script. It's a dumb windows thing."  
    $lambda = Read-Host "press any key to continue"    
    Do {
         Clear-Host 
         Write-Host -Object '**********************'
         Write-Host -Object 'Emacs+Doom Installer' -ForegroundColor Yellow
        Write-Host -Object '**********************'
        Write-Host -Object '1.  Run the whole script please. Install and set up everything because I am lazy. '
        Write-Host -Object ''
        Write-Host -Object '2.  Just emacs please! '
        Write-Host -Object ''
        Write-Host -Object '3.  One order of DOOM for my already installed Emacs '
        Write-Host -Object ''
        Write-Host -Object '4.  give me all-the-icons.ttf ! '
        Write-Host -Object ''
        Write-Host -Object '5.  Just the aweful environmental Veriables for me. '
        Write-Host -Object $errout
        $Menu = Read-Host -Prompt '(0-5 or Q to Quit)'
        switch ($Menu) {
            1 {
                SetEnvironmentalVeriables
                InstallChco
                GitDoom
                InstallDoom
                EmacsShortcuts
                EmacsServer
                InstallFonts
                anyKey
            }
            2 {
                InstallChco
                anyKey
            }
            3 {
                GitDoom
                InstallDoom
                anyKey
            }
            4 {
                InstallFonts
                anyKey
            }
            5 {
                SetEnvironmentalVeriables
                anyKey
            }
            Q {
                Exit
            }   
            default {
                $errout = 'Invalid option please try again........Try 0-5 or Q only'
            }
        }
    }
    until ($Menu -eq 'Q')
}   


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

function InstallChco {     
    #Installs chocolatey and requried software
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    choco install git ripgrep fd git -y 
}

function GitDoom {
    git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
}

function InstallDoom {
    ~/.emacs.d/bin/doom.cmd install 
}

function EmacsShortcuts {
    #creating a shortcut in for emacs onto your desktop.
    $LoggedInUser = $env:UserName
    $ShortcutPath = "C:\Users\" + $LoggedInUser + "\Desktop\DoomEmacs.lnk"
    $SourceFilePath = "C:\Program Files\Emacs\emacs-28.1\bin\emacsclientw.exe"
    $WScriptObj = New-Object -ComObject ("WScript.Shell")
    $Shortcut = $WscriptObj.CreateShortcut($ShortcutPath)
    $Shortcut.TargetPath = $SourceFilePath
    $Shortcut.Arguments = "-n -c -a `"`""
    $Shortcut.Save()
}

function EmacsServer {
    #this drops a batch file into your startup folder, to start the server on startup.

    #Sets the target file
    $serverstartfile = $env:APPDATA + "\Microsoft\Windows\Start Menu\Programs\Startup\EmacsServerStartup.bat"
    #in case you decide to run this script again, delete the old file to make sure you didn't screw something up.
    del $serverstartfile -Force
    "rem Sets HOME for current shell" | out-file $serverstartfile -Append
    "set HOME=%APPDATA%" | out-file $serverstartfile -Append
    "rem Clean previous server file info first" | out-file $serverstartfile -Append
    "del /q ""%HOME%\\.emacs.d\\server\\*""" | out-file $serverstartfile -Append
    "`"C:\Program Files\Emacs\emacs-28.1\bin\runemacs.exe`" --daemon -c `"`"(setq default-directory `"~/`")`"`"" | out-file $serverstartfile -Append
}

Function InstallFonts {
    #Download the fonts from the all-the-icons github and then install them.
    $TempFontFolder = $env:TEMP + "\all-the-icons\"
    mkdir $TempFontFolder 
    $TempFontFolder = $env:TEMP + "\all-the-icons\all-the-icons.ttf"
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/domtronn/all-the-icons.el/master/fonts/all-the-icons.ttf -OutFile $TempFontFolder
    $TempFontFolder = $env:TEMP + "\all-the-icons\file-icons.ttf"
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/domtronn/all-the-icons.el/master/fonts/file-icons.ttf -OutFile $TempFontFolder
    $TempFontFolder = $env:TEMP + "\all-the-icons\fontawesome.ttf"
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/domtronn/all-the-icons.el/master/fonts/fontawesome.ttf -OutFile $TempFontFolder
    $TempFontFolder = $env:TEMP + "\all-the-icons\octicons.ttf"
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/domtronn/all-the-icons.el/master/fonts/octicons.ttf -OutFile $TempFontFolder
    $TempFontFolder = $env:TEMP + "\all-the-icons\weathericons.ttf"
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/domtronn/all-the-icons.el/master/fonts/weathericons.ttf -OutFile $TempFontFolder
    # Now that we have all fonts downloaded to the TEMP folder, time to install them...
    # There will be errors here, but it should run through and install everything fine.

    $TempFontFolder = $env:TEMP + "\all-the-icons\"
    $fonts = (New-Object -ComObject Shell.Application).Namespace(0x14)
    foreach ($file in Get-ChildItem $TempFontFolder\*.ttf) {
        $fileName = $file.Name
        if (-not(Test-Path -Path "C:\Windows\fonts\$fileName" )) {
            Write-Output $fileName
            Get-ChildItem $file | ForEach-Object { $fonts.CopyHere($_.fullname) }
        }
    }
    Copy-Item *.ttf c:\windows\fonts\
}

#Time to actualy start the script
Main