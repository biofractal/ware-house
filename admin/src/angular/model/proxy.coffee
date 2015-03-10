angular
.module 'admin'
.factory 'proxy', ($q, $log, $rootScope, socket, model)->

	$rootScope.$on 'socket:success', (event, payload)->
		listener payload

	$rootScope.$on 'socket:model', (event, payload)->
		$rootScope.$broadcast 'model-changed', payload

	$rootScope.$on 'socket:exception', (event, payload)->
		$log.error payload

	callbacks = {}
	currentId = 0

	getId = ->
		currentId += 1
		if currentId > 10000
			currentId = 0
		currentId

	setSync=(p)->
		p.sync=true
		for name in Object.getOwnPropertyNames p
			if Array.isArray p[name]
				p[name][index] = setSync item for item, index in p[name]
		return p

	listener = (payload) ->
		id = payload.id
		if callbacks.hasOwnProperty(id)
			setSync payload.data
			$rootScope.$apply callbacks[id].resolve payload.data
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
		method = caller.slice start+1, end

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