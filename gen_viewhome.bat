if  exist  build  (
	echo "����build�ļ��У�ɾ��build�ļ���"
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
@echo "����viewhome.zipѹ��"
zip -r viewhome.zip viewhome
@echo "viewhome.zip�����ɣ��ļ�λ��build/viewhome.zip"
pause
rd /s /q viewhome
