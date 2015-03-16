angular
.module 'admin', ['ui.router', 'socket-sauce', 'xeditable']
.run ($rootScope, $state, proxy, editableOptions)->

	editableOptions.theme = 'bs3'
	$rootScope.$state = $state
	$rootScope.proxy = proxy

	$rootScope.$on '$stateChangeError', (event, toState, toParams, fromState, fromParams, error) ->
		$log.error "stateChangeError: #{fromState.name} -> #{toState.name}"
		$log.error error
		event.preventDefault();
