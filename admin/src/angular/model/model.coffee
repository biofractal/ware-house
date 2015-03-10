angular
.module 'admin'
.factory 'model', ->

	model =
		house:
			getAll:->
			getById:(id)->
			update:(id, client, products)->

	return model