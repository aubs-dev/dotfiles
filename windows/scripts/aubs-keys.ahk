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
#]:: ; Windows + Enter
    windowTitle := "RuneLite - ChariotNord"
    WinGet, windowState, MinMax, %windowTitle%

    if (windowState = -1) {
        ; Restore window if minimized
        WinActivate, %windowTitle%
        WinRestore, %windowTitle%
    } else {
        if WinActive(windowTitle) {
            ; Minimize if active
            WinActivate, %windowTitle%
            WinMinimize, %windowTitle%
        } else {
            ; Focus the window if it's inactive
            WinActivate, %windowTitle%
        }
    }
return