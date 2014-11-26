if exist  build  (
	echo "存在build文件夹"
)else (
  echo "不存在build文件夹，创建build文件夹"
  md build
)
@echo "进行viewhome.zip压缩"
zip -r build/viewhome.zip assets/ config/ html/ lib/ xml/
@echo "viewhome.zip已生成，文件位置build/viewhome.zip"
pause
