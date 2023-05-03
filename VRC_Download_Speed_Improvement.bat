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
echo RWIN設定調整
REM vbsYorN表示
echo Dim answer:answer = MsgBox("RWIN設定をNormalへ変更しますか？" ^& Chr(13) ^& "この設定を変えることでダウンロード速度が戻ります",vbYESNO,"RWIN調整 実行確認"):WScript.Quit(answer) > %TEMP%\msgbox.vbs & %TEMP%\msgbox.vbs
REM YN結果_変数格納
set YN=%ERRORLEVEL%
REM MsgBox表示用_一時vbs_削除
timeout /t 0 >nul
del /Q %TEMP%\msgbox.vbs

REM IF分岐(Yes選択時に処理)
if %YN% equ 6 (
    echo 設定表示　事前
    netsh int tcp show global

    echo RWIN自動調整をNormal化
    netsh int tcp set global autotuninglevel=normal

    echo 設定表示　事後
    netsh int tcp show global
    echo.

) else (

    echo 処理をスキップ

)
echo.
echo.




REM  ===============================================
echo ===============================================
echo IPv6 無効化
REM vbsYorN表示
echo Dim answer:answer = MsgBox("IPv6関連の無効化を実施しますか？" ^& Chr(13) ^& "" ^& Chr(13) ^& "IPv6環境である場合は問題を引き起こす場合があります" ^& Chr(13) ^& "よくわからない場合は「いいえ」を選択してください",vbYESNO,"IPv6無効化 実行確認"):WScript.Quit(answer) > %TEMP%\msgbox.vbs & %TEMP%\msgbox.vbs
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

    echo 各種インターフェース 無効化
    echo isatap無効化
    netsh interface ipv6 isatap set state disabled
    echo 6to4無効化
    netsh interface ipv6 6to4 set state disabled
    echo Terado無効化
    netsh interface teredo set state disabled
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
    echo IPv6無効化
    echo 状態表示　事前
    PowerShell -command "Get-NetAdapterBinding -Name "イーサネット" -ComponentID ms_tcpip6"
    PowerShell -command "Get-NetAdapterBinding -Name "Wi-Fi" -ComponentID ms_tcpip6"

    echo 無効化
    PowerShell -command "Disable-NetAdapterBinding -Name "イーサネット" -ComponentID ms_tcpip6"
    PowerShell -command "Disable-NetAdapterBinding -Name "Wi-Fi" -ComponentID ms_tcpip6"

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
echo ツール終了
echo.
pause
