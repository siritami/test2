; Open Command Prompt
Run "cmd.exe"
WinWaitActive "ahk_class ConsoleWindowClass"

; Close the Command Prompt window
Send "exit{Enter}"
Sleep 5000  ; Wait a moment for the window to close

; Reopen Command Prompt
Run "cmd.exe"
WinWaitActive "ahk_class ConsoleWindowClass"

; Type the first command and press Enter
Send "cd D:\a\test2\test2\{Enter}"

; Type the second command and press Enter
Send "java -jar revanced-cli.jar patch -p patches.rvp -o D:\a\test2\test2\release\youtube-revanced-extended.apk youtube.apk{Enter}"

; Stop the script
ExitApp
