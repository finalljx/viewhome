if exist  build  (
	echo "����build�ļ���"
)else (
  echo "������build�ļ��У�����build�ļ���"
  md build
)
@echo "����viewhome.zipѹ��"
zip -r build/viewhome.zip assets/ config/ html/ lib/ xml/
@echo "viewhome.zip�����ɣ��ļ�λ��build/viewhome.zip"
pause
