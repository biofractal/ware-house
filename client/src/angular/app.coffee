angular
.module 'client', ['ui.router', 'ui.bootstrap', 'btford.socket-io']
.run ($rootScope, $log)->
	#localStorage.debug = 'socket.io-client*'
	$rootScope.$on '$stateChangeError', (event, toState, toParams, fromState, fromParams, error) ->
		$log.error "stateChangeError: #{fromState.name} -> #{toState.name}"
		$log.error error
		event.preventDefault();
