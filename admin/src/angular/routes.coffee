angular
.module 'admin'
.config ($stateProvider) ->

	$stateProvider

		.state 'root',
			url:'/'
			templateUrl: "root.html"


		.state 'root.houses',
			url:'houses'
			templateUrl: "houses.html"
			controller: ($scope, sync)->
			resolve: houses:(proxy)->
				proxy.house.getAll()

			controller: ($scope, sync, houses)->
				$scope.houses = houses
				sync.watch $scope


		.state 'root.house',
			url:'house/:id'
			templateUrl: "house.html"
			controller: ($scope, sync)->
			resolve: house:($stateParams, proxy)->
				proxy.house.getById $stateParams.id

			controller: ($log, $scope, sync, proxy, house)->
				$scope.house = house
				$scope.update = ->
					proxy.house.update $scope.house

				sync.watch $scope

