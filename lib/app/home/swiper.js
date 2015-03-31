function initSwiperData() {
	// 图片新闻
	var tpxwList = [
			{
				"contentName" : "a14f0154-eb57-489a-888e-82039de16934",
				"contentTitle" : "",
				"sitAreaTitle" : "图片新闻",
				"imgSrc" : "../assets/home/items/module-res/swiper/p1.jpg",
				"source" : "",
				"newsDate" : "10-14 07:07",
				"content" : ""
			},
			{
				"contentName" : "56d9bde3-e26b-44ae-8860-f68fa3dd4de8",
				"contentTitle" : "",
				"sitAreaTitle" : "图片新闻",
				"imgSrc" : "../assets/home/items/module-res/swiper/p2.jpg",
				"source" : "",
				"newsDate" : "10-14 07:07",
				"content" : ""
			}];
	var data = new Object();
	data.list = tpxwList;
	// 绘制内容
	renderSwiper(data);
}

function renderSwiper(jsonData) {
	var viewModel = ko.mapping.fromJS(jsonData);
	ko.applyBindings(viewModel, document.getElementById("tpxwSwiper"));
	initSwiper();
}

// 初始化swiper
function initSwiper() {
	// 初始化宽高
	var width = $(window).width();
	var height = width / 3;
	$(".swiper-container").width(width);
	$(".swiper-container").height(height);
	$(".swiper-image").width(width);
	$(".swiper-image").height(height);
	//$(".swiper-container .more").width(50);
	//$(".swiper-slide .title").width(width - 70);
	// 生成swiper
	var mySwiper = new Swiper('.swiper-container', {
		pagination : '.pagination',
		paginationClickable : true
	})
}

function showDetail(item){
	
}
