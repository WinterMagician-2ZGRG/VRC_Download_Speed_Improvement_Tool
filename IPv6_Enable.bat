@echo off
setlocal ENABLEDELAYEDEXPANSION
color 0A
hostname




REM  ===============================================
echo ===============================================
echo ���s�����m�F
net session >nul 2>&1
REM YN����_�ϐ��i�[
set AdminCheck=%ERRORLEVEL%

REM IF����(�Ǘ��Ҍ����łȂ��Ƃ��͏I��)
if %AdminCheck% equ 0 (
    REM Check OK
    echo �Ǘ��Ҍ��� ���s�m�F OK

) else (
    REM Check NG
    echo �Ǘ��Ҍ��� ���s�m�F NG
    echo msgbox "�c�[�����Ǘ��Ҏ��s����Ă��Ȃ��ׁA�����𒆒f���܂���",vbExclamation,"�������f" > %TEMP%\msgbox.vbs & %TEMP%\msgbox.vbs

    REM MsgBox�\���p_�ꎞvbs_�폜
    timeout /t 0 >nul
    del /Q %TEMP%\msgbox.vbs
    echo.
    echo.
    echo �E�N���b�N���j���[���A�u�Ǘ��҂Ƃ��Ď��s�v��I�����A
    echo �Ǘ��Ҍ����Ńc�[�������s���Ă�������...
    echo.
    pause
    exit
)
echo.
echo.




REM  ===============================================
echo ===============================================
echo IPv6 ������
REM vbsYorN�\��
echo Dim answer:answer = MsgBox("IPv6�֘A�̗L���������{���܂����H",vbYESNO,"IPv6�L���� ���s�m�F"):WScript.Quit(answer) > %TEMP%\msgbox.vbs & %TEMP%\msgbox.vbs
REM YN����_�ϐ��i�[
set YN=%ERRORLEVEL%
REM MsgBox�\���p_�ꎞvbs_�폜
timeout /t 0 >nul
del /Q %TEMP%\msgbox.vbs

REM IF����(Yes�I�����ɏ���)
if %YN% equ 6 (

    echo �e��C���^�[�t�F�[�X ��ԕ\���@���O
    echo isatap ��Ԋm�F
    netsh interface ipv6 isatap show state
    echo 6to4 ��Ԋm�F
    netsh interface ipv6 6to4 show state
    echo teredo ��Ԋm�F
    netsh interface teredo show state
    echo.

    echo �e��C���^�[�t�F�[�X �L����
    echo isatap�L����
    netsh interface ipv6 isatap set state enabled
    echo 6to4�L����
    netsh interface ipv6 6to4 set state enabled
    echo Terado�L����
    netsh interface teredo set state enterpriseclient
    echo.

    echo �e��C���^�[�t�F�[�X ��ԕ\���@����
    echo isatap ��Ԋm�F
    netsh interface ipv6 isatap show state
    echo 6to4 ��Ԋm�F
    netsh interface ipv6 6to4 show state
    echo teredo ��Ԋm�F
    netsh interface teredo show state
    echo.

    echo ===============================================
    echo IPv6�L����
    echo ��ԕ\���@���O
    PowerShell -command "Get-NetAdapterBinding -Name "�C�[�T�l�b�g" -ComponentID ms_tcpip6"
    PowerShell -command "Get-NetAdapterBinding -Name "Wi-Fi" -ComponentID ms_tcpip6"

    echo �L����
    PowerShell -command "Enable-NetAdapterBinding -Name "�C�[�T�l�b�g" -ComponentID ms_tcpip6"
    PowerShell -command "Enable-NetAdapterBinding -Name "Wi-Fi" -ComponentID ms_tcpip6"

    echo ��ԕ\���@����
    PowerShell -command "Get-NetAdapterBinding -Name "�C�[�T�l�b�g" -ComponentID ms_tcpip6"
    PowerShell -command "Get-NetAdapterBinding -Name "Wi-Fi" -ComponentID ms_tcpip6"
    echo.

) else (

    echo �������X�L�b�v

)
echo.
echo.

echo ===============================================
echo �ݒ�I��
echo.
pause
