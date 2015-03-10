angular
.module 'client', ['ui.router', 'btford.socket-io']
.run ($rootScope, $log, $state)->
	#localStorage.debug = 'socket.io-client*'
	$rootScope.$log = $log
	$rootScope.$state = $state
	$rootScope.$on '$stateChangeError', (event, toState, toParams, fromState, fromParams, error) ->
		$log.error "stateChangeError: #{fromState.name} -> #{toState.name}"
		$log.error error
		event.preventDefault();
