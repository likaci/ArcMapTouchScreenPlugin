#Persistent
SetTitleMatchMode , 2
;CoordMode, Mouse, Screen
;#WinActivateForce
Gui, Margin ,0,5
Hotkey ,LButton,Off
switch=0
gui +AlwaysOnTop +ToolWindow
Gui Add, Button, x40   y120 w35 h35 gButton1,点击
Gui Add, Button, x0   y80  w35 h35 gButton2,拖动
Gui Add, Button, x0   y120 w35 h35 gButton3,缩放
Gui Add, Button, x0   y40  w35 h35 gButton4,选切
Gui Add, Button, x40   y40 w35 h35 gButton5,释放
Gui Add, Text  , x1   y72,------------
Gui Add, Text  , x1   y113,------------
Gui Add, Button, x40  y80  w35 h35 gButton6,完成
Gui Add, Button, x0   y0   w35 h35 gButton7,撤销
Gui Add, Button, x40  y0   w35 h35 gButton8,删草
Gui Add, Button, x18  y160 w35 h35 gButton9,↑
Gui Add, Button, x18  y230 w35 h35 gButton10,↓
Gui Add, Button, x0   y195 w35 h35 gButton11,←
Gui Add, Button, x40  y195 w35 h35 gButton12,→
;Gui Add, Button, x0  y40 w35 h35 gButton13,选切
Gui Show,,   ccaiai
WinSet, Transparent, 180, ccaiai
return

;--点击
Button1:
{
	Gosub , Button5
	switch=1
	ControlSetText, Button1,点击ing,
	ControlSetText, Button2,拖动,
	ControlSetText, Button3,缩放,
	ControlSetText, Button4,选切,
	WinActivate ,- ArcMap - ArcInfo,,,
	Hotkey ,LButton,On
	Return
}

;--拖动
Button2:
{
	Gosub , Button5
	switch=2
	ControlSetText, Button1,点击,
	ControlSetText, Button2,拖动ing,
	ControlSetText, Button3,缩放,
	ControlSetText, Button4,选切,
	WinActivate ,- ArcMap - ArcInfo,,,
	Send {c Down}
	Send {alt Down}{Tab}{Shift Down}{Tab}{Shift Up}{Alt Up}
	Hotkey ,LButton,Off
	Return
}

;--缩放
Button3:
{
	Gosub , Button5
	switch=3
	ControlSetText, Button1,点击,
	ControlSetText, Button2,拖动,
	ControlSetText, Button3,缩放ing,
	ControlSetText, Button4,选切,
	WinActivate ,- ArcMap - ArcInfo,,,
	Send {b Down}
	Send {alt Down}{Tab}{Shift Down}{Tab}{Shift Up}{Alt Up}
	Hotkey ,LButton,Off
	Return
}

;--选切
Button4:
{
	Gosub button5
	WinActivate ,- ArcMap - ArcInfo,,,
	;Send {Ctrl Down}{Alt Down}{Shift Down}{r Down}
	;Send {r Up}{shift Up}{Alt Up}{Ctrl Up}
	Send ^!+r
	ControlSetText, Button4,选ing,
		Loop{
			Sleep 50
			If(GetKeyState("LButton","P")!=0)
			Break
		}
		Loop{
			Sleep 50
			If(GetKeyState("LButton","P")=0)
			Break
		}
	Send {Ctrl Down}{Alt Down}{Shift Down}{c Down}
	Send {c Up}{shift Up}{Alt Up}{Ctrl Up}
	ControlSetText, Button13,选切,
	Goto Button1
	Return
}

;--释放
Button5:
{
	WinActivate ,- ArcMap - ArcInfo,,,
	Send {c Up}
	Send {b Up}
	;Send {x Up}
	switch=0
	ControlSetText, Button1,点击,
	ControlSetText, Button2,拖动,
	ControlSetText, Button3,缩放,
	ControlSetText, Button4,选切,
	Hotkey ,LButton,Off
	Return
}

;--完成
Button6:
{
	WinActivate ,- ArcMap - ArcInfo,,,
	Send {F2}
	Return
}

;--撤销
Button7:
{
	WinActivate ,- ArcMap - ArcInfo,,,
	Send {Ctrl Down}{z}{Ctrl Up}
	Return
}


;--删除草图
Button8:
{
	WinActivate ,- ArcMap - ArcInfo,,,
	;Send {Ctrl Down}{y}{Ctrl Up}
	Send {Ctrl Down}{Del}{Ctrl Up}
	Return
}


;--上
Button9:
{
	WinActivate ,- ArcMap - ArcInfo,,,
	Send {Up Down}
	Sleep 400
	Send {Up Up}
	Return
}


;--下
Button10:
{
	WinActivate ,- ArcMap - ArcInfo,,,
	Send {Down Down}
	sleep 400
	Send {Down Up}
	Return
}

;--左
Button11:
{
	WinActivate ,- ArcMap - ArcInfo,,,
	Send {Left Down}
	sleep 400
	Send {Left Up}
	Return
}

;--右
Button12:
{
	WinActivate ,- ArcMap - ArcInfo,,,
	Send {Right Down}
	Sleep 400
	Send {Right Up}
	Return
}

Ins::Suspend
LButton::
{
	Send {Lbutton Down}
		IfWinActive ,- ArcMap - ArcInfo,,,
		{	Send {Lbutton Up}
			;ToolTip ,%switch%
			If(switch=1){
				;自动点击
				Loop{
					MouseGetPos, xpos1, ypos1
					Loop{
						sleep 50
						MouseGetPos, xpos2, ypos2
						b:=(xpos2-xpos1)*(xpos2-xpos1)+(ypos2-ypos1)*(ypos2-ypos1)
						b:=Sqrt(b)
						If (b>13)&(GetKeyState("LButton","P")!=0){
							Click
							Break
						}
						if(GetKeyState("LButton","P")=0)
							Break
					}
					if(GetKeyState("LButton","P")=0)
						Break
				}
			Return
			}
		}
		Else
		{
			Loop{
				sleep 50
				if(GetKeyState("LButton","P")=0)
				{
					Send {LButton Up}
					Break
				}
			}
		Return
		}
}
GuiClose:
ExitApp