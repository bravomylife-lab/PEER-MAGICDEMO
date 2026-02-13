Set WshShell = CreateObject("WScript.Shell")
Desktop = WshShell.SpecialFolders("Desktop")
Set oShellLink = WshShell.CreateShortcut(Desktop & "\🎵 PEERMUSIC DEMO 시스템.lnk")

' 실행할 배치 파일 경로
oShellLink.TargetPath = WshShell.CurrentDirectory & "\start-server.bat"
oShellLink.WorkingDirectory = WshShell.CurrentDirectory
oShellLink.Description = "PEERMUSIC DEMO 검토 시스템 실행"

' Windows 내장 음악 아이콘 사용 (또는 사용자 지정 아이콘)
' %SystemRoot%\System32\mmcndmgr.dll,0 = 음악 노트 아이콘
' %SystemRoot%\System32\imageres.dll,108 = 별 아이콘
' %SystemRoot%\System32\shell32.dll,165 = 마법사 모자 아이콘
oShellLink.IconLocation = "%SystemRoot%\System32\shell32.dll,165"

oShellLink.Save

MsgBox "바탕화면에 '🎵 PEERMUSIC DEMO 시스템' 바로가기가 생성되었습니다!" & vbCrLf & vbCrLf & "더블클릭하여 실행하세요 ✨", 64, "바로가기 생성 완료"
