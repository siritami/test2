; Open Command Prompt
Run "cmd.exe"
WinWaitActive "ahk_class ConsoleWindowClass"

; Add a delay of 2 seconds (2000 milliseconds)
Sleep 2000

; Type the first command and press Enter
Send "D:\a\test2\test2\src\etc\RefreshEnv.cmd{Enter}"
Sleep 5000

; Type
Send "java -jar D:\a\test2\test2\revanced-cli.jar patch -p D:\a\test2\test2\patches.rvp -o D:\a\test2\test2\release\youtube-revanced-extended.apk D:\a\test2\test2\youtube.apk{Enter}"

; Stop the script
ExitApp