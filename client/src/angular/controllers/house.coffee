angular
.module 'ware-house-client'
.controller 'house',
($scope, sync, house)->
	$scope.house = house
	sync.watch $scope
