(function(app) {
	app.viewModel = function(data) {
		var jsonData = JSON.parse(data);
		var mapping = {
			"dialNumber" : {
				update : function(options) {

					return options.data;

				}
			},
			"mailto" : {
				update : function(options) {

					return "mailto:" + options.data;

				}
			}
		};
		var viewModel = ko.mapping.fromJS(jsonData, mapping);
		return viewModel;

	};
	app.refreshData=function(data, viewModel)
	{
		var jsonData = JSON.parse(data);
		ko.mapping.fromJS(jsonData, {}, viewModel);
	};
})(app);
