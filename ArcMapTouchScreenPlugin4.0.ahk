#Persistent
SetTitleMatchMode , 2
;CoordMode, Mouse, Screen
;#WinActivateForce
Gui, Margin ,0,5
Hotkey ,LButton,Off
switch=0
gui +AlwaysOnTop +ToolWindow
Gui Add, Button, x40   y120 w35 h35 gButton1,���
Gui Add, Button, x0   y80  w35 h35 gButton2,�϶�
Gui Add, Button, x0   y120 w35 h35 gButton3,����
Gui Add, Button, x0   y40  w35 h35 gButton4,ѡ��
Gui Add, Button, x40   y40 w35 h35 gButton5,�ͷ�
Gui Add, Text  , x1   y72,------------
Gui Add, Text  , x1   y113,------------
Gui Add, Button, x40  y80  w35 h35 gButton6,���
Gui Add, Button, x0   y0   w35 h35 gButton7,����
Gui Add, Button, x40  y0   w35 h35 gButton8,ɾ��
Gui Add, Button, x18  y160 w35 h35 gButton9,��
Gui Add, Button, x18  y230 w35 h35 gButton10,��
Gui Add, Button, x0   y195 w35 h35 gButton11,��
Gui Add, Button, x40  y195 w35 h35 gButton12,��
;Gui Add, Button, x0  y40 w35 h35 gButton13,ѡ��
Gui Show,,   ccaiai
WinSet, Transparent, 180, ccaiai
return

;--���
Button1:
{
	Gosub , Button5
	switch=1
	ControlSetText, Button1,���ing,
	ControlSetText, Button2,�϶�,
	ControlSetText, Button3,����,
	ControlSetText, Button4,ѡ��,
	WinActivate ,- ArcMap - ArcInfo,,,
	Hotkey ,LButton,On
	Return
}

;--�϶�
Button2:
{
	Gosub , Button5
	switch=2
	ControlSetText, Button1,���,
	ControlSetText, Button2,�϶�ing,
	ControlSetText, Button3,����,
	ControlSetText, Button4,ѡ��,
	WinActivate ,- ArcMap - ArcInfo,,,
	Send {c Down}
	Send {alt Down}{Tab}{Shift Down}{Tab}{Shift Up}{Alt Up}
	Hotkey ,LButton,Off
	Return
}

;--����
Button3:
{
	Gosub , Button5
	switch=3
	ControlSetText, Button1,���,
	ControlSetText, Button2,�϶�,
	ControlSetText, Button3,����ing,
	ControlSetText, Button4,ѡ��,
	WinActivate ,- ArcMap - ArcInfo,,,
	Send {b Down}
	Send {alt Down}{Tab}{Shift Down}{Tab}{Shift Up}{Alt Up}
	Hotkey ,LButton,Off
	Return
}

;--ѡ��
Button4:
{
	Gosub button5
	WinActivate ,- ArcMap - ArcInfo,,,
	;Send {Ctrl Down}{Alt Down}{Shift Down}{r Down}
	;Send {r Up}{shift Up}{Alt Up}{Ctrl Up}
	Send ^!+r
	ControlSetText, Button4,ѡing,
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
	ControlSetText, Button13,ѡ��,
	Goto Button1
	Return
}

;--�ͷ�
Button5:
{
	WinActivate ,- ArcMap - ArcInfo,,,
	Send {c Up}
	Send {b Up}
	;Send {x Up}
	switch=0
	ControlSetText, Button1,���,
	ControlSetText, Button2,�϶�,
	ControlSetText, Button3,����,
	ControlSetText, Button4,ѡ��,
	Hotkey ,LButton,Off
	Return
}

;--���
Button6:
{
	WinActivate ,- ArcMap - ArcInfo,,,
	Send {F2}
	Return
}

;--����
Button7:
{
	WinActivate ,- ArcMap - ArcInfo,,,
	Send {Ctrl Down}{z}{Ctrl Up}
	Return
}


;--ɾ����ͼ
Button8:
{
	WinActivate ,- ArcMap - ArcInfo,,,
	;Send {Ctrl Down}{y}{Ctrl Up}
	Send {Ctrl Down}{Del}{Ctrl Up}
	Return
}


;--��
Button9:
{
	WinActivate ,- ArcMap - ArcInfo,,,
	Send {Up Down}
	Sleep 400
	Send {Up Up}
	Return
}


;--��
Button10:
{
	WinActivate ,- ArcMap - ArcInfo,,,
	Send {Down Down}
	sleep 400
	Send {Down Up}
	Return
}

;--��
Button11:
{
	WinActivate ,- ArcMap - ArcInfo,,,
	Send {Left Down}
	sleep 400
	Send {Left Up}
	Return
}

;--��
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
				;�Զ����
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