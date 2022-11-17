```
(        )     )    *            *                 (      (       ) (                   (    (        (     
 )\ )  ( /(  ( /(  (  `         (  `    (       (   )\ )   )\ ) ( /( )\ )  *   )   (     )\ ) )\ )     )\ )  
(()/(  )\()) )\()) )\))(    (   )\))(   )\      )\ (()/(  (()/( )\()|()/(` )  /(   )\   (()/((()/( (  (()/(  
 /(_))((_)\ ((_)\ ((_)()\   )\ ((_)()((((_)(  (((_) /(_))  /(_)|(_)\ /(_))( )(_)|(((_)(  /(_))/(_)))\  /(_)) 
(_))_   ((_)  ((_)(_()((_) ((_)(_()((_)\ _ )\ )\___(_))   (_))  _((_|_)) (_(_()) )\ _ )\(_)) (_)) ((_)(_))   
 |   \ / _ \ / _ \|  \/  | | __|  \/  (_)_\(_|(/ __/ __|  |_ _|| \| / __||_   _| (_)_\(_) |  | |  | __| _ \  
 | |) | (_) | (_) | |\/| | | _|| |\/| |/ _ \  | (__\__ \   | | | .` \__ \  | |    / _ \ | |__| |__| _||   /  
 |___/ \___/ \___/|_|  |_| |___|_|  |_/_/ \_\  \___|___/  |___||_|\_|___/  |_|   /_/ \_\|____|____|___|_|_\  
 ```

# Doom Emacs Installer Script for Windows

Does your work require you to use windows for pretty much no reason other than they can't spy on you?!

Did they also turn off WSL for "security reasons"!? Did you find out that you can start the LXSSManager via an elevated command prompt but realize you would get busted eventually, and that just sounds like a pain?

Still need Emacs for your precious "ORG mode" and because it's a "free and open software" Have I got the project for you!

Automatic install of doom emacs on windows systems

It will do it all, 
  * install emacs, 
  * set up all the path environmental variables for you, 
  * as well as download and "install" doom emacs.
  * create a startup script for starting a server on login
  * It will also set up a nice desktop shortcut for you (that will try and connect to an emacs 'server' and if it doesn't find one, start it itself)

 
 Run PowerShell as admin, and paste this into Powershell
 
 `iwr -useb https://raw.githubusercontent.com/briantehowenerer/DoomEmacsInstall/main/installEmacs.ps1 | iex`
