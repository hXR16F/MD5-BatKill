#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Run_Tidy=y
#AutoIt3Wrapper_Run_Au3Stripper=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>
#include <FileConstants.au3>

#Region ### START Koda GUI section ###
$Form1 = GUICreate("MD5-BatKill", 362, 306, 274, 191)
GUISetIcon("C:\Windows\System32\shell32.dll", -51)
$Group1 = GUICtrlCreateGroup("MD5 Hash", 8, 8, 345, 65)
$Input1 = GUICtrlCreateInput("", 24, 32, 313, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("Method", 8, 80, 345, 81)
$Radio1 = GUICtrlCreateRadio("core\md5.exe -l -d", 24, 104, 113, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetTip(-1, "Faster, don't need to install additional packages.")
$Radio2 = GUICtrlCreateRadio("py core/md5.py", 24, 128, 113, 17)
GUICtrlSetTip(-1, "Slower, needs python3 to be installed.")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group3 = GUICtrlCreateGroup("Password", 8, 168, 345, 65)
$Input2 = GUICtrlCreateInput("", 24, 192, 233, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_READONLY))
$Button2 = GUICtrlCreateButton("Copy", 264, 190, 75, 25)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Button1 = GUICtrlCreateButton("Crack", 8, 240, 347, 33)
$StatusBar1 = _GUICtrlStatusBar_Create($Form1)
Dim $StatusBar1_PartsWidth[1] = [-1]
_GUICtrlStatusBar_SetParts($StatusBar1, $StatusBar1_PartsWidth)
_GUICtrlStatusBar_SetText($StatusBar1, @TAB & "Programmed by hXR16F", 0)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		Case $Button1
			GUICtrlSetState($Input1, $GUI_DISABLE)
			GUICtrlSetState($Input2, $GUI_DISABLE)
			GUICtrlSetData($Input2, "Cracking in progress...")
			GUICtrlSetState($Radio1, $GUI_DISABLE)
			GUICtrlSetState($Radio2, $GUI_DISABLE)
			GUICtrlSetState($Button1, $GUI_DISABLE)
			GUICtrlSetState($Button2, $GUI_DISABLE)

			Local $InputData = GUICtrlRead($Input1)
			If GUICtrlRead($Radio1) = 1 Then
				Local $Method = "1"
			Else
				Local $Method = "2"
			EndIf

			FileWrite(@ScriptDir & "\input.ini", $InputData & @CRLF & $Method)
			ShellExecuteWait(@ScriptDir & "\md5-batkill.bat", "", "", "", @SW_MINIMIZE)
			If FileExists(@ScriptDir & "\output.txt") Then
				Local $hFileOpen = FileOpen(@ScriptDir & "\output.txt", $FO_READ)
				Local $sFileRead = FileReadLine($hFileOpen, 1)
				GUICtrlSetData($Input2, $sFileRead)
				FileClose($hFileOpen)
			EndIf
			FileDelete(@ScriptDir & "\output.txt")

			GUICtrlSetState($Input1, $GUI_ENABLE)
			GUICtrlSetState($Input2, $GUI_ENABLE)
			GUICtrlSetState($Radio1, $GUI_ENABLE)
			GUICtrlSetState($Radio2, $GUI_ENABLE)
			GUICtrlSetState($Button1, $GUI_ENABLE)
			GUICtrlSetState($Button2, $GUI_ENABLE)

		Case $Button2
			ClipPut(GUICtrlRead($Input2))
			MsgBox($MB_OK, "MD5-BatKill", "Copied '" & GUICtrlRead($Input2) & "' to clipboard!")
	EndSwitch
WEnd
