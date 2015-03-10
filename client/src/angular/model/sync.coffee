angular
.module 'client'
.factory 'sync', ($log)->
	synchModel=(parent, changed)->
		names = []
		for name in Object.getOwnPropertyNames parent
			continue unless name.indexOf('$') is -1
			names.push(name) if parent[name]?.sync? is true or Array.isArray parent[name]
		return if names.length is 0

		for name in names
			if Array.isArray parent[name]
				for item,index in parent[name]
					synchModel parent[name][index], changed
					parent[name][index] = changed if changed._id is item._id
			else
				synchModel parent[name], changed
				parent[name] = changed if changed._id is parent[name]._id

	service={}
	service.watch = (scope)->
		scope.$on 'model-changed', (event, args)->
			synchModel scope, args.data.item

	return service
