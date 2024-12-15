; Open Command Prompt
Run "cmd.exe"
WinWaitActive "ahk_class ConsoleWindowClass"

; Add a delay of 2 seconds (2000 milliseconds)
Sleep 2000

; Type the first command and press Enter
Send "D:\a\test2\test2\src\etc\RefreshEnv.cmd{Enter}"

; Stop the script
ExitApp