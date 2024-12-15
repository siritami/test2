; Open Command Prompt
Run "cmd.exe"
WinWaitActive "ahk_class ConsoleWindowClass"

; Close the Command Prompt
WinClose "ahk_class ConsoleWindowClass"
WinWaitClose "ahk_class ConsoleWindowClass"

; Reopen Command Prompt
Run "cmd.exe"
WinWaitActive "ahk_class ConsoleWindowClass"

; Type the first command and press Enter
Send "D:\a\test2\test2\src\etc\RefreshEnv.cmd{Enter}"

; Stop the script
ExitApp