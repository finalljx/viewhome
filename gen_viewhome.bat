if  exist  build  (
	echo "存在build文件夹，删除build文件夹"
	rd build
)
md build\viewhome\assets
md build\viewhome\config
md build\viewhome\html
md build\viewhome\xml

xcopy /S assets build\viewhome\assets
xcopy /S config build\viewhome\config
xcopy /S html build\viewhome\html
xcopy /S xml build\viewhome\xml
copy version build\viewhome
cd build
@echo "进行viewhome.zip压缩"
zip -r viewhome.zip viewhome
@echo "viewhome.zip已生成，文件位置build/viewhome.zip"
pause
rd /s /q viewhome
