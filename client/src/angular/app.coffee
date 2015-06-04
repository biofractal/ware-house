angular
.module 'ware-house-client', ['ui.router', 'sapify-angular']
.run ($rootScope, $state, $log, proxy, sso)->

	$rootScope.$state = $state
	$rootScope.proxy = proxy

	$rootScope.$on '$stateChangeError', (event, toState, toParams, fromState, fromParams, error) ->
		$log.error "stateChangeError: #{fromState.name} -> #{toState.name}"
		$log.error error
		event.preventDefault();