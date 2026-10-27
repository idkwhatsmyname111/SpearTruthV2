#NoEnv
#SingleInstance Force
SendMode Input
SetBatchLines, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
CoordMode, ToolTip, Screen

running := false

; Small circular status indicator near the left edge of the screen.
Gui, Status:New, +AlwaysOnTop -Caption +ToolWindow +LastFound
Gui, Status:Color, 333333
Gui, Status:Font, s10 bold cFFFFFF, Segoe UI
Gui, Status:Add, Text, x0 y0 w88 h52 Center 0x200 vStatusText, OFF
Gui, Status:Show, x8 y300 w88 h52 NoActivate, Clicker Status
WinSet, Region, 0-0 W88 H52 R26-26

UpdateStatus()
return

8::
if (running)
    return
running := true
UpdateStatus()
SetTimer, ClickLoop, 1
return

9::
running := false
SetTimer, ClickLoop, Off
UpdateStatus()
return

ClickLoop:
if (!running)
    return
Click, Left
Click, Right
return

UpdateStatus() {
    global running
    if (running) {
        Gui, Status:Color, 16803C
        GuiControl, Status:, StatusText, ON
    } else {
        Gui, Status:Color, 333333
        GuiControl, Status:, StatusText, OFF
    }
}

Esc::
running := false
SetTimer, ClickLoop, Off
ExitApp
return
