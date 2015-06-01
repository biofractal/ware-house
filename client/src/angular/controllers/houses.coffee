angular
.module 'ware-house-client'
.controller 'houses',
($scope, sync, houses)->
	$scope.houses = houses
	sync.watch $scope
