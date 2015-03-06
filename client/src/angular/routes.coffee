angular
.module 'client'
.config ($stateProvider) ->

	$stateProvider

		.state 'root',
			url:'/'
			templateUrl: "root.html"

		.state 'root.products',
			url:'products'
			templateUrl: "products.html"
			resolve: products:(proxy)-> proxy.product.getAll()
			controller: ($scope, products)->$scope.products = products

		.state 'root.product',
			url:'product/:id'
			templateUrl: "product.html"
			resolve: product:($stateParams, $log, proxy)->proxy.product.getById $stateParams.id
			controller: ($scope, product)->	$scope.product = product

		.state 'root.houses',
			url:'houses'
			templateUrl: "houses.html"
			resolve: houses:(proxy)-> proxy.house.getAll()
			controller: ($scope, houses)-> $scope.houses = houses