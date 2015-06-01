angular
.module 'ware-house-client'
.controller 'verify',
($rootScope, $scope, $state)->
	$scope.verification = vid: $state.params.vid
	$scope.verify = ->
		$scope.proxy.user.verify $scope.verification.vid, $scope.verification.code
		.then (user)->
			$rootScope.user = user
			$state.go 'app.products'