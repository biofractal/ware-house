angular
.module 'ware-house-client'
.controller 'product',
($scope, sync, product, proxy)->
	$scope.product = product
	sync.watch $scope
	$scope.purchase=(id, stock)->
		proxy.product.purchase id, stock
		.then (product)->
			$scope.product = product
