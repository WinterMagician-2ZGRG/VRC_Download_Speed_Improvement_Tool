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
echo RWIN�ݒ蒲��
REM vbsYorN�\��
echo Dim answer:answer = MsgBox("RWIN�ݒ��Normal�֕ύX���܂����H" ^& Chr(13) ^& "���̐ݒ��ς��邱�ƂŃ_�E�����[�h���x���߂�܂�",vbYESNO,"RWIN���� ���s�m�F"):WScript.Quit(answer) > %TEMP%\msgbox.vbs & %TEMP%\msgbox.vbs
REM YN����_�ϐ��i�[
set YN=%ERRORLEVEL%
REM MsgBox�\���p_�ꎞvbs_�폜
timeout /t 0 >nul
del /Q %TEMP%\msgbox.vbs

REM IF����(Yes�I�����ɏ���)
if %YN% equ 6 (
    echo �ݒ�\���@���O
    netsh int tcp show global

    echo RWIN����������Normal��
    netsh int tcp set global autotuninglevel=normal

    echo �ݒ�\���@����
    netsh int tcp show global
    echo.

) else (

    echo �������X�L�b�v

)
echo.
echo.




REM  ===============================================
echo ===============================================
echo IPv6 ������
REM vbsYorN�\��
echo Dim answer:answer = MsgBox("IPv6�֘A�̖����������{���܂����H" ^& Chr(13) ^& "" ^& Chr(13) ^& "IPv6���ł���ꍇ�͖��������N�����ꍇ������܂�" ^& Chr(13) ^& "�悭�킩��Ȃ��ꍇ�́u�������v��I�����Ă�������",vbYESNO,"IPv6������ ���s�m�F"):WScript.Quit(answer) > %TEMP%\msgbox.vbs & %TEMP%\msgbox.vbs
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

    echo �e��C���^�[�t�F�[�X ������
    echo isatap������
    netsh interface ipv6 isatap set state disabled
    echo 6to4������
    netsh interface ipv6 6to4 set state disabled
    echo Terado������
    netsh interface teredo set state disabled
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
    echo IPv6������
    echo ��ԕ\���@���O
    PowerShell -command "Get-NetAdapterBinding -Name "�C�[�T�l�b�g" -ComponentID ms_tcpip6"
    PowerShell -command "Get-NetAdapterBinding -Name "Wi-Fi" -ComponentID ms_tcpip6"

    echo ������
    PowerShell -command "Disable-NetAdapterBinding -Name "�C�[�T�l�b�g" -ComponentID ms_tcpip6"
    PowerShell -command "Disable-NetAdapterBinding -Name "Wi-Fi" -ComponentID ms_tcpip6"

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
echo �c�[���I��
echo.
pause
