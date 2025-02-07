#SingleInstance, Force

; --- Close active window
#IfWinNotActive,Program Manager
#q::
    Keywait,q
    WinGetTitle,curTitle,A
    if (curTitle != "Program Manager")
        Send !{F4}
return

; --- Minimize active window
#IfWinNotActive,Program Manager
#+f::
    Keywait, f
    WinGetTitle, curTitle, A
    if (curTitle != "Program Manager") {
        WinMinimize, A
    }
return

; --- Toggle minimize/maximize for active window
#f::
    WinGet, curState, MinMax, A
    if (curState = 1) {
        WinRestore, A ; Restore the window
    } else {
        WinMaximize, A ; Otherwise, maximize the window
    }
return

; --- Focus Runelite
#Enter:: ; Windows + Enter
    windowTitle := "RuneLite - HistoricClio"
    WinGet, windowState, MinMax, %windowTitle%

    if (windowState = -1) {
        ; Restore window if minimized
        WinActivate, 
        WinRestore, %windowTitle%
    } else {
        ; Otherwise, minimize window
        WinActivate, %windowTitle%
        WinMinimize, %windowTitle%
    }

    ; Center window on screen
    WinGetPos, winX, winY, winWidth, winHeight, %windowTitle%
    SysGet, screenWidth, 78 ; Screen width
    SysGet, screenHeight, 79 ; Screen height

    newX := (screenWidth - winWidth) // 2 ; Calculate new X position
    newY := (screenHeight - winHeight) // 2 ; Calculate new Y position

    WinMove, %windowTitle%, , newX, newY
return