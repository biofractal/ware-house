angular
.module 'client', ['ui.router', 'socket-sauce']
.run ($rootScope, $log, $state, proxy)->

	$rootScope.$state = $state
	$rootScope.proxy = proxy


	$rootScope.$on '$stateChangeError', (event, toState, toParams, fromState, fromParams, error) ->
		$log.error "stateChangeError: #{fromState.name} -> #{toState.name}"
		$log.error error
		event.preventDefault();
