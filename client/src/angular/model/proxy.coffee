angular
.module 'client'
.factory 'proxy', ($q, $log, $rootScope, socket, model)->

	$rootScope.$on 'socket:success', (ev, res)->
		listener res

	$rootScope.$on 'socket:exception', (ev, res)->
		$log.error res

	callbacks = {}
	currentId = 0

	getId = ->
		currentId += 1
		if currentId > 10000
			currentId = 0
		currentId

	listener = (result) ->
		id = result.id
		if callbacks.hasOwnProperty(id)
			$rootScope.$apply callbacks[id].resolve result.data
			delete callbacks[id]

	sendRequest= (args) =>
		defer = $q.defer()
		id = getId()
		method = getMethod args
		params = getParams args
		callbacks[id] = defer
		socket.emit '*', id:id, method:method, params:params
		defer.promise

	getMethod=(args)->
		caller = args.callee.caller.toString()
		start = caller.indexOf '.'
		end = caller.lastIndexOf '('
		caller.slice start+1, end

	getParams=(args)->
		names = angular.injector.$$annotate args.callee
		params={}
		params[name]=args[index] for name, index in names
		params


	for component in Object.getOwnPropertyNames(model)
		for fn in Object.getOwnPropertyNames(model[component])
			source = model[component][fn].toString()
			source = source.replace('function (', "function #{fn} (").replace '{}', '{return sendRequest(arguments);}'
			eval(source)
			model[component][fn] = eval(fn)

	return model