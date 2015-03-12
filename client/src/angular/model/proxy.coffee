angular
.module 'client'
.factory 'proxy', ($q, $log, $rootScope, socket, model)->

	$rootScope.$on 'socket:success', (event, payload)->
		console.log 'socket:success', payload
		listener payload

	$rootScope.$on 'socket:model', (event, payload)->
		console.log 'socket:model', payload
		$rootScope.$broadcast 'model-changed', setSync payload

	$rootScope.$on 'socket:exception', (event, payload)->
		handleSocketError event, payload

	callbacks = {}
	currentId = 0

	handleSocketError=(event, payload)->
		$log.error payload

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
			else if p[name] is Object(p[name])
				 setSync p[name]
		return p

	listener = (payload) ->
		id = payload.id
		if callbacks.hasOwnProperty(id)
			setSync payload.data
			$rootScope.$apply callbacks[id].resolve payload.data
			delete callbacks[id]

	sendRequest= (method, args) =>
		defer = $q.defer()
		id = getId()
		params = getParams args
		callbacks[id] = defer
		socket.emit '*', id:id, socketId:$rootScope.socketId, method:method, params:params
		defer.promise

	getParams=(args)->
		names = angular.injector.$$annotate args.callee
		params={}
		params[name]=args[index] for name, index in names
		params

	for component in Object.getOwnPropertyNames(model)
		for fn in Object.getOwnPropertyNames(model[component])
			method= "#{component}.#{fn}"
			source = model[component][fn].toString()
			source = source.replace('function (', "function #{fn} (").replace '{}', "{return sendRequest('#{method}', arguments);}"
			eval(source)
			model[component][fn] = eval(fn)

	return model