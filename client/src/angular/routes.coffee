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
			controller: ($log, $rootScope, $scope, products)->
				$scope.products = products
				$scope.$on 'model-changed', (event, args)->
					return unless args.data.type is 'product'
					item = args.data.item
					for p,i in $scope.products
						if item._id is p._id
							$scope.products[i] = item
							break

		.state 'root.product',
			url:'product/:id'
			templateUrl: "product.html"
			resolve: product:($stateParams, $log, proxy)->
				proxy.product.getById $stateParams.id
			controller: ($rootScope, $scope, product)->
				$scope.product = product
				$scope.$on 'model-changed', (event, args)->
					return unless args.data.type is 'product'
					item = args.data.item
					$scope.product = item if item._id is $scope.product._id

		.state 'root.houses',
			url:'houses'
			templateUrl: "houses.html"
			resolve: houses:(proxy)->
				proxy.house.getAll()
			controller: ($scope, houses)->
				$scope.houses = houses