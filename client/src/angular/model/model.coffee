angular
.module 'client'
.factory 'model', ->
	model={}

	model =

		product:
			getAll:->
			getById:(id)->
		,

		house:
			getAll:->
			getById:(id)->

	return model