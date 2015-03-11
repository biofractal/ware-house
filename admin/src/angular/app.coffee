angular
.module 'admin', ['ui.router', 'btford.socket-io', 'xeditable']
.run ($rootScope, $state, editableOptions)->
	editableOptions.theme = 'bs3'
	$rootScope.$state = $state
	$rootScope.$on '$stateChangeError', (event, toState, toParams, fromState, fromParams, error) ->
		$log.error "stateChangeError: #{fromState.name} -> #{toState.name}"
		$log.error error
		event.preventDefault();
