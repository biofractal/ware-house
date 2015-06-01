angular
.module 'ware-house-client'
.controller 'products',
($scope, sync, products)->
	$scope.products = products
	sync.watch $scope
