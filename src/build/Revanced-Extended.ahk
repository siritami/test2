; Open Command Prompt
Run "cmd.exe"
WinWaitActive "ahk_class ConsoleWindowClass"

; Add a delay of 2 seconds (2000 milliseconds)
Sleep 2000

; Type the first command and press Enter
Send "D:\a\test2\test2\src\etc\RefreshEnv.cmd{Enter}"
Sleep 5000

; Type
Send "cd /d D:\{Enter}"
Sleep 1000
Send "D:\a\test2\test2{Enter}"
Sleep 1000

; Type
Send "java -jar revanced-cli.jar patch -p patches.rvp youtube.apk{Enter}"
Sleep 1000

; Stop the script
ExitApp
