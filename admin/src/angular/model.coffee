angular
.module 'admin'
.factory 'model', ->

	model =
		house:
			getAll:->
			getById:(id)->
			update:(item)->

		product:
			update:(item)->

	return model