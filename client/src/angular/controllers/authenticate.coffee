angular
.module 'ware-house-client'
.controller 'authenticate',
($scope, $state)->
	$scope.credentials={}
	$scope.authenticate=->
		$scope.proxy.user.authenticate $scope.credentials.email, $scope.credentials.secret
		.then (data)->
			$state.go 'app.verify', vid:data.vid
