if  exist  build  (
	echo "存在build文件夹，删除build文件夹"
	rd /s /q build
)
md build\server_dist\viewhome\assets
md build\server_dist\viewhome\config
md build\server_dist\viewhome\html
md build\server_dist\viewhome\xml
md build\server_dist\viewhome\lib
md build\server_dist\viewhome\jsp
md build\server_dist\viewhome\xsl

xcopy /S assets build\server_dist\viewhome\assets
xcopy /S config build\server_dist\viewhome\config
xcopy /S html build\server_dist\viewhome\html
xcopy /S xml build\server_dist\viewhome\xml
xcopy /S lib build\server_dist\viewhome\lib
xcopy /S jsp build\server_dist\viewhome\jsp
xcopy /S xsl build\server_dist\viewhome\xsl
copy server.properties build\server_dist\viewhome
copy signature.dat build\server_dist\viewhome
copy viewers.xml build\server_dist\viewhome
@echo "viewhome版本已复制，文件位置build/server_dist"
pause

