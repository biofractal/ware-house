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
			resolve: products:(proxy)->
				proxy.product.getAll()
			controller: ($scope, sync, products)->
				$scope.products = products
				sync.watch $scope

		.state 'root.product',
			url:'product/:id'
			templateUrl: "product.html"
			resolve: product:($stateParams, proxy)->
				proxy.product.getById $stateParams.id
			controller: ($scope, sync, product, proxy)->
				$scope.product = product
				sync.watch $scope
				$scope.purchase=(id, stock)->
					proxy.product.purchase id, stock

		.state 'root.houses',
			url:'houses'
			templateUrl: "houses.html"
			resolve: houses:(proxy)->
				proxy.house.getAll()
			controller: ($scope, sync, houses)->
				$scope.houses = houses
				sync.watch $scope

		.state 'root.house',
			url:'house/:id'
			templateUrl: "house.html"
			resolve: house:($stateParams, proxy)->
				proxy.house.getById $stateParams.id
			controller: ($scope, sync, house)->
				$scope.house = house
				sync.watch $scope