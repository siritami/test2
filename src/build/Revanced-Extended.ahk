; Open Command Prompt
Run "cmd.exe"
WinWaitActive "ahk_class ConsoleWindowClass"

; Delay for 1 second after the Command Prompt is active
Sleep, 2000

; Type the first command and press Enter
Send "cd D:\a\test2\test2\{Enter}"

; Delay for 1 second after the first command
Sleep, 1000

; Type the second command and press Enter
Send "java -jar revanced-cli.jar patch -p patches.rvp -o D:\a\test2\test2\release\youtube-revanced-extended.apk youtube.apk{Enter}"

; Delay for 2 seconds before stopping the script
Sleep, 2000

; Stop the script
ExitApp
