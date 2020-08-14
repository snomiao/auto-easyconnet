#SingleInstance Force
; fprc 崩掉自动重启
While, 1 {
    Process, Exist, frpc.exe
    If (ErrorLevel == 0) {
        RunWait %A_ScriptDir%/frpc.exe, 
        TrayTip, % 启动 frpc
    }
    Sleep 5000
}