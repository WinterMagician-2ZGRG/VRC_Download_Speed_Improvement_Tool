@echo off
setlocal ENABLEDELAYEDEXPANSION
color 0A
hostname




REM  ===============================================
echo ===============================================
echo 実行権限確認
net session >nul 2>&1
REM YN結果_変数格納
set AdminCheck=%ERRORLEVEL%

REM IF分岐(管理者権限でないときは終了)
if %AdminCheck% equ 0 (
    REM Check OK
    echo 管理者権限 実行確認 OK

) else (
    REM Check NG
    echo 管理者権限 実行確認 NG
    echo msgbox "ツールが管理者実行されていない為、処理を中断しました",vbExclamation,"処理中断" > %TEMP%\msgbox.vbs & %TEMP%\msgbox.vbs

    REM MsgBox表示用_一時vbs_削除
    timeout /t 0 >nul
    del /Q %TEMP%\msgbox.vbs
    echo.
    echo.
    echo 右クリックメニューより、「管理者として実行」を選択し、
    echo 管理者権限でツールを実行してください...
    echo.
    pause
    exit
)
echo.
echo.




REM  ===============================================
echo ===============================================
echo IPv6 無効化
REM vbsYorN表示
echo Dim answer:answer = MsgBox("IPv6関連の有効化を実施しますか？",vbYESNO,"IPv6有効化 実行確認"):WScript.Quit(answer) > %TEMP%\msgbox.vbs & %TEMP%\msgbox.vbs
REM YN結果_変数格納
set YN=%ERRORLEVEL%
REM MsgBox表示用_一時vbs_削除
timeout /t 0 >nul
del /Q %TEMP%\msgbox.vbs

REM IF分岐(Yes選択時に処理)
if %YN% equ 6 (

    echo 各種インターフェース 状態表示　事前
    echo isatap 状態確認
    netsh interface ipv6 isatap show state
    echo 6to4 状態確認
    netsh interface ipv6 6to4 show state
    echo teredo 状態確認
    netsh interface teredo show state
    echo.

    echo 各種インターフェース 有効化
    echo isatap有効化
    netsh interface ipv6 isatap set state enabled
    echo 6to4有効化
    netsh interface ipv6 6to4 set state enabled
    echo Terado有効化
    netsh interface teredo set state enterpriseclient
    echo.

    echo 各種インターフェース 状態表示　事後
    echo isatap 状態確認
    netsh interface ipv6 isatap show state
    echo 6to4 状態確認
    netsh interface ipv6 6to4 show state
    echo teredo 状態確認
    netsh interface teredo show state
    echo.

    echo ===============================================
    echo IPv6有効化
    echo 状態表示　事前
    PowerShell -command "Get-NetAdapterBinding -Name "イーサネット" -ComponentID ms_tcpip6"
    PowerShell -command "Get-NetAdapterBinding -Name "Wi-Fi" -ComponentID ms_tcpip6"

    echo 有効化
    PowerShell -command "Enable-NetAdapterBinding -Name "イーサネット" -ComponentID ms_tcpip6"
    PowerShell -command "Enable-NetAdapterBinding -Name "Wi-Fi" -ComponentID ms_tcpip6"

    echo 状態表示　事後
    PowerShell -command "Get-NetAdapterBinding -Name "イーサネット" -ComponentID ms_tcpip6"
    PowerShell -command "Get-NetAdapterBinding -Name "Wi-Fi" -ComponentID ms_tcpip6"
    echo.

) else (

    echo 処理をスキップ

)
echo.
echo.

echo ===============================================
echo 設定終了
echo.
pause
