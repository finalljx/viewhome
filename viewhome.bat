@echo OFF

rem 设置zip文件生成目录

set buildViewPath=E:\temp

rem 设置日志文件

set horiLogFile==%buildViewPath%\viewHomeLog.txt



rem 设置 viewhome目录

set viewPath=E:\viewhome

rem 设置本地config.js的文件名，用于覆盖之前的config.js省得忘记改severBaseUrl

set confg_client=config_client.js

rem 设置 zip命令路径，默认是7z,注意空格应该加上双引号

set zipPath=C:\"Program Files"\7-Zip

rem 设置压缩命令

set zipCommand=7z.exe

echo @ECHO OFF >%horiLogFile%

if not exist %zipPath%\%zipCommand% goto nozip

if not exist "%buildViewPath%" md "%buildViewPath%"


if  exist  %buildViewPath%\build  (
	echo "存在build文件夹，删除build文件夹"
	rd  /S /Q %buildViewPath%\build
	
)


rem 创建各个文件夹

md "%buildViewPath%"\build\viewhome\assets
md "%buildViewPath%"\build\viewhome\config
md "%buildViewPath%"\build\viewhome\html
md "%buildViewPath%"\build\viewhome\xml
md "%buildViewPath%"\build\viewhome\lib


rem 拷贝文件

xcopy /S "%viewPath%"\assets "%buildViewPath%"\build\viewhome\assets	>>%horiLogFile%
xcopy /S "%viewPath%"\config "%buildViewPath%"\build\viewhome\config	>>%horiLogFile%
xcopy /S "%viewPath%"\html "%buildViewPath%"\build\viewhome\html	>>%horiLogFile%
xcopy /S "%viewPath%"\xml "%buildViewPath%"\build\viewhome\xml		>>%horiLogFile%
xcopy /S "%viewPath%"\lib "%buildViewPath%"\build\viewhome\lib		>>%horiLogFile%


rem 单独拷贝打包的congfig.js 省得忘记改serverBaseUrl

copy /Y "%viewPath%"\config\web\%confg_client% "%buildViewPath%"\build\viewhome\config\web\config.js

echo "进行viewhome.zip压缩"

echo "%date:~0,10% %time:~0,2%:%time:~3,2%:%time:~6,2%.%time:~9,2%  开始创建压缩文件:%buildViewPath%\build\viewhome.zip" >> %horiLogFile%


%zipPath%\%zipCommand% a "%buildViewPath%"\build\viewhome.zip "%buildViewPath%"\build\viewhome	>>%horiLogFile%



echo "%date:~0,10% %time:~0,2%:%time:~3,2%:%time:~6,2%.%time:~9,2% viewhome.zip已生成，文件位置%buildViewPath%\build\viewhome.zip"

rem 删除打完包的viewhome

rd /s /q "%buildViewPath%"\build\viewhome >>%horiLogFile%

echo "%date:~0,10% %time:~0,2%:%time:~3,2%:%time:~6,2%.%time:~9,2% 日志文件已生成,文件位置 %horiLogFile%"
goto end

:mdfail

@echo 创建备份文件夹"%buildViewPath%"失败,请检查是否有写入权限。&& pause
goto end
:nozip
@echo 7z命令运行失败,请检查配置目录中是否有7z.exe
goto end
:end
@echo "按任意键结束" && pause