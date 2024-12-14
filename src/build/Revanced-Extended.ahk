; Open Command Prompt
Run "cmd.exe"
WinWaitActive "ahk_class ConsoleWindowClass"

; Sleep for 1 second (1000 ms) before killing Command Prompt
Sleep 1000

; Kill the Command Prompt process
Run "taskkill /IM cmd.exe /F", , "Hide"
WinWaitClose "ahk_class ConsoleWindowClass" ; Wait for the command window to close

; Sleep for 1 second after killing Command Prompt
Sleep 2000

; Reopen Command Prompt
Run "cmd.exe"
WinWaitActive "ahk_class ConsoleWindowClass"

; Type the first command and press Enter
Send "cd D:\a\test2\test2\{Enter}"

; Type the second command and press Enter
Send "java -jar revanced-cli.jar patch -p patches.rvp -o D:\a\test2\test2\release\youtube-revanced-extended.apk youtube.apk{Enter}"

; Stop the script
ExitApp
