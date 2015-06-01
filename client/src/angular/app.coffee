angular
.module 'ware-house-client', ['ui.router', 'sapify-angular']
.run ($rootScope, $state, $log, proxy)->

	$rootScope.$state = $state
	$rootScope.proxy = proxy

	$rootScope.$on '$stateChangeStart', (event, toState, toParams) ->
		$log.info "stateChangeStart: #{toState.name}"
		return if not toState.data.requireLogin or $rootScope.user?
		event.preventDefault();
		$state.go 'app.authenticate'

	$rootScope.$on '$stateChangeError', (event, toState, toParams, fromState, fromParams, error) ->
		$log.error "stateChangeError: #{fromState.name} -> #{toState.name}"
		$log.error error
		event.preventDefault();