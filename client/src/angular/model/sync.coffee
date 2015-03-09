angular
.module 'client'
.factory 'sync', ($log)->
	service={}
	service.watch = (scope)->
		names = []
		names.push name if scope[name]?.sync for name in Object.getOwnPropertyNames scope
		return if names.length is 0

		scope.$on 'model-changed', (event, args)->
			changed = args.data.item
			$log.info name
			for name in names
				if Array.isArray scope[name]
					for item,index in scope[name]
						scope[name][index] = changed if changed._id is item._id
				else
					scope[name] = changed if changed._id is scope[name]._id

	return service
