#a::
If WinExist("ahk_exe SynologySurveillanceStationClient.exe")
  If WinActive("ahk_exe SynologySurveillanceStationClient.exe")
  {
    WinMinimize, ahk_exe SynologySurveillanceStationClient.exe
    if WinActive("ahk_exe SynologySurveillanceStationClient.exe")
        Send !{Esc}    ; activates the previously-active window
  }
  else
  {
    WinActivate, ahk_exe SynologySurveillanceStationClient.exe
  }
else
  Run, SynologySurveillanceStationClient.exe, C:\Program Files\Synology\SynologySurveillanceStationClient\bin
return
