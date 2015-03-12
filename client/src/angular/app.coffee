angular
.module 'client', ['ui.router', 'btford.socket-io']
.run ($rootScope, $log, $state, proxy)->

	$rootScope.$state = $state
	$rootScope.proxy = proxy

	$rootScope.$on '$stateChangeError', (event, toState, toParams, fromState, fromParams, error) ->
		$log.error "stateChangeError: #{fromState.name} -> #{toState.name}"
		$log.error error
		event.preventDefault();
