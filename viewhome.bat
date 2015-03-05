@echo OFF

rem ����zip�ļ�����Ŀ¼

set buildViewPath=E:\temp

rem ������־�ļ�

set horiLogFile==%buildViewPath%\viewHomeLog.txt



rem ���� viewhomeĿ¼

set viewPath=E:\viewhome

rem ���ñ���config.js���ļ��������ڸ���֮ǰ��config.jsʡ�����Ǹ�severBaseUrl

set confg_client=config_client.js

rem ���� zip����·����Ĭ����7z,ע��ո�Ӧ�ü���˫����

set zipPath=C:\"Program Files"\7-Zip

rem ����ѹ������

set zipCommand=7z.exe

echo @ECHO OFF >%horiLogFile%

if not exist %zipPath%\%zipCommand% goto nozip

if not exist "%buildViewPath%" md "%buildViewPath%"


if  exist  %buildViewPath%\build  (
	echo "����build�ļ��У�ɾ��build�ļ���"
	rd  /S /Q %buildViewPath%\build
	
)


rem ���������ļ���

md "%buildViewPath%"\build\viewhome\assets
md "%buildViewPath%"\build\viewhome\config
md "%buildViewPath%"\build\viewhome\html
md "%buildViewPath%"\build\viewhome\xml
md "%buildViewPath%"\build\viewhome\lib


rem �����ļ�

xcopy /S "%viewPath%"\assets "%buildViewPath%"\build\viewhome\assets	>>%horiLogFile%
xcopy /S "%viewPath%"\config "%buildViewPath%"\build\viewhome\config	>>%horiLogFile%
xcopy /S "%viewPath%"\html "%buildViewPath%"\build\viewhome\html	>>%horiLogFile%
xcopy /S "%viewPath%"\xml "%buildViewPath%"\build\viewhome\xml		>>%horiLogFile%
xcopy /S "%viewPath%"\lib "%buildViewPath%"\build\viewhome\lib		>>%horiLogFile%


rem �������������congfig.js ʡ�����Ǹ�serverBaseUrl

copy /Y "%viewPath%"\config\web\%confg_client% "%buildViewPath%"\build\viewhome\config\web\config.js

echo "����viewhome.zipѹ��"

echo "%date:~0,10% %time:~0,2%:%time:~3,2%:%time:~6,2%.%time:~9,2%  ��ʼ����ѹ���ļ�:%buildViewPath%\build\viewhome.zip" >> %horiLogFile%


%zipPath%\%zipCommand% a "%buildViewPath%"\build\viewhome.zip "%buildViewPath%"\build\viewhome	>>%horiLogFile%



echo "%date:~0,10% %time:~0,2%:%time:~3,2%:%time:~6,2%.%time:~9,2% viewhome.zip�����ɣ��ļ�λ��%buildViewPath%\build\viewhome.zip"

rem ɾ���������viewhome

rd /s /q "%buildViewPath%"\build\viewhome >>%horiLogFile%

echo "%date:~0,10% %time:~0,2%:%time:~3,2%:%time:~6,2%.%time:~9,2% ��־�ļ�������,�ļ�λ�� %horiLogFile%"
goto end

:mdfail

@echo ���������ļ���"%buildViewPath%"ʧ��,�����Ƿ���д��Ȩ�ޡ�&& pause
goto end
:nozip
@echo 7z��������ʧ��,��������Ŀ¼���Ƿ���7z.exe
goto end
:end
@echo "�����������" && pause