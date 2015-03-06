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
			controller: ($scope, products)->
				$scope.products = products
			resolve:
				products:(proxy)->
					proxy.product.getAll()

		.state 'root.houses',
			url:'houses'
			templateUrl: "houses.html"
			controller: ($scope, houses)->
				$scope.houses = houses
			resolve:
				houses:(proxy)->
					proxy.house.getAll()