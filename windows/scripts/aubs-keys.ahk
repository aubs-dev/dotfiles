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

; --- Focus Runelite (Main)
#]:: ; Windows + Enter
    windowTitle := "RuneLite - BelladonnaIM"
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

    ; Center window on screen
    WinGetPos, winX, winY, winWidth, winHeight, %windowTitle%
    SysGet, screenWidth, 78 ; Screen width
    SysGet, screenHeight, 79 ; Screen height

    WinGet cnt, Count, ahk_exe runelite.exe
    newX := 0

    if (cnt > 1) {
        newX := (screenWidth // 2) - winWidth - 15
    } else {
        newX := (screenWidth - winWidth) // 2
    }

    newY := (screenHeight - winHeight) // 2

    WinMove, %windowTitle%, , newX, newY
return

; --- Focus Runelite (Alt)
#[:: ; Windows + Enter
    windowTitle := "RuneLite - HistoricClio"
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

    ; Center window on screen
    WinGetPos, winX, winY, winWidth, winHeight, %windowTitle%
    SysGet, screenWidth, 78 ; Screen width
    SysGet, screenHeight, 79 ; Screen height

    WinGet cnt, Count, ahk_exe runelite.exe
    newX := 0

    if (cnt > 1) {
        newX := (screenWidth // 2) + 15
    } else {
        newX := (screenWidth - winWidth) // 2
    }
    
    newY := (screenHeight - winHeight) // 2

    WinMove, %windowTitle%, , newX, newY
return